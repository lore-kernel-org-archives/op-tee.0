From: Jan Kiszka <jan.kiszka@siemens.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v5 3/3] efi: Add tee-based EFI variable driver
Date: Wed, 07 Jun 2023 17:14:35 +0000
Message-ID: <b9b8c1d3-fc8e-df94-d12b-a9e3debf3418@siemens.com>
In-Reply-To: <
 <CAC_iWjJMv68yLC606SBhMmBYkR4wVC8SvUcPvNM=RX_qL=9Bvw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1386820985592914148=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1386820985592914148==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 07.06.23 18:59, Ilias Apalodimas wrote:
> On Wed, 7 Jun 2023 at 19:09, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
>>
>> Hi Jan,
>>
>> [...]
>>>>>> No I don't, this will work reliably without the need to remount the ef=
ivarfs.
>>>>>> As you point out you will still have this dependency if you end up
>>>>>> building them as modules and you manage to mount the efivarfs before
>>>>>> those get inserted.  Does anyone see a reasonable workaround?
>>>>>> Deceiving the kernel and making the bootloader set the RT property bit
>>>>>> to force the filesystem being mounted as rw is a nasty hack that we
>>>>>> should avoid.  Maybe adding a kernel command line parameter that says
>>>>>> "Ignore the RTPROP I know what I am doing"?  I don't particularly love
>>>>>> this either, but it's not unreasonable.
>>>>>
>>>>> In the context of https://github.com/OP-TEE/optee_os/issues/6094,
>>>>> basically this issue mapped on reboot/shutdown, I would really love to
>>>>> see the unhandy tee-supplicant daemon to be overcome.
>>>>
>>>> I have seen this error before and it has been on my todo list. So I
>>>> have tried to fix it here [1]. Feel free to test it and let me know if
>>>> you see any further issues.
>>>>
>>>> [1] https://lkml.org/lkml/2023/6/7/927
>>>>
>>>
>>> Ah, nice, will test ASAP!
>>>
>>> Meanwhile more food: I managed to build a firmware that was missing
>>> STMM. But the driver loaded, and I got this:
>>
>> Thanks for the testing. I'll try to reproduce it locally and get back to y=
ou
>=20
> Can you provide a bit more info on how that was triggered btw? I would
> be helpful to know
>=20
> - OP-TEE version

Today's master, 145953d55.

> - was it compiled as a module or built-in?

Sorry, not sure anymore, switching back and forth right now. I think it
was built-in.

> - was the supplicant running?

Yes.

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


--===============1386820985592914148==--

