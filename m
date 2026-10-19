Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80CD1CCF2DA
	for <op-tee@archiver.kernel.org>; Mon, 19 Oct 2026 06:16:14 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9EFE344FD6
	for <op-tee@archiver.kernel.org>; Mon, 19 Oct 2026 06:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1792390573;
	bh=xhmXf1PR+SPWbydXKdG1JG0Ihlu3vWgnp2oEIJ3YqRA=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Lq9xlq4/UwbaGLwwUGgg/Z6H/Pd9ZHPnftNk7FZv3SBS7Zjd2I/sCTnsq/dKoD0ED
	 hBQIgf9zMvrUSdLhjfGiDp/KTiBn2VYswmmGDCaHcU0AGzHZBMHkMnXriMNYIigU/8
	 gFjp8Uh9WL5Kju0rJOO2B1IcW9XoRsXo/MABVl+PLWlYI1adWKsh2mhxonCWCK30uY
	 Xq/JX7pkX7IUcUOmJtNtwdo/0tFfP8XcpUxWBjOd5mu9levlAmeCsvj/nJ2YxJpT/y
	 A679MESeQRkyKsAX0nqNnjhuGdd5mzKe3vyWXU0te6zcNCiE7omjQ301I68Z8L+3bQ
	 N9Kk8K0snqxWw==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id AD95644A8C
	for <op-tee@lists.trustedfirmware.org>; Mon, 19 Oct 2026 06:15:55 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hBafz8Cp;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EKzqVJNV;
	dkim-atps=neutral
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J4j3P42264936
	for <op-tee@lists.trustedfirmware.org>; Mon, 19 Oct 2026 06:15:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xnXlvura6HqbRVAHGsr8qtM9oPK7l8m6EFNCUTUAuOc=; b=hBafz8Cpu55qf6Qy
	RRsAnylBWsXPrZOVUSIJGFPsjdbUIODgR31N/lSucVSeGpCO+D3Ad8TH3E/Xlw6S
	t1qEAw32fZ3lQh7UciwTaClUF1A0L/Y5bhSKS6YK68SLOEkF2M+f/euccjDt5m8Q
	cyoEcmzjzGex1A2Hyv9zY4gaI7Vpky5pixtbbJzj0yQmXM0niutqhf181rDp3KAT
	IthhK6CMaJdiznoPfJ4ZF7okP+COcOeZr0iZu9tCEDzHIqggJDLw4nZGPeZe/F83
	ZGL7K45cBwg3tAfvoIszodOVhzMdMfH0INn6IpAAofwmd+BwQZk7W1WE1T69boUd
	tEo9VQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc0kxn8da-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 19 Oct 2026 06:15:55 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30bcb065bfdso3605165eec.0
        for <op-tee@lists.trustedfirmware.org>; Sun, 18 Oct 2026 23:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792390554; x=1792995354; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xnXlvura6HqbRVAHGsr8qtM9oPK7l8m6EFNCUTUAuOc=;
        b=EKzqVJNV48OUGpsa1GlZEd8Q9yXLkLp9dUqTRdyrWOO1Vtfgr9nueRA4ju2YjeWYMi
         hBWZKWqPnbQiH2S0+91Lb2scvzVgG6gG9Lei9Lo19x0NbIw5p2J0lG1acCDhCwdO+e3A
         WP0fWrPdP9lKYVFlH4UOlc5JNKIgJ5kkm09nuZf3eLIG/cF7cQ9Kcq+SySDDyPNWB//D
         EDFpj/bNTf99GTz0LG8f1GzPQlK+8s+VRCaE9aCGboeJMsR+unisbMeV8fkn5uczRhwB
         sv9ejttW+w2ssY74YSr0Tm9ow7UxnYCNRd57nYRECqvXXGHZAAxT78z4ugF4ifw5ipzu
         mc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792390554; x=1792995354;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xnXlvura6HqbRVAHGsr8qtM9oPK7l8m6EFNCUTUAuOc=;
        b=Mr5b2yQBftSjPoJI/09tHkcVWGLquIG/8NtKW5m3ELIDkbaEjhI/UqRjwmKbX67le7
         bylw930eDQNdojjFITHn3lnzMEsdo47AZtGOaPShvbexHtmjB+8lLllbgeMgipZK28Lr
         b/4a2pO/0v5KROanNfFfytfzB2rGmiGZmzlhXqDYyh8A26W8AbpiY2GRM7agXmTVwy/W
         t4/+Kb/ENWraM9/mlVq0jN8aHc0Q3DOPHlM08wOaYONJEGbAmEa45T5ffLpDCyGhRQ0h
         Sm8tKXFmTERQLa9rZHc9jQzWgTSN1WQOt+LRQyMOousubqZe3guBeu6g51V10l/6cnLB
         u7aA==
