From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v2] optee: Do not send requests to supplicant during shutdown
Date: Thu, 27 Jan 2022 12:40:43 +0530
Message-ID: 
 <CAFA6WYN_=9KdJpWr3WUkN3C4n-3V164J6_aqJAjvDZeoFm+VtA@mail.gmail.com>
In-Reply-To: <ed6debc2-7610-c258-fa90-a11dcb4b3d35@axis.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7651221087587447261=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7651221087587447261==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Jan 2022 at 16:18, Lars Persson <larper@axis.com> wrote:
>
>
>
> On 2022-01-25 07:05, Sumit Garg wrote:
> > On Tue, 25 Jan 2022 at 01:57, Jens Wiklander <jens.wiklander@linaro.org>
> > wrote:
> >>
> >> On Mon, Jan 24, 2022 at 6:48 PM Lars Persson <larper@axis.com> wrote:
> >> >
> >> >
> >> >
> >> > On 2022-01-24 06:56, Sumit Garg wrote:
> >> > > Hi Lars,
> >> > >
> >> > > On Thu, 20 Jan 2022 at 16:10, Lars Persson <larper@axis.com> wrote:
> >> > >>
> >> > >> The addition of a shutdown hook by commit f25889f93184 ("optee:
> >> > >> fix tee out of memory failure seen during kexec reboot") introduced=
 a
> >> > >> kernel shutdown regression that can be triggered after running the
> >> > >> xtest suites.
> >> > >>
> >> > >> Once the shutdown hook is called it is not possible to communicate =
any
> >> > >> more with the supplicant process because the system is not scheduli=
ng
> >> > >> task any longer. Thus if the optee driver shutdown path receives a
> >> > >> supplicant RPC request from the OP-TEE we will deadlock the kernel's
> >> > >> shutdown.
> >> > >>
> >> > >> This unexpected event will in fact occur after the xtest suite has
> >> > >> been run. It seems some cached SHM kept alive a context object which
> >> > >> in turn kept alive a session towards a PTA or TA. Closing the sessi=
on
> >> > >> results in a socket RPC command being sent back from OP-TEE.
> >> > >>
> >> > >> This sequence of events is captured by a 5.15 kernel annotated with
> >> > >> extra prints:
> >> > >>
> >> > >>  Calling OPTEE_SMC_DISABLE_SHM_CACHE
> >> > >>  OPTEE_SMC_DISABLE_SHM_CACHE returned 0
> >> > >>   freeing SHM ptr 0xFFFFFF8001079380
> >> > >>  Calling OPTEE_SMC_DISABLE_SHM_CACHE
> >> > >>  OPTEE_SMC_DISABLE_SHM_CACHE returned 0
> >> > >>   freeing SHM ptr 0xFFFFFF8001CC5580
> >> > >>  Calling OPTEE_SMC_DISABLE_SHM_CACHE
> >> > >>  OPTEE_SMC_DISABLE_SHM_CACHE returned 0
> >> > >>   freeing SHM ptr 0xFFFFFF8006308A80
> >> > >>  Calling OPTEE_SMC_DISABLE_SHM_CACHE
> >> > >>  OPTEE_SMC_DISABLE_SHM_CACHE returned 0
> >> > >>   freeing SHM ptr 0xFFFFFF8006308B00
> >> > >>  optee: optee_handle_rpc: a0=3D0XFFFF0000 a1=3D0XA0 a2=3D0X0
> >> > >>  optee: optee_handle_rpc: a0=3D0XFFFF0005 a1=3D0XFFFFFF80 a2=3D0X61=
E6500
> >> > >>  optee: handle_rpc_func_cmd: cmd =3D 0XA
> >> > >>  optee_supp_thrd_req: func=3D0XA
> >> > >>
> >> > >
> >> > > This looks like another side effect (earlier known one is here [1]) =
of
> >> > > shared memory cache being allocated via RPC in a particular client's
> >> > > context. There is an appropriate fix from Jens here [2] to rather use
> >> > > driver internal tee_contex for RPC allocations. Can you try that and
> >> > > let us know if you still observe this issue?
> >> > >
> >> > > [1] https://github.com/OP-TEE/optee_os/issues/1918
> > <https://github.com/OP-TEE/optee_os/issues/1918>
> >> > > <https://github.com/OP-TEE/optee_os/issues/1918
> > <https://github.com/OP-TEE/optee_os/issues/1918>>
> >> > > [2]
> >> > > https://lore.kernel.org/lkml/20220114150824.3578829-8-jens.wiklander=
(a)linaro.org/
> > <https://lore.kernel.org/lkml/20220114150824.3578829-8-jens.wiklander@l=
inaro.org/>
> >> > > <https://lore.kernel.org/lkml/20220114150824.3578829-8-jens.wiklande=
r@linaro.org/
> > <https://lore.kernel.org/lkml/20220114150824.3578829-8-jens.wiklander@l=
inaro.org/>>
> >> > >
> >> > > -Sumit
> >> > >
> >> >
> >> > Indeed it seems this is the root cause. Backporting the patches to 5.15
> >> > also fixes our shutdown deadlock.
> >>
> >> That's good to hear.
> >>
> >> >
> >> > Nevertheless I prefer to have this extra guard in the supplicant
> >> > interface to prevent other shutdown deadlocks in the future.
> >>
> >> Yes, I agree, this still makes sense. Perhaps with an updated
> >> description to avoid unnecessary confusion when applied on top of my
> >> "tee: shared memory updates" patches.
> >>
> >
> > That's fine with me and we should drop the fixes tag as well.
> >
>
> Should we really drop the Fixes ? Depending on if and when the SHM
> owning context patch is backported, this fix may still be relevant for
> the 5.15 LTS branch.

I rather consider this as a robustness patch where the actual problem
is being fixed by Jens patch. I hope we should be able to target Jens
patch for 5.17 as a fix which should be backported to affected stable
releases.

-Sumit

>
> /Lars
>
>

--===============7651221087587447261==--

