From: Jarkko Sakkinen <jarkko@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v8 4/4] MAINTAINERS: Add myself as Trusted Keys co-maintainer
Date: Tue, 24 Nov 2020 05:46:41 +0200
Message-ID: <20201124034641.GC40379@kernel.org>
In-Reply-To: <1604419306-26105-5-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0986445640097953733=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0986445640097953733==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, Nov 03, 2020 at 09:31:46PM +0530, Sumit Garg wrote:
> Add a Trusted Keys co-maintainer entry in order to support TEE based
> Trusted Keys framework.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e73636b..52687bb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9732,11 +9732,13 @@ KEYS-TRUSTED
>  M:	James Bottomley <jejb@linux.ibm.com>
>  M:	Jarkko Sakkinen <jarkko@kernel.org>
>  M:	Mimi Zohar <zohar@linux.ibm.com>
> +M:	Sumit Garg <sumit.garg@linaro.org>
>  L:	linux-integrity(a)vger.kernel.org
>  L:	keyrings(a)vger.kernel.org
>  S:	Supported
>  F:	Documentation/security/keys/trusted-encrypted.rst
>  F:	include/keys/trusted-type.h
> +F:	include/keys/trusted_tee.h
>  F:	include/keys/trusted_tpm.h
>  F:	security/keys/trusted-keys/
>  
> -- 
> 2.7.4
> 
> 

/Jarkko

--===============0986445640097953733==--

