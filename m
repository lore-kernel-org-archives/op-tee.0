From: Lars Persson <larper@axis.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: handle lookup of shm with reference count 0
Date: Tue, 14 Dec 2021 15:54:11 +0100
Message-ID: <5beb196e-bb70-f28c-98c9-9e18df164e94@axis.com>
In-Reply-To: <YbifvnSBjW5m19hZ@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1529859521241230979=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1529859521241230979==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit



On 2021-12-14 14:44, Greg KH wrote:
> On Tue, Dec 14, 2021 at 01:35:40PM +0100, Jens Wiklander wrote:
>> Since the tee subsystem does not keep a strong reference to its idle
>> shared memory buffers, it races with other threads that try to destroy a
>> shared memory through a close of its dma-buf fd or by unmapping the
>> memory.
>> 
>> In tee_shm_get_from_id() when a lookup in teedev->idr has been
>> successful, it is possible that the tee_shm is in the dma-buf teardown
>> path, but that path is blocked by the teedev mutex. Since we don't have
>> an API to tell if the tee_shm is in the dma-buf teardown path or not we
>> must find another way of detecting this condition.
>> 
>> Fix this by doing the reference counting directly on the tee_shm using a
>> new refcount_t refcount field. dma-buf is replaced by using
>> anon_inode_getfd() instead, this separates the life-cycle of the
>> underlying file from the tee_shm. tee_shm_put() is updated to hold the
>> mutex when decreasing the refcount to 0 and then remove the tee_shm from
>> teedev->idr before releasing the mutex. This means that the tee_shm can
>> never be found unless it has a refcount larger than 0.
> 
> So you are dropping dma-buf support entirely?  And anon_inode_getfd()
> works instead?  Why do more people not do this as well?

Indeed, thinking about it, does it really makes sense to do mmap() on an 
anon_inode_getfd() fd ? It is a singleton inode used there so don't we 
breach some contract with the linux mm ? The dma-buf code for creating 
the file object is more complex, it creates a unique inode for each object.

I am by no means claiming to understand inodes' interaction with mmap, 
just sharing a concern that popped up in my head.

- Lars

--===============1529859521241230979==--

