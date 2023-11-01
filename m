From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v9 0/6] introduce tee-based EFI Runtime Variable Service
Date: Wed, 01 Nov 2023 08:56:44 +0200
Message-ID: <ZUH2rNtWTgENLDtS@hades>
In-Reply-To: <
 <CADQ0-X8fEUw2pkeWRKGsYs8cNfDnyM=ibj9emZ5Q0zL9btdz=A@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4391265678188767086=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4391265678188767086==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Kojima-san

On Fri, Oct 27, 2023 at 04:26:50PM +0900, Masahisa Kojima wrote:
> Hi Ilias,
>=20
> On Wed, 18 Oct 2023 at 20:35, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Kojima-san,
> >
> > I found some time to do some extended testing here's what I found
> >
> > Switching the permissions from RO->RW when the supplicant is started works
> > correctly
> > # mount | grep efiv
> > efivarfs on /sys/firmware/efi/efivars type efivarfs (ro,nosuid,nodev,noex=
ec,relatime)
> > # tee-supplicant -d
> > [   77.374878] efivars: Unregistered efivars operations
> > [   77.381604] Use tee-based EFI runtime variable services
> > [   77.386862] efivars: Registered efivars operations
> > # mount | grep efiv
> > efivarfs on /sys/firmware/efi/efivars type efivarfs (rw,nosuid,nodev,noex=
ec,relatime)
> > I didn't test unbinding yet, but I assume it's going to work fine and
> > remove the efivar ops.
> >
> > Reading an writing non-authenticated EFI variables seems to work fine.
> > I verified this with U-Boot and the BootOrder changed correctly.
> > # efibootmgr -o 0001,0002,0000
> > BootCurrent: 0002
> > BootOrder: 0001,0002,0000
> > Boot0000* nvme 0:1
> > Boot0001* nvme 0:2
> > Boot0002* debian
> > # efibootmgr -o 0002,0000,0001
> > BootCurrent: 0002
> > BootOrder: 0002,0000,0001
> > Boot0000* nvme 0:1
> > Boot0001* nvme 0:2
> > Boot0002* debian
> >
> > Writing authenticated EFI variables works the first time.
> > I also dumped those variables from both Linux and U-Boot and they matched
> > # efi-updatevar -f PK.auth PK
> > # efi-updatevar -f KEK.auth KEK
> > # efi-updatevar -f db.auth db
> >
> > But removing the PK at runtime fails.
> > # efi-updatevar -f noPK.auth PK
> > # Failed to update PK: Operation not permitted
> > My guess is that the EDK2 code prohibits that, but we need to check why
> > this is happening.  I also got similar failures trying to update KEK and =
db.
>=20
> "# efi-updatevar -f noPK.auth PK" does not reach the kernel efivarfs code.
> With strace, error occurs when efi-updatevar tries to open
> /sys/firmware/efi/efivars/KEK-*** file.
> I guess O_TRUNC option in open() is not required?
>=20
> openat(AT_FDCWD,
> "/sys/firmware/efi/efivars/KEK-8be4df61-93ca-11d2-aa0d-00e098032b8c",
> O_RDWR|O_CREAT|O_TRUNC, 0644) =3D -1 EPERM (Operation not permitted)
> write(2, "Failed to update KEK: ", 22Failed to update KEK: )  =3D 22
> write(2, "Operation not permitted\n", 24Operation not permitted
> ) =3D 24
> exit_group(1)                           =3D ?
> +++ exited with 1 +++
>=20
> We can use "efivar" instead to remove the keys. It also works for KEK and d=
b.
> # efi-updatevar -f PK.auth PK
> # efi-updatevar -f noPK.auth PK     <--- it does not work
> # efivar -w -n 8be4df61-93ca-11d2-aa0d-00e098032b8c-PK -f noPK.auth
> <--- it works

Ok that's fine then.  Thanks for verifying it=20

