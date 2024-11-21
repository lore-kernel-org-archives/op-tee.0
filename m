From: Patryk <pbiel7@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: Dynamic shared memory
Date: Thu, 21 Nov 2024 13:47:18 +0100
Message-ID: 
 <CA+DkFDbQcBOtD-rgGAoZiy2HZjpCc=Y9FTJPCez2sQzCH0Di8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5899733257071003767=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5899733257071003767==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hello,
I've been currently looking at the possibility of storing u-boot
environment variables in RPMB and I've stumbled upon this article:
https://www.linaro.org/blog/protected-uefi-variables-with-u-boot/
which briefly describes what needs to be done in order to achieve
this.
Unfortunately there is no comment section in this article so I cannot
ask the author so I decided to try here.
The article mentions that for that purpose, my board should support
dynamic shared memory, therefore the OP-TEE port for my board should
register that memory in platform main using the "register_ddr"
function. For my platform (ls1028ardb) I do not see anything like
this, thus I assume it's not supported. However, I'm wondering - is it
my platform's hardware limitation or missing software implementation?
Making this question more generic - does dynamic shared memory depend
on hardware, meaning that there is no way to register dynamic shared
memory if hardware does not support some particular features?
I would be grateful for some hints.

Best regards
Patryk

--===============5899733257071003767==--

