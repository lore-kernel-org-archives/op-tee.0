From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: Fix typo Unuspported -> Unsupported
Date: Thu, 23 Feb 2023 11:08:49 +0530
Message-ID: 
 <CAFA6WYPGF3Q=_U-rZGyyH=ouunwT=9nx7j+pueCVS5jLng4fxA@mail.gmail.com>
In-Reply-To: <20230222173009.19874-1-jmaselbas@kalray.eu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3713987659594167315=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3713987659594167315==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Feb 2023 at 23:00, Jules Maselbas <jmaselbas@kalray.eu> wrote:
>
> Fix typo Unuspported -> Unsupported
>
> Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
> ---
>  drivers/tee/optee/call.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> index 290b1bb0e9cd..df5fb5410b72 100644
> --- a/drivers/tee/optee/call.c
> +++ b/drivers/tee/optee/call.c
> @@ -488,7 +488,7 @@ static bool is_normal_memory(pgprot_t p)
>  #elif defined(CONFIG_ARM64)
>         return (pgprot_val(p) & PTE_ATTRINDX_MASK) =3D=3D PTE_ATTRINDX(MT_N=
ORMAL);
>  #else
> -#error "Unuspported architecture"
> +#error "Unsupported architecture"
>  #endif
>  }
>
> --
> 2.17.1
>

--===============3713987659594167315==--

