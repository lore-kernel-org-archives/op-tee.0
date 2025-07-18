Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A6BBC87FCB
	for <op-tee@archiver.kernel.org>; Mon,  4 Aug 2025 19:21:30 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id BFAE64FC58
	for <op-tee@archiver.kernel.org>; Mon,  4 Aug 2025 19:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1754335289;
	bh=f3LSdoYYmURS1rjz0097H7ejp033uVg7byHFkNuPVVE=;
	h=Date:To:Subject:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=zbp6RFEAt21EH+/bBBovbDs9doMd+9vGtKJ3ujMxKUBScCYxdgJMj6Geb2jAhV3xV
	 8udlDhLhSYP5fpWTQJmI1iKYXhPh+gyFS7uS0NR3q61xd5JHBHdBkfOjNwJr6a2GdN
	 IBnDGiI3hYidOeGvsFsWewWHZBto9sPhjGzd2fbOhkSXqpR+6ROoQfZdHV6U2x1RgH
	 Kb3a7wcMj8FYEq40Mme0o5W6J+opw/bYzfqza1/kDSuG31Mah9kfHRflU14yCkukq1
	 CiGzlcZb/Zf95oEdXYJeyrLvSLhB1O6B1J6vWHip9sMTFy5nwy6Z4cKDQkySjRZrRT
	 eawtcnbhJqoKA==
Received: from smtp1.iitb.ac.in (smtpd7.iitb.ac.in [103.21.126.62])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8478342E7D
	for <op-tee@lists.trustedfirmware.org>; Fri, 18 Jul 2025 15:30:26 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=iitb.ac.in header.i=@iitb.ac.in header.a=rsa-sha256 header.s=mail header.b=lev25uV9;
	dkim-atps=neutral
Received: from ldns2.iitb.ac.in (ldns2.iitb.ac.in [10.200.12.2])
	by smtp1.iitb.ac.in (Postfix) with SMTP id F2220101C931
	for <op-tee@lists.trustedfirmware.org>; Fri, 18 Jul 2025 21:00:23 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in F2220101C931
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1752852623; bh=f3LSdoYYmURS1rjz0097H7ejp033uVg7byHFkNuPVVE=;
	h=Date:From:To:Cc:Subject:From;
	b=lev25uV9L6S8T9uZxe+yu2+fKUbS2pCyuZfta79tZWvM3/B4GvdekxUth7VnAvNWr
	 aMIAw/s3/QoWvXFMbkk+EUPzxeztrG8NF2+Izz06vCRTDoBe7GBY8eOufwx2hTtAsJ
	 EsVzUpmG3bAuaScxO8wjZBMiB1Zt6z72WMGMDWVc=
Received: (qmail 13141 invoked by uid 510); 18 Jul 2025 21:00:23 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns2 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.100.0/26337}
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 4.023033 secs; 18 Jul 2025 21:00:23 +0530
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns2.iitb.ac.in) (10.200.1.25)
  by ldns2.iitb.ac.in with SMTP; 18 Jul 2025 21:00:19 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns2.iitb.ac.in (Postfix) with ESMTP id 84B093414EF;
	Fri, 18 Jul 2025 21:00:19 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id 5DFEA1E814D3;
	Fri, 18 Jul 2025 21:00:19 +0530 (IST)
Date: Fri, 18 Jul 2025 21:00:13 +0530
To: jens.wiklander@linaro.org, sumit.garg@kernel.org
Subject: [PATCH] drivers: tee: improve sysfs interface by using sysfs_emit()
Message-ID: <aHpohUxxSH42w16U@bhairav-test.ee.iitb.ac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 8478342E7D
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[iitb.ac.in,reject];
	R_DKIM_ALLOW(-0.20)[iitb.ac.in:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:103.21.126.56/29];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:132423, ipnet:103.21.124.0/22, country:IN];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[iitb.ac.in:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.trustedfirmware.org,vger.kernel.org,gmail.com,linuxfoundation.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RBL_SENDERSCORE_REPUT_BLOCKED(0.00)[103.21.126.62:from]
X-Rspamd-Action: no action
X-MailFrom: akhilesh@ee.iitb.ac.in
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: 64QEEMMRXDSWJO4SV3FZOHXJ35Y3XG5M
X-Message-ID-Hash: 64QEEMMRXDSWJO4SV3FZOHXJ35Y3XG5M
X-Mailman-Approved-At: Mon, 04 Aug 2025 19:21:07 +0000
CC: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, akhileshpatilvnit@gmail.com, skhan@linuxfoundation.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/64QEEMMRXDSWJO4SV3FZOHXJ35Y3XG5M/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Akhilesh Patil via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>

Replace scnprintf() with sysfs_emit() while formatting buffer that is
passed to userspace as per the recommendation in
Documentation/filesystems/sysfs.rst. sysfs _show() callbacks should use
sysfs_emit() or sysfs_emit_at() while returning values to the userspace.
This change does not impact functionality, but aligns with sysfs
interface usage guidelines for the tee driver.

Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
---
 drivers/tee/optee/core.c | 2 +-
 drivers/tee/tee_core.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index c75fddc83576..ce44e3498d37 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -72,7 +72,7 @@ static ssize_t rpmb_routing_model_show(struct device *dev,
 	else
 		s = "user";
 
-	return scnprintf(buf, PAGE_SIZE, "%s\n", s);
+	return sysfs_emit(buf, "%s\n", s);
 }
 static DEVICE_ATTR_RO(rpmb_routing_model);
 
diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index acc7998758ad..944f913f8592 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -977,7 +977,7 @@ static ssize_t implementation_id_show(struct device *dev,
 	struct tee_ioctl_version_data vers;
 
 	teedev->desc->ops->get_version(teedev, &vers);
-	return scnprintf(buf, PAGE_SIZE, "%d\n", vers.impl_id);
+	return sysfs_emit(buf, "%d\n", vers.impl_id);
 }
 static DEVICE_ATTR_RO(implementation_id);
 
-- 
2.34.1

