From: Manuel Traut <manut@mecka.net>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v7 0/4] Replay Protected Memory Block (RPMB) subsystem
Date: Thu, 30 May 2024 16:38:29 +0200
Message-ID: <ZliPZWm0oVxLwUSQ@mecka.net>
In-Reply-To: <20240527121340.3931987-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1779148930202776920=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1779148930202776920==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On Mon, May 27, 2024 at 02:13:36PM +0200, Jens Wiklander wrote:
> Hi,
>=20
> This patch set introduces a new RPMB subsystem, based on patches from [1],
> [2], and [3]. The RPMB subsystem aims at providing access to RPMB
> partitions to other kernel drivers, in particular the OP-TEE driver. A new
> user space ABI isn't needed, we can instead continue using the already
> present ABI when writing the RPMB key during production.
>=20
> I've added and removed things to keep only what is needed by the OP-TEE
> driver. Since the posting of [3], there has been major changes in the MMC
> subsystem so "mmc: block: register RPMB partition with the RPMB subsystem"
> is in practice completely rewritten.
>=20
> With this OP-TEE can access RPMB during early boot instead of having to
> wait for user space to become available as in the current design [4].
> This will benefit the efi variables [5] since we won't rely on userspace as
> well as some TPM issues [6] that were solved.

I applied the patches to 6.10~rc1 today and tried them on a Toradex
Verdin Board with an i.MX8MM.
=20
> The OP-TEE driver finds the correct RPMB device to interact with by
> iterating over available devices until one is found with a programmed
> authentication matching the one OP-TEE is using. This enables coexisting
> users of other RPMBs since the owner can be determined by who knows the
> authentication key.

The probing does not work for me.

> The corresponding secure world OP-TEE patches are available at [7].

I added some debug prints to see that the optee side properly detected
the need to reinit in tee_rpmb_init. The rpmb_ctx->key_verified is false
and the following call of rpmb_probe_reset fails which leads to the
panic of the TA trying to do a rpmb request.

Same codeflow can be seen earlier during probing the rpmb device but
without the panic.

I am not sure if I find time to look at it in more detail tomorrow.
Otherwise next week.

Thanks
Manuel

