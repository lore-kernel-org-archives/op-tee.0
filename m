Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59AC2C43458
	for <op-tee@archiver.kernel.org>; Thu,  2 Jul 2026 19:14:24 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 891C144F4F
	for <op-tee@archiver.kernel.org>; Thu,  2 Jul 2026 19:14:23 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Ps04Mciw;
	dkim-atps=neutral
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 950A3438C6
	for <op-tee@lists.trustedfirmware.org>; Thu,  2 Jul 2026 19:14:16 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-698a9f11776so2139791a12.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 02 Jul 2026 12:14:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783019655; cv=none;
        d=google.com; s=arc-20260327;
        b=du6ddq0r9LvhNmUqaSZR4xdk3kk+aB25SnRPcLD/nweOdzBE1ai2vepIKSg37d0/zo
         bP4zHsuUgSPmT6j2XE24q7to86ujqqftQaX3cvveRVmIaeRIQ9bHuRZqt95lQS9cMY6u
         gSg1vucqAsoyJFOOZZlQgWCM25bnJVjipPtmHH5GCNChzKcMpFE3srxysBNlVXQst0++
         BvZSuYdUV3sqlRaaly35yWzYGNf2pjuoo781U63OdwYH1nWEofCfrxity8dV06vJFcuN
         GUEiarqZoGfLNuL9pHFFAxlWEgU84ovv3FlcOd5RGPkBIDh0THBEwirxg8dsTLRWTAXF
         WYhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dfas/91RHw7TRgs4MMexcFlE2KWowDBMjBihd9aSOjU=;
        fh=WZ+ZaV751VobGBXQkC7V+4vVljBq8tjlfqbSW2iLQ+o=;
        b=mFJLVjSql49etmbK2ES/U7LksQGE9tUCrh5xHNXb1NX0jPFFTss1YN310inl3oT07T
         8FyZ3FlV0lKm7RgBkiW1dghK+ApVtJY9ToE2Oythd/dgHWR8Gvb1LK5Uz+lDqDSdFPMy
         mEjC7DykclP2FyB1jTBcDSqsfcWmK5fvpTfUVAxo71lZNDOsBwN833sxptrJwHiLOo+k
         lM/1CKEn2TUJBh0Tv73cF2EGE6oMFSzrcspLL/NzDW1I8yWgmQ4JtShCSVHJuhV4ojoG
         jTDmg0WzvxPmhwuIB+SKrzCiZ1n3qY1tiw/hZwuj4c0xwkDeUgiHUnnLUogI2UHjG5M+
         7nEw==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783019655; x=1783624455; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dfas/91RHw7TRgs4MMexcFlE2KWowDBMjBihd9aSOjU=;
        b=Ps04Mciw+sXBfzCkmKcLBor/WJ6JPxOZTXEGQqzthozDHq269zH2Aa9DIkofR5Eg/z
         uYPEhBcTQ6ZMO7bP31snRMcj94RrBQp2wpXTHXKAKv1ymTFJqtEFTZLEbwbyVYJhGDQy
         IZABVxffVVRsJG+SITColLA5bBJ0R7WIAbLIurf9bsoZJS/zRGF+N1orciT11y/pRU+D
         KJG5j1bovqwrqbS+lA+ijUqQSyPdKa4+ijbTSKos7lOnbgndZothWPWXf0M6QF/kLo76
         SIyaN4PzuAL34LKjZr+S5v70lg4103zpbMoDaevc4eLKic2f+lpyMlkJebVEk/lHh+KZ
         hXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783019655; x=1783624455;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dfas/91RHw7TRgs4MMexcFlE2KWowDBMjBihd9aSOjU=;
        b=IsGfQbOhuiKhHCyMrlCVIYeG0hVTY68GEopT3OGjz9KVfuUBS0fZ2yDh4RkE114CR8
         sJ0i1c+glIDK1HBPIN2SlmqBpZufVV9qj1kthLpjwf0CIElgneU9DJX+dwYQ1sqOZWSk
         xdmFKOR4hb1oblNT8rUwR0PEYqaryv+ZlBRFq2TyS7K7kYLwU9wqg9HNJ8dWHtHxKUbm
         dcAUdQOJ8nQMvRNGV+/h+EK1fHuFapTrOFHTl+VjD/mopKzP9+dAEpeVxhkA+pJ3AIdp
         3AggcD3nS/xHsSc2l7eQd7JAxP83/D3iJLv7f5ELWLE4SOH+OMU8JvglKzDJ5vm7JpID
         x26g==
