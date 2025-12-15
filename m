Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8826ED5B876
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 23:12:07 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id CABE44FEDA
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 23:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765840326;
	bh=9mOXI8QC1AqpHbGM6zt/JfJr3fh2o/pCGCDLcVW75h0=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=NLZP5AVhXfkURp2az6SHSRsIXtocg80QzypVU4cV4nog7KL7bDDABHFeEx+7wz2Bm
	 AlBxKE0nFdDOd7JP34kplKnLr8spPk8c587bE+Oq4McROGP2hLe+K4Xjqt6Jlin3mp
	 W4Qxh0aJu/NEWLT/fCUzLpiIXSKPnZ0a2NKwJC6iU3F0yg78G7e2TtA47vzsQQ9RPx
	 mFcqq9CpqPLE/gI6cZ6bKAlcekxfikXmA/7lQWBF7qu26vpA3bopOF035D8nTzGACT
	 E4sr8GytuivuJN38lTXV8B4Bt1DxNszcArxhhbKTTaIdxrEc1mDChrnVI+ex7brToU
	 ZmofUk8xNeJDg==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7833B4FE9B
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 23:11:45 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IZ52vt1O;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jlx4EMCo;
	dkim-atps=neutral
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFGjgbu1825473
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 23:11:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9mOXI8QC1AqpHbGM6zt/JfJr3fh2o/pCGCDLcVW75h0=; b=IZ52vt1O7GbRGxZu
	lel5QAK0hybX00it8t69gxD0F7mnx4QPZ3B+kbXA/rI20xX1m9ErEW5R6pgQA4Uj
	wCJJj7udaLtcaKT4YO057G3vSTVIESUcl8OVV0WXsuhTzbqaA2owK7RHkKWb26yj
	jisMFLSZmsVzmC9SOrfkeNXPFHdF1I3lXfyyQUMVy1fndiLe77rNCOKYFtJewORX
	CQudnR5ELeWdRZwvBB1sxj1UucYCHx5BYqXgtDVDj/XWaRDR+TaQs2ZE5NKGDsV/
	UJiWpVLrLYGCFuuWJ6xWNcLxj2UXfqyB6TDwFvmfN9hYPoAhEKQHWb46kvUHhw1v
	f5Ffdg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b2p4f13ax-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 23:11:44 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b99763210e5so7678687a12.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 15:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765840304; x=1766445104; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9mOXI8QC1AqpHbGM6zt/JfJr3fh2o/pCGCDLcVW75h0=;
        b=jlx4EMCou0N0O5hGukp4FnC8Zwi5QYtHE52vb8f6LITYxQ+WLKKgVIVujXlDk4a0QT
         UeXsgt0bSG1t9HWf3Vz4PyhJMrg9lasE/2LXG2We+3ki1JLtbd5OvOr9SclDspfwdcq7
         vL7xCPP1xRAV+IejFRlMjN5bQDtp/qM8gL0mmcUWA9MWx4ctK/rb6SLQ4N6s6hORIy6R
         HGt4Vek6VlwH0+ZVNfVmi5ImEZwl4X2KonOu/DOQmk1z4rEYThkdx8WyYrVlp73uurlS
         06zVlvXRxsQ77uU7VFSj7jFWsof4AULE+wxfDzF7OtRC5V51jY798XSvoUffYHKMDoTX
         YcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765840304; x=1766445104;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9mOXI8QC1AqpHbGM6zt/JfJr3fh2o/pCGCDLcVW75h0=;
        b=HkLysZdgSxvlk1p3WFykzMDPnFLmNd2+SQPKqqhhCxGaS2Byq6MzW1pNj+OrH2p3Os
         Oo3dxMGa4NcFibujDhp4wHn0xa8DUgfhmzyFrwaau8Aky2hkkP6kdHO2X+R668k1KVMK
         N8VpDhcYGi1EVwcLZPh2eNbtjqjserlTrBXuFj6UaWKGVqjlVZWluOgFalFLhXMq3j5t
         EFHwNDvHtDJ4C03cCPHbkBqihVa2t0qARdzniiMmZS/chGWSSYRnDd32Hce1aSKSzgfU
         s4ZZhSAnbc6A4FWYhjgAiE1QvMIPY6N93xzDZWkg5SNsyol3UmVLXHNTeHKZvPxbZT6C
         q0Pg==
X-Forwarded-Encrypted: i=1; AJvYcCUHanQRHheIepPGihFJbgjQuzX58/gq6Rg1fm41CTsawFiky2ceNrVx+yB5hrGXjDIsER5kXi8=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzViuwIJ9CssTPCweHqQh7zCyAde04TPBW/InnBUING4Ja79wYf
	7BIECwnvkAbNLlxB8QgJVsNyvFzFuqtulT78kPfM5iWIzGDci+uuf0rUKxYfDI40YO4R42qNyl0
	wtMBNf7shCEhgD3fa10+Sf0FzDtms1a/8AxsODcRWgXOSYUiJOIqNteTBxA8gMJpcRX0awndc
