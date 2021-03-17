From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: EHF + OPTEE on ARM64
Date: Wed, 17 Mar 2021 09:16:32 +0100
Message-ID: 
 <CAHUa44G0EuZ8Y-UoSJsoe-HUC6FfOpH=237CojqEroTBV2auCg@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3CDB6PR0402MB2760BCA1305CF51F1AB222FA886A9=40DB6PR04?=
 =?utf-8?q?02MB2760=2Eeurprd04=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6084883962756637812=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6084883962756637812==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 17, 2021 at 9:02 AM Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: Re: EHF + OPTEE on ARM64
> >
> > On Wed, Mar 17, 2021 at 8:41 AM Peng Fan <peng.fan@nxp.com> wrote:
> > >
> > > > Subject: Re: EHF + OPTEE on ARM64
> > > >
> > > > On Tue, Mar 16, 2021 at 11:08 AM Peng Fan <peng.fan@nxp.com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > In bl31/ehf.c, there are following two lines, per my
> > > > > understanding, when cpu is in secure world, the non-secure
> > > > > interrupt as FIQ(GICv3) will be directly catched by EL3, not S-EL1
> > > > >         /* Route EL3 interrupts when in Secure and Non-secure. */
> > > > >         set_interrupt_rm_flag(flags, NON_SECURE);
> > > > >         set_interrupt_rm_flag(flags, SECURE);
> > > > >
> > > > > So this will conflict with OP-TEE, because OP-TEE needs catch
> > > > > NS-interrupt as FIQ in S-EL1 world.
> > > >
> > > > In the case of GICv3, OP-TEE is configured to receive the non-secure
> > > > interrupts as FIQ and secure interrupts as IRQ. See CFG_ARM_GICV3.
> > >
> > > But EHF needs NS-interrupt FIQ be catched by EL3 if I understand
> > > correct, per " set_interrupt_rm_flag(flags, SECURE);"
> > >
> > > So currently EHF could not work together with OP-TEE, right?
> >
> > To be honest, I'm not completely sure what EHF does. From OP-TEE point of
> > view we expect to receive the non-secure interrupts as a way of doing a
> > controlled exit. This allows OP-TEE to resume execution with a different =
core
> > on re-entry. If EL3 takes the non-secure interrupts directly it will have=
 to
> > make sure to only re-enter OP-TEE on this core as a return from exception.
>
> Is this easy to be achieved?

I don't know, it depends on what you intend to do with this non-secure
interrupt. If it's handled at EL3 and then there's a return from
exception back to S-EL1 there's likely no harm done. But if there's a
world switch involved there might be trouble, OP-TEE might not be in a
suitable state for a world switch.

>
> Or by using opteed_sel1_interrupt_handler, could we have similar behavior
> to allow the other core resume execution?

Only OP-TEE itself can make a controlled exit as there's an internal
state to maintain. Currently that's signalled with a non-secure
interrupt.

Cheers,
Jens

--===============6084883962756637812==--

