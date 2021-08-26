From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 5/5] optee: add FF-A support
Date: Thu, 26 Aug 2021 16:52:13 +0200
Message-ID: <20210826145213.GA1739293@jade>
In-Reply-To: <
 <CAFA6WYNHrej1_yMZejLpG5u1WjN5XvpmS-zKWdLVZu=DEWd6xA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5528159430611017445=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5528159430611017445==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 25, 2021 at 05:12:45PM +0530, Sumit Garg wrote:
> On Thu, 19 Aug 2021 at 16:37, Jens Wiklander <jens.wiklander@linaro.org> =
wrote:
> >
> > Adds support for using FF-A [1] as transport to the OP-TEE driver.
> >
> > Introduces struct optee_msg_param_fmem which carries all information
> > needed when OP-TEE is calling FFA_MEM_RETRIEVE_REQ to get the shared
> > memory reference mapped by the hypervisor in S-EL2. Register usage is
> > also updated to include the information needed.
> >
> > The FF-A part of this driver is enabled if CONFIG_ARM_FFA_TRANSPORT is
> > enabled.
> >
> > [1] https://developer.arm.com/documentation/den0077/latest
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/tee/optee/Makefile        |   3 +-
> >  drivers/tee/optee/call.c          |  13 +-
> >  drivers/tee/optee/core.c          |  16 +-
> >  drivers/tee/optee/ffa_abi.c       | 907 ++++++++++++++++++++++++++++++
> >  drivers/tee/optee/optee_ffa.h     | 153 +++++
> >  drivers/tee/optee/optee_msg.h     |  27 +-
> >  drivers/tee/optee/optee_private.h |  43 +-
> >  7 files changed, 1148 insertions(+), 14 deletions(-)
> >  create mode 100644 drivers/tee/optee/ffa_abi.c
> >  create mode 100644 drivers/tee/optee/optee_ffa.h
> >
[snip]
> > --- /dev/null
> > +++ b/drivers/tee/optee/ffa_abi.c
> > @@ -0,0 +1,907 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2021, Linaro Limited
> > + */
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include <linux/arm_ffa.h>
> > +#include <linux/errno.h>
> > +#include <linux/scatterlist.h>
> > +#include <linux/sched.h>
> > +#include <linux/slab.h>
> > +#include <linux/string.h>
> > +#include <linux/tee_drv.h>
> > +#include <linux/types.h>
> > +#include "optee_private.h"
> > +#include "optee_ffa.h"
> > +#include "optee_rpc_cmd.h"
> > +
> > +/*
> > + * This file implement the FF-A ABI used when communicating with secure =
world
> > + * OP-TEE OS via FF-A.
> > + * This file is divided into the follow sections:
>=20
> s/follow/following/

Thanks, I'll fix.

[snip]
> > +static bool optee_ffa_exchange_caps(struct ffa_device *ffa_dev,
> > +                                   const struct ffa_dev_ops *ops,
> > +                                   unsigned int *rpc_arg_count)
> > +{
> > +       struct ffa_send_direct_data data =3D { OPTEE_FFA_EXCHANGE_CAPABIL=
ITIES };
> > +       int rc;
> > +
> > +       rc =3D ops->sync_send_receive(ffa_dev, &data);
> > +       if (rc) {
> > +               pr_err("Unexpected error %d", rc);
> > +               return false;
> > +       }
> > +       if (data.data0) {
> > +               pr_err("Unexpected exchange error %lu", data.data0);
> > +               return false;
> > +       }
> > +
> > +       *rpc_arg_count =3D (u8)data.data1;
>=20
> Why is this special capability required in case of FF-A? Is it true
> that RPC arguments count will be fixed for all RPC commands?

It's to allow this driver to preallocate the argument struct used when
doing RPC. That way we can avoid the chicken and egg problem of allocating
an RPC argumet struct just before doing the real RPC.

This is the maximum number of arguments needed by secure world. In case
a larger value ever is needed, secure world will be able to supply the
needed value.

I plan to update the SMC based ABI with this also, but not in the patch
set.

>=20
> > +
> > +       return true;
> > +}

[snip]
> > +static int optee_ffa_probe(struct ffa_device *ffa_dev)
> > +{
> > +       const struct ffa_dev_ops *ffa_ops;
> > +       unsigned int rpc_arg_count;
> > +       struct tee_device *teedev;
> > +       struct optee *optee;
> > +       int rc;
> > +
> > +       ffa_ops =3D ffa_dev_ops_get(ffa_dev);
> > +       if (!ffa_ops) {
> > +               pr_warn("failed \"method\" init: ffa\n");
> > +               return -ENOENT;
> > +       }
> > +
> > +       if (!optee_ffa_api_is_compatbile(ffa_dev, ffa_ops))
> > +               return -EINVAL;
> > +
> > +       if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &rpc_arg_count))
> > +               return -EINVAL;
> =3D> +
> > +       optee =3D kzalloc(sizeof(*optee), GFP_KERNEL);
> > +       if (!optee) {
> > +               rc =3D -ENOMEM;
> > +               goto err;
> > +       }
> > +       optee->pool =3D optee_ffa_config_dyn_shm();
> > +       if (IS_ERR(optee->pool)) {
> > +               rc =3D PTR_ERR(optee->pool);
> > +               optee->pool =3D NULL;
> > +               goto err;
> > +       }
>=20
> IIUC, with FF-A we will only be supporting dynamic shared memory. So
> CFG_CORE_DYN_SHM=3Dy should be enforced in OP-TEE OS when
> CFG_CORE_FFA=3Dy, but I don't see that currently. Am I missing
> something?

You mean in optee_os.git? With FF-A dynamic shared memory is always
handled, so that flag in irrelevant in that case. However, feel free to
start a discussion on that topic at github.

Thanks,
Jens

--===============5528159430611017445==--

