From: Naman Jain <quic_namajain@quicinc.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v3 1/7] remoteproc: Add TEE support
Date: Thu, 22 Feb 2024 05:42:37 +0000
Message-ID: <71a6eb2e-bb13-4b6b-82b6-f51bdb6d164e@quicinc.com>
In-Reply-To: <20240214172127.1022199-2-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1887693983050118622=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1887693983050118622==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 2/14/2024 10:51 PM, Arnaud Pouliquen wrote:
> From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>=20
> Add a remoteproc TEE (Trusted Execution Environment) driver
> that will be probed by the TEE bus. If the associated Trusted
> application is supported on secure part this device offers a client
> interface to load a firmware in the secure part.
> This firmware could be authenticated and decrypted by the secure
> trusted application.
>=20
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---

<...>

> +};
> +
> +static struct tee_rproc__context *tee_rproc_ctx;
> +
> +static void prepare_args(struct tee_rproc *trproc, int cmd,
> +			 struct tee_ioctl_invoke_arg *arg,
> +			 struct tee_param *param, unsigned int num_params)

s/prepare_args/tee_rproc_prepare_args ?

please align function args in nextline with (.
Eg:=20
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drive=
rs/remoteproc/remoteproc_sysfs.c?h=3Dv6.8-rc5#n13

> +{
> +	memset(arg, 0, sizeof(*arg));
> +	memset(param, 0, MAX_TEE_PARAM_ARRY_MEMBER * sizeof(*param));
> +
> +	arg->func =3D cmd;

Regards,
Naman Jain


--===============1887693983050118622==--

