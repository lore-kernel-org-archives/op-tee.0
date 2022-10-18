From: Balint Dobszay <balint.dobszay@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: OP-TEE 3.19 SPMC status
Date: Tue, 18 Oct 2022 12:49:00 +0200
Message-ID: <DED8C1F4-8EA9-4CB6-9A59-4FF037341A7D@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3312016281604979779=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3312016281604979779==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi All,

This is a follow-up email to the OP-TEE 3.19 release, highlighting the
updates to the SPMC and related components.

Short summary of introduced changes:
  - Added support for running SPs loaded from the FIP (by TF-A). This is
    an alternative to the current embedded SP loading mechanism [1].
  - Added a new suite to xtest (ffa_spmc) to enable testing the SPMC as
    part of the normal OP-TEE test procedure [2].

For more details on how to get, build and test the SPMC, please see [3].
Our 3.19 release related test results are captured on this page [4].

Regards,
Balint

[1] https://optee.readthedocs.io/en/latest/architecture/spmc.html#sp-loading-=
mechanism
[2] https://github.com/OP-TEE/optee_test/blob/3.19.0/host/xtest/ffa_spmc_1000=
.c
[3] https://developer.trustedfirmware.org/w/trusted-services/op-tee-spmc
[4] https://developer.trustedfirmware.org/w/trusted-services/op-tee-spmc/rele=
ase-testing-3-19

--===============3312016281604979779==--

