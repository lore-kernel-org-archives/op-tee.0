From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Conflict with "fallthrough" define
Date: Thu, 03 Apr 2025 10:25:56 +0200
Message-ID: 
 <CAHUa44F_EEmub2Sj1xHYdVG9wz29Bj05jCB1VFDLG4vqZoxYHA@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3CGV2PR02MB8920DD8FE701332DC2B7FE098AAF2=40GV2PR02MB?=
 =?utf-8?q?8920=2Eeurprd02=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1689160239371999630=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1689160239371999630==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 2, 2025 at 8:21=E2=80=AFPM Jacob Kroon <Jacob.Kroon@axis.com> w=
rote:
>
> Hi,
>
> We are using OP-TEE together with a library that provides its own "fallthro=
ugh" define, similar to what OP-TEE does in lib/libutils/ext/include/compiler=
.h:
>
> #define fallthrough __attribute__((__fallthrough__))
>
> However, this other library checks for fallthrough attribute support by fir=
st doing:
>
> #if __has_cpp_attribute(fallthrough)
> ...
> #endif
>
> which fails to compile due to the OP-TEE define.
>
> Would OP-TEE accept a patch to rename the "fallthrough" define to something=
 like "optee_fallthrough", "FALLTHROUGH", <other suggestion> ?

No, the name should stay "fallthrough". We may accept an extra check
to see how and if it should be defined, but the result should be a
usable "fallthrough" macro after <compiler.h> has been included.

>
> Or should we upstream a patch to the library to do:
>
> #if __has_cpp_attribute(__fallthrough__)
> ...
> #endif

It seems like at least some change will be needed in that library.

Cheers,
Jens

>
> (which is what OP-TEE currently does)
>
> Regards
> Jacob

--===============1689160239371999630==--

