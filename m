From: Linus Walleij <linus.walleij@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v3 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
Date: Tue, 05 Mar 2024 15:16:34 +0100
Message-ID: 
 <CACRpkdaOnbUmk1q_BBWkPYGriNHfZBUmGxtH+sQmw6U0rxicMg@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3CPH7PR11MB7605493349915A168A80CDD8E5222=40PH7PR11MB?=
 =?utf-8?q?7605=2Enamprd11=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0740706194722330082=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0740706194722330082==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 1:54=E2=80=AFPM Winkler, Tomas <tomas.winkler@intel.=
com> wrote:

> > On Tue, Feb 27, 2024 at 4:31=E2=80=AFPM Jens Wiklander <jens.wiklander@=
linaro.org>
> > wrote:
> >
> > > +struct rpmb_frame {
> > > +       u8     stuff[196];
> > > +       u8     key_mac[32];
> > > +       u8     data[256];
> > > +       u8     nonce[16];
> > > +       __be32 write_counter;
> > > +       __be16 addr;
> > > +       __be16 block_count;
> > > +       __be16 result;
> > > +       __be16 req_resp;
> > > +} __packed;
> >
> > I didn't quite get why these things are encoded big-endian?
>
> By the spec.

So a kerneldoc comment above the struct with a reference to the spec
it is mirroring should be appropriate?

As it stands now it will be misunderstood by people like me as "just some
other Linux struct".

Yours,
Linus Walleij

--===============0740706194722330082==--

