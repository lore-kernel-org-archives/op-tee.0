From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH 0/3] Introduce DMA APIs to allocate and free TEE shared memory
Date: Wed, 25 Oct 2023 19:01:31 +0530
Message-ID: 
 <CAFA6WYPKXFftMzqJ4GnXT-zqu21_Jzn8aKti_wU-pQ4KpEVNrA@mail.gmail.com>
In-Reply-To: <20231025065700.1556152-1-JESHWANTHKUMAR.NK@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6434370383335731041=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6434370383335731041==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Jeshwank,

On Wed, 25 Oct 2023 at 12:27, jeshwank <JESHWANTHKUMAR.NK@amd.com> wrote:
>
> From: Jeshwanth Kumar N K <JESHWANTHKUMAR.NK@amd.com>
>
> At present, the shared memory for TEE ring buffer, command buffer and
> data buffer is allocated using get_free_pages(). The driver shares the
> physical address of these buffers with PSP so that it can be mapped by
> the Trusted OS.
>
> In this patch series we have replaced get_free_pages() with
> dma_alloc_coherent() to allocate shared memory to cleanup the existing
> allocation method.

Thanks for putting this together but I can't find the reasoning behind
this change neither in this commit message and nor in the patch
descriptions. Care to explain why?

-Sumit

>
> Rijo Thomas (3):
>   crypto: ccp - Add function to allocate and free memory using DMA APIs
>   crypto: ccp - Use psp_tee_alloc_buffer() and psp_tee_free_buffer()
>   tee: amdtee: Use psp_tee_alloc_buffer() and psp_tee_free_buffer()
>
>  drivers/crypto/ccp/psp-dev.c        |   3 +
>  drivers/crypto/ccp/tee-dev.c        | 119 ++++++++++++++++++----------
>  drivers/crypto/ccp/tee-dev.h        |  11 +--
>  drivers/tee/amdtee/amdtee_private.h |  18 ++---
>  drivers/tee/amdtee/call.c           |  74 ++++++++---------
>  drivers/tee/amdtee/core.c           |  72 ++++++++++-------
>  drivers/tee/amdtee/shm_pool.c       |  21 ++---
>  include/linux/psp-tee.h             |  47 +++++++++++
>  8 files changed, 221 insertions(+), 144 deletions(-)
>
> --
> 2.25.1
>

--===============6434370383335731041==--

