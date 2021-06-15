From: Florian Fainelli <f.fainelli@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v5 0/8] tee: Improve support for kexec and kdump
Date: Tue, 15 Jun 2021 07:15:58 -0700
Message-ID: <944c1df8-3e9f-0026-c83c-d778f42fa1b3@gmail.com>
In-Reply-To: <20210615133734.GY4910@sequoia>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1700815372789537888=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1700815372789537888==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 6/15/2021 6:37 AM, Tyler Hicks wrote:
> On 2021-06-15 09:23:25, Jens Wiklander wrote:
>> It looks like we're almost done now. Thanks for your patience to see
>> this through.
>>
>> I suppose it makes most sense to take this via my tree, but before I
>> can do that I'll need acks from the maintainers of
>> drivers/char/tpm/tpm_ftpm_tee.c ("tpm_ftpm_tee: Free and unregister
>> TEE shared memory during kexec") and
>> drivers/firmware/broadcom/tee_bnxt_fw.c ("firmware: tee_bnxt: Release
>> TEE shm, session, and context during kexec").
>=20
> @Rafa=C5=82 Mi=C5=82ecki, we just need an ack from you for the tee_bnxt_fw.c
> change:
>=20
>  https://lore.kernel.org/lkml/20210614223317.999867-9-tyhicks(a)linux.micro=
soft.com/

Rafal is listed as the maintainer of drivers/firmware/broadcom/ but he
did not author that file, Vikas did, adding him.
--=20
Florian

--===============1700815372789537888==--

