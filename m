Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E1A2CA101F
	for <op-tee@archiver.kernel.org>; Wed, 10 Sep 2025 05:10:53 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 78CEA4FD6B
	for <op-tee@archiver.kernel.org>; Wed, 10 Sep 2025 05:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1757481052;
	bh=ulCUV9C314YyKs41QAMn/UMnFxanovaasff/UpI/TOQ=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=y/ABw/IdrY5wgf+OOwov1n9OfUUpA64uLXJmAbIfT67yogWArFViXuoSW8GehxjFe
	 saQhdMMxR6IiYClFZECVMgLtgruFAfika6gL24CoVlFMUyLH3te1lXqjSHKhHlbKaM
	 1gMeZzeTl2ivpoh8zBq31WdBQ/nuijSGciDYx5DzwC9GYgp3cG672dlxv5pJC4txZ+
	 5ogUicLmJI4xIEnOu/ckBfV3px2J4PunCvYgb8D2u7D1fC9gC6dLmc2HZ5AR74h5Wu
	 2+v7hKD1u4gkO/jqbXFU3vk841jRKuDAQJHT+EMfFuMDM/hOTEQaLaWFaQ270DTsqx
	 sYMn5CjkMai6w==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 46C7343004
	for <op-tee@lists.trustedfirmware.org>; Wed, 10 Sep 2025 05:10:37 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=k0VRfI/e;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 865C9449BA;
	Wed, 10 Sep 2025 05:10:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F09CC4CEF0;
	Wed, 10 Sep 2025 05:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757481036;
	bh=ulCUV9C314YyKs41QAMn/UMnFxanovaasff/UpI/TOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k0VRfI/eBLgnnLJDoUyKp7UdMKK4uCmQn3bNaxcBp3XozJTav9RY4MqaOhgcANnB4
	 MKzVhwgelj9u7aClS2zuvQKMQpyI6YcGctQ6L2SKdPjhyHBuoiuVXPs+KR2GDyyiw7
	 fpRXtj38s9AWaTZg4RZ4ylryPFcJYp/+YehVTE8ST8WwHYDfpvaMvwX4KhQOl7/eUK
	 EMTAPQVRQ1RhmYRrBkDtsI1IaLt9pA+UXgIhecqYW2IglKPtkWbHYlVBMzQwEiQGzQ
	 ZVEceLcbGP6qm/sMLk1yofNTyAT9BEiSpA1ZK+jGkBH+CLqzI4NBvSiWTyCKCVcSQx
	 urs8rtkyIJiHA==
Date: Wed, 10 Sep 2025 10:40:15 +0530
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Subject: Re: [PATCH v10 00/11] Trusted Execution Environment (TEE) driver for
 Qualcomm TEE (QTEE)
Message-ID: <aMEINycp24DG6KXO@sumit-X1>
References: <20250909-qcom-tee-using-tee-ss-without-mem-obj-v10-0-20b17855ef31@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909-qcom-tee-using-tee-ss-without-mem-obj-v10-0-20b17855ef31@oss.qualcomm.com>
X-Rspamd-Queue-Id: 46C7343004
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-5.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: ZRUXSK7K3Y7TK2FVYTXIL7FKRTBH44GG
X-Message-ID-Hash: ZRUXSK7K3Y7TK2FVYTXIL7FKRTBH44GG
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Apurupa Pattapu <quic_apurupa@quicinc.com>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, Kuldeep Singh <quic_kuldsing@quicinc.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ZRUXSK7K3Y7TK2FVYTXIL7FKRTBH44GG/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

Hi Amir,

