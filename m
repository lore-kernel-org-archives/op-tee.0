From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: optee xtest cannot run success stably
Date: Mon, 20 Mar 2023 08:05:24 +0100
Message-ID: 
 <CAHUa44HoWSMayqCyR-KmEWxy7i_f0j_Yhyw=-6yxChZkoaBS1w@mail.gmail.com>
In-Reply-To: <
 <1b8fabc9-a521-4489-8817-a34c91288ec7.meijianqiang.mjq@alibaba-inc.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0579966733507901233=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0579966733507901233==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Yuye,

Comment below.

On Mon, Mar 20, 2023 at 4:43=E2=80=AFAM =E6=A2=85=E5=BB=BA=E5=BC=BA(=E7=A6=B9=
=E5=A4=9C)
<meijianqiang.mjq@alibaba-inc.com> wrote:
> Hi, experts
>
> Recently, we are testing the stability for running optee xtest with environ=
ment that hafnium runs as SPMC and optee runs on SPMC as SP.
> When we reboot the system, xtest failed on some cases with TEEC_ERROR_OUT_O=
F_MEMORY.
> It seems to be that there is an insufficient memory allocation somewhere in=
 the chain.
> We tried the following:
> Using Single core startup,
> Increased optee MAX_XLAT_TABLES size to 16,
> Increased optee CFG_CORE_HEAP_SIZE to 0x2000000,
> Increasing the size of optee CFG_TEE_RAM_VA_SIZE to 0x4000000,
> Increasing the size of hafnium heap_pages to 8192,
> But nothing seems to be working.
> Can you offer any help or suggestions?

It would help if you could pinpoint the source of the out-of-memory
error. I guess it happens somewhere during mobj_ffa_get_by_cookie(),
where especially thread_spmc_populate_mobj_from_rx() is interesting.
It could also be worth setting CFG_CORE_DUMP_OOM=3Dy, it's easy to
enable but I'm afraid it's more of a long shot.

Cheers,
Jens


> Some other configuration for optee is attached in the issue:
> https://github.com/OP-TEE/optee_os/issues/5893



>
> Regards,
> Yuye.
>

--===============0579966733507901233==--