>=20
> >
> > But the most worrying thing is this. From Linux program KEK and db
> > # efi-updatevar -f KEK.auth KEK
> > # efi-updatevar -f db.auth db
> >
> > Reboot the machine and U-Boot complains when it tries to populate the
> > runtime vars with:
> > Loading Linux 6.6.0-rc2-00654-g82a013b37495 ...
> > Loading initial ramdisk ...
> > EFI stub: Booting Linux Kernel...
> > EFI stub: Using DTB from configuration table
> > EFI stub: Exiting boot services...
> > Can't populate EFI variables. No runtime variables will be available <-- =
This
>=20
> I could not reproduce this issue.
> I tried the following command then reboot the board. Linux boots fine.
>  # efi-updatevar -f KEK.auth KEK
>  # efi-updatevar -f db.auth db
>=20
> I also enroll the PK, then UEFI secure boot works.
> Signed grub and signed kernel boot in UEFI secure boot enabled.
>=20
> Are there any additional steps to reproduce?

We discussed this offline, and this is not a driver bug indeed.  It's
linked to how u-boot populates runtime variables.  When SHIM gets in the
mix it adds a bunch of volatile RT variables.  The runtime memory that
u-boot uses to store these variables is a Kconfig options, so it's just a
matter of bumping that size.

Thanks
/Ilias
>=20
> Thanks,
> Masahisa Kojima
>=20
> >
> > If you rewrite those vars from the U-Boot shell everything seems to come
> > back to normal
> > =3D> tftp  $loadaddr 192.168.49.5:noKEK.auth && setenv -e -nv -bs -rt -at=
 -i $loadaddr:$filesize KEK
> > =3D> tftp  $loadaddr 192.168.49.5:nodb.auth && setenv -e -nv -bs -rt -at =
-i $loadaddr:$filesize db
> > =3D> tftp  $loadaddr 192.168.49.5:KEK.auth && setenv -e -nv -bs -rt -at -=
i $loadaddr:$filesize KEK
> > =3D> tftp  $loadaddr 192.168.49.5:db.auth && setenv -e -nv -bs -rt -at -i=
 $loadaddr:$filesize db
