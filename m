From: Arnd Bergmann <arnd@arndb.de>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: Add support for supplicant timeout
Date: Fri, 31 Jan 2025 12:32:59 +0100
Message-ID: <11d19be4-85a2-40dd-b3c6-07bbdd794df0@app.fastmail.com>
In-Reply-To: <
 <CAFA6WYNj0aWnV+jxoxHU7OOg8oWC2-AboUMztxaPCDQuO+c8gg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1040064672696046754=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1040064672696046754==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025, at 12:06, Sumit Garg wrote:
> On Tue, 28 Jan 2025 at 13:49, Jens Wiklander <jens.wiklander@linaro.org> =
wrote:
>> >
>> > As far as I can tell, even that DEFAULT_HUNG_TASK_TIMEOUT
>> > limit is only for tasks that are in an unkillable state for more
>> > than two minutes, but the supplicant not providing results
>> > to the kernel could also happen when it waits in a killable
>> > or interruptible state, or when it does multiple I/Os in a
>> > row that each block for a time under 120 seconds.
>
> The supplicant itself can be in a killable state but the client
> application which will be waiting for it in the kernel is in
> unkillable state. So if a shutdown/reboot is issued at that point
> which has to kill the client application first and then the
> tee-supplicant, it will just cause the system to hang up. That is a
> real problem that I am trying to address here.

Is the client the one waiting in optee_supp_thrd_req(), or
is that the supplicant?

If the problem is the client being unkillable at the moment,
could you address that by using wait_even_killable() or
mutex_lock_killable() and just bail out safely? I assume
at the point the system is rebooting, there is no need to
wait for the supplicant to complete, other than making sure
the function can return without running into undefined state
of the kernel.

>> > A single sector write to an eMMC can easily take multiple
>> > seconds by itself when nothing is going on and the device is
>> > in need of garbage collection. If the system is already in
>> > low memory or there are other tasks writing to the file system,
>> > you can have many such I/O operations queued up in the device
>> > when it adds another I/O to the back of the queue.
>>
>> Adding a timeout means we must somehow handle them to avoid spurious error=
s.
>>
>
> The timeout I am proposing here as default being 2 minutes is just for
> a single tee-supplicant RPC request. I suppose that should be
> sufficient to avoid any spurious errors.

It won't guarantee that, but if there is a 2 minute delay, that
likely means that the system has become quite unusable from being
slow, even if it hasn't otherwise misbehaved to that point.

     Arnd

--===============1040064672696046754==--

