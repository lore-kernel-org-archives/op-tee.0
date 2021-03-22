From: Sandeep Tripathy <sandeep.tripathy@broadcom.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [TF-A] EHF + OPTEE on ARM64
Date: Mon, 22 Mar 2021 20:41:40 +0530
Message-ID: 
 <CALf0XcyVL8hmbVD_481Eiui55JymAXWymHMnabWW8SuZfsd2vA@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3C010001785935935d-4467c71b-2436-490d-b8a5-486cf0a25?=
 =?utf-8?q?243-000000=40email=2Eamazonses=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6600580199349486584=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6600580199349486584==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Peng,

1-Asynchronous preemption of SP:
The long route is to make changes in the dispatcher and the
corresponding SPD implementation to have synchronous preemption.
ie: OP-TEE dispatcher will implement a G1NS (fiq) handler and invoke
an entry of OP-TEE synchronously. OP-TEE will save the thread context
and return.
I did some POC but the complexity and effort to generalise was not
justified by our requirement at that point especially envisioning the
movement to SPMD in future.

2-Synchronous preemption of SP:
ref:
https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/6345

I used this approach instead to unblock OP-TEE work alongside EHF.
This serves the purpose without changing the routing model with a
limitation that non yielding/fast SMC can
not be preempted. And ofcourse OP-TEE can mask G0 interrupt in
anycase. But I think this is sufficient for your purpose.

Please feedback if the above patch works for you.

Thanks
Sandeep

On Mon, Mar 22, 2021 at 2:43 PM Peng Fan via TF-A
<tf-a@lists.trustedfirmware.org> wrote:
>
> Hi Achin,
>
>
>
> We are using SDEI for Jailhouse hypervisor to minimize interrupt latency, h=
owever we also wanna use OP-TEE when SDEI enabled.
>
>
>
> So I wanna how to make both work together.
>
>
>
> Thanks,
>
> Peng.
>
>
>
> From: Achin Gupta [mailto:Achin.Gupta(a)arm.com]
> Sent: 2021=E5=B9=B43=E6=9C=8817=E6=97=A5 17:59
> To: Peng Fan <peng.fan@nxp.com>; Jens Wiklander <jens.wiklander@linaro.=
org>
> Cc: op-tee(a)lists.trustedfirmware.org; tf-a(a)lists.trustedfirmware.org
> Subject: Re: EHF + OPTEE on ARM64
>
>
>
> Hi Peng,
>
>
>
> +TF-A folk.
>
>
>
> My 0.02$.
>
>
>
> What is the problem you are trying to solve? Why do you need to run OP-TEE =
and EHF together? EHF was originally written to support a S-EL0 SP that is ma=
naged directly by TF-A in EL3 (TF-A folk can chime in).
>
>
>
> The SP could perform RAS error handling for which it needs the EHF. The EHF=
 triages asynchronous exceptions and hands RAS errors to the SP for further h=
andling.
>
>
>
> This is just one use case but there is no Trusted OS in these configuration=
s.
>
>
>
> So, it would help to understand the requirement.
>
>
>
> cheers,
>
> Achin
>
>
>
> ________________________________
>
> From: OP-TEE <op-tee-bounces@lists.trustedfirmware.org> on behalf of Jens=
 Wiklander via OP-TEE <op-tee@lists.trustedfirmware.org>
