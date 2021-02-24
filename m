From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: add invoke_fn tracepoints
Date: Wed, 24 Feb 2021 09:10:54 +0100
Message-ID: <20210224081054.GA2653493@jade>
In-Reply-To: <20210223091936.5b390f35@gandalf.local.home>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8687928377246537445=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8687928377246537445==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 23, 2021 at 09:19:36AM -0500, Steven Rostedt wrote:
> On Tue, 23 Feb 2021 14:11:24 +0100
> Jens Wiklander <jens.wiklander@linaro.org> wrote:
>=20
> > I used the -strict option.
> >=20
> > ./scripts/checkpatch.pl -strict 0001-tee-optee-add-invoke_fn-tracepoints.=
patch
> > WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> > #44:=20
> > new file mode 100644
>=20
> The above is just asking for someone to take maintainership of the new file.
>=20
> >=20
> > CHECK: Alignment should match open parenthesis
> > #68: FILE: drivers/tee/optee/optee_trace.h:20:
> > +TRACE_EVENT(optee_invoke_fn_begin,
> > +	TP_PROTO(struct optee_rpc_param *param),
> >=20
> > CHECK: Lines should not end with a '('
> > #71: FILE: drivers/tee/optee/optee_trace.h:23:
> > +	TP_STRUCT__entry(
> >=20
> > CHECK: Lines should not end with a '('
> > #76: FILE: drivers/tee/optee/optee_trace.h:28:
> > +	TP_fast_assign(
> >=20
> > CHECK: Alignment should match open parenthesis
> > #89: FILE: drivers/tee/optee/optee_trace.h:41:
> > +TRACE_EVENT(optee_invoke_fn_end,
> > +	TP_PROTO(struct optee_rpc_param *param, struct arm_smccc_res *res),
> >=20
> > CHECK: Lines should not end with a '('
> > #92: FILE: drivers/tee/optee/optee_trace.h:44:
> > +	TP_STRUCT__entry(
> >=20
> > CHECK: Lines should not end with a '('
> > #97: FILE: drivers/tee/optee/optee_trace.h:49:
> > +	TP_fast_assign(
>=20
> The TRACE_EVENT() macro is "special", and checkpatch notoriously stumbles
> over it. I usually recommend that people ignore the checkpatch warnings on
> TRACE_EVENT() macros.

Makes sense. I'll pick this up as it is.

Thanks,
Jens

--===============8687928377246537445==--

