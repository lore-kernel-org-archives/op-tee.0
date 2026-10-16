Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1470DCCA462
	for <op-tee@archiver.kernel.org>; Fri, 16 Oct 2026 12:56:01 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4C2D04528B
	for <op-tee@archiver.kernel.org>; Fri, 16 Oct 2026 12:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1792155360;
	bh=wYA6+QG4gqtKsAXq1l8c19NwZl8PIpQBydrd2KKUXEg=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=AREHJIfkCSyVTkzN1hCnfF01Kj7Oiusl7+39Sc/PFri4gBPu3slMIVRrMRFtok2gg
	 MUBLGMUp+kuOYlQZ/kCtDwFQ6Tt/n2knNJHmQzeh6Uuwa9sB3H2jclHnaX8PgX0UTm
	 lBX/MdjXSoaGswUlX6g4bjMnPxnxz6h2BP5d8eR88JVMtp4pjvcxp7c1HMfLCNfh3d
	 Gh0Cid4FhzPzZpzdWud7QHClS5mf61ErIzENEriDBU1h1pcWP0ArhtPi4lAMt7ROMg
	 55IYW2CnYcQ3fNaU00y4t55RlA29TdiqEUo/2yvzycLthqrDo/fRHLi4cP0JQGAiRE
	 pRoYRq23nKCjA==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6167445340
	for <op-tee@lists.trustedfirmware.org>; Fri, 16 Oct 2026 12:55:35 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JPrvZbRD;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DpDNXjXE;
	dkim-atps=neutral
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GAAL44488576
	for <op-tee@lists.trustedfirmware.org>; Fri, 16 Oct 2026 12:55:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q3YW7DvRD8yt6RfBklKs77Vve2cfD+JOKZ+SXC0k2aI=; b=JPrvZbRDIGXb6JGz
	3WVyb/mnYH58OAhTU6zQwLuA6QX1Wa17NYSkB1FpCmwmyxTZ0QWoYZuonkKkDHy/
	kVRL4lh0jb9HZ3R0rABNIaPC/U4qu05pgRI6BzPiqbocG2sZbKWcUOhaAtTDzeU9
	cAfLGGwVg5WKtlQqt2zY3nye0S0esCmHLzuzLCfmVePfMVbwkANyWKO2fUiBh1NK
	pRSIJybFladMyQmV4VFD5VeNrWY2PstZ0KPL6shcfe5wxzf+1Lh9Fsypda795xrz
	K7khOwhtYdCJoYz0xZ5jReywFH8np1rxz/5vBI0bKHEx287xXp2qGLoAIY5AuQdO
	WVB2tw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbcjt9w5a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 16 Oct 2026 12:55:34 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-35fb6be0f9fso3662451eec.0
        for <op-tee@lists.trustedfirmware.org>; Fri, 16 Oct 2026 05:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792155334; x=1792760134; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q3YW7DvRD8yt6RfBklKs77Vve2cfD+JOKZ+SXC0k2aI=;
        b=DpDNXjXE9Ig8pKHbKSfeEI8wOJYh5lVEbkcEOimmTrzE96xf5x+/wmluthGQ62m32g
         KquZedIr9T8ff8S0DVabgW1KJNSr3CinxAs63ktQMd7P8ZtF2p6YvOH8sXi/bpWEkBWf
         LbnoT/iVWl6LY098qjp1wPJjuFTwlAvp3nvwudYWBeUN/K+NL8CPflWAFbPcJQHLlcHM
         C5NJi3+4Yn++0OFssLDMJh3ZOpkiQXGy3RXvcyU97gLIw5vAiKe/njwyuuxasr6ThMBr
         NpBbDgAAajKfkChvSOZLDN70a9bV5J9t8QAYhEwF+PpRszwCbcidWC2eZ4SYyzeehrhY
         YTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792155334; x=1792760134;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q3YW7DvRD8yt6RfBklKs77Vve2cfD+JOKZ+SXC0k2aI=;
        b=Gt6WaXl2eZtz+VYS27FKOIvDfnSaLGUlmi5vHG4M2e4TZFHoTn99XeRKllkdNcNLei
         1hKR8JC3IgoGggzsmdlydhx7N/DkgNbYxxWSoUyM+EaQYy62fZEzKp0sX663zajNA6OC
         Wm1VkNiHjXY7IXRv6bTxw+rBJvGpxhG7d9FKyZjA5Bmmlh2qjuXQmusOLp0oadszY+ZI
         YFMMopWaTgLqtszGbPMK+67r0XL0efBD+NxTwojm2AttNsShMIXc/9Xa9hY32gBUI5Kk
         JqIwczzwv4myIL7lP7aP7Lqfcagf66cC2EB4yuIMAjN13vJrUj8iK8LV2s+uztt8VPBM
         7D8A==
X-Forwarded-Encrypted: i=1; AKwUvBxug8GvJSKLx5Sk8tZn0TTwwWMeYLnMW1KDnpTufQT4P9hwq59G1bKm2s9def3m8vx+uVq1aUw=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYKqiJlG0S6f7Q2RjTTk7oxBy/YxdWA+mGtDoyj1z2hwkVLl4OUz
	Kt+KBRjIM/djuv89PnNYRnuO8NJb6RQE32IMKoJRt8fkB6Fy+hyKp7eI2Sl6ZBsVPe+d+YDMBsp
	IsFE+087pB8Z+CTzPD5mHU0zXYB2isXO+k0sLWxKfpXusH+QgUdQAoDSCmmZBSUUbcFnpoo5h
