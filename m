From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: Add support for supplicant timeout
Date: Mon, 03 Feb 2025 13:33:07 +0530
Message-ID: 
 <CAFA6WYOHbv4GA2j7DWf25QFGjoyzp7szoxhij4CMFjg+NQvN9w@mail.gmail.com>
In-Reply-To: <11d19be4-85a2-40dd-b3c6-07bbdd794df0@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4434148383990486112=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4434148383990486112==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 31 Jan 2025 at 17:03, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Jan 31, 2025, at 12:06, Sumit Garg wrote:
> > On Tue, 28 Jan 2025 at 13:49, Jens Wiklander <jens.wiklander@linaro.org=
> wrote:
> >> >
> >> > As far as I can tell, even that DEFAULT_HUNG_TASK_TIMEOUT
> >> > limit is only for tasks that are in an unkillable state for more
> >> > than two minutes, but the supplicant not providing results
> >> > to the kernel could also happen when it waits in a killable
> >> > or interruptible state, or when it does multiple I/Os in a
> >> > row that each block for a time under 120 seconds.
> >
> > The supplicant itself can be in a killable state but the client
> > application which will be waiting for it in the kernel is in
> > unkillable state. So if a shutdown/reboot is issued at that point
> > which has to kill the client application first and then the
> > tee-supplicant, it will just cause the system to hang up. That is a
> > real problem that I am trying to address here.
>
> Is the client the one waiting in optee_supp_thrd_req(), or
> is that the supplicant?

It's the client only.

>
> If the problem is the client being unkillable at the moment,
> could you address that by using wait_even_killable() or
> mutex_lock_killable() and just bail out safely? I assume
> at the point the system is rebooting, there is no need to
> wait for the supplicant to complete, other than making sure
> the function can return without running into undefined state
> of the kernel.

Thanks for the suggestion, it helps to resolve the shutdown/reboot
hung up issue we were observing. Incorporated your suggestion in v2.

>
> >> > A single sector write to an eMMC can easily take multiple
> >> > seconds by itself when nothing is going on and the device is
> >> > in need of garbage collection. If the system is already in
> >> > low memory or there are other tasks writing to the file system,
> >> > you can have many such I/O operations queued up in the device
> >> > when it adds another I/O to the back of the queue.
> >>
> >> Adding a timeout means we must somehow handle them to avoid spurious err=
ors.
> >>
> >
> > The timeout I am proposing here as default being 2 minutes is just for
> > a single tee-supplicant RPC request. I suppose that should be
> > sufficient to avoid any spurious errors.
>
> It won't guarantee that, but if there is a 2 minute delay, that
> likely means that the system has become quite unusable from being
> slow, even if it hasn't otherwise misbehaved to that point.

Agree.

-Sumit

--===============4434148383990486112==--

