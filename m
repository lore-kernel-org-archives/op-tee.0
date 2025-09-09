Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A0CACA0FED
	for <op-tee@archiver.kernel.org>; Tue,  9 Sep 2025 06:17:17 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1DF1C4FD95
	for <op-tee@archiver.kernel.org>; Tue,  9 Sep 2025 06:17:16 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=DKfEv2Gf;
	dkim-atps=neutral
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 99F4243131
	for <op-tee@lists.trustedfirmware.org>; Tue,  9 Sep 2025 06:17:00 +0000 (UTC)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-746c06937c3so2405382a34.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 08 Sep 2025 23:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757398620; x=1758003420; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yo6ffDWub4okELhRpitpTPAQAp1vCcd2HCwvbQ9oskY=;
        b=DKfEv2GfHUm2QDFjXTMFLJd5k1ZH1i9+CUMqUvScACkEa04gsomVN6+0neCqtF4bWv
         jXjbKkAfFL3QNogK1ryF/2NQmDzPPTWd9XnYv4Adqno59DZVwzc1fbHJ+7kvu4TVE0X9
         HVoOXTQtWYeDBbxAAyCeCQyA6EVQGQFQxVPhdNJTkNN3d6E+AhE5CrJzuvrt7Gz45CA8
         k0OwPSjcwMdronWtln8MIDBdIfgi4QsVE87QEsAAZRabLRzJs78AvL+j9DLwYzy+dUeX
         WrNLfJTwG9Aui0qJ4copf8Le2NAMHyMCQsXrOLri3E74FSUWLRXjEsnxgPAP1I8Z/c0r
         yvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757398620; x=1758003420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yo6ffDWub4okELhRpitpTPAQAp1vCcd2HCwvbQ9oskY=;
        b=Ap8T7xuPdLrLhAMIBA1STjl1Wd5b7Wp8J16/fmxHWP1vwQndveSvprooGoPgO32/x0
         rn9B5VbJ772rwGsbK6h/sKCn0Xy2bctAMHmzy2BnR1k23D42HB5NhHUF09icudkhMIrT
         wf1YBY/x0H0UV/wZZexzUMtZ6m4zWgKGQJ/5Zf4SB9TFaG3W6ZVlpDBeWwe17nGy632Q
         vIFgVGO6U14r5HXhYrtT3p4YfxhvFb2LIxZeBxNu3JVZKyWxvfr1KkIBLFaV+AU2afUO
         bAbXeUI9qiXwMFbNculHbsWgFaMYS/io7YYekiSWTYTnY6rgpW81iomPVxj2fFyaIEdb
         3gOg==
X-Forwarded-Encrypted: i=1; AJvYcCXRUYdQCNzt1tNqiYLyuZNOzgAOwqfIu+bR6aLrpwAa5W7axpZCbwM29ZNmmGaj1xqGs2/6yFs=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yzi4qZEVxjOKdKQDIQMDn5/u9j/bvMMgyb68IjFyMK/BqmlV+E0
	YoiWXNp7bteEfUJyXK77+GCitoJoip+btBdQab/WEcvfXgNywHjEQSPY2AZVoBGkAl3cKH49xOD
	IdHQ4OGs+IT+RSCOPp8q+wE9Yl/EedWFq8L2vKY34F/Xt
X-Gm-Gg: ASbGncuVd1k0KaahJXiH58ByVaVtIkE1OUukXmPDLgDuVD8+Ckpp0SjBmGdwkIMMTMw
	IYVAfrgFPaDqLrztmbdUqkuE3T7oKvgjpMqewhj1HQ/HnwFSaK907SuZyADuVIk9mgMQuOa2AoC
	hlJZ43aa/n1hsVNxmbOMQ6+A9e+m3KmjSl45dvVUmAupsEgs1ZzdIbnwWhn/hBelMpqTrOzWCwv
	POFyA88
X-Google-Smtp-Source: AGHT+IFdWd1+vb/Rl4PyiuASXINuF9rhsbEjXGlN27AUAvNG+S3/oT+E/Sl0ISuJwz6n95Ct9NcfS1g0fMrD6zw15s0=
X-Received: by 2002:a05:6830:26d9:b0:745:5fcc:e70b with SMTP id
 46e09a7af769-746d92f6d9emr5801485a34.14.1757398619808; Mon, 08 Sep 2025
 23:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
 <aL-uOEByKImuvIYF@sumit-X1>
