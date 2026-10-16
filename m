Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC327CCA46C
	for <op-tee@archiver.kernel.org>; Fri, 16 Oct 2026 12:55:32 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0C2F74534C
	for <op-tee@archiver.kernel.org>; Fri, 16 Oct 2026 12:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1792155332;
	bh=hDTZ3oqULIZdr5on0b3OG8uMpsW6DhD9jVUp4w4AKas=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=OmTXc7xeBVM36VklX/54Q8KN3X6xD6PIbmMoOZ7hYwBCn0xGp3SshWmW0R1xbeUp2
	 MS7vxckPQkK+JPGryPmGWdzRPteRC5Z2NTJjlTjd9nlvJJZWZX6BtJwMIZDjY1ml/v
	 bRO8tHTrgd/Cukr7qvuiv7U3xi0wJQ/LuPuGGzbbQEW/PCzdbBtH5kQSrdNipbymrp
	 T3kaS1Use6E0KwZ8zPqytD0QXCo661uOWAEpHWTUSWpcMvZ9QhmznDPaMmT/paZEMy
	 TRSJHM/9ejGSHQzcFR65EjQq8An34sths95LU2ZL1+cZT27z2SzTc4ZmI5bUY/RWOl
	 XjUllz21ejNxg==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 460E44533E
	for <op-tee@lists.trustedfirmware.org>; Fri, 16 Oct 2026 12:55:13 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MZnARc8F;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GDR0A58w;
	dkim-atps=neutral
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GAASU23069356
	for <op-tee@lists.trustedfirmware.org>; Fri, 16 Oct 2026 12:55:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0DP1299sBs5o7pcdjosdvrMKB0twaCKLfEnrmAKUqIY=; b=MZnARc8Fa6ovO2hW
	PkrcYuinZYNYSi7E5Q1vpiJllK/3+hmDDZ4Y1jjA47aXYbfgnD2Maw0Reirz1S+j
	wrmUw3NoMBLAUPfyd3eEIKpgytuGvdJqjpPMcSPg3g99z1Fd2gRIL4/2tfUgOQD/
	NPlGM4oFspbVh5kW4agGA8kN0J2pkY2sT4yvzsg+6pixQNVcu69sorKml86FK58o
	WrXnu83WTxNx6fi1cBEo4NVR2qSr7VbPpbW9qfGjSi+vojglxnFvmpOH/cfcdU9V
	A9O98an1tS3qp6InAsZH0XhOvLvJJf7gjOXq/EBJ1tk5IKuNW1o4v1lZLHTDn9uy
	k4gaaA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hba262c3f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 16 Oct 2026 12:55:11 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-35c5aef2a74so9151419eec.0
        for <op-tee@lists.trustedfirmware.org>; Fri, 16 Oct 2026 05:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792155311; x=1792760111; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0DP1299sBs5o7pcdjosdvrMKB0twaCKLfEnrmAKUqIY=;
        b=GDR0A58wVr0hH5x1W77BVN3h3QJZuvPZDYkuUHAu8r2nJ87GXMouFHqfu1EJn1A7c7
         3tNIagDWQygbgZNmGwXl23cKDp/JEyPxybBXKqdcb+okLIJU6ZnhF4Lflux+vVbJVMji
         /kmO2APwXorqfpMmmMEUJ6/ByXGB4CbbqWncrrItGOBLq4TBPysJbDhnfBDc3t6N47D8
         p//14pDFkwH3Un6wUQsw7ao3Uo5xg/geAlWW/I2kkd8cJfyLKucdpt3MFxLbHvIM3eqY
         VWjXr4sfi2mGrlp0PpUEhSBy5Rt+sKbZIXP4HoG1Ucx19G7TVHKLHXqnJSu6Csp+Et4I
         +UlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792155311; x=1792760111;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0DP1299sBs5o7pcdjosdvrMKB0twaCKLfEnrmAKUqIY=;
        b=nmJjhqOJvbXr4Hnjv5zMNkGBppkj0Bop98oZj/Coh0mDJnYx5OS9CleKZ2l0uTzEtC
         w8Ig5SzZvboKQAMP4w7Vccth0BpaoPCphTPrABjwhlQHVEi6cNVrhVJ1O+02LcXAe4+O
         +S0s++mPGhzus6hBfqYR0tAn/2FVHlT0RAZs4hvFF32xS3D3Qtz2HgS0j1ul3sKenThu
         5pT8oUK4XqpT8bvlm8gZbj4PEvQvtdWugvLsz0QQuiCNRdYtcvAYHc6OjMyvKQ0knaGV
         YEAoVfhRjBrl4zgFFixVGZvDByUXqwRPXow0BtkTpIoJLlSWC0bUpDGQFl1QBgjBmw31
         5WUQ==
X-Forwarded-Encrypted: i=1; AKwUvBzWXm4sxhIXO7hGGsmYJ2cb39e2biJMVUpTHvmHkpe9xoHsjfTPiZ1NbWGonFVFPocS4c2Y5ds=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYKzYEYYk84meR5hKxvO9bUB+jCkuaUvgV72qHqfbb2o4F1K6DIf
	xVDDIylsUAu/U2yhVB/GoxIdKWtALS6mog8U30qB3rrcnEfxV/FOoCQJ+OxQJjRwBh3Fiv3YLv8
	FF3KgQk4y18EDYOOvnFxd33mSB2Q/xtL0qjhYHh9mlPkGwki2NUFGRCPBM7mA2Wn1T3n/i1vp
