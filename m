From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 2/3] mmc: block: register RPMB partition with the RPMB
 subsystem
Date: Tue, 09 Apr 2024 14:01:10 +0200
Message-ID: 
 <CAHUa44GozpaRSC4oNiGCG1Myv+GE8bvk6aHS0q1ecQwW-YMMUA@mail.gmail.com>
In-Reply-To: <
 <CACRpkdYLCuRKZRqRUkav7UoT+0FSaMmciH9bps3VGgxLCw6+_g@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3565800580076779740=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3565800580076779740==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Mon, Apr 8, 2024 at 11:07=E2=80=AFAM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> Hi Jens,
>
> On Fri, Apr 5, 2024 at 1:53=E2=80=AFPM Jens Wiklander <jens.wiklander@lin=
aro.org> wrote:
>
> > +/**
> > + * struct rpmb_frame - rpmb frame as defined by specs
>
> As Tomas said maybe we can write the name of the spec or the number or
> something so users can find it?
>
> I would also write explicitly "the stuff bytes and big-endian properties are
> modeled to fit to the spec".

That makes sense, I'll add it.

Thanks,
Jens

>
> Yours,
> Linus Walleij

--===============3565800580076779740==--

