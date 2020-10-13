From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v7 4/4] MAINTAINERS: Add entry for TEE based Trusted Keys
Date: Tue, 13 Oct 2020 05:21:57 +0300
Message-ID: <20201013022157.GA47751@linux.intel.com>
In-Reply-To: <1602065268-26017-5-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0162253230801483666=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0162253230801483666==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, Oct 07, 2020 at 03:37:48PM +0530, Sumit Garg wrote:
> Add MAINTAINERS entry for TEE based Trusted Keys framework.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 48aff80..eb3d889 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9663,6 +9663,14 @@ F:	include/keys/trusted-type.h
>  F:	include/keys/trusted_tpm.h
>  F:	security/keys/trusted-keys/
>  
> +KEYS-TRUSTED-TEE
> +M:	Sumit Garg <sumit.garg@linaro.org>
> +L:	linux-integrity(a)vger.kernel.org
> +L:	keyrings(a)vger.kernel.org
> +S:	Supported
> +F:	include/keys/trusted_tee.h
> +F:	security/keys/trusted-keys/trusted_tee.c
> +
>  KEYS/KEYRINGS
>  M:	David Howells <dhowells@redhat.com>
>  M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> -- 
> 2.7.4

I'm sorry but I think I have changed my mind on this. This has been
spinning for a while and sometimes conclusions change over the time.

I don't think that we really need a separate subsystem tag. I'd be for a
new M-entry or R-entry to the existing subsystem tag. It's essential to
have ack from someone with ARM and TEE knowledge but this way too heavy
for the purpose.

I also see it the most manageable if the trusted keys PR's come from a
single source.

/Jarkko

--===============0162253230801483666==--

