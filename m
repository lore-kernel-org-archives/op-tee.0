From: Steven Rostedt <rostedt@goodmis.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: add invoke_fn tracepoints
Date: Wed, 10 Feb 2021 09:37:36 -0500
Message-ID: <20210210093736.0b26f917@gandalf.local.home>
In-Reply-To: <20210210144409.36ecdaed@xhacker.debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3230528917724651766=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3230528917724651766==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Feb 2021 14:44:09 +0800
Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:

> Add tracepoints to retrieve information about the invoke_fn. This would
> help to measure how many invoke_fn are triggered and how long it takes
> to complete one invoke_fn call.
>=20
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>=20
> Since v1:
>  - add BUILD_BUG_ON() macro usage to make sure that the size of what is bei=
ng
>    copied, is not smaller than the amount being copied. Thank Steve.
>  - move optee_trace.h to keep include headers sorted

From a tracing point of view:

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

--===============3230528917724651766==--