X-Gm-Gg: AY/fxX60jt0mBG4NVORBOiIPMeyc8XfQgLF064XOUyV0XdXoh4S9qyyP2CtoYlUQZyv
	k2iAo7jA35WXMJhaCVjSLq0bvrty3ooVKXrpdIVj2XHrqrvxYS9y72kCTrFQvIJp+O+UOSZQF4I
	zb7HMz0KJnmGM3wJuDjFYWjhKexRypuDSe8pj+vwpsigmNk3e6J6HzPE28iwS/FkiG4MZMwcnrU
	pHSJhh4gtbLl7rhHlJcgTw6etbgwyTpzzUB4YyGmpc70ChiIwaRXpcJjcfcN+5O4/HuSV+maW6g
	ljFLvtMVt6uMr5kQSq+EWJDT3DUkWcoT4jUyJ1rZuWJ5imlafDlc3CTWJXixG7XICSAYQiU+amG
	5Ptw9+hD1mTmBPbhT0i6kEctwLpihsQqlBov+2V1m5Oo9Y/ICu7uvwjIPBSoyTDM7Lvdbrx7MEu
	ft
X-Received: by 2002:a05:693c:40d0:b0:2ac:2480:f0ac with SMTP id 5a478bee46e88-2ac300f6569mr7656632eec.23.1765840303796;
        Mon, 15 Dec 2025 15:11:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGWd9bZdX9FqE4Zu9kudeOlBTu8WHuiZEe4iQU/7cEpax6mK1X2xvTe73Hi7niTXG2c7K7BA==
X-Received: by 2002:a05:693c:40d0:b0:2ac:2480:f0ac with SMTP id 5a478bee46e88-2ac300f6569mr7656615eec.23.1765840303310;
        Mon, 15 Dec 2025 15:11:43 -0800 (PST)
Received: from [192.168.1.3] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f43ced319sm15594685c88.9.2025.12.15.15.11.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 15:11:43 -0800 (PST)
Message-ID: <178f4564-8b59-4cf0-8274-dba7e58ba596@oss.qualcomm.com>
Date: Mon, 15 Dec 2025 15:11:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] tee: qcomtee: call: Fix confusing cleanup.h syntax
To: Sumit Garg <sumit.garg@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20251208020844.5310-4-krzysztof.kozlowski@oss.qualcomm.com>
 <aTtn-x0hh18V7n7J@sumit-X1>
 <b29c97cd-cade-40ef-8e6d-d164b1d16059@oss.qualcomm.com>
 <aTtyR5J3AqXoE7to@sumit-X1>
Content-Language: en-US
In-Reply-To: <aTtyR5J3AqXoE7to@sumit-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ylG5xZgzP0RSkLzjwpdXDa8O_RGS4m71
X-Authority-Analysis: v=2.4 cv=OK8qHCaB c=1 sm=1 tr=0 ts=694095b0 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bC-a23v3AAAA:8 a=pGLkceISAAAA:8
 a=AIc35tNdPba7fq3S6GQA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: ylG5xZgzP0RSkLzjwpdXDa8O_RGS4m71
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDIwMCBTYWx0ZWRfX4UCXQGW5t5to
 pTmN3lFKQdLMkua+VJ7+w9PiUrRwRXXzygHQuD5jVsyeoxsU4XboWhT26yN/7jw1pBoMtdtyRwA
 TyWsPPEj1aYaJYA+XKKpF0a5/qFABy5ujdGHDf5jxJiM8PB3hn8pvqSGfr4KNof2s+ZpcCKzzzJ
 OXJCi+0nLo7z0ZN+v/59GTD6CbEZ742fAK5c7cqM6pdPQgqiHbDWK6PIcx9Wo2todKfFCotqOUK
 gPfLI9RCuNSxWKHdSFrR8iY0jzFW2npLHJw9zIacPfE458HCX3+FS4JiEfL9XTvsReoN4zGVjv5
 9AlgaSDpIYRRF+XF+4mGKrrDBN84JSnyQoC4IJUp4DVLPrF/hH6pX4QqBuB0hX2dnSToVrmbdzf
 pcVrhQbNYbCrOtGViY2pmB4owqj1Gg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_05,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1011 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512150200
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.04 / 15.00];
	BAYES_HAM(-2.94)[99.73%];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	BLOCKLISTDE_FAIL(0.00)[209.85.215.198:server fail];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.198:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 7833B4FE9B
X-Spamd-Bar: ----
Message-ID-Hash: SLLZQBTQS2L3FTM6ME6A2XFSQXMWQ5KM
X-Message-ID-Hash: SLLZQBTQS2L3FTM6ME6A2XFSQXMWQ5KM
X-MailFrom: jeff.johnson@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/SLLZQBTQS2L3FTM6ME6A2XFSQXMWQ5KM/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jeff Johnson via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>

On 12/11/2025 5:39 PM, Sumit Garg wrote:
> On Fri, Dec 12, 2025 at 02:07:40AM +0100, Krzysztof Kozlowski wrote:
>> Sure, fair. I just don't get why introducing cleanup.h without actually
>> accepting its explicitly documented style...
> TBH, it is likely overlooked during review of the QTEE driver. Having a
> builtin warning for the undesired syntax would help the reviewers here.

It is in the works:
https://patch.msgid.link/20251203-aheev-checkpatch-uninitialized-free-v7-1-841e3b31d8f3@gmail.com