In-Reply-To: <aL-uOEByKImuvIYF@sumit-X1>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Tue, 9 Sep 2025 08:16:48 +0200
X-Gm-Features: Ac12FXy83iDtr2MlreSn2K-a4Ho9ZbQ2XYunPWu-01PDMz9YAYPkq_r6L4oHrE8
Message-ID: <CAHUa44FQVQ1AE3nSjCjcB07XGowYPN6srwG2dknT76qqdtEV+g@mail.gmail.com>
Subject: Re: [PATCH v7 00/11] Trusted Execution Environment (TEE) driver for
 Qualcomm TEE (QTEE)
To: Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 99F4243131
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.210.54:from];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_TWELVE(0.00)[20];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	ARC_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.54:from];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: 5FO6UBCJ756LAPMG64R2BROO7C64YK3R
X-Message-ID-Hash: 5FO6UBCJ756LAPMG64R2BROO7C64YK3R
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Apurupa Pattapu <quic_apurupa@quicinc.com>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/5FO6UBCJ756LAPMG64R2BROO7C64YK3R/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Tue, Sep 9, 2025 at 6:34=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org> w=
rote:
>
> On Tue, Aug 12, 2025 at 05:35:29PM -0700, Amirreza Zarrabi wrote:
> > This patch series introduces a Trusted Execution Environment (TEE)
> > driver for Qualcomm TEE (QTEE). QTEE enables Trusted Applications (TAs)
> > and services to run securely. It uses an object-based interface, where
> > each service is an object with sets of operations. Clients can invoke
> > these operations on objects, which can generate results, including othe=
r
> > objects. For example, an object can load a TA and return another object
> > that represents the loaded TA, allowing access to its services.
> >
> > Kernel and userspace services are also available to QTEE through a
> > similar approach. QTEE makes callback requests that are converted into
> > object invocations. These objects can represent services within the
> > kernel or userspace process.
> >
> > Note: This patch series focuses on QTEE objects and userspace services.
> >
> > Linux already provides a TEE subsystem, which is described in [1]. The
> > tee subsystem provides a generic ioctl interface, TEE_IOC_INVOKE, which
> > can be used by userspace to talk to a TEE backend driver. We extend the
> > Linux TEE subsystem to understand object parameters and an ioctl call s=
o
> > client can invoke objects in QTEE:
> >
> >   - TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_*
> >   - TEE_IOC_OBJECT_INVOKE
> >
> > The existing ioctl calls TEE_IOC_SUPPL_RECV and TEE_IOC_SUPPL_SEND are
> > used for invoking services in the userspace process by QTEE.
> >
> > The TEE backend driver uses the QTEE Transport Message to communicate
> > with QTEE. Interactions through the object INVOKE interface are
> > translated into QTEE messages. Likewise, object invocations from QTEE
> > for userspace objects are converted into SEND/RECV ioctl calls to
> > supplicants.
> >
> > The details of QTEE Transport Message to communicate with QTEE is
> > available in [PATCH 12/12] Documentation: tee: Add Qualcomm TEE driver.
> >
> > You can run basic tests with following steps:
> > git clone https://github.com/quic/quic-teec.git
> > cd quic-teec
> > mkdir build
> > cmake .. -DCMAKE_TOOLCHAIN_FILE=3DCMakeToolchain.txt -DBUILD_UNITTEST=
=3DON
> >
> > https://github.com/quic/quic-teec/blob/main/README.md lists dependencie=
s
> > needed to build the above.
> >
> > More comprehensive tests are availabe at
> > https://github.com/qualcomm/minkipc.
> >
> > root@qcom-armv8a:~# qtee_supplicant &
> > root@qcom-armv8a:~# qtee_supplicant: process entry PPID =3D 378
> > Total listener services to start =3D 4
> > Opening CRequestTABuffer_open
> > Path /data/
> > register_service ::Opening CRegisterTABufCBO_UID
> > Calling TAbufCBO Register
> > QTEE_SUPPLICANT RUNNING
> >
> > root@qcom-armv8a:~# smcinvoke_client -c /data 1
> > Run callback obj test...
> > Load /data/tzecotestapp.mbn, size 52192, buf 0x1e44ba0.
> > System Time: 2024-02-27 17:26:31
> > PASSED - Callback tests with Buffer inputs.
> > PASSED - Callback tests with Remote and Callback object inputs.
> > PASSED - Callback tests with Memory Object inputs.
> > TEST PASSED!
> > root@qcom-armv8a:~#
> > root@qcom-armv8a:~# smcinvoke_client -m /data 1
> > Run memory obj test...
> > Load /data/tzecotestapp.mbn, size 52192, buf 0x26cafba0.
> > System Time: 2024-02-27 17:26:39
> > PASSED - Single Memory Object access Test.
> > PASSED - Two Memory Object access Test.
> > TEST PASSED!
> >
> > This series has been tested for QTEE object invocations, including
> > loading a TA, requesting services from the TA, memory sharing, and
> > handling callback requests to a supplicant.
> >
> > Tested platforms: sm8650-mtp, sm8550-qrd, sm8650-qrd, sm8650-hdk
> >
> > [1] https://www.kernel.org/doc/Documentation/tee.txt
> >
> > Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> >
>
> At this point, I think this series is ready to be applied to linux-next.

