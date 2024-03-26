From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 5/5] MAINTAINERS: tee: tstee: Add entry
Date: Tue, 26 Mar 2024 10:09:02 +0000
Message-ID: <ZgKevs_YQYAhx98U@bogus>
In-Reply-To: <20240325151105.135667-6-balint.dobszay@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2791400615689818120=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2791400615689818120==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Mon, Mar 25, 2024 at 04:11:05PM +0100, Balint Dobszay wrote:
> Create an entry for the newly added Trusted Services TEE driver, with
> Sudeep and myself as maintainers.
>

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

> Signed-off-by: Balint Dobszay <balint.dobszay@arm.com>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fd221a7d4d1c..eaa89feabd25 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22470,6 +22470,15 @@ F:	Documentation/ABI/testing/configfs-tsm
>  F:	drivers/virt/coco/tsm.c
>  F:	include/linux/tsm.h
>  
> +TRUSTED SERVICES TEE DRIVER
> +M:	Balint Dobszay <balint.dobszay@arm.com>
> +M:	Sudeep Holla <sudeep.holla@arm.com>
> +L:	linux-arm-kernel(a)lists.infradead.org (moderated for non-subscribers)
> +L:	trusted-services(a)lists.trustedfirmware.org
> +S:	Maintained
> +F:	Documentation/tee/ts-tee.rst
> +F:	drivers/tee/tstee/
> +
>  TTY LAYER AND SERIAL DRIVERS
>  M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>  M:	Jiri Slaby <jirislaby@kernel.org>
> -- 
> 2.34.1
> 

-- 
Regards,
Sudeep

--===============2791400615689818120==--

