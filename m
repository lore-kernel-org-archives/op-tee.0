From: Christoph Hellwig <hch@infradead.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [RFC PATCH 2/4] remoteproc: Add TEE support
Date: Tue, 23 May 2023 23:50:47 -0700
Message-ID: <ZG2zx+ARLO1a7wh5@infradead.org>
In-Reply-To: <20230523091350.292221-3-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8158496578867390832=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8158496578867390832==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 23, 2023 at 11:13:48AM +0200, Arnaud Pouliquen wrote:
> +	struct tee_param param[MAX_TEE_PARAM_ARRY_MEMB];
> +	struct tee_shm *fw_shm;
> +	int ret;
> +
> +	fw_shm =3D tee_shm_register_kernel_buf(tee_rproc_ctx->tee_ctx, (void *)fw=
->data, fw->size);
> +	if (IS_ERR(fw_shm)) {
> +		/* Fallback: Try to allocate memory in OP-TEE space */
> +		fw_shm =3D tee_shm_alloc_kernel_buf(tee_rproc_ctx->tee_ctx, fw->size);

> +EXPORT_SYMBOL(tee_rproc_load_fw);

Please stick to the EXPORT_SYMBOL_GPL of the underlying tee
infrastructure.

--===============8158496578867390832==--

