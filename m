From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 0/3] introduce tee-based EFI Runtime Variable Service
Date: Wed, 24 May 2023 11:00:21 +0300
Message-ID: 
 <CAC_iWjKxXrEgpqgnpt8g0ummdb1mFbwgMVTSVqfRTNbXOwhz2w@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYOOEwd=jWk1LEaj9K2GkjfV+kfPYOfwPkJVoWXJKGoQXA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8309319755453853937=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8309319755453853937==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Sumit,

On Wed, 24 May 2023 at 10:56, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Tue, 23 May 2023 at 14:36, Masahisa Kojima
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
> > v3 -> v4:
> > - replace the reference from EDK2 to PI Specification
> > - remove EDK2 source code reference comments
> > - prepare nonblocking variant of set_variable, it just returns
> >   EFI_UNSUPPORTED
> > - remove redundant buffer size check
> > - argument name change in mm_communicate
> > - function interface changes in setup_mm_hdr to remove (void **) cast
>
> I don't have detailed insights into how EFI spec mandates StandaloneMM
> should be implemented. But utilizing OP-TEE as the underlying
> transport here looks fine to me. FWIW,
>
> For the series:
> Acked-by: Sumit Garg <sumit.garg@linaro.org>

Thanks!

 FWIW the PI spec describes some of the functionality and how that
should be accessed.
There's a EFI_MM_COMMUNICATION_PROTOCOL which is not used here.
Instead the entry point is via an SMC to op-tee and the payload
adheres to what the PI spec describes in its EFI_MM_COMMUNICATE_HEADER

Regards
/Ilias
>
> -Sumit
>
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
> >  drivers/firmware/efi/stmm/tee_stmm_efi.c     | 637 +++++++++++++++++++
> >  include/linux/efi.h                          |   4 +
> >  6 files changed, 905 insertions(+)
> >  create mode 100644 drivers/firmware/efi/stmm/mm_communication.h
> >  create mode 100644 drivers/firmware/efi/stmm/tee_stmm_efi.c
> >
> > --
> > 2.30.2
> >

--===============8309319755453853937==--

