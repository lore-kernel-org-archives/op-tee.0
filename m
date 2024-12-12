From: Patryk <pbiel7@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: Using EFI variables stored in RPMB
Date: Thu, 12 Dec 2024 12:36:52 +0100
Message-ID: 
 <CA+DkFDaRDRbMiUP7ArzSmoEksP_TtpOmjYQ_3yjTVBXH1BaRSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8093497514461508967=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8093497514461508967==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi, not sure if this is a good place to ask, however I see that OPTEE
developers are highly involved in this topic so I decided to ask.
Short background - we've been working on an embedded system based on
Layerscape 1028A SoC. On this platform we've been using TFA (bl2, el3
runtime services), OPTEE as BL32 and u-boot as BL33. In the previous,
older platforms we usually stored u-boot's environment in let's say
"traditional way", we just stored the env on some offset of the eMMC
device, however I see that on this particular, new platform there are
some better possibilities, like combining OPTEE, EDKII StandaloneMM
and u-boot efivars implementation to store EFI variables in RPMB on
eMMC which seems to be more secure, UEFI compliant way. The aspect I'm
unsure of is - does it make sense to utilize these capabilities if we
want to only use it to store some u-boot's writable env variables and
not utilize features like UEFI SecureBoot (at least for now, it may
change it in the future)?

I would be grateful for some advice.

Best regards
Patryk

--===============8093497514461508967==--

