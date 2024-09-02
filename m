From: Arnd Bergmann <arnd@arndb.de>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 1/2] mmc: block: add RPMB dependency
Date: Mon, 02 Sep 2024 15:14:50 +0000
Message-ID: <75d9c06f-5af3-4088-8813-b4a3ccb59434@app.fastmail.com>
In-Reply-To: <20240902151231.3705204-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6016078888597788928=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6016078888597788928==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Mon, Sep 2, 2024, at 15:12, Jens Wiklander wrote:
> Prevent build error when CONFIG_RPMB=m and CONFIG_MMC_BLOCK=y by adding
> a dependency to CONFIG_RPMB for CONFIG_MMC_BLOCK block so the RPMB
> subsystem always is reachable if configured. This means that
> CONFIG_MMC_BLOCK automatically becomes compiled as a module if
> CONFIG_RPMB is compiled as a module. If CONFIG_RPMB isn't configured or
> is configured as built-in, CONFIG_MMC_BLOCK will remain unchanged.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: 
> https://lore.kernel.org/oe-kbuild-all/202409021448.RSvcBPzt-lkp(a)intel.com/
> Fixes: 7852028a35f0 ("mmc: block: register RPMB partition with the RPMB 
> subsystem")
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

--===============6016078888597788928==--

