From: Olivier Deprez <Olivier.Deprez@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Secure interrupt while sending direct response
Date: Fri, 20 Oct 2023 15:59:18 +0000
Message-ID: <DB9PR08MB6796906D34A89179DE0AF0E49BDBA@DB9PR08MB6796.eurprd08.prod.outlook.com>
In-Reply-To: <
 <CAHUa44GgPGR2A7J8qfG-n8XxQ-bAuAAm_nk==5JbjG3EMXvPZg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3570141124335459923=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3570141124335459923==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,

See answers below [OD].

Regards,
Olivier.


________________________________________
From: Jens Wiklander <jens.wiklander@linaro.org>
Sent: 20 October 2023 15:49
To: Olivier Deprez
Cc: hafnium(a)lists.trustedfirmware.org; OP-TEE TrustedFirmware; Marc Bonnici
Subject: Re: Secure interrupt while sending direct response

Hi Olivier,

On Fri, Oct 20, 2023 at 3:10=E2=80=AFPM Olivier Deprez <Olivier.Deprez@arm.=
com> wrote:
>
> Hi Jens,
>
> Yes this is an impdef solution for the case where the TEE exits while PSTAT=
E.I/F=3D1 and there's still a virtual interrupt pending.
> In this case the SPMC resumes the vCPU with the error code you mention beca=
use otherwise, the PE would return to the normal world while a virtual interr=
upt is still pending for the TEE with no way for the normal world to know it =
and give back cycles to the TEE..

This impdef solution currently results in an infinite loop since
OP-TEE responds with FFA_ERROR to an unexpected fid.

Another option would be to return with FFA_INTERRUPT as I guess secure
interrupts normally are delivered if the SP isn't active.

[OD] I read again comments from this thread which discusses this concern:
https://review.trustedfirmware.org/c/hafnium/hafnium/+/13401/2..15/src/api.c#=
b2212
Actually the conclusion was it is permitted for FFA_MSG_SEND_DIRECT_RESP to c=
omplete with FFA_ERROR (but not FFA_INTERRUPT) per FF-A v1.2 ALP0 section 16.=
3.
I agree though the impdef deviation is that FFA_ERROR(-5) is not listed in Ta=
ble 16.12.

>
> In the notifications prototype I shared earlier, the interrupt is explicitl=
y masked in the GIC for the top half handling:
> https://github.com/odeprez/optee_os/commit/c2c401c16627caaf0291857f5a31134a=
9d42c823#diff-5b10343fdf0b05e98f4c097d5df2823430d47090fc5531e8cd57f473777ed12=
eR111
>
> In which case this situation cannot happen because an interrupt cannot be r=
aised again up until the bottom half handling has completed:
> https://github.com/odeprez/optee_os/commit/c2c401c16627caaf0291857f5a31134a=
9d42c823#diff-5b10343fdf0b05e98f4c097d5df2823430d47090fc5531e8cd57f473777ed12=
eR142

That's what I'm using except that I removed the
itr_enable()/itr_disable() since I assumed that masking/unmasking
should be enough.

[OD] I think itr_enable/itr_disable is also required to disable the virtual i=
nterrupt delivery on the running vCPU.

In this case, I strongly suspect that we're actually processing a TA
while this happens (with the interrupt unmasked). I can try to narrow
it down further if you think that helps.

[OD] If my understanding is correct it would happen as such:
-a TA runs then a secure interrupt happens
-It traps first to Hafnium, then Hafnium injects a virtual interrupt to OP-TE=
E and resumes it.
-OP-TEE proceeds with the secure interrupt (top half handling) and asserts a =
notification towards normal world, a NS interrupt (SGI8) is now pending
-the TA is resumed and the NS interrupt traps to Hafnium which initiates a ma=
naged exit operation
-OP-TEE is resumed, traps vFIQ and returns with a direct resp.
-a (secure) virtual interrupt is pending , Hafnium resumes OP-TEE again with =
FFA_ERROR(-5)

As to why an interrupt is pending at last step, that may be because the inter=
rupt did not get disabled prior to returning to normal world?



Cheers,
Jens

>
> Regards,
> Olivier.
>
>
> ________________________________________
> From: Jens Wiklander <jens.wiklander@linaro.org>
> Sent: 20 October 2023 14:46
> To: Olivier Deprez; hafnium(a)lists.trustedfirmware.org
> Cc: OP-TEE TrustedFirmware; Marc Bonnici
> Subject: Secure interrupt while sending direct response
>
> Hi all,
>
> I'm testing FF-A notifications with OP-TEE and Hafnium. I'm using
> interrupts from the secure uart as a trigger to set a notification for
> the normal world. Sometimes when testing I run into:
> VERBOSE: Secure virtual interrupt not yet serviced by SP 8001.
> FFA_MSG_SEND_DIRECT_RESP interrupted
>
> Hafnium then returns an FFA_ERROR (code -5) as a response to the
> FFA_MSG_SEND_DIRECT_RESP OP-TEE was just exiting with. After some
> digging in the code I find a comment at the top of
> plat_ffa_is_direct_response_interrupted()
> https://git.trustedfirmware.org/hafnium/hafnium.git/tree/src/arch/aarch64/p=
lat/ffa/spmc.c#n2539
>
> /*
> * A secure interrupt might trigger while the target SP is currently
> * running to send a direct response. SPMC would then inject virtual
> * interrupt to vCPU of target SP and resume it.
> * However, it is possible that the S-EL1 SP could have its interrupts
> * masked and hence might not handle the virtual interrupt before
> * sending direct response message. In such a scenario, SPMC must
> * return an error with code FFA_INTERRUPTED to inform the S-EL1 SP of
> * a pending interrupt and allow it to be handled before sending the
> * direct response.
> */
>
> The specification doesn't mention this as a valid error code for
> FFA_MSG_SEND_DIRECT_RESP. Is this something we can expect to be added
> to the specification or at least something OP-TEE has to be prepared
> to handle regardless?
>
> As far as I can tell there's no way of guaranteeing that Hafnium will
> not return this error for FFA_MSG_SEND_DIRECT_RESP. Even if we were
> able to execute the smc instruction with secure interrupts unmasked,
> what if the interrupt is raised just after the smc instruction has
> been trapped in Hafnium?
> It is a bit inconvenient as it means saving the registers passed to
> the smc instruction to be able to restart the smc instruction with the
> same arguments. It seems we may need to redesign the exit procedure.
> It would be nice with an example of how an S-EL1 SP is supposed to
> exit with FFA_MSG_SEND_DIRECT_RESP.
>
> Thoughts?
>
> Thanks,
> Jens

--===============3570141124335459923==--

