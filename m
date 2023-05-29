From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: [v2,0/4] rpmb subsystem, uapi and virtio-rpmb driver
Date: Mon, 29 May 2023 23:23:36 +0000
Message-ID: <ef44fb8e-7b31-96a7-2ce0-302f11bbbdc2@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5551304955407145420=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5551304955407145420==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Alex,


Are you still working on it or planning to resubmit it ?

[1] The current optee tee kernel driver implementation doesn't work when
IMA is used with optee implemented ftpm.

The ftpm has dependency on tee-supplicant which comes once the user-space
is up and running and IMA attestation happens at boot time and it requires
to extend ftpm PCRs.

But IMA can't use PCRs if ftpm use secure emmc RPMB partition. As optee
can only access RPMB via tee-supplicant(user space). So, there should
be a fast path to allow optee os to access the RPMB parititon without
waiting for user-space the tee supplicant.

To achieve this fast path linux optee driver and mmc driver needs
some work and finally it will need RPMB driver which you posted.

Please let me know what's your plan on this.

[1] https://optee.readthedocs.io/en/latest/architecture/secure_storage.html

Thanks,
Shyam

--===============5551304955407145420==--

