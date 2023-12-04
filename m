From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: optee: os: toolchains would include linux target macros likes __linux__
Date: Mon, 04 Dec 2023 17:34:10 +0100
Message-ID: 
 <CAHUa44FEkdtA+4AuoQnNEnObKzcUX3qkFD8iV8Z_pGJ7ZPWw2A@mail.gmail.com>
In-Reply-To: <bfba8d2c-646d-4d62-9f71-8e388e70f782@soulik.info>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8930268645734130431=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8930268645734130431==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Randy,

On Mon, Dec 4, 2023 at 2:39=E2=80=AFPM Randy Li <ayaka@soulik.info> wrote:
>
> Hello
>
> I wonder why Optee OS would use a linux target toolchains but not a bare
> metal target(none os)?

I guess it started with that we didn't want to download both one Linux
and one bare metal toolchain. We need both AArch32 and AArch64
versions so it doubles up.

>
> gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu/bin/aarch64-none-linux-g=
nu-gcc
> -dM -E - < /dev/null|grep linux
> #define __linux 1
> #define __gnu_linux__ 1
> #define linux 1
> #define __linux__ 1
>
> That makes hard to share a header files between Linux kernel and Optee.
> We like to pass some structure in SHM, but optee don't have all those
> Linux types likes <linux/types.h>.

Surely you can define a .h file in a way that you can include it in
both environments. We try to stick to ISO C.

>
> If optee didn't choose the toolchains for the Linux, we could easily
> decide which part would use for Client Agent(Linux kernel) side or TEE
> OS side.
>
> Why we don't use bare metal toolchains ?

Feel free to do so.

Cheers,
Jens

--===============8930268645734130431==--