X-Forwarded-Encrypted: i=1; AHgh+RqYAoNbsfbcRqycuVYyootH661480/ch5tS9koqrZQ930HQXnt1qEcbIaUwYFqdLeiB6mYG05Q=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YziqjygraRwul7Wyl/omD7jJ+gXnFabUkZGslLLCIqpadbf/EZj
	IL7gZuP+wP1zrRC8iWNiwEhHsS9pQ4/5GKDyYiybN1UhQVF7mPmTDKrqbgtDqmYS95gxWaA9Tn7
	d7nHJiy+LQJDgy57ExcYUb+HS4c2+p2CCpvj84N0D58uV
X-Gm-Gg: AfdE7cmrY0LXOMR+s0Swbm7qLf9dlDsAGI7NskQmz0sgE2amOlitR5f8OzsB/ekDmQa
	dl/Khrsi8w3m1WGZXJB7KFGU7Naz/Q4SeMVyTZdgFFiaS/JNXtoViadSCsj2DE9bgumcqyWm1Tk
	Jra/xysWSiOMg1FUoOglHUwXwfGGHlKEGqL6ypttn7CvkoXgM7zT7BQYf58ZyGDa5FJBhZU64hE
	22CC/KXsc0bMdeIwp19kRJ8wP/1OnMkeLpWZwpJlTtkos+IeTU6usi0lYUxLRwqwWOM4ga2JsC9
	kX2LNEKXT+DkGasDaFFeCxdke9dM3SI=
X-Received: by 2002:a05:6402:42c6:b0:695:f580:a66f with SMTP id
 4fb4d7f45d1cf-698a2cda40dmr3064278a12.21.1783019655273; Thu, 02 Jul 2026
 12:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260702115835.167602-1-sumit.garg@kernel.org>
In-Reply-To: <20260702115835.167602-1-sumit.garg@kernel.org>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Thu, 2 Jul 2026 13:14:03 -0600
X-Gm-Features: AVVi8CeXvNLFBEH_Z9SIZx0oNo56nh0xA5WRLgXhkbS1U9sxKdwz3gfEHooCZ0g
Message-ID: <CANLsYkyFJ+CbUJpwWAy28KHvmNz6rJRtM5KrEzHjyAha-7grTQ@mail.gmail.com>
Subject: Re: [PATCH v9 00/14] firmware: qcom: Add OP-TEE PAS service support
To: Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[48];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,qti.qualcomm.com,lists.trustedfirmware.org];
	FROM_HAS_DN(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.208.53:from];
	TAGGED_RCPT(0.00)[dt,netdev];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.208.53:from];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 950A3438C6
X-Spamd-Bar: ---
Message-ID-Hash: C4HV3H25DBDZ33ZNJSVVIG5PQD5PKPTO
X-Message-ID-Hash: C4HV3H25DBDZ33ZNJSVVIG5PQD5PKPTO
X-MailFrom: mathieu.poirier@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: andersson@kernel.org, konradybcio@kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.ka
 ndagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, jenswi@kernel.org, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/C4HV3H25DBDZ33ZNJSVVIG5PQD5PKPTO/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hey Sumit - nice hearing from you...

Is there some kind of overarching design harminisation between what
you are proposing here and what Arnaud posted back in April [1] ?

[1]. https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfi=
rmware.org/thread/VMKTRATYUFWL2TP7NHN5KJ37MSVZZMPK/

