From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] Properly check tee_shm buffer mmap offset
Date: Mon, 23 Nov 2020 14:52:55 +0100
Message-ID: 
 <CAHUa44HB6WKoubGEWFANh8SmsOU0Z=p+42AV5-At8TC1B08npA@mail.gmail.com>
In-Reply-To: <1606115436-15332-1-git-send-email-a869920004@163.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9050254402185498689=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============9050254402185498689==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 23, 2020 at 8:10 AM gaoyusong <a869920004@163.com> wrote:
>
> The memmap options in tee_shm_op_mmap were not being checked for all
> sets of possible crazy values. Fix this up by properly check tee_shm
> buffer offsets.
>
> Signed-off-by: gaoyusong <a869920004@163.com>
> ---
>  drivers/tee/tee_shm.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 827ac3d..3f762c8 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -75,6 +75,16 @@ static int tee_shm_op_mmap(struct dma_buf *dmabuf, struc=
t vm_area_struct *vma)
>  {
>         struct tee_shm *shm =3D dmabuf->priv;
>         size_t size =3D vma->vm_end - vma->vm_start;
> +       unsigned long offset;
> +
> +       /* Check dmabuffer mmap offset */
> +       if (vma->vm_pgoff > (~0UL >> PAGE_SHIFT))
> +               return -EINVAL;
> +
> +       offset =3D vma->vm_pgoff << PAGE_SHIFT;
> +
> +       if (offset > shm->size || size > shm->size - offset)
> +               return -EINVAL;

If we would have used vm_pgoff below to offset into the shm buffer
these checks would be needed.
Currently we're ignoring this field though. That might be a bit
inconsistent with the mmap() API, but on the other hand this buffer
has just been carved out of the shared memory pool for the purpose of
mapping it in user space. To carve out more than we're going to map
would be wasteful so I guess that in the end it makes sense to ignore
vm_pgoff.

Thanks,
Jens

>
>         /* Refuse sharing shared memory provided by application */
>         if (shm->flags & TEE_SHM_USER_MAPPED)
> --
> 1.8.3.1
>

--===============9050254402185498689==--

