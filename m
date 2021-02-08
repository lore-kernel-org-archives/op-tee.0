From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] optee: simplify i2c access
Date: Mon, 08 Feb 2021 09:54:34 +0100
Message-ID: 
 <CAHUa44GUagcWJYyYw9EdaH0E2QjWVAR+iQN10dq_t0uPf+58uA@mail.gmail.com>
In-Reply-To: <20210208083250.GB27508@trex>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0356317400599534545=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0356317400599534545==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 8, 2021 at 9:32 AM Jorge Ramirez-Ortiz, Foundries
<jorge@foundries.io> wrote:
>
> On 08/02/21, Jorge Ramirez-Ortiz, Foundries wrote:
> > On 08/02/21, Jens Wiklander wrote:
> > > Hi Jorge,
> > >
> > > On Wed, Jan 27, 2021 at 11:41 AM Jens Wiklander
> > > <jens.wiklander@linaro.org> wrote:
> > > >
> > > > Hi Arnd,
> > > >
> > > > On Mon, Jan 25, 2021 at 12:38 PM Arnd Bergmann <arnd@kernel.org> wr=
ote:
> > > > >
> > > > > From: Arnd Bergmann <arnd@arndb.de>
> > > > >
> > > > > Storing a bogus i2c_client structure on the stack adds overhead and
> > > > > causes a compile-time warning:
> > > > >
> > > > > drivers/tee/optee/rpc.c:493:6: error: stack frame size of 1056 byte=
s in function 'optee_handle_rpc' [-Werror,-Wframe-larger-than=3D]
> > > > > void optee_handle_rpc(struct tee_context *ctx, struct optee_rpc_par=
am *param,
> > > > >
> > > > > Change the implementation of handle_rpc_func_cmd_i2c_transfer() to
> > > > > open-code the i2c_transfer() call, which makes it easier to read
> > > > > and avoids the warning.
> > > > >
> > > > > Fixes: c05210ab9757 ("drivers: optee: allow op-tee to access device=
s on the i2c bus")
> > > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > > > ---
> > > > >  drivers/tee/optee/rpc.c | 31 ++++++++++++++++---------------
> > > > >  1 file changed, 16 insertions(+), 15 deletions(-)
> > > >
> > > > Looks good to me.
> > > > Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
> > >
> > > Would you mind testing this?
> >
> > sure, doing it this morning.
> >
> > btw what Arnd has done - removing the unnecessary level of indirection
> > - was pretty much my initial though but I thought it was easier to
> > read the way I wrote it (I guess I was wrong and I obviously missed
> > the stack size increase)
> >
> > but yes, will test
>
> Tested on imx6ull.
>
> Tested-by: Jorge Ramirez-Ortiz <jorge@foundries.io>

Thank you.

Cheers,
Jens

--===============0356317400599534545==--

