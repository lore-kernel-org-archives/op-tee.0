Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D16C982ED
	for <op-tee@archiver.kernel.org>; Mon, 21 Sep 2026 08:36:58 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6EAF645487
	for <op-tee@archiver.kernel.org>; Mon, 21 Sep 2026 08:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1789979817;
	bh=ZCwmZO84Gw6iM0nAODwcNKlVIlSJtLdUDQfhkkemjho=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=edtLhM/JtHXMJbslPsc3KfUzHa0aijaVnLmA5XIHpmvl77CL50h1aV56IBtj4W9wq
	 /9ozQfU/TLaya/eXWwpLmFRQ36mN6J332f+jMtY2nmTfxyhw6WCN9nhm39W5C1OpBn
	 BaOQQo9ODRue6H7Q7M2bHIqAw8bCrC7MfC+l7tKjNB+7c6gA5Gw96bB3Ph9nZQL/Sg
	 F7AEAvsYExUgVLfjsUvJ6kqlLMTPmIj300g6TAPSbECPDe02xEhUy/nYQSO9inSYWY
	 RNjXjI7cteHl1UzpuR95CPjaS+GWDSgLWFLaI08R4aN/xz9yQd0mUqk9e0wEHGM3yT
	 1b9nCU56nAHgg==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A648F43B56
	for <op-tee@lists.trustedfirmware.org>; Mon, 21 Sep 2026 08:36:50 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=D3SlBmMU;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SKiqjNYO;
	dkim-atps=neutral
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L79uRF1096083
	for <op-tee@lists.trustedfirmware.org>; Mon, 21 Sep 2026 08:36:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kPtxmrYU8ZrfXfOjYF4vl1wiQZgzuzOfDh5H7b3Y+5s=; b=D3SlBmMUdBjMKj91
	YpyGZ9eAsB9w24gK8bmeYcytRs4qvBuRHT/NJk+RqIa4tng0epLHf8B3zUKe5Rp3
	zP92/H2hfYMQpD38qKx9ztIzgXW4sbUMsSAEYqGJFq8DcPCl6RlFy0i0BTXgrJ4C
	zKnMXhxoJqbmUpwFlYlt1ko6cyxji/h7xca2OeNhe3/REHptY5XkQtLRrrx7Mvdk
	ScW8Namr9rsqVFYw2SFHSR5OVKA9r3xu83aZVW7ThCp3WxxZBZrNR44u1Eb60F0i
	Y4J0pGCUzM236lTVO/XsK9k35pJq1i+pD+NiJUF6Fe3cr1K36uP1hK9gD0KC+075
	WhSndg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtysw0css-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 21 Sep 2026 08:36:49 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2db3734d06dso49078655ad.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 21 Sep 2026 01:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789979809; x=1790584609; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kPtxmrYU8ZrfXfOjYF4vl1wiQZgzuzOfDh5H7b3Y+5s=;
        b=SKiqjNYOf/FHfHWLj6B4U1p8fiHuPQiP2B84iau4U34fQOUD5XsS6IuckqdshRR5YV
         CK0fS50QtZotlVtX7e/LUgi3o54t//ZN3mPwXxfn7gFO+OQuc9Re1cKuHHZs4bHwjXoC
         K5yzqXN70JbKpX6VS3XEDDYsO9Lm1B0f1Spx6uwXvOvoVDA+08o9L2MNas7vZLVYK7yo
         0YuVykU5eOwGRB4PQIAClbhJOGaenHVTCDMk7ezilqrdkjr4yUlDh9jopakax4ahmmS+
         v7DuQwEF4pcK3UTN20sxrMZ3Sryy8F4IoXEQbqXWZ37aGEckpGQciAhFsz/Nj40YOchC
         ksew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789979809; x=1790584609;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kPtxmrYU8ZrfXfOjYF4vl1wiQZgzuzOfDh5H7b3Y+5s=;
        b=qBuonEp9XwdEthGFdPNFq50L8mSeAxkSkH6H70kSqF2oxPL2XW0YjTvICjU7WaRJx1
         43OYm/OZLSNYtsTRs//dEnlhZYaO5C92fjwWTybP2NqDQ6dbLdyBg777N+ifRom59pza
         N5qCYfs7yUj8UkLHBTOTIQvc5UTKC4dYB30m7CRAkCKKIryi9AW5BcJ1gdPDBaTjcVRV
         VEgE1+xUj8/XfxjqAZt+30ZulLGp8hJNUFV0CLSOD/N/yJL46G1RyH8nWzvhUphQOnpc
         eLArFMKXoZzHfWR5X/zeJ/lQXIy9bgzTSD0miBYoXatAO4v3LVQEGOYk/4FbHCU2Vu2G
         TANw==
X-Forwarded-Encrypted: i=1; AKwUvBxKryxsSPECjDxuVSVjKY3hW5YWtT10+0aoBzfFTtpOhgCpI32//BoKRcb9VFvD6D1k/9Jf7Lk=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++mzHeElEjS11vVMdMo3ptkAIwTRZ3Zx+xKp/j7WyULV0aj/Uo0u
	x6tBH153J9ANJ8VdczvnwuNvbAOoNcMy6UOyVtYKQFHxd0Oi3emDd+EWtnexevz3kS1TED94mSk
	pIBRdA8uNlVgcF7uBO2iGI+MCB/iFeC/5EDt6stG34qWW/boPhcKwjf+8KxSCVdFuZhIp2UVz
