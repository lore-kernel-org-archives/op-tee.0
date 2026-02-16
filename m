Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF1BE8383C
	for <op-tee@archiver.kernel.org>; Mon, 16 Feb 2026 22:25:00 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 052D0436E8
	for <op-tee@archiver.kernel.org>; Mon, 16 Feb 2026 22:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1771280700;
	bh=sFOj8xX0Q3HGZxZuHG70/L20ZM5XbsUoy5e9awUE1fI=;
	h=Date:Subject:To:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=JfRPHNGvbBerV7vhZRkE1RHMa6+JNvyV/YdNVkW14eWW57JUHD6C1VtkDDDHTm3W4
	 ehios7/FD7CPR1+vNVzM4uCgRUxpwYpZLmzCy2tJbF6qfTCUYH1YtKxHyQXDOlUaBg
	 W2vhJDfGjRdV6/bIeZgGY44xxi06bT++WN7k9/AvOB/n98+KD68SV7yyGXsrDQ/PS9
	 JTPUANLfX840q5Ad9rEKIdtFbe/+1SmSHlrnjj7nHHc9fmOXGlheYGH1lLIcSTVWw5
	 sSkTays0woDU7sEB7bGCJalO/j1lntLgCzAu/9EqOWfxyh7uoVUMutD0hzaDjYCUZM
	 LAWiyn2TX7bPA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id D6EE8436E8
	for <op-tee@lists.trustedfirmware.org>; Mon, 16 Feb 2026 22:24:38 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aI+TfEt+;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LHPYhGvy;
	dkim-atps=neutral
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GFtXba297215
	for <op-tee@lists.trustedfirmware.org>; Mon, 16 Feb 2026 22:24:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=kib2rIwG0L/bYr5o7sZjqj
	0oC1MGannDXI1dUWK6gUM=; b=aI+TfEt+ZWR/qxH0EQO3dxKCdVvXR0dVr4Gy5b
	Q5SGtnom04WQbyYgorb0fZ9WTvNmFOjOknUcOOKHXEAZcRmg4Kw/H63OJfwY5spU
	4AcoVQEDrMJxjUARuH7t4wol7aK4HLbCQwApWyxtpJbuo9v8BEBdOtGLt2/vZm2+
	6ehPj8ReD9VYjaUQiG6UPOS++pcynsrbzXIY9ucBK4YmHynH8jw8Zr1LBOiTtG76
	sl83pOtbtrjQ/Flb6VHDdZ987h/jkcrTzFx3GiNR7alJFLtshuCdfUkxtf3bmq1x
	4BWpUrANbzf303ZH4YY1zxeO81tZXx2Dmf2b7DiMxKVvvzpw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc6a9rpsd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 16 Feb 2026 22:24:38 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-124a95d580cso61611647c88.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 16 Feb 2026 14:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771280677; x=1771885477; darn=lists.trustedfirmware.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kib2rIwG0L/bYr5o7sZjqj0oC1MGannDXI1dUWK6gUM=;
        b=LHPYhGvyyAtYrss2Ml2lsh+tyFWjZCThzBfmLXcNlyHtxnomq3D/ffdlgbf/0XlfT7
         9YvDgVq1Tqk2PTWg4TK6FNuTAubRnbNII7KRq+YRA7QKyXruQZ/w+pcgzUrhNyuF3sDD
         y66If5Wu9kMuxDOD/Z/h1Kfa6PSB71uxMgMmue4PvHpYXlEpdlDJbo0NRAOxfTBg2OZp
         9b0N/HZcAkCkRTm5mgMFr2G9gkemVyn7OD91PeaGQHFUwCryYgImwGC62kQHwkHYdKiC
         0+9sXz6rXAYZKwhJLFLGToY6WLIdvuvpVkgx/zZn3MfwJnUX44RUtbIgpuqqBDI1F9vI
         hefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771280677; x=1771885477;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kib2rIwG0L/bYr5o7sZjqj0oC1MGannDXI1dUWK6gUM=;
        b=GkFA3pnQe5ho855UfRNCdD+7cpc5lQX9k2823OMb7JRbPxVWqIa9aw20mO/pcjcDEm
         Jyfcuah2g5+RRDOKdnOAxjl2OYpfK/YisXnIKnnHnXweFBoZOgDD+o8Lu7CIWzCBU6oF
         a7cqDGUVB6yBiLNOY08toX/jVz4+Xi/E3BWfYBNnS80TrxLHxaosRJSwB2yUXu6mkfqo
         1Fq1Y5TN3YZ3S4IBW/h9YMCku7bR5nBpIwHs5KNMHyb9pS8DkZNQGKV7Xq9w8vl90mng
         BKQO5VPLBawpivDNuMk3HDwycokmLcesbgeIAienw5Xe0cTm2G30BnR2vEUK1AWPqUBU
         uREQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGxbJzXnFCpvYEuxFC005IqFKqBfgJoEdgzWqnVe7lpGPOyE4+MjZbztKJBJSNNkq4qsiZ3z4=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yw2l8jI7nIHio0qISBbrGn1N82uIl2bjBy/zbybzEGtGhzrn5Oq
	qz/NesSvIzmPfElrEEgDZXuZjA7iKNjOyOF/ypQfXVsa0pjG8OxADbVibXauvKtlM/qpMgRhUcQ
	jDdUWnPrfJuc9JOMRpCE8/pwDIbcmoh7gQRXgb4430njCWvOjxQkf1eMl0w2IsAkmJoNB4hk=
