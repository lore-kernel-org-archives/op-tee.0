From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v3 0/5] Add FF-A support in OP-TEE driver
Date: Mon, 26 Jul 2021 15:59:36 +0530
Message-ID: 
 <CAFA6WYMgWizZoJmk7U0g8zP7Jf_SHLXi3ydMCg2iH5HEQmF=zw@mail.gmail.com>
In-Reply-To: <20210722121757.1944658-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6567058362829144695=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6567058362829144695==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On Thu, 22 Jul 2021 at 17:48, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> Hi all,
>
> This adds supports for the OP-TEE driver to communicate with secure world
> using FF-A [1] as transport.
>
> There is one change to the TEE subsystem with "tee: add sec_world_id to
> struct tee_shm" to add support for holding globally unique handle assigned
> by the FF-A. This is a field that I believe could useful for the AMDTEE
> driver too.
>
> For communication the OP-TEE message protocol is still used, but with a new
> type of memory reference, struct optee_msg_param_fmem, to carry the
> information needed by FF-A. The OP-TEE driver is refactored internally with
> to sets of callbacks, one for the old SMC based communication and another
> set with FF-A as transport. The functions relating to the SMC based ABI
> are moved to smc_abi.c while the FF-A based ABI is added in a ffa_abi.c.
>
> There is also a difference in how the drivers are instantiated. With the
> SMC based transport we have a platform driver, module_platform_driver(),
> today which we're keeping as is for this configuration. In a FF-A system we
> have a FF-A driver, module_ffa_driver(), instead.
>
> The OP-TEE driver can be compiled for both targets at the same time and
> it's up to runtime configuration (device tree or ACPI) to decide how it's
> initialized. Note that it's only the old SMC based driver instance that
> need device tree or ACPI to initialize. The FF-A based driver relies on the
> FF-A bus instead.
>
> This can be tested QEMU
> The repo for SPMC at S-EL1 retrieved by
> repo init -u https://github.com/jenswi-linaro/manifest.git -m
> qemu_v8.xml -b ffav4_spmc
> repo sync
> # Then checkout the branch optee_ffa_v3 from
> # git://git.linaro.org/people/jens.wiklander/linux-tee.git
> # in the linux directory
>
> To build do:
> cd build
> make toolchains
> make all
>
> To boot:
> make run-only
>
> Test with xtest, perhaps only with the command "xtest 1004" in case you're
> not interested in too many tests.

Thanks Jens for sharing instructions to test this feature. So I tried
to reproduce using following repo versions:

linux-tee, branch: optee_ffa_v3
trusted-firmware-a, branch: ffav4_sel1_spmc
build, branch: ffav4_spmc

and rest of the repos synced to the latest version as per upstream
qemu_v8.xml [1] but I don't see OP-TEE driver being probed during boot
[2]. Am I missing something?

[1] https://github.com/OP-TEE/manifest/blob/master/qemu_v8.xml
[2]
Welcome to Buildroot, type root or test to login
buildroot login: root
# dmesg | grep optee
#

-Sumit

>
> Thanks,
> Jens
>
> [1] https://developer.arm.com/documentation/den0077/latest
>
> v2->v3:
> - Rebased on 5.14-rc2 which now have the FF-A patches merged
> - Fixed a couple bugs in optee_shm_register() and optee_shm_unregister()
>   which where introduced in "optee: refactor driver with internal callbacks"
>   in previous the version.
> - Separated SMC ABI specifics into smc_abi.c to keep it separated from
>   the FF-A ABI functions as requested by Sumit.
> - Added the FF-A specifics in ffa_abi.c
> - Provided an implementation for optee_ffa_remove()
>
> v1->v2:
> - Rebased to the FF-A v7 patch
> - Fixed a couple of reports from kernel test robot <lkp@intel.com>
>
> Jens Wiklander (5):
>   tee: add sec_world_id to struct tee_shm
>   optee: simplify optee_release()
>   optee: refactor driver with internal callbacks
>   optee: isolate smc abi
>   optee: add FF-A support
>
>  drivers/tee/optee/Makefile        |    7 +-
>  drivers/tee/optee/call.c          |  415 ++-------
>  drivers/tee/optee/core.c          |  673 ++-------------
>  drivers/tee/optee/ffa_abi.c       |  910 ++++++++++++++++++++
>  drivers/tee/optee/optee_ffa.h     |  153 ++++
>  drivers/tee/optee/optee_msg.h     |   27 +-
>  drivers/tee/optee/optee_private.h |  155 +++-
>  drivers/tee/optee/rpc.c           |  270 +-----
>  drivers/tee/optee/shm_pool.c      |   89 --
>  drivers/tee/optee/shm_pool.h      |   14 -
>  drivers/tee/optee/smc_abi.c       | 1301 +++++++++++++++++++++++++++++
>  include/linux/tee_drv.h           |    7 +-
>  12 files changed, 2650 insertions(+), 1371 deletions(-)
>  create mode 100644 drivers/tee/optee/ffa_abi.c
>  create mode 100644 drivers/tee/optee/optee_ffa.h
>  delete mode 100644 drivers/tee/optee/shm_pool.c
>  delete mode 100644 drivers/tee/optee/shm_pool.h
>  create mode 100644 drivers/tee/optee/smc_abi.c
>
> --
> 2.31.1
>

--===============6567058362829144695==--

