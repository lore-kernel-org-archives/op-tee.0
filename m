From: Boris Brezillon <boris.brezillon@collabora.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 0/6] TEE subsystem for restricted dma-buf allocations
Date: Wed, 12 Feb 2025 20:56:13 +0100
Message-ID: <20250212205613.4400a888@collabora.com>
In-Reply-To: <20241217100809.3962439-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4310408612697264631=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4310408612697264631==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

+Florent, who's working on protected-mode support in Panthor.

Hi Jens,

On Tue, 17 Dec 2024 11:07:36 +0100
Jens Wiklander <jens.wiklander@linaro.org> wrote:

> Hi,
> 
> This patch set allocates the restricted DMA-bufs via the TEE subsystem.

We're currently working on protected-mode support for Panthor [1] and it
looks like your series (and the OP-TEE implementation that goes with
it) would allow us to have a fully upstream/open solution for the
protected content use case we're trying to support. I need a bit more
time to play with the implementation but this looks very promising
(especially the lend rstmem feature, which might help us allocate our
FW sections that are supposed to execute code accessing protected
content).

> 
> The TEE subsystem handles the DMA-buf allocations since it is the TEE
> (OP-TEE, AMD-TEE, TS-TEE, or perhaps a future QCOMTEE) which sets up the
> restrictions for the memory used for the DMA-bufs.
> 
> I've added a new IOCTL, TEE_IOC_RSTMEM_ALLOC, to allocate the restricted
> DMA-bufs. This IOCTL reaches the backend TEE driver, allowing it to choose
> how to allocate the restricted physical memory.

I'll probably have more questions soon, but here's one to start: any
particular reason you didn't go for a dma-heap to expose restricted
buffer allocation to userspace? I see you already have a cdev you can
take ioctl()s from, but my understanding was that dma-heap was the
standard solution for these device-agnostic/central allocators.

Regards,

Boris

[1]https://lwn.net/ml/all/cover.1738228114.git.florent.tomasin(a)arm.com/#t

--===============4310408612697264631==--

