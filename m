From: Patryk <pbiel7@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Using EFI variables stored in RPMB
Date: Fri, 13 Dec 2024 13:41:38 +0100
Message-ID: 
 <CA+DkFDYEvjcg-TUa46Bb9+p-TcLjgw5GOCo=4h1QbxfQXJp51Q@mail.gmail.com>
In-Reply-To: <
 <CAC_iWjLb2zRcN0iLnsvTFtbhLtMu4K5gVBieo_hSpyH4s48V_w@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4331363782938133306=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4331363782938133306==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi,
Thanks Ilias
> The RPMB support is only plugged in for EFI variables.
> You can find more information here [0] [1]
>
> [0] https://www.linaro.org/blog/protected-uefi-variables-with-u-boot/
> [1] https://www.linaro.org/blog/uefi-secureboot-in-u-boot/
I've read your really good articles and actually used them as a base
for my research and experiments. I'm also aware that the RPMB
currently works with EFI variables. My point is (maybe not clearly
expressed before) - would it make sense from your perspective to use
RPMB together with OPTEE also as a storage for non EFI variables? I've
done some research and it seems not to be that hard, we already have
optee_rpmb read/write u-boot shell commands that work in similar way,
so we could just plug in the underlying mechanism to the u-boot's env
subsystem. I thought about creating such an implementation (at least
POC) that uses RPMB through OPTEE (similarly like in case of EFI but
without StMM) to store non EFI, U-BOOT variables. I think it could be
useful as it would provide more secure storage for u-boot env
variables that could be used in non UEFI use cases. I'm asking because
I might not see the whole picture, and my assumptions could be wrong.
So, I thought I would ask someone more involved before diving in. The
whole idea arose from the discussion in my team about storing u-boot
writable env variables in some more secure way without having to use
UEFI (at least for now).
Will be grateful for some response.

Best regards
Patryk

--===============4331363782938133306==--

