From: Greg KH <gregkh@linuxfoundation.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2] tee: handle lookup of shm with reference count 0
Date: Wed, 15 Dec 2021 13:52:37 +0100
Message-ID: <YbnlFf8930RuLkU8@kroah.com>
In-Reply-To: <20211215092501.1861229-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0398549887740094223=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0398549887740094223==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, Dec 15, 2021 at 10:25:01AM +0100, Jens Wiklander wrote:
> Since the tee subsystem does not keep a strong reference to its idle
> shared memory buffers, it races with other threads that try to destroy a
> shared memory through a close of its dma-buf fd or by unmapping the
> memory.
> 
> In tee_shm_get_from_id() when a lookup in teedev->idr has been
> successful, it is possible that the tee_shm is in the dma-buf teardown
> path, but that path is blocked by the teedev mutex. Since we don't have
> an API to tell if the tee_shm is in the dma-buf teardown path or not we
> must find another way of detecting this condition.
> 
> Fix this by doing the reference counting directly on the tee_shm using a
> new refcount_t refcount field. dma-buf is replaced by using
> anon_inode_getfd() instead, this separates the life-cycle of the
> underlying file from the tee_shm. tee_shm_put() is updated to hold the
> mutex when decreasing the refcount to 0 and then remove the tee_shm from
> teedev->idr before releasing the mutex. This means that the tee_shm can
> never be found unless it has a refcount larger than 0.
> 
> Fixes: 967c9cca2cc5 ("tee: generic TEE subsystem")
> Cc: stable(a)vger.kernel.org
> Reviewed-by: Lars Persson <larper@axis.com>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> Reported-by: Patrik Lantz <patrik.lantz@axis.com>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
> v1->v2
> * fix copyright years in drivers/tee/tee_shm.c
> * update kerneldoc comment for struct tee_shm with the reference counter

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

--===============0398549887740094223==--

