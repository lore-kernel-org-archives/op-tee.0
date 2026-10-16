Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1ACCCA462
	for <op-tee@archiver.kernel.org>; Fri, 16 Oct 2026 12:55:01 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C766644F1C
	for <op-tee@archiver.kernel.org>; Fri, 16 Oct 2026 12:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1792155300;
	bh=x96yRi+rg72nO2L3bIVmQsQ6SzwyjfTCHUgMt0kpwJ0=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=NunWTe435RDXo2vrP/ClLLfRSKeEt7ZtBAk1oQrCc7k+fuEAR5eEzFa+9jH8X5GUb
	 vxetQLgJ5exiZKlXETWBi81NNvWpwIn5haapzAeUD73sepL34NWnHj+HQVQ63wfuju
	 WHGxs3bhDzKz5tf1DqZb+KthWZFJgr+Lk1u/n/y8b/GG68Mc7/DgtbGQSaRcqgyjHv
	 vRzZtanYD31Vt1I/dtGbPIiTBaR7avl9YPS2y/Pa8Hbz6pymjfg62tRr9kzy1RvWM6
	 Ktk4pNGoOswpJJmVXkPH/HHGrrgE8SAugeBh8KJ668h22EuoriyVB4gxGxBq7Ao4ki
	 3AyNP3vvrVL0A==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id AAB6E43A5F
	for <op-tee@lists.trustedfirmware.org>; Fri, 16 Oct 2026 12:54:42 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TW+N774G;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DOR02AI8;
	dkim-atps=neutral
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GAASui3069362
	for <op-tee@lists.trustedfirmware.org>; Fri, 16 Oct 2026 12:54:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XO8v3O2VsXW8MiGFrpI6qTd/A+X+oiAypVl/y9s5AYQ=; b=TW+N774GsmFf3Ae0
	R7RfnvUC0izCPo03cn1m4VU5C4hu2AjW/+vvrKO6z7PGzPfOn1RwjjmUXCnCCgh/
	JCyZ+o52FRf25aAt33f+zlYKY14XDelzPEAKeWdrkg57oNUtZSvsMlwD41ZKnsDc
	NGM/gdCtmdUhJPL0ULfEPSUnfXw+SegxQWkhUBkFLTRiKurA+i67pz/nZytTKKiN
	59RfDvcl5BHOWaba0037OETWiowYuVC3fa04Y47tMuAiZ1v9j1YIv0Le+0zt8bDK
	uq+RdTcsEtOGuoTJDMHEdqwqPwMzfETJTs89hE/QO7s6+FvhoBNTa0HlR0V47JjA
	jv5v6g==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hba262c0r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 16 Oct 2026 12:54:41 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-35d4538fd74so9140818eec.1
        for <op-tee@lists.trustedfirmware.org>; Fri, 16 Oct 2026 05:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792155281; x=1792760081; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XO8v3O2VsXW8MiGFrpI6qTd/A+X+oiAypVl/y9s5AYQ=;
        b=DOR02AI8NQiYDLpQsUofjA9i8bmFKLDpzFBR1U9xu0CtdrMXTZMf7KsNNTr41l1s8A
         nVjjijDUgpj4e7Ct01P1LjJeLVm8tH9BzjdlvgTKLj+V/7n79MkvVRkGJ0nVrvarQgNV
         OQyPZW20MvRG6NBp2QLDjwALbYmBFTmMIjO2z8tMAcVe5n2k4qrvJMbumxnZ4IezBA4/
         Y39ZRlafahEL0xSmo8oUb0yxhkYECOfoBB6bW+voKC2LwWruneSbRBFoHnOcvjeNQ/7Q
         3IxOdc4fZzbex8lHjout6698HY63K3XaC7LihCPJOUY8DwZoytyEBTdpxiHc6Vq9VaaQ
         0BgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792155281; x=1792760081;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XO8v3O2VsXW8MiGFrpI6qTd/A+X+oiAypVl/y9s5AYQ=;
        b=cp5X/xyrTda90SZFQm22jM8zLtj8+H2zHhSCIOdKBcxWXc93+E8IGrOUVUdqmT8ksL
         jEuF8elt8XPHAiGeswU+e1o59kYg1oEtYb2z/GIGYl3NS5/y6g0B28EFnGNf544BnjsW
         ZYhlggn+g27JYVtD+9JPpj1JOdQWKdLVQHPokl/1d3VdfZAChDb8NJ551tDDsWTrdkTr
         IwVa8H4AzEZogIO2WEQibLf6UVRyTufMoNcb8NfNqmSX6YF00poFX4pZLKj5MXFHhtjY
         9jU2dZse1EbP7A8pEVl2xFzIwVFqMefjbupT7aeOf+y+rbFGpV9HMKQpmjsWY0f67tLm
         lwwg==
X-Forwarded-Encrypted: i=1; AKwUvBxjiT+E8d3zYCJF6zf4weG+cEGHgV7enV5t3XP3aKF9yB6x0mF/Uio4aPwOuSVg45zy3Md9OxA=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYKXo81AHxa0mCuOXmkC8n+JYsbBNgJgC0a+/Nt3eMn2XknOvLbX
	V98YkQq6GVMGbq6dQljr9vPpOQOUyzKIq4JY8cyr8BVKS5fthVTkL395IrzbBCkQ9PRLd1WZtdY
	9Km0fl7E7lAPKqArRv4tcjLmAoQOoCIO55mrhRWMhJcDKFzBGFKgVUvLJdZaYOvoLD3SijoLj
