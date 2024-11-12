From: Enric Balletbo i Serra <eballetb@redhat.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: optee-based efi runtime variable service on TI j784s4 platforms
Date: Tue, 12 Nov 2024 13:45:03 +0100
Message-ID: 
 <CALE0LRsqc6L9EunhOyvyOR_KgG28zb10YBR1qN2qgZ9iJvaHEw@mail.gmail.com>
In-Reply-To: <
 <CAC_iWj+STZib+VOZrQtZk95skWzyLqe7_HpNM60G6axNa3Lnnw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0583001019324503173=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0583001019324503173==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilias,

On Tue, Nov 12, 2024 at 12:50=E2=80=AFPM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Enric
>
> On Tue, 12 Nov 2024 at 13:40, Enric Balletbo i Serra
> <eballetb@redhat.com> wrote:
> >
> > Hi again,
> >
> > On Tue, Nov 12, 2024 at 9:17=E2=80=AFAM Enric Balletbo i Serra
> > <eballetb@redhat.com> wrote:
> > >
> > > Hi,
> > >
> > > On Mon, Nov 11, 2024 at 3:26=E2=80=AFPM Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > On Mon, 11 Nov 2024 at 16:13, Enric Balletbo i Serra
> > > > <eballetb@redhat.com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > Thanks a lot for your support.
> > > >
> > > > You're welcome. FWIW I did test this in the past with an AM62x SoC.
> > > >
> > >
> > > Thanks for the info, maybe I can give it a try with my BeaglePlay then.=
..
> > >
> > > > >
> > > > > On Mon, Nov 11, 2024 at 12:01=E2=80=AFPM Ilias Apalodimas
> > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > >
> > > > > > On Mon, 11 Nov 2024 at 10:21, Enric Balletbo i Serra
> > > > > > <eballetb@redhat.com> wrote:
> > > > > > >
> > > > > > > Hi Ilias,
> > > > > > >
> > > > > > > On Sat, Nov 9, 2024 at 1:31=E2=80=AFAM Ilias Apalodimas
> > > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > > >
> > > > > > > > On Fri, 8 Nov 2024 at 23:11, Enric Balletbo i Serra <eballetb=
@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > Hi Ilias,
> > > > > > > > >
> > > > > > > > > Thanks for your quick answer.
> > > > > > > > >
> > > > > > > > > On Fri, Nov 8, 2024 at 4:48=E2=80=AFPM Ilias Apalodimas
> > > > > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi Enric,
> > > > > > > > > >
> > > > > > > > > > On Fri, 8 Nov 2024 at 12:26, Enric Balletbo i Serra <ebal=
letb@redhat.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hi all,
> > > > > > > > > > >
> > > > > > > > > > > I'm looking for any advice/clue to help me to progress =
on enabling
> > > > > > > > > > > TEE-base EFI Runtime Variable Service on TI a j784s4 pl=
atforms.
> > > > > > > > > > >
> > > > > > > > > > > I basically followed the steps described in u-boot docu=
mentation [1],
> > > > > > > > > > > I enabled some debugging messages but I think I'm at th=
e point that
> > > > > > > > > > > the problem might be in the StandaloneMM application, a=
nd I'm not sure
> > > > > > > > > > > how to debug it.
> > > > > > > > > > >
> > > > > > > > > > > What I see is that when I run the tee-supplicant daemon=
, it looks like
> > > > > > > > > > > the tee_client_open_session() call loops forever and th=
e tee_stmm_efi
> > > > > > > > > > > driver never ends to probe.
> > > > > > > > > > >
> > > > > > > > > > > With debug enabled I got the following messages.
> > > > > > > > > >
> > > > > > > > > > I assume reading and storing variables already works in U=
-Boot right?
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > Reading and storing variables to the RPMB partition in U-Bo=
ot works,
> > > > > > > > > that's using the mmc rpmb command from u-boot,
> > > > > > > >
> > > > > > > > Are you talking about env variables? Perhaps you store them i=
n the mmc
> > > > > > > > and not the RPMB partition?
> > > > > > > > There's some information here [0]
> > > > > > > >
> > > > > > > > > But setting
> > > > > > > > > CONFIG_EFI_MM_COMM_TEE=3Dy in u-boot I end with a similar b=
ehaviour
> > > > > > > > > (although I'm not able to debug at u-boot level) What I see=
 is that
> > > > > > > > > u-boot gets stuck
> > > > > > > > > when bootefi bootmgr is invoqued. I can also reproduce the =
issue with
> > > > > > > > > bootefi hello.
> > > > > > > > >
> > > > > > > > > =3D> run bootcmd
> > > > > > > > >   Scanning for bootflows in all bootdevs
> > > > > > > > >   Seq  Method       State   Uclass    Part  Name           =
           Filename
> > > > > > > > >   ---  -----------  ------  --------  ----  ---------------=
---------
> > > > > > > > > ----------------
> > > > > > > > >   Scanning global bootmeth 'efi_mgr':
> > > > > > > > > ( gets stuck here)
> > > > > > > > >
> > > > > > > > > or
> > > > > > > > >
> > > > > > > > > =3D> bootefi hello
> > > > > > > > > (gets stuck)
> > > > > > > > >
> > > > > > > > > To debug I disabled CONFIG_EFI_MM_COMM_TEE to not get stuck=
 and bypass
> > > > > > > > > the error and go to Linux. My understanding is that
> > > > > > > > > CONFIG_EFI_MM_COMM_TEE is only required to read/write efi v=
ariables at
> > > > > > > > > u-boot level but OPTEE is running the StandaloneMM service.=
 Am I
> > > > > > > > > right?
> > > > > > > >
> > > > > > > > U-Boot has two ways of storing EFI variables [0] . You can ei=
ther
> > > > > > > > store them in a file or the RPMB partition. The correct thing=
 to do,
> > > > > > > > since you want to use the RPMB, is enable CONFIG_EFI_MM_COMM_=
TEE. I am
> > > > > > > > not sure why the hand happens, but one thing we can improve i=
s figure
> > > > > > > > out why it hangs and print a useful message.
> > > > > > > > There are a number of reasons that might lead to a failure. I=
s the
> > > > > > > > RPMB key programmed on your board? Have a look at this [1] in=
 case it
> > > > > > > > helps
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > # tee-supplicant
> > > > > > > > > > > D/TC:? 0 tee_ta_init_session_with_context:557 Re-open t=
rusted service
> > > > > > > > > > > 7011a688-ddde-4053-a5a9-7b3c4ddf13b8
> > > > > > > > > > > D/TC:? 0 load_stmm:297 stmm load address 0x40004000
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:859 Received FFA version
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > >
> > > > > > > > If I had to guess, OP-TEE doesn't store the variables in the =
RPMB, can
> > > > > > > > you compile it with a bit more debugging enabled?
> > > > > > > >
> > > > > > >
> > > > > > > Here is a log with CFG_TEE_CORE_LOG_LEVEL=3D4, CFG_TEE_CORE_DEB=
UG=3Dy and
> > > > > > > CFG_TEE_TA_LOG_LEVEL=3D4
> > > > > > >
> > > > > > > https://paste.centos.org/view/eed83a5b
> > > > > > >
> > > > > > > At the beginning of the log I see
> > > > > > >
> > > > > > > D/TC:0 0 check_ta_store:449 TA store: "REE"
> > > > > > >
> > > > > > > Which looks wrong to me as I built optee with:
> > > > > > >   CFG_REE_FS=3Dn
> > > > > > >   CFG_RPMB_FS_DEV_ID=3D0
> > > > > > >   CFG_RPMB_FS=3Dy
> > > > > >
> > > > > > Yes it does look wrong. Our compilation flags are
> > > > > > CFG_RPMB_FS=3Dy CFG_RPMB_FS_DEV_ID=3D0 CFG_RPMB_WRITE_KEY=3Dy
> > > > > > CFG_RPMB_TESTKEY=3Dy CFG_REE_FS=3Dn CFG_CORE_ARM64_PA_BITS=3D48
> > > > > > CFG_SCTLR_ALIGNMENT_CHECK=3Dn
> > > > > >
> > > > >
> > > > > Mine are very similar
> > > > >
> > > > > make CROSS_COMPILE=3D"$CC32" CROSS_COMPILE64=3D"$CC64" \
> > > > >     PLATFORM=3Dk3-j784s4 CFG_ARM64_core=3Dy CFG_CONSOLE_UART=3D0x8 \
> > > > >     CFG_RPMB_FS_DEV_ID=3D0 CFG_REE_FS=3Dn CFG_RPMB_FS=3Dy \
> > > > >     CFG_RPMB_WRITE_KEY=3Dy CFG_RPMB_TESTKEY=3Dy \
> > > > >     CFG_STMM_PATH=3DBL32_AP_MM.fd \
> > > > >     CFG_CORE_HEAP_SIZE=3D524288 CFG_CORE_DYN_SHM=3Dy CFG_SCTLR_ALIG=
NMENT_CHECK=3Dn \
> > > > >     CFG_TEE_CORE_LOG_LEVEL=3D4 CFG_TEE_CORE_DEBUG=3Dy CFG_TEE_TA_LO=
G_LEVEL=3D4
> > > > >
> > > > > There is a difference with CFG_CORE_ARM64_PA_BITS=3D48 , my platfor=
m defines it to
> > > > >
> > > > >    core/arch/arm/plat-k3/conf.mk:$(call force,CFG_CORE_ARM64_PA_BIT=
S,36)
> > > > >
> > > > > But I don't think this is the problem.
> > > > >
> > > > > > The testkey etc aren't required if your board has a way of readin=
g the
> > > > > > RPMB key from a secure location -- in fact, using the testkey is =
not
> > > > > > secure. Is the RPMB programmed on your board? Also can you make s=
ure
> > > > > > CFG_RPMB_FS_DEV_ID needs to be 0? How many sd interfaces your boa=
rd
> > > > > > has?
> > > > >
> > > > > My board has two interfaces, an eMMC and a SD-card, 0 is indeed the
> > > > > eMMC and I'm using the testkey which I assume was programmed the fi=
rst
> > > > > time I booted with all this. Unfortunately I lost the traces. But,
> > > > > optee_rpmb works. I.e:
> > > > >
> > > > >      =3D> optee_rpmb write test 1234
> > > > >      =3D> optee_rpmb read test 4
> > > > >      Read 4 bytes, value =3D 1234
> > > > >
> > > > >
> > > > > > IOW in U-Boot does 'mmc dev 0 && mmc info' print information for =
the
> > > > > > RPMB partition?
> > > > > >
> > > > >
> > > > >     =3D> mmc dev 0
> > > > >     switch to partitions #0, OK
> > > > >     mmc0(part 0) is current device
> > > > >     =3D> mmc info
> > > > >     Device: mmc(a)4f80000
> > > > >     Manufacturer ID: 13
> > > > >     OEM: 4e
> > > > >     Name: G1M15L
> > > > >     Bus Speed: 200000000
> > > > >     Mode: HS400 (200MHz)
> > > > >     Rd Block Len: 512
> > > > >     MMC version 5.1
> > > > >     High Capacity: Yes
> > > > >     Capacity: 29.6 GiB
> > > > >     Bus Width: 8-bit DDR
> > > > >     Erase Group Size: 512 KiB
> > > > >     HC WP Group Size: 8 MiB
> > > > >     User Capacity: 29.6 GiB WRREL
> > > > >     Boot Capacity: 31.5 MiB ENH
> > > > >     RPMB Capacity: 4 MiB ENH
> > > > >     Boot area 0 is not write protected
> > > > >     Boot area 1 is not write protected
> > > > >     =3D> mmc list
> > > > >     mmc(a)4f80000: 0 (eMMC)
> > > > >     mmc(a)4fb0000: 1
> > > > >
> > > > > Any interaction with efi gives me the same result (printenv -e,
> > > > > efidebug, bootefi ...)
> > > >
> > > > Yes, that makes sense, because variables fail to initialize -- which
> > > > is a core part of bringing up the EFI subsystem.
> > > >
> > > > Can you recompile op-tee with CFG_RPMB_RESET_FAT and try again?
> > > >
> > >
> > > Unfortunately that didn't help, but I don't see this code being run.
>
> That's weird, look below.
>
> > > Who sets for the first place the uefi variables, is this u-boot
> > > writing them to the rpmb? or is optee itself?
>
> U-Boot sets the variables, but it does so via StandAloneMM.
>
> > >
> >
> > I tried to compare the behaviour between optee_rpmb (works) and
> > efidebug (doesn't worrk). I see that the first thing optee_rpmb
> > command does is open a session against the TA application, something
> > that efidebug doesn't do, shouldn't efidebug do the same to access to
> > the rpmb device and read or write the efi variables?
> >
>
> That's a bit more complicated and explained to one of the blog posts I
> pasted above.
> We do open an OP-TEE session, but not for talking to a TA. We send the
> messages to StandAloneMM, which then usese OPTEE RPMB APIs to write
> the flash.
>
> The weird thing is why OP-TEE does not format your RPMB when compiling
> with that flag.
> If done correctly, OP-TEE will wipe the RPMB contents the first time
> it tries to access it.
>

It does if I call optee_rpmb command

E/TC:? 0 rpmb_fs_setup:2143 **** Clearing Storage ****

But I don't see any attempt to write efi variables to the rpmb
partition if I use the normal boot workflow or calling any efi command
from the prompt.

I think I need to read a bit more about all the pieces because I might
miss something.

=3D> optee_rpmb read test 4
D/TC:? 0 tee_ta_init_pseudo_ta_session:303 Lookup pseudo TA
023f8f1a-292a-432b-8fc4-de8471358067
D/TC:? 0 ldelf_load_ldelf:110 ldelf load address 0x40007000
D/LD:  ldelf:142 Loading TS 023f8f1a-292a-432b-8fc4-de8471358067
F/TC:? 0 trace_syscall:147 syscall #3 (syscall_get_property)
F/TC:? 0 trace_syscall:147 syscall #5 (syscall_open_ta_session)
D/TC:? 0 ldelf_syscall_open_bin:135 > ldelf_syscall_open_bin
D/TC:? 0 ldelf_syscall_open_bin:164 Lookup user TA ELF
023f8f1a-292a-432b-8fc4-de8471358067 (early TA)
D/TC:? 0 ldelf_syscall_open_bin:168 res=3D0
F/TC:? 0 trace_syscall:147 syscall #7 (syscall_invoke_ta_command)
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 trace_syscall:147 syscall #11 (syscall_mask_cancellation)
F/TC:? 0 trace_syscall:147 syscall #7 (syscall_invoke_ta_command)
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 492 bytes
F/TC:? 0 trace_syscall:147 syscall #3 (syscall_get_property)
F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_rights)
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 532 bytes
F/TC:? 0 read_compressed:178 924 bytes
F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_rights)
F/TC:? 0 read_compressed:178 248 bytes
F/TC:? 0 read_compressed:178 760 bytes
F/TC:? 0 trace_syscall:147 syscall #6 (syscall_close_ta_session)
F/TC:? 0 trace_syscall:147 syscall #3 (syscall_get_property)
D/LD:  ldelf:176 ELF (023f8f1a-292a-432b-8fc4-de8471358067) at 0x40048000
F/TC:? 0 trace_syscall:147 syscall #33 (syscall_cryp_random_number_generate)
F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_rights)
F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_rights)
F/TC:? 0 trace_syscall:147 syscall #4 (syscall_get_property_name_to_index)
F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_rights)
F/TC:? 0 trace_syscall:147 syscall #41 (syscall_storage_obj_open)
D/TC:? 0 rpmb_fs_open_internal:2356 >>> rpmb_fs_open_internal
D/TC:? 0 tee_rpmb_init:1205 >>> core/tee/tee_rpmb_fs.c:1205
D/TC:? 0 tee_rpmb_init:1214 >>> core/tee/tee_rpmb_fs.c:1214
D/TC:? 0 tee_rpmb_init:1253 >>> core/tee/tee_rpmb_fs.c:1253
D/TC:? 0 legacy_rpmb_init:1142 Trying legacy RPMB init
D/TC:? 0 rpmb_set_dev_info:1111 RPMB: Syncing device information
D/TC:? 0 rpmb_set_dev_info:1113 RPMB: RPMB size is 32*128 KB
D/TC:? 0 rpmb_set_dev_info:1114 RPMB: Reliable Write Sector Count is 1
D/TC:? 0 rpmb_set_dev_info:1116 RPMB: CID
D/TC:? 0 rpmb_set_dev_info:1117 000000009e93ab30  13 01 4e 47 31 4d 31
35  4c 10 27 91 28 07 a9 00
D/TC:? 0 legacy_rpmb_init:1162 RPMB INIT: Deriving key
D/TC:? 0 tee_rpmb_key_gen:308 RPMB: Using test key
D/TC:? 0 legacy_rpmb_init:1176 RPMB INIT: Verifying Key
F/TC:? 0 plat_prng_add_jitter_entropy:68 0x61
D/TC:? 0 legacy_rpmb_init:1180 Found working RPMB device
D/TC:? 0 tee_rpmb_init:1205 >>> core/tee/tee_rpmb_fs.c:1205
D/TC:? 0 tee_rpmb_init:1214 >>> core/tee/tee_rpmb_fs.c:1214
D/TC:? 0 tee_rpmb_read:1362 Read 1 block at index 0
D/TC:? 0 tee_rpmb_write_blk:1494 Write 1 block at index 0
D/TC:? 0 tee_rpmb_init:1205 >>> core/tee/tee_rpmb_fs.c:1205
D/TC:? 0 tee_rpmb_init:1214 >>> core/tee/tee_rpmb_fs.c:1214
D/TC:? 0 tee_rpmb_init:1205 >>> core/tee/tee_rpmb_fs.c:1205
D/TC:? 0 tee_rpmb_init:1214 >>> core/tee/tee_rpmb_fs.c:1214
D/TC:? 0 tee_rpmb_read:1362 Read 1 block at index 0
E/TC:? 0 rpmb_fs_setup:2143 **** Clearing Storage ****
D/TC:? 0 tee_rpmb_write_blk:1494 Write 1 block at index 2
F/TC:? 0 plat_prng_add_jitter_entropy:68 0xD3
D/TC:? 0 tee_rpmb_read:1362 Read 1 block at index 0
D/TC:? 0 tee_rpmb_write_blk:1494 Write 1 block at index 0
D/TC:? 0 tee_rpmb_read:1362 Read 8 blocks at index 2
F/TC:? 0 dump_fat:1951 flags 0x2, size 0, address 0, filename ''
D/TC:? 0 read_fat:2221 fat_address 0
D/TC:? 0 tee_rpmb_read:1362 Read 8 blocks at index 2
F/TC:? 0 plat_prng_add_jitter_entropy:68 0x18
E/TA:  read_persist_value:338 Can't open named object value, res =3D 0xffff00=
08
D/TC:? 0 tee_ta_invoke_command:798 Error: ffff0008 of 4
D/TC:? 0 tee_ta_close_session:460 csess 0x9e925a50 id 1
D/TC:? 0 tee_ta_close_session:479 Destroy session
D/TC:? 0 destroy_context:318 Destroy TA ctx (0x9e9259f0)
Failed to read persistent value







