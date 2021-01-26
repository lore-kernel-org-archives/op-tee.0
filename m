From: Arnd Bergmann <arnd@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] optee: simplify i2c access
Date: Tue, 26 Jan 2021 10:10:16 +0100
Message-ID: 
 <CAK8P3a09stVcEr9xBOLbkw7ZtzdZpP_pqE4wYRzBoC70c3h1eA@mail.gmail.com>
In-Reply-To: <20210126080827.GA26654@trex>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0898870153373434294=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0898870153373434294==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 26, 2021 at 9:08 AM Jorge Ramirez-Ortiz, Foundries
<jorge@foundries.io> wrote:
>
> On 25/01/21, Arnd Bergmann wrote:
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
>
> does fixing stack-frame compile warnings need a 'fixes' tag?

The fixes tag only describes which commit introduced the bug, it is irrelevant
what type of bug this is.

      Arnd

--===============0898870153373434294==--