> Sent: 17 March 2021 09:23
> To: Peng Fan <peng.fan@nxp.com>
> Cc: op-tee(a)lists.trustedfirmware.org <op-tee@lists.trustedfirmware.org>
> Subject: Re: EHF + OPTEE on ARM64
>
>
>
> On Wed, Mar 17, 2021 at 9:43 AM Peng Fan <peng.fan@nxp.com> wrote:
> >
> > > Subject: Re: EHF + OPTEE on ARM64
> > >
> > > On Wed, Mar 17, 2021 at 9:02 AM Peng Fan <peng.fan@nxp.com> wrote:
> > > >
> > > > > Subject: Re: EHF + OPTEE on ARM64
> > > > >
> > > > > On Wed, Mar 17, 2021 at 8:41 AM Peng Fan <peng.fan@nxp.com> wrote:
> > > > > >
> > > > > > > Subject: Re: EHF + OPTEE on ARM64
> > > > > > >
> > > > > > > On Tue, Mar 16, 2021 at 11:08 AM Peng Fan <peng.fan@nxp.com>
> > > wrote:
> > > > > > > >
> > > > > > > > Hi,
> > > > > > > >
> > > > > > > > In bl31/ehf.c, there are following two lines, per my
> > > > > > > > understanding, when cpu is in secure world, the non-secure
> > > > > > > > interrupt as FIQ(GICv3) will be directly catched by EL3, not =
S-EL1
> > > > > > > >         /* Route EL3 interrupts when in Secure and Non-secure.
> > > */
> > > > > > > >         set_interrupt_rm_flag(flags, NON_SECURE);
> > > > > > > >         set_interrupt_rm_flag(flags, SECURE);
> > > > > > > >
> > > > > > > > So this will conflict with OP-TEE, because OP-TEE needs catch
> > > > > > > > NS-interrupt as FIQ in S-EL1 world.
> > > > > > >
> > > > > > > In the case of GICv3, OP-TEE is configured to receive the
> > > > > > > non-secure interrupts as FIQ and secure interrupts as IRQ. See
> > > CFG_ARM_GICV3.
> > > > > >
> > > > > > But EHF needs NS-interrupt FIQ be catched by EL3 if I understand
> > > > > > correct, per " set_interrupt_rm_flag(flags, SECURE);"
> > > > > >
> > > > > > So currently EHF could not work together with OP-TEE, right?
> > > > >
> > > > > To be honest, I'm not completely sure what EHF does. From OP-TEE
> > > > > point of view we expect to receive the non-secure interrupts as a
> > > > > way of doing a controlled exit. This allows OP-TEE to resume
> > > > > execution with a different core on re-entry. If EL3 takes the
> > > > > non-secure interrupts directly it will have to make sure to only re=
-enter
> > > OP-TEE on this core as a return from exception.
> > > >
> > > > Is this easy to be achieved?
> > >
> > > I don't know, it depends on what you intend to do with this non-secure
> > > interrupt. If it's handled at EL3 and then there's a return from except=
ion back
> > > to S-EL1 there's likely no harm done. But if there's a world switch inv=
olved
> > > there might be trouble, OP-TEE might not be in a suitable state for a w=
orld
> > > switch.
> > >
> > > >
> > > > Or by using opteed_sel1_interrupt_handler, could we have similar
> > > > behavior to allow the other core resume execution?
> > >
> > > Only OP-TEE itself can make a controlled exit as there's an internal st=
ate to
> > > maintain. Currently that's signalled with a non-secure interrupt.
> >
> >
> > Per EHF, https://trustedfirmware-a.readthedocs.io/en/latest/components/ex=
ception-handling.html?highlight=3DException%20Handling%20Framework
> > On GICv3 systems, when executing in S-EL1, pending Non-secure interrupts =
of
> > sufficient priority are signalled as FIQs, and therefore will be routed t=
o EL3.
> > As a result, S-EL1 software cannot expect to handle Non-secure interrupts=
 at S-EL1.
> > Essentially, this deprecates the routing mode described as CSS=3D0, TEL3=
=3D0.
> >
> > In order for S-EL1 software to handle Non-secure interrupts while having =
EHF enabled,
> > the dispatcher must adopt a model where Non-secure interrupts are receive=
d at EL3,
> > but are then synchronously handled over to S-EL1.
> >
> > The issue to me here how to synchronously handled over to S-EL1 and not b=
reak optee.
>
> I understand. OP-TEE is masking interrupts in some critical sections,
> while in such a state OP-TEE cannot handle any asynchronous interrupt.
> Temporarily masking interrupts is normally a quick operation so we do
> it in quite a few places.
> So the crux of the problem is to make sure that OP-TEE is in a state
> where it can make a controlled exit. I don't have any good ideas for
> this right now.
>
> Cheers,
> Jens
>
> --
> TF-A mailing list
> TF-A(a)lists.trustedfirmware.org
> https://lists.trustedfirmware.org/mailman/listinfo/tf-a

--===============6600580199349486584==--

