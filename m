From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Using EFI variables stored in RPMB
Date: Fri, 13 Dec 2024 13:25:15 +0200
Message-ID: 
 <CAC_iWjLb2zRcN0iLnsvTFtbhLtMu4K5gVBieo_hSpyH4s48V_w@mail.gmail.com>
In-Reply-To: <
 <CA+DkFDaRDRbMiUP7ArzSmoEksP_TtpOmjYQ_3yjTVBXH1BaRSA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2785276267896426814=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2785276267896426814==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Patryk

On Thu, 12 Dec 2024 at 13:37, Patryk <pbiel7@gmail.com> wrote:
>
> Hi, not sure if this is a good place to ask, however I see that OPTEE
> developers are highly involved in this topic so I decided to ask.

It is. FWIW this is a project Jens and I mostly worked on.

> Short background - we've been working on an embedded system based on
> Layerscape 1028A SoC. On this platform we've been using TFA (bl2, el3
> runtime services), OPTEE as BL32 and u-boot as BL33. In the previous,
> older platforms we usually stored u-boot's environment in let's say
> "traditional way", we just stored the env on some offset of the eMMC
> device, however I see that on this particular, new platform there are
> some better possibilities, like combining OPTEE, EDKII StandaloneMM
> and u-boot efivars implementation to store EFI variables in RPMB on
> eMMC which seems to be more secure, UEFI compliant way. The aspect I'm
> unsure of is - does it make sense to utilize these capabilities if we
> want to only use it to store some u-boot's writable env variables and
> not utilize features like UEFI SecureBoot (at least for now, it may
> change it in the future)?

The RPMB support is only plugged in for EFI variables.
You can find more information here [0] [1]

[0] https://www.linaro.org/blog/protected-uefi-variables-with-u-boot/
[1] https://www.linaro.org/blog/uefi-secureboot-in-u-boot/

Regards
/Ilias


>
> I would be grateful for some advice.
>
> Best regards
> Patryk

--===============2785276267896426814==--

