From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: smc_abi: Fix use-after-free in optee_smc_open
Date: Tue, 03 Jan 2023 09:07:50 +0100
Message-ID: 
 <CAHUa44HpDg39ohLGV73rgswLxQ4J8RV+iRaGGri6aNqhGZspMQ@mail.gmail.com>
In-Reply-To: <
 <CALQpDLd+eEYv=qkPOoPkRGe5RX2eTgUfj_pp838eDX39Cfke2w@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1241769013126797610=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1241769013126797610==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 2, 2023 at 1:18 AM Yoochan Lee <yoochan1026@gmail.com> wrote:
>
> I fix the errors in the previous patch.
>
> From 2046cc19aeaddb5f6fb5e9b1d9a380a116892657 Mon Sep 17 00:00:00 2001
> From: Yoochan Lee <yoochan1026@gmail.com>
> Date: Mon, 2 Jan 2023 09:18:23 +0900
> Subject: [PATCH 2/2] fix errors in previous patch
>
> ---
>  drivers/tee/optee/smc_abi.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)

Please fix up the original patch and post it as a v2. By the way, have
you tried to test this in some way?

Thanks,
Jens

>
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index 4fbec2acc255..be662f263f29 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -1103,12 +1103,7 @@ static void optee_smc_release_supp(struct
> tee_context *ctx)
>  {
>   struct optee *optee =3D tee_get_drvdata(ctx->teedev);
>
> - optee_release_helper(ctx, optee_close_session_helper);
> - if (optee->scan_bus_wq) {
> - destroy_workqueue(optee->scan_bus_wq);
> - optee->scan_bus_wq =3D NULL;
> - }
> - optee_supp_release(&optee->supp);
> + optee_release_supp(ctx)
>   kref_put(&optee->refcnt, optee_smc_delete);
>  }
>
> @@ -1116,7 +1111,7 @@ static void optee_smc_release(struct tee_context *ctx)
>  {
>   struct optee *optee =3D tee_get_drvdata(ctx->teedev);
>
> - optee_release_helper(ctx, optee_close_session_helper);
> + optee_release(ctx);
>   kref_put(&optee->refcnt, optee_smc_delete);
>  }
>
> --
> 2.39.0
>
> 2023=EB=85=84 1=EC=9B=94 2=EC=9D=BC (=EC=9B=94) =EC=98=A4=EC=A0=84 6:43, ke=
rnel test robot <lkp@intel.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > Hi Yoochan,
> >
> > Thank you for the patch! Yet something to improve:
> >
> > [auto build test ERROR on linus/master]
> > [also build test ERROR on v6.2-rc1 next-20221226]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Yoochan-Lee/tee-op=
tee-smc_abi-Fix-use-after-free-in-optee_smc_open/20221231-132046
> > patch link:    https://lore.kernel.org/r/20221231051954.2038772-1-yoochan=
1026%40gmail.com
> > patch subject: [PATCH] tee: optee: smc_abi: Fix use-after-free in optee_s=
mc_open
> > config: arm-randconfig-c002-20221231
> > compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project f570=
0e7b69048de958172fb513b336564e7f8709)
> > reproduce (this is a W=3D1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install arm cross compiling tool for clang build
> >         # apt-get install binutils-arm-linux-gnueabi
> >         # https://github.com/intel-lab-lkp/linux/commit/6d3d5f78a2463a577=
c1a908cdedda61affba9c01
> >         git remote add linux-review https://github.com/intel-lab-lkp/linux
> >         git fetch --no-tags linux-review Yoochan-Lee/tee-optee-smc_abi-Fi=
x-use-after-free-in-optee_smc_open/20221231-132046
> >         git checkout 6d3d5f78a2463a577c1a908cdedda61affba9c01
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=
=3D1 O=3Dbuild_dir ARCH=3Darm olddefconfig
> >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=
=3D1 O=3Dbuild_dir ARCH=3Darm SHELL=3D/bin/bash drivers/tee/optee/
> >
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> > >> drivers/tee/optee/smc_abi.c:1106:2: error: call to undeclared function=
 'optee_release_helper'; ISO C99 and later do not support implicit function d=
eclarations [-Wimplicit-function-declaration]
> >            optee_release_helper(ctx, optee_close_session_helper);
> >            ^
> >    drivers/tee/optee/smc_abi.c:1106:2: note: did you mean 'optee_release_=
supp'?
> >    drivers/tee/optee/optee_private.h:258:6: note: 'optee_release_supp' de=
clared here
> >    void optee_release_supp(struct tee_context *ctx);
> >         ^
> >    drivers/tee/optee/smc_abi.c:1119:2: error: call to undeclared function=
 'optee_release_helper'; ISO C99 and later do not support implicit function d=
eclarations [-Wimplicit-function-declaration]
> >            optee_release_helper(ctx, optee_close_session_helper);
> >            ^
> >    2 errors generated.
> >
> >
> > vim +/optee_release_helper +1106 drivers/tee/optee/smc_abi.c
> >
> >   1101
> >   1102  static void optee_smc_release_supp(struct tee_context *ctx)
> >   1103  {
> >   1104          struct optee *optee =3D tee_get_drvdata(ctx->teedev);
> >   1105
> > > 1106          optee_release_helper(ctx, optee_close_session_helper);
> >   1107          if (optee->scan_bus_wq) {
> >   1108                  destroy_workqueue(optee->scan_bus_wq);
> >   1109                  optee->scan_bus_wq =3D NULL;
> >   1110          }
> >   1111          optee_supp_release(&optee->supp);
> >   1112          kref_put(&optee->refcnt, optee_smc_delete);
> >   1113  }
> >   1114
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://01.org/lkp

--===============1241769013126797610==--

