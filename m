From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [Intel-wired-lan] [PATCH 000/141] Fix fall-through warnings for Clang
Date: Wed, 25 Nov 2020 02:05:49 +0100
Message-ID: 
 <CANiq72m2kGxSy2E9jgYE4_xRV6h9rFqiJP25KXs_5ObYnH_nmA@mail.gmail.com>
In-Reply-To: <alpine.LNX.2.23.453.2011251022550.14@nippy.intranet>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4185637817549962586=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4185637817549962586==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2020 at 12:53 AM Finn Thain <fthain@telegraphics.com.au> wr=
ote:
>
> I'm saying that supporting the official language spec makes more sense
> than attempting to support a multitude of divergent interpretations of the
> spec (i.e. gcc, clang, coverity etc.)

Making the kernel strictly conforming is a ship that sailed long ago,
for several reasons. Anyway, supporting several compilers and other
tools, regardless of extensions, is valuable.

> I'm also saying that the reason why we use -std=3Dgnu89 is that existing
> code was written in that language, not in ad hoc languages comprised of
> collections of extensions that change with every release.

No, we aren't particularly tied to `gnu89` or anything like that. We
could actually go for `gnu11` already, since the minimum GCC and Clang
support it. Even if a bit of code needs fixing, that shouldn't be a
problem if someone puts the work.

In other words, the kernel code is not frozen, nor are the features it
uses from compilers. They do, in fact, change from time to time.

> Thank you for checking. I found a free version that's only 6 weeks old:

You're welcome! There are quite a few new attributes coming, mostly
following C++ ones.

> It will be interesting to see whether 6.7.11.5 changes once the various
> implementations reach agreement.

Not sure what you mean. The standard does not evolve through
implementations' agreement (although standardizing existing practice
is one of the best arguments to back a change).

Cheers,
Miguel

--===============4185637817549962586==--

