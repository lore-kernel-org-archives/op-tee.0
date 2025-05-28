Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45034C3ABB2
	for <op-tee@archiver.kernel.org>; Wed, 28 May 2025 23:48:05 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6A09042FA2
	for <op-tee@archiver.kernel.org>; Wed, 28 May 2025 23:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1748476084;
	bh=SwrwpC4n9/pBKcWA5KZ7qHFzQtSNq4wV7YWuKBDhOKA=;
	h=Date:To:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=VoEdlZ6/D5dwBaM6x6MH2KKLKnFOLtH87rJi1urA1hMEG+8mVDfNy/Gq9oEakiR1p
	 PNv3qYH2D+S7S/eTJrsxa944k9sosWSq0AyagnSNVh3Do4qJ8PNdSaC+VlhgYX4D0y
	 xDbfsxaRYlSvvp+Lbevro7GWY4a8aNxEBHDqCx5QqzvqB9Hd0bhETrgt6y5KyfESk0
	 vq7fJnhKPdJnkQQN+OuUaPOz4xihShOshiJ3ve9puGI4pBFd71lCoOxxkCOT8B5DM0
	 x5NP1gO3qfxvq3uUbub1eyxR1arZ4zaCSNeftrbRi1PGmb/JrRCj2g7EMW0h7P7zQ6
	 vUBDTt2lOT3xA==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5462342F84
	for <op-tee@lists.trustedfirmware.org>; Wed, 28 May 2025 23:47:46 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Cz6TBoZO;
	dkim-atps=neutral
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SFgL6t028888
	for <op-tee@lists.trustedfirmware.org>; Wed, 28 May 2025 23:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=A9fC4RyVuE5PHwCBJXl9z3
	P6edX+uln6BjSySgZwMO8=; b=Cz6TBoZOxdtkcjjY3R4fgsYq/7P+31E6f7JuIr
	0vBzz/338TFVLx3UdXWh2ca30G5BBnv5c0NyuUGtIclT1MpvSQzmNcfcqCrZj6z2
	i/gyfgT/tthxiMecf/i7nPbMm8/S0Bhu0nEQP7LRqrsHznUkO6PEv4KoP/DsbARu
	psj6UwFiY6M8lIfRUgTL+Nd67I4lq1xB+DtqEAqZQsWXwt/u/l/iCI1Za8nvbJNN
	NejSoCWFLYzDbDNrx76qN4Dm2V7EEr94j8qg64FEoWaoj2cJInPLE804WR8n4pW3
	/Fx9UVzqjCpdRG58pOuod5WhIeZ0wvs4ACi5BR6ysrNLxJJA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46whuf484g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 28 May 2025 23:47:45 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-31215090074so456430a91.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 28 May 2025 16:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748476064; x=1749080864;
        h=content-transfer-encoding:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A9fC4RyVuE5PHwCBJXl9z3P6edX+uln6BjSySgZwMO8=;
        b=WAJqxOISWvGHO/ybKIVusNkzR3P5O/XhBNxYHQssWktM7M+e9ClCxF6Iwyx2xecZnm
         lOFoI2D5pynZbYxeqdU8f8SXdbBQCB1ojzIoisjyUbhJL0CVbG6YHjXQ8Zlb/5ON9nma
         p+w8GUwKzKFfVDfp6PK+FmpH/0Bebc+fJ4P58PEZc+2pynYjbNNTZmwpfrhK2EiNjAVg
         Zi3B2dT6x+Dni+y34JnA7+8yoa0vQNIWWNIFT0RSVSpWOQnOx6h57lReElzrVTXle/XE
         A7921J2EdC+zgZr/qJt0dC8s4MMPbzRf2CQYHq3efNqlrgJO0bCt0i8HtsUpysj8COh+
         gEwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx9eBgirQFF1Ud4ZSc2VNEH0+qQlooK3E3r/dX+DYZnYFeUeLq7gnx0EfhaOaxMr0VomjxNmY=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxDU/12mNX4isF8GnMMEjHR2rHd8iHOggm2la8UrJ+F5uTCcT83
	URH0/n12vEN/EXgcPpl0uwItsLi4jBDW9zGLAMoce8nPXMca7imxAig3NZEyRV7dRyozALgbtEW
	UzMjHu5lQszRjjmjK+UZhGfU0Cm2eIe4ln7utWpyIB3lzgpLNoki0T9Vkv/l8nxk3dnixj+M=
