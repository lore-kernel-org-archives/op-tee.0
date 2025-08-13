Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 956C6C87FCF
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 21:47:41 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D14D143099
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 21:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1755121660;
	bh=3WEil0ehY5vXWc5kCGbGh1iNwldSAw0zKkcaT1ugWPM=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=HqwMIV2ktuh/6/8SYEwgF6+WzGoQDCHX5oN2mwJWmx9JO5jm4c6tfI5R9VtU+2IU7
	 mzMVCBu3ygsorNj/o7MmSKUwKFZ9XMuQ2yOYxifJlhxFqOrHEy60Vc2kwz+8c2SNbw
	 r2uoBnVP8OrYA7ELSDZ2tjpD5jgfIcug1NjU7HY/Hk9Ue0Nmy+PV9dJ91Bw0n8Cdxy
	 OVYvxzkFU5gmiV5ySC1ind4DXUlfm/zNkTzWU0mGrkh1ki4TO8ZJqJcPfI1nQ9B3gQ
	 4wA7l8sVOMMtUwjhreG3HCg3jvwFO6bDFP0ocpAdcYki4zT73Bfl+0lsu8sKNPtmri
	 +NCfj8AdvbH5w==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 342CF42E10
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 21:47:26 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LCJShcCJ;
	dkim-atps=neutral
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DBLvVd021102
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 21:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PoxP7tG7pCID580yMt9K2LXcQBndbjiv/lE6hcV18C4=; b=LCJShcCJqrQ7J/v4
	GUKejkcaQxV4s9YPZgV8B6+bo/RivOwQyJyJEdjsoQF0qnCkgT7sy1D6zqHnV1vO
	s48+BESFy59JftqMeDl8n2SDCymjYh5aSnCrr1TbCWVG7Kb8IsVjxSZcByDlSHAN
	8IrmNbu000mwJy7GjCPp4kET5WaJXICZmjJntGnTE0eEMzog/jpTZ5T/46QLADsE
	i+pm0N50cbRTQcgWZjzDqVKjtbuQQq4wnqRI9wswOhQOehQ0zOZXm+n7HzJlHfhZ
	1MBWBsL0LP9EGj1Y6HMPq1rsJoFE8RUKzy8jCWnsHUV/YTgwCMYi2dS0hOqO/jCB
	TFDVQQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dw9swk99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 21:47:25 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b4716fa1e59so167957a12.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 14:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755121644; x=1755726444;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PoxP7tG7pCID580yMt9K2LXcQBndbjiv/lE6hcV18C4=;
        b=ioPUFQhzsolhfRR9fa5UPcxDl/mrbDSXvJ6FI9+wW4+dUysqvcvlvAO6ZBeHwj8wN/
         tfavfrGvrfc+BcgmeEXDDYZmNPzS3odkuEfY22GaT0+czmZU7S1LTbVYfW/rPySRvp2d
         4zHC10kQkT8vs1L+/b8Ub4QF+Gx/wBoW2OWb7lrBeAQHaUdo5NKH3VkpM69eOfB2ukb6
         dILIv8BS1ATKnuuJaHa17i5/yEfqzYsEWBXkmM60x7ppWgHQ4sDsoLQ9OmmloeRxU6Mk
         AzJEKpqXtTyASO9kcPZ33aEVRSraP9a5cvIo4iLrHni+s3zb5tt7ASwv23SFflD2uLMb
         XDaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNElzq0nsA6tuI8d+YLO0yDAS7wg2PsNj7uejgt+QrzvU9nOlAFZtFtpD77UIRdAIAwizJ7Ro=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyeEyPbsrLqphoaqv3z/g+2k7ump4pYUz4IvQdAWaNzNz47NPvi
	FGlxOlMxxXmHykn4BISu+g4ap620q4dswb7kQGZoh551QwYlisTqtILNZ7wpeMXnpQz+zDdseOy
	MXndjSASyiVAKOJvrxYNIDS/vkg1cXePcvc6Xm7cx3y0+gjgFQOlII0mG1MKqbAl7nAv0cdk=
