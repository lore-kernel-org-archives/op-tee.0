From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 0/2] OP-TEE FF-A notifications
Date: Mon, 30 Oct 2023 11:32:47 +0530
Message-ID: 
 <CAFA6WYOYRQ4BgyUE90EwAVULsa=qDkZ4C=0rX49e-E3LOvyz6Q@mail.gmail.com>
In-Reply-To: <20231026080409.4149616-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0085649786095331851=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0085649786095331851==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On Thu, 26 Oct 2023 at 13:34, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
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

It's good to see FF-A notifications support coming through. The good
aspect here is that FF-A uses a common secure world SGI for
notifications and doesn't have to deal with platform specific reserved
SPI for notifications.

From OP-TEE point of view I think most of the secure SGI donation base
would be common, so can we switch the SMC ABI to use this donated
secure world SGI for notifications too?

-Sumit

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
> Thanks,
> Jens
>
> Jens Wiklander (2):
>   optee: provide optee_do_bottom_half() as a common function
>   optee: ffa_abi: add asynchronous notifications
>
>  drivers/tee/optee/call.c          | 31 ++++++++++-
>  drivers/tee/optee/ffa_abi.c       | 91 ++++++++++++++++++++++++++++++-
>  drivers/tee/optee/optee_ffa.h     | 28 ++++++++--
>  drivers/tee/optee/optee_private.h |  9 ++-
>  drivers/tee/optee/smc_abi.c       | 36 ++----------
>  5 files changed, 153 insertions(+), 42 deletions(-)
>
>
> base-commit: bcefd1bf63b1ec9bb08067021cf47f0fad96f395
> --
> 2.34.1
>

--===============0085649786095331851==--