On Tue, Sep 09, 2025 at 05:11:02PM -0700, Amirreza Zarrabi wrote:
> This patch series introduces a Trusted Execution Environment (TEE)
> driver for Qualcomm TEE (QTEE). QTEE enables Trusted Applications (TAs)
> and services to run securely. It uses an object-based interface, where
> each service is an object with sets of operations. Clients can invoke
> these operations on objects, which can generate results, including other
> objects. For example, an object can load a TA and return another object
> that represents the loaded TA, allowing access to its services.
> 
> Kernel and userspace services are also available to QTEE through a
> similar approach. QTEE makes callback requests that are converted into
> object invocations. These objects can represent services within the
> kernel or userspace process.
> 
> Note: This patch series focuses on QTEE objects and userspace services.
> 
> Linux already provides a TEE subsystem, which is described in [1]. The
> tee subsystem provides a generic ioctl interface, TEE_IOC_INVOKE, which
> can be used by userspace to talk to a TEE backend driver. We extend the
> Linux TEE subsystem to understand object parameters and an ioctl call so
> client can invoke objects in QTEE:
> 
>   - TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_*
>   - TEE_IOC_OBJECT_INVOKE
> 
> The existing ioctl calls TEE_IOC_SUPPL_RECV and TEE_IOC_SUPPL_SEND are
> used for invoking services in the userspace process by QTEE.
> 
> The TEE backend driver uses the QTEE Transport Message to communicate
> with QTEE. Interactions through the object INVOKE interface are
> translated into QTEE messages. Likewise, object invocations from QTEE
> for userspace objects are converted into SEND/RECV ioctl calls to
> supplicants.
> 
> The details of QTEE Transport Message to communicate with QTEE is
> available in [PATCH 12/12] Documentation: tee: Add Qualcomm TEE driver.
> 
> You can run basic tests with following steps:
> git clone https://github.com/quic/quic-teec.git
> cd quic-teec
> mkdir build
> cmake .. -DCMAKE_TOOLCHAIN_FILE=CMakeToolchain.txt -DBUILD_UNITTEST=ON
> 
> https://github.com/quic/quic-teec/blob/main/README.md lists dependencies
> needed to build the above.
> 
> More comprehensive tests are availabe at
> https://github.com/qualcomm/minkipc.
> 
> root@qcom-armv8a:~# qtee_supplicant &
> root@qcom-armv8a:~# qtee_supplicant: process entry PPID = 378
> Total listener services to start = 4
> Opening CRequestTABuffer_open
> Path /data/
> register_service ::Opening CRegisterTABufCBO_UID
> Calling TAbufCBO Register
> QTEE_SUPPLICANT RUNNING
>  
> root@qcom-armv8a:~# smcinvoke_client -c /data 1
> Run callback obj test...
> Load /data/tzecotestapp.mbn, size 52192, buf 0x1e44ba0.
> System Time: 2024-02-27 17:26:31
> PASSED - Callback tests with Buffer inputs.
> PASSED - Callback tests with Remote and Callback object inputs.
> PASSED - Callback tests with Memory Object inputs.
> TEST PASSED!
> root@qcom-armv8a:~#
> root@qcom-armv8a:~# smcinvoke_client -m /data 1
> Run memory obj test...
> Load /data/tzecotestapp.mbn, size 52192, buf 0x26cafba0.
> System Time: 2024-02-27 17:26:39
> PASSED - Single Memory Object access Test.
> PASSED - Two Memory Object access Test.
> TEST PASSED!
> 
> This series has been tested for QTEE object invocations, including
> loading a TA, requesting services from the TA, memory sharing, and
> handling callback requests to a supplicant.
> 
> Tested platforms: sm8650-mtp, sm8550-qrd, sm8650-qrd, sm8650-hdk
> 
> [1] https://www.kernel.org/doc/Documentation/tee.txt
> 
> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> 
> Changes in v10:
> - Remove all loggings in qcom_scm_qtee_init().
> - Reorder patches.
> - Link to v9:
>   https://lore.kernel.org/r/20250901-qcom-tee-using-tee-ss-without-mem-obj-v9-0-a2af23f132d5@oss.qualcomm.com

