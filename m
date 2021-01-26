From: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] optee: simplify i2c access
Date: Tue, 26 Jan 2021 12:45:07 +0100
Message-ID: <20210126114507.GA9282@trex>
In-Reply-To: <
 <CAK8P3a09stVcEr9xBOLbkw7ZtzdZpP_pqE4wYRzBoC70c3h1eA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7799076872492636479=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7799076872492636479==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 26/01/21, Arnd Bergmann wrote:
> On Tue, Jan 26, 2021 at 9:08 AM Jorge Ramirez-Ortiz, Foundries
> <jorge@foundries.io> wrote:
> >
> > On 25/01/21, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > Storing a bogus i2c_client structure on the stack adds overhead and
> > > causes a compile-time warning:
> > >
> > > drivers/tee/optee/rpc.c:493:6: error: stack frame size of 1056 bytes in=
 function 'optee_handle_rpc' [-Werror,-Wframe-larger-than=3D]
> > > void optee_handle_rpc(struct tee_context *ctx, struct optee_rpc_param *=
param,
> > >
> > > Change the implementation of handle_rpc_func_cmd_i2c_transfer() to
> > > open-code the i2c_transfer() call, which makes it easier to read
> > > and avoids the warning.
> > >
> > > Fixes: c05210ab9757 ("drivers: optee: allow op-tee to access devices on=
 the i2c bus")
> >
> > does fixing stack-frame compile warnings need a 'fixes' tag?
>=20
> The fixes tag only describes which commit introduced the bug, it is irrelev=
ant
> what type of bug this is.
>=20
>       Arnd

thanks Arnd.

what compiler warnings are defined as kernel bugs? is there a list
that you use when tracking these?

--===============7799076872492636479==--