X-Gm-Gg: AYBFou17h+WWIfE+iSFtOp6ontlJ19s+RZeFeeWV6fwnEiV/awB9jLbyeHmqt2WhLv3
	OFTB+tkyAPsxBwR4gP7VkEiwMFwjsrisT1Aw7gPy8kONf8oURMBYIvtdy+Ya0MNivP9HozkOHx4
	bkwN8966JpFQYD2cvaQKuFNd67Iz3L3LGIuNdKgVPzUcWfBBTa8nrtHlIJPmaXF1tW+n9OoGb05
	uhKX18GJfD2XZFioGtFHOZWqGClKXHQNOugxNNaO2rfQHg+264JjLtDPahblUc6ibx0hncgjRxn
	l7n9/kVWWSUJAqSuR3IypAHWhiVpL4FZzRsNVbsTcl1DwDKI41QZN5Z9lEQJEbIJym9FxOjlZM5
	dr23yfw5yfNYEWQFGXgzG26UdTGoZLA==
X-Received: by 2002:a17:903:9ce:b0:2db:20fa:9443 with SMTP id d9443c01a7336-2ddb1b1133cmr154922865ad.13.1789979808860;
        Mon, 21 Sep 2026 01:36:48 -0700 (PDT)
X-Received: by 2002:a17:903:9ce:b0:2db:20fa:9443 with SMTP id d9443c01a7336-2ddb1b1133cmr154922645ad.13.1789979808455;
        Mon, 21 Sep 2026 01:36:48 -0700 (PDT)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c331d55cfsm22056781eec.30.2026.09.21.01.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 01:36:48 -0700 (PDT)
Message-ID: <d555ee76-3999-4ed0-be6a-ca07354af6d4@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 14:06:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Add TPM support via Qualcomm TEE TPM TA
To: Jarkko Sakkinen <jarkko@kernel.org>
References: <20260907-tpm_qcom_driver-v2-0-71a6b1752da8@oss.qualcomm.com>
 <aqyZtHynb2nuQT-P@kernel.org>
Content-Language: en-US
In-Reply-To: <aqyZtHynb2nuQT-P@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEyMSBTYWx0ZWRfX5Yspn63fVX6W
 UyxS2h0yAGx4pFffPKIVKm020ECY512m/SW49Bj7AvghvanK/fESEoi+BrPeQUlHdTXQrbsJBlt
 6rtdacUdjrdL4O1Wois/7NaPjpsR0Dvk/fg5vSMWrsGOTNSHblQ13mO2PTnc5GP0/XBxk+c2JJy
 4qZSyiI9JEJPVm/AoZjcDhjSPAByYnZSdVsgXlU1yEqch7OXokOx3obeLOcqxynpAadzbfi5NBU
 +7XNxXYxWML93ZkBmyjUYKX4+07kgPMdkghJ79VsoamxvZZwS/Oqec7tcAhsAqVXARjrF/LwbhD
 KvzSz76gL9MpyNEnXDrmBSCLJr8iY2NJCPa4lRpG7ALtgTt83v09j+l6VOCq3UoO/AqJv3ZwOAP
 XhO9cxDxEWc0I6fLo+a+y3tJJM/EHjEFZsmWNOBXMgbLTzhd4GzylVgy7NkidRpHBlZ94ySj/b1
 TBmWUP8Z9tHZEAHj+Qw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEyMSBTYWx0ZWRfX4A9KEzKVdGgU
 q0OLp0O/4NJPF4SZHQTo1BDUSf+a1spEZxo2y+0y4wv/acPJok3r11mcPEhYIIxm5AqBks2iGfY
 T+gF2FA3FBdrERe7u6AYZbCToGiHTPM=
X-Proofpoint-ORIG-GUID: wjInRyBG2Y7f-rrxtfh4MDuz1U3KFaeK
X-Proofpoint-GUID: wjInRyBG2Y7f-rrxtfh4MDuz1U3KFaeK
X-Authority-Analysis: v=2.4 cv=W7etxhWk c=1 sm=1 tr=0 ts=6ab0eca1 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ltvzBnS6LVNGfPjtTy4A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210121
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.82 / 15.00];
	BAYES_HAM(-2.72)[98.76%];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,gmx.de,ziepe.ca,vger.kernel.org,lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	DNSWL_BLOCKED(0.00)[202.46.22.19:received,209.85.214.199:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A648F43B56
X-Spamd-Bar: ---
Message-ID-Hash: GHVG4IOHW4XZQ2VSV3BLG6STYMB4AMRS
X-Message-ID-Hash: GHVG4IOHW4XZQ2VSV3BLG6STYMB4AMRS
X-MailFrom: kuldeep.singh@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/GHVG4IOHW4XZQ2VSV3BLG6STYMB4AMRS/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Kuldeep Singh via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

> Causes merge conflicts with my tree when applied with git am (actually
> b4 shazam).

Jarkko, this series was sent based on tag next-20260828 after applying
prerequisite series[1]. Some minor Makefile/MAINTAINERS conflict was
observed IIRC.

Kindly note for merge strategy, prerequisite series[1] will be merged
via TEE tree and current series need patch 1-5(not patch6) only as
prerequisite.

To merge TPM series, it's better to pick from your tree and TEE
maintainer can ACK patch 1/2 for seamless integration?

[1]
https://lore.kernel.org/lkml/20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com/

-- 
Regards
Kuldeep

