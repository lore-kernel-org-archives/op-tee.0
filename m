From: Stefano Stabellini <sstabellini@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 2/2] optee: allow plain TMEM buffers with NULL address
Date: Mon, 22 Jun 2020 18:19:37 -0700
Message-ID: <alpine.DEB.2.21.2006221809380.8121@sstabellini-ThinkPad-T480s>
In-Reply-To: <20200619223332.438344-3-volodymyr_babchuk@epam.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0343933849080949834=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0343933849080949834==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Jun 2020, Volodymyr Babchuk wrote:
> Trusted Applications use popular approach to determine required size
> of buffer: client provides a memory reference with the NULL pointer to
> a buffer. This is so called "Null memory reference". TA updates the
> reference with the required size and returns it back to the
> client. Then client allocates buffer of needed size and repeats the
> operation.
>=20
> This behavior is described in TEE Client API Specification, paragraph
> 3.2.5. Memory References.
>=20
> OP-TEE represents this null memory reference as a TMEM parameter with
> buf_ptr =3D 0x0. This is the only case when we should allow TMEM
> buffer without the OPTEE_MSG_ATTR_NONCONTIG flag. This also the
> special case for a buffer with OPTEE_MSG_ATTR_NONCONTIG flag.
>=20
> This could lead to a potential issue, because IPA 0x0 is a valid
> address, but OP-TEE will treat it as a special case. So, care should
> be taken when construction OP-TEE enabled guest to make sure that such
> guest have no memory at IPA 0x0 and none of its memory is mapped at PA
> 0x0.
>=20
> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> ---
>=20
> Changes from v1:
>  - Added comment with TODO about possible PA/IPA 0x0 issue
>  - The same is described in the commit message
>  - Added check in translate_noncontig() for the NULL ptr buffer
>=20
> ---
>  xen/arch/arm/tee/optee.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
>=20
> diff --git a/xen/arch/arm/tee/optee.c b/xen/arch/arm/tee/optee.c
> index 6963238056..70bfef7e5f 100644
> --- a/xen/arch/arm/tee/optee.c
> +++ b/xen/arch/arm/tee/optee.c
> @@ -215,6 +215,15 @@ static bool optee_probe(void)
>      return true;
>  }
> =20
> +/*
> + * TODO: There is a potential issue with guests that either have RAM
> + * at IPA of 0x0 or some of theirs memory is mapped at PA 0x0. This is
                               ^ their

> + * because PA of 0x0 is considered as NULL pointer by OP-TEE. It will
> + * not be able to map buffer with such pointer to TA address space, or
> + * use such buffer for communication with the guest. We either need to
> + * check that guest have no such mappings or ensure that OP-TEE
> + * enabled guest will not be created with such mappings.
> + */
>  static int optee_domain_init(struct domain *d)
>  {
>      struct arm_smccc_res resp;
> @@ -725,6 +734,15 @@ static int translate_noncontig(struct optee_domain *ct=
x,
>          uint64_t next_page_data;
>      } *guest_data, *xen_data;
> =20
> +    /*
> +     * Special case: buffer with buf_ptr =3D=3D 0x0 is considered as NULL
> +     * pointer by OP-TEE. No translation is needed. This can lead to
> +     * an issue as IPA 0x0 is a valid address for Xen. See the comment
> +     * near optee_domain_init()
> +     */
> +    if ( !param->u.tmem.buf_ptr )
> +        return 0;

Given that today it is not possible for this to happen, it could even be
an ASSERT. But I think I would just return an error, maybe -EINVAL?

Aside from this, and the small grammar issue, everything else looks fine
to me.

Let's wait for Julien's reply, but if this is the only thing I could fix
on commit.


>      /* Offset of user buffer withing OPTEE_MSG_NONCONTIG_PAGE_SIZE-sized p=
age */
>      offset =3D param->u.tmem.buf_ptr & (OPTEE_MSG_NONCONTIG_PAGE_SIZE - 1);
> =20
> @@ -865,9 +883,12 @@ static int translate_params(struct optee_domain *ctx,
>              }
>              else
>              {
> -                gdprintk(XENLOG_WARNING, "Guest tries to use old tmem arg\=
n");
> -                ret =3D -EINVAL;
> -                goto out;
> +                if ( call->xen_arg->params[i].u.tmem.buf_ptr )
> +                {
> +                    gdprintk(XENLOG_WARNING, "Guest tries to use old tmem =
arg\n");
> +                    ret =3D -EINVAL;
> +                    goto out;
> +                }
>              }
>              break;
>          case OPTEE_MSG_ATTR_TYPE_NONE:
> --=20
> 2.26.2
>=20

--===============0343933849080949834==--

