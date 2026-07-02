Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D33C43327
	for <op-tee@archiver.kernel.org>; Thu,  2 Jul 2026 12:23:27 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7F02F45032
	for <op-tee@archiver.kernel.org>; Thu,  2 Jul 2026 12:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1782995006;
	bh=saOYySi17G8WfVNXpXK5Fq1yaGVSJ/vCXyaSR4hV5T4=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=WpP8prcFecJKAq3rm22PtrXkHK1xZpzBS8ZRkbiwRbsvk8iea3z641qv7ciiFTLJ4
	 39zOP8N/mkgWF2w6aMPmVgE7rDjLtFg1O6lqBjHQ+3li6OLfDMhUC5pypm+fwkuvk7
	 t8Pi/NP67rtTuGTI98Y6BA5WmtOE5Q0LUoGbPdCI/NXxM0IjlRKXG/GXoXeBFc3xcy
	 raKqwdprv8UcA1DWD+MieqoxBgBKI8gUiXon+h6Yyy97Fic+Yq23cwWlslVCU4KpiK
	 Z3yCz7gC2uthiIAx0IOAjD9cGlIBNAqGNYgpu1ZqM+iZ9SDK6qnQhEhs8wEoQktG4j
	 KcqH+I8yY6nfw==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1F53644E4D
	for <op-tee@lists.trustedfirmware.org>; Thu,  2 Jul 2026 12:23:19 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=I4DFLHXV;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ThwnhFLn;
	dkim-atps=neutral
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662AaKGg3591072
	for <op-tee@lists.trustedfirmware.org>; Thu, 2 Jul 2026 12:23:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H3yAMBOi6v9eV+nAc7eVAGvVNWiyX5n7k7tofn0XxxI=; b=I4DFLHXVXlt0GoIW
	dfrRzLqyw6s67krAgqYSt6uR+IDOUqir3lJqb8cjfvc+WfrR06mPcdrVYhASsGpX
	LDWlAIsxrv6nUMWL7UFHqiKKddhfMNNcBJBnT2vbhL1lO1bmKk4ToK3uezaJLgfb
	vL/DWrGi/mTNnY+cPoI8dtbXSokmFzVNVuswHkJ25BRq2wpCA7pwiPvVjqAzsNuX
	FMcUjrXlY84iazu1GnGFSWFmCuDzcq4Psx1TfYpo+zOw7aAYkS173PQq47+nZpsb
	A+bVUvqbOno3MHvb6oI6bCLcJHH5JYvBxquO0tf15x74MISA0/9SUv10GZob+np+
	n23xWQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5h7n9nva-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 02 Jul 2026 12:23:17 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c2d2dd52eso1535511cf.3
        for <op-tee@lists.trustedfirmware.org>; Thu, 02 Jul 2026 05:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782994996; x=1783599796; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H3yAMBOi6v9eV+nAc7eVAGvVNWiyX5n7k7tofn0XxxI=;
        b=ThwnhFLnUQkAnkvx/YG8oYHSZZ2zQrfyFKTr4D/9X03DGPExuL0PhvvVD/4+PnwNkR
         1p5ZoitTLuG0eXJPBs5iFk2q3y8X6h5AkIR5HwIweOYnun1JQFfYBuQD7SIHrhjDNN1I
         88hOf2tf3mI9Q2rLfF005iFs3mEtpc/S3XmhmoxtwnFE1MJaFsWzyl/AFevJ9l4fgOVG
         V3fXZouuJtV3En2KOPqLu7YK8iBeRy6QKxwXvQcOFMlYkv0L9CinEVy8bO+D8N0Z400B
         nOsoW2t7DfoRbfGZ7wXPClWLdfWb+opBtfRgP1mlEeC+4EcT/4nlpYT/etEbqRoYsBvs
         XLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782994996; x=1783599796;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H3yAMBOi6v9eV+nAc7eVAGvVNWiyX5n7k7tofn0XxxI=;
        b=Wratv2b6G9k+w7GvDJIKxjyqv2JiYmkgEJGJwrS1fov6b54nH/MSKpf/hlefEeS2xF
         kz4ovp9FpuxaiCZYsmXKLSRR46Mn8TLQcBJjXvwMEq5tt8+Rx9BLCP0KxF+oPyn+oZvO
         LjszCHuIPQI0vxucP8PNKOtMoZe8BKmZh6BRbBdRIxRq7wNqG56TWIn+OS993BxEOp9g
         sKx+J7Oz2FPezeqMari3ZQkz7SvWBiHaG56EUtKW6asVpQYV2FDwZzED93QrZe/b15cL
         BhfrIo9kA/2B0qyvhkg6uLufgVCZk8XWpeqd/6d7lR9VnHSlEzr9pdJKFw+dh2fGY4K+
         Eqag==
X-Forwarded-Encrypted: i=1; AFNElJ89nRXIx7ZuqT65uEA0pQZ7BLSsv+W935uPkJ8Hkc/8SWQzl9ZLPE4VHc2zvrbUJJcLbF4HErc=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzA1uLYrJNo2JU1f4nhsHmu/2Ycd7BsmP5FWvVvdzEAobNqTeKr
	x/IEO69iQCdBtXctorzxBL2bFBqaqWW05KlJ6t5stWb/aYVvcn8/bXI2j4m1BiGNLVN2W6qkn97
	MaPk/IdQxkHYAMo0ktrKJwGmvCdq3WmfOb3cN0AF3llLoe0cXR/lqYyskWbKNO2J75JdnZyEp
