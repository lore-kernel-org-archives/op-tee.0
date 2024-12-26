From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 0/6] TEE subsystem for restricted dma-buf allocations
Date: Thu, 26 Dec 2024 11:29:23 +0530
Message-ID: 
 <CAFA6WYMEjT5EAG3AL8NpbET6L=M86LBgnhLnWirvDZg9cUUiuA@mail.gmail.com>
In-Reply-To: <Z2p-v-xjhzhPso6u@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0060776530355518220=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0060776530355518220==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Lukas,

On Tue, 24 Dec 2024 at 14:58, Lukas Wunner <lukas@wunner.de> wrote:
>
> On Tue, Dec 24, 2024 at 12:05:19PM +0530, Sumit Garg wrote:
> > Restricted memory is a feature enforced by hardware specific firewalls
> > where a particular TEE implementation governs which particular block
> > of memory is accessible to a particular peripheral or a CPU running in
> > a higher privileged mode than the Linux kernel.
> [...]
> > - Another possible use-case can be for the TEE implementation to store
> > key material in a restricted buffer which is only accessible to the
> > hardware crypto accelerator.
>
> Just a heads-up:
>
> For RSA sign/verify operations using rsassa-pkcs1 encoding,
> the message to be signed/verified (which I understand could
> be located in restricted memory) is prepended by a padding.
>
> The crypto subsystem does the prepending of the padding in software.
> The actual signature generation/verification (which is an RSA encrypt
> or decrypt operation) may be performed in hardware by a crypto
> accelerator.
>
> Before commit 8552cb04e083 ("crypto: rsassa-pkcs1 - Copy source
> data for SG list"), the kernel constructed a scatterlist
> consisting of the padding on the one hand, and of the message
> to be signed/verified on the other hand.  I believe this worked
> for use cases where the message is located in restricted memory.
>
> However since that commit, the kernel kmalloc's a new buffer and
> copies the message to be signed/verified into it.  The argument
> was that although the *kernel* may be able to access the data,
> the crypto accelerator may *not* be able to do so.  In particular,
> portions of the padding are located in the kernel's .rodata section
> which is a valid virtual address on x86 but not on arm64 and
> which may be inaccessible to a crypto accelerator.
>
> However in the case of restricted memory, the situation is exactly
> the opposite:  The kernel may *not* be able to access the data,
> but the crypto accelerator can access it just fine.
>
> I did raise a concern about this to the maintainer, but to no avail:
> https://lore.kernel.org/r/Z1Kym1-9ka8kGHrM(a)wunner.de/

Herbert's point is valid that there isn't any point for mapping
restricted memory in the kernel virtual address space as any kernel
access to that space can lead to platform specific hardware error
scenarios. And for that reason we simply disallow dma_buf_mmap() and
don't support dma_buf_vmap() for DMA-bufs holding TEE restricted
memory. The only consumers for those DMA-bufs will be the DMA capable
peripherals granted access permissions by the TEE implementation. IOW,
kernel role here will be to just provide the DMA-buf infrastructure
for buffers to be set up by TEE and then setting up DMA addresses for
peripherals to access them. The hardware crypto accelerator can be one
such peripheral.

>
> This is the alternative solution I would have preferred:
> https://lore.kernel.org/r/3de5d373c86dcaa5abc36f501c1398c4fbf05f2f.17328651=
09.git.lukas(a)wunner.de/
>
> > I am also in favour of end to end open source use-cases. But I fear
> > without progressing in a step wise manner as with this proposal we
> > would rather force developers to upstream all the software pieces in
> > one go which will be kind of a chicken and egg situation. I am sure
> > once this feature lands Mediatek folks will be interested to port
> > their secure video playback patchset [3] on top of it. Similarly other
> > silicon vendors like NXP, Qcom etc. will be motivated to do the same.
>
> The crypto use case may be easier to bring up than the video decoding
> use case because you don't need to implement a huge amount of
> user space code.

Agree, if you already have such an existing hardware use-case then
please feel free to build up on this patch-set.

-Sumit

>
> Thanks,
>
> Lukas

--===============0060776530355518220==--

