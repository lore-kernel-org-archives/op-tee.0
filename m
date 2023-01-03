From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: ffa_abi: Fix use-after-free in optee_ffa_open
Date: Tue, 03 Jan 2023 09:08:29 +0100
Message-ID: 
 <CAHUa44GDB592mgJsmYzFetM_T+VvwAn5LMoj77KnQFSNEM4nOw@mail.gmail.com>
In-Reply-To: <
 <CALQpDLcLghTY44YumjGj8McLsTUDkcxTKMOmjA5-oqEPGBG3ww@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0098039382846683103=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0098039382846683103==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 2, 2023 at 1:17 AM Yoochan Lee <yoochan1026@gmail.com> wrote:
>
> I fix the error in the previous patch.
>
> From fde49d86f6401789ba51f267a0d79fbe4e7ffc24 Mon Sep 17 00:00:00 2001
> From: Yoochan Lee <yoochan1026@gmail.com>
> Date: Mon, 2 Jan 2023 09:16:05 +0900
> Subject: [PATCH 2/2] fix errors in previous patch
>
> ---
>  drivers/tee/optee/ffa_abi.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)

Please fix up the original patch and post it as a v2. By the way, have
you tried to test this in some way?

Thanks,
Jens

>
> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index ea76d7532419..65d9463d9ed8 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -741,28 +741,23 @@ static void optee_ffa_delete(struct kref *kref)
>
>  static void optee_ffa_release(struct tee_context *ctx)
>  {
> - struct optee *optee =3D tee_get_drvdata(teedev);
> -
> - optee_release_helper(ctx, optee_close_session_helper);
> + struct optee *optee =3D tee_get_drvdata(ctx->teedev);
> +
> + optee_release(ctx);
>   kref_put(&optee->refcnt, optee_ffa_delete);
>  }
>
>  void optee_ffa_release_supp(struct tee_context *ctx)
>  {
>   struct optee *optee =3D tee_get_drvdata(ctx->teedev);
> -
> - optee_release_helper(ctx, optee_close_session_helper);
> - if (optee->scan_bus_wq) {
> - destroy_workqueue(optee->scan_bus_wq);
> - optee->scan_bus_wq =3D NULL;
> - }
> - optee_supp_release(&optee->supp);
> +
> + optee_release_supp(ctx);
>   kref_put(&optee->refcnt, optee_ffa_delete);
>  }
>
>  static int optee_ffa_open(struct tee_context *ctx)
>  {
> - struct optee *optee =3D tee_get_drvdata(teedev);
> + struct optee *optee =3D tee_get_drvdata(ctx->teedev);
>   kref_get(&optee->refcnt);
>
>   return optee_open(ctx, true);
> --
> 2.39.0
>
> 2023=EB=85=84 1=EC=9B=94 2=EC=9D=BC (=EC=9B=94) =EC=98=A4=EC=A0=84 5:12, ke=
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
tee-ffa_abi-Fix-use-after-free-in-optee_ffa_open/20221231-133611
> > patch link:    https://lore.kernel.org/r/20221231053421.2039591-1-yoochan=
1026%40gmail.com
> > patch subject: [PATCH] tee: optee: ffa_abi: Fix use-after-free in optee_f=
fa_open
> > config: arm-randconfig-c002-20221231
> > compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project f570=
0e7b69048de958172fb513b336564e7f8709)
> > reproduce (this is a W=3D1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install arm cross compiling tool for clang build
> >         # apt-get install binutils-arm-linux-gnueabi
> >         # https://github.com/intel-lab-lkp/linux/commit/3fe68a00d912f9e5d=
bec5002a7d30cf2a0868679
> >         git remote add linux-review https://github.com/intel-lab-lkp/linux
> >         git fetch --no-tags linux-review Yoochan-Lee/tee-optee-ffa_abi-Fi=
x-use-after-free-in-optee_ffa_open/20221231-133611
> >         git checkout 3fe68a00d912f9e5dbec5002a7d30cf2a0868679
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
> > All error/warnings (new ones prefixed by >>):
> >
> > >> drivers/tee/optee/ffa_abi.c:744:40: error: use of undeclared identifie=
r 'teedev'
> >            struct optee *optee =3D tee_get_drvdata(teedev);
> >                                                  ^
> > >> drivers/tee/optee/ffa_abi.c:746:2: error: call to undeclared function =
'optee_release_helper'; ISO C99 and later do not support implicit function de=
clarations [-Wimplicit-function-declaration]
> >            optee_release_helper(ctx, optee_close_session_helper);
> >            ^
> >    drivers/tee/optee/ffa_abi.c:746:2: note: did you mean 'optee_release_s=
upp'?
> >    drivers/tee/optee/optee_private.h:258:6: note: 'optee_release_supp' de=
clared here
> >    void optee_release_supp(struct tee_context *ctx);
> >         ^
> >    drivers/tee/optee/ffa_abi.c:754:2: error: call to undeclared function =
'optee_release_helper'; ISO C99 and later do not support implicit function de=
clarations [-Wimplicit-function-declaration]
> >            optee_release_helper(ctx, optee_close_session_helper);
> >            ^
> > >> drivers/tee/optee/ffa_abi.c:750:6: warning: no previous prototype for =
function 'optee_ffa_release_supp' [-Wmissing-prototypes]
> >    void optee_ffa_release_supp(struct tee_context *ctx)
> >         ^
> >    drivers/tee/optee/ffa_abi.c:750:1: note: declare 'static' if the funct=
ion is not intended to be used outside of this translation unit
> >    void optee_ffa_release_supp(struct tee_context *ctx)
> >    ^
> >    static
> >    drivers/tee/optee/ffa_abi.c:765:40: error: use of undeclared identifie=
r 'teedev'
> >            struct optee *optee =3D tee_get_drvdata(teedev);
> >                                                  ^
> >    1 warning and 4 errors generated.
> >
> >
> > vim +/teedev +744 drivers/tee/optee/ffa_abi.c
> >
> >    741
> >    742  static void optee_ffa_release(struct tee_context *ctx)
> >    743  {
> >  > 744          struct optee *optee =3D tee_get_drvdata(teedev);
> >    745
> >  > 746          optee_release_helper(ctx, optee_close_session_helper);
> >    747          kref_put(&optee->refcnt, optee_ffa_delete);
> >    748  }
> >    749
> >  > 750  void optee_ffa_release_supp(struct tee_context *ctx)
> >    751  {
> >    752          struct optee *optee =3D tee_get_drvdata(ctx->teedev);
> >    753
> >    754          optee_release_helper(ctx, optee_close_session_helper);
> >    755          if (optee->scan_bus_wq) {
> >    756                  destroy_workqueue(optee->scan_bus_wq);
> >    757                  optee->scan_bus_wq =3D NULL;
> >    758          }
> >    759          optee_supp_release(&optee->supp);
> >    760          kref_put(&optee->refcnt, optee_ffa_delete);
> >    761  }
> >    762
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://01.org/lkp

--===============0098039382846683103==--