X-Gm-Gg: AYBFou1BrlhSKeTcAzJ6S1E5Zf0o9ge0leADmiEYaif9jf2RrP9pU9N7D2jhPtF+HGw
	H14u21OePJZIyuEBrWgNHe0vedibTP++NfznY/7yltDizDOb7OPmRGbFTt8CLobmo5jeeUn+QRx
	zjbgOx5spVuqkOPyw5Mvh5fNwyU1GQz55TrTrhC/njYWQkiz1PPgygS9AG4PPnftYJgUs2pyzCN
	k9s8KUScosaSHPMnnGNM5seeFOzVQb7c5yvgCRO+apkcrd8hS7kHNoThstgZI+U1VkyWDL9IC96
	8b3Tmpf5HRQRm83sIgs2vj5giB49mi2QEYFwm53+6yProyepAlLeKRU1btxqUFq7bhoprlGE4ac
	RaT/2qEPdtkB/l4APbZCsBJc7zeccmw==
X-Received: by 2002:a05:7300:e9d6:10b0:359:bdc8:c9d5 with SMTP id 5a478bee46e88-359bdd83104mr26473235eec.21.1792155333481;
        Fri, 16 Oct 2026 05:55:33 -0700 (PDT)
X-Received: by 2002:a05:7300:e9d6:10b0:359:bdc8:c9d5 with SMTP id 5a478bee46e88-359bdd83104mr26473199eec.21.1792155332766;
        Fri, 16 Oct 2026 05:55:32 -0700 (PDT)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082a7b33bsm13434921eec.24.2026.10.16.05.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 05:55:32 -0700 (PDT)
Message-ID: <796d1de8-9c1c-426b-93f7-eeb417390f66@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 18:25:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/7] tee: Export uuidv5 generation for TEE backends
To: Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20261015-qcom_uefisecapp_migrate_qcomtee-v5-0-1460691b35d3@oss.qualcomm.com>
 <20261015-qcom_uefisecapp_migrate_qcomtee-v5-4-1460691b35d3@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261015-qcom_uefisecapp_migrate_qcomtee-v5-4-1460691b35d3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1MSBTYWx0ZWRfX8OmOXLyVlvUm
 fjzy3NHxDpIl0rcJx4Hz1j+iaubHdWP4GRgX/lv50ezGBRUgSnSnAWx9rimO2TY3PaptvBOFZOe
 DmxisU149x2idThXUonwLYtC0wyUPyOPTy0rdQMzHQXWoPkO23ii8m2FvI/dOPVG3hj5pq9hb/W
 Q7P+kOyQZua5B2u3y7WiVVsf3lYhA55V+iKeesBBNgHH+Xi/BCdvDxVC45409fmbLtZ8/wM7poO
 JBNgFtWw5LySKVXWOYJWN+SK1+yBwPopdx3jR30MN9kUoxXHm5I9Jm1qDOZNl8g+jWY1O59/5el
 zfsushr+sVGZ3oGoQgtYGvyy6kQ6obNvHppzXkcjrrITpNcvrp8RFsfHylOS8nqdfCyrc1zrhNM
 0BLu09pSr/jPEt3Bg3gvvFrvL+IHjtd75a09Y1vLoGiDk/tpIUQ4ntgcClry0/RBzIvp1LUhObT
 ORnN4PiLxcHdYYnlmhA==
X-Proofpoint-ORIG-GUID: 9O1OLZpf1fybU2LtzyR64BdcdWl-9CSU
X-Proofpoint-GUID: 9O1OLZpf1fybU2LtzyR64BdcdWl-9CSU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1MSBTYWx0ZWRfX35LfdLcZfHWL
 VxHN6C7utguLnIEZJ3Dv1Fyk1RFpFJSD+BX10T+FxIc5M8mLQId2YLkbk5bkrLcxNM7M53HkrP7
 EVpzZmIHt9qYUve2BVERtikLucP2+I4=
X-Authority-Analysis: v=2.4 cv=VpS2kO2n c=1 sm=1 tr=0 ts=6ad21ec6 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=wUKrATpdGnaYG2FsxpQA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610160051
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.87 / 15.00];
	BAYES_HAM(-2.87)[99.44%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.198:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[205.220.168.131:from,202.46.22.19:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 6167445340
X-Spamd-Bar: -----
Message-ID-Hash: FHORPOU4RLW62HEQOR5HQXTZKKJXS6H7
X-Message-ID-Hash: FHORPOU4RLW62HEQOR5HQXTZKKJXS6H7
X-MailFrom: kuldeep.singh@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/FHORPOU4RLW62HEQOR5HQXTZKKJXS6H7/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Kuldeep Singh via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

On 15-10-2026 17:09, Harshal Dev wrote:
> Export the uuidv5() function defined in the TEE core to all TEE backends.
> This enables the TEE backend drivers to generate a UUID for identifying
> and registering their secure services on the TEE bus.
> 
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Reviewed-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>

Tested-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com> #on Glymur-crd

-- 
Regards
Kuldeep

