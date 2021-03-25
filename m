From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: add invoke_fn tracepoints
Date: Thu, 25 Mar 2021 11:50:43 +0800
Message-ID: <20210325115043.6c00a33e@xhacker.debian>
In-Reply-To: <20210324105313.4ff3ad07@gandalf.local.home>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3662386639284667394=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3662386639284667394==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Mar 2021 10:53:13 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:


>=20
> On Wed, 24 Mar 2021 07:48:53 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
>=20
> > On Wed, Mar 24, 2021 at 07:34:07AM -0700, Guenter Roeck wrote: =20
> > > On Wed, Feb 10, 2021 at 02:44:09PM +0800, Jisheng Zhang wrote: =20
> > > > Add tracepoints to retrieve information about the invoke_fn. This wou=
ld
> > > > help to measure how many invoke_fn are triggered and how long it takes
> > > > to complete one invoke_fn call.
> > > >
> > > > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com> =20
> > >
> > > arm64:defconfig:
> > >
> > > make-arm64 -j drivers/tee/optee/call.o
> > >   CALL    scripts/atomic/check-atomics.sh
> > >   CALL    scripts/checksyscalls.sh
> > >   CC      drivers/tee/optee/call.o
> > > In file included from drivers/tee/optee/optee_trace.h:67,
> > >                  from drivers/tee/optee/call.c:18:
> > > ./include/trace/define_trace.h:95:42: fatal error: ./optee_trace.h: No =
such file or directory
> > >    95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
> > >       |                                          ^
> > > compilation terminated.

Interesting, I always build linux kernel with "O=3D", didn't see such build e=
rror
and IIRC, we didn't receive any lkp robot build error report.

My steps are:

mkdir /tmp/test

make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- O=3D/tmp/test defconfig

make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- O=3D/tmp/test drivers/te=
e/optee/

Today, I tried to build the linux kernel w/o "O=3D...", I reproduced this err=
or!
This is the first time I saw "O=3D" make a different behavior.

I'll send out a patch to fix it.

Thanks

> > > =20
> >
> > The problem also affects arm:imx_v6_v7_defconfig.
> > =20
>=20
> I think it affects everything. The problem is that the
> drivers/tee/optee/Makefile needs to be updated with:
>=20
> CFLAGS_call.o :=3D -I$(src)
>=20
> otherwise the compiler wont know how to find the path to optee_tree.h.
>=20
> This is described in:
>=20
>    samples/trace_events/Makefile

Thank Steven for pointing this out.


--===============3662386639284667394==--

