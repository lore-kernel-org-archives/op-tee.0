From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v3 0/2] OP-TEE kernel private shared memory optimizations
Date: Mon, 04 Dec 2023 17:11:14 +0100
Message-ID: 
 <CAHUa44Hw5=91VpE9T_vtv=2+Pmy5=zH4yMnSiAAWFedxEihXPg@mail.gmail.com>
In-Reply-To: <20231114095217.1142360-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1773262240184916106=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1773262240184916106==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, Nov 14, 2023 at 10:52 AM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> Hi,
>
> This patch set optimizes OP-TEE driver private shared memory allocated as
> dynamic shared memory (not from the static shared memory pool). The first
> patch handles kernel private RPC allocatations larger than one page and the
> second changes from alloc_pages_exact() instead of alloc_pages() for more
> efficient memory usage.
>
> v1->v2:
> * Split into two patches as requested
>
> v2->v3:
> * Simplified optee_pool_op_alloc_helper() by always doing the same thing
>
> Thanks,
> Jens
>
> Jens Wiklander (2):
>   optee: add page list to kernel private shared memory
>   optee: allocate shared memory with alloc_pages_exact()
>
>  drivers/tee/optee/core.c    | 44 +++++++++++++++++++-----------------
>  drivers/tee/optee/smc_abi.c | 45 +++++++++++++++++--------------------
>  2 files changed, 44 insertions(+), 45 deletions(-)
>
>
> base-commit: 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1
> --
> 2.34.1
>

I'm picking up this.

Thanks,
Jens

--===============1773262240184916106==--

