From: Tom Lendacky <thomas.lendacky@amd.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v3 0/9] Export platform features from ccp driver
Date: Fri, 03 Mar 2023 14:58:58 -0600
Message-ID: <9b4b0c6a-3cca-593b-bbda-b138e93de513@amd.com>
In-Reply-To: <20230303165050.2918-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0524479160499081935=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0524479160499081935==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On 3/3/23 10:50, Mario Limonciello wrote:
> The i2c-designware-amdpsp driver communicates with a platform
> features mailbox provided by the PSP.  The address used for
> communication is discovered via a non-architecturally
> guaranteed mechanism.
> 
> To better scale, export a feature for communication with platform
> features directly from the ccp driver.
> 

If there is agreement with Jan and Grzegorz for patches 7-9, I'm ok with 
the rest.

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

> v2->v3:
>   * Split new ACPI ID to own patch
>   * Squash doorbell offsets into doorbell patch
>   * Fix all feedback from v2 (see individual patches for details)
> Mario Limonciello (9):
>    crypto: ccp: Drop TEE support for IRQ handler
>    crypto: ccp: Add a header for multiple drivers to use `__psp_pa`
>    crypto: ccp: Move some PSP mailbox bit definitions into common header
>    crypto: ccp: Add support for an interface for platform features
>    crypto: ccp: Enable platform access interface on client PSP parts
>    i2c: designware: Use PCI PSP driver for communication
>    crypto: ccp: Add support for ringing a platform doorbell
>    i2c: designware: Add doorbell support for Skyrim
>    i2c: designware: Add support for AMDI0020 ACPI ID
> 
>   arch/x86/kvm/svm/sev.c                      |   1 +
>   drivers/crypto/ccp/Makefile                 |   3 +-
>   drivers/crypto/ccp/platform-access.c        | 218 ++++++++++++++++++++
>   drivers/crypto/ccp/platform-access.h        |  35 ++++
>   drivers/crypto/ccp/psp-dev.c                |  32 +--
>   drivers/crypto/ccp/psp-dev.h                |  11 +-
>   drivers/crypto/ccp/sev-dev.c                |  16 +-
>   drivers/crypto/ccp/sev-dev.h                |   2 +-
>   drivers/crypto/ccp/sp-dev.h                 |  10 +
>   drivers/crypto/ccp/sp-pci.c                 |   9 +
>   drivers/crypto/ccp/tee-dev.c                |  17 +-
>   drivers/i2c/busses/Kconfig                  |   2 +-
>   drivers/i2c/busses/i2c-designware-amdpsp.c  | 179 +++-------------
>   drivers/i2c/busses/i2c-designware-core.h    |   1 -
>   drivers/i2c/busses/i2c-designware-platdrv.c |   2 +-
>   drivers/tee/amdtee/call.c                   |   2 +-
>   drivers/tee/amdtee/shm_pool.c               |   2 +-
>   include/linux/psp-platform-access.h         |  65 ++++++
>   include/linux/psp-sev.h                     |   8 -
>   include/linux/psp.h                         |  29 +++
>   20 files changed, 438 insertions(+), 206 deletions(-)
>   create mode 100644 drivers/crypto/ccp/platform-access.c
>   create mode 100644 drivers/crypto/ccp/platform-access.h
>   create mode 100644 include/linux/psp-platform-access.h
>   create mode 100644 include/linux/psp.h
> 

--===============0524479160499081935==--

