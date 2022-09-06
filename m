From: Daniel Vetter <daniel@ffwll.ch>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 0/1] tee: Add tee_shm_register_fd
Date: Tue, 06 Sep 2022 19:59:26 +0000
Message-ID: <YxemmVxh5F0fXEPJ@phenom.ffwll.local>
In-Reply-To: <
 <CAFA6WYM89+SrW2Br-fnFke4djt4GgGHXn7JS3=rxvAa7dAAY7w@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4752592601004102799=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4752592601004102799==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, Aug 19, 2022 at 01:54:31PM +0530, Sumit Garg wrote:
> Hi Olivier,
> 
> On Fri, 12 Aug 2022 at 20:01, Olivier Masse <olivier.masse@nxp.com> wrote:
> >
> > Add a new ioctl called TEE_IOC_SHM_REGISTER_FD to register a
> > shared memory from a dmabuf file descriptor.
> > This new ioctl will allow the Linux Kernel to register a buffer
> > to be used by the Secure Data Path OPTEE OS feature.
> >
> > Please find more information here:
> > https://static.linaro.org/connect/san19/presentations/san19-107.pdf
> >
> > Patch tested on Hikey 6220.
> >
> 
> AFAIU, for the OP-TEE SDP feature to work you need to have a DMA-BUF
> heap driver for allocating secure buffers through exposed chardev:
> "/dev/dma_heap/sdp". Have you tested it with some out-of-tree driver
> as I can't find it upstream? Also, do you plan to push that upstream
> as well?
> 
> BTW, please add a changelog while sending newer patch-set versions.

Also after the huge discussion last year dma-buf are agreed to be under
the "you need an open source userspace for any new uapi using them" rule
that all gpu drivers are under.

Does this exist here?
-Daniel

> 
> -Sumit
> 
> > Etienne Carriere (1):
> >   tee: new ioctl to a register tee_shm from a dmabuf file descriptor
> >
> >  drivers/tee/tee_core.c   | 38 +++++++++++++++
> >  drivers/tee/tee_shm.c    | 99 +++++++++++++++++++++++++++++++++++++++-
> >  include/linux/tee_drv.h  | 11 +++++
> >  include/uapi/linux/tee.h | 29 ++++++++++++
> >  4 files changed, 175 insertions(+), 2 deletions(-)
> >
> > --
> > 2.25.0
> >

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

--===============4752592601004102799==--

