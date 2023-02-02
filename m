From: Balint Dobszay <balint.dobszay@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: OP-TEE S-EL1 SPMC broken
Date: Thu, 02 Feb 2023 15:26:42 +0100
Message-ID: <1A5825B9-91CB-4EF4-BFBD-4D69981F2C96@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4811830273762008558=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4811830273762008558==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi All,

A recent patch in optee_os [1] changed the boot ABI, which causes the
"S-EL1 SPMC + Secure Partitions" config fail to boot. We are currently
investigating the issue.

Regards,
Balint

[1]: https://github.com/OP-TEE/optee_os/commit/f1f431c7a92671b4fa397976d381cc=
5ad8adacc4

--===============4811830273762008558==--

