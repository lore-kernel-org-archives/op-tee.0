From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] optee: use driver internal tee_contex for some rpc
Date: Thu, 03 Feb 2022 14:08:24 +0100
Message-ID: 
 <CAHUa44EDnkwYLJGKqDmmkq1kgHEWo4u_1d3yZzrSM=vj8PMo2Q@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYNqSKwtRYN+dudreG=ZuRLhzsbNgy8wwjrYuSR6oq_79w@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0184919055434999413=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0184919055434999413==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 28, 2022 at 6:46 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Thu, 27 Jan 2022 at 19:59, Jens Wiklander <jens.wiklander@linaro.org> =
wrote:
> >
> > Adds a driver private tee_context by moving the tee_context in struct
> > optee_notif to struct optee. This tee_context was previously used when
> > doing internal calls to secure world to deliver notification.
> >
> > The new driver internal tee_context is now also when allocating driver
> > private shared memory. This decouples the shared memory object from its
> > original tee_context. This is needed when the life time of such a memory
> > allocation outlives the client tee_context.
> >
> > This patch fixes the problem described below:
> >
> > The addition of a shutdown hook by commit f25889f93184 ("optee: fix tee o=
ut
> > of memory failure seen during kexec reboot") introduced a kernel shutdown
> > regression that can be triggered after running the OP-TEE xtest suites.
> >
> > Once the shutdown hook is called it is not possible to communicate any mo=
re
> > with the supplicant process because the system is not scheduling task any
> > longer. Thus if the optee driver shutdown path receives a supplicant RPC
> > request from the OP-TEE we will deadlock the kernel's shutdown.
> >
> > Fixes: f25889f93184 ("optee: fix tee out of memory failure seen during ke=
xec reboot")
> > Fixes: 217e0250cccb ("tee: use reference counting for tee_context")
> > Reported-by: Lars Persson <larper@axis.com>
> > Cc: stable(a)vger.kernel.org
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >
> > This patch is from "optee: add driver private tee_context" and "optee: use
> > driver internal tee_contex for some rpc" in [1] combined into one patch f=
or
> > easier tracking. It turned out that those two patches fixes reported
> > problem so I'm breaking out this from the patchset in order to target it
> > for the v5.17.
> >
> > [1] https://lore.kernel.org/lkml/20220125162938.838382-1-jens.wiklander(a=
)linaro.org/
> >
> >  drivers/tee/optee/core.c          |  1 +
> >  drivers/tee/optee/ffa_abi.c       | 77 +++++++++++++++++--------------
> >  drivers/tee/optee/optee_private.h |  5 +-
> >  drivers/tee/optee/smc_abi.c       | 48 +++++++------------
> >  4 files changed, 64 insertions(+), 67 deletions(-)
> >
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

Thanks, I'm picking this up now.

/Jens

--===============0184919055434999413==--

