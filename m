From: Steven Rostedt <rostedt@goodmis.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: add invoke_fn tracepoints
Date: Tue, 23 Feb 2021 09:19:36 -0500
Message-ID: <20210223091936.5b390f35@gandalf.local.home>
In-Reply-To: <20210223131124.GA2303918@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1763936502554979222=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1763936502554979222==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Feb 2021 14:11:24 +0100
Jens Wiklander <jens.wiklander@linaro.org> wrote:

> I used the -strict option.
>=20
> ./scripts/checkpatch.pl -strict 0001-tee-optee-add-invoke_fn-tracepoints.pa=
tch
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #44:=20
> new file mode 100644

The above is just asking for someone to take maintainership of the new file.

>=20
> CHECK: Alignment should match open parenthesis
> #68: FILE: drivers/tee/optee/optee_trace.h:20:
> +TRACE_EVENT(optee_invoke_fn_begin,
> +	TP_PROTO(struct optee_rpc_param *param),
>=20
> CHECK: Lines should not end with a '('
> #71: FILE: drivers/tee/optee/optee_trace.h:23:
> +	TP_STRUCT__entry(
>=20
> CHECK: Lines should not end with a '('
> #76: FILE: drivers/tee/optee/optee_trace.h:28:
> +	TP_fast_assign(
>=20
> CHECK: Alignment should match open parenthesis
> #89: FILE: drivers/tee/optee/optee_trace.h:41:
> +TRACE_EVENT(optee_invoke_fn_end,
> +	TP_PROTO(struct optee_rpc_param *param, struct arm_smccc_res *res),
>=20
> CHECK: Lines should not end with a '('
> #92: FILE: drivers/tee/optee/optee_trace.h:44:
> +	TP_STRUCT__entry(
>=20
> CHECK: Lines should not end with a '('
> #97: FILE: drivers/tee/optee/optee_trace.h:49:
> +	TP_fast_assign(

The TRACE_EVENT() macro is "special", and checkpatch notoriously stumbles
over it. I usually recommend that people ignore the checkpatch warnings on
TRACE_EVENT() macros.

-- Steve


>=20
> total: 0 errors, 1 warnings, 6 checks, 86 lines checked


--===============1763936502554979222==--