It's still not rebased on top of linux-next and have merge conflicts,
see my comments here [1].

[1] https://lore.kernel.org/all/aL_MCagNVIDXW0wp@sumit-X1/

-Sumit

> 
> Changes in v9:
> - Remove unnecessary logging in qcom_scm_probe().
> - Replace the platform_device_alloc()/add() sequence with
>   platform_device_register_data().
> - Fixed sparse warning.
> - Fixed documentation typo.
> - Link to v8:
>   https://lore.kernel.org/r/20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-0-7066680f138a@oss.qualcomm.com
> 
> Changes in v8:
> - Check if arguments to qcom_scm_qtee_invoke_smc() and
>   qcom_scm_qtee_callback_response() are NULL.
> - Add CPU_BIG_ENDIAN as a dependency to Kconfig.
> - Fixed kernel bot errors.
> - Link to v7:
>   https://lore.kernel.org/r/20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com
> 
> Changes in v7:
> - Updated copyrights.
> - Updated Acked-by: tags.
> - Fixed kernel bot errors.
> - Link to v6:
>   https://lore.kernel.org/r/20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-0-697fb7d41c36@oss.qualcomm.com
> 
> Changes in v6:
> - Relocate QTEE version into the driver's main service structure.
> - Simplfies qcomtee_objref_to_arg() and qcomtee_objref_from_arg().
> - Enhanced the return logic of qcomtee_object_do_invoke_internal().
> - Improve comments and remove redundant checks.
> - Improve helpers in qcomtee_msh.h to use GENMASK() and FIELD_GET().
> - updated Tested-by:, Acked-by:, and Reviewed-by: tags
> - Link to v5:
>   https://lore.kernel.org/r/20250526-qcom-tee-using-tee-ss-without-mem-obj-v5-0-024e3221b0b9@oss.qualcomm.com
> 
> Changes in v5:
> - Remove references to kernel services and public APIs.
> - Support auto detection for failing devices (e.g., RB1, RB4).
> - Add helpers for obtaining client environment and service objects.
> - Query the QTEE version and print it.
> - Move remaining static variables, including the object table, to struct
>   qcomtee.
> - Update TEE_MAX_ARG_SIZE to 4096.
> - Add a dependancy to QCOM_TZMEM_MODE_SHMBRIDGE in Kconfig
> - Reorganize code by removing release.c and qcom_scm.c.
> - Add more error messages and improve comments.
> - updated Tested-by:, Acked-by:, and Reviewed-by: tags
> - Link to v4: https://lore.kernel.org/r/20250428-qcom-tee-using-tee-ss-without-mem-obj-v4-0-6a143640a6cb@oss.qualcomm.com
> 
> Changes in v4:
> - Move teedev_ctx_get/put and tee_device_get/put to tee_core.h.
> - Rename object to id in struct tee_ioctl_object_invoke_arg.
> - Replace spinlock with mutex for qtee_objects_idr.
> - Move qcomtee_object_get to qcomtee_user/memobj_param_to_object.
> - More code cleanup following the comments.
> - Cleanup documentations.
> - Update MAINTAINERS file.
> - Link to v3: https://lore.kernel.org/r/20250327-qcom-tee-using-tee-ss-without-mem-obj-v3-0-7f457073282d@oss.qualcomm.com
> 
> Changes in v3:
> - Export shm_bridge create/delete APIs.
> - Enable support for QTEE memory objects.
> - Update the memory management code to use the TEE subsystem for all
>   allocations using the pool.
> - Move all driver states into the driver's main service struct.
> - Add more documentations.
> - Link to v2: https://lore.kernel.org/r/20250202-qcom-tee-using-tee-ss-without-mem-obj-v2-0-297eacd0d34f@quicinc.com
> 
> Changes in v2:
> - Clean up commit messages and comments.
> - Use better names such as ubuf instead of membuf or QCOMTEE prefix
>   instead of QCOM_TEE, or names that are more consistent with other
>   TEE-backend drivers such as qcomtee_context_data instead of
>   qcom_tee_context.
> - Drop the DTS patch and instantiate the device from the scm driver.
> - Use a single structure for all driver's internal states.
> - Drop srcu primitives and use the existing mutex for synchronization
>   between the supplicant and QTEE.
> - Directly use tee_context to track the lifetime of qcomtee_context_data.
> - Add close_context() to be called when the user closes the tee_context.
> - Link to v1: https://lore.kernel.org/r/20241202-qcom-tee-using-tee-ss-without-mem-obj-v1-0-f502ef01e016@quicinc.com
> 
> Changes in v1:
> - It is a complete rewrite to utilize the TEE subsystem.
> - Link to RFC: https://lore.kernel.org/all/20240702-qcom-tee-object-and-ioctls-v1-0-633c3ddf57ee@quicinc.com
> 
> ---
> Amirreza Zarrabi (11):
>       firmware: qcom: tzmem: export shm_bridge create/delete
>       firmware: qcom: scm: add support for object invocation
>       tee: allow a driver to allocate a tee_device without a pool
>       tee: add close_context to TEE driver operation
>       tee: add TEE_IOCTL_PARAM_ATTR_TYPE_UBUF
>       tee: add TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF
>       tee: increase TEE_MAX_ARG_SIZE to 4096
>       tee: add Qualcomm TEE driver
>       tee: qcom: add primordial object
>       tee: qcom: enable TEE_IOC_SHM_ALLOC ioctl
>       Documentation: tee: Add Qualcomm TEE driver
> 
>  Documentation/tee/index.rst              |   1 +
>  Documentation/tee/qtee.rst               |  96 ++++
>  MAINTAINERS                              |   7 +
>  drivers/firmware/qcom/qcom_scm.c         | 119 ++++
>  drivers/firmware/qcom/qcom_scm.h         |   7 +
>  drivers/firmware/qcom/qcom_tzmem.c       |  63 ++-
>  drivers/tee/Kconfig                      |   1 +
>  drivers/tee/Makefile                     |   1 +
>  drivers/tee/qcomtee/Kconfig              |  12 +
>  drivers/tee/qcomtee/Makefile             |   9 +
>  drivers/tee/qcomtee/async.c              | 182 ++++++
>  drivers/tee/qcomtee/call.c               | 820 +++++++++++++++++++++++++++
>  drivers/tee/qcomtee/core.c               | 915 +++++++++++++++++++++++++++++++
>  drivers/tee/qcomtee/mem_obj.c            | 169 ++++++
>  drivers/tee/qcomtee/primordial_obj.c     | 113 ++++
>  drivers/tee/qcomtee/qcomtee.h            | 185 +++++++
>  drivers/tee/qcomtee/qcomtee_msg.h        | 304 ++++++++++
>  drivers/tee/qcomtee/qcomtee_object.h     | 316 +++++++++++
>  drivers/tee/qcomtee/shm.c                | 150 +++++
>  drivers/tee/qcomtee/user_obj.c           | 692 +++++++++++++++++++++++
>  drivers/tee/tee_core.c                   | 127 ++++-
>  drivers/tee/tee_private.h                |   6 -
>  include/linux/firmware/qcom/qcom_scm.h   |   6 +
>  include/linux/firmware/qcom/qcom_tzmem.h |  15 +
>  include/linux/tee_core.h                 |  54 +-
>  include/linux/tee_drv.h                  |  12 +
>  include/uapi/linux/tee.h                 |  56 +-
>  27 files changed, 4410 insertions(+), 28 deletions(-)
> ---
> base-commit: 33bcf93b9a6b028758105680f8b538a31bc563cf
> change-id: 20241202-qcom-tee-using-tee-ss-without-mem-obj-362c66340527
> 
> Best regards,
> -- 
> Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> 
