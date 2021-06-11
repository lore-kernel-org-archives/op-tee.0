From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v4 1/8] optee: Fix memory leak when failing to register shm pages
Date: Fri, 11 Jun 2021 11:05:18 +0200
Message-ID: 
 <CAHUa44HU+KnqRKnvhK=Xm3WJeYN5HPJ83e0=v+CZ0hztBWh6Fw@mail.gmail.com>
In-Reply-To: <20210610210913.536081-2-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7373212751556275366=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7373212751556275366==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, Jun 10, 2021 at 11:09 PM Tyler Hicks
<tyhicks@linux.microsoft.com> wrote:
>
> Free the previously allocated pages when we encounter an error condition
> while attempting to register the pages with the secure world.
>
> Fixes: a249dd200d03 ("tee: optee: Fix dynamic shm pool allocations")
> Fixes: 5a769f6ff439 ("optee: Fix multi page dynamic shm pool alloc")
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> ---
>  drivers/tee/optee/shm_pool.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Looks good.

Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>

--===============7373212751556275366==--

