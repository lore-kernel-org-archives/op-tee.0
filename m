From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 5/5] MAINTAINERS: tee: tstee: Add entry
Date: Tue, 26 Mar 2024 12:01:34 +0530
Message-ID: 
 <CAFA6WYPghVHUG_4WkT7b00CxP=jWXfK=twPEn5DrbZabQon9Qg@mail.gmail.com>
In-Reply-To: <20240325151105.135667-6-balint.dobszay@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4110775835794901583=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4110775835794901583==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 25 Mar 2024 at 20:42, Balint Dobszay <balint.dobszay@arm.com> wrote:
>
> Create an entry for the newly added Trusted Services TEE driver, with
> Sudeep and myself as maintainers.
>
> Signed-off-by: Balint Dobszay <balint.dobszay@arm.com>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/MAINTAINERS b/MAINTAINERS
> index fd221a7d4d1c..eaa89feabd25 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22470,6 +22470,15 @@ F:     Documentation/ABI/testing/configfs-tsm
>  F:     drivers/virt/coco/tsm.c
>  F:     include/linux/tsm.h
>
> +TRUSTED SERVICES TEE DRIVER
> +M:     Balint Dobszay <balint.dobszay@arm.com>
> +M:     Sudeep Holla <sudeep.holla@arm.com>
> +L:     linux-arm-kernel(a)lists.infradead.org (moderated for non-subscribe=
rs)
> +L:     trusted-services(a)lists.trustedfirmware.org
> +S:     Maintained
> +F:     Documentation/tee/ts-tee.rst
> +F:     drivers/tee/tstee/
> +
>  TTY LAYER AND SERIAL DRIVERS
>  M:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>  M:     Jiri Slaby <jirislaby@kernel.org>
> --
> 2.34.1
>

--===============4110775835794901583==--

