From: Arnd Bergmann <arnd@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [GIT PULL] OP-TEE fix for v5.12
Date: Wed, 03 Feb 2021 13:30:56 +0100
Message-ID: <161235543740.2002596.8962861009539553209.b4-ty@arndb.de>
In-Reply-To: <20210203120953.GB3624453@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4447427853089125243=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4447427853089125243==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Arnd Bergmann <arnd@arndb.de>

On Wed, 3 Feb 2021 13:09:53 +0100, Jens Wiklander wrote:
> Please pull this small fix removing an unnecessary call to need_resched()
> before cond_resched() while the OP-TEE driver is handing a RPC.
> 
> Thanks,
> Jens
> 
> The following changes since commit e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62:
> 
> [...]

Merged into arm/drivers, thanks!

merge commit: d94bd41a0022ca3e14479ed7b71cc5f79f159750

       Arnd

--===============4447427853089125243==--