X-Gm-Gg: AYBFou1mU0ZHTbyxJ509W/slk/XJQTq4uY4e6s9WgThAzajRr2biOOz5UBFq98TtAg3
	4s2Vr8uSIfY/AB1GkeQtGnfYAHY7fk3a8mZRIUIXrti1uHGoIG5MpwAw5uDbkma/Z6KLxmS0Nyn
	V0C3pAZEGqgeTpFqbcRPDfFVT9pUr1gFa7DiUVUZ1Byo4bQeJKwL1dCS4M15Vdfb0fMU0HyvdW+
	g9MPni3R6eR5weMeYnggrW49/SL/X1LFGv/CvGpy+MZ+y8eMEi2AnLec5GTYOPPdHi9JYQIm4tP
	tHep0qpOTONJtXGBQfhtCrmffVkuNeOZzqU6axFRMrzDX7esn/C7y33lN+qPtSWKurtxWOSxFVP
	GaM7HNVCWMBXrWhVFROl3BnC9Z3+h1A==
X-Received: by 2002:a05:693c:8959:10b0:35b:da8b:f88c with SMTP id 5a478bee46e88-35bda8c2195mr17030969eec.41.1792155280670;
        Fri, 16 Oct 2026 05:54:40 -0700 (PDT)
X-Received: by 2002:a05:693c:8959:10b0:35b:da8b:f88c with SMTP id 5a478bee46e88-35bda8c2195mr17030931eec.41.1792155279953;
        Fri, 16 Oct 2026 05:54:39 -0700 (PDT)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607ee0d391sm7184042eec.4.2026.10.16.05.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 05:54:39 -0700 (PDT)
Message-ID: <bea6d8df-88b2-4f03-9da2-1be7d5788d1e@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 18:24:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/7] tee: Add kernel client object invoke helper
To: Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20261015-qcom_uefisecapp_migrate_qcomtee-v5-0-1460691b35d3@oss.qualcomm.com>
 <20261015-qcom_uefisecapp_migrate_qcomtee-v5-2-1460691b35d3@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261015-qcom_uefisecapp_migrate_qcomtee-v5-2-1460691b35d3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=bsHZl0ai c=1 sm=1 tr=0 ts=6ad21e91 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=IkwWU5-DNg5bmC6MlS0A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1MSBTYWx0ZWRfX57/Q0pXRojRc
 HIkmWEw1r99HmF7UEmoe3ksbUL7zSLDSF3zGjYLUTG5C0qQ++e7/oF65D1Wj1Szx7JOhQKGEqIY
 xY1Bb2t2oMccSLZAdTqG3m8oM+gbu0HpPVgbCOd9DLy9gy0Z5/7BFnK1xM+oQjou4RmZUZl7GIU
 ZZnLQY5OZdLr431mqB4GbBOWDcOXlUnneH9DGgQ49INDHyPzAkNEue/HhkEW/hJ74JOt2LrAiXO
 512yJjPSwsGcdKQRWDIltgXCHQs2fNT5oJMmLINP0Yz+cRcEFJ2QRRc6RiZrjkvXWP2RTT+JrhR
 HwQordzrVQu+5ypry92KR/gDnWL4QJ8fWmRVPThBe7BG/kLy8B/cyjGZasm6QLtJ2G7UEqVSwGu
 A4qARS9GwDdKPueg2D1EUNhWCMXZzP8ZrwhGHc2U8synhO9eNp1IyR6O2G9ny/9jDEtonJcfy+K
 wpPJ4maKZtSLgoznyvg==
X-Proofpoint-ORIG-GUID: bQKlIU8O2NjE4Bi9hQkg8Fiv4zS2Hffd
X-Proofpoint-GUID: bQKlIU8O2NjE4Bi9hQkg8Fiv4zS2Hffd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1MSBTYWx0ZWRfX8bZFqYqw6saL
 uVxEnkklSlQJi3eA5hqYnMsYgdKc1svif62rfVOwrBBvLbN1uH4HvioYZR3pLOB9RbYK6vKnBB6
 hTqeeOyxWBbY59Y+3Qwb08kXRxxodb0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 phishscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160051
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.99 / 15.00];
	BAYES_HAM(-2.99)[99.96%];
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
	DNSWL_BLOCKED(0.00)[202.46.22.19:received,205.220.168.131:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: AAB6E43A5F
X-Spamd-Bar: -----
Message-ID-Hash: G37KOII2HBVPZ55CXF2KLQXC57VEI23V
X-Message-ID-Hash: G37KOII2HBVPZ55CXF2KLQXC57VEI23V
X-MailFrom: kuldeep.singh@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/G37KOII2HBVPZ55CXF2KLQXC57VEI23V/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Kuldeep Singh via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

On 15-10-2026 17:09, Harshal Dev wrote:
> From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> 
> Kernel clients can open a TEE context and invoke regular TA commands
> through tee_client_invoke_func(). However, there is currently no
> equivalent helper for invoking TEE objects.
> 
> Add tee_client_object_invoke_func() as a kernel client API for issuing
> object invocation requests. The helper checks that the backend provides
> object_invoke_func() before forwarding the request by setting the origin
> as TEE_OBJECT_INVOKE_KERNEL. This allows TEE backends to support
> privileged object-based calls from the kernel-space.
> 
> Co-developed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Reviewed-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Tested-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com> #on Glymur-crd

-- 
Regards
Kuldeep

