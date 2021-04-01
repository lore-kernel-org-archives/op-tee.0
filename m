From: Arnd Bergmann <arnd@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [GIT PULL] OP-TEE memref size check for v5.13
Date: Thu, 01 Apr 2021 21:24:13 +0200
Message-ID: <161730504488.632809.12872911046632269445.b4-ty@arndb.de>
In-Reply-To: <20210330110037.GA1166563@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8072466835380705985=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8072466835380705985==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Arnd Bergmann <arnd@arndb.de>

On Tue, 30 Mar 2021 13:00:37 +0200, Jens Wiklander wrote:
> Please pull this small patch for the OP-TEE driver to remove the invalid
> size check of outgoing memref parameters. This code path is only
> activated for a certain configuration of OP-TEE in secure world
> (CFG_CORE_DYN_SHM=n) so this problem isn't always visible.
> 
> Thanks,
> Jens
> 
> [...]

Merged into arm/drivers, thanks!

merge commit: d6358a687891dacbe7d88541a83f61bdccb4f7b8

       Arnd

--===============8072466835380705985==--

