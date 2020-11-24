From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [Intel-wired-lan] [PATCH 000/141] Fix fall-through warnings for Clang
Date: Wed, 25 Nov 2020 00:15:54 +0100
Message-ID: 
 <CANiq72nUt57u5DG9rH=DB0DzQH7U6-QbG-2Ou+PyCY=p=_Ggag@mail.gmail.com>
In-Reply-To: <alpine.LNX.2.23.453.2011250859290.15@nippy.intranet>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2509917307570276540=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2509917307570276540==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2020 at 11:24 PM Finn Thain <fthain@telegraphics.com.au> wr=
ote:
>
> These statements are not "missing" unless you presume that code written
> before the latest de facto language spec was written should somehow be
> held to that spec.

There is no "language spec" the kernel adheres to. Even if it did,
kernel code is not frozen. If an improvement is found, it should be
applied.

> If the 'fallthrough' statement is not part of the latest draft spec then
> we should ask why not before we embrace it. Being that the kernel still
> prefers -std=3Dgnu89 you might want to consider what has prevented
> -std=3Dgnu99 or -std=3Dgnu2x etc.

The C standard has nothing to do with this. We use compiler extensions
of several kinds, for many years. Even discounting those extensions,
the kernel is not even conforming to C due to e.g. strict aliasing. I
am not sure what you are trying to argue here.

But, since you insist: yes, the `fallthrough` attribute is in the
current C2x draft.

Cheers,
Miguel

--===============2509917307570276540==--

