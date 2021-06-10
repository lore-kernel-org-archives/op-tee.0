From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v3 5/7] tee: Support shm registration without dma-buf backing
Date: Thu, 10 Jun 2021 09:34:24 +0200
Message-ID: <20210610073424.GB2753553@jade>
In-Reply-To: <20210609135104.GD4910@sequoia>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0367170444049689307=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0367170444049689307==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 09, 2021 at 08:51:04AM -0500, Tyler Hicks wrote:
[snip]
> > > I've just posted "[PATCH 0/7] tee: shared memory updates",
> > > https://lore.kernel.org/lkml/20210609102324.2222332-1-jens.wiklander(a)=
linaro.org/
> > >=20
> > > Where tee_shm_alloc() is replaced by among other functions
> > > tee_shm_alloc_kernel_buf(). tee_shm_alloc_kernel_buf() takes care of the
> > > problem with TEE_SHM_DMA_BUF.
> >=20
> > Thanks! At first glance, that series would take care of the last three
> > patches in my kexec/kdump series.
>=20
> Correction: Your series would not completely take care of the last three
> patches in my kexec/kdump series because your series doesn't implement
> the .shutdown() hook for tee_bnxt_fw.
>=20
> Does it make sense to take my series first and then rebase your series
> on top of it? That would allow my fixes to flow back to stable, then
> your changes would greatly clean up the implementation in future
> releases.

Yes, we could try that. I'd like to see tee_shm_alloc_kernel_buf() being
used instead of tee_shm_alloc() in ftpm_tee_probe() and
tee_bnxt_fw_probe(). So it would be great if you could include "tee: add
tee_shm_alloc_kernel_buf()" in your patch set.

My patch set would then shrink a bit. By the way, thanks for reviewing
it.

Cheers,
Jens

--===============0367170444049689307==--

