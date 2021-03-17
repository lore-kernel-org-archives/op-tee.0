From: Peng Fan <peng.fan@nxp.com>
To: op-tee@lists.trustedfirmware.org
Subject: RE: EHF + OPTEE on ARM64
Date: Wed, 17 Mar 2021 08:02:07 +0000
Message-ID: <DB6PR0402MB2760BCA1305CF51F1AB222FA886A9@DB6PR0402MB2760.eurprd04.prod.outlook.com>
In-Reply-To: <
 <CAHUa44FAKfGRz8EAAoqzGs7FRqJbWusM5DdFKW1fwXmcK4EewA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1003614685121521990=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1003614685121521990==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

> Subject: Re: EHF + OPTEE on ARM64
>=20
> On Wed, Mar 17, 2021 at 8:41 AM Peng Fan <peng.fan@nxp.com> wrote:
> >
> > > Subject: Re: EHF + OPTEE on ARM64
> > >
> > > On Tue, Mar 16, 2021 at 11:08 AM Peng Fan <peng.fan@nxp.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > In bl31/ehf.c, there are following two lines, per my
> > > > understanding, when cpu is in secure world, the non-secure
> > > > interrupt as FIQ(GICv3) will be directly catched by EL3, not S-EL1
> > > >         /* Route EL3 interrupts when in Secure and Non-secure. */
> > > >         set_interrupt_rm_flag(flags, NON_SECURE);
> > > >         set_interrupt_rm_flag(flags, SECURE);
> > > >
> > > > So this will conflict with OP-TEE, because OP-TEE needs catch
> > > > NS-interrupt as FIQ in S-EL1 world.
> > >
> > > In the case of GICv3, OP-TEE is configured to receive the non-secure
> > > interrupts as FIQ and secure interrupts as IRQ. See CFG_ARM_GICV3.
> >
> > But EHF needs NS-interrupt FIQ be catched by EL3 if I understand
> > correct, per " set_interrupt_rm_flag(flags, SECURE);"
> >
> > So currently EHF could not work together with OP-TEE, right?
>=20
> To be honest, I'm not completely sure what EHF does. From OP-TEE point of
> view we expect to receive the non-secure interrupts as a way of doing a
> controlled exit. This allows OP-TEE to resume execution with a different co=
re
> on re-entry. If EL3 takes the non-secure interrupts directly it will have to
> make sure to only re-enter OP-TEE on this core as a return from exception.

Is this easy to be achieved?=20

Or by using opteed_sel1_interrupt_handler, could we have similar behavior
to allow the other core resume execution?

Thanks,
Peng.

>=20
> Cheers,
> Jens

--===============1003614685121521990==--

