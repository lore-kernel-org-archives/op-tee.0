From: Finn Thain <fthain@telegraphics.com.au>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [Intel-wired-lan] [PATCH 000/141] Fix fall-through warnings for Clang
Date: Thu, 26 Nov 2020 11:30:36 +1100
Message-ID: <alpine.LNX.2.23.453.2011261031290.6@nippy.intranet>
In-Reply-To: <
 <CAKwvOdna5Zj_O=sB7Q0jHZX0BJSaakX=ZyftwQ_3=L3-ZB54XQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1815981347798410493=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1815981347798410493==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On Wed, 25 Nov 2020, Nick Desaulniers wrote:

> On Wed, Nov 25, 2020 at 1:33 PM Finn Thain <fthain@telegraphics.com.au> w=
rote:
> >
> > Or do you think that a codebase can somehow satisfy multiple checkers=20
> > and their divergent interpretations of the language spec?
>=20
> Have we found any cases yet that are divergent? I don't think so.=20

You mean, aside from -Wimplicit-fallthrough? I'm glad you asked. How about=20
-Wincompatible-pointer-types and -Wframe-larger-than?

All of the following files have been affected by divergent diagnostics=20
produced by clang and gcc.

arch/arm64/include/asm/neon-intrinsics.h
arch/powerpc/xmon/Makefile
drivers/gpu/drm/i915/Makefile
drivers/gpu/drm/i915/i915_utils.h
drivers/staging/media/atomisp/pci/atomisp_subdev.c
fs/ext4/super.c
include/trace/events/qla.h
net/mac80211/rate.c
tools/lib/string.c
tools/perf/util/setup.py
tools/scripts/Makefile.include

And if I searched for 'smatch' or 'coverity' instead of 'clang' I'd=20
probably find more divergence.

Here are some of the relevant commits.

0738c8b5915c7eaf1e6007b441008e8f3b460443
9c87156cce5a63735d1218f0096a65c50a7a32aa
babaab2f473817f173a2d08e410c25abf5ed0f6b
065e5e559555e2f100bc95792a8ef1b609bbe130
93f56de259376d7e4fff2b2d104082e1fa66e237
6c4798d3f08b81c2c52936b10e0fa872590c96ae
b7a313d84e853049062011d78cb04b6decd12f5c
093b75ef5995ea35d7f6bdb6c7b32a42a1999813

And before you object, "but -Wconstant-logical-operand is a clang-only=20
warning! it can't be divergent with gcc!", consider that the special cases=20
added to deal with clang-only warnings have to be removed when gcc catches=20
up, which is more churn. Now multiply that by the number of checkers you=20
care about.

--===============1815981347798410493==--

