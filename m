From: Jerome Forissier <jerome@forissier.org>
To: op-tee@lists.trustedfirmware.org
Subject: [op-tee] [PATCH v2 0/2] hw/arm/virt: dt: add kaslr-seed property
Date: Mon, 20 Apr 2020 14:18:05 +0200
Message-ID: <20200420121807.8204-1-jerome@forissier.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4936133501417343725=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4936133501417343725==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

This patchset creates the DT property /chosen/kaslr-seed which is used
by the OS for Address Space Layout Randomization. If the machine is
secure, a similar property is created under /secure-chosen.

Changes since v1:
 - Move creation of /secure-chosen to create_fdt()
 - Use qemu_guest_getrandom() instead of qcrypto_random_bytes()
 - Create kaslr-seed for the non-secure OS too

Jerome Forissier (2):
  hw/arm/virt: dt: move creation of /secure-chosen to create_fdt()
  hw/arm/virt: dt: add kaslr-seed property

 hw/arm/virt.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

-- 
2.20.1


--===============4936133501417343725==--

