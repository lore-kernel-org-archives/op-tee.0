From: XiaoXia <cxx194832@alibaba-inc.com>
To: op-tee@lists.trustedfirmware.org
Subject: HELP for OPTEE Application crash when wakeup from Hiberation
Date: Fri, 03 Nov 2023 13:42:17 +0000
Message-ID: <f223e352-799d-4037-af14-a6e83f2daa54.cxx194832@alibaba-inc.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0793428973312476983=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0793428973312476983==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello All:=20
I have new project for developping TEE in notebook. the system needs to suppo=
rt S4 (Hiberation/STD) in order to reduce the power consume.=20
To make the design simplest, I follow the regular suspend flow as below:
1. the kernel implement suspend flow to freeze thread and store data in swap =
paritition. then enter into S3 mode
2. system wakeups by pressing poweron event, and boot into kernel as normal. =
and the TEE OS and Trusted firmware will initialize like in normal boot.
Once kernel recover all context, I try to issue CA again, and it prompts the =
below error message.=20
I know that the context of TEE-OS and TEE driver does not match new after sys=
tem recovery... I wonder to know if there is way to cleanup TEE driver before=
 entering into S4 to make CA work after wakeup .
Thank you for your help .=20
Best Regareds,
Vincent Cui

--===============0793428973312476983==--