> >
> > Loading Linux 6.6.0-rc2-00654-g82a013b37495 ...
> > Loading initial ramdisk ...
> > EFI stub: Booting Linux Kernel...
> > EFI stub: Using DTB from configuration table
> > EFI stub: Exiting boot services...
> >
> > Let me know if you need any more information
> >
> > Regards
> > /Ilias
> > On Fri, Oct 13, 2023 at 04:45:33PM +0900, Masahisa Kojima wrote:
> > > This series introduces the tee based EFI Runtime Variable Service.
> > >
> > > The eMMC device is typically owned by the non-secure world(linux in
> > > this case). There is an existing solution utilizing eMMC RPMB partition
> > > for EFI Variables, it is implemented by interacting with
> > > OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
> > > and tee-supplicant. The last piece is the tee-based variable access
> > > driver to interact with OP-TEE and StandaloneMM.
> > >
> > > Changelog:
> > > v8 -> v9
> > > - patch #6 "tee: optee: restore efivars ops when tee-supplicant stops"
> > >   is newly added
> > > - remove !EFI_VARS_PSTORE Kconfig dependency, we have added a non-block=
ing
> > >   set_variable and it just returns EFI_UNSUPPORTED.
> > > - remove obvious comments
> > >
> > > v7 -> v8
> > > Only patch #3 "efi: Add tee-based EFI variable driver" is updated.
> > > - fix typos
> > > - refactor error handling, direct return if applicable
> > > - use devm_add_action_or_reset() for closing of tee context/session
> > > - remove obvious comment
> > >
> > > v6 -> v7
> > > Patch #1-#4 are not updated.
> > > Patch #5 is added into this series, original patch is here:
> > > https://lore.kernel.org/all/20230609094532.562934-1-ilias.apalodimas(a)=
linaro.org/
> > >
> > > There are two issues in the v6 series and v7 series addresses those.
> > >
> > > 1) efivar ops is not restored when the tee-supplicant daemon terminates.
> > >  -> As the following patch says, user must remove the device before
> > >     terminating tee-supplicant daemon.
> > >     https://lore.kernel.org/all/20230728134832.326467-1-sumit.garg(a)li=
naro.org/
> > >
> > > 2) cause panic when someone remounts the efivarfs as RW even if
> > > SetVariable is not supported
> > >  -> The fifth patch addresses this issue.
> > >    "[PATCH v7 5/5] efivarfs: force RO when remounting if SetVariable is
> > >     not supported"
> > >
> > > v5 -> v6
> > > - new patch #4 is added in this series, #1-#3 patches are unchanged.
> > >   automatically update super block flag when the efivarops support
> > >   SetVariable runtime service, so that user does not need to manually
> > >   remount the efivarfs as RW.
> > >
> > > v4 -> v5
> > > - rebase to efi-next based on v6.4-rc1
> > > - set generic_ops.query_variable_info, it works as expected as follows.
> > > $ df -h /sys/firmware/efi/efivars/
> > > Filesystem      Size  Used Avail Use% Mounted on
> > > efivarfs         16K  1.3K   15K   8% /sys/firmware/efi/efivars
> > >
> > > v3 -> v4:
> > > - replace the reference from EDK2 to PI Specification
> > > - remove EDK2 source code reference comments
> > > - prepare nonblocking variant of set_variable, it just returns
> > >   EFI_UNSUPPORTED
> > > - remove redundant buffer size check
> > > - argument name change in mm_communicate
> > > - function interface changes in setup_mm_hdr to remove (void **) cast
> > >
> > > v2 -> v3:
> > > - add CONFIG_EFI dependency to TEE_STMM_EFI
> > > - add missing return code check for tee_client_invoke_func()
> > > - directly call efivars_register/unregister from tee_stmm_efi.c
> > >
> > > rfc v1 -> v2:
> > > - split patch into three patches, one for drivers/tee,
> > >   one for include/linux/efi.h, and one for the driver/firmware/efi/stmm
> > > - context/session management into probe() and remove() same as other tee
> > > client driver
> > > - StMM variable driver is moved from driver/tee/optee to driver/firmwar=
e/efi
> > > - use "tee" prefix instead of "optee" in driver/firmware/efi/stmm/tee_s=
tmm_efi.c,
> > >   this file does not contain op-tee specific code, abstracted by tee la=
yer and
> > >   StMM variable driver will work on other tee implementation.
> > > - PTA_STMM_CMD_COMMUNICATE -> PTA_STMM_CMD_COMMUNICATE
> > > - implement query_variable_store() but currently not used
> > > - no use of TEEC_SUCCESS, it is defined in driver/tee/optee/optee_priva=
te.h.
> > >   Other tee client drivers use 0 instead of using TEEC_SUCCESS
> > > - remove TEEC_ERROR_EXCESS_DATA status, it is referred just to output
> > > error message
> > >
> > > Ilias Apalodimas (1):
> > >   efivarfs: force RO when remounting if SetVariable is not supported
> > >
> > > Masahisa Kojima (5):
> > >   efi: expose efivar generic ops register function
> > >   efi: Add EFI_ACCESS_DENIED status code
> > >   efi: Add tee-based EFI variable driver
> > >   efivarfs: automatically update super block flag
> > >   tee: optee: restore efivars ops when tee-supplicant stops
> > >
> > >  drivers/firmware/efi/Kconfig                 |  15 +
> > >  drivers/firmware/efi/Makefile                |   1 +
> > >  drivers/firmware/efi/efi.c                   |  18 +
> > >  drivers/firmware/efi/stmm/mm_communication.h | 236 +++++++
> > >  drivers/firmware/efi/stmm/tee_stmm_efi.c     | 617 +++++++++++++++++++
> > >  drivers/firmware/efi/vars.c                  |   8 +
> > >  drivers/tee/optee/supp.c                     |   4 +
> > >  fs/efivarfs/super.c                          |  45 ++
> > >  include/linux/efi.h                          |  13 +
> > >  9 files changed, 957 insertions(+)
> > >  create mode 100644 drivers/firmware/efi/stmm/mm_communication.h
> > >  create mode 100644 drivers/firmware/efi/stmm/tee_stmm_efi.c
> > >
> > >
> > > base-commit: b691118f2c44d16b84fc65b8147b33620eb18cac
> > > --
> > > 2.30.2
> > >

--===============4391265678188767086==--

