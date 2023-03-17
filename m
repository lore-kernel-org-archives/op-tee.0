From: Herbert Xu <herbert@gondor.apana.org.au>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 0/8] Export platform features from ccp driver
Date: Fri, 17 Mar 2023 11:26:02 +0800
Message-ID: <ZBPdypC1EBbQ1lDR@gondor.apana.org.au>
In-Reply-To: <20230310211954.2490-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4980804226462149119=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4980804226462149119==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, Mar 10, 2023 at 03:19:43PM -0600, Mario Limonciello wrote:
> The i2c-designware-amdpsp driver communicates with a platform
> features mailbox provided by the PSP.  The address used for
> communication is discovered via a non-architecturally
> guaranteed mechanism.
> 
> To better scale, export a feature for communication with platform
> features directly from the ccp driver.
> 
> v3->v4
>  Drop the ACPI ID as result of confirmation with internal team.
>  Future platforms should use doorbell, so will treat Cezanne as quirk
>  and assume doorbell going forward.
> 
> Mario Limonciello (8):
>   crypto: ccp: Drop TEE support for IRQ handler
>   crypto: ccp: Add a header for multiple drivers to use `__psp_pa`
>   crypto: ccp: Move some PSP mailbox bit definitions into common header
>   crypto: ccp: Add support for an interface for platform features
>   crypto: ccp: Enable platform access interface on client PSP parts
>   i2c: designware: Use PCI PSP driver for communication
>   crypto: ccp: Add support for ringing a platform doorbell
>   i2c: designware: Add doorbell support for Skyrim
> 
>  arch/x86/kvm/svm/sev.c                      |   1 +
>  drivers/crypto/ccp/Makefile                 |   3 +-
>  drivers/crypto/ccp/platform-access.c        | 232 ++++++++++++++++++++
>  drivers/crypto/ccp/platform-access.h        |  35 +++
>  drivers/crypto/ccp/psp-dev.c                |  32 +--
>  drivers/crypto/ccp/psp-dev.h                |  11 +-
>  drivers/crypto/ccp/sev-dev.c                |  16 +-
>  drivers/crypto/ccp/sev-dev.h                |   2 +-
>  drivers/crypto/ccp/sp-dev.h                 |  10 +
>  drivers/crypto/ccp/sp-pci.c                 |   9 +
>  drivers/crypto/ccp/tee-dev.c                |  17 +-
>  drivers/i2c/busses/Kconfig                  |   2 +-
>  drivers/i2c/busses/i2c-designware-amdpsp.c  | 188 ++++------------
>  drivers/i2c/busses/i2c-designware-core.h    |   1 -
>  drivers/i2c/busses/i2c-designware-platdrv.c |   1 -
>  drivers/tee/amdtee/call.c                   |   2 +-
>  drivers/tee/amdtee/shm_pool.c               |   2 +-
>  include/linux/psp-platform-access.h         |  65 ++++++
>  include/linux/psp-sev.h                     |   8 -
>  include/linux/psp.h                         |  29 +++
>  20 files changed, 461 insertions(+), 205 deletions(-)
>  create mode 100644 drivers/crypto/ccp/platform-access.c
>  create mode 100644 drivers/crypto/ccp/platform-access.h
>  create mode 100644 include/linux/psp-platform-access.h
>  create mode 100644 include/linux/psp.h
> 
> -- 
> 2.34.1

Patches 1-5 and 7 applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--===============4980804226462149119==--

