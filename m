From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] optee: simplify i2c access
Date: Mon, 08 Feb 2021 08:00:55 +0100
Message-ID: 
 <CAHUa44Fa4oCjpGQj-52nei1M+KkyxPYBsX5TDmgA3ekRPqg8GQ@mail.gmail.com>
In-Reply-To: <
 <CAHUa44GwSRB=7tFpXi2ZW-SXGipp7ErDkB2_4iGQfyH_ECAU8A@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3796810142386027829=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3796810142386027829==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jorge,

On Wed, Jan 27, 2021 at 11:41 AM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> Hi Arnd,
>
> On Mon, Jan 25, 2021 at 12:38 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > Storing a bogus i2c_client structure on the stack adds overhead and
> > causes a compile-time warning:
> >
> > drivers/tee/optee/rpc.c:493:6: error: stack frame size of 1056 bytes in f=
unction 'optee_handle_rpc' [-Werror,-Wframe-larger-than=3D]
> > void optee_handle_rpc(struct tee_context *ctx, struct optee_rpc_param *pa=
ram,
> >
> > Change the implementation of handle_rpc_func_cmd_i2c_transfer() to
> > open-code the i2c_transfer() call, which makes it easier to read
> > and avoids the warning.
> >
> > Fixes: c05210ab9757 ("drivers: optee: allow op-tee to access devices on t=
he i2c bus")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/tee/optee/rpc.c | 31 ++++++++++++++++---------------
> >  1 file changed, 16 insertions(+), 15 deletions(-)
>
> Looks good to me.
> Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>

Would you mind testing this?

Thanks,
Jens

--===============3796810142386027829==--

