From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: fix build error caused by recent optee
 tracepoints feature
Date: Tue, 30 Mar 2021 10:26:17 +0200
Message-ID: <20210330082617.GA971075@jade>
In-Reply-To: <20210325120601.71584253@xhacker.debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7900402841624657993=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7900402841624657993==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 25, 2021 at 12:06:01PM +0800, Jisheng Zhang wrote:
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

I've picked up this.

Thanks,
Jens

--===============7900402841624657993==--

