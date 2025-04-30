From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 00/11] Trusted Execution Environment (TEE) driver for
 Qualcomm TEE (QTEE)
Date: Thu, 01 May 2025 09:14:21 +1000
Message-ID: <40e28045-7b27-4f7b-8c57-51127fb4e062@oss.qualcomm.com>
In-Reply-To: <3c4e3ed8-ceaf-45c7-a52c-dc7b8209418b@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8895096657879151463=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8895096657879151463==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Neil,

On 4/29/2025 11:01 PM, neil.armstrong(a)linaro.org wrote:
> On 29/04/2025 08:06, Amirreza Zarrabi wrote:
>> This patch series introduces a Trusted Execution Environment (TEE)
>> driver for Qualcomm TEE (QTEE). QTEE enables Trusted Applications (TAs)
>> and services to run securely. It uses an object-based interface, where
>> each service is an object with sets of operations. Clients can invoke
>> these operations on objects, which can generate results, including other
>> objects. For example, an object can load a TA and return another object
>> that represents the loaded TA, allowing access to its services.
>>
>> Kernel and userspace services are also available to QTEE through a
>> similar approach. QTEE makes callback requests that are converted into
>> object invocations. These objects can represent services within the
>> kernel or userspace process.
>>
>> Note: This patch series focuses on QTEE objects and userspace services.
>>
>> Linux already provides a TEE subsystem, which is described in [1]. The
>> tee subsystem provides a generic ioctl interface, TEE_IOC_INVOKE, which
>> can be used by userspace to talk to a TEE backend driver. We extend the
>> Linux TEE subsystem to understand object parameters and an ioctl call so
>> client can invoke objects in QTEE:
>>
>> =C2=A0=C2=A0 - TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_*
>> =C2=A0=C2=A0 - TEE_IOC_OBJECT_INVOKE
>>
>> The existing ioctl calls TEE_IOC_SUPPL_RECV and TEE_IOC_SUPPL_SEND are
>> used for invoking services in the userspace process by QTEE.
>>
>> The TEE backend driver uses the QTEE Transport Message to communicate
>> with QTEE. Interactions through the object INVOKE interface are
>> translated into QTEE messages. Likewise, object invocations from QTEE
>> for userspace objects are converted into SEND/RECV ioctl calls to
>> supplicants.
>>
>> The details of QTEE Transport Message to communicate with QTEE is
>> available in [PATCH 11/11] Documentation: tee: Add Qualcomm TEE driver.
>>
>> You can run basic tests with following steps:
>> git clone https://github.com/quic/quic-teec.git
>> cd quic-teec
>> mkdir build
>> cmake .. -DCMAKE_TOOLCHAIN_FILE=3DCMakeToolchain.txt -DBUILD_UNITTEST=3DON
>>
>> https://github.com/quic/quic-teec/blob/main/README.md lists dependencies
>> needed to build the above.
>>
>> This series has been tested for basic QTEE object invocations and
>> callback requests, including loading a TA and requesting services form
>> the TA.
>>
>> Tested platforms: sm8650-mtp
>>
>> [1] https://www.kernel.org/doc/Documentation/tee.txt
>>
>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>>
>> Changes in v4:
>> - Move teedev_ctx_get/put and tee_device_get/put to tee_core.h.
>> - Rename object to id in struct tee_ioctl_object_invoke_arg.
>> - Replace spinlock with mutex for qtee_objects_idr.
>> - Move qcomtee_object_get to qcomtee_user/memobj_param_to_object.
>> - More code cleanup following the comments.
>> - Cleanup documentations.
>> - Update MAINTAINERS file.
>> - Link to v3: https://lore.kernel.org/r/20250327-qcom-tee-using-tee-ss-wit=
hout-mem-obj-v3-0-7f457073282d(a)oss.qualcomm.com
>>
>> Changes in v3:
>> - Export shm_bridge create/delete APIs.
>> - Enable support for QTEE memory objects.
>> - Update the memory management code to use the TEE subsystem for all
>> =C2=A0=C2=A0 allocations using the pool.
>> - Move all driver states into the driver's main service struct.
>> - Add more documentations.
>> - Link to v2: https://lore.kernel.org/r/20250202-qcom-tee-using-tee-ss-wit=
hout-mem-obj-v2-0-297eacd0d34f(a)quicinc.com
>>
>> Changes in v2:
>> - Clean up commit messages and comments.
>> - Use better names such as ubuf instead of membuf or QCOMTEE prefix
>> =C2=A0=C2=A0 instead of QCOM_TEE, or names that are more consistent with o=
ther
>> =C2=A0=C2=A0 TEE-backend drivers such as qcomtee_context_data instead of
>> =C2=A0=C2=A0 qcom_tee_context.
>> - Drop the DTS patch and instantiate the device from the scm driver.
>> - Use a single structure for all driver's internal states.
>> - Drop srcu primitives and use the existing mutex for synchronization
>> =C2=A0=C2=A0 between the supplicant and QTEE.
>> - Directly use tee_context to track the lifetime of qcomtee_context_data.
>> - Add close_context() to be called when the user closes the tee_context.
>> - Link to v1: https://lore.kernel.org/r/20241202-qcom-tee-using-tee-ss-wit=
hout-mem-obj-v1-0-f502ef01e016(a)quicinc.com
>>
>> Changes in v1:
>> - It is a complete rewrite to utilize the TEE subsystem.
>> - Link to RFC: https://lore.kernel.org/all/20240702-qcom-tee-object-and-io=
ctls-v1-0-633c3ddf57ee(a)quicinc.com
>>
>> ---
>> Amirreza Zarrabi (11):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tee: allow a driver to allocate a tee=
_device without a pool
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tee: add close_context to TEE driver =
operation
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tee: add TEE_IOCTL_PARAM_ATTR_TYPE_UB=
UF
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tee: add TEE_IOCTL_PARAM_ATTR_TYPE_OB=
JREF
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 firmware: qcom: scm: add support for =
object invocation
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 firmware: qcom: scm: remove unused ar=
guments to the shm_brige
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 firmware: qcom: tzmem: export shm_bri=
dge create/delete
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tee: add Qualcomm TEE driver
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qcomtee: add primordial object
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qcomtee: enable TEE_IOC_SHM_ALLOC ioc=
tl
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Documentation: tee: Add Qualcomm TEE =
driver
>>
>> =C2=A0 Documentation/tee/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 Documentation/tee/qtee.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 150 ++++++
>> =C2=A0 MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +
>> =C2=A0 drivers/firmware/qcom/qcom_scm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 132 ++++-
>> =C2=A0 drivers/firmware/qcom/qcom_scm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +
>> =C2=A0 drivers/firmware/qcom/qcom_tzmem.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 57 ++-
>> =C2=A0 drivers/tee/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 drivers/tee/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 1 +
>> =C2=A0 drivers/tee/qcomtee/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 10 +
>> =C2=A0 drivers/tee/qcomtee/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 11 +
>> =C2=A0 drivers/tee/qcomtee/async.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 160 ++++++
>> =C2=A0 drivers/tee/qcomtee/call.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 770 +++++++++++++++++++++++++=
++++
>> =C2=A0 drivers/tee/qcomtee/core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 815 +++++++++++++++++++++++++=
++++++
>> =C2=A0 drivers/tee/qcomtee/mem_obj.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 172 +++++++
>> =C2=A0 drivers/tee/qcomtee/primordial_obj.c=C2=A0=C2=A0=C2=A0=C2=A0 | 115 =
+++++
>> =C2=A0 drivers/tee/qcomtee/qcom_scm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 38 ++
>> =C2=A0 drivers/tee/qcomtee/qcomtee_msg.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 239 +++++++++
>> =C2=A0 drivers/tee/qcomtee/qcomtee_private.h=C2=A0=C2=A0=C2=A0 | 264 +++++=
+++++
>> =C2=A0 drivers/tee/qcomtee/release.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 48 ++
>> =C2=A0 drivers/tee/qcomtee/shm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 146 ++++++
>> =C2=A0 drivers/tee/qcomtee/user_obj.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 713 +++++++++++++++++++++++++++
>> =C2=A0 drivers/tee/tee_core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 127 ++++-
>> =C2=A0 drivers/tee/tee_private.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 -
>> =C2=A0 include/linux/firmware/qcom/qcom_scm.h=C2=A0=C2=A0 |=C2=A0 31 +-
>> =C2=A0 include/linux/firmware/qcom/qcom_tee.h=C2=A0=C2=A0 | 302 ++++++++++=
++
>> =C2=A0 include/linux/firmware/qcom/qcom_tzmem.h |=C2=A0 15 +
>> =C2=A0 include/linux/tee_core.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 54 +-
>> =C2=A0 include/linux/tee_drv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 12 +
>> =C2=A0 include/uapi/linux/tee.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 54 +-
>> =C2=A0 29 files changed, 4427 insertions(+), 32 deletions(-)
>> ---
>> base-commit: 33035b665157558254b3c21c3f049fd728e72368
>> change-id: 20241202-qcom-tee-using-tee-ss-without-mem-obj-362c66340527
>>
>> Best regards,
>=20
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-HDK
>=20
> # /unittest -d
> [test_print_diagnostics_info][52] 831360=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 =3D Total bytes as heap
> [test_print_diagnostics_info][53] 111707=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 =3D Total bytes allocated from heap
> [test_print_diagnostics_info][54] 700160=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 =3D Total bytes free on heap
> [test_print_diagnostics_info][55] 15280=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 =3D Total bytes overhead
> [test_print_diagnostics_info][56] 4213=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D Total bytes wasted
> [test_print_diagnostics_info][57] 454160=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 =3D Largest free block size
>=20
> [test_print_diagnostics_info][60] SUCCESS.
> # /unittest -l / /smcinvoke_skeleton_ta64.mbn 0
> [test_read_file][246] File //smcinvoke_skeleton_ta64.mbn, size: 32856 Bytes.
> [test_load_sample_ta][199] SUCCESS.
>=20
> Thanks,
> Neil

Thanks Neil for the tests.

Regards,
Amir



--===============8895096657879151463==--

