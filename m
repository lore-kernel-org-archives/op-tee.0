From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v2] tee: amdtee: unload TA only when its refcount becomes 0
Date: Mon, 12 Apr 2021 09:36:53 +0200
Message-ID: 
 <CAHUa44Gga=k3indU8FC3X5xE=6RnKEDNeZBDWeJzm47-Spm0QA@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3C3150feb19421ca6b15202c853215f8b40fe35567=2E1617615?=
 =?utf-8?q?067=2Egit=2ERijo-john=2EThomas=40amd=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2280041136243362715=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2280041136243362715==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 5, 2021 at 11:43 AM Rijo Thomas <Rijo-john.Thomas@amd.com> wrot=
e:
>
> Same Trusted Application (TA) can be loaded in multiple TEE contexts.
>
> If it is a single instance TA, the TA should not get unloaded from AMD
> Secure Processor, while it is still in use in another TEE context.
>
> Therefore reference count TA and unload it when the count becomes zero.
>
> Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
> Reviewed-by: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
> Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
> ---
> v2:
>  * Unload TA if get_ta_refcount() fails
>
>  drivers/tee/amdtee/amdtee_private.h | 13 ++++
>  drivers/tee/amdtee/call.c           | 94 ++++++++++++++++++++++++++---
>  drivers/tee/amdtee/core.c           | 15 +++--
>  3 files changed, 106 insertions(+), 16 deletions(-)

Looks good to me. Please address Dan's comment.

Cheers,
Jens

--===============2280041136243362715==--

