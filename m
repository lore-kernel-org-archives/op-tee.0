From: Arnd Bergmann <arnd@arndb.de>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [GIT PULL] TEE updates for 6.16
Date: Fri, 09 May 2025 23:14:30 +0200
Message-ID: <e5bfb069-6adb-4757-a52c-bb3635990686@app.fastmail.com>
In-Reply-To: <20250509065114.GA4188600@rayden>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5410545614534514028=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5410545614534514028==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025, at 08:51, Jens Wiklander wrote:
> ----------------------------------------------------------------
> Small TEE updates for v6.16
>
> - Remove an unnecessary NULL check before release_firmware() in the
>   OP-TEE driver
> - Prevent a size wrap in the TEE subsystem. The wrap would have been caught
>   later in the code so no security consequences.
>
> ----------------------------------------------------------------
> Chen Ni (1):
>       tee: optee: smc: remove unnecessary NULL check before release_firmwar=
e()
>
> Jann Horn (1):
>       tee: Prevent size calculation wraparound on 32-bit kernels
>

The second patch looks like it should be a bugfix for 6.15 instead,
any reason to have it only in 6.16?

      Arnd

--===============5410545614534514028==--