X-Gm-Gg: AfdE7cmuhX6DKTWTNJGAg7gUfJ9tAcyrQmIbjZH2UIvULw/LGpmnzQmT3W8LuH3YkaX
	31Q35FGdRO+ym4H7RSfR2EKIMO4auAuAGyNDEvXpbKk4xSiXgYCWVq4Wt5ptxv5Jgo1uMzYHL4j
	Q4JAN7QjBs8qVI9HIfacs2fWEXoGU1EvgZ8fgFosiI0LQtreiRuE8s4lLRN38DNjva6Gq2HE/Do
	YhBp/cpCwjQq+wSvghHZ8j+mRg9y+ro48RsJ6tJ8uXP7JDufxIa7RMQ5UvLQTDoWx0cqsYM4gJD
	AQaUqI04FWOvVfVR+nOB3VfTCgnNyRiyih+XK6QWTv8IpVNlvKQk4zr6HmxwCSkRRMX+7YjdML6
	pvHHhrKDGqPPQZ1CvWvpzWRSp/XMQf8hKsLE=
X-Received: by 2002:a05:622a:14d1:b0:50b:3489:5495 with SMTP id d75a77b69052e-51c26b3920dmr46800951cf.8.1782994996215;
        Thu, 02 Jul 2026 05:23:16 -0700 (PDT)
X-Received: by 2002:a05:622a:14d1:b0:50b:3489:5495 with SMTP id d75a77b69052e-51c26b3920dmr46800541cf.8.1782994995674;
        Thu, 02 Jul 2026 05:23:15 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b60545dcsm122833966b.3.2026.07.02.05.23.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 05:23:14 -0700 (PDT)
Message-ID: <a2e5d6bf-e2d7-4252-8e91-1355c481d35a@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 14:23:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 10/14] media: qcom: Pass proper PAS ID to
 set_remote_state API
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org,
        konradybcio@kernel.org
References: <20260702115835.167602-1-sumit.garg@kernel.org>
 <20260702115835.167602-11-sumit.garg@kernel.org>
Content-Language: en-US
In-Reply-To: <20260702115835.167602-11-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEzMCBTYWx0ZWRfX77m+ehGkvSuJ
 tev1oqtfQZmIVoAktcih6mq1RkKmdpCy+km49I2XwWtBmenx5jt+Szh9WbTVELEdDJj/tjT4Pmo
 IMs0tHcEdOwP6exDPMncAAB/DpwB+3IR8af1waarViikgMPAaPvQJPMz/WiTzlZrDD0orXCy8Tq
 YfWGpxUEAaq00vwB8vCY9aC6OLLHPPFxbIWsAw24qNlnjvjM3rTMTt0DsnsRzE5KF/lr6hgCemC
 BSfkIKUYNAG+ZxByu1ZBZrNqPAk7yD1nDWuNTYekFj/15KFqletVVh55C7pgl8Mm3T+1Yx7JgVE
 G6gyEBbnd/2P7JRPeRXiDW9zAE47gzH3nPeb3011S+b7P2zcibuCzeFU1UdhDxqARU9DVDuKth4
 hxezk+Et4/rgpLcvpJqpTD5JrK5a52a9j5l1v/B0xZ9grudAF09JBDMJKz3AhakViTe9H5wGF9o
 GNWquX+Yygr995unI9Q==
X-Proofpoint-ORIG-GUID: GRDGYNu4ftpOUyARhLKBmuGmKLvags_X
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEzMCBTYWx0ZWRfX4b1q7AZvk7eJ
 7gWUuCt7YwAZZvIvXkf8nZUFf4qgewb7cFjT7tcZLAoA6S0LFJZRV6agwg0TIe0OJf4nbRoWMK5
 QX3X0WzNabMhxCjDFPG9WbeSsmKesig=
X-Proofpoint-GUID: GRDGYNu4ftpOUyARhLKBmuGmKLvags_X
X-Authority-Analysis: v=2.4 cv=WMBPmHsR c=1 sm=1 tr=0 ts=6a465835 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=d_vIauj3UwZ4nLxAXMoA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020130
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.37 / 15.00];
	BAYES_HAM(-2.77)[99.02%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	RCPT_COUNT_TWELVE(0.00)[49];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.198:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 1F53644E4D
X-Spamd-Bar: ----
Message-ID-Hash: U5QBR6FSEWADUSJSPOTJ3N7YDYLPUP7K
X-Message-ID-Hash: U5QBR6FSEWADUSJSPOTJ3N7YDYLPUP7K
X-MailFrom: konrad.dybcio@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualc
 omm.com, amirreza.zarrabi@oss.qualcomm.com, jenswi@kernel.org, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/U5QBR6FSEWADUSJSPOTJ3N7YDYLPUP7K/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Konrad Dybcio via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

On 7/2/26 1:58 PM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> As per testing the SCM backend just ignores it while OP-TEE makes
> use of it to for proper book keeping purpose.

It's apparently not ignored, but 0 is assumed to mean video for
historical reasons

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
