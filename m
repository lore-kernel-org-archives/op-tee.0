From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 0/1] tee: Add tee_shm_register_fd
Date: Thu, 08 Sep 2022 15:56:02 +0530
Message-ID: 
 <CAFA6WYMstaxeGVcuEKF68Bo9ZFSvQCaJfiC59Bv2q6LDCD3JDQ@mail.gmail.com>
In-Reply-To: <YxemmVxh5F0fXEPJ@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4443756579099951064=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4443756579099951064==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Wed, 7 Sept 2022 at 01:29, Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Fri, Aug 19, 2022 at 01:54:31PM +0530, Sumit Garg wrote:
> > Hi Olivier,
> >
> > On Fri, 12 Aug 2022 at 20:01, Olivier Masse <olivier.masse@nxp.com> wro=
te:
> > >
> > > Add a new ioctl called TEE_IOC_SHM_REGISTER_FD to register a
> > > shared memory from a dmabuf file descriptor.
> > > This new ioctl will allow the Linux Kernel to register a buffer
> > > to be used by the Secure Data Path OPTEE OS feature.
> > >
> > > Please find more information here:
> > > https://static.linaro.org/connect/san19/presentations/san19-107.pdf
> > >
> > > Patch tested on Hikey 6220.
> > >
> >
> > AFAIU, for the OP-TEE SDP feature to work you need to have a DMA-BUF
> > heap driver for allocating secure buffers through exposed chardev:
> > "/dev/dma_heap/sdp". Have you tested it with some out-of-tree driver
> > as I can't find it upstream? Also, do you plan to push that upstream
> > as well?
> >
> > BTW, please add a changelog while sending newer patch-set versions.
>
> Also after the huge discussion last year dma-buf are agreed to be under
> the "you need an open source userspace for any new uapi using them" rule
> that all gpu drivers are under.
>
> Does this exist here?

There is already an open source userspace test application using it
here [1] [2] demonstrating its use-case. I think that should be
sufficient.

[1] https://github.com/OP-TEE/optee_test/blob/master/host/xtest/sdp_basic.c
[2] https://github.com/OP-TEE/optee_test/blob/master/host/xtest/sdp_basic.h

-Sumit

> -Daniel
>
> >
> > -Sumit
> >
> > > Etienne Carriere (1):
> > >   tee: new ioctl to a register tee_shm from a dmabuf file descriptor
> > >
> > >  drivers/tee/tee_core.c   | 38 +++++++++++++++
> > >  drivers/tee/tee_shm.c    | 99 +++++++++++++++++++++++++++++++++++++++-
> > >  include/linux/tee_drv.h  | 11 +++++
> > >  include/uapi/linux/tee.h | 29 ++++++++++++
> > >  4 files changed, 175 insertions(+), 2 deletions(-)
> > >
> > > --
> > > 2.25.0
> > >
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

--===============4443756579099951064==--

