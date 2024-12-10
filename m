From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 05/10] qcomtee: implement object invoke support
Date: Tue, 10 Dec 2024 11:24:27 +0100
Message-ID: 
 <CAHUa44FhZc1ZVgJQrqbDdY1kegNgHrC4VTs66-5CDfY04D6MMw@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3C20241202-qcom-tee-using-tee-ss-without-mem-obj-v1-?=
 =?utf-8?q?5-f502ef01e016=40quicinc=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2699216398238094342=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2699216398238094342==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 5:20=E2=80=AFAM Amirreza Zarrabi
<quic_azarrabi@quicinc.com> wrote:
>
> Introduce qcom_tee_object, which represents an object in both QTEE and
> the kernel. QTEE clients can invoke an instance of qcom_tee_object to
> access QTEE services. If this invocation produces a new object in QTEE,
> an instance of qcom_tee_object will be returned.
>
> Similarly, QTEE can request services from the kernel by issuing a callback
> request, which invokes an instance of qcom_tee_object in the kernel.
> Any subsystem that exposes a service to QTEE should allocate and initialize
> an instance of qcom_tee_object with a dispatcher callback that is called
> when the object is invoked.
>
> Signed-off-by: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
> ---
>  drivers/tee/Kconfig                    |   1 +
>  drivers/tee/Makefile                   |   1 +
>  drivers/tee/qcomtee/Kconfig            |  10 +
>  drivers/tee/qcomtee/Makefile           |   6 +
>  drivers/tee/qcomtee/async.c            | 153 ++++++
>  drivers/tee/qcomtee/core.c             | 928 +++++++++++++++++++++++++++++=
++++
>  drivers/tee/qcomtee/qcom_scm.c         |  36 ++
>  drivers/tee/qcomtee/qcomtee_msg.h      | 217 ++++++++
>  drivers/tee/qcomtee/qcomtee_private.h  |  47 ++
>  drivers/tee/qcomtee/release.c          |  66 +++
>  include/linux/firmware/qcom/qcom_tee.h | 284 ++++++++++
>  11 files changed, 1749 insertions(+)
>
[snip]

> +/**
> + * DOC: Overview
> + *
> + * qcom_tee_object provides object ref-counting, id allocation for objects=
 hosted in
> + * REE, and necessary message marshaling for Qualcomm TEE (QTEE).
> + *
> + * To invoke an object in QTEE, user calls qcom_tee_object_do_invoke() whi=
le passing
> + * an instance of &struct qcom_tee_object and the requested operation + ar=
guments.
> + *
> + * After the boot, QTEE provides a static object %ROOT_QCOM_TEE_OBJECT (ty=
pe of
> + * %QCOM_TEE_OBJECT_TYPE_ROOT). The root object is invoked to pass user's =
credentials and
> + * obtain other instances of &struct qcom_tee_object (type of %QCOM_TEE_OB=
JECT_TYPE_TEE)
> + * that represents services and TAs in QTEE, see &enum qcom_tee_object_typ=
e.
> + *
> + * The object received from QTEE are refcounted. So the owner of these obj=
ects can
> + * issue qcom_tee_object_get(), to increase the refcount, and pass objects=
 to other
> + * clients, or issue qcom_tee_object_put() to decrease the refcount, and r=
eleasing
> + * the resources in QTEE.
> + *
> + * REE can host services accessible to QTEE. A driver should embed an inst=
ance of
> + * &struct qcom_tee_object in the struct it wants to export to QTEE (it is=
 called
> + * callback object). It issues qcom_tee_object_user_init() to set the disp=
atch()
> + * operation for the callback object and set its type to %QCOM_TEE_OBJECT_=
TYPE_CB_OBJECT.
> + *
> + * core.c holds an object table for callback objects. An object id is assi=
gned
> + * to each callback object which is an index to the object table. QTEE use=
s these ids
> + * to reference or invoke callback objects.
> + *
> + * If QTEE invoke a callback object in REE, the dispatch() operation is ca=
lled in the
> + * context of thread that called qcom_tee_object_do_invoke(), originally.
> + */
> +
> +/**
> + * enum qcom_tee_object_typ - Object types.
> + * @QCOM_TEE_OBJECT_TYPE_TEE: object hosted on QTEE.
> + * @QCOM_TEE_OBJECT_TYPE_CB_OBJECT: object hosted on REE.
> + * @QCOM_TEE_OBJECT_TYPE_ROOT: 'primordial' object.
> + * @QCOM_TEE_OBJECT_TYPE_NULL: NULL object.
> + *
> + * Primordial object is used for bootstrapping the IPC connection between =
a REE
> + * and QTEE. It is invoked by REE when it wants to get a 'client env'.
> + */
> +enum qcom_tee_object_type {
> +       QCOM_TEE_OBJECT_TYPE_TEE,
> +       QCOM_TEE_OBJECT_TYPE_CB_OBJECT,

The second OBJECT seems redundant. How about QCOM_TEE_OBJECT_TYPE_CB
or QCOM_TEE_OBJECT_TYPE_CALLBACK instead?

> +       QCOM_TEE_OBJECT_TYPE_ROOT,
> +       QCOM_TEE_OBJECT_TYPE_NULL,
> +};
[snip]

Cheers,
Jens

--===============2699216398238094342==--

