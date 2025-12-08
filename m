Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217D7D1CDC6
	for <op-tee@archiver.kernel.org>; Mon,  8 Dec 2025 02:10:09 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 722DC4305F
	for <op-tee@archiver.kernel.org>; Mon,  8 Dec 2025 02:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765159808;
	bh=z+2zhT5iS1jtj/V/z+H/E0iOdnQsXlnnYnekDYlsgsA=;
	h=To:Subject:Date:In-Reply-To:References:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=5nj0amVMGDHXJCFRaFGt2rMO1keyF9OybjfPN2OTVtSiOyjiD9lNrgIWv+rbs1w2c
	 vdaxgQJICma+r21B2J91fM1U0wV9TXskUiH1ayjCZig+qzGWRFT7fAJwWKTpIkGWYk
	 SM2mBlrBQvFZRqkGlNYz604MBbk7awEkxfNCZGQ5Xk5zWAXTkwUEleBWdiXh2GlTjz
	 wE9TAVOubRoUPB8v3Vaq3oSuPPPkgXZna90NOkmnhHBAPTvVq9aSi2rsbUaTRwmcz+
	 FvKiBPJWNJzxqWG9yt1WfXwMbmqvB5pwMPYICqygihdHLXoTPhIl7c0nxD2mJmfyT+
	 SZwKcx4iT3R7Q==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A0F4C4305F
	for <op-tee@lists.trustedfirmware.org>; Mon,  8 Dec 2025 02:08:58 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PL2jIwli;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FsgJpf2i;
	dkim-atps=neutral
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B7MICaO2841664
	for <op-tee@lists.trustedfirmware.org>; Mon, 8 Dec 2025 02:08:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=6m4yBMVpghL
	dTE/9wjzkray31oVvX3/XX9CZj5B0m8A=; b=PL2jIwliV2RXmjsH4QVQoAjYIVk
	X8g8GNp33l4himfG/2q4djnV6ODW2oOJJaxh+OjcxLN+1y9P+b6K5+mPydLWVY7F
	U+5bl7pnj1AsKXhWek1x/xuoJED1IvkZeBLmPsvvmKV+/6oNydK+1u3/+/7sX0Nx
	Q0WmeFNZsV9NrVkYYtpCzyiGMZLiDqv+9jo0FA4gzCSP1C8pfImV0Tgb+Tq5rhH0
	cp3l833Sse88aX7ghnHAmwCczSR4XPZAKajDP2gcBxP5JLyBjk8vaiLDk75tXZZm
	4OgBZoBbG8yqzQDGN3BQn/n8sBubjEJLHTcUWVxB3+tB3DRZtbCMGzjcS5g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ava6fbhgw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 08 Dec 2025 02:08:57 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34385d7c4a7so2511431a91.0
        for <op-tee@lists.trustedfirmware.org>; Sun, 07 Dec 2025 18:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765159737; x=1765764537; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6m4yBMVpghLdTE/9wjzkray31oVvX3/XX9CZj5B0m8A=;
        b=FsgJpf2iUCffFxpRMLQS3ecsGPySYoYwi+ASsgGz4p/aQJl3IlQjke3XLKi4geGeE0
         aIQ+yf4GSICze+E/t8tdXZdbM4EXn4F3QUyDGuhUx7aXYZDSDhe0o/3GIZymL+hl2nd2
         PmAGn217iZxlJw6xuRS6M8eVO42sSe7PEikyGSHJjNJ1cxNw7Nr/S13d6exY4db5RYPK
         A9trIf7beKMkS4TzgQNPjG01o18rRKQbAuHNA/cxr9e6LaQl8YSD8BnvKhhPPRgVt6PH
         0GZw3L8M8tdrprWj9k7ZFAAx784ggcyvV7+EsicOeXsm5R0yBT2R7ubXfEd/qMtXaz47
         liEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765159737; x=1765764537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6m4yBMVpghLdTE/9wjzkray31oVvX3/XX9CZj5B0m8A=;
        b=vzJkaVdT32X992yXjVwqEtTP5XGMQIyhaBfN+Hm2LTCT6pztZhjO4ILxKI+Sn1xkDp
         KQmu/3FPf7Ve4Xrv7MgirND4YXo7VVxH4/bya4ZFZsKZ8xcchwQw0uZRnGGapv4C0U1h
         1xAc7YYePoOqPFUHeDDmNoCfn4OgrdwPCqYZkI4TsajUv+vULiCySfcNfO48WFtmIvxU
         OzLneVM6AXzvpKw4y73JO217UIrK5mgf1vkL3ABkUugVQNEkDx4Lu8OzyO6ZnzTrgzQH
         ccXrQhpkdaFsJvGbuR+KU31HA5JyRjcbFLFaP6xlTHpLt12Q788YsJx6BGGgwD/ZfW72
         6b3w==
