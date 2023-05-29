From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v5 0/3] introduce tee-based EFI Runtime Variable Service
Date: Mon, 29 May 2023 11:05:21 +0200
Message-ID: 
 <CAHUa44EcVtMRp-894vQdHkNpnowvsKEQMZbr=axOJPig9zFhqQ@mail.gmail.com>
In-Reply-To: <
 <CAMj1kXEN0naaKAzGKBsJaL7LKa_4b+iP=g9YLcBK8qxZxy1C-A@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2393149833189504639=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2393149833189504639==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2023 at 3:10=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> On Fri, 26 May 2023 at 03:08, Masahisa Kojima
> <masahisa.kojima@linaro.org> wrote:
> >
> > This series introduces the tee based EFI Runtime Variable Service.
> >
> > The eMMC device is typically owned by the non-secure world(linux in
> > this case). There is an existing solution utilizing eMMC RPMB partition
> > for EFI Variables, it is implemented by interacting with
> > OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
> > and tee-supplicant. The last piece is the tee-based variable access
> > driver to interact with OP-TEE and StandaloneMM.
> >
> > Changelog:
> > v4 -> v5
> > - rebase to efi-next based on v6.4-rc1
> > - set generic_ops.query_variable_info, it works as expected as follows.
> > $ df -h /sys/firmware/efi/efivars/
> > Filesystem      Size  Used Avail Use% Mounted on
> > efivarfs         16K  1.3K   15K   8% /sys/firmware/efi/efivars
>
> Excellent, thanks a lot for double checking that.
>
> Jens, did you have any feedback on this? If not, I intend to queue it
> up for v6.5

Looks good to me.

Thanks,
Jens

>
> Thanks,
>
> >
> > v3 -> v4:
> > - replace the reference from EDK2 to PI Specification
> > - remove EDK2 source code reference comments
> > - prepare nonblocking variant of set_variable, it just returns
> >   EFI_UNSUPPORTED
> > - remove redundant buffer size check
> > - argument name change in mm_communicate
> > - function interface changes in setup_mm_hdr to remove (void **) cast
> >
> > v2 -> v3:
> > - add CONFIG_EFI dependency to TEE_STMM_EFI
> > - add missing return code check for tee_client_invoke_func()
> > - directly call efivars_register/unregister from tee_stmm_efi.c
> >
> > rfc v1 -> v2:
> > - split patch into three patches, one for drivers/tee,
> >   one for include/linux/efi.h, and one for the driver/firmware/efi/stmm
> > - context/session management into probe() and remove() same as other tee
> > client driver
> > - StMM variable driver is moved from driver/tee/optee to driver/firmware/=
efi
> > - use "tee" prefix instead of "optee" in driver/firmware/efi/stmm/tee_stm=
m_efi.c,
> >   this file does not contain op-tee specific code, abstracted by tee laye=
r and
> >   StMM variable driver will work on other tee implementation.
> > - PTA_STMM_CMD_COMMUNICATE -> PTA_STMM_CMD_COMMUNICATE
> > - implement query_variable_store() but currently not used
> > - no use of TEEC_SUCCESS, it is defined in driver/tee/optee/optee_private=
.h.
> >   Other tee client drivers use 0 instead of using TEEC_SUCCESS
> > - remove TEEC_ERROR_EXCESS_DATA status, it is referred just to output
> > error message
> >
> > Masahisa Kojima (3):
> >   efi: expose efivar generic ops register function
> >   efi: Add EFI_ACCESS_DENIED status code
> >   efi: Add tee-based EFI variable driver
> >
> >  drivers/firmware/efi/Kconfig                 |  15 +
> >  drivers/firmware/efi/Makefile                |   1 +
> >  drivers/firmware/efi/efi.c                   |  12 +
> >  drivers/firmware/efi/stmm/mm_communication.h | 236 +++++++
> >  drivers/firmware/efi/stmm/tee_stmm_efi.c     | 638 +++++++++++++++++++
> >  include/linux/efi.h                          |   4 +
> >  6 files changed, 906 insertions(+)
> >  create mode 100644 drivers/firmware/efi/stmm/mm_communication.h
> >  create mode 100644 drivers/firmware/efi/stmm/tee_stmm_efi.c
> >
> > --
> > 2.30.2
> >

--===============2393149833189504639==--