X-Gm-Gg: AZuq6aJPfOntmuC3Tvmnkup0QiRDoMlQpyzqvBe8aFNLvcUogmclEC9V20byjtT9KHI
	gbKaoCuD5xlgbi1FJDgye0nkn7Afm/0QgVBmczQ8lpo/MdRGsJ1ANtwIdXS/5FOv7rf500s5VzZ
	yM2F45vOYfgWiE/vDZdsEtgRc0psrTj8sgmpyidQeEPjOvqtyNAuAjPbjhELBC/iuVazeV9jx2O
	ST46wDoiPdUiklzcG1/WJx1IHVQdx0hqWZ0q3AKHF7O2Bt7qggDEzssBZqF0IHvB9HN61EXvpcE
	DUHGZiNHOJbKS7hEFI/PFyGyJT8VRTF9uTOnxDmb5BTZvO2Q0vOL3kLecrIyZUkdVLOyzGM3pnw
	2EUxH+F9INEy6ikaR4PkuJT2t+67gdAJ68kCRuYJEChyITYmR9dyfvv6hZk88t3QiMVrWPoLT9V
	vDE1eK
X-Received: by 2002:a05:7022:6088:b0:119:e569:fba9 with SMTP id a92af1059eb24-1273ae341ecmr6787690c88.24.1771280677128;
        Mon, 16 Feb 2026 14:24:37 -0800 (PST)
X-Received: by 2002:a05:7022:6088:b0:119:e569:fba9 with SMTP id a92af1059eb24-1273ae341ecmr6787671c88.24.1771280676548;
        Mon, 16 Feb 2026 14:24:36 -0800 (PST)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742cba118sm14274369c88.12.2026.02.16.14.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 14:24:36 -0800 (PST)
Date: Mon, 16 Feb 2026 14:24:06 -0800
Subject: [PATCH v5] tee: optee: prevent use-after-free when the client
 exits before the supplicant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-fix-use-after-free-v5-1-0d6fd12d1f09@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAWZk2kC/3XOS24CMQwG4KugrBuUePKarnoPxCLJ2CVSYdoER
 q3Q3L0GCbWLsLH0W/ZnX0XDWrCJ181VVFxKK/OJg33ZiHyIp3eUZeIsQIFVThlJ5VteGspIZ6y
 SKqIMRDrZyU7eG8GLnxV56o7u9pwPpZ3n+nO/sehb98HZHrdoqWX0aoIhEYEJb3Nr269L/Mjz8
 bjlIm7qAv8k7bsSsKQpUSTMdtT+iTQ8JKc0hK40sJSUD87xYyM8k8yfBGrsSoYln002ScHgAnW
 kdV1/AXHT/HSZAQAA
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>, Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.13.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDE5MiBTYWx0ZWRfXwER5hU2ByWTE
 CCs2ZLPVsa6DdTHu/EDhMCIEhHAhC2M4+mLuTA6KQeYTOU9dVJYxzf3+499BZSFt5F58uFFRDiQ
 64HIw2qODg3cIgkmzhDhb0PG18SGJs+gJonpv7hMXcTNp34qmCbuxQAFQjYFYmda9FB3ERPUfJM
 OauVbvHnB8FxlYI3wRWNZfxN3F6TDPcU4YcZE+pCUJseoJzUl+IT6NN7FEoFvVulNxfGgHMO/rp
 coM2u4sdODb8Ob2q7vZgarZ+DdLszQj9ao+X8wGCD4FzfaM0qjaWF5CkXnXtc78jXZCCyUfV004
 lUEPAHWLoiz2RbsfqIzw8ZhhVfQXCZLMuKlyWcFge3+5el8zNhUuNpf+2Ba45RwmDpw3YQlI/YU
 r7uJkRAqRG5hbpfc4SvXpQO+8DuxcSQ2qt7xSvEKE1BL9Km6XZEUIFrzrq+xufoA5/FUE9JHyq5
 D7GQSMUY54zHK8VetzQ==
