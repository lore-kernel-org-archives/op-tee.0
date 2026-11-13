Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44348606CA98
	for <op-tee@archiver.kernel.org>; Fri, 13 Nov 2026 13:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oMTuOfDt;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cf5wKUmT
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9D60F45539
	for <op-tee@archiver.kernel.org>; Fri, 13 Nov 2026 13:23:12 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oMTuOfDt;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cf5wKUmT;
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C002A40AB7
	for <op-tee@lists.trustedfirmware.org>; Fri, 13 Nov 2026 13:22:53 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADCJQB21525298
	for <op-tee@lists.trustedfirmware.org>; Fri, 13 Nov 2026 13:22:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=JQ8+sqq1Xi1ve9mdblMlJk
	MRVEsyvQ5nDwDvZeW41Gs=; b=oMTuOfDtLwIhCAMMQrqJDvu1g8VvXfY/A7INZm
	jEnf5qOM3O1fguSHZZ/V0zfCkxa3IW4+wRD8vaY+ORKs8g7mdHkdsbSF7t5pOoMb
	Yn5JEz6i0RNgSQh1Ge+rp8qy8V+QYE/wXeJlhMLcDhNLIX6dZ4rCCYqFbkGfHWY0
	UKcS2Hnau0QLyyG7tDgAIVC7tiwk7pLBH2As8bPzuB/jlqoWPIymFaFYWzfNwAmJ
	e2E5Y5AnWnoz9cskvXKZr7KgM/AEH3CDzPAOI1mxaUVvZ0Q1sbl+ktkoH05eKJx3
	m6+K5bl+WjT4rSHo0gxiiIY+1LN3BHnw80aSP/InAkpFFSNw==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hx0g20nbw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 13 Nov 2026 13:22:52 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-8b4a063a95aso1958537b3.3
        for <op-tee@lists.trustedfirmware.org>; Fri, 13 Nov 2026 05:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794576171; x=1795180971; darn=lists.trustedfirmware.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JQ8+sqq1Xi1ve9mdblMlJkMRVEsyvQ5nDwDvZeW41Gs=;
        b=cf5wKUmTk+yT0smUos83sfTitCbmHD18wDUvNUGYK72Am9VbtLUm5LBNNnKwVHfsDo
         te7mEbNoECDU9I8Ol3vF+y1GFwq0qbTyuHnviO3fKaVrtWucpRwTlijYr79tcFGHhHhl
         usbsVBrTwT+w9GkEKDA9bO36SzN5nPqRR/X+vuVM4g1JjXZ5S/X1mpoyWoj2t+mg7Ost
         +IO/PToEIsP7nctxEMFLpq93zrAM7LsIapoCkHmplq2K9zPKhI59VWZ6ST24pHg8p3Bt
         8CXqlncAkJ++dsnMx515TrcdHJVnrsnNQFcdHYwBeI2djEPsnKbtCmtILTjPZspyygyp
         SArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794576171; x=1795180971;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=JQ8+sqq1Xi1ve9mdblMlJkMRVEsyvQ5nDwDvZeW41Gs=;
        b=Cf0D0wWfmNNCDDROPhPvzBgKMsGZL43eSzuZk99cB9QIgdPo5zKQmydtRYRHxsA1YV
         EzijII9AGGLLKFV09PlFC64z1dQ8tWf6NEuwUaowsNXoknKNA7DNGhH0Ti8JFpa1kwXh
         MCI+INxSnf+kuBY3YYcafhRvoY0uDM1slFzxv786mk8j2ewi8Ky293CQiT7itLfr6oJM
         IV8H8tBtTXskw58q53/zhdyrfMnxEDl8qwyRYHmN1pdFAI8pM3V+gnJrnU1Jq3jON+fw
         ZzDeoR3zs8LL/zbe3DxU0o4ki+m0o5BxfMdWGgKvXSMibVwZsUOzSaA2+C9g2/fR8aWv
         49gA==
