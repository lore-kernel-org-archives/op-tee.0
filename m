From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 000/141] Fix fall-through warnings for Clang
Date: Mon, 23 Nov 2020 15:05:31 +0100
Message-ID: 
 <CANiq72=z+tmuey9wj3Kk7wX5s0hTHpsQdLhAqcOVNrHon6xn5Q@mail.gmail.com>
In-Reply-To: <alpine.LNX.2.23.453.2011230938390.7@nippy.intranet>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5594553197365453008=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5594553197365453008==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 22, 2020 at 11:54 PM Finn Thain <fthain@telegraphics.com.au> wr=
ote:
>
> We should also take into account optimisim about future improvements in
> tooling.

Not sure what you mean here. There is no reliable way to guess what
the intention was with a missing fallthrough, even if you parsed
whitespace and indentation.

> It is if you want to spin it that way.

How is that a "spin"? It is a fact that we won't get *implicit*
fallthrough mistakes anymore (in particular if we make it a hard
error).

> But what we inevitably get is changes like this:
>
>  case 3:
>         this();
> +       break;
>  case 4:
>         hmmm();
>
> Why? Mainly to silence the compiler. Also because the patch author argued
> successfully that they had found a theoretical bug, often in mature code.

If someone changes control flow, that is on them. Every kernel
developer knows what `break` does.

> But is anyone keeping score of the regressions? If unreported bugs count,
> what about unreported regressions?

Introducing `fallthrough` does not change semantics. If you are really
keen, you can always compare the objects because the generated code
shouldn't change.

Cheers,
Miguel

--===============5594553197365453008==--

