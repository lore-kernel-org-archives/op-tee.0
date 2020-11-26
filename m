From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 000/141] Fix fall-through warnings for Clang
Date: Thu, 26 Nov 2020 18:05:45 +0100
Message-ID: 
 <CANiq72=n4rVvmKt0RCb5aOfQydA8bgDxfntRLDieV8Q2efP8Zg@mail.gmail.com>
In-Reply-To: <
 <CAMuHMdV5kOakvZJMWLxbpigFPS+Xuw6DVYsWCWZy7wGsv3idcw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5697574128193329475=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5697574128193329475==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2020 at 4:28 PM Geert Uytterhoeven <geert@linux-m68k.org> w=
rote:
>
> The maintainer is not necessarily the owner/author of the code, and
> thus may not know the intent of the code.

Agreed, I was not blaming maintainers -- just trying to point out that
the problem is there :-)

In those cases, it is still very useful: we add the `fallthrough` and
a comment saying `FIXME: fallthrough intended? Figure this out...`.
Thus a previous unknown unknown is now a known unknown. And no new
unknown unknowns will be introduced since we enabled the warning
globally.

> BTW, you cannot mindlessly fix the latter, as you cannot know if
> "(a =3D=3D b)" or "((a =3D b))" was intended, without understanding the code
> (and the (possibly unavailable) data sheet, and the hardware, ...).

That's right, I was referring to the cases where the compiler saves
someone time from a typo they just made.

Cheers,
Miguel

--===============5697574128193329475==--

