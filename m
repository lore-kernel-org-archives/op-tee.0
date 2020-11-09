From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 0/2] AMD-TEE driver bug fixes
Date: Mon, 09 Nov 2020 08:47:34 +0100
Message-ID: 
 <CAHUa44F4L+B=Kr_-hprhMRjgjfnQPRdzPsxq0WFABB6WPKqyog@mail.gmail.com>
In-Reply-To: <cover.1604470183.git.Rijo-john.Thomas@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5354506099998544898=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5354506099998544898==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Rijo,

On Wed, Nov 4, 2020 at 7:26 AM Rijo Thomas <Rijo-john.Thomas@amd.com> wrote:
>
> AMD-TEE driver keeps track of shared memory buffers and their
> corresponding buffer id's in a global linked list. These buffers are
> used to share data between x86 and AMD Secure Processor. This patchset
> fixes issues related to maintaining mapped buffers in a shared linked
> list.
>
> Rijo Thomas (2):
>   tee: amdtee: fix memory leak due to reset of global shm list
>   tee: amdtee: synchronize access to shm list
>
>  drivers/tee/amdtee/amdtee_private.h |  8 ++++----
>  drivers/tee/amdtee/core.c           | 26 +++++++++++++++++++-------
>  2 files changed, 23 insertions(+), 11 deletions(-)

This series looks good. I'll pick it up.

Thanks,
Jens

--===============5354506099998544898==--

