From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v5 6/8] tee: Correct inappropriate usage of TEE_SHM_DMA_BUF flag
Date: Tue, 15 Jun 2021 09:10:08 +0200
Message-ID: 
 <CAHUa44G+hxjckap1e1qZXTf6vQqQYNMw=ofzdFCP1OgCXQsF5Q@mail.gmail.com>
In-Reply-To: <20210614223317.999867-7-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6222150324918646232=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6222150324918646232==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, Jun 15, 2021 at 12:33 AM Tyler Hicks
<tyhicks@linux.microsoft.com> wrote:
>
> From: Sumit Garg <sumit.garg@linaro.org>
>
> Currently TEE_SHM_DMA_BUF flag has been inappropriately used to not
> register shared memory allocated for private usage by underlying TEE
> driver: OP-TEE in this case. So rather add a new flag as TEE_SHM_PRIV
> that can be utilized by underlying TEE drivers for private allocation
> and usage of shared memory.
>
> With this corrected, allow tee_shm_alloc_kernel_buf() to allocate a
> shared memory region without the backing of dma-buf.
>
> Cc: stable(a)vger.kernel.org
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> Co-developed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> ---
>  drivers/tee/optee/call.c     | 2 +-
>  drivers/tee/optee/core.c     | 3 ++-
>  drivers/tee/optee/rpc.c      | 5 +++--
>  drivers/tee/optee/shm_pool.c | 8 ++++++--
>  drivers/tee/tee_shm.c        | 4 ++--
>  include/linux/tee_drv.h      | 1 +
>  6 files changed, 15 insertions(+), 8 deletions(-)

Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>

--===============6222150324918646232==--

