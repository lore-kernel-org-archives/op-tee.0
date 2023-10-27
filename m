From: Olivier Deprez <Olivier.Deprez@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Secure interrupt while sending direct response
Date: Fri, 27 Oct 2023 15:42:31 +0000
Message-ID: <PAXPR08MB6799750F21F9CADC1EF2941F9BDCA@PAXPR08MB6799.eurprd08.prod.outlook.com>
In-Reply-To: <
 <CAHUa44HXfyROi7Z9ZcKLX5=E-i7jXq9Sr=Kt3NSK29kaHSUy+w@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0634108695429046607=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0634108695429046607==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,

See below [OD]

Regards,
Olivier.


________________________________________
From: Jens Wiklander <jens.wiklander@linaro.org>
Sent: 23 October 2023 11:35
To: Olivier Deprez
Cc: hafnium(a)lists.trustedfirmware.org; OP-TEE TrustedFirmware; Marc Bonnici
Subject: Re: Secure interrupt while sending direct response

Hi Olivier,

Comments below.

On Fri, Oct 20, 2023 at 5:59=E2=80=AFPM Olivier Deprez <Olivier.Deprez@arm.=
com> wrote:
>
> Hi Jens,
>
> See answers below [OD].
>
> Regards,
> Olivier.
>
>
> ________________________________________
> From: Jens Wiklander <jens.wiklander@linaro.org>
> Sent: 20 October 2023 15:49
> To: Olivier Deprez
> Cc: hafnium(a)lists.trustedfirmware.org; OP-TEE TrustedFirmware; Marc Bonni=
ci
> Subject: Re: Secure interrupt while sending direct response
>
> Hi Olivier,
>
> On Fri, Oct 20, 2023 at 3:10=E2=80=AFPM Olivier Deprez <Olivier.Deprez@ar=
m.com> wrote:
> >
> > Hi Jens,
> >
> > Yes this is an impdef solution for the case where the TEE exits while PST=
ATE.I/F=3D1 and there's still a virtual interrupt pending.
> > In this case the SPMC resumes the vCPU with the error code you mention be=
cause otherwise, the PE would return to the normal world while a virtual inte=
rrupt is still pending for the TEE with no way for the normal world to know i=
t and give back cycles to the TEE..
>
> This impdef solution currently results in an infinite loop since
> OP-TEE responds with FFA_ERROR to an unexpected fid.
>
> Another option would be to return with FFA_INTERRUPT as I guess secure
> interrupts normally are delivered if the SP isn't active.
>
> [OD] I read again comments from this thread which discusses this concern:
> https://review.trustedfirmware.org/c/hafnium/hafnium/+/13401/2..15/src/api.=
c#b2212
> Actually the conclusion was it is permitted for FFA_MSG_SEND_DIRECT_RESP to=
 complete with FFA_ERROR (but not FFA_INTERRUPT) per FF-A v1.2 ALP0 section 1=
6.3.
> I agree though the impdef deviation is that FFA_ERROR(-5) is not listed in =
Table 16.12.

This deviation is an ABI breakage (at least in FF-A 1.1) as an
uninformed SP wouldn't know what to do with that error.

FFA_INTERRUPT is a valid re-entry value, provided that the ongoing
FFA_MSG_SEND_DIRECT_RESP is suspended by the SPMC only to be resumed
with the matching FFA_MSG_WAIT.

By returning FFA_ERROR(FFA_INTERRUPTED) from FFA_MSG_SEND_DIRECT_RESP
you introduce a third way of signaling a secure interrupt to an SP.

[OD] Agree with the above. At the time, this was the guidance from arch team,=
 or at least we were advised not to use FFA_INTERRUPT. But the exact reasons =
have become a bit blurry. I re-opened the case with arch team, and we're curr=
ently checking if it's worth revisiting the interrupt handling chapter to cov=
er this case.


>
> >
> > In the notifications prototype I shared earlier, the interrupt is explici=
tly masked in the GIC for the top half handling:
> > https://github.com/odeprez/optee_os/commit/c2c401c16627caaf0291857f5a3113=
4a9d42c823#diff-5b10343fdf0b05e98f4c097d5df2823430d47090fc5531e8cd57f473777ed=
12eR111
> >
> > In which case this situation cannot happen because an interrupt cannot be=
 raised again up until the bottom half handling has completed:
