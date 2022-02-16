From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 00/10] tee: shared memory updates
Date: Wed, 16 Feb 2022 07:40:26 +0100
Message-ID: 
 <CAHUa44Gm6mTq2mp8JzxL7_MDfJa0ApVbkaV6ZOMOaKMWti2fDg@mail.gmail.com>
In-Reply-To: <20220204093359.359059-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6449691904382703960=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6449691904382703960==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, Feb 4, 2022 at 10:34 AM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> Hi all,
>
> This patchset is a general cleanup of shared memory handling in the TEE
> subsystem.
>
> Until now has the in-kernel tee clients used tee_shm_alloc() and
> tee_shm_register() to share memory with secure world. These two function
> exposes via a flags parameter a bit more of the internals of the TEE
> subsystem than one would like. So in order to make things easier are those
> two functions replaced by few functions which should provide better
> abstraction.
>
> Two in-kernel tee clients are updated to use these new functions.
>
> The shared memory pool handling is simplified, an internal matter for the
> two TEE drivers OP-TEE and AMDTEE.
>
> In the v3 review it was suggested [1] to break out "optee: add driver
> private tee_context" and "optee: use driver internal tee_contex for some
> rpc" into a separate patch to fix to allow those a faster path upstream as
> they fix reported problems. So this patchset is now rebased on top of those
> patches separated.
>
> This patchset is based on [2] and is also available at [3].

All patches are reviewed and there are no further comments so I'm
picking up this now.

Cheers,
Jens

>
> Thanks,
> Jens
>
> [1] https://lore.kernel.org/lkml/20220125162938.838382-1-jens.wiklander(a)l=
inaro.org/T/#m9e38c5788b49ed3929276df69fe856b6cbe14dfb
> [2] https://git.linaro.org/people/jens.wiklander/linux-tee.git/log/?h=3Dfix=
es
> [3] https://git.linaro.org/people/jens.wiklander/linux-tee.git/log/?h=3Dtee=
_shm_v4
>
> v3->v4:
> * Broke out "optee: add driver private tee_context" and "optee: use driver
>   internal tee_contex for some rpc" into a separate patch as that fixes
>   earlier reported issues and deserves a to go into v5.17 and stable
>   trees.
> * Rebased on the recent fixes for the OP-TEE driver on top of v5.17-rc2
> * All patches are now reviewed by Sumit Garg + some small fixes from the
>   last review
>
> v2->v3:
> * Make tee_shm_alloc_user_buf() and tee_shm_register_user_buf() internal
>   and don't export them to the drivers.
> * Rename tee_shm_alloc_priv_kernel_buf() to tee_shm_alloc_priv_buf()
> * Adressing comments on variable names and choice of types in "tee: replace
>   tee_shm_register()"
> * Adding detailed explaination on alignment in "tee: simplify shm pool hand=
ling"
> * Added Sumits R-B on a few of the patches
>
> v1->v2:
> * The commits three "tee: add tee_shm_alloc_kernel_buf()",
>   "tpm_ftpm_tee: use tee_shm_alloc_kernel_buf()" and
>   "firmware: tee_bnxt: use tee_shm_alloc_kernel_buf()" has been merged some
>   time ago as part of another patchset.
> * Another in-kernel tee client is updated with the commit
>   "KEYS: trusted: tee: use tee_shm_register_kernel_buf()"
> * tee_shm_alloc_anon_kernel_buf() is replaced with an easier to use function
>   tee_shm_alloc_priv_kernel_buf() and tee_shm_free_anon_kernel_buf() has
>   been dropped.
> * A driver internal struct tee_context is used to when doing driver internal
>   calls to secure world.
> * Adds patches to replace tee_shm_register() in a similar way as how
>   tee_shm_alloc() is replaced.
> * A patch is added to clean up the TEE_SHM_* flags
> * Fixed a warning reported by kernel test robot <lkp@intel.com>
>
> Jens Wiklander (10):
>   hwrng: optee-rng: use tee_shm_alloc_kernel_buf()
>   tee: remove unused tee_shm_pool_alloc_res_mem()
>   tee: add tee_shm_alloc_user_buf()
>   tee: simplify shm pool handling
>   tee: replace tee_shm_alloc()
>   optee: add optee_pool_op_free_helper()
>   tee: add tee_shm_register_{user,kernel}_buf()
>   KEYS: trusted: tee: use tee_shm_register_kernel_buf()
>   tee: replace tee_shm_register()
>   tee: refactor TEE_SHM_* flags
>
>  drivers/char/hw_random/optee-rng.c       |   6 +-
>  drivers/tee/amdtee/shm_pool.c            |  55 ++--
>  drivers/tee/optee/Kconfig                |   8 -
>  drivers/tee/optee/call.c                 |   2 +-
>  drivers/tee/optee/core.c                 |  21 +-
>  drivers/tee/optee/device.c               |   5 +-
>  drivers/tee/optee/ffa_abi.c              |  63 ++---
>  drivers/tee/optee/optee_private.h        |   7 +-
>  drivers/tee/optee/smc_abi.c              | 125 +++------
>  drivers/tee/tee_core.c                   |   5 +-
>  drivers/tee/tee_private.h                |  15 +-
>  drivers/tee/tee_shm.c                    | 320 +++++++++++++++--------
>  drivers/tee/tee_shm_pool.c               | 162 +++---------
>  include/linux/tee_drv.h                  | 138 +++-------
>  security/keys/trusted-keys/trusted_tee.c |  23 +-
>  15 files changed, 388 insertions(+), 567 deletions(-)
>
> --
> 2.31.1
>

--===============6449691904382703960==--

