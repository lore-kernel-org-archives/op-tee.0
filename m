From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: add invoke_fn tracepoints
Date: Tue, 23 Feb 2021 14:11:24 +0100
Message-ID: <20210223131124.GA2303918@jade>
In-Reply-To: <20210223184026.22c86356@xhacker.debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6844036872869864995=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6844036872869864995==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 23, 2021 at 06:40:26PM +0800, Jisheng Zhang wrote:
> On Tue, 23 Feb 2021 08:59:22 +0100 Jens Wiklander wrote:
>=20
>=20
> >=20
> > Hi Jisheng,
>=20
> Hi Jens,
>=20
> >=20
> > On Wed, Feb 10, 2021 at 7:44 AM Jisheng Zhang
> > <Jisheng.Zhang@synaptics.com> wrote:
> > >
> > > Add tracepoints to retrieve information about the invoke_fn. This would
> > > help to measure how many invoke_fn are triggered and how long it takes
> > > to complete one invoke_fn call.
> > >
> > > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > > ---
> > >
> > > Since v1:
> > >  - add BUILD_BUG_ON() macro usage to make sure that the size of what is=
 being
> > >    copied, is not smaller than the amount being copied. Thank Steve.
> > >  - move optee_trace.h to keep include headers sorted
> > >
> > >  drivers/tee/optee/call.c        |  4 ++
> > >  drivers/tee/optee/optee_trace.h | 67 +++++++++++++++++++++++++++++++++
> > >  2 files changed, 71 insertions(+)
> > >  create mode 100644 drivers/tee/optee/optee_trace.h
> > >
[snip]
> > > diff --git a/drivers/tee/optee/optee_trace.h b/drivers/tee/optee/optee_=
trace.h
> > > new file mode 100644
> > > index 000000000000..7c954eefa4bf
> > > --- /dev/null
> > > +++ b/drivers/tee/optee/optee_trace.h
> > > @@ -0,0 +1,67 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * optee trace points
> > > + *
> > > + * Copyright (C) 2021 Synaptics Incorporated
> > > + * Author: Jisheng Zhang <jszhang@kernel.org>
> > > + */
> > > +
> > > +#undef TRACE_SYSTEM
> > > +#define TRACE_SYSTEM optee
> > > +
> > > +#if !defined(_TRACE_OPTEE_H) || defined(TRACE_HEADER_MULTI_READ)
> > > +#define _TRACE_OPTEE_H
> > > +
> > > +#include <linux/arm-smccc.h>
> > > +#include <linux/tracepoint.h>
> > > +#include "optee_private.h"
> > > + =20
> >=20
> > Checkpatch has some complaints below. Is that something that could be
> > fixed or is this so far from regular C-syntax that we don't care?
>=20
> I tried ./scripts/checkpatch.pl in Linus tree to check the patch, there's
> no any error, and except the "MAINTAINERS need updating" warning, there's
> no other warnings.
>=20
> git log  -- scripts/checkpatch.pl
> shows the latest checkpatch.pl is at commit 62137364e3e8afcc745846c5c67cacf=
943149073
>=20
> I'm not sure what happened.

I used the -strict option.

./scripts/checkpatch.pl -strict 0001-tee-optee-add-invoke_fn-tracepoints.patch
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#44:=20
new file mode 100644

CHECK: Alignment should match open parenthesis
#68: FILE: drivers/tee/optee/optee_trace.h:20:
+TRACE_EVENT(optee_invoke_fn_begin,
+	TP_PROTO(struct optee_rpc_param *param),

CHECK: Lines should not end with a '('
#71: FILE: drivers/tee/optee/optee_trace.h:23:
+	TP_STRUCT__entry(

CHECK: Lines should not end with a '('
#76: FILE: drivers/tee/optee/optee_trace.h:28:
+	TP_fast_assign(

CHECK: Alignment should match open parenthesis
#89: FILE: drivers/tee/optee/optee_trace.h:41:
+TRACE_EVENT(optee_invoke_fn_end,
+	TP_PROTO(struct optee_rpc_param *param, struct arm_smccc_res *res),

CHECK: Lines should not end with a '('
#92: FILE: drivers/tee/optee/optee_trace.h:44:
+	TP_STRUCT__entry(

CHECK: Lines should not end with a '('
#97: FILE: drivers/tee/optee/optee_trace.h:49:
+	TP_fast_assign(

total: 0 errors, 1 warnings, 6 checks, 86 lines checked

Thanks,
Jens

--===============6844036872869864995==--

