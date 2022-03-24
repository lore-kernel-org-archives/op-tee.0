From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4] rtc: optee: add RTC driver for OP-TEE RTC PTA
Date: Thu, 24 Mar 2022 08:51:44 +0100
Message-ID: 
 <CAHUa44EVLYiA6u4QVyPQTnK0-=4UgL-RK4i=wDYfQW9daCCkvw@mail.gmail.com>
In-Reply-To: <20220308133505.471601-1-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0864418583606703408=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0864418583606703408==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 8, 2022 at 2:36 PM Cl=C3=A9ment L=C3=A9ger <clement.leger@bootl=
in.com> wrote:
>
> This drivers allows to communicate with a RTC PTA handled by OP-TEE [1].
> This PTA allows to query RTC information, set/get time and set/get
> offset depending on the supported features.
>
> [1] https://github.com/OP-TEE/optee_os/pull/5179
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
> ---
>
> Changes in v4:
>  - Remove error prints except the ones in probe
>
> Changes in v3 (was resent as a second v2 due to a mistake);
>  - Fix error messages to include ret value and fix wrong IOCTL names
>  - Use 100 columns char limit
>
> Changes in v2:
>  - Rebased over tee-shm-for-v5.18
>  - Switch to tee_shm_alloc_kernel_buf()
>  - Use export_uuid() to copy uuid
>  - Fix warnings reported by checkpatch
>  - Free SHM in error exit path
>
>  MAINTAINERS             |   6 +
>  drivers/rtc/Kconfig     |  10 ++
>  drivers/rtc/Makefile    |   1 +
>  drivers/rtc/rtc-optee.c | 362 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 379 insertions(+)
>  create mode 100644 drivers/rtc/rtc-optee.c

Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>

--===============0864418583606703408==--

