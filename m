From: Heiko Thiery <heiko.thiery@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: fix build error caused by recent optee
 tracepoints feature
Date: Tue, 30 Mar 2021 08:53:42 +0200
Message-ID: <20210330065341.18074-1-heiko.thiery@gmail.com>
In-Reply-To: <20210325120601.71584253@xhacker.debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6056115380988573208=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6056115380988573208==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

> If build kernel without "O=3Ddir", below error will be seen:
>=20
> In file included from drivers/tee/optee/optee_trace.h:67,
>                  from drivers/tee/optee/call.c:18:
> ./include/trace/define_trace.h:95:42: fatal error: ./optee_trace.h: No such=
 file or directory
>    95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
>       |                                          ^
> compilation terminated.
>=20
> Fix it by adding below line to Makefile:
> CFLAGS_call.o :=3D -I$(src)
>=20
> Tested with and without "O=3Ddir", both can build successfully.
>=20
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Fixes: 0101947dbcc3 ("tee: optee: add invoke_fn tracepoints")
Tested-by: Heiko Thiery <heiko.thiery@gmail.com>

> ---
>  drivers/tee/optee/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
> index 56263ae3b1d7..3aa33ea9e6a6 100644
> --- a/drivers/tee/optee/Makefile
> +++ b/drivers/tee/optee/Makefile
> @@ -6,3 +6,6 @@ optee-objs +=3D rpc.o
>  optee-objs +=3D supp.o
>  optee-objs +=3D shm_pool.o
>  optee-objs +=3D device.o
> +
> +# for tracing framework to find optee_trace.h
> +CFLAGS_call.o :=3D -I$(src)
> --=20
> 2.31.0
>=20

Thank you.

--=20
Heiko

--===============6056115380988573208==--

