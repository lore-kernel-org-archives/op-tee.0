From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v9 0/4] Introduce TEE based Trusted Keys support
Date: Mon, 01 Mar 2021 18:41:23 +0530
Message-ID: <20210301131127.793707-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8066736207598074097=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8066736207598074097==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Add support for TEE based trusted keys where TEE provides the functionality
to seal and unseal trusted keys using hardware unique key. Also, this is
an alternative in case platform doesn't possess a TPM device.

This patch-set has been tested with OP-TEE based early TA which is already
merged in upstream [1].

[1] https://github.com/OP-TEE/optee_os/commit/f86ab8e7e0de869dfa25ca05a37ee07=
0d7e5b86b

Changes in v9:
1. Rebased to latest tpmdd/master.
2. Defined pr_fmt() and removed redundant tags.
3. Patch #2: incorporated misc. comments.
4. Patch #3: incorporated doc changes from Elaine and misc. comments
   from Randy.
5. Patch #4: reverted to separate maintainer entry as per request from
   Jarkko.
6. Added Jarkko's Tested-by: tag on patch #2.

Changes in v8:
1. Added static calls support instead of indirect calls.
2. Documented trusted keys source module parameter.
3. Refined patch #1 commit message discription.
4. Addressed misc. comments on patch #2.
5. Added myself as Trusted Keys co-maintainer instead.
6. Rebased to latest tpmdd master.

Changes in v7:
1. Added a trusted.source module parameter in order to enforce user's
   choice in case a particular platform posses both TPM and TEE.
2. Refine commit description for patch #1.

Changes in v6:
1. Revert back to dynamic detection of trust source.
2. Drop author mention from trusted_core.c and trusted_tpm1.c files.
3. Rebased to latest tpmdd/master.

Changes in v5:
1. Drop dynamic detection of trust source and use compile time flags
   instead.
2. Rename trusted_common.c -> trusted_core.c.
3. Rename callback: cleanup() -> exit().
4. Drop "tk" acronym.
5. Other misc. comments.
6. Added review tags for patch #3 and #4.

Changes in v4:
1. Pushed independent TEE features separately:
  - Part of recent TEE PR: https://lkml.org/lkml/2020/5/4/1062
2. Updated trusted-encrypted doc with TEE as a new trust source.
3. Rebased onto latest tpmdd/master.

Changes in v3:
1. Update patch #2 to support registration of multiple kernel pages.
2. Incoporate dependency patch #4 in this patch-set:
   https://patchwork.kernel.org/patch/11091435/

Changes in v2:
1. Add reviewed-by tags for patch #1 and #2.
2. Incorporate comments from Jens for patch #3.
3. Switch to use generic trusted keys framework.

Sumit Garg (4):
  KEYS: trusted: Add generic trusted keys framework
  KEYS: trusted: Introduce TEE based Trusted Keys
  doc: trusted-encrypted: updates with TEE as a new trust source
  MAINTAINERS: Add entry for TEE based Trusted Keys

 .../admin-guide/kernel-parameters.txt         |  12 +
 .../security/keys/trusted-encrypted.rst       | 171 ++++++--
 MAINTAINERS                                   |   8 +
 include/keys/trusted-type.h                   |  53 +++
 include/keys/trusted_tee.h                    |  16 +
 include/keys/trusted_tpm.h                    |  29 +-
 security/keys/trusted-keys/Makefile           |   2 +
 security/keys/trusted-keys/trusted_core.c     | 358 +++++++++++++++++
 security/keys/trusted-keys/trusted_tee.c      | 317 +++++++++++++++
 security/keys/trusted-keys/trusted_tpm1.c     | 366 ++++--------------
 10 files changed, 981 insertions(+), 351 deletions(-)
 create mode 100644 include/keys/trusted_tee.h
 create mode 100644 security/keys/trusted-keys/trusted_core.c
 create mode 100644 security/keys/trusted-keys/trusted_tee.c

--=20
2.25.1


--===============8066736207598074097==--

