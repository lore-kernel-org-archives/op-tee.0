From: Gabor Toth <Gabor.Toth2@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: RE: Enable pointer authentication for the SP initialization
Date: Wed, 26 Jun 2024 10:29:41 +0000
Message-ID: <VI1PR08MB10174C80D2EF3B0F8E08251F1A9D62@VI1PR08MB10174.eurprd08.prod.outlook.com>
In-Reply-To: <
 <CAHUa44FD4zYU9jjYJocAv_xhcnkzTi2jMdzeP8iG8i-axy170g@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0691115527726200048=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0691115527726200048==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,

As I see after the SP-s return to SEL1 the context is restored and the pauth =
keys are set to the keys of the atomic context (kernels[n].keys). So the only=
 problem is that at initialization the keys of the thread-line context (threa=
d_core_local[n].keys) are used instead of the atomic ones.

Since " which context is used is more by chance than by design", do you see a=
nything against initializing the pauth keys to the keys of the atomic context=
 instead of the kernel-like ones=20
here: https://github.com/OP-TEE/optee_os/blob/master/core/arch/arm/kernel/ent=
ry_a64.S#L139 ?

With this change and moving the SP initialization right after enabling SCTLR_=
ENIA the feature seems to be working properly and the protection is already e=
nabled when the sp boot starts.

Br,
G=C3=A1bor

-----Original Message-----
From: Jens Wiklander <jens.wiklander@linaro.org>=20
Sent: Tuesday, June 25, 2024 3:21 PM
To: Gabor Toth <Gabor.Toth2@arm.com>
Cc: op-tee(a)lists.trustedfirmware.org
Subject: Re: Enable pointer authentication for the SP initialization

Hi Gabor,

On Tue, Jun 25, 2024 at 1:16=E2=80=AFPM Gabor Toth <Gabor.Toth2@arm.com> wr=
ote:
>
> Hi Guys,
>
> Currently pointer authentication is disabled at the beginning of the SP-s a=
nd is enabled after boot_init_primary_late here:
> https://github.com/OP-TEE/optee_os/blob/master/core/arch/arm/kernel/en
> try_a64.S#L385
>
> We would like to have it already enabled when the SP starts running to prot=
ect all the code and to also avoid problems like having the feature enabled b=
etween a paciasp-autiasp pair.
> I tried moving the feature enablement right before the initialization of th=
e SP-s, here:
> https://github.com/OP-TEE/optee_os/blob/master/core/arch/arm/kernel/bo
> ot.c#L1064
>
> When __thread_enter_user_mode is called thread_core_local[0] keys are used =
by the feature, but before switching to user mode the related registers are s=
et to threads[0].keys and not returned to the original values resulting in ex=
ception.
>
> I see three possible ways to solve this:
>
>   *   Enable PAC before SP initialization is started and restore the origin=
al keys in functions that change them if the feature is enabled.
>   *   Enable PAC before SP initialization is started and disable the protec=
tion (by attribute) for functions that change keys to avoid such issues.
>   *   Keep enablement like this and disable the protection for the related =
functions in trusted-services. We would like to avoid this solution due to co=
mpatibility issues with other SPMC implementations.
>
> My problem is that I do not understand the purpose of thread_core_local[n].=
keys and threads[n].keys, why are there two different key pairs?

Each execution context has its own pair of PAC keys to make it harder for one=
 execution context to write something useful into the stack of another execut=
ion context.

> Is it a bug that the original keys are not restored or is intentional like =
this?

During boot, until the first exit into the normal world, OP-TEE doesn't have =
a clear difference between preemptible thread and atomic contexts. Until now =
we have used a thread-like context when needed by certain functions and then =
switched back to an atomic context. SPs are initialized during this phase so =
which context is used is more by chance than by design.

> Do you have an idea what would be the best solution for implementing this c=
hange?

SPs should be initialized at a later step when SCTLR_ENIA has been enabled. E=
ach SP should use its own pair of PAC keys, they should not try to reuse anyt=
hing from the thread context or atomic per CPU context.

Cheers,
Jens

--===============0691115527726200048==--

