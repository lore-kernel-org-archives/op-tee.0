From: Enric Balletbo i Serra <eballetb@redhat.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: optee-based efi runtime variable service on TI j784s4 platforms
Date: Tue, 12 Nov 2024 09:17:31 +0100
Message-ID: 
 <CALE0LRu2oDSo6KOhO2fTDMiqX7iqjqNjNGD_67MJFS7BJWqT_w@mail.gmail.com>
In-Reply-To: <
 <CAC_iWjL+J9tNxEdh0AoYD19h013N4nk=KmaT=RACo4-oVwuRCA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0165248703151500964=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0165248703151500964==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 11, 2024 at 3:26=E2=80=AFPM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Mon, 11 Nov 2024 at 16:13, Enric Balletbo i Serra
> <eballetb@redhat.com> wrote:
> >
> > Hi,
> >
> > Thanks a lot for your support.
>
> You're welcome. FWIW I did test this in the past with an AM62x SoC.
>

Thanks for the info, maybe I can give it a try with my BeaglePlay then...

> >
> > On Mon, Nov 11, 2024 at 12:01=E2=80=AFPM Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > On Mon, 11 Nov 2024 at 10:21, Enric Balletbo i Serra
> > > <eballetb@redhat.com> wrote:
> > > >
> > > > Hi Ilias,
> > > >
> > > > On Sat, Nov 9, 2024 at 1:31=E2=80=AFAM Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > > On Fri, 8 Nov 2024 at 23:11, Enric Balletbo i Serra <eballetb@red=
hat.com> wrote:
> > > > > >
> > > > > > Hi Ilias,
> > > > > >
> > > > > > Thanks for your quick answer.
> > > > > >
> > > > > > On Fri, Nov 8, 2024 at 4:48=E2=80=AFPM Ilias Apalodimas
> > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > >
> > > > > > > Hi Enric,
> > > > > > >
> > > > > > > On Fri, 8 Nov 2024 at 12:26, Enric Balletbo i Serra <eballetb(a=
)redhat.com> wrote:
> > > > > > > >
> > > > > > > > Hi all,
> > > > > > > >
> > > > > > > > I'm looking for any advice/clue to help me to progress on ena=
bling
> > > > > > > > TEE-base EFI Runtime Variable Service on TI a j784s4 platform=
s.
> > > > > > > >
> > > > > > > > I basically followed the steps described in u-boot documentat=
ion [1],
> > > > > > > > I enabled some debugging messages but I think I'm at the poin=
t that
> > > > > > > > the problem might be in the StandaloneMM application, and I'm=
 not sure