X-Gm-Gg: AYBFou30o7hRKEbhATc1x55ohJoNnecud+emDAWgFazROU9YDAmRVMPO7JxIbFK/res
	dnBZ5FfzJFHy8iXYQoKQud3hEXQ5b1u+NEX6NYsRJFzVtoyAbRwGV3Evg9nA/OCEyipRwjmi+mL
	KGxD6qzNzDkn/i20sFJ1Jqd/Bmfvp67uk5zizG5sNsL17lxcanvwixllWTP2UfGAL57c5LmOj/R
	+QM6cBjFIp0VwMEtd+/r32WHgqyQ4emMcG7voGeYjLZeVsTz8nluQ3+whMFfm6KSNu3uKLpUhIB
	Das0PzdVKM75fhuDDgKRepcr0qb0U3xqDRAfsTOrj/8QmV7PVUHobau31S8h7zyLx4snjq7H1eq
	UWtRnHVYONcNF56qJv6BkmskgzoVMPMw=
X-Received: by 2002:a05:693c:821a:b0:35c:813a:1c81 with SMTP id 5a478bee46e88-35c813a23b6mr15907405eec.18.1792155311313;
        Fri, 16 Oct 2026 05:55:11 -0700 (PDT)
X-Received: by 2002:a05:693c:821a:b0:35c:813a:1c81 with SMTP id 5a478bee46e88-35c813a23b6mr15907290eec.18.1792155309466;
        Fri, 16 Oct 2026 05:55:09 -0700 (PDT)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360826875b3sm7285151eec.21.2026.10.16.05.55.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 05:55:09 -0700 (PDT)
Message-ID: <ad16a8f8-b0b3-4fa3-8563-5d0ae14c1122@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 18:25:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/7] tee: qcomtee: Allow object invokes from kernel
 clients
To: Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20261015-qcom_uefisecapp_migrate_qcomtee-v5-0-1460691b35d3@oss.qualcomm.com>
 <20261015-qcom_uefisecapp_migrate_qcomtee-v5-3-1460691b35d3@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261015-qcom_uefisecapp_migrate_qcomtee-v5-3-1460691b35d3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=bsHZl0ai c=1 sm=1 tr=0 ts=6ad21eb0 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=WasAi8j2_tIlmVKutyQA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1MSBTYWx0ZWRfX+X/rY1UDZuyQ
 xE+JHJug2RLf++ohLvv2AUOeAm1kbWQ1mBYFyUv1VXoUt/vUwJ9iyyjRY53DBD/+Q54pluTGRrA
 90YdSXcktVX3y5S3V+PJi+N+ADJZelM/eQgp7okYQ1/+3t0S2ppI7iSfv6CzYfYuK2oam0O5DmO
 20VKvVjA9a2MIknYwpW2lTGI8/nIZcB2V6Et4LOONM/Sos/qSq0uUshSzunfyoCf0zgEeXkjjSZ
 FToRdOJipOgkpYZMsA7jZLikle2hEA+zaRE3rr1VJyzPEDs5OGR/0yke7XIdn0eMKRsQC4WtwSJ
 JL0jErCM4NoI1yMCnBt8ChnCdKe9IU/rqsw6rY96fHd83KVWk4vpi3vyBcrLBn7QU//YHCObR0v
 vtymWAXD9GRmcZ/5uJJLyL0JQ1tzN/Ux8i1zItqISpH2sc3aGhuYSQ2OpzRpP0fThTNyV4XEdgj
 +VQpoDrUAt5J6NAlOhQ==
X-Proofpoint-ORIG-GUID: 2Cy7KT4Ik3SkZ7XAO9c4IzrCVGlP7U4D
X-Proofpoint-GUID: 2Cy7KT4Ik3SkZ7XAO9c4IzrCVGlP7U4D
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1MSBTYWx0ZWRfX5OSenKkmr6Zz
 TUB/2w/gis714nR5UB6W/s/j5BOBuBeWSZcoI71USdJqsYfynuQ3cnzRC8ANSfV9FvZf2KWmc4Q
 18ngDpS3CcnaiQ5HJosdD0u/VZkSaVE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 phishscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160051
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.97 / 15.00];
	BAYES_HAM(-2.97)[99.86%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[202.46.22.19:received,205.220.168.131:from,74.125.82.200:received];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 460E44533E
X-Spamd-Bar: -----
Message-ID-Hash: B46XOJRCJD3FF25XFGWMB5VIZ4L6MCNA
X-Message-ID-Hash: B46XOJRCJD3FF25XFGWMB5VIZ4L6MCNA
X-MailFrom: kuldeep.singh@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/B46XOJRCJD3FF25XFGWMB5VIZ4L6MCNA/>
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
> QCOMTEE currently treats UBUF parameters as userspace addresses and
> applies userspace restrictions when invoking the root object. This is
> not suitable for object invocation requests issued by kernel clients.
> 
> Use the kernel_ctx flag to distinguish kernel client requests from
> userspace requests. For kernel contexts, do not mark UBUF parameters as
> user addresses, and allow permitted root-object operations to proceed
> without applying the userspace-only checks.
> 
> This allows in-kernel users of tee_client_object_invoke_func() to issue
> object invocation requests through the qcomtee backend.
> 
> Co-developed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Reviewed-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Tested-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com> #on Glymur-crd

-- 
Regards
Kuldeep

