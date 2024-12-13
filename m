From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Using EFI variables stored in RPMB
Date: Fri, 13 Dec 2024 15:23:56 +0200
Message-ID: 
 <CAC_iWjLxXKHxqi+7gPBT_QhhjUFp3xBQrjWvQqt9=3+HPC6Xuw@mail.gmail.com>
In-Reply-To: <
 <CA+DkFDYEvjcg-TUa46Bb9+p-TcLjgw5GOCo=4h1QbxfQXJp51Q@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2634975210806603230=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2634975210806603230==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, 13 Dec 2024 at 14:41, Patryk <pbiel7@gmail.com> wrote:
>
> Hi,
> Thanks Ilias
> > The RPMB support is only plugged in for EFI variables.
> > You can find more information here [0] [1]
> >
> > [0] https://www.linaro.org/blog/protected-uefi-variables-with-u-boot/
> > [1] https://www.linaro.org/blog/uefi-secureboot-in-u-boot/
> I've read your really good articles and actually used them as a base
> for my research and experiments. I'm also aware that the RPMB
> currently works with EFI variables. My point is (maybe not clearly
> expressed before) - would it make sense from your perspective to use
> RPMB together with OPTEE also as a storage for non EFI variables?
> I've
> done some research and it seems not to be that hard, we already have
> optee_rpmb read/write u-boot shell commands that work in similar way,
> so we could just plug in the underlying mechanism to the u-boot's env
> subsystem. I thought about creating such an implementation (at least
> POC) that uses RPMB through OPTEE (similarly like in case of EFI but
> without StMM) to store non EFI, U-BOOT variables. I think it could be
> useful as it would provide more secure storage for u-boot env
> variables that could be used in non UEFI use cases. I'm asking because
> I might not see the whole picture, and my assumptions could be wrong.
> So, I thought I would ask someone more involved before diving in. The
> whole idea arose from the discussion in my team about storing u-boot
> writable env variables in some more secure way without having to use
> UEFI (at least for now).
> Will be grateful for some response.

It depends on the use case really.
The usual practice right now to protect env variables is built-in
variables and disable. So if a chain of trust verifies U-Boot you also
implicitly verify the variables.
Using the RPMB would be a good way to ensure no one tampered with env
variables outside U-Boot, but how do you expect to update them? If you
enable the command line that defeats the purpose as anyone can update
them. So I guess you are thinking of verified scripts that changes
those?

I think the u-boot ML is a better place for such a discussion


Thanks
Ilias
>
> Best regards
> Patryk

--===============2634975210806603230==--

