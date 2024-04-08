From: Linus Walleij <linus.walleij@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 2/3] mmc: block: register RPMB partition with the RPMB
 subsystem
Date: Mon, 08 Apr 2024 11:07:25 +0200
Message-ID: 
 <CACRpkdYLCuRKZRqRUkav7UoT+0FSaMmciH9bps3VGgxLCw6+_g@mail.gmail.com>
In-Reply-To: <20240405115318.904143-3-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4260953791448448240=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4260953791448448240==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On Fri, Apr 5, 2024 at 1:53=E2=80=AFPM Jens Wiklander <jens.wiklander@linar=
o.org> wrote:

> +/**
> + * struct rpmb_frame - rpmb frame as defined by specs

As Tomas said maybe we can write the name of the spec or the number or
something so users can find it?

I would also write explicitly "the stuff bytes and big-endian properties are
modeled to fit to the spec".

Yours,
Linus Walleij

--===============4260953791448448240==--

