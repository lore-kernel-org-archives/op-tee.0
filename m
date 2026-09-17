Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F7F4C982CC
	for <op-tee@archiver.kernel.org>; Thu, 17 Sep 2026 02:29:23 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7F8F3452A8
	for <op-tee@archiver.kernel.org>; Thu, 17 Sep 2026 02:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1789612162;
	bh=gKCf9G1OziX0p9Csqvkd7+kJuhpu6eAUnKhLv5d9diw=;
	h=To:Subject:Date:In-Reply-To:References:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=eI44haMH1hN7NjDbDi/cRgksGV/pScMhcp6URnSJulw/neY3DJAK1po6ye6kNcQBM
	 wnB1wX7L5taj+0vW7vVeJCX3T3f5xJDEuimpYP21rsOQKE+Q3M3plFRyKGfSZqD6nH
	 KG1ANve9vckTLogSx1azQAT9kwhnlt5uu193R8mYO3XQJNmIDMTAfXG6cS99viZhlS
	 nWY3oC7YGeuQxajXWIKV1j+jwyeFOzPfQuv+DkxmAF//Lrue/6ThT25GVvRw16ZIuu
	 iIsRP2MQ49g3pw9NnxVrj7Tcr0rABGrWALI6BX/MQy63VGPG2ck7LZGhIm2GMYOFjK
	 BQ6wuivBXFDzA==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id CA5DF4397D
	for <op-tee@lists.trustedfirmware.org>; Thu, 17 Sep 2026 02:29:14 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ceN61Dhc;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0ADBB40E0F;
	Thu, 17 Sep 2026 02:29:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1261F0089D;
	Thu, 17 Sep 2026 02:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789612153;
	bh=fEVAPOQk6jwt+Jf+SkWTcogcQHa4kbYgmMZhQ7yy+3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ceN61Dhc7mUBHHP1sN8XXZmBWqGbSG0jJT1avrRETIx2I+xhVUeNazoiKcClM89lr
	 iMYw0J2l6lRcvUDxjkiUxMjOeJPd5/aC4TNb6lDzSXjAG5q131Rt1KNzKxavIlkZ1p
	 JoZ4L6B62xtTTfyfKMkylQwgYXyG6tnsaays5GAZ9dbYSd6QAPI4MppOZfKGzzrirT
	 R6LvbafM8XwYBBeNWgRZOgYYjKScbZcTCtVr0Jkh26bqNxKBe4L7QlknigFTgh60P1
	 UXHNcO4Md9JW5G4lF1MFmyDhCIZ5UqpDBy6Ja7Og0vW0tfYMo9VCOyaBxoi3f0uL3X
	 a4hf73YMlMGeA==
To: stanleyjhu@google.com,
	beanhuo@micron.com,
	beanhuo@iokpp.de,
	James.Bottomley@hansenpartnership.com,
	alim.akhtar@samsung.com,
	bvanassche@acm.org,
	can.guo@oss.qualcomm.com,
	sumit.garg@oss.qualcomm.com,
	jenswi@kernel.org,
	"Martin K. Petersen" <mkp@kernel.org>,
	Avri Altman <avri.altman@sandisk.com>,
	Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Subject: Re: [PATCH v5 0/2] ufs: rpmb: make RPMB usable with OP-TEE key derivation
Date: Wed, 16 Sep 2026 22:29:02 -0400
Message-ID: <178952247934.2757716.8897400080333552916.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831154804.719528-1-jorge.ramirez@oss.qualcomm.com>
References: <20260831154804.719528-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.00 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.98%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[100.103.45.18:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: CA5DF4397D
X-Spamd-Bar: ------
Message-ID-Hash: CRUJQ7FBL6TIHMO6TFCVC63GNBOCMIPS
X-Message-ID-Hash: CRUJQ7FBL6TIHMO6TFCVC63GNBOCMIPS
X-MailFrom: mkp@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/CRUJQ7FBL6TIHMO6TFCVC63GNBOCMIPS/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: "Martin K. Petersen (Oracle) via OP-TEE" <op-tee@lists.trustedfirmware.org>
Reply-To: "Martin K. Petersen (Oracle)" <mkp@kernel.org>

On Mon, 31 Aug 2026 17:47:59 +0200, Jorge Ramirez-Ortiz wrote:

> This series makes UFS RPMB work out of the box with an OP-TEE that
> implements the standard eMMC RPMB key-derivation flow, without requiring
> any fundamental changes on the OP-TEE side.
> 
> RPMB provides an authenticated, replay-protected storage area whose
> security relies on a secret authentication key. In our setup that key is
> never exposed to the kernel: OP-TEE derives it in the secure world from
> its hardware-unique key and a device identifier (dev_id) that the RPMB
> core hands down. OP-TEE's implementation targets eMMC, where dev_id is
> the 16-byte eMMC CID, and both the fixed length and the raw-CID layout
> are baked into its key derivation.
> 
> [...]

Applied to 7.4/scsi-queue, thanks!

[1/2] ufs: rpmb: retry power-on UNIT ATTENTION on the RPMB WLUN
      https://git.kernel.org/mkp/scsi/c/a8a34238e5e6
[2/2] ufs: rpmb: use a fixed-length RPMB dev_id
      https://git.kernel.org/mkp/scsi/c/657eff806d38

-- 
Martin K. Petersen
