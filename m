From: Jan Kiszka <jan.kiszka@siemens.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v8 0/5] introduce tee-based EFI Runtime Variable Service
Date: Mon, 14 Aug 2023 17:23:35 +0000
Message-ID: <660cec45-d0d1-433f-b58e-a22a07a289fb@siemens.com>
In-Reply-To: <
 <CAC_iWjLU+mVtG4uGVoEJSJwuE0=GVcfJgi=h3QX54=fh2P4EAg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6165881847544402573=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6165881847544402573==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 14.08.23 11:24, Ilias Apalodimas wrote:
> Hi Jan,
>=20
> On Mon, 7 Aug 2023 at 05:53, Masahisa Kojima <masahisa.kojima@linaro.org>=
 wrote:
>>
>> This series introduces the tee based EFI Runtime Variable Service.
>>
>> The eMMC device is typically owned by the non-secure world(linux in
>> this case). There is an existing solution utilizing eMMC RPMB partition
>> for EFI Variables, it is implemented by interacting with
>> OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
>> and tee-supplicant. The last piece is the tee-based variable access
>> driver to interact with OP-TEE and StandaloneMM.
>>
>> Changelog:
>> v7 -> v8
>> Only patch #3 "efi: Add tee-based EFI variable driver" is updated.
>> - fix typos
>> - refactor error handling, direct return if applicable
>> - use devm_add_action_or_reset() for closing of tee context/session
>> - remove obvious comment
>=20
> Any chance you can run this and see if it solves your issues?
>=20

I also need [1], and I still need a cleanup script before terminating
the tee-supplicant, right? And if need some service in the initrd
already, I still need to start the supplicant there and transfer its
ownership to systemd later on? These patches here only make life easier
if the supplicant is started by systemd, after efivarfs has been
mounted, correct?

Jan

[1] https://lkml.org/lkml/2023/7/28/853

--=20
Siemens AG, Technology
Linux Expert Center


--===============6165881847544402573==--

