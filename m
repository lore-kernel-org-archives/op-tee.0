From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2] tee: optee: Fix supplicant wait loop
Date: Mon, 03 Feb 2025 16:44:58 +0530
Message-ID: 
 <CAFA6WYPt+DkOXd_0Sj5axH+kMx+NtEc+7rsrn93Mk9aDW2Sqbg@mail.gmail.com>
In-Reply-To: <65aedfdf-0a13-445d-956c-6945f1b49681@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9132332331680964114=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============9132332331680964114==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 3 Feb 2025 at 16:23, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Feb 3, 2025, at 10:31, Jens Wiklander wrote:
> > On Mon, Feb 3, 2025 at 9:00=E2=80=AFAM Sumit Garg <sumit.garg@linaro.or=
g> wrote:
>
> > Why not mutex_lock()? If we fail to acquire the mutex here, we will
> > quite likely free the req list item below at the end of this function
> > while it remains in the list.
>
> Right, I had mentioned mutex_lock_killable in an earlier reply,
> as I didn't know exactly where it hang. If we know that the
> wait_event_interruptible() was causing the hang, then the
> normal mutex_lock should be fine.
>

Yeah for my current test scenario mutex_lock() works fine too but I
added mutex_lock_killable() just in another theoretical corner case
being stuck acquiring mutex while someone is trying to kill the
process. But let's avoid over complexity for the time being with a
simpler mutex_lock() approach.

-Sumit

--===============9132332331680964114==--

