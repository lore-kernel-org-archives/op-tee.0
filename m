Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD150CAC592
	for <op-tee@archiver.kernel.org>; Mon, 15 Sep 2025 14:03:42 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 213E741A2A
	for <op-tee@archiver.kernel.org>; Mon, 15 Sep 2025 14:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1757945022;
	bh=3OGpAD/DchUR1g97RRHzHWYq+4uUvSPasPeyQ225Wbw=;
	h=To:Subject:Date:In-Reply-To:References:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=dK7Gjd5hvpZqXRfEuf513Pgqm6APXannmIwso8HhdL3cfirrC1NDF27j4S8805GR+
	 x74d/SAO1GKjX6zl236Pr7On2ltV0iQqB7veFVT5u+1hogtF+bAm08d9VJ65Ivmz4r
	 REwQIFfcMzJHNlfZofcxVZaEteMXi8kf9cEYXXRztMjd394uC3bNgHaz4jiVjitEnO
	 HdmO+NlWIqAPC0DkGw8/kFgypthht1h0sVZBDUm194sOMoH6i41tqs6wOLVrakbSGy
	 HNjBxPPfT+3Fw/kFkKsLB5q+l9g9dwGKwSQL+3XvbMkQ4zsYxkqILOJ4u2SJu35hC3
	 iNa/+g4QZ3BRA==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 294E240ADA
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Sep 2025 14:03:25 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ePsbBEj7;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 640ED4196A;
	Mon, 15 Sep 2025 14:03:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5EDCC4CEF1;
	Mon, 15 Sep 2025 14:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757945004;
	bh=3OGpAD/DchUR1g97RRHzHWYq+4uUvSPasPeyQ225Wbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ePsbBEj7Xnja3jcodWPE9dWOmMn5QFEarpYbh77+opI5UEfW4s2diz9T0dmsLgpXH
	 7hex+7mEbHOw4A6gcLtg+2YJLyfFsOxm3oNAYi55mbDGYGvEzjSWZEBqfbcFJMv+TZ
	 cFVSWimnCfZai8Lji+z0GAuK7XR+pvIP5ipesFhyp/iU0Qi+xovpCcj7hzTj4yladf
	 Jqk9hrb19xKTnctrFPfpuoZ5/nWiQ2td4pwFxDHLkftR/tp8+RTrDw5ZUh4qhC47WV
	 25nGeIUReGZB9erzYXtEiEnKvwgdOsNbYHIEANFg9/KbyyBH4cxAnXA+xFsuIoorrB
	 dJraCaCEONZVw==
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Sumit Garg <sumit.garg@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Apurupa Pattapu <quic_apurupa@quicinc.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v12 00/11] Trusted Execution Environment (TEE) driver for Qualcomm TEE (QTEE)
Date: Mon, 15 Sep 2025 09:03:21 -0500
Message-ID: <175794499686.3800302.11326605409469132909.b4-ty@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-0-17f07a942b8d@oss.qualcomm.com>
References: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-0-17f07a942b8d@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 294E240ADA
X-Spamd-Bar: -
X-Spamd-Result: default: False [-1.45 / 15.00];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	BAYES_HAM(-0.45)[78.90%];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: 62AQWD6YJKROK3ODLE5KRRU2AFLM4FOH
X-Message-ID-Hash: 62AQWD6YJKROK3ODLE5KRRU2AFLM4FOH
X-MailFrom: andersson@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, Kuldeep Singh <quic_kuldsing@quicinc.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/62AQWD6YJKROK3ODLE5KRRU2AFLM4FOH/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Bjorn Andersson via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Bjorn Andersson <andersson@kernel.org>


On Thu, 11 Sep 2025 21:07:39 -0700, Amirreza Zarrabi wrote:
> This patch series introduces a Trusted Execution Environment (TEE)
> driver for Qualcomm TEE (QTEE). QTEE enables Trusted Applications (TAs)
> and services to run securely. It uses an object-based interface, where
> each service is an object with sets of operations. Clients can invoke
> these operations on objects, which can generate results, including other
> objects. For example, an object can load a TA and return another object
> that represents the loaded TA, allowing access to its services.
> 
> [...]

Applied, thanks!

[01/11] firmware: qcom: tzmem: export shm_bridge create/delete
        commit: 8aa1e3a6f0ffbcfdf3bd7d87feb9090f96c54bc4
[02/11] firmware: qcom: scm: add support for object invocation
        commit: 4b700098c0fc4a76c5c1e54465c8f35e13755294

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
