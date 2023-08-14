From: Ruth Glushkin <rutigl@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: tpm2 device fail on u-boot
Date: Mon, 14 Aug 2023 10:52:52 +0300
Message-ID: 
 <CALDRwioa8N+2xK53F0i0E6gaPQXEucJbiYP6=kzyVuVu5LbM1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2315543573465875707=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2315543573465875707==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi,
I have u-boot based on u-boot 2021.04
I have configuration with fTPM of Microsoft enabled.
I have a EVB board with Nuvoton chip.
OPTee-OS is based on latest 3.22 upstream version with Nuvoton npcm
platform configuration.
If I take OPTee-OS without reading HUK from our PCR0 field from
non-secured memory,
the command works fine.
If I add reading HUK, the command fails.
Here is the error log:
-
U-Boot>tpm2 device
optee optee: OP-TEE: revision 3.22 (a012b992)
I/TC: Reserved shared memory is enabled
I/TC: Dynamic shared memory is enabled
I/TC: Normal World virtualization support is disabled
I/TC: Asynchronous notifications are disabled
E/TC:0 0 std_entry_with_parg:235 Bad arg address 0x7fce2000
Couldn't set TPM 0 (rc = 1)
-

All other commands of tpm2 that are not connected to fTPM works OK.
After loading Linux, xtest works OK.

Could you please help me?

Thank you in advance,
Margarita Glushkin

--===============2315543573465875707==--