X-Forwarded-Encrypted: i=1; AKwUvBw1cmQ86b96BC3Urvekk3tVs9wlZem8QqNZg8eVwswAYker4/S9jxjdbdZFZPjte9H6R55gFzo=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYIZ99KrTEWsKqrmSSOZnfZQlgObGHqfu7XkOPy0SVCkBuUfnlHa
	GxrbS0kmn7jwCph45ynbc8KPRcP6MWllQGCxkqxvdjPiXdBizzwYqZYCJdQ3uJPGLtANWrz9EDY
	/0suVTd2e8LOhjOi1GlUmn4xVopCGRsIQC8W/T4eMECr32ssXlMaQos4bwlLt5450mSgYh+SJ
X-Gm-Gg: AYBFou0E30wuU5uLiUHdh8PUqZlttH6wL7tfVByHCNUm+BJjahPxHQOLrJv592Zf2AS
	Nd3XXg65ASL2a0mkDw725IczaNZrRA3HJBQZLMV9TSLqk9kp86OMc8bvKpOZiQ8qCwj7ikgJK6h
	wxIA+07dMNbhR3CaBtUHzWcUJgy2b1G9xGBYAS7nVIYp22mQ+hIcA+fEbQ7wtviszSVXMmnuXSB
	OCkazFaIWmRsqPqswIYMe6VL5H4Y7+KKagGc6E2X8KHT1K1pBrce2OOiNoTbC4OXfltthd5kvWN
	0LBPYjk6UhYHXR4Rw8cYmrqlf1UjRz0fSoOkHKTMe0IeqhKSM7cTwwYZ2qA6DWCltSNdYK4TKCE
	Fc3d8fz0cjSNTEb+f48I8asJjrs4MeQ==
X-Received: by 2002:a05:7301:4b0e:b0:360:ca2f:ce6f with SMTP id 5a478bee46e88-3619ea236b5mr9259812eec.1.1792390553829;
        Sun, 18 Oct 2026 23:15:53 -0700 (PDT)
X-Received: by 2002:a05:7301:4b0e:b0:360:ca2f:ce6f with SMTP id 5a478bee46e88-3619ea236b5mr9259784eec.1.1792390553247;
        Sun, 18 Oct 2026 23:15:53 -0700 (PDT)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607bc950f9sm32590185eec.0.2026.10.18.23.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2026 23:15:52 -0700 (PDT)
Message-ID: <f14e7eb7-89af-4228-82d2-e0dc6b67a0b1@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 11:45:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Add TPM support via Qualcomm TEE TPM TA
To: Jarkko Sakkinen <jarkko@kernel.org>
References: <20261015-tpm_qcom_driver-v3-0-247c8e50250e@qti.qualcomm.com>
 <atKRjiZEMIx3hhxI@kernel.org>
Content-Language: en-US
In-Reply-To: <atKRjiZEMIx3hhxI@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAyNCBTYWx0ZWRfX2n3zYKuxVTX0
 3CgLs6lZ5dXdDl0ymK+5+3cg8JfU1nL6dVRRKOAq2y60oL2Li7FowhYsf3TfvowxfVkYEphSCER
 2AT8BjHFik0MqZUdMZv/GwWNcANWd9Q=
