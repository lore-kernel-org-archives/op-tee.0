From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [RFC PATCH 0/2] introduce op-tee based EFI Runtime Variable Service
Date: Thu, 02 Feb 2023 17:35:49 +0530
Message-ID: 
 <CAFA6WYMdTxkcFkSux7F3fwxx2OqHP9UzqbWxdGnxuzjNU75PxA@mail.gmail.com>
In-Reply-To: <20230126132120.1661-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6685473323838424406=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6685473323838424406==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Masahisa,

On Thu, 26 Jan 2023 at 18:52, Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> This RFC series introduces the op-tee based EFI Runtime Variable
> Service.
>
> The eMMC device is typically owned by the non-secure world(linux in
> this case). There is an existing solution utilizing eMMC RPMB partition
> for EFI Variables, it is implemented by interacting with
> OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
> and tee-supplicant. The last piece is the tee-based variable access
> driver to interact with OP-TEE and StandaloneMM.
>

After an overall look at the APIs, following are some initial comments:
- Is there any reason to have the edk2 specific StandaloneMM stack in
Linux to communicate with OP-TEE pseudo TA?
- I think the OP-TEE pseudo TA should be able to expose a rather
generic invoke commands such as:
     TEE_EFI_GET_VARIABLE
     TEE_EFI_GET_NEXT_VARIABLE
     TEE_EFI_SET_VARIABLE
  So it should no longer be tied to StMM stack and other TEE
implementations can re-use the abstracted interface to communicate
with its corresponding secure storage TA.

-Sumit

> Masahisa Kojima (2):
>   efi: expose efivar generic ops register function
>   tee: Add op-tee helper functions for variable access
>
>  drivers/firmware/efi/efi.c           |  12 +
>  drivers/tee/optee/Kconfig            |  10 +
>  drivers/tee/optee/Makefile           |   1 +
>  drivers/tee/optee/mm_communication.h | 249 +++++++++++
>  drivers/tee/optee/optee_private.h    |   5 +-
>  drivers/tee/optee/optee_stmm_efi.c   | 598 +++++++++++++++++++++++++++
>  drivers/tee/tee_core.c               |  23 ++
>  include/linux/efi.h                  |   4 +
>  include/linux/tee_drv.h              |  23 ++
>  9 files changed, 924 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/tee/optee/mm_communication.h
>  create mode 100644 drivers/tee/optee/optee_stmm_efi.c
>
> --
> 2.30.2
>

--===============6685473323838424406==--

