From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [op-tee] [PATCH v2 0/3] tee: add support for session's client
 UUID generation
Date: Tue, 12 May 2020 12:56:09 +0200
Message-ID: <20200512105608.GA6646@jade>
In-Reply-To: <20200430123711.20083-1-vesa.jaaskelainen@vaisala.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1018488976568484827=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1018488976568484827==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2020 at 03:37:08PM +0300, Vesa J=C3=A4=C3=A4skel=C3=A4inen wr=
ote:
> TEE Client API defines that from user space only information needed for
> specified login operations is group identifier for group based logins.
>=20
> REE kernel is expected to formulate trustworthy client UUID and pass that
> to TEE environment. REE kernel is required to verify that provided group
> identifier for group based logins matches calling processes group
> memberships.
>=20
> TEE specification only defines that the information passed from REE
> environment to TEE environment is encoded into on UUID.
>=20
> In order to guarantee trustworthiness of client UUID user space is not
> allowed to freely pass client UUID.
>=20
> Vesa J=C3=A4=C3=A4skel=C3=A4inen (3):
>   tee: add support for session's client UUID generation
>   tee: optee: Add support for session login client UUID generation

I'm picking up these two patches.

>   [RFC] tee: add support for app id for client UUID generation

I'm waiting with this patch until we've reached some conclusion.

Thanks,
Jens

>=20
>  drivers/tee/Kconfig      |   1 +
>  drivers/tee/optee/call.c |   6 +-
>  drivers/tee/tee_core.c   | 211 +++++++++++++++++++++++++++++++++++++++
>  include/linux/tee_drv.h  |  16 +++
>  4 files changed, 233 insertions(+), 1 deletion(-)
>=20
> --=20
> 2.17.1
>=20
> Changes v1->v2:
>=20
> * Changed goto labels to be more logical
> * Capture error if formatted string for UUIDv5 does not fit into buffer
>=20
> Notes:
>=20
> This patcheset has been designed so that it can be iteratively intergrated
> meaning that the application ID (RFC patch) part can be left for later when
> there is agreed solution for that.
>=20
> TEE specification leaves Linux behavior undefined. It does not define any
> UUID value for name space. UUID in here is randomly generated with uuidgen
> tool.
>=20
> I have also include amdtee people as this method probably should also be
> applied in there.
>=20
> Using op-tee(a)lists.trustedfirmware.org instead of tee-dev(a)lists.linaro.=
org as
> latter is deprecated old list.
>=20
> Original issue in OP-TEE OS tracker:
> https://github.com/OP-TEE/optee_os/issues/3642
>=20
> Related reviews and demonstration for the concept:
> https://github.com/linaro-swg/linux/pull/74
> https://github.com/OP-TEE/optee_client/pull/195
> https://github.com/OP-TEE/optee_test/pull/406

--===============1018488976568484827==--

