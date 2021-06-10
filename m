From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 6/7] firmware: tee_bnxt: use tee_shm_alloc_kernel_buf()
Date: Thu, 10 Jun 2021 11:08:16 +0200
Message-ID: 
 <CAHUa44Erb6bVFEU=xDoRj4KHn1rMFaEPZfS0H24zR+XgGAoLUQ@mail.gmail.com>
In-Reply-To: <20210609145811.GJ4910@sequoia>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4145509868224770776=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4145509868224770776==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 9, 2021 at 4:58 PM Tyler Hicks <tyhicks@linux.microsoft.com> wr=
ote:
>
> On 2021-06-09 12:23:23, Jens Wiklander wrote:
> > Uses the new simplified tee_shm_alloc_kernel_buf() function instead of
> > the old deprecated tee_shm_alloc() function which required specific
> > TEE_SHM-flags.
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
>
> Since this series is essentially a rewrite of the shm allocation logic,
> it is worth pointing out that the rewrite still uses contiguous
> allocations (from alloc_pages()). The tee_bnxt_fw driver is performing
> an order-10 allocation which is the max, by default. I've only tested
> tee_bnxt_fw when it was built-in to the kernel and tee_bnxt_fw_probe()
> was called early in boot but I suspect that it might not succeed when
> built as a module and loaded later after memory is segmented. I think
> this driver would benefit from being able to request a non-contiguous
> allocation.
>
> Is this rewrite a good time to offer drivers a way to perform a
> non-contiguous allocation?

Good idea, I'll look into that. I'll add it as a separate patch if it works O=
K.

Cheers,
Jens

--===============4145509868224770776==--

