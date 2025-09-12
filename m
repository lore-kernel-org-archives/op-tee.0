Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950AACAC582
	for <op-tee@archiver.kernel.org>; Fri, 12 Sep 2025 08:22:24 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B5C594FD8E
	for <op-tee@archiver.kernel.org>; Fri, 12 Sep 2025 08:22:23 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=BtBZSEEn;
	dkim-atps=neutral
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id DB61C42D0E
	for <op-tee@lists.trustedfirmware.org>; Fri, 12 Sep 2025 08:22:07 +0000 (UTC)
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7459de59821so1508797a34.1
        for <op-tee@lists.trustedfirmware.org>; Fri, 12 Sep 2025 01:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757665327; x=1758270127; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqmWGb+bqV5HnkceUK4yMUe3ao70v2Hu/Bx0pkeeRhg=;
        b=BtBZSEEn0oFA2e8ojLiTIHrN68Tv5R3lVRXssUpKjPCI4xbksjYTy4DcdVfclBXAma
         I7XPuG1m43NI4UJ+qTGqqhsflJV9oYGXwnQHQjhc5NK39MTyHVeWQih+iLp7fZbq+t9j
         4rwVfgog7mcHTzsJmF+LOtcWv9D9bSs9DMYmR5AgNsgqjN18QuPtIvO96wyCYTBDZzA/
         /RrQaI5rKDkw2v6XlTqyMMb3cFiCYFYpyiCuLNQQoX/jHHPWZeaqhIa0EqrIePfCirwd
         gIjDpGkeW3Bw+b9pqA+rtstoTz+dHUmTOrLj0HiMmWo9hbL17hPsfew7DVy6TZ4Ue4cg
         7q0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757665327; x=1758270127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FqmWGb+bqV5HnkceUK4yMUe3ao70v2Hu/Bx0pkeeRhg=;
        b=o1OvWjndsY2+xSAMWnpQLR2K1Lbc7+QZlNJwdiLKzXN63AT2Ng6LC0x6GkUxWJmsn6
         NMFZrr6N6ij0Sp7NDKsim+6N9vBiUv+91oN1s4LCm+QEC5AGtS+S2xACqzYQOSBOAZG/
         /I/3rjst/Ji0fIG2KwOkxhkbnGOXLXaGirFiZbgOR1x8qUYlfKquYF4PMAALuuHZvbXL
         TMBZoFd/zwV2rs3fVGeJMBvZH2a7DTZ5n8EHO4eUstsdO9at4DmW1Qcxgvhx7UvYcV9P
         U9Ho++1SknPIlT+cJlHaCtsOTuRe9td33B/DCsiaUvdtcllbKIyQCZmbYFHIeaEaNlCa
         bnJw==
X-Forwarded-Encrypted: i=1; AJvYcCW2vZLaglFaMpkW3YTADWIjJU5VJSXJ6Qjf2KrlFv+EdwytxlpNd6HIJ+oWMKEBGzoRl5nEPqE=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yxf8eOYzKlrAfbyXSdJt/uwjffTalLrjx13nlWYzwHJuINgIpC4
	b+XtXr+eRk+1XPZpRBVU6iXZMQVxLlBeIGie1vpuCzByrL5E1hPOm9t5V3qxOXKiJ0FCEaubqWA
	8iCia9seXmgODCzZkezF/ey9wtQzXsR+A1XjC+54cNBTK
X-Gm-Gg: ASbGncs/HXYpF31F3Oi5Yy4oZV9/D9O28cyT49cljhOnTdZnB0ZWftKd+UdjleXtkf4
	ExlEx8vv70bhnQbjZa4YQntyk72uwXdjlv/2HtPR5maa0Afx4clpONCG+3uGBvvKShrtGKYA6Ss
	0N60LRjLEBSaz59ueqA7R+Z8Bb7KimI9iBdIn3jVCkWAl9NY4QbilGRj+6fGNKOrE3wv0p56ER4
	9+FcXY3
X-Google-Smtp-Source: AGHT+IF6KSmtzV3lD8Ye2Smqf1AHbbHzZL7yhMscYVEGZKEmeFM9f9fBRAk0lKMT9A8gz3y+3CIy3hDQkioIiFSlJ2M=
X-Received: by 2002:a05:6830:6a94:b0:745:9d11:cc87 with SMTP id
 46e09a7af769-75355ac462dmr1395964a34.35.1757665327140; Fri, 12 Sep 2025
 01:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-0-17f07a942b8d@oss.qualcomm.com>
In-Reply-To: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-0-17f07a942b8d@oss.qualcomm.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Fri, 12 Sep 2025 10:21:55 +0200
X-Gm-Features: Ac12FXxUkHtHNTLgZu3XBq2-UbPsnB-71u1NgRvPtOLVCD8F1behB1r-vwEiHeY
Message-ID: <CAHUa44Fow6BhkdTki=rt2psOC=dq99cRgwXsVagmQU7fttXyCw@mail.gmail.com>
Subject: Re: [PATCH v12 00/11] Trusted Execution Environment (TEE) driver for
 Qualcomm TEE (QTEE)
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: DB61C42D0E
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.210.44:from];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_TWELVE(0.00)[21];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	ARC_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.44:from];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: R3IS4CIZTMPPNEWXVMA2CPPEAQCWMLCV
X-Message-ID-Hash: R3IS4CIZTMPPNEWXVMA2CPPEAQCWMLCV
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Apurupa Pattapu <quic_apurupa@quicinc.com>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, Kuldeep Singh <quic_kuldsing@quicinc.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/R3IS4CIZTMPPNEWXVMA2CPPEAQCWMLCV/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

On Fri, Sep 12, 2025 at 6:07=E2=80=AFAM Amirreza Zarrabi
<amirreza.zarrabi@oss.qualcomm.com> wrote:
>
> This patch series introduces a Trusted Execution Environment (TEE)
> driver for Qualcomm TEE (QTEE). QTEE enables Trusted Applications (TAs)
> and services to run securely. It uses an object-based interface, where
> each service is an object with sets of operations. Clients can invoke
> these operations on objects, which can generate results, including other
> objects. For example, an object can load a TA and return another object
> that represents the loaded TA, allowing access to its services.
>
[snip]

I'm OK with the TEE patches, Sumit and I have reviewed them.

There were some minor conflicts with other patches I have in the pipe
for this merge window, so this patchset is on top of what I have to
avoid merge conflicts.

However, the firmware patches are for code maintained by Bj=C3=B6rn.
Bj=C3=B6rn, how would you like to do this? Can I take them via my tree, or
what do you suggest?

It's urgent to get this patchset into linux-next if it's to make it
for the coming merge window. Ideally, I'd like to send my pull request
to arm-soc during this week.

Cheers,
Jens

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
>  drivers/tee/qcomtee/call.c               | 820 +++++++++++++++++++++++++=
++
>  drivers/tee/qcomtee/core.c               | 915 +++++++++++++++++++++++++=
++++++
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
> base-commit: 8b8aefa5a5c7d4a65883e5653cf12f94c0b68dbf
> change-id: 20241202-qcom-tee-using-tee-ss-without-mem-obj-362c66340527
>
> Best regards,
> --
> Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>
