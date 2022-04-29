From: Herbert Xu <herbert@gondor.apana.org.au>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] hwrng: optee-rng: remove redundant initialization to
 variable rng_size
Date: Fri, 29 Apr 2022 13:50:56 +0800
Message-ID: <Ymt8wNWKkLeI4VIV@gondor.apana.org.au>
In-Reply-To: <20220424181156.1364446-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0960379640824740653=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0960379640824740653==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Sun, Apr 24, 2022 at 07:11:56PM +0100, Colin Ian King wrote:
> Variable rng_size is being initialized with a value that is never read,
> the variable is being re-assigned later on. The initialization is
> redundant and can be removed.
> 
> Cleans up cppcheck warning:
> Variable 'rng_size' is assigned a value that is never used.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/char/hw_random/optee-rng.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--===============0960379640824740653==--

