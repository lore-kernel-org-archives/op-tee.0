From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH] optee: Add __init/__exit annotations to module init/exit funcs
Date: Tue, 11 Oct 2022 11:44:12 +0200
Message-ID: 
 <CAHUa44G3jDS5TSeHtMt3O_oNeHB=JY_04EjQHm6Snjo8umfDqw@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYM9c5aAMNnidUFz3dwfoxBmUaSEadGO-Tb2zLtq1+ha+Q@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6163459829978391497=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6163459829978391497==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 26, 2022 at 9:24 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Sat, 24 Sept 2022 at 15:02, Xiu Jianfeng <xiujianfeng@huawei.com> wrot=
e:
> >
> > Add missing __init/__exit annotations to module init/exit funcs.
> >
> > Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> > ---
> >  drivers/tee/optee/core.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

I'm picking up this.

Thanks,
Jens

>
> -Sumit
>
> > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > index daf07737c4fd..2a258bd3b6b5 100644
> > --- a/drivers/tee/optee/core.c
> > +++ b/drivers/tee/optee/core.c
> > @@ -188,7 +188,7 @@ void optee_remove_common(struct optee *optee)
> >  static int smc_abi_rc;
> >  static int ffa_abi_rc;
> >
> > -static int optee_core_init(void)
> > +static int __init optee_core_init(void)
> >  {
> >         /*
> >          * The kernel may have crashed at the same time that all available
> > @@ -210,7 +210,7 @@ static int optee_core_init(void)
> >  }
> >  module_init(optee_core_init);
> >
> > -static void optee_core_exit(void)
> > +static void __exit optee_core_exit(void)
> >  {
> >         if (!smc_abi_rc)
> >                 optee_smc_abi_unregister();
> > --
> > 2.17.1
> >

--===============6163459829978391497==--

