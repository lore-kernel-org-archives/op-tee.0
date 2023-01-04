From: 梅建强(禹夜) <meijianqiang.mjq@alibaba-inc.com>
To: op-tee@lists.trustedfirmware.org
Subject: optee device tree and tee driver
Date: Thu, 05 Jan 2023 01:10:00 +0800
Message-ID: 
 <56467e5f-c1d8-400e-83ad-4fec823dee30.meijianqiang.mjq@alibaba-inc.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6599504229721403508=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6599504229721403508==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello expert,=20
I have a few questions about the optee device tree and tee driver.=20
In our environment, optee uses version 3.19 vexpress-fvp and runs on top of h=
afnium as SPMC. Here's my question.=20
1. Does the current optee version support adding ACPI table iterm for optee t=
o enable REE to identify the installed optee driver so that TA and CA can est=
ablish communication?=20
(I raise this question because I cannot find the corresponding optee node in =
"/sys/devices/platform" in the current linux environment.=20
While in the QEMU runtime environment, the corresponding optee node is in "/p=
roc/device-tree/firmware", i.e. "linaro,optee-tz".)=20
2. If I want to transfer dtb file which includes a device tree node written b=
y optee to linux, How to configure CFG_DT, CFG_DT_ADDR, and CFG_EXTERNAL_DTB_=
OVERLAY?
 (I understand that this method should be independent from the method in ques=
tion 1. If it is not, look forward your explain.)
Looking forward to your reply. Thanks.
regards,
yuye

--===============6599504229721403508==--