X-Proofpoint-GUID: DRIah9PCVEus6jRSTy0xxeNqJ9O83D6v
X-Proofpoint-ORIG-GUID: DRIah9PCVEus6jRSTy0xxeNqJ9O83D6v
X-Authority-Analysis: v=2.4 cv=TPNIilla c=1 sm=1 tr=0 ts=69939926 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=6MCoFBzevOMPZS9IYwYA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_08,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160192
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.30 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_MED(-0.20)[129.46.96.20:received];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[allwinnertech.com,gmail.com,vger.kernel.org,lists.trustedfirmware.org,oss.qualcomm.com];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.69:received];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: D6EE8436E8
X-Spamd-Bar: -----
Message-ID-Hash: 6XHZZHBPJJRYAMWXNHGJTLACNVSAQZRO
X-Message-ID-Hash: 6XHZZHBPJJRYAMWXNHGJTLACNVSAQZRO
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Michael Wu <michael@allwinnertech.com>, Yuanjia Yeh <yeh.ooxx@gmail.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/6XHZZHBPJJRYAMWXNHGJTLACNVSAQZRO/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Commit 70b0d6b0a199 ("tee: optee: Fix supplicant wait loop") made the
client wait as killable so it can be interrupted during shutdown or
after a supplicant crash. This changes the original lifetime expectations:
the client task can now terminate while the supplicant is still processing
its request.

If the client exits first it removes the request from its queue and
kfree()s it, while the request ID remains in supp->idr. A subsequent
lookup on the supplicant path then dereferences freed memory, leading to
a use-after-free.

Serialise access to the request with supp->mutex:

  * Hold supp->mutex in optee_supp_recv() and optee_supp_send() while
    looking up and touching the request.
  * Let optee_supp_thrd_req() notice that the client has terminated and
    signal optee_supp_send() accordingly.

With these changes the request cannot be freed while the supplicant still
has a reference, eliminating the race.

Fixes: 70b0d6b0a199 ("tee: optee: Fix supplicant wait loop")
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
Changes in v5:
- Move idr_alloc() inside the supp->mutex, reported by Yuanjia Yeh.
- Link to v4: https://lore.kernel.org/r/20260209-fix-use-after-free-v4-1-7c4c4b02368f@oss.qualcomm.com

Changes in v4:
- Pre-allocate request ID when allocating the request.
- Cleanup the loop in optee_supp_recv().
- Update the return value for revoked request from -ENOENT to -EBADF.
- Link to v3: https://lore.kernel.org/r/20260128-fix-use-after-free-v3-1-b0786670d927@oss.qualcomm.com

Changes in v3:
- Introduce processed flag instead of -1 for req->id.
- Update optee_supp_release() as reported by Michael Wu.
- Use mutex instead of guard.
- Link to v2: https://lore.kernel.org/r/20250617-fix-use-after-free-v2-1-1fbfafec5917@oss.qualcomm.com

Changes in v2:
- Replace the static variable with a sentinel value.
- Fix the issue with returning the popped request to the supplicant.
- Link to v1: https://lore.kernel.org/r/20250605-fix-use-after-free-v1-1-a70d23bff248@oss.qualcomm.com
---
 drivers/tee/optee/supp.c | 107 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 74 insertions(+), 33 deletions(-)

