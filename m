From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v5 4/8] optee: Clear stale cache entries during initialization
Date: Tue, 15 Jun 2021 09:00:36 +0200
Message-ID: 
 <CAHUa44HeJu9_33H3V=ms5=Z4tKSgQ8=3nWqUDvvNgJvaUB4H=A@mail.gmail.com>
In-Reply-To: <20210614223317.999867-5-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5280944276953009217=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5280944276953009217==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, Jun 15, 2021 at 12:33 AM Tyler Hicks
<tyhicks@linux.microsoft.com> wrote:
>
> The shm cache could contain invalid addresses if
> optee_disable_shm_cache() was not called from the .shutdown hook of the
> previous kernel before a kexec. These addresses could be unmapped or
> they could point to mapped but unintended locations in memory.
>
> Clear the shared memory cache, while being careful to not translate the
> addresses returned from OPTEE_SMC_DISABLE_SHM_CACHE, during driver
> initialization. Once all pre-cache shm objects are removed, proceed with
> enabling the cache so that we know that we can handle cached shm objects
> with confidence later in the .shutdown hook.
>
> Cc: stable(a)vger.kernel.org
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> ---
>  drivers/tee/optee/call.c          | 36 ++++++++++++++++++++++++++++---
>  drivers/tee/optee/core.c          |  9 ++++++++
>  drivers/tee/optee/optee_private.h |  1 +
>  3 files changed, 43 insertions(+), 3 deletions(-)

Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>

--===============5280944276953009217==--

