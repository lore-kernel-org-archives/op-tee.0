Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C2FC5AD49
	for <op-tee@archiver.kernel.org>; Mon, 26 May 2025 10:25:08 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5D17E42F96
	for <op-tee@archiver.kernel.org>; Mon, 26 May 2025 10:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1748255107;
	bh=JQ3FR2hNKw6sKWSi9aQrbPbvN5ZRm0PcpU+bcMaazmU=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=B6Ti1awXAydHKEPmdxlIk+D2Fj6ItbicVgt+5pGJDHqKGgFkDubcyoa7eb5GMY57Q
	 imHsYhyKlRxValwr1vCYjW+SfTqynZjF8ptkBIQ7bZN2/94bdzFerP84kCWOoZTidJ
	 8Z3ffZa5ejWe68mw1q/889xchm5+bjdoH6qMokbG3NRFpWS2SuYQCn1qYxQJkPJKyE
	 t5Q0df4p43kxuWZTj4wrfcQOZr2mPHpwqwXlsGrEh87GnNJz/L7OohgmU7nKMJivCb
	 dnkLg03breWoRyEJeSBX2p/OsE+PEFExVJewjdmnSlAUS16N49BvIdRCaR8kaKM4l1
	 3UJvtb8tLz5bg==
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id D776042C5D
	for <op-tee@lists.trustedfirmware.org>; Mon, 26 May 2025 10:24:49 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jrLzDfrN;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id ACE15A4EBBA;
	Mon, 26 May 2025 10:24:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF465C4CEE7;
	Mon, 26 May 2025 10:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748255089;
	bh=JQ3FR2hNKw6sKWSi9aQrbPbvN5ZRm0PcpU+bcMaazmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jrLzDfrNyPMktHQttqg31CQeMMSZ3rOmfjFQnYDGRGYyz2K44Poc4EhCx5n6lbV6P
	 Gnp4t0i/7zCb2PubDjMuZDEd+2LyLcytk6ERSFbZ9sBxi/WAX0ej0mH2h08MquxukN
	 rL9UAYRm3f3l/kvD6d1/vCWduOJQFP94wGcdMppS1Pse8nkUkigl43Xv8krF7VC79x
	 mVX48yxPBZUl10b797BAxENZwaHVut7MM0HwUOD1HRazWWkNybwxyWSSqtKb0NfoIp
	 AR9Z6GM8CPvSE1kI0elsm/bsZCO3wkGKIo7Ku08gzxv+FWfCFR8gmLAm0txJHyJvP8
	 4ZjfVBsd1W/0A==
Date: Mon, 26 May 2025 15:54:37 +0530
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: Linaro OP-TEE Contribution, LOC, monthly meeting May 27
Message-ID: <aDRBZVy9tsws659J@sumit-X1>
References: <CAHUa44HpAVR+sDM-Jb6DWo_goFMRZt3VVpi7Kg=5+aYpJLssZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHUa44HpAVR+sDM-Jb6DWo_goFMRZt3VVpi7Kg=5+aYpJLssZw@mail.gmail.com>
X-Spamd-Bar: ----------
X-Spamd-Result: default: False [-10.20 / 15.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	RCVD_IN_DNSWL_MED(-0.20)[147.75.193.91:from];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:147.75.193.91];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:54825, ipnet:147.75.192.0/21, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: D776042C5D
Message-ID-Hash: IAUIXJHA5BC5IJSXXOR45EIBV7AJ3IE2
X-Message-ID-Hash: IAUIXJHA5BC5IJSXXOR45EIBV7AJ3IE2
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>, linaro-open-discussions@op-lists.linaro.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/IAUIXJHA5BC5IJSXXOR45EIBV7AJ3IE2/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

Hi Jens,

On Mon, May 26, 2025 at 11:15:37AM +0200, Jens Wiklander wrote:
> Hi,
> 
> Tomorrow, Tuesday, it's time for another LOC monthly meeting. For time
> and connection details, see the calendar at
> https://www.trustedfirmware.org/meetings/
> 
> OP-TEE version 4.6.0 was released on April 25.
> 
> Amir posted a v4 [1] of the QTEE driver. Sumit and I have spent quite
> a bit of time reviewing this, but it would be welcome with comments
> from others, too. For instance, for "tee: add
> TEE_IOCTL_PARAM_ATTR_TYPE_UBUF" which adds yet another type of memory
> reference.
> 
> optee_ftpm Issue "Warning in _plat__GetUnique()" [2], digging in this
> reveals further issues.
> 
> [1] https://lore.kernel.org/lkml/20250428-qcom-tee-using-tee-ss-without-mem-obj-v4-0-6a143640a6cb@oss.qualcomm.com/
> [2] https://github.com/OP-TEE/optee_ftpm/issues/15
> 
> Are there any other topics?

Another topic:

- dTPM access via OP-TEE and exposing access to Linux via kernel driver
  (tpm_ftpm_tee)

-Sumit