X-Gm-Message-State: APuU4Z+q4pVqzD/k0QEBI6LbZvkjm/YwQnWQDF2axP81/WhBkxq89Sep
	cIdyo1Ad2L1L+3F1c0+iIC2hiIlDNLADS2+NHbYlk3wyG2W61O4T2bQy7533ZpYHFrtc3ULvWSw
	eX3Y1qWCNb1QGeXFMHZaFjwQ6p25e7wHKdFYHSveot+GsrAM5pkZHKwwkKNypfiAVa66hFVMB
X-Gm-Gg: AYBFou1g1kG0tflRsumA5w95UrgqD+uDlEdkodJxe1quXsz/1SLhoTOgFPYQODdE1Xa
	Z6hmMQ9RXyCxAqLsnwdS6FpvJn/dRUowCIMNiVFfw7UTy9FkMU74WjRcLHHID+FLai6TnqJHgDR
	E54gdf+1Cy5TxcG5mOF7CSjY1Q5LeA5j0lViy1zXIDRJr57/TOOrV+iN6FPtySm1G83U0eIRGos
	n0jrB+4E3EktEdKTvsvSKoyIz57NK86kS6jtyUI64V58Me+pwxiejjlvnT0FyUJOpcGf1WvOGj4
	CTJvFL7JARRDrKnJnesfGjgVdB/FZtVgi0zyvlA3gSM8acj/BxGQ8XEt4YZmd2Fu+lHioh+z0GI
	TxvY5YtIA7xKyK6d0EwSIOcbHbBtdlTcWJrVnZt4f03Vhx7e0TqtEkfJ+/wPlH0bhyw==
X-Received: by 2002:a05:690c:6983:b0:8b0:8ec8:d4df with SMTP id 00721157ae682-8b4aa2e6c2fmr14708977b3.53.1794576171475;
        Fri, 13 Nov 2026 05:22:51 -0800 (PST)
X-Received: by 2002:a05:690c:6983:b0:8b0:8ec8:d4df with SMTP id 00721157ae682-8b4aa2e6c2fmr14708887b3.53.1794576170997;
        Fri, 13 Nov 2026 05:22:50 -0800 (PST)
Received: from x2e.localdomain ([108.208.224.205])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4aa957df4sm19614737b3.20.2026.11.13.05.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 05:22:50 -0800 (PST)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 08:22:46 -0500
Subject: [PATCH] tee: shm: sync DMA memory for the device before it is lent
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-tee-shm-dma-sync-v1-1-19d4efdfb4cd@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIACUP92oC/yXMSwqDQBBF0a1IjVOQaj9IthIy0PapFbATulQM4
 t7TJsMzuHcnQ1QY3bKdIlY1fYUEuWTkxyYMYO2SyV1dJSI5zwDbOHE3NWyf4FlcX9ZFXra1gFL
 2juh1+y3vj79taZ/w8/mh4/gCf1QRWXQAAAA=
X-Change-ID: 20261113-tee-shm-dma-sync-12f58435b81e
To: Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>
X-Mailer: b4 0.16.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA1MyBTYWx0ZWRfX/K5bPXwdBnON
 MYp8KH2DOEjL5QV2/PY33w5hXxHqBOa3DkIgY978XtnZVJnvOoUxzymBC6VnZICcwPEMJAWCjxD
 O9faYfZWgxmvmEOanXwKu4lFP4UZ/qijQXbXwW4uwqQpREHG+0lMa8WPEqC1choZ+JT17peKpFx
 01EdKKX8FVI79Ffeh81bfC68NopP567bKJggalcGSSF6TWOeUy/IO9fJihTVCck/GkmBqX5X58r
 m2aq9wA2XDBnyljiA3N3Pfv5NjSDziO68KmxoCZffoxsLnG0r1PAqvCnHjtULk6CtZP1ipLFqEv
 zJLSPoyxuSqvJhD7cJd5+yYr46r5LvI61amoGuL+EdF6ei0fxzX+ziSDuK5JINCRiQ02lzgeLQR
 n/dY4stbf0iU45LFzzPONG0Y8IiuK1TffhwteSNSCv2N1Hld+ufJabZ7dLhzXR5N8p0LOcpNgMc
 uPT3dPPOJBXDy+DNdSw==
