From: Herbert Xu <herbert@gondor.apana.org.au>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCHv3 1/2] hwrng: optee: handle unlimited data rates
Date: Fri, 21 Aug 2020 17:57:31 +1000
Message-ID: <20200821075731.GI25143@gondor.apana.org.au>
In-Reply-To: <20200806100010.20509-1-jorge@foundries.io>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5269535190040370174=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5269535190040370174==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, Aug 06, 2020 at 12:00:09PM +0200, Jorge Ramirez-Ortiz wrote:
> Data rates of MAX_UINT32 will schedule an unnecessary one jiffy
> timeout on the call to msleep. Avoid this scenario by using 0 as the
> unlimited data rate.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/char/hw_random/optee-rng.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--===============5269535190040370174==--

