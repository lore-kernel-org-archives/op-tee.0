From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: optee xtest cannot run success stably
Date: Mon, 20 Mar 2023 16:18:14 +0100
Message-ID: 
 <CAHUa44EeFCwc6GOd7YRM03qxzxzOUqQZEXCviJBSKBUG2YgnHg@mail.gmail.com>
In-Reply-To: <
 <9c67106c-777a-4564-b803-73612a0d8ea8.meijianqiang.mjq@alibaba-inc.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7675737581731350393=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7675737581731350393==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Yuye,

On Mon, Mar 20, 2023 at 2:17=E2=80=AFPM =E6=A2=85=E5=BB=BA=E5=BC=BA(=E7=A6=B9=
=E5=A4=9C)
<meijianqiang.mjq@alibaba-inc.com> wrote:
> Hi, Jens,
>
> We seem to have found the answer following the comment you gave in the issu=
e:
>
> https://github.com/OP-TEE/optee_os/issues/5877
>
> The reason seems to be that the system has more non-secure memory than what=
 OP-TEE is aware of.
>
> When our system memory DRAM size is 32GB, optee has the following configura=
tion for non-secure state memory:
>
>         #define DRAM1_BASE 0x880000000UL
>
>         #define DRAM1_SIZE 0x780000000UL
>
> On another device, our system memory DRAM size is 64G, optee uses the above=
 configuration for non-secure memory.
>
> And xtest will not run stably.

Try a large enough value for CFG_LPAE_ADDR_SPACE_BITS and
CFG_CORE_ARM64_PA_BITS.

>
>
> In addition, I would like to ask you a few questions in order to understand=
 the problem better.
> 1.
> System has more non-secure memory than what OP-TEE is aware of, and optee w=
ill not run stably.
> Why? What is the root cause of TEEC_ERROR_OUT_OF_MEMORY on the issue?
>
> I'll do some research on it myself, meanwhile I hope you could give us some=
 insights.

On system configured with SPMC at S-EL2 it should only be
CFG_LPAE_ADDR_SPACE_BITS and CFG_CORE_ARM64_PA_BITS causing troubles
if too small. On other systems, OP-TEE must know that a physical
address is valid non-secure memory to agree to map and access it.

>
> 2.
> When I execute the following command,
>         for i in {1.. 10}; do ./xtest&; done;
> xtest prints out of order,
>
> And the following error is reported:
>
>         E/TC:032 002 mobj_ffa_get_by_cookie:356 possible spinlock deadlock =
reminder 1
>
>         E/TC:070 mobj_ffa_unregister_by_cookie:310 possible spinlock deadlo=
ck reminder 1
>
>         E/TC:004 003 mobj_ffa_get_by_cookie:356 possible spinlock deadlock =
reminder 1
>
>         E/TC:058 001 mobj_ffa_get_by_cookie:356 possible spinlock deadlock =
reminder 1
>
> Then the system hangs and restarts automatically.
> Does optee currently support running multiple TAs in parallel?

Yes

> Is the maximum number of TAs running in parallel equal to the number of vcp=
us?

We're normally only testing with 2-4 vcpus so as you scale up you may
run into issues. Perhaps one CPU panicked while holding that lock.

> 3.
> The values of MAX_XLAT_TABLES and CFG_CORE_HEAP_SIZE also seem to affect th=
e stability of the system.
> What configurations, such as the number of cores, should I pay attention to=
 if I want to configure appropriate values for these options?

As you add a very large number of threads you may need to increase the
heap with a similar factor. I suspect that most of these "stability"
issues are really out-of-memory issues. If you can narrow (EMSG() is
your friend here) down each case of out-of-memory you should soon be
able to identify the bottlenecks.

Cheers,
Jens

>
> Thanks a lot.
>
> Regards,
> Yuye.
>
> ------------------------------------------------------------------
> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AJens Wiklander <jens.wiklander@linaro=
.org>
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2023=E5=B9=B43=E6=9C=8820=E6=
=97=A5(=E6=98=9F=E6=9C=9F=E4=B8=80) 15:05
> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A=E6=A2=85=E5=BB=BA=E5=BC=BA(=E7=A6=B9=
=E5=A4=9C) <meijianqiang.mjq@alibaba-inc.com>
> =E6=8A=84=E3=80=80=E9=80=81=EF=BC=9AOlivier Deprez <Olivier.Deprez@arm.co=
m>; hafnium <hafnium@lists.trustedfirmware.org>; op-tee <op-tee@lists.tru=
stedfirmware.org>
> =E4=B8=BB=E3=80=80=E9=A2=98=EF=BC=9ARe: optee xtest cannot run success stab=
ly
>
> Hi Yuye,
>
> Comment below.
>
> On Mon, Mar 20, 2023 at 4:43 AM =E6=A2=85=E5=BB=BA=E5=BC=BA(=E7=A6=B9=E5=A4=
=9C)
> <meijianqiang.mjq@alibaba-inc.com> wrote:
> > Hi, experts
> >
> > Recently, we are testing the stability for running optee xtest with envir=
onment that hafnium runs as SPMC and optee runs on SPMC as SP.
> > When we reboot the system, xtest failed on some cases with TEEC_ERROR_OUT=
_OF_MEMORY.
> > It seems to be that there is an insufficient memory allocation somewhere =
in the chain.
> > We tried the following:
> > Using Single core startup,
> > Increased optee MAX_XLAT_TABLES size to 16,
> > Increased optee CFG_CORE_HEAP_SIZE to 0x2000000,
> > Increasing the size of optee CFG_TEE_RAM_VA_SIZE to 0x4000000,
> > Increasing the size of hafnium heap_pages to 8192,
> > But nothing seems to be working.
> > Can you offer any help or suggestions?
>
> It would help if you could pinpoint the source of the out-of-memory
> error. I guess it happens somewhere during mobj_ffa_get_by_cookie(),
> where especially thread_spmc_populate_mobj_from_rx() is interesting.
> It could also be worth setting CFG_CORE_DUMP_OOM=3Dy, it's easy to
> enable but I'm afraid it's more of a long shot.
>
> Cheers,
> Jens
>
>
> > Some other configuration for optee is attached in the issue:
> > https://github.com/OP-TEE/optee_os/issues/5893
>
>
>
> >
> > Regards,
> > Yuye.
> >

--===============7675737581731350393==--

