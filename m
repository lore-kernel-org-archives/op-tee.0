From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: EHF + OPTEE on ARM64
Date: Wed, 17 Mar 2021 10:23:12 +0100
Message-ID: 
 <CAHUa44G8gY2rpLtOA3M80+TFYrJru7CvwbFm6niS+vjdMYxKCw@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3CDB6PR0402MB2760C9070B6DBA9907249ACB886A9=40DB6PR04?=
 =?utf-8?q?02MB2760=2Eeurprd04=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7317044861479643743=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7317044861479643743==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 17, 2021 at 9:43 AM Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: Re: EHF + OPTEE on ARM64
> >
> > On Wed, Mar 17, 2021 at 9:02 AM Peng Fan <peng.fan@nxp.com> wrote:
> > >
> > > > Subject: Re: EHF + OPTEE on ARM64
> > > >
> > > > On Wed, Mar 17, 2021 at 8:41 AM Peng Fan <peng.fan@nxp.com> wrote:
> > > > >
> > > > > > Subject: Re: EHF + OPTEE on ARM64
> > > > > >
> > > > > > On Tue, Mar 16, 2021 at 11:08 AM Peng Fan <peng.fan@nxp.com>
> > wrote:
> > > > > > >
> > > > > > > Hi,
> > > > > > >
> > > > > > > In bl31/ehf.c, there are following two lines, per my
> > > > > > > understanding, when cpu is in secure world, the non-secure
> > > > > > > interrupt as FIQ(GICv3) will be directly catched by EL3, not S-=
EL1
> > > > > > >         /* Route EL3 interrupts when in Secure and Non-secure.
> > */
> > > > > > >         set_interrupt_rm_flag(flags, NON_SECURE);
> > > > > > >         set_interrupt_rm_flag(flags, SECURE);
> > > > > > >
> > > > > > > So this will conflict with OP-TEE, because OP-TEE needs catch
> > > > > > > NS-interrupt as FIQ in S-EL1 world.
> > > > > >
> > > > > > In the case of GICv3, OP-TEE is configured to receive the
> > > > > > non-secure interrupts as FIQ and secure interrupts as IRQ. See
> > CFG_ARM_GICV3.
> > > > >
> > > > > But EHF needs NS-interrupt FIQ be catched by EL3 if I understand
> > > > > correct, per " set_interrupt_rm_flag(flags, SECURE);"
> > > > >
> > > > > So currently EHF could not work together with OP-TEE, right?
> > > >
> > > > To be honest, I'm not completely sure what EHF does. From OP-TEE
> > > > point of view we expect to receive the non-secure interrupts as a
> > > > way of doing a controlled exit. This allows OP-TEE to resume
> > > > execution with a different core on re-entry. If EL3 takes the
> > > > non-secure interrupts directly it will have to make sure to only re-e=
nter
> > OP-TEE on this core as a return from exception.
> > >
> > > Is this easy to be achieved?
> >
> > I don't know, it depends on what you intend to do with this non-secure
> > interrupt. If it's handled at EL3 and then there's a return from exceptio=
n back
> > to S-EL1 there's likely no harm done. But if there's a world switch invol=
ved
> > there might be trouble, OP-TEE might not be in a suitable state for a wor=
ld
> > switch.
> >
> > >
> > > Or by using opteed_sel1_interrupt_handler, could we have similar
> > > behavior to allow the other core resume execution?
> >
> > Only OP-TEE itself can make a controlled exit as there's an internal stat=
e to
> > maintain. Currently that's signalled with a non-secure interrupt.
>
>
> Per EHF, https://trustedfirmware-a.readthedocs.io/en/latest/components/exce=
ption-handling.html?highlight=3DException%20Handling%20Framework
> On GICv3 systems, when executing in S-EL1, pending Non-secure interrupts of
> sufficient priority are signalled as FIQs, and therefore will be routed to =
EL3.
> As a result, S-EL1 software cannot expect to handle Non-secure interrupts a=
t S-EL1.
> Essentially, this deprecates the routing mode described as CSS=3D0, TEL3=3D=
0.
>
> In order for S-EL1 software to handle Non-secure interrupts while having EH=
F enabled,
> the dispatcher must adopt a model where Non-secure interrupts are received =
at EL3,
> but are then synchronously handled over to S-EL1.
>
> The issue to me here how to synchronously handled over to S-EL1 and not bre=
ak optee.

I understand. OP-TEE is masking interrupts in some critical sections,
while in such a state OP-TEE cannot handle any asynchronous interrupt.
Temporarily masking interrupts is normally a quick operation so we do
it in quite a few places.
So the crux of the problem is to make sure that OP-TEE is in a state
where it can make a controlled exit. I don't have any good ideas for
this right now.

Cheers,
Jens

--===============7317044861479643743==--

