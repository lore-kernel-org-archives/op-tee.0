From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: Add Arm FF-A TEE driver
Date: Wed, 18 May 2022 11:11:09 +0100
Message-ID: <20220518101109.xdmiuj5gjqg3drhm@bogus>
In-Reply-To: <=?utf-8?q?=3CAS8PR08MB5895E2E79F48D5CBF939C45391CE9=40AS8PR08MB?=
 =?utf-8?q?5895=2Eeurprd08=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8236863341238889070=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8236863341238889070==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 17, 2022 at 06:55:47PM +0100, Gyorgy Szing wrote:
> Hi Sumit,
>=20
> The best way to test the driver is to use the PSA SPs from Trusted Services
> similarly as described on the wiki page above. We have merged the TEE driver
> enablement patches to integration branch of TS recently, and as a result the
> set-up and build instructions above will build an end-to-end config using
> the TEE driver.
> The TEE driver integration needs to be changed though. Instead of building
> the TEE driver as an out of tree module from our fork [2], you might want to
> change the config to use the driver posted by Sudeep. If you wish to use the
> op-tee build flow, the makefiles in OP-TEE/build repo part of the above
> set-up need modification too.

Correct I have done something similar when testing as a module.

> TS will build multiple test executables targeting the Linux user-space. For
> TEE driver testing any of these targeting the "arm-linux" environment will
> do, but I suggest using the "ts-service-test".
>=20
> AFAIK Sudeep is testing with TS too using a similar set-up.
>

Indeed. I just made couple of minor changes to the way app checks the presence
of the driver and dropped the version check.
Ref: ffarpc_caller_check_version in components/rpc/ffarpc/caller/linux/ffarpc=
_caller.c
to make progress.

> [2] https://gitlab.arm.com/linux-arm/linux-trusted-services
>=20

--=20
Regards,
Sudeep

--===============8236863341238889070==--

