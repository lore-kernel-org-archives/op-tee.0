From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v9 0/6] introduce tee-based EFI Runtime Variable Service
Date: Fri, 27 Oct 2023 16:06:04 +0300
Message-ID: 
 <CAC_iWjLQPL1a8Zu38+98PgDO8mGzZ=WzCaQxab9bZDrRJNTL7g@mail.gmail.com>
In-Reply-To: <
 <CADQ0-X8fEUw2pkeWRKGsYs8cNfDnyM=ibj9emZ5Q0zL9btdz=A@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8927414184923959070=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8927414184923959070==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Kojima-san,

Thanks for looking into this

On Fri, 27 Oct 2023 at 10:27, Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> Hi Ilias,
>
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
>
> "# efi-updatevar -f noPK.auth PK" does not reach the kernel efivarfs code.
> With strace, error occurs when efi-updatevar tries to open
> /sys/firmware/efi/efivars/KEK-*** file.
> I guess O_TRUNC option in open() is not required?
>
> openat(AT_FDCWD,
> "/sys/firmware/efi/efivars/KEK-8be4df61-93ca-11d2-aa0d-00e098032b8c",
> O_RDWR|O_CREAT|O_TRUNC, 0644) =3D -1 EPERM (Operation not permitted)
> write(2, "Failed to update KEK: ", 22Failed to update KEK: )  =3D 22
> write(2, "Operation not permitted\n", 24Operation not permitted
> ) =3D 24
> exit_group(1)                           =3D ?
> +++ exited with 1 +++
>
> We can use "efivar" instead to remove the keys. It also works for KEK and d=
b.
> # efi-updatevar -f PK.auth PK
> # efi-updatevar -f noPK.auth PK     <--- it does not work
> # efivar -w -n 8be4df61-93ca-11d2-aa0d-00e098032b8c-PK -f noPK.auth
> <--- it works

Ok, that's fine then

>
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
>
> I could not reproduce this issue.
> I tried the following command then reboot the board. Linux boots fine.
>  # efi-updatevar -f KEK.auth KEK
>  # efi-updatevar -f db.auth db
>
> I also enroll the PK, then UEFI secure boot works.
> Signed grub and signed kernel boot in UEFI secure boot enabled.
>
> Are there any additional steps to reproduce?

Hmm, how big is that db? I think I have 2 signatures in mine, a custom
one and the MS one.
Can you test again with these certs [0]

[...]

[0] https://gitlab.com/Linaro/trustedsubstrate/meta-ts/-/blob/master/meta-tru=
stedsubstrate/uefi-certificates/uefi_certs.tgz?ref_type=3Dheads

Thanks
/Ilias

--===============8927414184923959070==--