> > > > > > > > how to debug it.
> > > > > > > >
> > > > > > > > What I see is that when I run the tee-supplicant daemon, it l=
ooks like
> > > > > > > > the tee_client_open_session() call loops forever and the tee_=
stmm_efi
> > > > > > > > driver never ends to probe.
> > > > > > > >
> > > > > > > > With debug enabled I got the following messages.
> > > > > > >
> > > > > > > I assume reading and storing variables already works in U-Boot =
right?
> > > > > > >
> > > > > >
> > > > > > Reading and storing variables to the RPMB partition in U-Boot wor=
ks,
> > > > > > that's using the mmc rpmb command from u-boot,
> > > > >
> > > > > Are you talking about env variables? Perhaps you store them in the =
mmc
> > > > > and not the RPMB partition?
> > > > > There's some information here [0]
> > > > >
> > > > > > But setting
> > > > > > CONFIG_EFI_MM_COMM_TEE=3Dy in u-boot I end with a similar behavio=
ur
> > > > > > (although I'm not able to debug at u-boot level) What I see is th=
at
> > > > > > u-boot gets stuck
> > > > > > when bootefi bootmgr is invoqued. I can also reproduce the issue =
with
> > > > > > bootefi hello.
> > > > > >
> > > > > > =3D> run bootcmd
> > > > > >   Scanning for bootflows in all bootdevs
> > > > > >   Seq  Method       State   Uclass    Part  Name                 =
     Filename
> > > > > >   ---  -----------  ------  --------  ----  ---------------------=
---
> > > > > > ----------------
> > > > > >   Scanning global bootmeth 'efi_mgr':
> > > > > > ( gets stuck here)
> > > > > >
> > > > > > or
> > > > > >
> > > > > > =3D> bootefi hello
> > > > > > (gets stuck)
> > > > > >
> > > > > > To debug I disabled CONFIG_EFI_MM_COMM_TEE to not get stuck and b=
ypass
> > > > > > the error and go to Linux. My understanding is that
> > > > > > CONFIG_EFI_MM_COMM_TEE is only required to read/write efi variabl=
es at
> > > > > > u-boot level but OPTEE is running the StandaloneMM service. Am I
> > > > > > right?
> > > > >
> > > > > U-Boot has two ways of storing EFI variables [0] . You can either
> > > > > store them in a file or the RPMB partition. The correct thing to do,
> > > > > since you want to use the RPMB, is enable CONFIG_EFI_MM_COMM_TEE. I=
 am
> > > > > not sure why the hand happens, but one thing we can improve is figu=
re
> > > > > out why it hangs and print a useful message.
> > > > > There are a number of reasons that might lead to a failure. Is the
> > > > > RPMB key programmed on your board? Have a look at this [1] in case =
it
> > > > > helps
> > > > >
> > > > > >
> > > > > > > >
> > > > > > > > # tee-supplicant
> > > > > > > > D/TC:? 0 tee_ta_init_session_with_context:557 Re-open trusted=
 service
> > > > > > > > 7011a688-ddde-4053-a5a9-7b3c4ddf13b8
> > > > > > > > D/TC:? 0 load_stmm:297 stmm load address 0x40004000
> > > > > > > > D/TC:? 0 spm_handle_scall:859 Received FFA version
> > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > >
> > > > > If I had to guess, OP-TEE doesn't store the variables in the RPMB, =
can
> > > > > you compile it with a bit more debugging enabled?
> > > > >
> > > >
> > > > Here is a log with CFG_TEE_CORE_LOG_LEVEL=3D4, CFG_TEE_CORE_DEBUG=3Dy=
 and
> > > > CFG_TEE_TA_LOG_LEVEL=3D4
> > > >
> > > > https://paste.centos.org/view/eed83a5b
> > > >
> > > > At the beginning of the log I see
> > > >
> > > > D/TC:0 0 check_ta_store:449 TA store: "REE"
> > > >
> > > > Which looks wrong to me as I built optee with:
> > > >   CFG_REE_FS=3Dn
> > > >   CFG_RPMB_FS_DEV_ID=3D0
> > > >   CFG_RPMB_FS=3Dy
> > >
> > > Yes it does look wrong. Our compilation flags are
> > > CFG_RPMB_FS=3Dy CFG_RPMB_FS_DEV_ID=3D0 CFG_RPMB_WRITE_KEY=3Dy
> > > CFG_RPMB_TESTKEY=3Dy CFG_REE_FS=3Dn CFG_CORE_ARM64_PA_BITS=3D48
> > > CFG_SCTLR_ALIGNMENT_CHECK=3Dn
> > >
> >
> > Mine are very similar
> >
> > make CROSS_COMPILE=3D"$CC32" CROSS_COMPILE64=3D"$CC64" \
> >     PLATFORM=3Dk3-j784s4 CFG_ARM64_core=3Dy CFG_CONSOLE_UART=3D0x8 \
> >     CFG_RPMB_FS_DEV_ID=3D0 CFG_REE_FS=3Dn CFG_RPMB_FS=3Dy \
> >     CFG_RPMB_WRITE_KEY=3Dy CFG_RPMB_TESTKEY=3Dy \
> >     CFG_STMM_PATH=3DBL32_AP_MM.fd \
> >     CFG_CORE_HEAP_SIZE=3D524288 CFG_CORE_DYN_SHM=3Dy CFG_SCTLR_ALIGNMENT_=
CHECK=3Dn \
> >     CFG_TEE_CORE_LOG_LEVEL=3D4 CFG_TEE_CORE_DEBUG=3Dy CFG_TEE_TA_LOG_LEVE=
L=3D4
> >
> > There is a difference with CFG_CORE_ARM64_PA_BITS=3D48 , my platform defi=
nes it to
> >
> >    core/arch/arm/plat-k3/conf.mk:$(call force,CFG_CORE_ARM64_PA_BITS,36)
> >
> > But I don't think this is the problem.
> >
> > > The testkey etc aren't required if your board has a way of reading the
> > > RPMB key from a secure location -- in fact, using the testkey is not
> > > secure. Is the RPMB programmed on your board? Also can you make sure
> > > CFG_RPMB_FS_DEV_ID needs to be 0? How many sd interfaces your board
> > > has?
> >
> > My board has two interfaces, an eMMC and a SD-card, 0 is indeed the
> > eMMC and I'm using the testkey which I assume was programmed the first
> > time I booted with all this. Unfortunately I lost the traces. But,
> > optee_rpmb works. I.e:
> >
> >      =3D> optee_rpmb write test 1234
> >      =3D> optee_rpmb read test 4
> >      Read 4 bytes, value =3D 1234
> >
> >
> > > IOW in U-Boot does 'mmc dev 0 && mmc info' print information for the
> > > RPMB partition?
> > >
> >
> >     =3D> mmc dev 0
> >     switch to partitions #0, OK
> >     mmc0(part 0) is current device
> >     =3D> mmc info
> >     Device: mmc(a)4f80000
> >     Manufacturer ID: 13
> >     OEM: 4e
> >     Name: G1M15L
> >     Bus Speed: 200000000
> >     Mode: HS400 (200MHz)
> >     Rd Block Len: 512
> >     MMC version 5.1
> >     High Capacity: Yes
> >     Capacity: 29.6 GiB
> >     Bus Width: 8-bit DDR
> >     Erase Group Size: 512 KiB
> >     HC WP Group Size: 8 MiB
> >     User Capacity: 29.6 GiB WRREL
> >     Boot Capacity: 31.5 MiB ENH
> >     RPMB Capacity: 4 MiB ENH
> >     Boot area 0 is not write protected
> >     Boot area 1 is not write protected
> >     =3D> mmc list
> >     mmc(a)4f80000: 0 (eMMC)
> >     mmc(a)4fb0000: 1
> >
> > Any interaction with efi gives me the same result (printenv -e,
> > efidebug, bootefi ...)
>
> Yes, that makes sense, because variables fail to initialize -- which
> is a core part of bringing up the EFI subsystem.
>
> Can you recompile op-tee with CFG_RPMB_RESET_FAT and try again?
>

Unfortunately that didn't help, but I don't see this code being run.
Who sets for the first place the uefi variables, is this u-boot
writing them to the rpmb? or is optee itself?


> Thanks
> /Ilias
> >
> > =3D> efidebug query -bs -rt -nv
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
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > ... stuck here ... I need to reset the board
> >
> > Will continue to see if I can get more useful messages
> >
> > Thanks,
> >   Enric
> >
> > > Thanks
> > > /Ilias
> > > >
> > > > I'll try to add some more prints to verify if REE is used as a store
> > > > system, I assume this should say something about RPMB. Am I right with
> > > > this?
> > >
> > >
> > > >
> > > > > > > >
> > > > > > > > And tracing the function calls gives me that:
> > > > > > > >
> > > > > > > >       tee_stmm_efi_probe() {
> > > > > > > >              tee_client_open_context() {
> > > > > > > >                optee_get_version() {
> > > > > > > >                  tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > > > > > > >                } (ret=3D0xd)
> > > > > > > >                tee_ctx_match(); (ret=3D0x1)
> > > > > > > >                optee_smc_open() {
> > > > > > > >                  tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > > > > > > >                  optee_open() {
> > > > > > > >                    tee_get_drvdata(); (ret=3D0xffff000002e558=
00)
> > > > > > > >                  } (ret=3D0x0)
> > > > > > > >                } (ret=3D0x0)
> > > > > > > >              } (ret=3D0xffff000004e71c80)
> > > > > > > >              tee_client_open_session() {
> > > > > > > >                optee_open_session() {
> > > > > > > >                  tee_get_drvdata(); (ret=3D0xffff000002e55800)
> > > > > > > >                  optee_get_msg_arg() {
> > > > > > > >                    tee_get_drvdata(); (ret=3D0xffff000002e558=
00)
> > > > > > > >                    tee_shm_get_va(); (ret=3D0xffff00000290900=
0)
> > > > > > > >                  } (ret=3D0xffff000002909000)
> > > > > > > >                  tee_session_calc_client_uuid(); (ret=3D0x0)
> > > > > > > >                  optee_to_msg_param(); (ret=3D0x0)
> > > > > > > >                  optee_smc_do_call_with_arg() {
> > > > > > > >                    tee_get_drvdata(); (ret=3D0xffff000002e558=
00)
> > > > > > > >                    tee_shm_get_va(); (ret=3D0xffff00000290900=
0)
> > > > > > > >                    tee_shm_get_va(); (ret=3D0xffff00000290906=
0)
> > > > > > > >                    optee_cq_wait_init(); (ret=3D0xffff000002e=
55910)
> > > > > > > >                    optee_smccc_smc(); (ret=3D0xffff0004)
> > > > > > > >                    tee_get_drvdata(); (ret=3D0xffff000002e558=
00)
> > > > > > > >                    optee_smccc_smc(); (ret=3D0xffff0004)
> > > > > > > >                    tee_get_drvdata(); (ret=3D0xffff000002e558=
00)
> > > > > > > >                    optee_smccc_smc(); (ret=3D0xffff0004)
> > > > > > > >                    tee_get_drvdata(); (ret=3D0xffff000002e558=
00)
> > > > > > > >                    optee_smccc_smc(); (ret=3D0xffff0004)
> > > > > > > >                    tee_get_drvdata(); (ret=3D0xffff000002e558=
00)
> > > > > > > >                    optee_smccc_smc(); (ret=3D0xffff0004)
> > > > > > > >      ... continues sending this forever ...
> > > > > > > >      ... Hit ^C to stop recording ...
> > > > > > > >                    tee_get_drvdata(); (ret=3D0xffff000002e558=
00)
> > > > > > > >                    optee_smccc_smc() {
> > > > > > > >
> > > > > > > > [1] https://docs.u-boot.org/en/latest/develop/uefi/uefi.html#=
using-op-tee-for-efi-variables
> > > > > > > >
> > > > > > > > Thanks in advance,
> > > > > > >
> > > > > > > The most common problem with this is miscompiling the tee_suppl=
icant
> > > > > > > application.
> > > > > > > Since we don't know if the system has an RPMB, we emulate it in=
 the
> > > > > > > tee_supplicant. How did you get the supplicant and can you chec=
k if it
> > > > > > > was compiled with RPMB_EMU=3D0 or 1?
> > > > > > >
> > > > > >
> > > > > > I'm using the tee-supplicant provided by the fedora package which=
 is
> > > > > > built with ` -DRPMB_EMU=3D0`, I think that's correct, right?
> > > > > >
> > > > >
> > > > > Yes, this is correct. We fixed the Fedora package to compile the
> > > > > supplicant correctly a while back.
> > > > >
> > > > > [0] https://www.linaro.org/blog/uefi-secureboot-in-u-boot/
> > > > > [1] https://apalos.github.io/Protected%20UEFI%20variables%20with%20=
U-Boot.html#Protected%20UEFI%20variables%20with%20U-Boot
> > > > >
> > > > >
> > > > > Regards
> > > > > /Ilias
> > > > > > Thanks,
> > > > > >    Enric
> > > > > >
> > > > > > > Thanks
> > > > > > > /Ilias
> > > > > > >
> > > > > > > >    Enric
> > > > > > > >
> > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> >
>


--===============0165248703151500964==--

