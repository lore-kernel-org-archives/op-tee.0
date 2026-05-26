Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48DB2CD5BB1
	for <op-tee@archiver.kernel.org>; Tue, 26 May 2026 15:21:33 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id ABA4544DE5
	for <op-tee@archiver.kernel.org>; Tue, 26 May 2026 15:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1779808892;
	bh=QF3GgHGmqxOc2ZiHSwTIFp/SPXOTLWdRiKhIV8Khm7E=;
	h=Date:In-Reply-To:References:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=CeApfLVYuWQ/cwJDssqJ7RcKndLHYuB9qA1wl+o+ziB98i4nMrqQor1PG/BoMD+HE
	 zD3KpQrol8UHJujvKzlMhGlWiomIGEACdSbezWpBpzflzmA3pbETsd1Yxe/XTambJF
	 6FBVg0lWlfTYF2O1ACy3ersEDfNjyeO3aW6QjTS3KaTJ5KIMw1Iuq86TuCmMsANAaa
	 4dbt0qIzkryleT8XjULUwXqIYmMKrW/b5nv72FTCNN+Iq5uqlqIuOgslVVEIjzrKEk
	 c7b133G5f6/RtKCutGQ/sEc0Qh6EzaDT3A9ZbhG/+kD7SiKwCdrMwyODv9mLcCwh4+
	 xcdcliWSWFJzA==
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 828FE44E66
	for <op-tee@lists.trustedfirmware.org>; Tue, 26 May 2026 15:19:51 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=wVM88YCd;
	dkim-atps=neutral
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-bd52e4acb11so783435666b.3
        for <op-tee@lists.trustedfirmware.org>; Tue, 26 May 2026 08:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779808790; x=1780413590; darn=lists.trustedfirmware.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UeoRdqb2W8o2rKYS6Num15n8gkt/ODkSyZpzjjpRQD8=;
        b=wVM88YCdEDkuYG88TIJg0sxbEhcAo6BwHXs0RzLXHjXPi0lsCkFyjmLWMyDWaUR1Z6
         Ad4j07BkFhQZjO1Ip8g1CC/j8wkywyyF23P1UuWGAfwfdb9xtwBFh43qzfUoo+UXl03y
         sgFNmjIOAGQkOzlQuWJqVL+hST5DYtuYeUAtl7iJEmb5MLEy+bHik0Z3Edn9OE2kP488
         15xB5uvkuQ+IiHHW2HZP1V05a6FvoNJwoYrIwC5MrgQrC9uIPq6X7HsodtnkA4xiR4+h
         uDXQlco36BBMm6n2lC+PWTMTEMKqJXXD8iElX/dAj+RGVt/gKUKnAUsxK/IFPmYLgLcJ
         xQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779808790; x=1780413590;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UeoRdqb2W8o2rKYS6Num15n8gkt/ODkSyZpzjjpRQD8=;
        b=FnVp9qzIgiCY9NocC5Fjt6aXmOHt9blGXpu7CyyMo2iavOLWjxSx7pASYIPNYUNIMk
         s+X9ZLMKYFlwB86Akt+RCMN45mIYaQWIqtHNraFlXil6vBb8S2acuFu44IDqZ6/pd/ZQ
         Sc/USiQk8hZSD9AnIpwuwp4P5t/mOGxaopTJ6UsjJP4e6i/n7RWx6V1v/Yl48EWwBXrD
         tlFGbYWPgGseUyw37GpGkDwXW3pHFZ4Vw7zTmmFAJNGqLye8K2bVt8wLbW125CKrGV4b
         davBvKzFDfWOqVywxfSKaIfZ59LhtG0SpeNPFohiKhCxWbVb214y5sZs/mnXyhd/LAbi
         Eafw==
X-Gm-Message-State: AOJu0YzZN6di4hNehUV92T1/MTd0Z2p51S+hv/TzFhSTLDkTzPcs4FlL
	ywD6lQi0R5lBWYmZ18yTZ5ytbx7BRSMlkZbg5pqca6Ln3XXNUiIzgbP4+wCu77uG+89vhvn6+Ij
	fJBB9EQwt/MPGXqCuNcAQ6e0se9tqz4JTFy0guOshQebGA6LjeMljFQ5yU/ds4HQ5jCjiG8uamb
	etvLzymSyv4JOk1uhrexvihHfbfB7xjZsQgeYbzS1c7S5TZD7owL05/GyN2vaC
