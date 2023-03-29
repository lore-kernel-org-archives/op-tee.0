From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH][next] optee: Fix spelling mistake "Unuspported" -> "Unsupported"
Date: Wed, 29 Mar 2023 15:08:10 +0530
Message-ID: 
 <CAFA6WYNOzJxwXA_RfAkHxp-w1Pu0UQpeZOoP7tyaGBSeBuERVQ@mail.gmail.com>
In-Reply-To: <20230329093200.419041-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0361978753189664519=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0361978753189664519==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 29 Mar 2023 at 15:02, Colin Ian King <colin.i.king@gmail.com> wrote:
>
> There is a spelling mistake in a #error message. Fix it.

Thanks for catching it, it has already been fixed as part of this PR [1].

[1] https://lore.kernel.org/lkml/20230314184441.GA2936721(a)rayden/T/

-Sumit

>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/tee/optee/call.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
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
> 2.30.2
>

--===============0361978753189664519==--

