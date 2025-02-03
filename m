From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2] tee: optee: Fix supplicant wait loop
Date: Mon, 03 Feb 2025 16:25:43 +0530
Message-ID: 
 <CAFA6WYNJf2axMuxHmMP2OOdvTJc=YEMEAcSDHZDmiinkMAdcfw@mail.gmail.com>
In-Reply-To: <15a801d6-2274-4772-bbe3-5d2083b91b64@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4920757922115321446=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4920757922115321446==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Arnd,

On Mon, 3 Feb 2025 at 13:46, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Feb 3, 2025, at 09:00, Sumit Garg wrote:
> > OP-TEE supplicant is a user-space daemon and it's possible for it
> > being hung or crashed or killed in the middle of processing an OP-TEE
> > RPC call. It becomes more complicated when there is incorrect shutdown
> > ordering of the supplicant process vs the OP-TEE client application which
> > can eventually lead to system hang-up waiting for the closure of the
> > client application.
> >
> > Allow the client process waiting in kernel for supplicant response to
> > be killed rather than indefinitetly waiting in an unkillable state.
>
> It would be good to mention that the existing version ends up in
> a busy-loop here because of the broken wait_for_completion_interruptible()
> loop.
>
> A normal uninterruptible wait should not have resulted in the hung-task
> watchdog getting triggered, but the endless loop would.

Sure, I will add that.

>
> > +     if (wait_for_completion_killable(&req->c)) {
> > +             if (!mutex_lock_killable(&supp->mutex)) {
> >                       if (req->in_queue) {
>
> Using mutex_trylock() here is probably clearer than
> mutex_lock_killable(), since a task that is already in the
> process of getting killed won't ever wait for the mutex.
> mutex_lock_killable() does try to get the lock first though
> if nobody else holds it already, which is the same as trylock.

Let's follow-up on this in the other thread.

-Sumit

>
>      Arnd

--===============4920757922115321446==--

