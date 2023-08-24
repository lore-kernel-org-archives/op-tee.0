From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [RFC, PATCH 1/1] rpmb: add Replay Protected Memory Block (RPMB) driver
Date: Thu, 24 Aug 2023 19:31:28 +0530
Message-ID: 
 <CAFA6WYMYepbFwF0nWpR1vNkmzvFUoNojY1cWRPtGQAF8U8ngfA@mail.gmail.com>
In-Reply-To: <d24dba8-a777-1acb-98f0-747998b6e8a3@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8520433107644257429=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8520433107644257429==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 23 Aug 2023 at 00:29, Shyam Saini
<shyamsaini@linux.microsoft.com> wrote:
>
>
> Hi Sumit,
>
> > On Mon, 21 Aug 2023 at 15:19, Jerome Forissier
> > <jerome.forissier@linaro.org> wrote:
> >>
> >>
> >>
> >> On 8/17/23 01:31, Shyam Saini wrote:
> >>>
> >>> Hi Ulf,
> >>>
> >>>> On Sat, 22 Jul 2023 at 03:41, Shyam Saini
> >>>> <shyamsaini@linux.microsoft.com> wrote:
> >>>>>
> >>>>> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >>>>>
> >>>>> [This is patch 1 from [1] Alex's submission and this RPMB layer was
> >>>>> originally proposed by [2]Thomas Winkler ]
> >>>>>
> >>>>> A number of storage technologies support a specialised hardware
> >>>>> partition designed to be resistant to replay attacks. The underlying
> >>>>> HW protocols differ but the operations are common. The RPMB partition
> >>>>> cannot be accessed via standard block layer, but by a set of specific
> >>>>> commands: WRITE, READ, GET_WRITE_COUNTER, and PROGRAM_KEY. Such a
> >>>>> partition provides authenticated and replay protected access, hence
> >>>>> suitable as a secure storage.
> >>>>>
> >>>>> The initial aim of this patch is to provide a simple RPMB Driver which
> >>>>> can be accessed by Linux's optee driver to facilitate fast-path for
> >>>>> RPMB access to optee OS(secure OS) during the boot time. [1] Currentl=
y,
> >>>>> Optee OS relies on user-tee supplicant to access eMMC RPMB partition.
> >>>>>
> >>>>> A TEE device driver can claim the RPMB interface, for example, via
> >>>>> class_interface_register(). The RPMB driver provides a series of
> >>>>> operations for interacting with the device.
> >>>>
> >>>> I don't quite follow this. More exactly, how will the TEE driver know
> >>>> what RPMB device it should use?
> >>>
> >>> I don't have complete code to for this yet, but i think OP-TEE driver
> >>> should register with RPMB subsystem and then we can have eMMC/UFS/NVMe
> >>> specific implementation for RPMB operations.
> >>>
> >>> Linux optee driver can handle RPMB frames and pass it to RPMB subsystem
> >>>
> >
> > It would be better to have this OP-TEE use case fully implemented. So
> > that we can justify it as a valid user for this proposed RPMB
> > subsystem. If you are looking for any further suggestions then please
> > let us know.
>
> I was looking into UFS/NVMe user-space utils, it seems we may have to
> adapt rpmb frame data structure in optee-os to to handle NVMe/UFS
> specific bits.
>
> For nvme rpmb data frame, I think we would need an extra "target" member
> in rpmb data frame structure,
> as NVMe can support upto 7 RPMB units, see  [1] "struct rpmb_data_frame_t"
> UFS may support upto 3 or 4 RPMB regions.
>
> So even if we use CID to uniquely identify RPMB device either from
> eMMC/NVMe/UFS, we still need identify which RPMB target/unit in case
> if the device is NVMe, and which RPMB region if the device UFS.
>
> Also both NVMe/UFS utils have two extra RPMB operations implemented,
> Although new request/response operation than eMMC spec:
>   1) Authenticated Device Configuration Block Write
>   2) Authenticated Device Configuration Block Read
>
> see [2] enum rpmb_request/response_type and [3]enum rpmb_op_type
>
> do we need those implemented as well ?

IMO, we should start with eMMC RPMB support first with OP-TEE. This is
what OP-TEE currently supports. And later on we can extend that
framework for UFS and NVMe RPMB.

We need to put extra care here regarding the eMMC RPMB ABI among
OP-TEE and Linux kernel. It should be designed in a way that it is
future compatible for UFS/NMVe. IOW, the bits that you have already
discovered above.

Also, we have to be backwards compatible with eMMC RPMB ABI towards
u-boot too since OP-TEE would use the same ABI whether it is towards
Linux or u-boot.

-Sumit

>
> Please let me know what you think about these.
>
> [1] https://github.com/linux-nvme/nvme-cli/blob/master/nvme-rpmb.c#L252
> [2] https://github.com/linux-nvme/nvme-cli/blob/master/nvme-rpmb.c#L230
> [3] https://github.com/westerndigitalcorporation/ufs-utils/blob/dev/ufs_rpm=
b.c#L27
>
> >>> [1] U-Boot has mmc specific implementation
> >>>
> >>> I think OPTEE-OS has CFG_RPMB_FS_DEV_ID option
> >>> CFG_RPMB_FS_DEV_ID=3D1 for /dev/mmcblk1rpmb,
> >>
> >> Correct. Note that tee-supplicant will ignore this device ID if --rmb-cid
> >> is given and use the specified RPMB instead (the CID is a non-ambiguous =
way
> >> to identify a RPMB device).
> >>
> >>> but in case if a
> >>> system has multiple RPMB devices such as UFS/eMMC/NVMe, one them
> >>> should be declared as secure storage and optee should access that one o=
nly.
> >>
> >> Indeed, that would be an equivalent of tee-supplicant's --rpmb-cid.
> >>
> >>> Sumit, do you have suggestions for this ?
> >>
> >
> > I would suggest having an OP-TEE secure DT property that would provide
> > the RPMB CID which is allocated to the secure world.
> >
> > -Sumit
> >
> >>
> >> --
> >> Jerome
> >

--===============8520433107644257429==--

