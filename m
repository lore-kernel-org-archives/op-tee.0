From: Arnd Bergmann <arnd@arndb.de>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v3] tee: optee: Fix supplicant wait loop
Date: Tue, 04 Feb 2025 08:45:03 +0100
Message-ID: <60cd3fcc-5d21-4b98-9a81-f5fbec2099fc@app.fastmail.com>
In-Reply-To: <20250204073418.491016-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8045027241002802814=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8045027241002802814==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, Feb 4, 2025, at 08:34, Sumit Garg wrote:
> OP-TEE supplicant is a user-space daemon and it's possible for it
> be hung or crashed or killed in the middle of processing an OP-TEE
> RPC call. It becomes more complicated when there is incorrect shutdown
> ordering of the supplicant process vs the OP-TEE client application which
> can eventually lead to system hang-up waiting for the closure of the
> client application.
>
> Allow the client process waiting in kernel for supplicant response to
> be killed rather than indefinitely waiting in an unkillable state. Also,
> a normal uninterruptible wait should not have resulted in the hung-task
> watchdog getting triggered, but the endless loop would.
>
> This fixes issues observed during system reboot/shutdown when supplicant
> got hung for some reason or gets crashed/killed which lead to client
> getting hung in an unkillable state. It in turn lead to system being in
> hung up state requiring hard power off/on to recover.
>
> Fixes: 4fb0a5eb364d ("tee: add OP-TEE driver")
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Jens, I assume you'll pick it up and send me a pull request, but
I can also pick it up directly if you have nothing else.

     Arnd

--===============8045027241002802814==--

