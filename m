From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v8 1/4] KEYS: trusted: Add generic trusted keys framework
Date: Mon, 15 Feb 2021 18:45:37 +0530
Message-ID: 
 <CAFA6WYPrNPMZFA+u0fMo8T1DBFxu6XAVC4KySP53BarjDhfBQA@mail.gmail.com>
In-Reply-To: <YCQRPo0o6MZ0pcUa@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1305813956489116065=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1305813956489116065==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Feb 2021 at 22:30, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Tue, Nov 03, 2020 at 09:31:43PM +0530, Sumit Garg wrote:
> > +     case Opt_new:
> > +             key_len =3D payload->key_len;
> > +             ret =3D static_call(trusted_key_get_random)(payload->key,
> > +                                                       key_len);
> > +             if (ret !=3D key_len) {
> > +                     pr_info("trusted_key: key_create failed (%d)\n", re=
t);
> > +                     goto out;
> > +             }
>
> This repeats a regression in existing code, i.e. does not check
> "ret < 0" condition. I noticed this now when I rebased the code
> on top of my fixes.
>
> I.e. it's fixed in my master branch, which caused a merge conflict,
> and I found this.
>

Okay, I will rebase the next version to your master branch.

-Sumit

> /Jarkko

--===============1305813956489116065==--

