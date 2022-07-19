From: Balint Dobszay <balint.dobszay@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: OP-TEE 3.18 SPMC status
Date: Tue, 19 Jul 2022 16:10:28 +0200
Message-ID: <8D5B0415-5CE8-4401-9727-030F4CF9843D@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7522375534427348851=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7522375534427348851==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi All,

This is a follow-up email to the OP-TEE 3.18 release, highlighting the
updates to the SPMC and related components.

Short summary of introduced changes:
  - optee_os: Added support to the SPMC to process memory regions
              described in the SP manifest. This enables running the
              Trusted Services smm-gateway SP.
  - manifest: Added new manifest (derived from the fvp manifest) which
              includes Trusted Services and related kernel modules [1].
  - build:    Added new top level Makefile to configure optee_os as
              S-EL1 SPMC, build Trusted Services SPs and test apps [2].

For more details on how to get, build and test the SPMC, please see [3].

Regards,
Balint

[1]: https://github.com/OP-TEE/manifest/blob/3.18.0/fvp-ts.xml
[2]: https://github.com/OP-TEE/build/blob/3.18.0/fvp-psa-sp.mk
[3]: https://developer.trustedfirmware.org/w/trusted-services/op-tee-spmc

--===============7522375534427348851==--

