From: Simona Vetter <simona.vetter@ffwll.ch>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 0/6] TEE subsystem for restricted dma-buf allocations
Date: Wed, 08 Jan 2025 18:00:16 +0100
Message-ID: <Z36vIB-JrF5Ddhuf@phenom.ffwll.local>
In-Reply-To: <Z209ZegsmgN1xlNG@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3175612357244116028=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3175612357244116028==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, Dec 26, 2024 at 12:26:29PM +0100, Lukas Wunner wrote:
> On Thu, Dec 26, 2024 at 11:29:23AM +0530, Sumit Garg wrote:
> > On Tue, 24 Dec 2024 at 14:58, Lukas Wunner <lukas@wunner.de> wrote:
> > > However in the case of restricted memory, the situation is exactly
> > > the opposite:  The kernel may *not* be able to access the data,
> > > but the crypto accelerator can access it just fine.
> > >
> > > I did raise a concern about this to the maintainer, but to no avail:
> > > https://lore.kernel.org/r/Z1Kym1-9ka8kGHrM(a)wunner.de/
> > 
> > Herbert's point is valid that there isn't any point for mapping
> > restricted memory in the kernel virtual address space as any kernel
> > access to that space can lead to platform specific hardware error
> > scenarios. And for that reason we simply disallow dma_buf_mmap() and
> > don't support dma_buf_vmap() for DMA-bufs holding TEE restricted
> > memory.
> 
> The API for signature generation/verification (e.g. crypto_sig_sign(),
> crypto_sig_verify()) no longer accepts scatterlists, only buffers in
> virtual address space:
> 
> https://lore.kernel.org/all/ZIrnPcPj9Zbq51jK(a)gondor.apana.org.au/
> 
> Hence in order to use buffers in restricted memory for signature
> generation/verification, you'd need to map them into virtual address
> space first.

Nope, you need to get that old api back. Kernel virtual address space
mappings for dma-buf are very intentionally optional.
-Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

--===============3175612357244116028==--

