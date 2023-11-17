From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 0/2] OP-TEE FF-A notifications
Date: Fri, 17 Nov 2023 15:42:41 +0100
Message-ID: 
 <CAHUa44EXRjDqNjvf5dNVieopKvjVWgXh+NcEN=ec5W489fEORQ@mail.gmail.com>
In-Reply-To: <20231107160657.3798803-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5283099777251001998=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5283099777251001998==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 7, 2023 at 5:07=E2=80=AFPM Jens Wiklander <jens.wiklander@linar=
o.org> wrote:
>
> Hi all,
>
> This patchset adds support for using FF-A notifications as a delivery
> mechanism of asynchronous notifications from OP-TEE running in the secure
> world. Support for asynchronous notifications via the SMC ABI was added in
> [1], here we add the counterpart needed when using the the FF-A ABI.
>
> Support for FF-A notifications is added with [2] and this patch set is based
> on Sudeeps tree at [3].
>
> [1] https://lore.kernel.org/lkml/20211103090255.998070-1-jens.wiklander(a)l=
inaro.org/
> [2] https://lore.kernel.org/linux-arm-kernel/20231005-ffa_v1-1_notif-v4-0-c=
ddd3237809c(a)arm.com/
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/=
tag/?h=3Dffa-updates-6.7
>     commit bcefd1bf63b1 ("firmware: arm_ffa: Upgrade the driver version to =
v1.1")
>
> v1->v2:
> * Applied Sumit's Reviewed-by
> * Addressed Sumit's comment on "optee: ffa_abi: add asynchronous
>   notifications"
>
> Thanks,
> Jens
>
> Jens Wiklander (2):
>   optee: provide optee_do_bottom_half() as a common function
>   optee: ffa_abi: add asynchronous notifications
>
>  drivers/tee/optee/call.c          | 31 ++++++++++-
>  drivers/tee/optee/ffa_abi.c       | 93 ++++++++++++++++++++++++++++++-
>  drivers/tee/optee/optee_ffa.h     | 28 ++++++++--
>  drivers/tee/optee/optee_private.h |  9 ++-
>  drivers/tee/optee/smc_abi.c       | 36 ++----------
>  5 files changed, 155 insertions(+), 42 deletions(-)
>
>
> base-commit: bcefd1bf63b1ec9bb08067021cf47f0fad96f395
> --
> 2.34.1
>

I'm picking up this.

Thanks,
Jens

--===============5283099777251001998==--

