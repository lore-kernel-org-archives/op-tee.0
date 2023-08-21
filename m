From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [RFC, PATCH 1/1] rpmb: add Replay Protected Memory Block (RPMB) driver
Date: Mon, 21 Aug 2023 17:47:49 +0530
Message-ID: 
 <CAFA6WYMPsBUutjKrm+6qTNHpVr80K2GcSLoYa+MFE3CfLSo8ew@mail.gmail.com>
In-Reply-To: <
 <CAC_iWjKKap47PhiCi=BfPZC_wJhVDB10WSf9oWMgdwSgWCfO_A@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3242040849266682654=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3242040849266682654==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 21 Aug 2023 at 17:26, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Mon, 21 Aug 2023 at 14:19, Jens Wiklander <jens.wiklander@linaro.org> =
wrote:
> >
> > On Mon, Aug 21, 2023 at 12:03=E2=80=AFPM Sumit Garg <sumit.garg@linaro.=
org> wrote:
> > >
> > > On Mon, 21 Aug 2023 at 15:19, Jerome Forissier
> > > <jerome.forissier@linaro.org> wrote:
> > > >
> > > >
> > > >
> > > > On 8/17/23 01:31, Shyam Saini wrote:
> > > > >
> > > > > Hi Ulf,
> > > > >
> > > > >> On Sat, 22 Jul 2023 at 03:41, Shyam Saini
> > > > >> <shyamsaini@linux.microsoft.com> wrote:
> > > > >>>
> > > > >>> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > > > >>>
> > > > >>> [This is patch 1 from [1] Alex's submission and this RPMB layer w=
as
> > > > >>> originally proposed by [2]Thomas Winkler ]
> > > > >>>
> > > > >>> A number of storage technologies support a specialised hardware
> > > > >>> partition designed to be resistant to replay attacks. The underly=
ing
> > > > >>> HW protocols differ but the operations are common. The RPMB parti=
tion
> > > > >>> cannot be accessed via standard block layer, but by a set of spec=
ific
> > > > >>> commands: WRITE, READ, GET_WRITE_COUNTER, and PROGRAM_KEY. Such a
> > > > >>> partition provides authenticated and replay protected access, hen=
ce
> > > > >>> suitable as a secure storage.
> > > > >>>
> > > > >>> The initial aim of this patch is to provide a simple RPMB Driver =
which
> > > > >>> can be accessed by Linux's optee driver to facilitate fast-path f=
or
> > > > >>> RPMB access to optee OS(secure OS) during the boot time. [1] Curr=
ently,
> > > > >>> Optee OS relies on user-tee supplicant to access eMMC RPMB partit=
ion.
> > > > >>>
> > > > >>> A TEE device driver can claim the RPMB interface, for example, via
> > > > >>> class_interface_register(). The RPMB driver provides a series of
> > > > >>> operations for interacting with the device.
> > > > >>
> > > > >> I don't quite follow this. More exactly, how will the TEE driver k=
now
> > > > >> what RPMB device it should use?
> > > > >
> > > > > I don't have complete code to for this yet, but i think OP-TEE driv=
er
> > > > > should register with RPMB subsystem and then we can have eMMC/UFS/N=
VMe
> > > > > specific implementation for RPMB operations.
> > > > >
> > > > > Linux optee driver can handle RPMB frames and pass it to RPMB subsy=
stem
> > > > >
> > >
> > > It would be better to have this OP-TEE use case fully implemented. So
> > > that we can justify it as a valid user for this proposed RPMB
> > > subsystem. If you are looking for any further suggestions then please
> > > let us know.
> >
> > +1
> >
> > >
> > > > > [1] U-Boot has mmc specific implementation
> > > > >
> > > > > I think OPTEE-OS has CFG_RPMB_FS_DEV_ID option
> > > > > CFG_RPMB_FS_DEV_ID=3D1 for /dev/mmcblk1rpmb,
> > > >
> > > > Correct. Note that tee-supplicant will ignore this device ID if --rmb=
-cid
> > > > is given and use the specified RPMB instead (the CID is a non-ambiguo=
us way
> > > > to identify a RPMB device).
> > > >
> > > > > but in case if a
> > > > > system has multiple RPMB devices such as UFS/eMMC/NVMe, one them
> > > > > should be declared as secure storage and optee should access that o=
ne only.
> > > >
> > > > Indeed, that would be an equivalent of tee-supplicant's --rpmb-cid.
> > > >
> > > > > Sumit, do you have suggestions for this ?
> > > >
> > >
> > > I would suggest having an OP-TEE secure DT property that would provide
> > > the RPMB CID which is allocated to the secure world.
> >
> > Another option is for OP-TEE to iterate over all RPMBs with a
> > programmed key and test if the key OP-TEE would use works. That should
> > avoid the problem of provisioning a device-unique secure DTB. I'd
> > expect that the RPMB key is programmed by a trusted provisioning tool
> > since allowing OP-TEE to program the RPMB key has never been secure,
> > not unless the OP-TEE binary is rollback protected.
>
> +1 to that.  Overall we shound't 'trust' to do the programming. For
> example, in OP-TEE if you compile it with device programming
> capabilities, you can easily convince OP-TEE to send you the symmetric
> key by swapping the supplicant with a malicious application.
>

Agree, with your overall intent, that OP-TEE shouldn't expose RPMB key
in plain form. But with suggested OP-TEE RPMB frames routing via
kernel, tee-supplicant won't be used for RPMB accesses.

-Sumit

> Thanks
> /Ilias
> >
> > Cheers,
> > Jens
> >
> > >
> > > -Sumit
> > >
> > > >
> > > > --
> > > > Jerome

--===============3242040849266682654==--

