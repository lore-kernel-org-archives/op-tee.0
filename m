From: Arnd Bergmann <arnd@arndb.de>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2] tee: optee: Fix supplicant wait loop
Date: Mon, 03 Feb 2025 11:53:11 +0100
Message-ID: <65aedfdf-0a13-445d-956c-6945f1b49681@app.fastmail.com>
In-Reply-To: <
 <CAHUa44FXzL-MZ5y7x6qrsn3GJR=1oR8bbRVCv6ZTvDRoQmENEg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6844974414977172898=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6844974414977172898==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, Feb 3, 2025, at 10:31, Jens Wiklander wrote:
> On Mon, Feb 3, 2025 at 9:00 AM Sumit Garg <sumit.garg@linaro.org> wrote:

> Why not mutex_lock()? If we fail to acquire the mutex here, we will
> quite likely free the req list item below at the end of this function
> while it remains in the list.

Right, I had mentioned mutex_lock_killable in an earlier reply,
as I didn't know exactly where it hang. If we know that the
wait_event_interruptible() was causing the hang, then the
normal mutex_lock should be fine.

     Arnd

--===============6844974414977172898==--

