From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 0/2] OP-TEE FF-A notifications
Date: Tue, 07 Nov 2023 18:06:45 +0100
Message-ID: 
 <CAHUa44FfnUbQVE_+R-wU+fKE=v_ZhTb49VBM5bP7tdgYAT2nTQ@mail.gmail.com>
In-Reply-To: <20231107114630.GE954129@bogus>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3697180999104146371=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3697180999104146371==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 7, 2023 at 12:48=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com>=
 wrote:
>
> On Thu, Oct 26, 2023 at 10:04:07AM +0200, Jens Wiklander wrote:
> > Hi all,
> >
> > This patchset adds support for using FF-A notifications as a delivery
> > mechanism of asynchronous notifications from OP-TEE running in the secure
> > world. Support for asynchronous notifications via the SMC ABI was added in
> > [1], here we add the counterpart needed when using the the FF-A ABI.
> >
> > Support for FF-A notifications is added with [2] and this patch set is ba=
sed
> > on Sudeeps tree at [3].
> >
> > [1] https://lore.kernel.org/lkml/20211103090255.998070-1-jens.wiklander(a=
)linaro.org/
> > [2] https://lore.kernel.org/linux-arm-kernel/20231005-ffa_v1-1_notif-v4-0=
-cddd3237809c(a)arm.com/
> > [3] https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.gi=
t/tag/?h=3Dffa-updates-6.7
> >     commit bcefd1bf63b1 ("firmware: arm_ffa: Upgrade the driver version t=
o v1.1")
> >
>
> FWIW:
>
> Tested-by: Sudeep Holla <sudeep.holla@arm.com>

Thanks, much appreciated.

Cheers,
Jens

>
> --
> Regards,
> Sudeep

--===============3697180999104146371==--

