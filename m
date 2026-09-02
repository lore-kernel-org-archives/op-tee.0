Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A068FC61DD6
	for <op-tee@archiver.kernel.org>; Wed,  2 Sep 2026 10:53:36 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id DD96A45315
	for <op-tee@archiver.kernel.org>; Wed,  2 Sep 2026 10:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788346416;
	bh=5C0s/9UucVAGmXDEl+xwewW/gLO4zg1pKiD4RPTspKs=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=MVFHtmyIlkeS+Q78XNk1nxQesRX/HQtkEiaLjHyvmtnjdPBwJXtJueRbqzts3oETj
	 YDYxTeST8mp71N2+0JFfXWKxbF06D6g1YDFIAe3VXjiT3ieO4NWO+cCD94w4hPtTZN
	 jX1grHtx1pmtMROegaIwBRc72cb7jfQqDWNbflC2G2wvziXbIzaoEv3G9KFDt6mfSn
	 dgt2N2uoVlNJ+gklEBnYuylgb+zAZGyOZrDy2cA/fxo7mkaBIYSf1VM+C3GQldisFi
	 0LQ6u2BlGuaF+aUtLbDhTdiSIEF3wxQVyS69OAtf1x7McU16rBFKKvVS3BwELQmvJT
	 9Fog2CbqPApfw==
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0B93345315
	for <op-tee@lists.trustedfirmware.org>; Wed,  2 Sep 2026 10:51:14 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=DoYMqZy4;
	dkim-atps=neutral
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6a6108d2987so1019308a12.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 02 Sep 2026 03:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788346273; x=1788951073; darn=lists.trustedfirmware.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0x2qbND6Sa3WNSOYkn6lqr5Ld4Ihzkg79AVpCRYTR1A=;
        b=DoYMqZy4K9Rr2MgcFikcWx93rZANml9TpxQUItWA0S5rPSR8fMXLx99sks7NfxMYcd
         IohP37hJGwGKQOVWPD73G7oGjlat56CoVle7ztYH/9tBJ733cJeP5WrANPELoq0AL9O2
         49R424ChHuIFonNbyg3A61Lg9q9f/cE6qxzTBUObxVBJl2ZUIf4OuTeUXdKQdL3FtSgx
         ujrZ2AAIAANJXX+AnaPyDP83uxgljHUp1PUwNfvWaL0XbIzqhc4ddGT/l8OZycx6fNFj
         IMZhDIt/ZJT4hDiBzWo9QzxQEB8iXJWV/kLJx4P6qPevHAc3S/20j5ps+UEHm2aYP6nF
         HDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788346273; x=1788951073;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0x2qbND6Sa3WNSOYkn6lqr5Ld4Ihzkg79AVpCRYTR1A=;
        b=shzCY8EjVM3Sx6oQWzOy0ZkSd3OOOAyCL0KYRjfalpY60dz94HPdA6mCs1/+hF8Yox
         xd/m5YUt8rwbgq730r+sC70zaxpjb8LEorItHZiX92wQHMrgFhjARl24/z2VMyOtKSVJ
         t1RRG4X2BTFIMk0mxCbjbk5gFF2RH/vXpgs2UgpGdjbJs3s7h1FrWmsOXu5aZAfvmIyn
         Rjnfi7nlayGih/WeUuQPgYUB1fAxL5pk5foQRS3xk+MfirsH7VFTHhNakDiYIOcQhC2a
         w7GWUFzgvXxcFlACmsmXVsq9SlkFaJKFz3ZO1ELhwkxU/4/hIfaadIw4eBd1s83q4+WB
         Kieg==
X-Forwarded-Encrypted: i=1; AKwUvBy4VYcmtyRmErl3G8U7uopQb8Z4LElUI8eZ6B6a8t8nYkG8zpVg0chcE534Gfv7Iqa3miW7Io4=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++nPf3/WcVUwhtvMlPd2DpMtHKi3BVipgiJdo8KgLTCKKOdFV4aw
	A/+pfe71HvT0wQFym7mUvSXVPO9zQh6KB30kboMolyaYpOl8TMRuPPgZDu1L7vtImyU3mCxnWuo
	HrSAysVfFXwlu4EAvhZnqZw==
X-Received: from edyf4.prod.google.com ([2002:a05:6402:684:b0:6a5:e070:f1f6])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:46c5:b0:6a3:f47c:969 with SMTP id 4fb4d7f45d1cf-6a68224ce3emr2605259a12.3.1788346272605;
 Wed, 02 Sep 2026 03:51:12 -0700 (PDT)
Date: Wed,  2 Sep 2026 11:47:07 +0100
In-Reply-To: <20260902104712.2399797-1-vdonnefort@google.com>
Mime-Version: 1.0
References: <20260902104712.2399797-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260902104712.2399797-6-vdonnefort@google.com>
Subject: [PATCH v9 05/10] arm64: can_set_direct_map() if BBML3
To: catalin.marinas@arm.com, will@kernel.org, rppt@kernel.org,
	akpm@linux-foundation.org, sudeep.holla@kernel.org, jenswi@kernel.org,
	robh@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	FORGED_SENDER(0.30)[vdonnefort@google.com,3op-xagokblso6hgg78hkm9hh9e7.5hfhi-m77eblml.mknlm768bkfp3k7.hk9@flex--vdonnefort.bounces.google.com];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.208.70:from];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	FROM_NEQ_ENVFROM(0.00)[vdonnefort@google.com,3op-xagokblso6hgg78hkm9hh9e7.5hfhi-m77eblml.mknlm768bkfp3k7.hk9@flex--vdonnefort.bounces.google.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.208.70:from];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 0B93345315
X-Spamd-Bar: --
Message-ID-Hash: S6GBVDI2AHFOE2U3WOGMF44BO5FRI5XM
X-Message-ID-Hash: S6GBVDI2AHFOE2U3WOGMF44BO5FRI5XM
X-MailFrom: 3oP-XagoKBlsO6HGG78HKM9HH9E7.5HFHI-M77EBLML.MKNLM768BKFP3K7.HK9@flex--vdonnefort.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: mark.rutland@arm.com, sumit.garg@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/S6GBVDI2AHFOE2U3WOGMF44BO5FRI5XM/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Vincent Donnefort via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Vincent Donnefort <vdonnefort@google.com>

Systems supporting BBML3 can split blocks without risking unhandled
page-faults. It is therefore safe for them to set the direct map
unconditionally.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index bbe98ac9ad8c..58898ae53f5d 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -99,7 +99,8 @@ bool can_set_direct_map(void)
 	 * Realms need to make pages shared/protected at page granularity.
 	 */
 	return rodata_full || debug_pagealloc_enabled() ||
-		arm64_kfence_can_set_direct_map() || is_realm_world();
+		arm64_kfence_can_set_direct_map() || is_realm_world() ||
+		system_supports_bbml3();
 }
 
 static int update_range_prot(unsigned long start, unsigned long size,
-- 
2.55.0.970.g62bdec98f9-goog

