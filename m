From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [RFC PATCH 1/4] dma-buf: heaps: restricted_heap: add no_map attribute
Date: Thu, 05 Sep 2024 08:56:11 +0200
Message-ID: 
 <CAHUa44G9yF2GoQD8XrE=agkGCditH1v+NYm16WpdORX4aRixYg@mail.gmail.com>
In-Reply-To: <4a498990-2d9e-4555-85f3-d1d22e26b9dd@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5306951888501719672=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5306951888501719672==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 10:47=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 30.08.24 um 09:03 schrieb Jens Wiklander:
> > Add a no_map attribute to struct restricted_heap_attachment and struct
> > restricted_heap to skip the call to dma_map_sgtable() if set. This
> > avoids trying to map a dma-buf that doens't refer to memory accessible
> > by the kernel.
>
> You seem to have a misunderstanding here dma_map_sgtable() is called to
> map a table into IOMMU and not any kernel address space.
>
> So please explain why you need that?

You're right, I had misunderstood dma_map_sgtable(). There's no need
for the no_map attribute, so I'll remove it.

Perhaps you have a suggestion on how to fix a problem when using
dma_map_sgtable()?

Without it, I'll have to assign a pointer to teedev->dev.dma_mask when
using the restricted heap with the OP-TEE driver or there will be a
warning in __dma_map_sg_attrs() ending with a failure when trying to
register the dma-buf fd. OP-TEE is probed with a platform device, and
taking the dma_mask pointer from that device works. Is that a good
approach or is there a better way of assigning dma_mask?

Thanks,
Jens

>
> Regards,
> Christian.
>
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >   drivers/dma-buf/heaps/restricted_heap.c | 17 +++++++++++++----
> >   drivers/dma-buf/heaps/restricted_heap.h |  2 ++
> >   2 files changed, 15 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/dma-buf/heaps/restricted_heap.c b/drivers/dma-buf/he=
aps/restricted_heap.c
> > index 8bc8a5e3f969..4bf28e3727ca 100644
> > --- a/drivers/dma-buf/heaps/restricted_heap.c
> > +++ b/drivers/dma-buf/heaps/restricted_heap.c
> > @@ -16,6 +16,7 @@
> >   struct restricted_heap_attachment {
> >       struct sg_table                 *table;
> >       struct device                   *dev;
> > +     bool no_map;
> >   };
> >
> >   static int
> > @@ -54,6 +55,8 @@ restricted_heap_memory_free(struct restricted_heap *rhe=
ap, struct restricted_buf
> >   static int restricted_heap_attach(struct dma_buf *dmabuf, struct dma_bu=
f_attachment *attachment)
> >   {
> >       struct restricted_buffer *restricted_buf =3D dmabuf->priv;
> > +     struct dma_heap *heap =3D restricted_buf->heap;
> > +     struct restricted_heap *rheap =3D dma_heap_get_drvdata(heap);
> >       struct restricted_heap_attachment *a;
> >       struct sg_table *table;
> >
> > @@ -70,6 +73,7 @@ static int restricted_heap_attach(struct dma_buf *dmabu=
f, struct dma_buf_attachm
> >       sg_dma_mark_restricted(table->sgl);
> >       a->table =3D table;
> >       a->dev =3D attachment->dev;
> > +     a->no_map =3D rheap->no_map;
> >       attachment->priv =3D a;
> >
> >       return 0;
> > @@ -92,9 +96,12 @@ restricted_heap_map_dma_buf(struct dma_buf_attachment =
*attachment,
> >       struct sg_table *table =3D a->table;
> >       int ret;
> >
> > -     ret =3D dma_map_sgtable(attachment->dev, table, direction, DMA_ATTR=
_SKIP_CPU_SYNC);
> > -     if (ret)
> > -             return ERR_PTR(ret);
> > +     if (!a->no_map) {
> > +             ret =3D dma_map_sgtable(attachment->dev, table, direction,
> > +                                   DMA_ATTR_SKIP_CPU_SYNC);
> > +             if (ret)
> > +                     return ERR_PTR(ret);
> > +     }
> >       return table;
> >   }
> >
> > @@ -106,7 +113,9 @@ restricted_heap_unmap_dma_buf(struct dma_buf_attachme=
nt *attachment, struct sg_t
> >
> >       WARN_ON(a->table !=3D table);
> >
> > -     dma_unmap_sgtable(attachment->dev, table, direction, DMA_ATTR_SKIP_=
CPU_SYNC);
> > +     if (!a->no_map)
> > +             dma_unmap_sgtable(attachment->dev, table, direction,
> > +                               DMA_ATTR_SKIP_CPU_SYNC);
> >   }
> >
> >   static int
> > diff --git a/drivers/dma-buf/heaps/restricted_heap.h b/drivers/dma-buf/he=
aps/restricted_heap.h
> > index 7dec4b8a471b..94cc0842f70d 100644
> > --- a/drivers/dma-buf/heaps/restricted_heap.h
> > +++ b/drivers/dma-buf/heaps/restricted_heap.h
> > @@ -27,6 +27,8 @@ struct restricted_heap {
> >       unsigned long           cma_paddr;
> >       unsigned long           cma_size;
> >
> > +     bool                    no_map;
> > +
> >       void                    *priv_data;
> >   };
> >
>

--===============5306951888501719672==--

