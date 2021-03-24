From: Guenter Roeck <linux@roeck-us.net>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: add invoke_fn tracepoints
Date: Wed, 24 Mar 2021 07:34:07 -0700
Message-ID: <20210324143407.GA8717@roeck-us.net>
In-Reply-To: <20210210144409.36ecdaed@xhacker.debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9187945489309488148=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============9187945489309488148==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 10, 2021 at 02:44:09PM +0800, Jisheng Zhang wrote:
> Add tracepoints to retrieve information about the invoke_fn. This would
> help to measure how many invoke_fn are triggered and how long it takes
> to complete one invoke_fn call.
>=20
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

arm64:defconfig:

make-arm64 -j drivers/tee/optee/call.o
  CALL    scripts/atomic/check-atomics.sh
  CALL    scripts/checksyscalls.sh
  CC      drivers/tee/optee/call.o
In file included from drivers/tee/optee/optee_trace.h:67,
                 from drivers/tee/optee/call.c:18:
./include/trace/define_trace.h:95:42: fatal error: ./optee_trace.h: No such f=
ile or directory
   95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
      |                                          ^
compilation terminated.

Guenter

--===============9187945489309488148==--

