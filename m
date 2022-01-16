From: 起飞的老杨 <sprhawk@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: no TEE TA log (D/TA:) issue (github issue #5112)
Date: Sun, 16 Jan 2022 21:22:34 +0800
Message-ID: 
 <CADBJ=yH5BhWpX5EF8yBFy-LBdbFtMP9T8rGWgvoCsyeUo-2GZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1974005546805802158=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1974005546805802158==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hello, I got problems here:

I built  the whole system with yotcto 3.3.3, linux kernel 5.10, optee-os
3.14, platform for rk3399 ( was working for qemu platform ).

Console Configuration:
U-Boot / TrustFirmware-A / optee-os: all pointed console to uart2
linux dts: chosen and secure-chosen all pointed to uart2. uart2's status
and secure-status are both set to "okay"

Build Configuration:
optee-os:

                                      DEBUG=1 \
                                      CFG_TEE_CORE_LOG_LEVEL=4 \
                                      CFG_TEE_CORE_DEBUG=y \
                                      CFG_TEE_TA_LOG_LEVEL=4 \
                                      ...

both optee-examples and my TA:

                                      DEBUG=1 \
                                      CFG_TEE_TA_LOG_LEVEL=4 \
                                      ...

During boot I can see D/TC: logs, but no any D/TA: log is output.

Some D/TC log like this:

D/TC:? 0 tee_ta_init_session_with_context:607 Re-open TA xxxxx
D/TC:? 0 tee_ta_close_session:512 csess 0xDDDDDD id 1
D/TC:? 0 tee_ta_close_session:531 Destroy session

My TA has correct output, no crashes,or other errors


Thanks.

--===============1974005546805802158==--

