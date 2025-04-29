From: neil.armstrong@linaro.org
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 00/11] Trusted Execution Environment (TEE) driver for
 Qualcomm TEE (QTEE)
Date: Tue, 29 Apr 2025 15:01:17 +0200
Message-ID: <3c4e3ed8-ceaf-45c7-a52c-dc7b8209418b@linaro.org>
In-Reply-To: <=?utf-8?q?=3C20250428-qcom-tee-using-tee-ss-without-mem-obj-v4-?=
 =?utf-8?q?0-6a143640a6cb=40oss=2Equalcomm=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2741208699748796933=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2741208699748796933==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 29/04/2025 08:06, Amirreza Zarrabi wrote:
> This patch series introduces a Trusted Execution Environment (TEE)
> driver for Qualcomm TEE (QTEE). QTEE enables Trusted Applications (TAs)
> and services to run securely. It uses an object-based interface, where
> each service is an object with sets of operations. Clients can invoke
> these operations on objects, which can generate results, including other
> objects. For example, an object can load a TA and return another object
> that represents the loaded TA, allowing access to its services.
>=20
> Kernel and userspace services are also available to QTEE through a
> similar approach. QTEE makes callback requests that are converted into
> object invocations. These objects can represent services within the
> kernel or userspace process.
>=20
> Note: This patch series focuses on QTEE objects and userspace services.
>=20
> Linux already provides a TEE subsystem, which is described in [1]. The
> tee subsystem provides a generic ioctl interface, TEE_IOC_INVOKE, which
> can be used by userspace to talk to a TEE backend driver. We extend the
> Linux TEE subsystem to understand object parameters and an ioctl call so
> client can invoke objects in QTEE:
>=20
>    - TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_*
>    - TEE_IOC_OBJECT_INVOKE
>=20
> The existing ioctl calls TEE_IOC_SUPPL_RECV and TEE_IOC_SUPPL_SEND are
> used for invoking services in the userspace process by QTEE.
>=20
> The TEE backend driver uses the QTEE Transport Message to communicate
> with QTEE. Interactions through the object INVOKE interface are
> translated into QTEE messages. Likewise, object invocations from QTEE
> for userspace objects are converted into SEND/RECV ioctl calls to
> supplicants.
>=20
> The details of QTEE Transport Message to communicate with QTEE is
> available in [PATCH 11/11] Documentation: tee: Add Qualcomm TEE driver.
>=20
> You can run basic tests with following steps:
> git clone https://github.com/quic/quic-teec.git
> cd quic-teec
> mkdir build
> cmake .. -DCMAKE_TOOLCHAIN_FILE=3DCMakeToolchain.txt -DBUILD_UNITTEST=3DON
>=20
> https://github.com/quic/quic-teec/blob/main/README.md lists dependencies
> needed to build the above.
>=20
> This series has been tested for basic QTEE object invocations and
> callback requests, including loading a TA and requesting services form
> the TA.
>=20
> Tested platforms: sm8650-mtp
>=20
> [1] https://www.kernel.org/doc/Documentation/tee.txt
>=20
> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>=20
> Changes in v4:
> - Move teedev_ctx_get/put and tee_device_get/put to tee_core.h.
> - Rename object to id in struct tee_ioctl_object_invoke_arg.
> - Replace spinlock with mutex for qtee_objects_idr.
> - Move qcomtee_object_get to qcomtee_user/memobj_param_to_object.
> - More code cleanup following the comments.
> - Cleanup documentations.
> - Update MAINTAINERS file.
> - Link to v3: https://lore.kernel.org/r/20250327-qcom-tee-using-tee-ss-with=
out-mem-obj-v3-0-7f457073282d(a)oss.qualcomm.com
>=20
> Changes in v3:
> - Export shm_bridge create/delete APIs.
> - Enable support for QTEE memory objects.
> - Update the memory management code to use the TEE subsystem for all
>    allocations using the pool.
> - Move all driver states into the driver's main service struct.
> - Add more documentations.
> - Link to v2: https://lore.kernel.org/r/20250202-qcom-tee-using-tee-ss-with=
out-mem-obj-v2-0-297eacd0d34f(a)quicinc.com
>=20
> Changes in v2:
> - Clean up commit messages and comments.
> - Use better names such as ubuf instead of membuf or QCOMTEE prefix
>    instead of QCOM_TEE, or names that are more consistent with other
>    TEE-backend drivers such as qcomtee_context_data instead of
>    qcom_tee_context.
> - Drop the DTS patch and instantiate the device from the scm driver.
> - Use a single structure for all driver's internal states.
> - Drop srcu primitives and use the existing mutex for synchronization
>    between the supplicant and QTEE.
> - Directly use tee_context to track the lifetime of qcomtee_context_data.
> - Add close_context() to be called when the user closes the tee_context.
> - Link to v1: https://lore.kernel.org/r/20241202-qcom-tee-using-tee-ss-with=
out-mem-obj-v1-0-f502ef01e016(a)quicinc.com
>=20
> Changes in v1:
> - It is a complete rewrite to utilize the TEE subsystem.
> - Link to RFC: https://lore.kernel.org/all/20240702-qcom-tee-object-and-ioc=
tls-v1-0-633c3ddf57ee(a)quicinc.com
>=20
> ---
> Amirreza Zarrabi (11):
>        tee: allow a driver to allocate a tee_device without a pool
>        tee: add close_context to TEE driver operation
>        tee: add TEE_IOCTL_PARAM_ATTR_TYPE_UBUF
>        tee: add TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF
>        firmware: qcom: scm: add support for object invocation
>        firmware: qcom: scm: remove unused arguments to the shm_brige
>        firmware: qcom: tzmem: export shm_bridge create/delete
>        tee: add Qualcomm TEE driver
>        qcomtee: add primordial object
>        qcomtee: enable TEE_IOC_SHM_ALLOC ioctl
>        Documentation: tee: Add Qualcomm TEE driver
>=20
>   Documentation/tee/index.rst              |   1 +
>   Documentation/tee/qtee.rst               | 150 ++++++
>   MAINTAINERS                              |   8 +
>   drivers/firmware/qcom/qcom_scm.c         | 132 ++++-
>   drivers/firmware/qcom/qcom_scm.h         |   7 +
>   drivers/firmware/qcom/qcom_tzmem.c       |  57 ++-
>   drivers/tee/Kconfig                      |   1 +
>   drivers/tee/Makefile                     |   1 +
>   drivers/tee/qcomtee/Kconfig              |  10 +
>   drivers/tee/qcomtee/Makefile             |  11 +
>   drivers/tee/qcomtee/async.c              | 160 ++++++
>   drivers/tee/qcomtee/call.c               | 770 ++++++++++++++++++++++++++=
+++
>   drivers/tee/qcomtee/core.c               | 815 ++++++++++++++++++++++++++=
+++++
>   drivers/tee/qcomtee/mem_obj.c            | 172 +++++++
>   drivers/tee/qcomtee/primordial_obj.c     | 115 +++++
>   drivers/tee/qcomtee/qcom_scm.c           |  38 ++
>   drivers/tee/qcomtee/qcomtee_msg.h        | 239 +++++++++
>   drivers/tee/qcomtee/qcomtee_private.h    | 264 ++++++++++
>   drivers/tee/qcomtee/release.c            |  48 ++
>   drivers/tee/qcomtee/shm.c                | 146 ++++++
>   drivers/tee/qcomtee/user_obj.c           | 713 +++++++++++++++++++++++++++
>   drivers/tee/tee_core.c                   | 127 ++++-
>   drivers/tee/tee_private.h                |   6 -
>   include/linux/firmware/qcom/qcom_scm.h   |  31 +-
>   include/linux/firmware/qcom/qcom_tee.h   | 302 ++++++++++++
>   include/linux/firmware/qcom/qcom_tzmem.h |  15 +
>   include/linux/tee_core.h                 |  54 +-
>   include/linux/tee_drv.h                  |  12 +
>   include/uapi/linux/tee.h                 |  54 +-
>   29 files changed, 4427 insertions(+), 32 deletions(-)
> ---
> base-commit: 33035b665157558254b3c21c3f049fd728e72368
> change-id: 20241202-qcom-tee-using-tee-ss-without-mem-obj-362c66340527
>=20
> Best regards,

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-HDK

# /unittest -d
[test_print_diagnostics_info][52] 831360          =3D Total bytes as heap
[test_print_diagnostics_info][53] 111707          =3D Total bytes allocated f=
rom heap
[test_print_diagnostics_info][54] 700160          =3D Total bytes free on heap
[test_print_diagnostics_info][55] 15280           =3D Total bytes overhead
[test_print_diagnostics_info][56] 4213            =3D Total bytes wasted
[test_print_diagnostics_info][57] 454160          =3D Largest free block size

[test_print_diagnostics_info][60] SUCCESS.
# /unittest -l / /smcinvoke_skeleton_ta64.mbn 0
[test_read_file][246] File //smcinvoke_skeleton_ta64.mbn, size: 32856 Bytes.
[test_load_sample_ta][199] SUCCESS.

Thanks,
Neil

--===============2741208699748796933==--