diff --git a/drivers/tee/optee/supp.c b/drivers/tee/optee/supp.c
index d0f397c90242..2386bbd38ce7 100644
--- a/drivers/tee/optee/supp.c
+++ b/drivers/tee/optee/supp.c
@@ -10,7 +10,11 @@
 struct optee_supp_req {
 	struct list_head link;
 
+	int id;
+
 	bool in_queue;
+	bool processed;
+
 	u32 func;
 	u32 ret;
 	size_t num_params;
@@ -19,6 +23,9 @@ struct optee_supp_req {
 	struct completion c;
 };
 
+/* It is temporary request used for revoked pending request in supp->idr. */
+#define INVALID_REQ_PTR ((struct optee_supp_req *)ERR_PTR(-EBADF))
+
 void optee_supp_init(struct optee_supp *supp)
 {
 	memset(supp, 0, sizeof(*supp));
@@ -39,21 +46,23 @@ void optee_supp_release(struct optee_supp *supp)
 {
 	int id;
 	struct optee_supp_req *req;
-	struct optee_supp_req *req_tmp;
 
 	mutex_lock(&supp->mutex);
 
-	/* Abort all request retrieved by supplicant */
+	/* Abort all request */
 	idr_for_each_entry(&supp->idr, req, id) {
 		idr_remove(&supp->idr, id);
-		req->ret = TEEC_ERROR_COMMUNICATION;
-		complete(&req->c);
-	}
+		/* Skip if request was already marked invalid */
+		if (IS_ERR(req))
+			continue;
 
-	/* Abort all queued requests */
-	list_for_each_entry_safe(req, req_tmp, &supp->reqs, link) {
-		list_del(&req->link);
-		req->in_queue = false;
+		/* For queued requests where supplicant has not seen it */
+		if (req->in_queue) {
+			list_del(&req->link);
+			req->in_queue = false;
+		}
+
+		req->processed = true;
 		req->ret = TEEC_ERROR_COMMUNICATION;
 		complete(&req->c);
 	}
@@ -100,8 +109,16 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
 
 	/* Insert the request in the request list */
 	mutex_lock(&supp->mutex);
+	req->id = idr_alloc(&supp->idr, req, 1, 0, GFP_KERNEL);
+	if (req->id < 0) {
+		mutex_unlock(&supp->mutex);
+		kfree(req);
+		return TEEC_ERROR_OUT_OF_MEMORY;
+	}
+
 	list_add_tail(&req->link, &supp->reqs);
 	req->in_queue = true;
+	req->processed = false;
 	mutex_unlock(&supp->mutex);
 
 	/* Tell an eventual waiter there's a new request */
@@ -117,21 +134,43 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
 	if (wait_for_completion_killable(&req->c)) {
 		mutex_lock(&supp->mutex);
 		if (req->in_queue) {
+			/* Supplicant has not seen this request yet. */
+			idr_remove(&supp->idr, req->id);
 			list_del(&req->link);
 			req->in_queue = false;
+
+			ret = TEEC_ERROR_COMMUNICATION;
+		} else if (req->processed) {
+			/*
+			 * Supplicant has processed this request. Ignore the
+			 * kill signal for now and submit the result. req is not
+			 * in supp->reqs (removed by supp_pop_entry()) nor in
+			 * supp->idr (removed by supp_pop_req()).
+			 */
+			ret = req->ret;
+		} else {
+			/*
+			 * Supplicant is in the middle of processing this
+			 * request. Replace req with INVALID_REQ_PTR so that
+			 * the ID remains busy, causing optee_supp_send() to
+			 * fail on the next call to supp_pop_req() with this ID.
+			 */
+			idr_replace(&supp->idr, INVALID_REQ_PTR, req->id);
+			ret = TEEC_ERROR_COMMUNICATION;
 		}
+
 		mutex_unlock(&supp->mutex);
-		req->ret = TEEC_ERROR_COMMUNICATION;
+	} else {
+		ret = req->ret;
 	}
 
-	ret = req->ret;
 	kfree(req);
 
 	return ret;
 }
 
 static struct optee_supp_req  *supp_pop_entry(struct optee_supp *supp,
-					      int num_params, int *id)
+					      int num_params)
 {
 	struct optee_supp_req *req;
 
@@ -153,10 +192,6 @@ static struct optee_supp_req  *supp_pop_entry(struct optee_supp *supp,
 		return ERR_PTR(-EINVAL);
 	}
 
-	*id = idr_alloc(&supp->idr, req, 1, 0, GFP_KERNEL);
-	if (*id < 0)
-		return ERR_PTR(-ENOMEM);
-
 	list_del(&req->link);
 	req->in_queue = false;
 
@@ -214,7 +249,6 @@ int optee_supp_recv(struct tee_context *ctx, u32 *func, u32 *num_params,
 	struct optee *optee = tee_get_drvdata(teedev);
 	struct optee_supp *supp = &optee->supp;
 	struct optee_supp_req *req = NULL;
-	int id;
 	size_t num_meta;
 	int rc;
 
@@ -224,15 +258,11 @@ int optee_supp_recv(struct tee_context *ctx, u32 *func, u32 *num_params,
 
 	while (true) {
 		mutex_lock(&supp->mutex);
-		req = supp_pop_entry(supp, *num_params - num_meta, &id);
+		req = supp_pop_entry(supp, *num_params - num_meta);
+		if (req)
+			break; /* Keep mutex held. */
 		mutex_unlock(&supp->mutex);
 
-		if (req) {
-			if (IS_ERR(req))
-				return PTR_ERR(req);
-			break;
-		}
-
 		/*
 		 * If we didn't get a request we'll block in
 		 * wait_for_completion() to avoid needless spinning.
@@ -245,6 +275,13 @@ int optee_supp_recv(struct tee_context *ctx, u32 *func, u32 *num_params,
 			return -ERESTARTSYS;
 	}
 
+	/* supp->mutex held and req != NULL. */
+
+	if (IS_ERR(req)) {
+		mutex_unlock(&supp->mutex);
+		return PTR_ERR(req);
+	}
+
 	if (num_meta) {
 		/*
 		 * tee-supplicant support meta parameters -> requsts can be
@@ -252,13 +289,11 @@ int optee_supp_recv(struct tee_context *ctx, u32 *func, u32 *num_params,
 		 */
 		param->attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT |
 			      TEE_IOCTL_PARAM_ATTR_META;
-		param->u.value.a = id;
+		param->u.value.a = req->id;
 		param->u.value.b = 0;
 		param->u.value.c = 0;
 	} else {
-		mutex_lock(&supp->mutex);
-		supp->req_id = id;
-		mutex_unlock(&supp->mutex);
+		supp->req_id = req->id;
 	}
 
 	*func = req->func;
@@ -266,6 +301,7 @@ int optee_supp_recv(struct tee_context *ctx, u32 *func, u32 *num_params,
 	memcpy(param + num_meta, req->param,
 	       sizeof(struct tee_param) * req->num_params);
 
+	mutex_unlock(&supp->mutex);
 	return 0;
 }
 
@@ -297,12 +333,17 @@ static struct optee_supp_req *supp_pop_req(struct optee_supp *supp,
 	if (!req)
 		return ERR_PTR(-ENOENT);
 
+	/* optee_supp_thrd_req() already returned to optee. */
+	if (IS_ERR(req))
+		goto failed_req;
+
 	if ((num_params - nm) != req->num_params)
 		return ERR_PTR(-EINVAL);
 
+	*num_meta = nm;
+failed_req:
 	idr_remove(&supp->idr, id);
 	supp->req_id = -1;
-	*num_meta = nm;
 
 	return req;
 }
@@ -328,10 +369,9 @@ int optee_supp_send(struct tee_context *ctx, u32 ret, u32 num_params,
 
 	mutex_lock(&supp->mutex);
 	req = supp_pop_req(supp, num_params, param, &num_meta);
-	mutex_unlock(&supp->mutex);
-
 	if (IS_ERR(req)) {
-		/* Something is wrong, let supplicant restart. */
+		mutex_unlock(&supp->mutex);
+		/* Something is wrong, let supplicant handel it. */
 		return PTR_ERR(req);
 	}
 
@@ -355,9 +395,10 @@ int optee_supp_send(struct tee_context *ctx, u32 ret, u32 num_params,
 		}
 	}
 	req->ret = ret;
-
+	req->processed = true;
 	/* Let the requesting thread continue */
 	complete(&req->c);
+	mutex_unlock(&supp->mutex);
 
 	return 0;
 }

---
base-commit: 3f24e4edcd1b8981c6b448ea2680726dedd87279
change-id: 20250604-fix-use-after-free-8ff1b5d5d774

Best regards,
-- 
Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

