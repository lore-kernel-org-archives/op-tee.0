From: Herbert Xu <herbert@gondor.apana.org.au>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2] hwrng: optee: Use device-managed registration API
Date: Wed, 10 Feb 2021 18:23:18 +1100
Message-ID: <20210210072318.GG4493@gondor.apana.org.au>
In-Reply-To: <1612355166-11824-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8473016908771252106=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8473016908771252106==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, Feb 03, 2021 at 08:26:06PM +0800, Tian Tao wrote:
> Use devm_hwrng_register to get rid of manual unregistration.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> ---
> v2:Fix up subject line as s/hwrng: optee -:/hwrng: optee:/
> ---
>  drivers/char/hw_random/optee-rng.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--===============8473016908771252106==--

