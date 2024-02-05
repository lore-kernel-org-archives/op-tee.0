From: Igor Zhbanov <izh1979@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: Why UBSAN is marked as using a lot of memory?
Date: Mon, 05 Feb 2024 15:12:16 +0300
Message-ID: 
 <CAEUiM9P9pRto1NSgeEZ0pD55jk6dSp0xd4PaDeKgCnHp+ieV6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6265905911016786596=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6265905911016786596==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hello,

In the configuration makefile mk/config.mk there are following lines:

# Enable support for detected undefined behavior in C
# Uses a lot of memory, can't be enabled by default
CFG_CORE_SANITIZE_UNDEFINED ?= n

I've read the sources of the conditionally compiled ubsan.c and, IIUC,
how UBSAN is working (mostly by adding simple checks), I don't understand,
why UBSAN is marked as using a lot of memory.

Is this comment still valid?

Thank you.

--===============6265905911016786596==--