X-Authority-Analysis: v=2.4 cv=JpZkP84C c=1 sm=1 tr=0 ts=6ad5b59b cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=VeEq6VHES1BVyvH2O-YA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAyNCBTYWx0ZWRfX4Z0Khpg/k4hn
 AZ0klcl3DNCRsYCtjYljujNk7msgm210Vyd62haJtTKBKJFjNr0iiIWUpPKlwjIK7PCUZGupxxz
 Y/ID03eaDgEeaSjcXeRZi/jihha01qxlfT6OvwNfhnF/TNYQTtaX3zliTWhGbv+qFrqw4/GHltB
 G/LTBb5nD3Kw4go60KnlT9qkcFcw0y0FI6YBl4MVESIpK4mVlfeS3Gb43Sk97DPRZVENWlPnA/K
 jO7uuZZNpGkOU2wZvpnnx9lgxfyGdis+mzp14CmSQpNRs1oX3jbenI+XqM7MkAy1WZymK91zcfv
 /IOlp7Dq1LGdA0q/gSRcwusAwgCPZozp29Gw0y/pLhx56hPiBIUBUsMBovO57DIyrcf9fpO5Eko
 NXNAAAcGts3qccXg5RN3GKzg8sTK+lirdKCi1nye5SpjwKTNr7+pRZktsRriGe5b1lYx0QwIMZ1
 ++qmv03cZnzZtwg+AfA==
X-Proofpoint-ORIG-GUID: lZhtAlDUlWnhllQamig2BjUd3uadTGFr
X-Proofpoint-GUID: lZhtAlDUlWnhllQamig2BjUd3uadTGFr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190024
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,gmx.de,ziepe.ca,vger.kernel.org,lists.trustedfirmware.org];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.200:received];
	FROM_EQ_ENVFROM(0.00)[];
	DNSWL_BLOCKED(0.00)[205.220.180.131:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: AD95644A8C
X-Spamd-Bar: -----
Message-ID-Hash: R5XGABJYFTL4AMWHS2EWEWENRMGYTGJY
X-Message-ID-Hash: R5XGABJYFTL4AMWHS2EWEWENRMGYTGJY
X-MailFrom: kuldeep.singh@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/R5XGABJYFTL4AMWHS2EWEWENRMGYTGJY/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Kuldeep Singh via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

On 17-10-2026 02:35, Jarkko Sakkinen wrote:
> On Thu, Oct 15, 2026 at 12:07:45PM +0530, Kuldeep Singh wrote:
>> Qualcomm platforms with a discrete TPM (dTPM) talked to it directly over
>> a non-secure SPI channel from the kernel. Arm's Base Boot Security
>> Requirements (BBSR) v1.4 require that access to go through TrustZone
>> instead, so on affected Qualcomm platforms the TPM 2.0 instance is now
>> fronted by a Trusted Application (TA) running inside Qualcomm's Trusted
>> Execution Environment (QTEE), which talks to the dTPM (or implements an
>> fTPM) on the kernel's behalf.
>>
>> This series adds a kernel driver for that TA, built on the QCOMTEE
>> object-IPC transport (drivers/tee/qcomtee/) already used to reach other
>> QTEE services.
>>
>> This patch series functionally depends on below(first 5 changes specially)
>> for qtee service discovery.
>> - https://lore.kernel.org/lkml/20261006-qcom_uefisecapp_migrate_qcomtee-v4-0-bf1c8e2a64ab@oss.qualcomm.com/
>>
>> Tested on Glymur-crd target with tpm2-tools utility.
>>
>> Validations:
>> - Get capabilities
>> - Random number generator
>> - RSA key creation, encryption and decryption.
>>
>> Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
>> ---
>> Changes in v3:
>> - Merge tpm_qcom.h into tpm_qcom.c(Amir comments)
>> - Update return values of functions and drop certain error prints.
>> - Define locality_arg as default value.
>> - Add Jarrko's tag on all but drop from 2/3 as significant changes done.
> 
> I get this because I have hard time to write "catppuccin" correctly ;-)

Lol, so sorry for typo!
It took me sometime still to figure out where i caused the typo! :(

-- 
Regards
Kuldeep

