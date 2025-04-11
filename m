From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v3 00/11] Trusted Execution Environment (TEE) driver for
 Qualcomm TEE (QTEE)
Date: Fri, 11 Apr 2025 15:55:57 +1000
Message-ID: <0af0f9c3-7b6e-4ef7-a637-3e8490e5d46e@oss.qualcomm.com>
In-Reply-To: <fd9ac8f1-94ad-460f-8ca7-e56724416fcf@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8168569395021538624=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8168569395021538624==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 4/9/2025 6:30 PM, neil.armstrong(a)linaro.org wrote:
> On 28/03/2025 03:47, Amirreza Zarrabi wrote:
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
>> available in [PATCH 10/10] Documentation: tee: Add Qualcomm TEE driver.
>>
>> You can run basic tests with following steps:
>> git clone https://github.com/quic/quic-teec.git
>> cd quic-teec
>> mkdir build
>> cmake .. -DCMAKE_TOOLCHAIN_FILE=3DCMakeToolchain.txt -DBUILD_UNITTEST=3DON
>>
>> https://github.com/quic/quic-teec/blob/main/README.md lists dependancies
>> needed to build the above.
>>
>> This series has been tested for basic QTEE object invocations and
>> callback requests, including loading a TA and requesting services form
>> the TA.
>>
>> Tested platforms: sm8650-mtp
>=20
> Does it requires any DT changes to be tested on other SM8650 devices ?
>=20
> Thanks,
> Neil

Hi Neil,

No, it does not require any DT changes.

Regards,
Amir

>=20
>>
>> [1] https://www.kernel.org/doc/Documentation/tee.txt
>>
>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
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
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 759 +++++++++++++++++++++++++=
++++
>> =C2=A0 drivers/tee/qcomtee/core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 810 +++++++++++++++++++++++++=
++++++
>> =C2=A0 drivers/tee/qcomtee/mem_obj.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 172 +++++++
>> =C2=A0 drivers/tee/qcomtee/primordial_obj.c=C2=A0=C2=A0=C2=A0=C2=A0 | 116 =
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
=C2=A0=C2=A0=C2=A0=C2=A0 | 710 +++++++++++++++++++++++++++
>> =C2=A0 drivers/tee/tee_core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 159 +++++-
>> =C2=A0 drivers/tee/tee_private.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 -
>> =C2=A0 include/linux/firmware/qcom/qcom_scm.h=C2=A0=C2=A0 |=C2=A0 31 +-
>> =C2=A0 include/linux/firmware/qcom/qcom_tee.h=C2=A0=C2=A0 | 302 ++++++++++=
++
>> =C2=A0 include/linux/firmware/qcom/qcom_tzmem.h |=C2=A0 15 +
>> =C2=A0 include/linux/tee_core.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 15 +-
>> =C2=A0 include/linux/tee_drv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 52 ++
>> =C2=A0 include/uapi/linux/tee.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 54 ++-
>> =C2=A0 28 files changed, 4434 insertions(+), 32 deletions(-)
>> ---
>> base-commit: db8da9da41bced445077925f8a886c776a47440c
>> change-id: 20241202-qcom-tee-using-tee-ss-without-mem-obj-362c66340527
>>
>> Best regards,
>=20


--===============8168569395021538624==--