X-Gm-Gg: ASbGncvgLcEWkFK2hgQ3c8yTzDWraqpcnKlZDqPsY+NRdcSlS0elHMp+fqvMm/DY7Yu
	EPctulRo6ualuKUTmnQ7E+GwmJ2gBnqv8Uimx56poFvycllWgmzVYlbsAVJe3yLnWsHE4KMdhus
	ZWi6TnAyxB/Es+s66m6fxgHH8QxwJtcPXbpOdwCsdhRPqsCXPWm5FSnnnyuAVFfmhOPUCMSnnfH
	LX1rlI98cc9v6vFkAvcEP1wm0iSk0y5bWXL8eQVFHcyx3yM+mjqF82vuf2Vi0E7zHE2wcIsjkOM
	WAetuI/LboMf2KfKT6GL1oXyeAKWuobu5aJu58UTYkkmSxnw8ho9Ylzkp4IrVDaX4jEZSoJHt39
	E3Ah+ekVLbQ==
X-Received: by 2002:a17:90b:58eb:b0:312:1d2d:18f4 with SMTP id 98e67ed59e1d1-3121d2d1a8cmr444642a91.0.1748476064180;
        Wed, 28 May 2025 16:47:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGe9GyhXVy6Q3nIcnIHlmeYQWqVmMt14nGF8K/dE/0bU0Cwnni92CETvlqQIaHw7XbLOIXILg==
X-Received: by 2002:a17:90b:58eb:b0:312:1d2d:18f4 with SMTP id 98e67ed59e1d1-3121d2d1a8cmr444610a91.0.1748476063829;
        Wed, 28 May 2025 16:47:43 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3121b71c5c5sm204899a91.17.2025.05.28.16.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 16:47:43 -0700 (PDT)
Message-ID: <11fff295-0e06-4865-9d7d-f8ed2876de87@oss.qualcomm.com>
Date: Thu, 29 May 2025 09:47:39 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org
Subject: Issue with optee fixing supplicant wait loop
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OslPyz/t c=1 sm=1 tr=0 ts=6837a0a1 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=NEAV23lmAAAA:8 a=U_ryie5L2X8KJgBvXBAA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=zY0JdQc1-4EAyPf5TuXT:22
X-Proofpoint-ORIG-GUID: BagtMdBEjvFzRxaYSJEjTxZYgmejXwuJ
X-Proofpoint-GUID: BagtMdBEjvFzRxaYSJEjTxZYgmejXwuJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDIwOSBTYWx0ZWRfXy/VTBM+Y2gi4
 8wVOGE1XmF/WU/8pzY4sMDxJ/PkaVVE9nJlPTo81Siqnu97TU8fgKS17jfWD0TfsBH9bBA69JuQ
 QjpCb3CbGWF5PdTyvGR8PCBpazgSjuw11Ui8M6dORET48elirtLdPJNbl4+A0QYiZIWVe+QFXQG
 PyiCcTSh9REbGSqCH6BrUuTAR2FXj/pstkYprdhdKyi68x/6tlANgLIxM6GvjuXwQjAJXoxGp8x
 5/xPkQ9eHy60K59Dh58zkOYYvpmCEakNhOelbD5ApR3pKwPLBKaDxnDXTKKHWbi1heXVOgY0zz6
 LXE1oFaSHd8Bmhjb3vC7aimpXKbBMVPsv9CpE1YJbehfG15EMHGNeZiwK6xH/9KQrQX/xo82Prt
 GSCbDN36pYI31Caci0t4j9wY/uneqtoWBzXWsZe4WVNTSoXNtIXMpFchOnZwBLc0rJqzKfhm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_11,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280209
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.98 / 15.00];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	BAYES_HAM(-1.88)[94.30%];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.71:received];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[205.220.168.131:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 5462342F84
Message-ID-Hash: IBFRHOQUG6SPNFDLKW3PDHGPBUTFUGKM
X-Message-ID-Hash: IBFRHOQUG6SPNFDLKW3PDHGPBUTFUGKM
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/IBFRHOQUG6SPNFDLKW3PDHGPBUTFUGKM/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Hi Jens, Sumit,

The following change has recently been merged: tee: optee: Fix supplicant wait loop
(https://github.com/torvalds/linux/commit/70b0d6b0a199c5a3ee6c72f5e61681ed6f759612).

This fix addresses the issue where the supplicant may terminate before the client due to
the shutdown sequence or a crash. However, it introduces a potential new issue - now that
the client is killable, what happens if it terminates before the supplicant?

During cleanup, the client would remove/free the request, while the request would still
be available in the request idr for the supplicant. Although I have not been able to
reproduce it, this could theoretically result in a kernel page fault.

To address this, there are a few options:
 (1) Use rcu and access request under a read lock in optee_supp_recv and optee_supp_send.
 (2) Reuse supp->mutex, ensuring that most of these functions run within the lock,
     even though it may not always be necessary.

Could you confirm whether this behavior was intentional? If not, I am happy to
prepare a patch. Additionally, please let me know whether you prefer solution
(1) or (2), or if you have any other suggestions.

Thank you for your time.

Regards,
Amir


