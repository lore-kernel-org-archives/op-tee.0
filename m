From: Tyler Hicks <tyhicks@linux.microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 3/8] optee: fix tee out of memory failure seen during
 kexec reboot
Date: Fri, 11 Jun 2021 07:53:26 -0500
Message-ID: <20210611125326.GQ4910@sequoia>
In-Reply-To: <
 <CAHUa44H=vJrkYYTb2T8WPfy6TznQyO8a8wnLCbJUuSE8QO4iuw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1643539882479581583=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1643539882479581583==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On 2021-06-11 11:11:33, Jens Wiklander wrote:
> On Thu, Jun 10, 2021 at 11:09 PM Tyler Hicks
> <tyhicks@linux.microsoft.com> wrote:
> >
> > From: Allen Pais <apais@linux.microsoft.com>
> >
> > The following out of memory errors are seen on kexec reboot
> > from the optee core.
> >
> > [    0.368428] tee_bnxt_fw optee-clnt0: tee_shm_alloc failed
> > [    0.368461] tee_bnxt_fw: probe of optee-clnt0 failed with error -22
> >
> > tee_shm_release() is not invoked on dma shm buffer.
> >
> > Implement .shutdown() method to handle the release of the buffers
> > correctly.
> >
> > More info:
> > https://github.com/OP-TEE/optee_os/issues/3637
> >
> > Signed-off-by: Allen Pais <apais@linux.microsoft.com>
> > Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> 
> Do we really need this considering the patch "optee: Refuse to load
> the driver under the kdump kernel"?

Yes. That patch fixes boot hangs when all of the OP-TEE threads were in
the suspended state at the time of a kernel panic. The kexec into the
kdump kernel after a panic is an "emergency" kexec that doesn't even
call .shutdown hooks. There's no way for the OP-TEE driver to clean up
after itself.

This patch disables the shm cache (and unregisters the shm buffers)
during a normal kexec from one perfectly working kernel into a new
kernel. This is required because the new kernel will not be able to
handle the virtual addresses that were cached under the old kernel. The
new kernel has an entirely different memory layout and the old addresses
point to unmapped memory or memory that's mapped but probably not a TEE
shm.

Tyler

> 
> Jens
> 

--===============1643539882479581583==--

