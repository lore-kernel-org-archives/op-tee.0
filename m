From: Jan Kiszka <jan.kiszka@siemens.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v6 0/4] introduce tee-based EFI Runtime Variable Service
Date: Thu, 22 Jun 2023 14:56:58 +0000
Message-ID: <8ce9f761-347d-1e8c-17d7-241d88c82451@siemens.com>
In-Reply-To: <20230622085112.1521-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2817065129196165300=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2817065129196165300==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On 22.06.23 10:51, Masahisa Kojima wrote:
> This series introduces the tee based EFI Runtime Variable Service.
> 
> The eMMC device is typically owned by the non-secure world(linux in
> this case). There is an existing solution utilizing eMMC RPMB partition
> for EFI Variables, it is implemented by interacting with
> OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
> and tee-supplicant. The last piece is the tee-based variable access
> driver to interact with OP-TEE and StandaloneMM.
> 
> Changelog:
> v5 -> v6
> - new patch #4 is added in this series, #1-#3 patches are unchanged.
>   automatically update super block flag when the efivarops support
>   SetVariable runtime service, so that user does not need to manually
>   remount the efivarfs as RW.

But that is not yet resolving the architectural problem with that
userspace daemon dependency. What are the next steps for that now?

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


--===============2817065129196165300==--

