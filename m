From: Jan Kiszka <jan.kiszka@siemens.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v5 3/3] efi: Add tee-based EFI variable driver
Date: Fri, 09 Jun 2023 06:16:50 +0000
Message-ID: <e0c71d88-ec5d-a348-0a53-ec6cea298b60@siemens.com>
In-Reply-To: <
 <CAMj1kXGbXdbDr6DbyuziSFuxMgAimjNnkhqy8C-S5AbxdnixuQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6581999590491375401=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6581999590491375401==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 08.06.23 15:52, Ard Biesheuvel wrote:
> On Thu, 8 Jun 2023 at 08:22, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
>>
>> Hi Jan
>>
>>
>> On Wed, 7 Jun 2023 at 22:46, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>
>>> On 07.06.23 20:17, Ilias Apalodimas wrote:
>>>> On Wed, 7 Jun 2023 at 20:14, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>>
>>>>> On 07.06.23 18:59, Ilias Apalodimas wrote:
>>>>>> On Wed, 7 Jun 2023 at 19:09, Ilias Apalodimas
>>>>>> <ilias.apalodimas@linaro.org> wrote:
>>>>>>>
>>>>>>> Hi Jan,
>>>>>>>
>>>>>>> [...]
>>>>>>>>>>> No I don't, this will work reliably without the need to remount t=
he efivarfs.
>>>>>>>>>>> As you point out you will still have this dependency if you end up
>>>>>>>>>>> building them as modules and you manage to mount the efivarfs bef=
ore
>>>>>>>>>>> those get inserted.  Does anyone see a reasonable workaround?
>>>>>>>>>>> Deceiving the kernel and making the bootloader set the RT propert=
y bit
>>>>>>>>>>> to force the filesystem being mounted as rw is a nasty hack that =
we
>>>>>>>>>>> should avoid.  Maybe adding a kernel command line parameter that =
says
>>>>>>>>>>> "Ignore the RTPROP I know what I am doing"?  I don't particularly=
 love
>>>>>>>>>>> this either, but it's not unreasonable.
>>>>>>>>>>
>>>>>>>>>> In the context of https://github.com/OP-TEE/optee_os/issues/6094,
>>>>>>>>>> basically this issue mapped on reboot/shutdown, I would really lov=
e to
>>>>>>>>>> see the unhandy tee-supplicant daemon to be overcome.
>>>>>>>>>
>>>>>>>>> I have seen this error before and it has been on my todo list. So I
>>>>>>>>> have tried to fix it here [1]. Feel free to test it and let me know=
 if
>>>>>>>>> you see any further issues.
>>>>>>>>>
>>>>>>>>> [1] https://lkml.org/lkml/2023/6/7/927
>>>>>>>>>
>>>>>>>>
>>>>>>>> Ah, nice, will test ASAP!
>>>>>>>>
>>>>>>>> Meanwhile more food: I managed to build a firmware that was missing
>>>>>>>> STMM. But the driver loaded, and I got this:
>>>>>>>
>>>>>>> Thanks for the testing. I'll try to reproduce it locally and get back=
 to you
>>>>>>
>>>>>> Can you provide a bit more info on how that was triggered btw? I would
>>>>>> be helpful to know
>>>>>>
>>>>>> - OP-TEE version
>>>>>
>>>>> Today's master, 145953d55.
>>>>>
>>>>>> - was it compiled as a module or built-in?
>>>>>
>>>>> Sorry, not sure anymore, switching back and forth right now. I think it
>>>>> was built-in.
>>>>>
>>>>>> - was the supplicant running?
>>>>>
>>>>> Yes.
>>>>>
>>>>
>>>> Ok thanks, that helps.  I guess this also means U-Boot was compiled to
>>>> store the variables in a file in the ESP instead of the RPMB right?
>>>> Otherwise, I can't see how the device booted in the first place.
>>>
>>> U-Boot was not configured to perform secure booting in this case. It had
>>> RPMB support enabled, just didn't have to use it.
>>
>> In your initial mail you said you managed to build a firmware without
>> StMM.  If U-boot isn't reconfigured accordingly -- iow skip the EFI
>> variable storage in an RPMB, the EFI subsystem will fail to start.
>>
>> In any case, I don't think the ooops you are seeing is not connected
>> to this patchset.  Looking at the kernel EFI stub we only set the
>> SetVariableRT if the RTPROP table is set accordingly by the firmware.
>> U-Boot never sets the EFI_RT_SUPPORTED_SET_VARIABLE property since it
>> can't support it.  What you are doing is remount the efivarfs as rw
>> and then trying to set a variable, but the callback for it is  NULL.
>> I think you'll be able to replicate the same behavior on the kernel
>> without even inserting the new module.

Might be true. I'll try to look into that again when the other dust settled.

>=20
> I have dropped this series from efi/next for now, given that it
> obviously has problems in its current state.
>=20
> The risk of merging this now and fixing it later is that it may cause
> regressions for early adopters that rely on the behavior we are
> introducing here. Better to get this in shape first.

On the one side, I'm sorry having ruined the merge, but my gut feeling
is as well that this really needs to be reworked to get rid of the
unfortunate tee-supplicant daemon. So far, we have to start the daemon
from initrd, write a systemd service to adopt that instance, and make
ftpm modular to remove it before terminating tee-supplicant (e.g. on
system shutdown) - Sumit's patch didn't help there.

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


--===============6581999590491375401==--

