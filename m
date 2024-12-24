From: Lukas Wunner <lukas@wunner.de>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 0/6] TEE subsystem for restricted dma-buf allocations
Date: Tue, 24 Dec 2024 09:28:33 +0000
Message-ID: <Z2p-v-xjhzhPso6u@wunner.de>
In-Reply-To: <
 <CAFA6WYNVHu7_-bNAuTYBRBdoJwfk2VrW5M4aFVkb_UWQ=uxTvQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5960198023529019464=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5960198023529019464==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 24, 2024 at 12:05:19PM +0530, Sumit Garg wrote:
> Restricted memory is a feature enforced by hardware specific firewalls
> where a particular TEE implementation governs which particular block
> of memory is accessible to a particular peripheral or a CPU running in
> a higher privileged mode than the Linux kernel.
[...]
> - Another possible use-case can be for the TEE implementation to store
> key material in a restricted buffer which is only accessible to the
> hardware crypto accelerator.

Just a heads-up:

For RSA sign/verify operations using rsassa-pkcs1 encoding,
the message to be signed/verified (which I understand could
be located in restricted memory) is prepended by a padding.

The crypto subsystem does the prepending of the padding in software.
The actual signature generation/verification (which is an RSA encrypt
or decrypt operation) may be performed in hardware by a crypto
accelerator.

Before commit 8552cb04e083 ("crypto: rsassa-pkcs1 - Copy source
data for SG list"), the kernel constructed a scatterlist
consisting of the padding on the one hand, and of the message
to be signed/verified on the other hand.  I believe this worked
for use cases where the message is located in restricted memory.

However since that commit, the kernel kmalloc's a new buffer and
copies the message to be signed/verified into it.  The argument
was that although the *kernel* may be able to access the data,
the crypto accelerator may *not* be able to do so.  In particular,
portions of the padding are located in the kernel's .rodata section
which is a valid virtual address on x86 but not on arm64 and
which may be inaccessible to a crypto accelerator.

However in the case of restricted memory, the situation is exactly
the opposite:  The kernel may *not* be able to access the data,
but the crypto accelerator can access it just fine.

I did raise a concern about this to the maintainer, but to no avail:
https://lore.kernel.org/r/Z1Kym1-9ka8kGHrM(a)wunner.de/

This is the alternative solution I would have preferred:
https://lore.kernel.org/r/3de5d373c86dcaa5abc36f501c1398c4fbf05f2f.1732865109=
.git.lukas(a)wunner.de/

> I am also in favour of end to end open source use-cases. But I fear
> without progressing in a step wise manner as with this proposal we
> would rather force developers to upstream all the software pieces in
> one go which will be kind of a chicken and egg situation. I am sure
> once this feature lands Mediatek folks will be interested to port
> their secure video playback patchset [3] on top of it. Similarly other
> silicon vendors like NXP, Qcom etc. will be motivated to do the same.

The crypto use case may be easier to bring up than the video decoding
use case because you don't need to implement a huge amount of
user space code.

Thanks,

Lukas

--===============5960198023529019464==--

