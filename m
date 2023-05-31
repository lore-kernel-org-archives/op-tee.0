From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH  v2 0/4] rpmb subsystem, uapi and virtio-rpmb driver
Date: Wed, 31 May 2023 12:10:07 -0700
Message-ID: <20230531191007.13460-1-shyamsaini@linux.microsoft.com>
In-Reply-To: <20220405093759.1126835-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7430167351773752480=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7430167351773752480==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

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

--===============7430167351773752480==--

