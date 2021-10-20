From: Arnd Bergmann <arnd@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [GIT PULL] OP-TEE FF-A for V5.16
Date: Wed, 20 Oct 2021 18:00:31 +0200
Message-ID: <163474562374.2274953.13067132975473108014.b4-ty@arndb.de>
In-Reply-To: <20211018121324.GA2943530@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6714487134464718948=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6714487134464718948==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Arnd Bergmann <arnd@arndb.de>

On Mon, 18 Oct 2021 14:13:24 +0200, Jens Wiklander wrote:
> Please pull these patches which adds support for FF-A [1] in the OP-TEE
> driver. There's a bit of shuffling in the code where everyhting related to
> the old SMC based ABI is moved to drivers/tee/optee/smc_abi.c, but there
> should not be any changed in behavior for with the old ABI.
> 
> Note that this is based on top of the recent fix 7f565d0ead26 ("tee: optee:
> Fix missing devices unregister during optee_remove") which has already been
> requested to be pulled.
> 
> [...]

Merged into arm/drivers, thanks!

merge commit: 20f6d9586eee5734072886cf052b72807b0afc4c

       Arnd

--===============6714487134464718948==--