X-Proofpoint-ORIG-GUID: 07BVyM00SGyMA5thkaogvv1AELC7G0Cn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA1MyBTYWx0ZWRfXwdOV+iTDxTUH
 AHJvLDMuCldHtP9UQZMc/8BAIuLxxXDkorWf//DgZzvgG2MF2T635cIuADGEpok6fheWM6RF0HI
 4JT6ofYs90tskqMMpEQrIO/wbX5aHbM=
X-Proofpoint-GUID: 07BVyM00SGyMA5thkaogvv1AELC7G0Cn
X-Authority-Analysis: v=2.4 cv=SpIFe/O0 c=1 sm=1 tr=0 ts=6af70f2c cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=6jbKIeu7AAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=EUspDBNiAAAA:8
 a=of0t6A3Ksg6zxwdynqYA:9 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
 a=-0VUF4iAjVmhXKmeMUOz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611130053
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[oss.qualcomm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.199:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C002A40AB7
X-Spamd-Bar: ------
Message-ID-Hash: BXAPYABMZ7GXCMNMMKRR6FKU6AK4WP6C
X-Message-ID-Hash: BXAPYABMZ7GXCMNMMKRR6FKU6AK4WP6C
X-MailFrom: tyler.baker@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>, stable@vger.kernel.org, Tyler Baker <tyler.baker@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/BXAPYABMZ7GXCMNMMKRR6FKU6AK4WP6C/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

tee_shm_alloc_dma_mem() returns dma_alloc_pages() memory without the
dma_sync_single_for_device() that the DMA API requires before a device
uses it. dma_alloc_pages() zeroes the pages through the cacheable
linear map, so the zeroes can still be dirty in the cache when the
optee protected memory pool lends the pages and a Secure Data Path TA
writes them through its secure mapping. A later eviction of those
lines overwrites the TA's data.

On an Eliza EVK with OP-TEE as the FF-A SPMC, a TA decrypts into a
protected buffer, a read of all RAM through /proc/kcore evicts the
lines, and the TA's digest of the buffer no longer matches:

  frame 0: 0e534d8c..., reference d98ddba1...

Sync the allocation for the device before returning it.

Fixes: ab09dd6d9201 ("tee: add tee_shm_alloc_dma_mem()")
Cc: stable@vger.kernel.org
Signed-off-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
---
Vincent's direct-map series [1] cleans the range in
dma_zap_direct_map() before the lend, which also covers this when it
can unmap. It returns -ENODEV without any cache maintenance when there
is no lendable pool and the direct map cannot change (arm64 with
rodata=noalias or rodata=off), and it is not a stable candidate.

On a dma-coherent TEE device the sync does nothing. teedev->dev is not
configured from firmware, so it is not coherent today.

Without the fix the TA's data is lost:
  https://lava.infra.foundries.io/scheduler/job/554467#L2262
With it, the data is intact after the scan and 50 lend rounds:
  https://lava.infra.foundries.io/scheduler/job/563840#L1979
  https://lava.infra.foundries.io/scheduler/job/563840#L2008

[1] https://lore.kernel.org/all/20261111110738.872947-1-vdonnefort@google.com/
---
 drivers/tee/tee_shm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 5c47a36916c45..70a273a425f88 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -297,6 +297,9 @@ struct tee_shm *tee_shm_alloc_dma_mem(struct tee_context *ctx,
 	if (!page)
 		goto err_put_teedev;
 
+	dma_sync_single_for_device(&teedev->dev, dma_addr,
+				   page_count * PAGE_SIZE, DMA_BIDIRECTIONAL);
+
 	dma_mem = kzalloc_obj(*dma_mem);
 	if (!dma_mem)
 		goto err_free_pages;

---
base-commit: e21989d08e0d6abacfff71387d0cb36dd96a4079
change-id: 20261113-tee-shm-dma-sync-12f58435b81e

Best regards,
--  
Tyler Baker <tyler.baker@oss.qualcomm.com>