X-Gm-Gg: ASbGncvHwjjM+zlnN9klKR6HxZgsh6n9qcO2Oj2TINb4ADBb5nfn568Eni5fAG5WPiP
	PJ8DsXEc4I1qbsMRd/dEC2btSundukksWFVXip/7wn1QkvceZylN26nwiW2J7IrXyAhNU/yOQc5
	H5ga0udkKyWvwYyZb0LzGFsq+4qhPnWP+xDHYAxUVCScPQ6XmH5t8bRxzF30w6ilnxXqwpf6D/I
	1OH/LTYodRbHzjzTLWMI9T4TTtdTUOOhNnqngAk3AuaFhhADWBsWjwqbbyCdUceOD3iBeY+n2p0
	7wF3nnN5Dez6oiNXEKaFMdDe0zZdTMQ9zk7PGn5yDBg1cxTWJA8RhtGyMG8jLpJEoCEpmqJA8LW
	j6bBT1C7kxtHpcM1Z25lChbbDbssaV+AWaSJrng==
X-Received: by 2002:a17:902:d482:b0:242:9bc4:f1c8 with SMTP id d9443c01a7336-244586e1b69mr7940515ad.55.1755121644277;
        Wed, 13 Aug 2025 14:47:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgjyhLi16jIYpZ8EHZqnYQaA0dKD8mdlmwaED7WOs0d7tmfiyJiuh/7q2M1HKFCS2ese9Jpw==
X-Received: by 2002:a17:902:d482:b0:242:9bc4:f1c8 with SMTP id d9443c01a7336-244586e1b69mr7940215ad.55.1755121643848;
        Wed, 13 Aug 2025 14:47:23 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-323257aa89esm1010760a91.23.2025.08.13.14.47.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 14:47:23 -0700 (PDT)
Message-ID: <0af9ac59-9b91-4a0b-92fb-b44e0e008431@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 07:47:14 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/11] firmware: qcom: tzmem: export shm_bridge
 create/delete
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
 <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-7-ce7a1a774803@oss.qualcomm.com>
 <f10f1602-972a-491f-9c11-95e5e7bd80f8@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <f10f1602-972a-491f-9c11-95e5e7bd80f8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=J+Wq7BnS c=1 sm=1 tr=0 ts=689d07ed cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=sWKEhP36mHoA:10 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=dTt1GwfqUVNo7j6m3doA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=bFCP_H2QrGi7Okbo017w:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: HWCmtc50lBk8g7eV3WnoePjITO1OIQ6u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAxNSBTYWx0ZWRfX/5jRk0ufTN7M
 4SUjhRvwWMKA4/7UKiN4fDNz0aHNi0OJ5XwnVPv9v6kZMDw26ukCut/4jTRPhj+QGJUxmir8QOy
 AqyS8TFPi/WfNOTGT04IQLL3HU0sC+nQMADyJbWdOURUvEUhTV30qyswRKYtK1Df2h795zR9FYr
 hxIsAhoO5kelAQzuaw2ixNyv4HBLOlFxJqb+Wpgtn4guvcQp71IFZmhsPLo6T2j270qfzARUYV8
 E/DEGht//OygrKWqI/zVx2xJm+lkLiIBN9J0rwRIJ2jAy1XwkaQUDd/VMJiljuPCdMm00UXLXQg
 wMB3IpXelbEH8LmUma0krO8GEep6yOAbbLAgZJ6Gdzbi+d+Aw1adez5Y4ehZPpqysrdoo5bTK1G
 Gc6p8v4t
X-Proofpoint-GUID: HWCmtc50lBk8g7eV3WnoePjITO1OIQ6u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090015
X-Rspamd-Queue-Id: 342CF42E10
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.23 / 15.00];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	BAYES_HAM(-1.13)[88.50%];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.197:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: 2FGXDZIX3X5OTFEECYI4WMEN4YOOOGYN
X-Message-ID-Hash: 2FGXDZIX3X5OTFEECYI4WMEN4YOOOGYN
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/2FGXDZIX3X5OTFEECYI4WMEN4YOOOGYN/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>



On 8/13/2025 8:06 PM, Konrad Dybcio wrote:
> On 8/13/25 2:35 AM, Amirreza Zarrabi wrote:
>> Anyone with access to contiguous physical memory should be able to
>> share memory with QTEE using shm_bridge.
>>
>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
>> Tested-by: Harshal Dev <quic_hdev@quicinc.com>
>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>> ---
> 
> Hm, I thought the idea for the tzmem allocator was to abstract
> these operations to prevent users from shooting themselves in
> the foot, and this seems to be circumventing that..
> 

Yes and no. The TEE subsystem has its own memory management code, and
the qcomtee backed driver will utilize it. In other words, qcomtee will
manage its own memory, and tzmem will only be used for drivers that
communicate with QTEE without involving the TEE subsystem.

This aligns with future extensions for FFA memory sharing.

Regards,
Amir

> Konrad

