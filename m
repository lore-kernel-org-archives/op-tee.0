From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Why UBSAN is marked as using a lot of memory?
Date: Fri, 09 Feb 2024 12:33:10 +0100
Message-ID: 
 <CAHUa44Fjrc5yVm+zrfkXkN-5Ja85iTmm6WCDcgRELc=L8S8mCQ@mail.gmail.com>
In-Reply-To: <
 <CAEUiM9Mow2oL1UTti9F0EOA-1KqgLrAS63TptCfFWgrVCKhi0A@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1798833126982956176=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1798833126982956176==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Igor,

On Mon, Feb 5, 2024 at 5:45=E2=80=AFPM Igor Zhbanov <izh1979@gmail.com> wro=
te:
>
> J=C3=A9r=C3=B4me, thanks.
>
> =D0=BF=D0=BD, 5 =D1=84=D0=B5=D0=B2=D1=80. 2024=E2=80=AF=D0=B3. =D0=B2 17:22=
, J=C3=A9r=C3=B4me Forissier <jerome.forissier@linaro.org>:
>
> > I don't know, but the latest info about USBSAN is that it fails to build
> > on the master branch so I can't even try it and check the memory usage :-/
> >
> > See https://github.com/OP-TEE/optee_os/issues/6463.
> >
>
> I was curious, how UBSAN is affecting the Linux kernel, so, I've built
> openSUSE kernel
> on x86_64 with the default distribution configuration, then checked the
> sized of the stripped
> files vmlinux and vmlinux.o.
>
> # CONFIG_UBSAN is not set:
> vmlinux   48 237 768
> vmlinux.o 31 664 696
>
> CONFIG_UBSAN=3Dy
> # CONFIG_UBSAN_TRAP is not set
> CONFIG_CC_HAS_UBSAN_BOUNDS_STRICT=3Dy
> CONFIG_UBSAN_BOUNDS=3Dy
> CONFIG_UBSAN_BOUNDS_STRICT=3Dy
> CONFIG_UBSAN_SHIFT=3Dy
> CONFIG_UBSAN_DIV_ZERO=3Dy
> CONFIG_UBSAN_BOOL=3Dy
> CONFIG_UBSAN_ENUM=3Dy
> CONFIG_UBSAN_ALIGNMENT=3Dy
> CONFIG_UBSAN_SANITIZE_ALL=3Dy
> vmlinux   96 472 264 (+48 234 496,  +99.99%)
> vmlinux.o 79 215 456 (+47 550 760, +150.17%)
>
> In this case the kernel is twice as big because of disabled
> CONFIG_UBSAN_TRAP option,
> which enables (when the option is disabled) printing verbose error location
> information.
> Also, pointer alignment is enabled. Of course, such a big overhead is not
> acceptable
> in production.
>
> However, without CONFIG_UBSAN_ALIGNMENT=3Dy, the numbers are much more
> optimistic:
>
> CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=3Dy
> CONFIG_UBSAN=3Dy
> # CONFIG_UBSAN_TRAP is not set
> CONFIG_CC_HAS_UBSAN_BOUNDS_STRICT=3Dy
> CONFIG_UBSAN_BOUNDS=3Dy
> CONFIG_UBSAN_BOUNDS_STRICT=3Dy
> CONFIG_UBSAN_SHIFT=3Dy
> CONFIG_UBSAN_DIV_ZERO=3Dy
> CONFIG_UBSAN_BOOL=3Dy
> CONFIG_UBSAN_ENUM=3Dy
> # CONFIG_UBSAN_ALIGNMENT is not set
> CONFIG_UBSAN_SANITIZE_ALL=3Dy
> vmlinux   50334920 (+2 097 152, +4.35%)
> vmlinux.o 34402408 (+2 737 712, +8.65%)
>
> And the overhead is even smaller, when CONFIG_UBSAN_TRAP=3Dy is enabled,
> which results in wordless oopses in the case of error:
>
> CONFIG_UBSAN=3Dy
> CONFIG_UBSAN_TRAP=3Dy
> CONFIG_CC_HAS_UBSAN_BOUNDS_STRICT=3Dy
> CONFIG_UBSAN_BOUNDS=3Dy
> CONFIG_UBSAN_BOUNDS_STRICT=3Dy
> CONFIG_UBSAN_SHIFT=3Dy
> CONFIG_UBSAN_DIV_ZERO=3Dy
> CONFIG_UBSAN_BOOL=3Dy
> CONFIG_UBSAN_ENUM=3Dy
> # CONFIG_UBSAN_ALIGNMENT is not set
> CONFIG_UBSAN_SANITIZE_ALL=3Dy
> vmlinux   48 237 768 (      +0, +0.00%)
> vmlinux.o 32 004 392 (+339 696, +1.07%)
>
> In this case the overhead is neglectable, compared to the overall kernel
> size. (And the final
> kernel image is even of the same size for some unknown reason.)
>
> Since pointers alignment sanitizing for some reason is incompatible with
> CONFIG_UBSAN_TRAP=3Dy, I can't test them together.
>
> So, I suppose that the overhead for OP-TEE should also be small, as there
> is no detailed
> error logging. But, of course, it is better to be tested.

I guess that depends on what you mean by detailed, it prints file
name, line, and column when logging.

Cheers,
Jens

--===============1798833126982956176==--

