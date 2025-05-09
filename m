From: Jann Horn <jannh@google.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [GIT PULL] TEE updates for 6.16
Date: Fri, 09 May 2025 23:22:23 +0200
Message-ID: 
 <CAG48ez3JEg11GZTzmSHeXEDVz9vN68vWjTH+2sq_6+8eK0zkig@mail.gmail.com>
In-Reply-To: <e5bfb069-6adb-4757-a52c-bb3635990686@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4980387548291788189=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4980387548291788189==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 11:14=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, May 9, 2025, at 08:51, Jens Wiklander wrote:
> > ----------------------------------------------------------------
> > Small TEE updates for v6.16
> >
> > - Remove an unnecessary NULL check before release_firmware() in the
> >   OP-TEE driver
> > - Prevent a size wrap in the TEE subsystem. The wrap would have been caug=
ht
> >   later in the code so no security consequences.
> >
> > ----------------------------------------------------------------
> > Chen Ni (1):
> >       tee: optee: smc: remove unnecessary NULL check before release_firmw=
are()
> >
> > Jann Horn (1):
> >       tee: Prevent size calculation wraparound on 32-bit kernels
> >
>
> The second patch looks like it should be a bugfix for 6.15 instead,
> any reason to have it only in 6.16?

FWIW, it's more of a cleanup than a real bugfix; there is an unsigned
integer wraparound, but if that occurs, we're guaranteed to hit a
memory allocation bailout pretty much immediately afterwards. So I
think putting it in 6.16 is reasonable.

--===============4980387548291788189==--

