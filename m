From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] optee: extend normal memory check to also write-through
Date: Wed, 02 Dec 2020 09:06:41 +0100
Message-ID: 
 <CAHUa44HuNPmWufnxzqGLrwJqLxTkjCivYGaHvukEkk6nOd1r3g@mail.gmail.com>
In-Reply-To: <20201202071057.4877-1-andrey.zhizhikin@leica-geosystems.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5653280094017424706=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5653280094017424706==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrey,

On Wed, Dec 2, 2020 at 8:11 AM Andrey Zhizhikin
<andrey.zhizhikin@leica-geosystems.com> wrote:
>
> ARMv7 Architecture Reference Manual [1] section A3.5.5 details Normal
> memory type, together with cacheability attributes that could be applied
> to memory regions defined as "Normal memory".
>
> Section B2.1.2 of the Architecture Reference Manual [1] also provides
> details regarding the Memory attributes that could be assigned to
> particular memory regions, which includes the descrption of cacheability
> attributes and cache allocation hints.
>
> Memory type and cacheability attributes forms 2 separate definitions,
> where cacheability attributes defines a mechanism of coherency control
> rather than the type of memory itself.
>
> In other words: Normal memory type can be configured with several
> combination of cacheability attributes, namely:
> - Write-Through (WT)
> - Write-Back (WB) followed by cache allocation hint:
>   - Write-Allocate
>   - No Write-Allocate (also known as Read-Allocate)
>
> Those types are mapped in the kernel to corresponding macros:
> - Write-Through: L_PTE_MT_WRITETHROUGH
> - Write-Back Write-Allocate: L_PTE_MT_WRITEALLOC
> - Write-Back Read-Allocate: L_PTE_MT_WRITEBACK
>
> Current implementation of the op-tee driver takes in account only 2 last
> memory region types, while performing a check if the memory block is
> allocated as "Normal memory", leaving Write-Through allocations to be
> not considered.
>
> Extend verification mechanism to include also Normal memory regios,
> which are designated with Write-Through cacheability attributes.

Are you trying to fix a real error with this or are you just trying to
cover all cases? I suspect the latter since you'd likely have
coherency problems with OP-TEE in Secure world if you used
Write-Through instead. Correct me if I'm wrong, but "Write-Back
Write-Allocate" and "Write-Back Read-Allocate" are both compatible
with each other as the "Allocate" part is just a hint.

Cheers,
Jens

>
> Link: [1]: https://developer.arm.com/documentation/ddi0406/cd
> Fixes: 853735e40424 ("optee: add writeback to valid memory type")
> Cc: stable(a)vger.kernel.org
> Signed-off-by: Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
> ---
>  drivers/tee/optee/call.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> index c981757ba0d4..8da27d02a2d6 100644
> --- a/drivers/tee/optee/call.c
> +++ b/drivers/tee/optee/call.c
> @@ -535,7 +535,8 @@ static bool is_normal_memory(pgprot_t p)
>  {
>  #if defined(CONFIG_ARM)
>         return (((pgprot_val(p) & L_PTE_MT_MASK) =3D=3D L_PTE_MT_WRITEALLOC=
) ||
> -               ((pgprot_val(p) & L_PTE_MT_MASK) =3D=3D L_PTE_MT_WRITEBACK)=
);
> +               ((pgprot_val(p) & L_PTE_MT_MASK) =3D=3D L_PTE_MT_WRITEBACK)=
 ||
> +               ((pgprot_val(p) & L_PTE_MT_MASK) =3D=3D L_PTE_MT_WRITETHROU=
GH));
>  #elif defined(CONFIG_ARM64)
>         return (pgprot_val(p) & PTE_ATTRINDX_MASK) =3D=3D PTE_ATTRINDX(MT_N=
ORMAL);
>  #else
> --
> 2.17.1
>

--===============5653280094017424706==--

