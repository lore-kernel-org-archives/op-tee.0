From: Ruth Glushkin <rutigl@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: tpm2 device fail on u-boot
Date: Thu, 17 Aug 2023 13:13:35 +0300
Message-ID: 
 <CALDRwioqPLFxr7Js+a4_FNhTA=hPJc0h6uJ5n-Z-PtFr2VMJyg@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYP1_pECXuP9_rBP-dR2EkUC72enb=-rad7iffBedsbvzQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0755684016340741735=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0755684016340741735==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Thank you very much, Sumit.

I should find a way to provision eMMC RPMB partition with our HUK.

With full respect,
Margarita

2023-08-17 13:06 GMT+03:00, Sumit Garg <sumit.garg@linaro.org>:
> On Mon, 14 Aug 2023 at 13:23, Ruth Glushkin <rutigl@gmail.com> wrote:
>>
>> Hi,
>> I have u-boot based on u-boot 2021.04
>> I have configuration with fTPM of Microsoft enabled.
>> I have a EVB board with Nuvoton chip.
>> OPTee-OS is based on latest 3.22 upstream version with Nuvoton npcm
>> platform configuration.
>> If I take OPTee-OS without reading HUK from our PCR0 field from
>> non-secured memory,
>> the command works fine.
>> If I add reading HUK, the command fails.
>
> The likely reason for this behaviour is that your eMMC RPMB partition
> is already provisioned using a key derived from default HUK. So later
> on when you update the HUK to be platform specific, all eMMC RPMB
> accesses are going to fail as the key changed. Now it will only work
> with default HUK as corresponding derived key has been provisioned
> into eMMC RPMB.
>
> Please go through this doc [1] carefully before provisioning the eMMC RPMB
> key.
>
> [1]
> https://optee.readthedocs.io/en/latest/architecture/secure_storage.html?hig=
hlight=3DRPMB#security-considerations
>
> -Sumit
>
>> Here is the error log:
>> -
>> U-Boot>tpm2 device
>> optee optee: OP-TEE: revision 3.22 (a012b992)
>> I/TC: Reserved shared memory is enabled
>> I/TC: Dynamic shared memory is enabled
>> I/TC: Normal World virtualization support is disabled
>> I/TC: Asynchronous notifications are disabled
>> E/TC:0 0 std_entry_with_parg:235 Bad arg address 0x7fce2000
>> Couldn't set TPM 0 (rc =3D 1)
>> -
>>
>> All other commands of tpm2 that are not connected to fTPM works OK.
>> After loading Linux, xtest works OK.
>>
>> Could you please help me?
>>
>> Thank you in advance,
>> Margarita Glushkin
>

--===============0755684016340741735==--

