From: Nick Desaulniers <ndesaulniers@google.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [Intel-wired-lan] [PATCH 000/141] Fix fall-through warnings for Clang
Date: Wed, 25 Nov 2020 14:09:29 -0800
Message-ID: 
 <CAKwvOdna5Zj_O=sB7Q0jHZX0BJSaakX=ZyftwQ_3=L3-ZB54XQ@mail.gmail.com>
In-Reply-To: <alpine.LNX.2.23.453.2011260750300.6@nippy.intranet>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8058544373473758020=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8058544373473758020==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2020 at 1:33 PM Finn Thain <fthain@telegraphics.com.au> wro=
te:
>
> Or do you think that a codebase can somehow satisfy multiple checkers and
> their divergent interpretations of the language spec?

Have we found any cases yet that are divergent? I don't think so.  It
sounds to me like GCC's cases it warns for is a subset of Clang's.
Having additional coverage with Clang then should ensure coverage for
both.

> > This is not a shiny new warning; it's already on for GCC and has existed
> > in both compilers for multiple releases.
> >
>
> Perhaps you're referring to the compiler feature that lead to the
> ill-fated, tree-wide /* fallthrough */ patch series.
>
> When the ink dries on the C23 language spec and the implementations figure
> out how to interpret it then sure, enforce the warning for new code -- the
> cost/benefit analysis is straight forward. However, the case for patching
> existing mature code is another story.

I don't think we need to wait for the ink to dry on the C23 language
spec to understand that implicit fallthrough is an obvious defect of
the C language.  While the kernel is a mature codebase, it's not
immune to bugs.  And its maturity has yet to slow its rapid pace of
development.
--=20
Thanks,
~Nick Desaulniers

--===============8058544373473758020==--

