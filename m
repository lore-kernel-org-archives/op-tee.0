From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 RE: [PATCH v3 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
Date: Tue, 05 Mar 2024 12:54:09 +0000
Message-ID: <PH7PR11MB7605493349915A168A80CDD8E5222@PH7PR11MB7605.namprd11.prod.outlook.com>
In-Reply-To: <
 <CACRpkdbhhZ9+Jy_tvWy1RSnyZMjqUhh0ARpS+WRtgWTH3AYCPw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1337012129605101371=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1337012129605101371==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


>=20
> Hi Jens,
>=20
> I realized there is one thing I wonder about:
>=20
> On Tue, Feb 27, 2024 at 4:31=E2=80=AFPM Jens Wiklander <jens.wiklander@li=
naro.org>
> wrote:
>=20
> > +struct rpmb_frame {
> > +       u8     stuff[196];
> > +       u8     key_mac[32];
> > +       u8     data[256];
> > +       u8     nonce[16];
> > +       __be32 write_counter;
> > +       __be16 addr;
> > +       __be16 block_count;
> > +       __be16 result;
> > +       __be16 req_resp;
> > +} __packed;
>=20
> I didn't quite get why these things are encoded big-endian?


By the spec.

>=20
> As on the producer side (the eMMC backend) it seems we are anyway calling
> cpu_to_be* to convert them into this format.
>=20
> If this is a requirement on the consumer side (such as TEE) I think the
> consumer should swap the bytes rather than the producer, but I guess that
> kind of assumes that we foresee there will be other consumers in the first
> place.
>=20
This is end 2 end.=20

> Yours,
> Linus Walleij

--===============1337012129605101371==--

