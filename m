From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 1/1] tee: optee: do not check memref size on return from
 Secure World
Date: Thu, 01 Apr 2021 09:40:52 +0200
Message-ID: 
 <CAHUa44HYkxMZpGx=iVKPqTSyTVhLm9L+_OkcNoAqGMmVjU7gxA@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYPryB+9W6EGXvea07=JH8_cfHKF8a4BDEyPeqPVkzvutw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0411902441908803065=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0411902441908803065==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, Mar 25, 2021 at 3:18 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Mon, 22 Mar 2021 at 16:11, Jerome Forissier via OP-TEE
> <op-tee@lists.trustedfirmware.org> wrote:
> >
> > When Secure World returns, it may have changed the size attribute of the
> > memory references passed as [in/out] parameters. The GlobalPlatform TEE
> > Internal Core API specification does not restrict the values that this
> > size can take. In particular, Secure World may increase the value to be
> > larger than the size of the input buffer to indicate that it needs more.
> >
> > Therefore, the size check in optee_from_msg_param() is incorrect and
> > needs to be removed. This fixes a number of failed test cases in the
> > GlobalPlatform TEE Initial Configuratiom Test Suite v2_0_0_0-2017_06_09
> > when OP-TEE is compiled without dynamic shared memory support
> > (CFG_CORE_DYN_SHM=n).
> >
> > Suggested-by: Jens Wiklander <jens.wiklander@linaro.org>
> > Signed-off-by: Jerome Forissier <jerome@forissier.org>
> > ---
> >  drivers/tee/optee/core.c | 10 ----------
> >  1 file changed, 10 deletions(-)
> >
>
> Looks good to me.
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

Thanks, I'm picking this up.

Cheers,
Jens

--===============0411902441908803065==--

