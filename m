From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [GIT PULL] OP-TEE fix for v5.15
Date: Mon, 04 Oct 2021 15:50:50 +0200
Message-ID: 
 <CAHUa44EZeE4pWmYFTfoBBxL4AhjTbRBS8vv6=M1UksL-oO_Rzw@mail.gmail.com>
In-Reply-To: <20210915113813.GA509196@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0073436976978682819=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0073436976978682819==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Is there any problems with this, or is it just that you'd rather take it late=
r?

Thanks,
Jens

On Wed, Sep 15, 2021 at 1:38 PM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> Hello arm-soc maintainers,
>
> Please pull this small OP-TEE driver fix for the shared memory pool
> handler. The fix doesn't change the generated code, but it's still relevant
> since the problem obviously triggers warnings with some tools.
>
> Thanks,
> Jens
>
> The following changes since commit 7d2a07b769330c34b4deabeed939325c77a7ec2f:
>
>   Linux 5.14 (2021-08-29 15:04:50 -0700)
>
> are available in the Git repository at:
>
>   git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-fix-f=
or-v5.15
>
> for you to fetch changes up to 88a3856c0a8c03188db7913f4d49379432fe1f93:
>
>   tee/optee/shm_pool: fix application of sizeof to pointer (2021-09-14 07:5=
4:56 +0200)
>
> ----------------------------------------------------------------
> Fix OP-TEE shm_pool lint warning
>
> ----------------------------------------------------------------
> jing yangyang (1):
>       tee/optee/shm_pool: fix application of sizeof to pointer
>
>  drivers/tee/optee/shm_pool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

--===============0073436976978682819==--