X-Received: from edbcr16.prod.google.com ([2002:a05:6402:2230:b0:687:17de:d8b5])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:5107:b0:67e:96a8:40d0 with SMTP id 4fb4d7f45d1cf-6889cc429a0mr6652238a12.21.1779808790002;
 Tue, 26 May 2026 08:19:50 -0700 (PDT)
Date: Tue, 26 May 2026 15:19:32 +0000
In-Reply-To: <20260526151934.3783707-1-smostafa@google.com>
Mime-Version: 1.0
References: <20260526151934.3783707-1-smostafa@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260526151934.3783707-5-smostafa@google.com>
Subject: [PATCH v5 4/6] KVM: arm64: Fix bounds checking in do_ffa_mem_reclaim()
To: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.30 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	FORGED_SENDER(0.30)[smostafa@google.com,3frovaggkbjknhjnovavbjjbgz.xjhjk-ozzgdnon.ompnozyadmhrvmz.jmb@flex--smostafa.bounces.google.com];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.218.73:from];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_TWELVE(0.00)[15];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	DWL_DNSWL_BLOCKED(0.00)[google.com:dkim];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.218.73:from];
	FROM_NEQ_ENVFROM(0.00)[smostafa@google.com,3frovaggkbjknhjnovavbjjbgz.xjhjk-ozzgdnon.ompnozyadmhrvmz.jmb@flex--smostafa.bounces.google.com];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 828FE44E66
X-Spamd-Bar: --
Message-ID-Hash: IUWAUU4HKRGNMPQX67BHCYQ5PREXIBZI
X-Message-ID-Hash: IUWAUU4HKRGNMPQX67BHCYQ5PREXIBZI
X-MailFrom: 3FroVaggKBjknhjnoVaVbjjbgZ.Xjhjk-oZZgdnon.ompnoZYadmhrVmZ.jmb@flex--smostafa.bounces.google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, sumit.garg@kernel.org, sebastianene@google.com, vdonnefort@google.com, sudeep.holla@kernel.org, Mostafa Saleh <smostafa@google.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/IUWAUU4HKRGNMPQX67BHCYQ5PREXIBZI/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Mostafa Saleh via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Mostafa Saleh <smostafa@google.com>

Sashiko (locally) reports out of bound write possiblity if SPMD
returns an invalid data.

While SPMD is considered trusted, pKVM does some basic checks,
for offset to be less than or equal len.

However, that is incorrect as even if the offset is smaller than
len pKVM can still access out of bound memory in the next
ffa_host_unshare_ranges().

Split this check into 2:
1- Check that the fixed portion of the descriptor fits.
2- After getting reg, check the variable array size addr_range_cnt
   fits.

Also, drop the WARN_ONs as that will panic the kernel and in the
next checks there are no WARNs, so that makes it consistent.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index 1af722771178..b6cf9ad82e12 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -607,8 +607,8 @@ static void do_ffa_mem_reclaim(struct arm_smccc_1_2_regs *res,
 	 * check that we end up with something that doesn't look _completely_
 	 * bogus.
 	 */
-	if (WARN_ON(offset > len ||
-		    fraglen > KVM_FFA_MBOX_NR_PAGES * PAGE_SIZE)) {
+	if (offset + CONSTITUENTS_OFFSET(0) > len ||
+	    fraglen > KVM_FFA_MBOX_NR_PAGES * PAGE_SIZE) {
 		ret = FFA_RET_ABORTED;
 		ffa_rx_release(res);
 		goto out_unlock;
@@ -641,6 +641,11 @@ static void do_ffa_mem_reclaim(struct arm_smccc_1_2_regs *res,
 		goto out_unlock;
 
 	reg = (void *)buf + offset;
+	if (offset + CONSTITUENTS_OFFSET(reg->addr_range_cnt) > len) {
+		ret = FFA_RET_ABORTED;
+		goto out_unlock;
+	}
+
 	/* If the SPMD was happy, then we should be too. */
 	WARN_ON(ffa_host_unshare_ranges(reg->constituents,
 					reg->addr_range_cnt));
-- 
2.54.0.746.g67dd491aae-goog

