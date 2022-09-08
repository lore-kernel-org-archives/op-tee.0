From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [EXT] Re: [PATCH v2 0/1] tee: Add tee_shm_register_fd
Date: Thu, 08 Sep 2022 15:58:47 +0530
Message-ID: 
 <CAFA6WYM+G=MPonqPpfVXCgCAxuezUjFnm7gZ1x6ybHGrAtQp3g@mail.gmail.com>
In-Reply-To: <fb641c168a6b9fc041785a0baa8ee4b2d3ff8ed4.camel@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9209077297414465818=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============9209077297414465818==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 8 Sept 2022 at 14:48, Olivier Masse <olivier.masse@nxp.com> wrote:
>
> Hi Sumit
>
> On ven., 2022-08-19 at 13:54 +0530, Sumit Garg wrote:
> > Caution: EXT Email
> >
> > Hi Olivier,
> >
> > On Fri, 12 Aug 2022 at 20:01, Olivier Masse <olivier.masse@nxp.com>
> > wrote:
> > >
> > > Add a new ioctl called TEE_IOC_SHM_REGISTER_FD to register a
> > > shared memory from a dmabuf file descriptor.
> > > This new ioctl will allow the Linux Kernel to register a buffer
> > > to be used by the Secure Data Path OPTEE OS feature.
> > >
> > > Please find more information here:
> > >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fstatic.=
linaro.org%2Fconnect%2Fsan19%2Fpresentations%2Fsan19-107.pdf&amp;data=3D05%7C=
01%7Colivier.masse%40nxp.com%7C05071ff1c28044ab740908da81bc44e2%7C686ea1d3bc2=
b4c6fa92cd99c5c301635%7C0%7C1%7C637964942860947359%7CUnknown%7CTWFpbGZsb3d8ey=
JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C=
%7C&amp;sdata=3DnYLb2iMoJExdKEg4CL4eW5%2FQ%2Bqqj4Iw1TxFsd1UqWW0%3D&amp;reserv=
ed=3D0
> > >
> > > Patch tested on Hikey 6220.
> > >
> >
> > AFAIU, for the OP-TEE SDP feature to work you need to have a DMA-BUF
> > heap driver for allocating secure buffers through exposed chardev:
> > "/dev/dma_heap/sdp". Have you tested it with some out-of-tree driver
> > as I can't find it upstream? Also, do you plan to push that upstream
> > as well?
>
> It has been tested with linaro,secure-heap reserved dma heap memory
> which is also in review for upstream.

Can you provide the corresponding reference? Also, do keep OP-TEE ML
in CC if you send any new iteration for that patch.

-Sumit

>
> >
> > BTW, please add a changelog while sending newer patch-set versions.
> >
> > -Sumit
> >
> > > Etienne Carriere (1):
> > >   tee: new ioctl to a register tee_shm from a dmabuf file
> > > descriptor
> > >
> > >  drivers/tee/tee_core.c   | 38 +++++++++++++++
> > >  drivers/tee/tee_shm.c    | 99
> > > +++++++++++++++++++++++++++++++++++++++-
> > >  include/linux/tee_drv.h  | 11 +++++
> > >  include/uapi/linux/tee.h | 29 ++++++++++++
> > >  4 files changed, 175 insertions(+), 2 deletions(-)
> > >
> > > --
> > > 2.25.0
> > >

--===============9209077297414465818==--