> Cheers
> /Ilias
>
> > =3D> optee_rpmb read test 4
> > D/TC:? 0 tee_ta_init_pseudo_ta_session:303 Lookup pseudo TA
> > 023f8f1a-292a-432b-8fc4-de8471358067
> > D/TC:? 0 ldelf_load_ldelf:110 ldelf load address 0x40007000
> > D/LD:  ldelf:142 Loading TS 023f8f1a-292a-432b-8fc4-de8471358067
> > F/TC:? 0 trace_syscall:147 syscall #3 (syscall_get_property)
> > F/TC:? 0 trace_syscall:147 syscall #5 (syscall_open_ta_session)
> > D/TC:? 0 ldelf_syscall_open_bin:163 Lookup user TA ELF
> > 023f8f1a-292a-432b-8fc4-de8471358067 (early TA)
> > D/TC:? 0 ldelf_syscall_open_bin:167 res=3D0
> > F/TC:? 0 trace_syscall:147 syscall #7 (syscall_invoke_ta_command)
> > F/TC:? 0 read_compressed:178 1024 bytes
> > F/TC:? 0 read_compressed:178 1024 bytes
> > F/TC:? 0 read_compressed:178 1024 bytes
> > F/TC:? 0 read_compressed:178 1024 bytes
> > F/TC:? 0 trace_syscall:147 syscall #11 (syscall_mask_cancellation)
> > F/TC:? 0 trace_syscall:147 syscall #7 (syscall_invoke_ta_command)
> >
> > =3D> efidebug query -bs -rt -nv
> > MMC: no card present
> > mmc_init: -123, time 2002
> > D/TC:? 0 load_stmm:297 stmm load address 0x40004000
> > D/TC:? 0 spm_handle_scall:859 Received FFA version
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> >
> >
> >
> > >
> > > > Thanks
> > > > /Ilias
> > > > >
> > > > > =3D> efidebug query -bs -rt -nv
> > > > > D/TC:? 0 load_stmm:297 stmm load address 0x40004000
> > > > > D/TC:? 0 spm_handle_scall:859 Received FFA version
> > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > ... stuck here ... I need to reset the board
> > > > >
> > > > > Will continue to see if I can get more useful messages
> > > > >
> > > > > Thanks,
> > > > >   Enric
> > > > >
> > > > > > Thanks
> > > > > > /Ilias
> > > > > > >
> > > > > > > I'll try to add some more prints to verify if REE is used as a =
store
> > > > > > > system, I assume this should say something about RPMB. Am I rig=
ht with
> > > > > > > this?
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > And tracing the function calls gives me that:
> > > > > > > > > > >
> > > > > > > > > > >       tee_stmm_efi_probe() {
> > > > > > > > > > >              tee_client_open_context() {
> > > > > > > > > > >                optee_get_version() {
> > > > > > > > > > >                  tee_get_drvdata(); (ret=3D0xffff000002=
e55800)
> > > > > > > > > > >                } (ret=3D0xd)
> > > > > > > > > > >                tee_ctx_match(); (ret=3D0x1)
> > > > > > > > > > >                optee_smc_open() {
> > > > > > > > > > >                  tee_get_drvdata(); (ret=3D0xffff000002=
e55800)
> > > > > > > > > > >                  optee_open() {
> > > > > > > > > > >                    tee_get_drvdata(); (ret=3D0xffff0000=
02e55800)
> > > > > > > > > > >                  } (ret=3D0x0)
> > > > > > > > > > >                } (ret=3D0x0)
> > > > > > > > > > >              } (ret=3D0xffff000004e71c80)
> > > > > > > > > > >              tee_client_open_session() {
> > > > > > > > > > >                optee_open_session() {
> > > > > > > > > > >                  tee_get_drvdata(); (ret=3D0xffff000002=
e55800)
> > > > > > > > > > >                  optee_get_msg_arg() {
> > > > > > > > > > >                    tee_get_drvdata(); (ret=3D0xffff0000=
02e55800)
> > > > > > > > > > >                    tee_shm_get_va(); (ret=3D0xffff00000=
2909000)
> > > > > > > > > > >                  } (ret=3D0xffff000002909000)
> > > > > > > > > > >                  tee_session_calc_client_uuid(); (ret=
=3D0x0)
> > > > > > > > > > >                  optee_to_msg_param(); (ret=3D0x0)
> > > > > > > > > > >                  optee_smc_do_call_with_arg() {
> > > > > > > > > > >                    tee_get_drvdata(); (ret=3D0xffff0000=
02e55800)
> > > > > > > > > > >                    tee_shm_get_va(); (ret=3D0xffff00000=
2909000)
> > > > > > > > > > >                    tee_shm_get_va(); (ret=3D0xffff00000=
2909060)
> > > > > > > > > > >                    optee_cq_wait_init(); (ret=3D0xffff0=
00002e55910)
> > > > > > > > > > >                    optee_smccc_smc(); (ret=3D0xffff0004)
> > > > > > > > > > >                    tee_get_drvdata(); (ret=3D0xffff0000=
02e55800)
> > > > > > > > > > >                    optee_smccc_smc(); (ret=3D0xffff0004)
> > > > > > > > > > >                    tee_get_drvdata(); (ret=3D0xffff0000=
02e55800)
> > > > > > > > > > >                    optee_smccc_smc(); (ret=3D0xffff0004)
> > > > > > > > > > >                    tee_get_drvdata(); (ret=3D0xffff0000=
02e55800)
> > > > > > > > > > >                    optee_smccc_smc(); (ret=3D0xffff0004)
> > > > > > > > > > >                    tee_get_drvdata(); (ret=3D0xffff0000=
02e55800)
> > > > > > > > > > >                    optee_smccc_smc(); (ret=3D0xffff0004)
> > > > > > > > > > >      ... continues sending this forever ...
> > > > > > > > > > >      ... Hit ^C to stop recording ...
> > > > > > > > > > >                    tee_get_drvdata(); (ret=3D0xffff0000=
02e55800)
> > > > > > > > > > >                    optee_smccc_smc() {
> > > > > > > > > > >
> > > > > > > > > > > [1] https://docs.u-boot.org/en/latest/develop/uefi/uefi=
.html#using-op-tee-for-efi-variables
> > > > > > > > > > >
> > > > > > > > > > > Thanks in advance,
> > > > > > > > > >
> > > > > > > > > > The most common problem with this is miscompiling the tee=
_supplicant
> > > > > > > > > > application.
> > > > > > > > > > Since we don't know if the system has an RPMB, we emulate=
 it in the
> > > > > > > > > > tee_supplicant. How did you get the supplicant and can yo=
u check if it
> > > > > > > > > > was compiled with RPMB_EMU=3D0 or 1?
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > I'm using the tee-supplicant provided by the fedora package=
 which is
> > > > > > > > > built with ` -DRPMB_EMU=3D0`, I think that's correct, right?
> > > > > > > > >
> > > > > > > >
> > > > > > > > Yes, this is correct. We fixed the Fedora package to compile =
the
> > > > > > > > supplicant correctly a while back.
> > > > > > > >
> > > > > > > > [0] https://www.linaro.org/blog/uefi-secureboot-in-u-boot/
> > > > > > > > [1] https://apalos.github.io/Protected%20UEFI%20variables%20w=
ith%20U-Boot.html#Protected%20UEFI%20variables%20with%20U-Boot
> > > > > > > >
> > > > > > > >
> > > > > > > > Regards
> > > > > > > > /Ilias
> > > > > > > > > Thanks,
> > > > > > > > >    Enric
> > > > > > > > >
> > > > > > > > > > Thanks
> > > > > > > > > > /Ilias
> > > > > > > > > >
> > > > > > > > > > >    Enric
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > >
> > > > > > > >
> > > > > > >
> > > > > >
> > > > >
> > > >
> >
>


--===============0583001019324503173==--

