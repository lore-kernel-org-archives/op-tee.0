From: "Zhu, Bing" <bing.zhu@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: RE: [PATCH  v2 0/4] rpmb subsystem, uapi and virtio-rpmb driver
Date: Thu, 01 Jun 2023 01:02:39 +0000
Message-ID: <SN7PR11MB6850DA4A185E3429B62531CD84499@SN7PR11MB6850.namprd11.prod.outlook.com>
In-Reply-To: <20230531191007.13460-1-shyamsaini@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7716941098545544414=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7716941098545544414==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

As an alternative, Is it possible to change ftpm design not to depend on RPMB=
 access at the earlier/boot stage? Because to my understanding, typically PCR=
s don't require persistent/NV storage (for example, before RPMB or tee-suppli=
cant is ready, use TEE memory instead as temporary storage)

Bing

IPAS Security Brown Belt (https://www.credly.com/badges/69ea809f-3a96-4bc7-bb=
2f-442c1b17af26)
System Software Engineering
Software and Advanced Technology Group
Zizhu Science Park, Shanghai, China

-----Original Message-----
From: Shyam Saini <shyamsaini@linux.microsoft.com>=20
Sent: Thursday, June 1, 2023 3:10 AM
To: alex.bennee(a)linaro.org
Cc: code(a)tyhicks.com; Matti.Moell(a)opensynergy.com; arnd(a)linaro.org; Zhu=
, Bing <bing.zhu@intel.com>; hmo(a)opensynergy.com; ilias.apalodimas(a)lina=
ro.org; joakim.bech(a)linaro.org; linux-kernel(a)vger.kernel.org; linux-mmc(a=
)vger.kernel.org; linux-scsi(a)vger.kernel.org; maxim.uvarov(a)linaro.org; ru=
chika.gupta(a)linaro.org; Winkler, Tomas <tomas.winkler@intel.com>; ulf.han=
sson(a)linaro.org; Huang, Yang <yang.huang@intel.com>; sumit.garg(a)linaro.=
org; jens.wiklander(a)linaro.org; op-tee(a)lists.trustedfirmware.org
Subject: [PATCH v2 0/4] rpmb subsystem, uapi and virtio-rpmb driver

Hi Alex,

[ Resending, Sorry for the noise ]
=20
Are you still working on it or planning to resubmit it ?

[1] The current optee tee kernel driver implementation doesn't work when IMA =
is used with optee implemented ftpm.

The ftpm has dependency on tee-supplicant which comes once the user space is =
up and running and IMA attestation happens at boot time and it requires to ex=
tend ftpm PCRs.=20

But IMA can't use PCRs if ftpm use secure emmc RPMB partition. As optee can o=
nly access RPMB via tee-supplicant(user space). So, there should be a fast pa=
th to allow optee os to access the RPMB parititon without waiting for user-sp=
ace tee supplicant.

To achieve this fast path linux optee driver and mmc driver needs some work a=
nd finally it will need RPMB driver which you posted.
=20
Please let me know what's your plan on this.
=20
[1] https://optee.readthedocs.io/en/latest/architecture/secure_storage.html

Best Regards,
Shyam

--===============7716941098545544414==--

