From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH] tee: optee: Fix missing devices unregister during optee_remove
Date: Tue, 12 Oct 2021 19:03:48 +0100
Message-ID: <20211012180348.zalanzdw3ykqg4db@bogus>
In-Reply-To: <20211012073116.4156054-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3412600507821596906=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3412600507821596906==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, Oct 12, 2021 at 01:01:16PM +0530, Sumit Garg wrote:
> When OP-TEE driver is built as a module, OP-TEE client devices
> registered on TEE bus during probe should be unregistered during
> optee_remove. So implement optee_unregister_devices() accordingly.
> 
> Fixes: c3fa24af9244 ("tee: optee: add TEE bus device enumeration support")
> Reported-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/tee/optee/core.c          |  3 +++
>  drivers/tee/optee/device.c        | 22 ++++++++++++++++++++++
>  drivers/tee/optee/optee_private.h |  1 +
>  3 files changed, 26 insertions(+)
> 
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index ccad3c7c8f6d..3915dc574503 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -586,6 +586,9 @@ static int optee_remove(struct platform_device *pdev)
>  {
>  	struct optee *optee = platform_get_drvdata(pdev);
>  
> +	/* Unregister OP-TEE specific client devices on TEE bus */
> +	optee_unregister_devices();
> +

This is not based on FF-A support series by Jens I assume. I added
optee_unregister_devices to optee_remove_common and that fixes the issue
I reported. I haven't followed the comments by Jens on the approach yet.

-- 
Regards,
Sudeep

--===============3412600507821596906==--

