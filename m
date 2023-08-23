From: Linus Walleij <linus.walleij@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [RFC, PATCH 1/1] rpmb: add Replay Protected Memory Block (RPMB) driver
Date: Wed, 23 Aug 2023 10:04:20 +0200
Message-ID: 
 <CACRpkdb=AnJXG2J_DRsN-RUEh=7_eAs8+_CxPYuueVM0c=DP3Q@mail.gmail.com>
In-Reply-To: <226aa02d-1247-a42c-123d-1c86b6b43d9f@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8818615999047596136=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8818615999047596136==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, Aug 22, 2023 at 9:07 PM Shyam Saini
<shyamsaini@linux.microsoft.com> wrote:

> do we plan to disable access to RPMB devices, once we have this RPMB
> driver in place. User space tools like mmc-utils/nvme/ufs utils
> can still access RPMB and programme the key and should
> RPMB driver deny access to RPMB ?

We don't break userspace. Just not. This is not an option.

The RPMB subsystem simply has to provide the rpmb character
device the same way the MMC subsystem did, or provide an
in-kernel backend to the MMC subsystem so that it can provide
the same device. Whatever solution is best.

No deprecation and deletion and breaking userspace. Ever.

Yours,
Linus Walleij

--===============8818615999047596136==--

