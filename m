From: Peng Fan <peng.fan@nxp.com>
To: op-tee@lists.trustedfirmware.org
Subject: RE: EHF + OPTEE on ARM64
Date: Mon, 22 Mar 2021 09:11:12 +0000
Message-ID: <DB6PR0402MB2760D253CF4642C13FFCC0CB88659@DB6PR0402MB2760.eurprd04.prod.outlook.com>
In-Reply-To: <=?utf-8?q?=3CDB6PR0801MB186187E5FB2478921413266CFF6A9=40DB6PR08?=
 =?utf-8?q?01MB1861=2Eeurprd08=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4430065945984498254=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4430065945984498254==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Achin,

We are using SDEI for Jailhouse hypervisor to minimize interrupt latency, how=
ever we also wanna use OP-TEE when SDEI enabled.

So I wanna how to make both work together.

Thanks,
Peng.

From: Achin Gupta [mailto:Achin.Gupta(a)arm.com]
Sent: 2021=E5=B9=B43=E6=9C=8817=E6=97=A5 17:59
To: Peng Fan <peng.fan@nxp.com>; Jens Wiklander <jens.wiklander@linaro.or=
g>
Cc: op-tee(a)lists.trustedfirmware.org; tf-a(a)lists.trustedfirmware.org
Subject: Re: EHF + OPTEE on ARM64

Hi Peng,

+TF-A folk.

My 0.02$.

What is the problem you are trying to solve? Why do you need to run OP-TEE an=
d EHF together? EHF was originally written to support a S-EL0 SP that is mana=
ged directly by TF-A in EL3 (TF-A folk can chime in).

The SP could perform RAS error handling for which it needs the EHF. The EHF t=
riages asynchronous exceptions and hands RAS errors to the SP for further han=
dling.

This is just one use case but there is no Trusted OS in these configurations.

So, it would help to understand the requirement.

cheers,
Achin

________________________________
From: OP-TEE <op-tee-bounces(a)lists.trustedfirmware.org<mailto:op-tee-bounce=
s@lists.trustedfirmware.org>> on behalf of Jens Wiklander via OP-TEE <op-te=
e(a)lists.trustedfirmware.org<mailto:op-tee@lists.trustedfirmware.org>>
Sent: 17 March 2021 09:23
To: Peng Fan <peng.fan(a)nxp.com<mailto:peng.fan@nxp.com>>
Cc: op-tee(a)lists.trustedfirmware.org<mailto:op-tee@lists.trustedfirmware.=
org> <op-tee(a)lists.trustedfirmware.org<mailto:op-tee@lists.trustedfirmwar=
e.org>>
Subject: Re: EHF + OPTEE on ARM64

On Wed, Mar 17, 2021 at 9:43 AM Peng Fan <peng.fan@nxp.com<mailto:peng.fan(=
a)nxp.com>> wrote:
>
> > Subject: Re: EHF + OPTEE on ARM64
> >
> > On Wed, Mar 17, 2021 at 9:02 AM Peng Fan <peng.fan(a)nxp.com<mailto:peng.=
fan@nxp.com>> wrote:
> > >
> > > > Subject: Re: EHF + OPTEE on ARM64
> > > >
> > > > On Wed, Mar 17, 2021 at 8:41 AM Peng Fan <peng.fan(a)nxp.com<mailto:p=
eng.fan@nxp.com>> wrote:
> > > > >
> > > > > > Subject: Re: EHF + OPTEE on ARM64
> > > > > >
> > > > > > On Tue, Mar 16, 2021 at 11:08 AM Peng Fan <peng.fan(a)nxp.com<mai=
lto:peng.fan@nxp.com>>
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
ption-handling.html?highlight=3DException%20Handling%20Framework<https://eur0=
1.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Ftrustedfirmware-a.rea=
dthedocs.io%2Fen%2Flatest%2Fcomponents%2Fexception-handling.html%3Fhighlight%=
3DException%2520Handling%2520Framework&data=3D04%7C01%7Cpeng.fan%40nxp.com%7C=
1632994e19aa4b3db22208d8e92b5332%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7=
C637515719585229040%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luM=
zIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&sdata=3D4yUCaoNYp7dsL6I%2BU2nC67%2Br=
MZvhbAjQgarqoWSeF1E%3D&reserved=3D0>
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

--===============4430065945984498254==--

