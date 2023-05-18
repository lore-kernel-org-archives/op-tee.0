From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v8 4/4] firmware: arm_scmi: optee: use optee system invocation
Date: Thu, 18 May 2023 11:53:07 +0530
Message-ID: 
 <CAFA6WYMyJrW25sdZRkQHDje72+tLDw4T+bjB6tmVf8XH0De1RQ@mail.gmail.com>
In-Reply-To: <20230516125111.2690204-5-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9143403160243836360=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============9143403160243836360==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 16 May 2023 at 18:24, Etienne Carriere
<etienne.carriere@linaro.org> wrote:
>
> Changes SCMI optee transport to call tee_client_system_session()
> to request optee driver to provision an entry context in OP-TEE
> for processing OP-TEE messages. This prevents possible deadlock
> in case OP-TEE threads are all consumed while these may be waiting
> for a clock or regulator to be enable which SCMI OP-TEE service which
> requires a free thread context to execute.
>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
> No change since v7
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> No change since v6
>
> Changes since v5:
> - Applied Sudeep's review tag
>
> Changes since v4:
> - Updated to new API function tee_client_system_session() introduced
>   in patch v5 2/3.
>
> No change since v3
>
> Changes since v2:
> - Fixed syntax issues (missing ';' chars), reported by kernel test robot.
>
> Changes since v1:
> - Updated to use new tee API functions tee_client_request_system_context()
>   and tee_client_release_system_context().
> ---
>  drivers/firmware/arm_scmi/optee.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/=
optee.c
> index e123de6e8c67..25bfb465484d 100644
> --- a/drivers/firmware/arm_scmi/optee.c
> +++ b/drivers/firmware/arm_scmi/optee.c
> @@ -440,6 +440,10 @@ static int scmi_optee_chan_setup(struct scmi_chan_info=
 *cinfo, struct device *de
>         if (ret)
>                 goto err_free_shm;
>
> +       ret =3D tee_client_system_session(scmi_optee_private->tee_ctx, chan=
nel->tee_session);
> +       if (ret)
> +               dev_warn(dev, "Could not switch to system session, do best =
effort\n");
> +
>         ret =3D get_channel(channel);
>         if (ret)
>                 goto err_close_sess;
> --
> 2.25.1
>

--===============9143403160243836360==--

