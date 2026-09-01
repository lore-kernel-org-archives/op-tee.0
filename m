Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6210EC61DD3
	for <op-tee@archiver.kernel.org>; Tue,  1 Sep 2026 09:02:28 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6540943ECB
	for <op-tee@archiver.kernel.org>; Tue,  1 Sep 2026 09:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788253347;
	bh=BXlJbCEi6gghch6dYwny4m8jmf01Ie7bCbCfesUB+0w=;
	h=In-Reply-To:References:Date:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=z0Xkjb8ZJEPCciuRGJT5P/J01eSFsLrPFeRoOvxpKzj7A2jnGF7iZDmeHHpUmrdhs
	 tlnMJkR7LBMhwi8YjSsk24ko1Lbj91k4HHeK7eaEpQJyp7iM673xifGVKtyfhGa7fr
	 cj4k+LhArJlOja/G9Kv8jqmziUPRytvsiW5Ut/gAdX1ModueBljO9j/1K5cgSgJsOQ
	 MVRGDOzWL4N6+1W7GfAvCrT8hA0aw+kih51CbE0mPS930SVqDj5if77tUXJhDSRbx0
	 0+BpOemGciATh3keJGJGayaFuuMkXHSSSCzG8PwJnps53PgX/ylSmFOszu7pldc3Pv
	 kLiiyCXnHwxcQ==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C31D44425E
	for <op-tee@lists.trustedfirmware.org>; Tue,  1 Sep 2026 09:02:12 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OmoeU9y0;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 09A80419F9
	for <op-tee@lists.trustedfirmware.org>; Tue,  1 Sep 2026 09:02:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23511F0155D
	for <op-tee@lists.trustedfirmware.org>; Tue,  1 Sep 2026 09:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788253331;
	bh=BXlJbCEi6gghch6dYwny4m8jmf01Ie7bCbCfesUB+0w=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=OmoeU9y08Rew/WJVX+cE/6GRW0CAUyUe+zwXOEPOaLlbU98K/Zw+PFL9i4MPtLeSt
	 P6zDV/E4j7cRg5HiPpibeWFETS+bPY4vUNn4bnbOW50OvfsVBUrz5jpQAJUllNRcZu
	 qQuZwOF3j4bJnM3blnq+qoUABLqlfL+SZikpTGkrrvGqp7fSUabQByLvrip9be36kC
	 zhRh9QjulU9d/C0Mh7FsyJwvtmixrhhzIxpX+YZEhFVwDujOsrLW2K5A7tq/iwRgR+
	 6fYA04sI1dubD9UaqeuCQPXMPzxq7MHZgP9UR+ybeHtrp6DN8KPS8ciwUdB9ywHUR2
	 HrdgsCNW39iCQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b5ef26b92dso4421612e87.2
        for <op-tee@lists.trustedfirmware.org>; Tue, 01 Sep 2026 02:02:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzIpki62ZkRs2UPli6adDULO9/hkN5rRSPerxqWTIWqGSTLe01gOiYH3U8B/tc/Tdqk1S4aj+k=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++mY/ax9eUq06DRTPEbm0gNuXvrNMgdw52IcC/lclx0gAsCaT7CK
	EW5Loy9JjiAYQ4qT2fTztlbkHgVGpMVhUVH1iwDQeyWAUO4HcYSqcgtvAtDaC2gx6K9/Xf9BTip
	wI2hxGnZEKMCDCoCLmWgL9X+mMMCaDgaHwpNPOL1J1Q==
X-Received: by 2002:a05:6512:2347:b0:5b5:e265:5215 with SMTP id
 2adb3069b0e04-5b60420477dmr415842e87.22.1788253330516; Tue, 01 Sep 2026
 02:02:10 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Sep 2026 02:02:09 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Sep 2026 02:02:09 -0700
In-Reply-To: <20260807175041.3299349-1-julianbraha@gmail.com>
MIME-Version: 1.0
References: <20260807175041.3299349-1-julianbraha@gmail.com>
Date: Tue, 1 Sep 2026 02:02:09 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mdi-q_P9fpQukVPRXREPAO2VFHOwS7EoY5D050X-2ckfg@mail.gmail.com>
X-Gm-Features: AcwNN1VWtBOTEG04afhQpw7eoJFOOGhkAMer2IfyIEsN0kXsao7L-VQZEx0Wr3U
Message-ID: <CAMRc=Mdi-q_P9fpQukVPRXREPAO2VFHOwS7EoY5D050X-2ckfg@mail.gmail.com>
Subject: Re: [PATCH v3] tee: remove TZMEM_MODE_GENERIC
To: Julian Braha <julianbraha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.47 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-2.97)[99.88%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[bartosz.golaszewski.oss.qualcomm.com:query timed out];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DNSWL_BLOCKED(0.00)[172.234.252.31:from];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C31D44425E
X-Spamd-Bar: -------
Message-ID-Hash: K4TV6B6R6VTZEWJQKUFI37JLJHK3GB56
X-Message-ID-Hash: K4TV6B6R6VTZEWJQKUFI37JLJHK3GB56
X-MailFrom: brgl@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: sumit.garg@kernel.org, arnd@arndb.de, geert+renesas@glider.be, amirreza.zarrabi@oss.qualcomm.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, quic_eberman@quicinc.com, andersson@kernel.org, brgl@kernel.org, harshal.dev@oss.qualcomm.com, nathan@kernel.org, nsc@kernel.org, jani.nikula@linux.intel.com, kees@kernel.org, amirreza.zarrabi@oss.qualcomm.com, jenswi@kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/K4TV6B6R6VTZEWJQKUFI37JLJHK3GB56/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Bartosz Golaszewski via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Bartosz Golaszewski <brgl@kernel.org>

On Fri, 7 Aug 2026 19:50:41 +0200, Julian Braha <julianbraha@gmail.com> said:
> 'select' does not work on config options in a 'choice', so currently it is
> possible to enable QCOMTEE without QCOM_TZMEM_MODE_SHMBRIDGE, even though
> this is needed at runtime.
>
> There are no users of the generic allocator option,
> QCOM_TZMEM_MODE_GENERIC, so let's remove it. Then, we can remove the
> containing choice..endchoice, which allows the 'select' to work as
> intended.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Julian Braha <julianbraha@gmail.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
