From: Sumit Garg <sumit.garg@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v6 05/10] tee: implement restricted DMA-heap
Date: Tue, 01 Apr 2025 13:28:48 +0530
Message-ID: <Z-ucuPzwz4IqVTgb@sumit-X1>
In-Reply-To: <
 <CAHUa44GjpHT5Nqo+Ar5jNYNPV-YJQYpLTCf=7oJ1o0VjP-t0nA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6654479797292035442=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6654479797292035442==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, Mar 25, 2025 at 11:55:46AM +0100, Jens Wiklander wrote:
> Hi Sumit,
> 

<snip>

> 
> >
> > > +
> > > +#include "tee_private.h"
> > > +
> > > +struct tee_dma_heap {
> > > +     struct dma_heap *heap;
> > > +     enum tee_dma_heap_id id;
> > > +     struct tee_rstmem_pool *pool;
> > > +     struct tee_device *teedev;
> > > +     /* Protects pool and teedev above */
> > > +     struct mutex mu;
> > > +};
> > > +
> > > +struct tee_heap_buffer {
> > > +     struct tee_rstmem_pool *pool;
> > > +     struct tee_device *teedev;
> > > +     size_t size;
> > > +     size_t offs;
> > > +     struct sg_table table;
> > > +};
> > > +
> > > +struct tee_heap_attachment {
> > > +     struct sg_table table;
> > > +     struct device *dev;
> > > +};
> > > +
> > > +struct tee_rstmem_static_pool {
> > > +     struct tee_rstmem_pool pool;
> > > +     struct gen_pool *gen_pool;
> > > +     phys_addr_t pa_base;
> > > +};
> > > +
> > > +#if !IS_MODULE(CONFIG_TEE) && IS_ENABLED(CONFIG_DMABUF_HEAPS)
> >
> > Can this dependency rather be better managed via Kconfig?
> 
> This was the easiest yet somewhat flexible solution I could find. If
> you have something better, let's use that instead.
>

--- a/drivers/tee/optee/Kconfig
+++ b/drivers/tee/optee/Kconfig
@@ -5,6 +5,7 @@ config OPTEE
        depends on HAVE_ARM_SMCCC
        depends on MMU
        depends on RPMB || !RPMB
+       select DMABUF_HEAPS
        help
          This implements the OP-TEE Trusted Execution Environment (TEE)
          driver.

-Sumit

--===============6654479797292035442==--