X-Forwarded-Encrypted: i=1; AJvYcCVsfDfKbG0JWE8c7DsOm+tg5z90Msj+WFeZUFwZDQGT/XvHs/mvHK2un+NvdvmVke4SGNlYnX8=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YykUUL8jlZvCfOr9MJZnmwSZIXglHL4Pdtith4LS3LvmNnX90Z2
	PnrajUP7yZNkC9QENW+5OFdWmcx3H9CvCQ/G+SzGM9rfTh+xJIQE5vLpBrfNMeruagh9HoQqC1y
	fM0v5YxrGSclbKQ/bjBJtHhxk8PGxIC4uQT9kh+NA4MYl+TV6GUkaDOk3BY8aiO8d0tTit5z/
X-Gm-Gg: ASbGncv/ed4Skj9QEwD0nVoEX0+Rp9ge3hD8XtmPNSQWVdGASwKrRpnGVZanxTz4hU7
	YbYUlyrBMg5+JsUpfV15MZR8Umd9bV4ksBHjr4X54gLMbtoQ3AziLFucT9qTqpV8CkbzO3lOdmD
	C+JggkeDP6s1C+rXyKp8mT0cIvUmQp/4bbrB+mUm5zhdrPPZPTMszraHhoSpuFRU6Zw+RyWGXOi
	41VbNi4Icd9YJr5tJxB0nuN6a7ISzvKDzNzLGZSEnLOP8CgkjtVVbb+6moHc7hJfRYZxVFrEROL
	kIKDJ6Z31mOJ3uvsV4DEfGnv9SlSKIve6TRssADa/eZpe2p+ELhzAwhOSbMMtZ2sca3Lk7b9aT1
	1cE0rbzVXBKaMOo92kIwWUdboZIhvP6NkxDOVn7qsGHjheE6vcO//DP7o
X-Received: by 2002:a17:90b:48cd:b0:340:29a3:800f with SMTP id 98e67ed59e1d1-349439278bbmr12915951a91.15.1765159736936;
        Sun, 07 Dec 2025 18:08:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFNs1bJ6t1L3uGImiEkEaEt7oqJ8aG203beI/b1GtEUEXzHgekhKWgKsZH5Y+mzjJEEFs1ig==
X-Received: by 2002:a17:90b:48cd:b0:340:29a3:800f with SMTP id 98e67ed59e1d1-349439278bbmr12915929a91.15.1765159736445;
        Sun, 07 Dec 2025 18:08:56 -0800 (PST)
