From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] KEYS: trusted: tee: use tee_shm_register_alloc_buf()
Date: Mon, 21 Aug 2023 12:55:11 +0200
Message-ID: 
 <CAHUa44GjxLxzDSRsufvR35HRYpJ0S9iAXaN8cMz-V1B=HVBzHw@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYOhSAY68S=pqW5=YU=gCo7LHYELt1A7mAx-0revWH5XpA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8010489996767149496=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8010489996767149496==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 21, 2023 at 11:35=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
[snip]
> Actually thinking about it more, let's rework
> tee_shm_register_kernel_buf() to be tee_shm_register_kernel_pages() to
> get aligned as we agreed here [1]. This would then shift the
> responsibility to check for duplicate pages to kernel clients rather
> than the TEE driver (don't need to bother about sub page buffers).
>
> [1] https://lists.trustedfirmware.org/archives/list/op-tee(a)lists.trustedf=
irmware.org/thread/Y224PTCQZPKLH2INVWWPRUZM4MDUPYL7/

Sounds good, I assume this will not affect tee_shm_alloc_kernel_buf().

Thanks,
Jens

--===============8010489996767149496==--