There are still some warnings in "[PATCH v9 06/11] firmware: qcom:
scm: add support for object invocation"

/Jens

>
> > Changes in v7:
> > - Updated copyrights.
> > - Updated Acked-by: tags.
> > - Fixed kernel bot errors.
> > - Link to v6:
> >   https://lore.kernel.org/r/20250713-qcom-tee-using-tee-ss-without-mem-=
obj-v6-0-697fb7d41c36@oss.qualcomm.com
> >
> > Changes in v6:
> > - Relocate QTEE version into the driver's main service structure.
> > - Simplfies qcomtee_objref_to_arg() and qcomtee_objref_from_arg().
> > - Enhanced the return logic of qcomtee_object_do_invoke_internal().
> > - Improve comments and remove redundant checks.
> > - Improve helpers in qcomtee_msh.h to use GENMASK() and FIELD_GET().
> > - updated Tested-by:, Acked-by:, and Reviewed-by: tags
> > - Link to v5:
> >   https://lore.kernel.org/r/20250526-qcom-tee-using-tee-ss-without-mem-=
obj-v5-0-024e3221b0b9@oss.qualcomm.com
> >
> > Changes in v5:
> > - Remove references to kernel services and public APIs.
> > - Support auto detection for failing devices (e.g., RB1, RB4).
> > - Add helpers for obtaining client environment and service objects.
> > - Query the QTEE version and print it.
> > - Move remaining static variables, including the object table, to struc=
t
> >   qcomtee.
> > - Update TEE_MAX_ARG_SIZE to 4096.
> > - Add a dependancy to QCOM_TZMEM_MODE_SHMBRIDGE in Kconfig
> > - Reorganize code by removing release.c and qcom_scm.c.
> > - Add more error messages and improve comments.
> > - updated Tested-by:, Acked-by:, and Reviewed-by: tags
> > - Link to v4: https://lore.kernel.org/r/20250428-qcom-tee-using-tee-ss-=
without-mem-obj-v4-0-6a143640a6cb@oss.qualcomm.com
> >
> > Changes in v4:
> > - Move teedev_ctx_get/put and tee_device_get/put to tee_core.h.
> > - Rename object to id in struct tee_ioctl_object_invoke_arg.
> > - Replace spinlock with mutex for qtee_objects_idr.
> > - Move qcomtee_object_get to qcomtee_user/memobj_param_to_object.
> > - More code cleanup following the comments.
> > - Cleanup documentations.
> > - Update MAINTAINERS file.
> > - Link to v3: https://lore.kernel.org/r/20250327-qcom-tee-using-tee-ss-=
without-mem-obj-v3-0-7f457073282d@oss.qualcomm.com
> >
> > Changes in v3:
> > - Export shm_bridge create/delete APIs.
> > - Enable support for QTEE memory objects.
> > - Update the memory management code to use the TEE subsystem for all
> >   allocations using the pool.
> > - Move all driver states into the driver's main service struct.
> > - Add more documentations.
> > - Link to v2: https://lore.kernel.org/r/20250202-qcom-tee-using-tee-ss-=
without-mem-obj-v2-0-297eacd0d34f@quicinc.com
> >
> > Changes in v2:
> > - Clean up commit messages and comments.
> > - Use better names such as ubuf instead of membuf or QCOMTEE prefix
> >   instead of QCOM_TEE, or names that are more consistent with other
> >   TEE-backend drivers such as qcomtee_context_data instead of
> >   qcom_tee_context.
> > - Drop the DTS patch and instantiate the device from the scm driver.
> > - Use a single structure for all driver's internal states.
> > - Drop srcu primitives and use the existing mutex for synchronization
> >   between the supplicant and QTEE.
> > - Directly use tee_context to track the lifetime of qcomtee_context_dat=
a.
> > - Add close_context() to be called when the user closes the tee_context=
.
> > - Link to v1: https://lore.kernel.org/r/20241202-qcom-tee-using-tee-ss-=
without-mem-obj-v1-0-f502ef01e016@quicinc.com
> >
> > Changes in v1:
> > - It is a complete rewrite to utilize the TEE subsystem.
> > - Link to RFC: https://lore.kernel.org/all/20240702-qcom-tee-object-and=
-ioctls-v1-0-633c3ddf57ee@quicinc.com
> >
> > ---
> > Amirreza Zarrabi (11):
> >       tee: allow a driver to allocate a tee_device without a pool
> >       tee: add close_context to TEE driver operation
> >       tee: add TEE_IOCTL_PARAM_ATTR_TYPE_UBUF
> >       tee: add TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF
> >       tee: increase TEE_MAX_ARG_SIZE to 4096
>
> >       firmware: qcom: scm: add support for object invocation
> >       firmware: qcom: tzmem: export shm_bridge create/delete
>
> Bjorn/Konrad,
>
> Since majority of this series belong to TEE subsystem, are you folks
> fine to ack these patches for Jens to pick them up for next?
>
> -Sumit
>
> >       tee: add Qualcomm TEE driver
> >       qcomtee: add primordial object
> >       qcomtee: enable TEE_IOC_SHM_ALLOC ioctl
> >       Documentation: tee: Add Qualcomm TEE driver
>
>
>
> >
> >  Documentation/tee/index.rst              |   1 +
> >  Documentation/tee/qtee.rst               |  96 ++++
> >  MAINTAINERS                              |   7 +
> >  drivers/firmware/qcom/qcom_scm.c         | 128 +++++
> >  drivers/firmware/qcom/qcom_scm.h         |   7 +
> >  drivers/firmware/qcom/qcom_tzmem.c       |  63 ++-
> >  drivers/tee/Kconfig                      |   1 +
> >  drivers/tee/Makefile                     |   1 +
> >  drivers/tee/qcomtee/Kconfig              |  11 +
> >  drivers/tee/qcomtee/Makefile             |   9 +
> >  drivers/tee/qcomtee/async.c              | 183 ++++++
> >  drivers/tee/qcomtee/call.c               | 820 +++++++++++++++++++++++=
++++
> >  drivers/tee/qcomtee/core.c               | 920 +++++++++++++++++++++++=
++++++++
> >  drivers/tee/qcomtee/mem_obj.c            | 169 ++++++
> >  drivers/tee/qcomtee/primordial_obj.c     | 116 ++++
> >  drivers/tee/qcomtee/qcomtee.h            | 185 +++++++
> >  drivers/tee/qcomtee/qcomtee_msg.h        | 300 ++++++++++
> >  drivers/tee/qcomtee/qcomtee_object.h     | 316 +++++++++++
> >  drivers/tee/qcomtee/shm.c                | 150 +++++
> >  drivers/tee/qcomtee/user_obj.c           | 692 +++++++++++++++++++++++
> >  drivers/tee/tee_core.c                   | 127 ++++-
> >  drivers/tee/tee_private.h                |   6 -
> >  include/linux/firmware/qcom/qcom_scm.h   |   6 +
> >  include/linux/firmware/qcom/qcom_tzmem.h |  15 +
> >  include/linux/tee_core.h                 |  54 +-
> >  include/linux/tee_drv.h                  |  12 +
> >  include/uapi/linux/tee.h                 |  56 +-
> >  27 files changed, 4423 insertions(+), 28 deletions(-)
> > ---
> > base-commit: 2674d1eadaa2fd3a918dfcdb6d0bb49efe8a8bb9
> > change-id: 20241202-qcom-tee-using-tee-ss-without-mem-obj-362c66340527
> >
> > Best regards,
> > --
> > Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> >
> >
