From: Olivier Masse <olivier.masse@nxp.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [EXT] Re: [PATCH v2 0/1] tee: Add tee_shm_register_fd
Date: Thu, 08 Sep 2022 09:18:43 +0000
Message-ID: <fb641c168a6b9fc041785a0baa8ee4b2d3ff8ed4.camel@nxp.com>
In-Reply-To: <
 <CAFA6WYM89+SrW2Br-fnFke4djt4GgGHXn7JS3=rxvAa7dAAY7w@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2127760872597854311=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2127760872597854311==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Sumit

On ven., 2022-08-19 at 13:54 +0530, Sumit Garg wrote:
> Caution: EXT Email
>=20
> Hi Olivier,
>=20
> On Fri, 12 Aug 2022 at 20:01, Olivier Masse <olivier.masse@nxp.com>
> wrote:
> >=20
> > Add a new ioctl called TEE_IOC_SHM_REGISTER_FD to register a
> > shared memory from a dmabuf file descriptor.
> > This new ioctl will allow the Linux Kernel to register a buffer
> > to be used by the Secure Data Path OPTEE OS feature.
> >=20
> > Please find more information here:
> >=20
https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fstatic.li=
naro.org%2Fconnect%2Fsan19%2Fpresentations%2Fsan19-107.pdf&amp;data=3D05%7C01=
%7Colivier.masse%40nxp.com%7C05071ff1c28044ab740908da81bc44e2%7C686ea1d3bc2b4=
c6fa92cd99c5c301635%7C0%7C1%7C637964942860947359%7CUnknown%7CTWFpbGZsb3d8eyJW=
IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7=
C&amp;sdata=3DnYLb2iMoJExdKEg4CL4eW5%2FQ%2Bqqj4Iw1TxFsd1UqWW0%3D&amp;reserved=
=3D0
> >=20
> > Patch tested on Hikey 6220.
> >=20
>=20
> AFAIU, for the OP-TEE SDP feature to work you need to have a DMA-BUF
> heap driver for allocating secure buffers through exposed chardev:
> "/dev/dma_heap/sdp". Have you tested it with some out-of-tree driver
> as I can't find it upstream? Also, do you plan to push that upstream
> as well?

It has been tested with linaro,secure-heap reserved dma heap memory
which is also in review for upstream.

>=20
> BTW, please add a changelog while sending newer patch-set versions.
>=20
> -Sumit
>=20
> > Etienne Carriere (1):
> >   tee: new ioctl to a register tee_shm from a dmabuf file
> > descriptor
> >=20
> >  drivers/tee/tee_core.c   | 38 +++++++++++++++
> >  drivers/tee/tee_shm.c    | 99
> > +++++++++++++++++++++++++++++++++++++++-
> >  include/linux/tee_drv.h  | 11 +++++
> >  include/uapi/linux/tee.h | 29 ++++++++++++
> >  4 files changed, 175 insertions(+), 2 deletions(-)
> >=20
> > --
> > 2.25.0
> >=20

--===============2127760872597854311==--

