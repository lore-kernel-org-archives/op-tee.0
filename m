From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v2 0/2] optee: SHM handling fixes
Date: Fri, 19 Jun 2020 22:33:55 +0000
Message-ID: <20200619223332.438344-1-volodymyr_babchuk@epam.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3495816084548725897=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3495816084548725897==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

There are two patches that previously was mailed separatedly. Both
patches fix issues found during testing the OP-TEE 3.9 release.

Julien and Stefano suggested to include this patches in Xen 4.14
release, because optee support still in the preview state and those
patches provide no new functionality, bugfixes only.

Volodymyr Babchuk (2):
  optee: immediately free buffers that are released by OP-TEE
  optee: allow plain TMEM buffers with NULL address

 xen/arch/arm/tee/optee.c | 59 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 7 deletions(-)

-- 
2.26.2

--===============3495816084548725897==--