On Thu, 2 Jul 2026 at 05:59, Sumit Garg <sumit.garg@kernel.org> wrote:
>
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
>
> Qcom platforms has the legacy of using non-standard SCM calls
> splintered over the various kernel drivers. These SCM calls aren't
> compliant with the standard SMC calling conventions which is a
> prerequisite to enable migration to the FF-A specifications from Arm.
>
> OP-TEE as an alternative trusted OS to Qualcomm TEE (QTEE) can't
> support these non-standard SCM calls. And even for newer architectures
> using S-EL2 with Hafnium support, QTEE won't be able to support SCM
> calls either with FF-A requirements coming in. And with both OP-TEE
> and QTEE drivers well integrated in the TEE subsystem, it makes further
> sense to reuse the TEE bus client drivers infrastructure.
>
> The added benefit of TEE bus infrastructure is that there is support
> for discoverable/enumerable services. With that client drivers don't
> have to manually invoke a special SCM call to know the service status.
>
> So enable the generic Peripheral Authentication Service (PAS) provided
> by the firmware. It acts as the common layer with different TZ
> backends plugged in whether it's an SCM implementation or a proper
> TEE bus based PAS service implementation.
>
> The TEE PAS service ABI is designed to be extensible with additional API
> as PTA_QCOM_PAS_CAPABILITIES. This allows to accommodate any future
> extensions of the PAS service needed while still maintaining backwards
> compatibility.
>
> Currently OP-TEE support is being added to provide the backend PAS
> service implementation which can be found as part of this PR [1].
> This implementation has been tested on Kodiak/RB3Gen2 and lemans
> EVK boards. In addition to that WIN/IPQ targets tested OP-TEE with
> this service too. Surely the backwards compatibility is maintained and
> tested for SCM backend.
>
> Note that kernel PAS service support while running in EL2 is at parity
> among OP-TEE vs QTEE. Especially the media (venus/iris) support depends
> on proper IOMMU support being worked out on the PAS client end.
>
> Patch summary:
> - Patch #1: adds generic PAS service.
> - Patch #2: migrates SCM backend to generic PAS service.
> - Patch #3: adds TEE/OP-TEE backend for generic PAS service.
> - Patch #4-#12: migrates all client drivers to generic PAS service.
> - Patch #13: drops legacy PAS SCM exported APIs.
>
> The patch-set is based on v7.2-rc1 and can be found in git tree
> here [2].
>
> Merge strategy:
>
> It is expected due to APIs dependency, the entire patch-set to go via
> the Qcom tree. All other subsystem maintainers, it will be great if I
> can get acks for the corresponding subsystem patches.
>
> [1] https://github.com/OP-TEE/optee_os/pull/7721 (already merged)
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/sumit.garg/linux.git/=
log/?h=3Dqcom-pas-v9
>
> ---
> Changes in v9:
> - Rebased to 7.2-rc1.
> - Enable SCM backend similar to TEE if ARCH_QCOM is set.
> - Address misc. comments from Konrad.
> - Add checks for corner cases (although not reachable as per OP-TEE ABI)
>   reported by Shashiko on patch #3.
> - Picked up review tags from Konrad.
>
> Changes in v8:
> - Rebased on mainline tip (no functional changes).
> - Now Lemans EVK is also tested to support OP-TEE PAS here:
>   https://github.com/OP-TEE/optee_os/pull/7845
> - Drop Kodiak DT patch as it is carried independently by Mukesh here:
>   https://lore.kernel.org/lkml/20260624063952.2242702-1-mukesh.ojha@oss.q=
ualcomm.com/
> - Regarding Sashiko comments, I have already replied in v6 the ones that
>   don't apply but in v7 I got the same comments again. Specific context
>   reasoning which Shashiko ignores:
>     - ABI contract between Linux and TZ
>     - No support for multiple concurrent backends
>     - The TZ backend doesn=E2=80=99t detach during the entire boot cycle
>
> Changes in v7:
> - Rebased to qcom tree (for-next branch) tip.
> - Merged patch #5 and #7 due to build dependency.
> - Disabled modem for kodiak EL2 as it isn't tested yet.
> - Fix an issue found out by sashiko-bot for patch #4.
>
> Changes in v6:
> - Rebased to v7.1-rc4 tag.
> - Patch #14: fixed ret error print.
> - Add Kconfig descriptions for PAS symbols such that they are visible
>   in menuconfig to update.
>
> Changes in v5:
> - Incorporated misc. comments from Mukesh.
> - Split up patch #11 into 2 to add an independent commit for passing
>   proper PAS ID to set_remote_state API.
> - Picked up tags.
>
> Changes in v4:
> - Incorporate misc. comments on patch #4.
> - Picked up an ack for patch #10.
> - Clarify in cover letter about state of media support.
>
> Changes in v3:
> - Incorporated some style and misc. comments for patch #2, #3 and #4.
> - Add QCOM_PAS Kconfig dependency for various subsystems.
> - Switch from pseudo TA to proper TA invoke commands.
>
> Changes in v2:
> - Fixed kernel doc warnings.
> - Polish commit message and comments for patch #2.
> - Pass proper PAS ID in set_remote_state API for media firmware drivers.
> - Added Maintainer entry and dropped MODULE_AUTHOR.
>
> Sumit Garg (14):
>   firmware: qcom: Add a generic PAS service
>   firmware: qcom_scm: Migrate to generic PAS service
>   firmware: qcom: Add a PAS TEE service
>   remoteproc: qcom_q6v5_pas: Switch over to generic PAS TZ APIs
>   remoteproc: qcom_q6v5_mss: Switch to generic PAS TZ APIs
>   remoteproc: qcom_wcnss: Switch to generic PAS TZ APIs
>   remoteproc: qcom: Select QCOM_PAS generic service
>   drm/msm: Switch to generic PAS TZ APIs
>   media: qcom: Switch to generic PAS TZ APIs
>   media: qcom: Pass proper PAS ID to set_remote_state API
>   net: ipa: Switch to generic PAS TZ APIs
>   wifi: ath12k: Switch to generic PAS TZ APIs
>   firmware: qcom_scm: Remove SCM PAS wrappers
>   MAINTAINERS: Add maintainer entry for Qualcomm PAS TZ service
>
>  MAINTAINERS                                   |   9 +
>  drivers/firmware/qcom/Kconfig                 |  22 +-
>  drivers/firmware/qcom/Makefile                |   2 +
>  drivers/firmware/qcom/qcom_pas.c              | 299 +++++++++++
>  drivers/firmware/qcom/qcom_pas.h              |  50 ++
>  drivers/firmware/qcom/qcom_pas_tee.c          | 479 ++++++++++++++++++
>  drivers/firmware/qcom/qcom_scm.c              | 302 ++++-------
>  drivers/gpu/drm/msm/Kconfig                   |   1 +
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c         |   4 +-
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c       |  11 +-
>  drivers/media/platform/qcom/iris/Kconfig      |  27 +-
>  .../media/platform/qcom/iris/iris_firmware.c  |   9 +-
>  drivers/media/platform/qcom/venus/Kconfig     |   1 +
>  drivers/media/platform/qcom/venus/firmware.c  |  11 +-
>  drivers/net/ipa/Kconfig                       |   2 +-
>  drivers/net/ipa/ipa_main.c                    |  13 +-
>  drivers/net/wireless/ath/ath12k/Kconfig       |   2 +-
>  drivers/net/wireless/ath/ath12k/ahb.c         |  10 +-
>  drivers/remoteproc/Kconfig                    |   4 +-
>  drivers/remoteproc/qcom_q6v5_mss.c            |   5 +-
>  drivers/remoteproc/qcom_q6v5_pas.c            |  51 +-
>  drivers/remoteproc/qcom_wcnss.c               |  12 +-
>  drivers/soc/qcom/mdt_loader.c                 |  12 +-
>  include/linux/firmware/qcom/qcom_pas.h        |  43 ++
>  include/linux/firmware/qcom/qcom_scm.h        |  29 --
>  include/linux/soc/qcom/mdt_loader.h           |   6 +-
>  26 files changed, 1095 insertions(+), 321 deletions(-)
>  create mode 100644 drivers/firmware/qcom/qcom_pas.c
>  create mode 100644 drivers/firmware/qcom/qcom_pas.h
>  create mode 100644 drivers/firmware/qcom/qcom_pas_tee.c
>  create mode 100644 include/linux/firmware/qcom/qcom_pas.h
>
> --
> 2.53.0
>