> > https://github.com/odeprez/optee_os/commit/c2c401c16627caaf0291857f5a3113=
4a9d42c823#diff-5b10343fdf0b05e98f4c097d5df2823430d47090fc5531e8cd57f473777ed=
12eR142
>
> That's what I'm using except that I removed the
> itr_enable()/itr_disable() since I assumed that masking/unmasking
> should be enough.
>
> [OD] I think itr_enable/itr_disable is also required to disable the virtual=
 interrupt delivery on the running vCPU.

I believe that with the para-virtualized HVC interface, there's no
need to make a distinction between masking/unmasking or
disabling/enabling an interrupt ID.

From OP-TEE's point of view, we expect the same of both operations,
when disabled/masked an interrupt ID should not trigger a secure
interrupt on any CPU any longer. When an interrupt ID is
re-enabled/unmasked it should be able to trigger secure interrupts
again. With this in mind, I'd like to figure out how to enable and
disable an interrupt ID. Is the following correct or should something
be added or removed?

void enable_itr(unsigned int it)
{
    HVC(HF_INTERRUPT_ENABLE, it, HF_ENABLE, HF_INTERRUPT_TYPE_IRQ);
    HVC(HF_INTERRUPT_RECONFIGURE, it, HF_INT_RECONFIGURE_STATUS, HF_ENABLE);
}

void disable_itr(unsigned int it)
{
    HVC(HF_INTERRUPT_RECONFIGURE, it, HF_INT_RECONFIGURE_STATUS, HF_DISABLE);
    HVC(HF_INTERRUPT_ENABLE, it, HF_DISABLE, HF_INTERRUPT_TYPE_IRQ);
}

[OD] Hafnium now has two interfaces wrt enabling/disabling an interrupt.
HF_INTERRUPT_ENABLE, enables/disables the delivery of a virtual interrupt on =
the current vCPU only (at the vCPU virtual interrupt controller).
HF_INTERRUPT_RECONFIGURE(HF_INT_RECONFIGURE_STATUS), enables/disables a physi=
cal interrupt globally (at the physical/GICD).
The latter has been introduced recently for a partner's specific use case, an=
d I hoped you'd not want to rely on it.
Anyways from OP-TEE perspective, if really needed to disable a physical inter=
rupt, I believe you could omit calls to HF_INTERRUPT_ENABLE from the runtime =
and only keep HF_INTERRUPT_RECONFIGURE. You would still need to call HF_INTER=
RUPT_ENABLE once at boot time, on each vCPU to permit delivery of the virtual=
 interrupt to the caller vCPU.


>
> In this case, I strongly suspect that we're actually processing a TA
> while this happens (with the interrupt unmasked). I can try to narrow
> it down further if you think that helps.
>
> [OD] If my understanding is correct it would happen as such:
> -a TA runs then a secure interrupt happens
> -It traps first to Hafnium, then Hafnium injects a virtual interrupt to OP-=
TEE and resumes it.
> -OP-TEE proceeds with the secure interrupt (top half handling) and asserts =
a notification towards normal world, a NS interrupt (SGI8) is now pending
> -the TA is resumed and the NS interrupt traps to Hafnium which initiates a =
managed exit operation
> -OP-TEE is resumed, traps vFIQ and returns with a direct resp.
> -a (secure) virtual interrupt is pending , Hafnium resumes OP-TEE again wit=
h FFA_ERROR(-5)
>
> As to why an interrupt is pending at last step, that may be because the int=
errupt did not get disabled prior to returning to normal world?

To simplify diagnosing this I've removed the notifications from the
equation. So all the interrupt processing is completed in the top half
handing, that is, reading from the UART. No FF-A notifications and no
masking/unmasking or enabling/disabling of the secure interrupt, it's
always enabled. Even in this setup, I can provoke an
FFA_ERROR(FFA_INTERRUPTED) from FFA_MSG_SEND_DIRECT_RESP. I'm running
a test case with frequent entry and exit=20

[OD] just curious is this using some timer? in other words not relying on the=
 uart interrupt for this case?

to and from the secure world
so I believe that what's happening is the following:

