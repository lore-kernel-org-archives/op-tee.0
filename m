From: Steven Rostedt <rostedt@goodmis.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: add invoke_fn tracepoints
Date: Wed, 24 Mar 2021 10:53:13 -0400
Message-ID: <20210324105313.4ff3ad07@gandalf.local.home>
In-Reply-To: <20210324144853.GA5718@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7658012888687646925=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7658012888687646925==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Mar 2021 07:48:53 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On Wed, Mar 24, 2021 at 07:34:07AM -0700, Guenter Roeck wrote:
> > On Wed, Feb 10, 2021 at 02:44:09PM +0800, Jisheng Zhang wrote: =20
> > > Add tracepoints to retrieve information about the invoke_fn. This would
> > > help to measure how many invoke_fn are triggered and how long it takes
> > > to complete one invoke_fn call.
> > >=20
> > > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com> =20
> >=20
> > arm64:defconfig:
> >=20
> > make-arm64 -j drivers/tee/optee/call.o
> >   CALL    scripts/atomic/check-atomics.sh
> >   CALL    scripts/checksyscalls.sh
> >   CC      drivers/tee/optee/call.o
> > In file included from drivers/tee/optee/optee_trace.h:67,
> >                  from drivers/tee/optee/call.c:18:
> > ./include/trace/define_trace.h:95:42: fatal error: ./optee_trace.h: No su=
ch file or directory
> >    95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
> >       |                                          ^
> > compilation terminated.
> >  =20
>=20
> The problem also affects arm:imx_v6_v7_defconfig.
>=20

I think it affects everything. The problem is that the
drivers/tee/optee/Makefile needs to be updated with:

CFLAGS_call.o :=3D -I$(src)

otherwise the compiler wont know how to find the path to optee_tree.h.

This is described in:

   samples/trace_events/Makefile

-- Steve

--===============7658012888687646925==--