Received: from quoll (fs98a57d9d.tkyc007.ap.nuro.jp. [152.165.125.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34986460717sm6481676a91.5.2025.12.07.18.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 18:08:56 -0800 (PST)
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] tee: qcomtee: user: Fix confusing cleanup.h syntax
Date: Mon,  8 Dec 2025 03:08:47 +0100
Message-ID: <20251208020844.5310-6-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251208020844.5310-4-krzysztof.kozlowski@oss.qualcomm.com>
References: <20251208020844.5310-4-krzysztof.kozlowski@oss.qualcomm.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1966; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=z+2zhT5iS1jtj/V/z+H/E0iOdnQsXlnnYnekDYlsgsA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpNjMucd5+fOHWEMT3FrtBL0qR0/Lb7P8bQWjo9
 xx4Lu+vP2CJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaTYzLgAKCRDBN2bmhouD
 198OD/4vkeN8r1M22JTB+8VcOOxCRZZDeyFzB00INO17cwu2eeu3wpNJG55S2DYzzJ7HdqJodMK
 G5ZCUzL9OXHp6uRPS9OiBhGd3uITN9XA33VwTGBRCK9yARKOJT1W+yo8bhxUpGeyJt5UQkjZgpw
 aHMNmFKGV7Ois/2thVVhj86E67PdWN4CTqlTVJeGJyl+yWE6pDUltC1YUStTFRMOrKs4HXMRdGZ
 0/p7XVHr7i7rdCI0OMI9HK5Ib4T18mBbsefNiom4Y05YAdDgzsSjKD1k/ltkGCHTw+dFBh5sQap
 mWrbDo+qp9A/YdYLROpEn7s/QBYBwJClUm3JB/jSoOPw+OiF9FD4qiXqCcZdVUF8D+ffB47Xji5
 AGwg3+Z06qLPiR7hcusfiih31axYuEjfdGyzYufAXIb9mL+23Cp2MXWf2l6Ub3L67yPtuj6d79H
 GpxJg3B/VBRfbwRTPJTNSGODWKyJft+83JvX5wP4Ad6FenhxFmH1NoDa/O20+XMWXZpkbSfXbM5
 +Q/2bDCn2z35eGsqfUNzLs3MNeHddmYCIacwmNms4L3CCqayYjreRmb06g2p+CEAMet4S6iw/iq
 6xiC6DmnQN42Ca7F+ARSv4wvsA8JX+LRvTp6WL3nA3d5QmmOJ2OzJi+hyPXGIW5koh0Z5zhXeFD CJwz/rtck9EpiTw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: sd06S9hc5R8oe8inZqNp_esgeLmgW-p5
X-Authority-Analysis: v=2.4 cv=NYXrFmD4 c=1 sm=1 tr=0 ts=69363339 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=vTE1kzb4AqIx7XBf0Bkr0A==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=YPuPo_wWdk5lylyXwGcA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: sd06S9hc5R8oe8inZqNp_esgeLmgW-p5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDAxNiBTYWx0ZWRfX5/gJIB1npBFd
 tRRrV+xGH8TaZx0/zyhfMRi0tLYjhS2hVwvdURtMRnwkyXta/0OuIFvz4eyLbjnWVt5ILQPKtnL
 fXtc9sRVrVgcPLmti2JF9SUeZ5msN/mLwKoknyCBHMAEuKXSs84xMWuETWQBDvTBNFXw04qaYMq
 uG74eZjtscStlOY4nCFjlG/grow+8Wh6SmZwUwNtZLcG+Bp9nTog6zoAesduhepLOFCfTvywe5b
 vDg4HU+oubxefwSMV+NExKIVdXplrcyXYtgvpoiDtcg/OtzxjQlc1FIR5XhGopS3/Se1GfKebCy
 Gg2rcE+nt5THai5ecohfG+M8BlmuZKhLhGZTlKzuMwrDwp58pjFt9Hr6W+WNiWV5tV/tvfF6h07
 pkDGqJkSDpyZwSlTe6mJaKbs4yXSCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512080016
X-Spamd-Bar: ----
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A0F4C4305F
X-Spamd-Result: default: False [-4.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DNSWL_BLOCKED(0.00)[205.220.168.131:from,209.85.216.69:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
Message-ID-Hash: 6G2E27WUCKPXYRXEGF6ZKADWH2QQXJCH
X-Message-ID-Hash: 6G2E27WUCKPXYRXEGF6ZKADWH2QQXJCH
X-MailFrom: krzysztof.kozlowski@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/6G2E27WUCKPXYRXEGF6ZKADWH2QQXJCH/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Krzysztof Kozlowski via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Initializing automatic __free variables to NULL without need (e.g.
branches with different allocations), followed by actual allocation is
in contrary to explicit coding rules guiding cleanup.h:

"Given that the "__free(...) = NULL" pattern for variables defined at
the top of the function poses this potential interdependency problem the
recommendation is to always define and assign variables in one statement
and not group variable definitions at the top of the function when
__free() is used."

Code does not have a bug, but is less readable and uses discouraged
coding practice, so fix that by moving declaration to the place of
assignment.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/tee/qcomtee/user_obj.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tee/qcomtee/user_obj.c b/drivers/tee/qcomtee/user_obj.c
index 0139905f2684..6aa3aefd67f0 100644
--- a/drivers/tee/qcomtee/user_obj.c
+++ b/drivers/tee/qcomtee/user_obj.c
@@ -228,10 +228,10 @@ static int qcomtee_user_object_dispatch(struct qcomtee_object_invoke_ctx *oic,
 {
 	struct qcomtee_user_object *uo = to_qcomtee_user_object(object);
 	struct qcomtee_context_data *ctxdata = uo->ctx->data;
-	struct qcomtee_ureq *ureq __free(kfree) = NULL;
 	int errno;
 
-	ureq = kzalloc(sizeof(*ureq), GFP_KERNEL);
+	struct qcomtee_ureq *ureq __free(kfree) = kzalloc(sizeof(*ureq),
+							  GFP_KERNEL);
 	if (!ureq)
 		return -ENOMEM;
 
@@ -367,10 +367,10 @@ int qcomtee_user_param_to_object(struct qcomtee_object **object,
 				 struct tee_param *param,
 				 struct tee_context *ctx)
 {
-	struct qcomtee_user_object *user_object __free(kfree) = NULL;
 	int err;
 
-	user_object = kzalloc(sizeof(*user_object), GFP_KERNEL);
+	struct qcomtee_user_object *user_object __free(kfree) =
+		kzalloc(sizeof(*user_object), GFP_KERNEL);
 	if (!user_object)
 		return -ENOMEM;
 
-- 
2.51.0

