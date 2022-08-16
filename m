From: Olivier Masse <olivier.masse@nxp.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [EXT] Re: [PATCH v2 0/1] tee: Add tee_shm_register_fd
Date: Tue, 16 Aug 2022 09:06:56 +0000
Message-ID: <0cd2fbe9eac3eff50ed22fcd7ac6742ff46064fd.camel@nxp.com>
In-Reply-To: <
 <CAHUa44EgA1btRyj2ByooyLr9Q+8AmW=9EfjtQFxyr7DuCXASvA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8969049278837824741=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8969049278837824741==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On mar., 2022-08-16 at 10:17 +0200, Jens Wiklander wrote:
> Caution: EXT Email
>=20
> Hi Olivier,
>=20
> On Fri, Aug 12, 2022 at 4:31 PM Olivier Masse <olivier.masse@nxp.com>
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
%7Colivier.masse%40nxp.com%7C20ddb873be8f4cd89b5408da7f5fda26%7C686ea1d3bc2b4=
c6fa92cd99c5c301635%7C0%7C1%7C637962346897373445%7CUnknown%7CTWFpbGZsb3d8eyJW=
IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7=
C&amp;sdata=3DcMbuihC0Hat4DEVORzcGhzwjO%2FxclAW43AIcvR8yReE%3D&amp;reserved=
=3D0
> >=20
> > Patch tested on Hikey 6220.
>=20
> What's new in this V2?

Just updated the cover letter and minor change to fix a build error
with gcc-11 for x86 architecture:
>> ./usr/include/linux/tee.h:136:13: error: expected declaration
specifiers or '...' before numeric constant
     136 | } __aligned(8);
         |             ^

Best regards,
Olivier

>=20
> Thanks,
> Jens
>=20
> >=20
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

--===============8969049278837824741==--

