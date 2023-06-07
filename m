From: Jan Kiszka <jan.kiszka@siemens.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v5 3/3] efi: Add tee-based EFI variable driver
Date: Wed, 07 Jun 2023 19:46:15 +0000
Message-ID: <871ece13-7d6e-44d4-3bda-317658202f6f@siemens.com>
In-Reply-To: <
 <CAC_iWj+cP4RfDNu_n-ZOp7A62W34drLpPszN_hrkqF_aPTLtMg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5841797536844635052=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5841797536844635052==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 07.06.23 20:17, Ilias Apalodimas wrote:
> On Wed, 7 Jun 2023 at 20:14, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 07.06.23 18:59, Ilias Apalodimas wrote:
>>> On Wed, 7 Jun 2023 at 19:09, Ilias Apalodimas
>>> <ilias.apalodimas@linaro.org> wrote:
>>>>
>>>> Hi Jan,
>>>>
>>>> [...]
>>>>>>>> No I don't, this will work reliably without the need to remount the =
efivarfs.
>>>>>>>> As you point out you will still have this dependency if you end up
>>>>>>>> building them as modules and you manage to mount the efivarfs before
>>>>>>>> those get inserted.  Does anyone see a reasonable workaround?
>>>>>>>> Deceiving the kernel and making the bootloader set the RT property b=
it
>>>>>>>> to force the filesystem being mounted as rw is a nasty hack that we
>>>>>>>> should avoid.  Maybe adding a kernel command line parameter that says
>>>>>>>> "Ignore the RTPROP I know what I am doing"?  I don't particularly lo=
ve
>>>>>>>> this either, but it's not unreasonable.
>>>>>>>
>>>>>>> In the context of https://github.com/OP-TEE/optee_os/issues/6094,
>>>>>>> basically this issue mapped on reboot/shutdown, I would really love to
>>>>>>> see the unhandy tee-supplicant daemon to be overcome.
>>>>>>
>>>>>> I have seen this error before and it has been on my todo list. So I
>>>>>> have tried to fix it here [1]. Feel free to test it and let me know if
>>>>>> you see any further issues.
>>>>>>
>>>>>> [1] https://lkml.org/lkml/2023/6/7/927
>>>>>>
>>>>>
>>>>> Ah, nice, will test ASAP!
>>>>>
>>>>> Meanwhile more food: I managed to build a firmware that was missing
>>>>> STMM. But the driver loaded, and I got this:
>>>>
>>>> Thanks for the testing. I'll try to reproduce it locally and get back to=
 you
>>>
>>> Can you provide a bit more info on how that was triggered btw? I would
>>> be helpful to know
>>>
>>> - OP-TEE version
>>
>> Today's master, 145953d55.
>>
>>> - was it compiled as a module or built-in?
>>
>> Sorry, not sure anymore, switching back and forth right now. I think it
>> was built-in.
>>
>>> - was the supplicant running?
>>
>> Yes.
>>
>=20
> Ok thanks, that helps.  I guess this also means U-Boot was compiled to
> store the variables in a file in the ESP instead of the RPMB right?
> Otherwise, I can't see how the device booted in the first place.

U-Boot was not configured to perform secure booting in this case. It had
RPMB support enabled, just didn't have to use it.

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


--===============5841797536844635052==--

