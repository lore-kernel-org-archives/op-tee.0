From: Tyler Hicks <tyhicks@linux.microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 2/2] firmware: tee_bnxt: implement shutdown method to
 handle kexec reboots
Date: Thu, 18 Mar 2021 15:55:36 -0500
Message-ID: <20210318205536.GB6446@sequoia>
In-Reply-To: <20210225090610.242623-3-allen.lkml@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3492537175789657855=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3492537175789657855==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 2021-02-25 14:36:10, Allen Pais wrote:
> From: Allen Pais <apais@linux.microsoft.com>
>=20
>  On kexec reboot the firmware driver fails to deallocate
> shm memory leading to a memory leak. Implement .shutdown()
> method to handle kexec reboots and to release shm buffers
> correctly.
>=20
> Signed-off-by: Allen Pais <apais@linux.microsoft.com>

Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>

Tyler

> ---
>  drivers/firmware/broadcom/tee_bnxt_fw.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/firmware/broadcom/tee_bnxt_fw.c b/drivers/firmware/bro=
adcom/tee_bnxt_fw.c
> index ed10da5313e8..4c62e044a99f 100644
> --- a/drivers/firmware/broadcom/tee_bnxt_fw.c
> +++ b/drivers/firmware/broadcom/tee_bnxt_fw.c
> @@ -242,6 +242,14 @@ static int tee_bnxt_fw_remove(struct device *dev)
>  	return 0;
>  }
> =20
> +static void tee_bnxt_fw_shutdown(struct device *dev)
> +{
> +	tee_shm_free(pvt_data.fw_shm_pool);
> +	tee_client_close_session(pvt_data.ctx, pvt_data.session_id);
> +	tee_client_close_context(pvt_data.ctx);
> +	pvt_data.ctx =3D NULL;
> +}
> +
>  static const struct tee_client_device_id tee_bnxt_fw_id_table[] =3D {
>  	{UUID_INIT(0x6272636D, 0x2019, 0x0716,
>  		    0x42, 0x43, 0x4D, 0x5F, 0x53, 0x43, 0x48, 0x49)},
> @@ -257,6 +265,7 @@ static struct tee_client_driver tee_bnxt_fw_driver =3D {
>  		.bus		=3D &tee_bus_type,
>  		.probe		=3D tee_bnxt_fw_probe,
>  		.remove		=3D tee_bnxt_fw_remove,
> +		.shutdown	=3D tee_bnxt_fw_shutdown,
>  	},
>  };
> =20
> --=20
> 2.25.1
>=20

--===============3492537175789657855==--

