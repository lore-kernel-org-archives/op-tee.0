From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 0/5] TEE driver for Trusted Services
Date: Wed, 03 Apr 2024 14:13:12 +0200
Message-ID: 
 <CAHUa44H-7V8SjEt6Xj5+hW-nAVMkuRC=pwvsgyGyzcgVaOXTYw@mail.gmail.com>
In-Reply-To: <20240325151105.135667-1-balint.dobszay@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3301895585892265110=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3301895585892265110==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 4:11=E2=80=AFPM Balint Dobszay <balint.dobszay@arm.=
com> wrote:
>
> This series introduces a TEE driver for Trusted Services [1].
>
> Trusted Services is a TrustedFirmware.org project that provides a
> framework for developing and deploying device Root of Trust services in
> FF-A [2] Secure Partitions. The project hosts the reference
> implementation of Arm Platform Security Architecture [3] for Arm
> A-profile devices.
>
> The FF-A Secure Partitions are accessible through the FF-A driver in
> Linux. However, the FF-A driver doesn't have a user space interface so
> user space clients currently cannot access Trusted Services. The goal of
> this TEE driver is to bridge this gap and make Trusted Services
> functionality accessible from user space.
>
> Changelog:
> v3[7] -> v4:
>   - Remove unnecessary callbacks from tstee_ops
>   - Add maintainers entry for the new driver
>
> v2[6] -> v3:
>   - Add patch "tee: Refactor TEE subsystem header files" from Sumit
>   - Remove unnecessary includes from core.c
>   - Remove the mutex from "struct ts_context_data" since the same
>     mechanism could be implemented by reusing the XArray's internal lock
>   - Rename tee_shm_pool_op_*_helper functions as suggested by Sumit
>   - Replace pr_* with dev_* as previously suggested by Krzysztof
>
> v1[5] -> v2:
>   - Refactor session handling to use XArray instead of IDR and linked
>     list (the linked list was redundant as pointed out by Jens, and IDR
>     is now deprecated in favor of XArray)
>   - Refactor tstee_probe() to not call tee_device_unregister() before
>     calling tee_device_register()
>   - Address comments from Krzysztof and Jens
>   - Address documentation comments from Randy
>   - Use module_ffa_driver() macro instead of separate module init / exit
>     functions
>   - Reformat max line length 100 -> 80
>
> RFC[4] -> v1:
>   - Add patch for moving pool_op helper functions to the TEE subsystem,
>     as suggested by Jens
>   - Address comments from Sumit, add patch for documentation
>
> [1] https://www.trustedfirmware.org/projects/trusted-services/
> [2] https://developer.arm.com/documentation/den0077/
> [3] https://www.arm.com/architecture/security-features/platform-security
> [4] https://lore.kernel.org/linux-arm-kernel/20230927152145.111777-1-balint=
.dobszay(a)arm.com/
> [5] https://lore.kernel.org/lkml/20240213145239.379875-1-balint.dobszay(a)a=
rm.com/
> [6] https://lore.kernel.org/lkml/20240223095133.109046-1-balint.dobszay(a)a=
rm.com/
> [7] https://lore.kernel.org/lkml/20240305101745.213933-1-balint.dobszay(a)a=
rm.com/
>
>
> Balint Dobszay (4):
>   tee: optee: Move pool_op helper functions
>   tee: tstee: Add Trusted Services TEE driver
>   Documentation: tee: Add TS-TEE driver
>   MAINTAINERS: tee: tstee: Add entry
>
> Sumit Garg (1):
>   tee: Refactor TEE subsystem header files
>
>  Documentation/tee/index.rst         |   1 +
>  Documentation/tee/ts-tee.rst        |  71 ++++
>  MAINTAINERS                         |  10 +
>  drivers/tee/Kconfig                 |   1 +
>  drivers/tee/Makefile                |   1 +
>  drivers/tee/amdtee/amdtee_private.h |   2 +-
>  drivers/tee/amdtee/call.c           |   2 +-
>  drivers/tee/amdtee/core.c           |   3 +-
>  drivers/tee/amdtee/shm_pool.c       |   2 +-
>  drivers/tee/optee/call.c            |   2 +-
>  drivers/tee/optee/core.c            |  66 +---
>  drivers/tee/optee/device.c          |   2 +-
>  drivers/tee/optee/ffa_abi.c         |   8 +-
>  drivers/tee/optee/notif.c           |   2 +-
>  drivers/tee/optee/optee_private.h   |  14 +-
>  drivers/tee/optee/rpc.c             |   2 +-
>  drivers/tee/optee/smc_abi.c         |  11 +-
>  drivers/tee/tee_core.c              |   2 +-
>  drivers/tee/tee_private.h           |  35 --
>  drivers/tee/tee_shm.c               |  66 +++-
>  drivers/tee/tee_shm_pool.c          |   2 +-
>  drivers/tee/tstee/Kconfig           |  11 +
>  drivers/tee/tstee/Makefile          |   3 +
>  drivers/tee/tstee/core.c            | 480 ++++++++++++++++++++++++++++
>  drivers/tee/tstee/tstee_private.h   |  92 ++++++
>  include/linux/tee_core.h            | 306 ++++++++++++++++++
>  include/linux/tee_drv.h             | 285 ++---------------
>  include/uapi/linux/tee.h            |   1 +
>  28 files changed, 1094 insertions(+), 389 deletions(-)
>  create mode 100644 Documentation/tee/ts-tee.rst
>  create mode 100644 drivers/tee/tstee/Kconfig
>  create mode 100644 drivers/tee/tstee/Makefile
>  create mode 100644 drivers/tee/tstee/core.c
>  create mode 100644 drivers/tee/tstee/tstee_private.h
>  create mode 100644 include/linux/tee_core.h
>
> --
> 2.34.1
>

I'm picking up this patch set.

Thanks,
Jens

--===============3301895585892265110==--