> I've put myself as a maintainer for the RPMB subsystem as I have an
> interest in the OP-TEE driver to keep this in good shape. However, if you'd
> rather see someone else taking the maintainership that's fine too. I'll
> help keep the subsystem updated regardless.
>=20
> [1] https://lore.kernel.org/lkml/20230722014037.42647-1-shyamsaini(a)linux.=
microsoft.com/
> [2] https://lore.kernel.org/lkml/20220405093759.1126835-2-alex.bennee(a)lin=
aro.org/
> [3] https://lore.kernel.org/linux-mmc/1478548394-8184-2-git-send-email-toma=
s.winkler(a)intel.com/
> [4] https://optee.readthedocs.io/en/latest/architecture/secure_storage.html=
#rpmb-secure-storage
> [5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Dc44b6be62e8dd4ee0a308c36a70620613e6fc55f
> [6] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D7269cba53d906cf257c139d3b3a53ad272176bca
> [7] https://github.com/jenswi-linaro/optee_os/tree/rpmb_probe_v7
>=20
> Thanks,
> Jens
>=20
> Changes since v6:
> * Add Tested-by: Manuel Traut <manut@mecka.net> provided for the v6
> * Add a new patch "tee: add tee_device_set_dev_groups()" needed later in
>   the patch set
> * Reintroduce the rpmb_class as requested by Greg, this affects the patches
>   "rpmb: add Replay Protected Memory Block (RPMB) subsystem" and
>   "optee: probe RPMB device using RPMB subsystem"
> * "rpmb: add Replay Protected Memory Block (RPMB) subsystem":
>   - rpmb_interface_{,un}register() are now based on
>     class_interface_{,un}register()
>   - Embed a separate device in struct rpmb_dev for life cycle
>     management etc
> * "optee: probe RPMB device using RPMB subsystem"
>   - Add an internal blocking_notifier to deal with the struct
>     class_interface callback
>   - Add a rpmb_routing_model variable in sysfs to help integration with
>     systemd, requested by Mikko Rapeli
>   - Add an RPMB probe capability flag in the ABI shared with the secure
>     world, both SMC and FF-A ABI, needed to support the rpmb_routing_model
>     variable
>   - optee_rpc_cmd() is strict whether an RPMB RPC request should be
>     forwarded to tee-supplicant or routed via the RPMB subsystem, depending
>     on the reported RPMB routing model
>=20
> Changes since v5:
> Manuel Traut reported and investigated an error on an i.MX8MM, the root
> cause was identified as insufficient alignment on frames sent to the RPMB
> device. Fixed in the OP-TEE driver as described below.
> * "rpmb: add Replay Protected Memory Block (RPMB) subsystem"
>   - Adding a missing EXPORT_SYMBOL_GPL()
> * "optee: probe RPMB device using RPMB subsystem"
>   - Replacing the old OPTEE_RPC_CMD_RPMB ABI with OPTEE_RPC_CMD_RPMB_FRAMES
>     to get rid of the small header struct rpmb_req (now removed) causing
>     the problem.
>   - Matching changes on the secure side + support for re-initializing
>     RPMB in case a boot stage has used RPMB, the latter also reported by=20
>     Manuel Traut.
>=20
> Changes since v4:
> * "rpmb: add Replay Protected Memory Block (RPMB) subsystem"
>   - Describing struct rpmb_descr as RPMB description instead of descriptor
> * "mmc: block: register RPMB partition with the RPMB subsystem"
>   - Addressing review comments
>   - Adding more comments for struct rpmb_frame
>   - Fixing assignment of reliable_wr_count and capacity in mmc_blk_rpmb_add=
()
> * "optee: probe RPMB device using RPMB subsystem"
>   - Updating struct rpmb_dev_info to match changes in "rpmb: add Replay
>     Protected Memory Block (RPMB) subsystem"
>=20
> Changes since v3:
> * Move struct rpmb_frame into the MMC driver since the format of the RPMB
>   frames depend on the implementation, one format for eMMC, another for
>   UFS, and so on
> * "rpmb: add Replay Protected Memory Block (RPMB) subsystem"
>   - Adding Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>   - Adding more description of the API functions
>   - Removing the set_dev_info() op from struct rpmb_ops, the needed informa=
tion
>     is supplied in the arguments to rpmb_dev_register() instead.
>   - Getting rid of struct rpmb_ops since only the route_frames() op was
>     remaining, store that op directly in struct rpmb_dev
>   - Changed rpmb_interface_register() and rpmb_interface_unregister() to use
>     notifier_block instead of implementing the same thing ourselves
> * "mmc: block: register RPMB partition with the RPMB subsystem"
>   - Moving the call to rpmb_dev_register() to be done at the end of
>     mmc_blk_probe() when the device is fully available
> * "optee: probe RPMB device using RPMB subsystem"
>   - Use IS_REACHABLE(CONFIG_RPMB) to determine if the RPMB subsystem is
>     available
>   - Translate TEE_ERROR_STORAGE_NOT_AVAILABLE if encountered in get_devices=
()
>     to recognize the error in optee_rpmb_scan()
>   - Simplified optee_rpmb_scan() and optee_rpmb_intf_rdev()
>=20
> Changes since v2:
> * "rpmb: add Replay Protected Memory Block (RPMB) subsystem"
>   - Fixing documentation issues
>   - Adding a "depends on MMC" in the Kconfig
>   - Removed the class-device and the embedded device, struct rpmb_dev now
>     relies on the parent device for reference counting as requested
>   - Removed the now unneeded rpmb_ops get_resources() and put_resources()
>     since references are already taken in mmc_blk_alloc_rpmb_part() before
>     rpmb_dev_register() is called
>   - Added rpmb_interface_{,un}register() now that
>     class_interface_{,un}register() can't be used ay longer
> * "mmc: block: register RPMB partition with the RPMB subsystem"
>   - Adding the missing error cleanup in alloc_idata()
>   - Taking the needed reference to md->disk in mmc_blk_alloc_rpmb_part()
>     instead of in mmc_rpmb_chrdev_open() and rpmb_op_mmc_get_resources()
> * "optee: probe RPMB device using RPMB subsystem"
>   - Registering to get a notification when an RPMB device comes online
>   - Probes for RPMB devices each time an RPMB device comes online, until
>     a usable device is found
>   - When a usable RPMB device is found, call
>     optee_enumerate_devices(PTA_CMD_GET_DEVICES_RPMB)
>   - Pass type of rpmb in return value from OPTEE_RPC_CMD_RPMB_PROBE_NEXT
>=20
> Changes since Shyam's RFC:
> * Removed the remaining leftover rpmb_cdev_*() function calls
> * Refactored the struct rpmb_ops with all the previous ops replaced, in
>   some sense closer to [3] with the route_frames() op
> * Added rpmb_route_frames()
> * Added struct rpmb_frame, enum rpmb_op_result, and enum rpmb_type from [3]
> * Removed all functions not needed in the OP-TEE use case
> * Added "mmc: block: register RPMB partition with the RPMB subsystem", based
>   on the commit with the same name in [3]
> * Added "optee: probe RPMB device using RPMB subsystem" for integration
>   with OP-TEE
> * Moved the RPMB driver into drivers/misc/rpmb-core.c
> * Added my name to MODULE_AUTHOR() in rpmb-core.c
> * Added an rpmb_mutex to serialize access to the IDA
> * Removed the target parameter from all rpmb_*() functions since it's
>   currently unused
>=20
>=20
> Jens Wiklander (4):
>   rpmb: add Replay Protected Memory Block (RPMB) subsystem
>   mmc: block: register RPMB partition with the RPMB subsystem
>   tee: add tee_device_set_dev_groups()
>   optee: probe RPMB device using RPMB subsystem
>=20
>  Documentation/ABI/testing/sysfs-class-tee |  15 ++
>  MAINTAINERS                               |   8 +
>  drivers/misc/Kconfig                      |  10 +
>  drivers/misc/Makefile                     |   1 +
>  drivers/misc/rpmb-core.c                  | 232 +++++++++++++++++++++
>  drivers/mmc/core/block.c                  | 241 +++++++++++++++++++++-
>  drivers/tee/optee/core.c                  |  96 ++++++++-
>  drivers/tee/optee/device.c                |   7 +
>  drivers/tee/optee/ffa_abi.c               |  14 ++
>  drivers/tee/optee/optee_ffa.h             |   2 +
>  drivers/tee/optee/optee_private.h         |  26 ++-
>  drivers/tee/optee/optee_rpc_cmd.h         |  35 ++++
>  drivers/tee/optee/optee_smc.h             |   2 +
>  drivers/tee/optee/rpc.c                   | 177 ++++++++++++++++
>  drivers/tee/optee/smc_abi.c               |  14 ++
>  drivers/tee/tee_core.c                    |  19 +-
>  include/linux/rpmb.h                      | 123 +++++++++++
>  include/linux/tee_drv.h                   |  12 ++
>  18 files changed, 1024 insertions(+), 10 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-tee
>  create mode 100644 drivers/misc/rpmb-core.c
>  create mode 100644 include/linux/rpmb.h
>=20
> --=20
> 2.34.1
>=20

--===============1779148930202776920==--

