From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Dynamic shared memory
Date: Thu, 21 Nov 2024 14:57:52 +0200
Message-ID: 
 <CAC_iWjLiqAxN=6PmX6LwUSyTA7QGBm7_Ld9h5nbCDC6vBdJVPg@mail.gmail.com>
In-Reply-To: <
 <CA+DkFDbQcBOtD-rgGAoZiy2HZjpCc=Y9FTJPCez2sQzCH0Di8w@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4319681510407431484=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4319681510407431484==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Patryk,

On Thu, 21 Nov 2024 at 14:47, Patryk <pbiel7@gmail.com> wrote:
>
> Hello,
> I've been currently looking at the possibility of storing u-boot
> environment variables in RPMB and I've stumbled upon this article:
> https://www.linaro.org/blog/protected-uefi-variables-with-u-boot/
> which briefly describes what needs to be done in order to achieve
> this.
> Unfortunately there is no comment section in this article so I cannot
> ask the author so I decided to try here.
> The article mentions that for that purpose, my board should support
> dynamic shared memory, therefore the OP-TEE port for my board should
> register that memory in platform main using the "register_ddr"
> function. For my platform (ls1028ardb) I do not see anything like
> this, thus I assume it's not supported. However, I'm wondering - is it
> my platform's hardware limitation or missing software implementation?

A software implementation issue

> Making this question more generic - does dynamic shared memory depend
> on hardware, meaning that there is no way to register dynamic shared
> memory if hardware does not support some particular features?
> I would be grateful for some hints.

You can define all of your available DDR as shared memory. That's
merely a check in OP-TEE for what memory we can use. Someone correct
me if I am wrong but simply defining the entire memory shouldn't be a
problem

Keep in mind that there was a breakage in StMM [0] which hasn't been
fixed yet, so you will need to clone an older version of EDK2 for now


[0] https://lore.kernel.org/linux-efi/CAC_iWj+4G3LG0XpsygS+MYJU9+oPhftOnPAfkO=
nEgn+GgTp2OA(a)mail.gmail.com/T/#m2570bbfce7db3ab29ff5966d18269f49f5161b18

Cheers
/Ilias
>
> Best regards
> Patryk

--===============4319681510407431484==--

