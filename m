From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 0/4] rpmb subsystem, uapi and virtio-rpmb driver
Date: Mon, 12 Jun 2023 19:06:45 +0200
Message-ID: 
 <CAHUa44F4CRM7zr8EevejPcCiGOjNgg7AtPy20L4h5S68SL9-_g@mail.gmail.com>
In-Reply-To: <
 <CAC_iWjLOhUvp5ggCCkHN5MRNfB_h6FZ2Z14yrtR3aqGn0Ovxig@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3490791151649762057=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3490791151649762057==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On Fri, Jun 2, 2023 at 10:26=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Thu, 1 Jun 2023 at 08:49, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > On Thu, 1 Jun 2023 at 11:02, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Bing
> > >
> > > On Thu, 1 Jun 2023 at 04:03, Zhu, Bing <bing.zhu@intel.com> wrote:
> > > >
> > > > As an alternative, Is it possible to change ftpm design not to depend=
 on RPMB access at the earlier/boot stage? Because to my understanding, typic=
ally PCRs don't require persistent/NV storage (for example, before RPMB or te=
e-supplicant is ready, use TEE memory instead as temporary storage)
> > >
> > > I am not entirely sure this will solve our problem here.  You are
> > > right that we shouldn't depend on the supplicant to extend PCRs. But
> > > what happens if an object is sealed against certain PCR values?  We
> > > are back to the same problem
> >
> > +1
> >
> > Temporary storage may be a stop gap solution for some use-cases but
> > having a fast path access to RPMB via kernel should be our final goal.
> > I would suggest we start small with the MMC subsystem to expose RPMB
> > access APIs for OP-TEE driver rather than a complete RPMB subsystem.
>
> I discussed with the OP-TEE maintainers about adding parts of the
> supplicant in the kernel.  The supplicant 'just' sends an ioctl to
> store/read stuff anyway.  So it would make sense to have a closer and
> see if that looks reasonable.
> Thanks

I was trying to create a setup to test this. I've added the kernel
patches on top of https://github.com/linaro-swg/linux/tree/optee. The
QEMU branch is a bit dated and I had to add
3a845a214b42 target/arm: allow setting SCR_EL3.EnTP2 when FEAT_SME is
implemented
d4a7b0ef1a03 hw/arm/boot: set CPTR_EL3.ESM and SCR_EL3.EnTP2 when
booting Linux with EL3
9745a003f878 hw/intc/arm_gicv3: fix prio masking on pmr write
beeec926d24a target/arm: mark SP_EL1 with ARM_CP_EL3_NO_EL2_KEEP
on top of that branch to be able to boot to the Linux kernel.

I have the vhost-user-rpmb process running and connected with QEMU,
but around (guessing really) when the RPMB subsystem is initializing
the process dies with:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Request: VHOST_USER_SET_VRING_ADDR (9)
Flags:   0x1
Size:    40
vhost-user-rpmb-INFO: 18:58:08.312: vrpmb_process_msg: msg
VHOST_USER_SET_VRING_ADDR(9)
vhost_vring_addr:
    index:  0
    flags:  0
    desc_user_addr:   0x00007ff15fa91000
    used_user_addr:   0x00007ff15fa91080
    avail_user_addr:  0x00007ff15fa91040
    log_guest_addr:   0x0000000041c91080
Setting virtq addresses:
    vring_desc  at (nil)
    vring_used  at (nil)
    vring_avail at (nil)

(vhost-user-rpmb:3236474): vhost-user-rpmb-CRITICAL **: 18:58:08.312:
Invalid vring_addr message

Among other options, I'm starting QEMU with -machine
virt,secure=3Don,mte=3Doff,gic-version=3D3,virtualization=3Dfalse to enable
the secure world.

Do you have an idea of what might be wrong? Where should I start looking?

Thanks,
Jens

>
> /Ilias
>
> >
> > -Sumit
> >
> > >
> > > Thanks
> > > /Ilias
> > > >
> > > > Bing
> > > >
> > > > IPAS Security Brown Belt (https://www.credly.com/badges/69ea809f-3a96=
-4bc7-bb2f-442c1b17af26)
> > > > System Software Engineering
> > > > Software and Advanced Technology Group
> > > > Zizhu Science Park, Shanghai, China
> > > >
> > > > -----Original Message-----
> > > > From: Shyam Saini <shyamsaini@linux.microsoft.com>
> > > > Sent: Thursday, June 1, 2023 3:10 AM
> > > > To: alex.bennee(a)linaro.org
> > > > Cc: code(a)tyhicks.com; Matti.Moell(a)opensynergy.com; arnd(a)linaro.=
org; Zhu, Bing <bing.zhu@intel.com>; hmo(a)opensynergy.com; ilias.apalodima=
s(a)linaro.org; joakim.bech(a)linaro.org; linux-kernel(a)vger.kernel.org; lin=
ux-mmc(a)vger.kernel.org; linux-scsi(a)vger.kernel.org; maxim.uvarov(a)linaro=
.org; ruchika.gupta(a)linaro.org; Winkler, Tomas <tomas.winkler@intel.com>;=
 ulf.hansson(a)linaro.org; Huang, Yang <yang.huang@intel.com>; sumit.garg(a=
)linaro.org; jens.wiklander(a)linaro.org; op-tee(a)lists.trustedfirmware.org
> > > > Subject: [PATCH v2 0/4] rpmb subsystem, uapi and virtio-rpmb driver
> > > >
> > > > Hi Alex,
> > > >
> > > > [ Resending, Sorry for the noise ]
> > > >
> > > > Are you still working on it or planning to resubmit it ?
> > > >
> > > > [1] The current optee tee kernel driver implementation doesn't work w=
hen IMA is used with optee implemented ftpm.
> > > >
> > > > The ftpm has dependency on tee-supplicant which comes once the user s=
pace is up and running and IMA attestation happens at boot time and it requir=
es to extend ftpm PCRs.
> > > >
> > > > But IMA can't use PCRs if ftpm use secure emmc RPMB partition. As opt=
ee can only access RPMB via tee-supplicant(user space). So, there should be a=
 fast path to allow optee os to access the RPMB parititon without waiting for=
 user-space tee supplicant.
> > > >
> > > > To achieve this fast path linux optee driver and mmc driver needs som=
e work and finally it will need RPMB driver which you posted.
> > > >
> > > > Please let me know what's your plan on this.
> > > >
> > > > [1] https://optee.readthedocs.io/en/latest/architecture/secure_storag=
e.html
> > > >
> > > > Best Regards,
> > > > Shyam

--===============3490791151649762057==--