1. Entry with FFA_MSG_SEND_DIRECT_RESP
2. Handling a yielding request, including possible TA execution
3. Start preparing exit, mask interrupts and save state
4. Exit with FFA_MSG_SEND_DIRECT_RESP using smc #0

When we get FFA_ERROR(FFA_INTERRUPTED) from FFA_MSG_SEND_DIRECT_RESP a
secure interrupt has been pended between steps 3 and 4, but since
we're on the exit path interrupts are masked.

I've tried to temporarily unmask secure interrupts during the SMC as:
msr   daifclr, #DAIFBIT_IRQ
smc     #0
msr   daifset, #DAIFBIT_IRQ

With this, I can't provoke FFA_ERROR(FFA_INTERRUPTED) from
FFA_MSG_SEND_DIRECT_RESP any longer.

[OD] Yes I think this is matching arch team's initial earlier recommendations=
, but I had mixed feeling in that it imposes a specific programming model to =
the TEE (actually a diverging pattern from the non-virtualized case)

So if we can be guaranteed that FFA_MSG_SEND_DIRECT_RESP never will
return FFA_ERROR(FFA_INTERRUPTED) if secure interrupts are unmasked
during the call we've fixed the problem in OP-TEE.

I'm not very keen on implementing support for restarting a failed
FFA_MSG_SEND_DIRECT_RESP, especially not if it's not part of an
official specification, so if doing the SMC with secure interrupts
unmasked is enough we'll settle with that.

[OD] Ok good to know, I didn't realise that may be acceptable at your end. So=
 I may revisit my arguments with arch team.

Cheers,
Jens

>
>
>
> Cheers,
> Jens
>
> >
> > Regards,
> > Olivier.
> >
> >
> > ________________________________________
> > From: Jens Wiklander <jens.wiklander@linaro.org>
> > Sent: 20 October 2023 14:46
> > To: Olivier Deprez; hafnium(a)lists.trustedfirmware.org
> > Cc: OP-TEE TrustedFirmware; Marc Bonnici
> > Subject: Secure interrupt while sending direct response
> >
> > Hi all,
> >
> > I'm testing FF-A notifications with OP-TEE and Hafnium. I'm using
> > interrupts from the secure uart as a trigger to set a notification for
> > the normal world. Sometimes when testing I run into:
> > VERBOSE: Secure virtual interrupt not yet serviced by SP 8001.
> > FFA_MSG_SEND_DIRECT_RESP interrupted
> >
> > Hafnium then returns an FFA_ERROR (code -5) as a response to the
> > FFA_MSG_SEND_DIRECT_RESP OP-TEE was just exiting with. After some
> > digging in the code I find a comment at the top of
> > plat_ffa_is_direct_response_interrupted()
> > https://git.trustedfirmware.org/hafnium/hafnium.git/tree/src/arch/aarch64=
/plat/ffa/spmc.c#n2539
> >
> > /*
> > * A secure interrupt might trigger while the target SP is currently
> > * running to send a direct response. SPMC would then inject virtual
> > * interrupt to vCPU of target SP and resume it.
> > * However, it is possible that the S-EL1 SP could have its interrupts
> > * masked and hence might not handle the virtual interrupt before
> > * sending direct response message. In such a scenario, SPMC must
> > * return an error with code FFA_INTERRUPTED to inform the S-EL1 SP of
> > * a pending interrupt and allow it to be handled before sending the
> > * direct response.
> > */
> >
> > The specification doesn't mention this as a valid error code for
> > FFA_MSG_SEND_DIRECT_RESP. Is this something we can expect to be added
> > to the specification or at least something OP-TEE has to be prepared
> > to handle regardless?
> >
> > As far as I can tell there's no way of guaranteeing that Hafnium will
> > not return this error for FFA_MSG_SEND_DIRECT_RESP. Even if we were
> > able to execute the smc instruction with secure interrupts unmasked,
> > what if the interrupt is raised just after the smc instruction has
> > been trapped in Hafnium?
> > It is a bit inconvenient as it means saving the registers passed to
> > the smc instruction to be able to restart the smc instruction with the
> > same arguments. It seems we may need to redesign the exit procedure.
> > It would be nice with an example of how an S-EL1 SP is supposed to
> > exit with FFA_MSG_SEND_DIRECT_RESP.
> >
> > Thoughts?
> >
> > Thanks,
> > Jens

--===============0634108695429046607==--

