From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] optee: add missing description of RPC argument reference
Date: Wed, 08 Nov 2023 08:54:28 +0100
Message-ID: 
 <CAHUa44G2=tVXTqJxSx_bBf22FDp2LVBP1zk2bzGp+EvcUkTUrQ@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYO4m5n9oTzP1zJdJXASCwXdhVaa_tMN2EhDTNDMmxwaJg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5384063528653585317=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5384063528653585317==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 10:06=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
>
> On Mon, 30 Oct 2023 at 14:25, Etienne Carriere
> <etienne.carriere@foss.st.com> wrote:
> >
> > Adds missing inline description comment for RPC optional arguments
> > reference.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/lkml/202310192021.fvb6JDOY-lkp(a)intel.co=
m/
> > Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
> > ---
> >  drivers/tee/optee/smc_abi.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

I'm picking up this.

Thanks,
Jens

>
> -Sumit
>
> > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> > index d5b28fd35d66..67bfa25d6302 100644
> > --- a/drivers/tee/optee/smc_abi.c
> > +++ b/drivers/tee/optee/smc_abi.c
> > @@ -806,6 +806,7 @@ static void handle_rpc_func_cmd(struct tee_context *c=
tx, struct optee *optee,
> >  /**
> >   * optee_handle_rpc() - handle RPC from secure world
> >   * @ctx:       context doing the RPC
> > + * @rpc_arg:   pointer to RPC arguments if any, or NULL if none
> >   * @param:     value of registers for the RPC
> >   * @call_ctx:  call context. Preserved during one OP-TEE invocation
> >   *
> > --
> > 2.25.1
> >

--===============5384063528653585317==--

