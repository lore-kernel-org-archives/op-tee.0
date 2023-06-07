From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [GIT PULL] AMDTEE fix for v6.5
Date: Wed, 07 Jun 2023 08:53:51 +0200
Message-ID: 
 <CAHUa44E5RjMqeTp1Sr_7=Eavu3T+q2YVg-V-_gLWpO5sjJ-Vhg@mail.gmail.com>
In-Reply-To: <0fac8e65-fe05-4dbf-a634-4620f764e2bd@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6589676985562513045=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6589676985562513045==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Tue, Jun 6, 2023 at 1:47=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Jun 6, 2023, at 09:58, Jens Wiklander wrote:
> > Hello arm-soc maintainers,
> >
> > Please pull this AMDTEE driver fix to add a return origin field to the
> > struct tee_cmd_load_ta used when loading a Trusted Application into the
> > AMDTEE. This change is backward compatible.
> >
> > Note that this isn't a usual Arm driver update. This targets AMD instead,
> > but is part of the TEE subsystem.
> >
> > Thanks,
> > Jens
> >
> > The following changes since commit f1fcbaa18b28dec10281551dfe6ed3a3ed80e3=
d6:
> >
> >   Linux 6.4-rc2 (2023-05-14 12:51:40 -0700)
> >
> > are available in the Git repository at:
> >
> >   https://git.linaro.org/people/jens.wiklander/linux-tee.git
> > tags/amdtee-fix-for-v6.5
> >
> > for you to fetch changes up to 436eeae0411acdfc54521ddea80ee76d4ae8a7ea:
>
> I see there is only one patch here, and it is marked as 'Cc: stable',
> so I assume  you meant this to be include in v6.4, not 6.5. Can you
> confirm that?

If you don't mind taking it for v6.4 that's even better.

Thanks,
Jens

>
>      Arnd

--===============6589676985562513045==--

