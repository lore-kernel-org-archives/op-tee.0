From: Gabor Toth <Gabor.Toth2@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: RE: Enable pointer authentication for the SP initialization
Date: Wed, 26 Jun 2024 13:09:08 +0000
Message-ID: <VI1PR08MB10174DE2EDBD33278C5EC205EA9D62@VI1PR08MB10174.eurprd08.prod.outlook.com>
In-Reply-To: <
 <CAHUa44EjyJT5TtZ0idTCu4o6ved+St6-=S3os5NHzgTKi0tm1Q@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6256616238859169657=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6256616238859169657==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,

" TAs use their own pauth keys, I think SPs should do the same. Or we're expo=
sing keys that shouldn't be exposed to SPs."
Yes I am implementing the same behavior as in case of TA-s. The SP-s have own=
 keys which are used when they are running.

Now everything is clear, thank you for the help!

Br,
G=C3=A1bor

-----Original Message-----
From: Jens Wiklander <jens.wiklander@linaro.org>=20
Sent: Wednesday, June 26, 2024 3:03 PM
To: Gabor Toth <Gabor.Toth2@arm.com>
Cc: op-tee(a)lists.trustedfirmware.org
Subject: Re: Enable pointer authentication for the SP initialization

Hi Gabor,

On Wed, Jun 26, 2024 at 12:29=E2=80=AFPM Gabor Toth <Gabor.Toth2@arm.com> w=
rote:
>
> Hi Jens,
>
> As I see after the SP-s return to SEL1 the context is restored and the paut=
h keys are set to the keys of the atomic context (kernels[n].keys). So the on=
ly problem is that at initialization the keys of the thread-line context (thr=
ead_core_local[n].keys) are used instead of the atomic ones.
>
> Since " which context is used is more by chance than by design", do=20
> you see anything against initializing the pauth keys to the keys of=20
> the atomic context instead of the kernel-like ones
> here: https://github.com/OP-TEE/optee_os/blob/master/core/arch/arm/kernel/e=
ntry_a64.S#L139 ?

No, at the point where this macro is used we're definitely in an atomic conte=
xt. I meant before that we're emulating a threaded context to the extent it's=
 needed at some places, for instance, to keep
mutex_lock() happy.

>
> With this change and moving the SP initialization right after enabling SCTL=
R_ENIA the feature seems to be working properly and the protection is already=
 enabled when the sp boot starts.

TAs use their own pauth keys, I think SPs should do the same. Or we're exposi=
ng keys that shouldn't be exposed to SPs.

Cheers,
Jens

>
> Br,
> G=C3=A1bor
>
> -----Original Message-----
> From: Jens Wiklander <jens.wiklander@linaro.org>
> Sent: Tuesday, June 25, 2024 3:21 PM
> To: Gabor Toth <Gabor.Toth2@arm.com>
> Cc: op-tee(a)lists.trustedfirmware.org
> Subject: Re: Enable pointer authentication for the SP initialization
>
> Hi Gabor,
>
> On Tue, Jun 25, 2024 at 1:16=E2=80=AFPM Gabor Toth <Gabor.Toth2@arm.com> =
wrote:
> >
> > Hi Guys,
> >
> > Currently pointer authentication is disabled at the beginning of the SP-s=
 and is enabled after boot_init_primary_late here:
> > https://github.com/OP-TEE/optee_os/blob/master/core/arch/arm/kernel/
> > en
> > try_a64.S#L385
> >
> > We would like to have it already enabled when the SP starts running to pr=
otect all the code and to also avoid problems like having the feature enabled=
 between a paciasp-autiasp pair.
> > I tried moving the feature enablement right before the initialization of =
the SP-s, here:
> > https://github.com/OP-TEE/optee_os/blob/master/core/arch/arm/kernel/
> > bo
> > ot.c#L1064
> >
> > When __thread_enter_user_mode is called thread_core_local[0] keys are use=
d by the feature, but before switching to user mode the related registers are=
 set to threads[0].keys and not returned to the original values resulting in =
exception.
> >
> > I see three possible ways to solve this:
> >
> >   *   Enable PAC before SP initialization is started and restore the orig=
inal keys in functions that change them if the feature is enabled.
> >   *   Enable PAC before SP initialization is started and disable the prot=
ection (by attribute) for functions that change keys to avoid such issues.
> >   *   Keep enablement like this and disable the protection for the relate=
d functions in trusted-services. We would like to avoid this solution due to =
compatibility issues with other SPMC implementations.
> >
> > My problem is that I do not understand the purpose of thread_core_local[n=
].keys and threads[n].keys, why are there two different key pairs?
>
> Each execution context has its own pair of PAC keys to make it harder for o=
ne execution context to write something useful into the stack of another exec=
ution context.
>
> > Is it a bug that the original keys are not restored or is intentional lik=
e this?
>
> During boot, until the first exit into the normal world, OP-TEE doesn't hav=
e a clear difference between preemptible thread and atomic contexts. Until no=
w we have used a thread-like context when needed by certain functions and the=
n switched back to an atomic context. SPs are initialized during this phase s=
o which context is used is more by chance than by design.
>
> > Do you have an idea what would be the best solution for implementing this=
 change?
>
> SPs should be initialized at a later step when SCTLR_ENIA has been enabled.=
 Each SP should use its own pair of PAC keys, they should not try to reuse an=
ything from the thread context or atomic per CPU context.
>
> Cheers,
> Jens

--===============6256616238859169657==--

