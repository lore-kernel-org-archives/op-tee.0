From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 3/8] optee: fix tee out of memory failure seen during
 kexec reboot
Date: Fri, 11 Jun 2021 11:11:33 +0200
Message-ID: 
 <CAHUa44H=vJrkYYTb2T8WPfy6TznQyO8a8wnLCbJUuSE8QO4iuw@mail.gmail.com>
In-Reply-To: <20210610210913.536081-4-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7806761546351421180=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7806761546351421180==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, Jun 10, 2021 at 11:09 PM Tyler Hicks
<tyhicks@linux.microsoft.com> wrote:
>
> From: Allen Pais <apais@linux.microsoft.com>
>
> The following out of memory errors are seen on kexec reboot
> from the optee core.
>
> [    0.368428] tee_bnxt_fw optee-clnt0: tee_shm_alloc failed
> [    0.368461] tee_bnxt_fw: probe of optee-clnt0 failed with error -22
>
> tee_shm_release() is not invoked on dma shm buffer.
>
> Implement .shutdown() method to handle the release of the buffers
> correctly.
>
> More info:
> https://github.com/OP-TEE/optee_os/issues/3637
>
> Signed-off-by: Allen Pais <apais@linux.microsoft.com>
> Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>

Do we really need this considering the patch "optee: Refuse to load
the driver under the kdump kernel"?

Jens

--===============7806761546351421180==--

