Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21843C43458
	for <op-tee@archiver.kernel.org>; Fri,  3 Jul 2026 15:07:16 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3FEFB44F9C
	for <op-tee@archiver.kernel.org>; Fri,  3 Jul 2026 15:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1783091235;
	bh=0w/d6iSpR9UaaKp/rDddcaeduOnJK9KBBmjSerbTYtU=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Aj59stFOilIalm/hezd4gjLpkIh3ldomOCFiwE9PB7j8JWcxpNrXd2eTns8lYNHQB
	 i6zLp9IgUK6zX4vT2sGkvqjjFhm6HedXu4T8H3YvN4VcHfXE1nCIcK36rYFhdNsA1A
	 6myCP+zZYBcJIJkbigb7VgYCtKhdp7ce6s5nQwyhCy48gJk6pTe4ni4/0lI5nXwk0p
	 4nDX1ch1lkBd47jvS1qGbPv7aRhx8KRewRPa4h+DWLa2PirioSfkiWYg7r6w4z3WH/
	 R/N36LnubRwDVvRO/G64sZAyabFzXkX45psNF8We8hykxbkwgOMpX5aKokwKucVpY6
	 5390yJpDgUdQQ==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6FA1643A7A
	for <op-tee@lists.trustedfirmware.org>; Fri,  3 Jul 2026 15:07:08 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=I2laStE7;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gcyASr7E;
	dkim-atps=neutral
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663BOOj13109547
	for <op-tee@lists.trustedfirmware.org>; Fri, 3 Jul 2026 15:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g/Y1MW5COel2wWx4p2DALR7RRNLnSVd1oYyWrSpSJXk=; b=I2laStE7JVO14Zny
	RUxphdbyneMw1OsRlTiKt0N99oI1NUu4z/tGStXgdRwGaWC+kYOJ+B0YCoFSgdZk
	3kFuL3t4LyLKsVcAQDoHbZBAdp6uHK+DAp1Lvyg/4TDPszJd3VK2f1OAfufBvxXB
	HWDTC78TO/jS0BMzX1rmYzGuPS6h6LYKvonLQlGWwobLQEmNeTVNVD4wtPSFw69b
	/YWG2WQvs0zTl/iG/65M0nNCwOOvyH982WAl8ISIzOHiWx6RisnoNPrGzuYlQBIy
	r2Ayt+rO6n7GP7/qDetmB7+9Y3D3G/UW048SZ4923U0oQOznFMwLEf/z/Q75j3d6
	OswDTA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f60eybkay-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 03 Jul 2026 15:07:07 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e66fe6152so14504585a.1
        for <op-tee@lists.trustedfirmware.org>; Fri, 03 Jul 2026 08:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783091227; x=1783696027; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g/Y1MW5COel2wWx4p2DALR7RRNLnSVd1oYyWrSpSJXk=;
        b=gcyASr7EbBnTT85xt2hJmEo0wdlfCNBHRPW542wNQMxMNuyUgtLQb5frrXWs+yiOpg
         BvzOsaNJJhCgIrCw3dXKt8Tltq4R7CdY706SgGuDYtn+JLNpITwzLT0swFXnClioIrOM
         E1mKwuBdM51NgKodfnl5aOktnc/MRZc7hgewGhsmkkumYXXHyGs/rmTN+DBQYEb32piF
         pGmVZIiYIWLgMLU4fWNrUbCPVQb2FQuqU6NZW1+wantTV4GY/fTX/VK5ENBfzL00JaJI
         XciSZZwTQUrLK+8PFFXqBZfY4NpeVnFpkC6omlkMAIJT0ZRRFeZSUAU8Bmxd+TaTtJ25
         uXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783091227; x=1783696027;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g/Y1MW5COel2wWx4p2DALR7RRNLnSVd1oYyWrSpSJXk=;
        b=pZqxfjcL9r6QvBFMmJ5xnXKVlsFFhznGLRqPbgN+XTavsmwTEJr9G4tEYJa9Bf8LmP
         4drk5cVihJoder2w3STYxre40IY9C+cLH7jDntcONDEQzCQODn05KPawPA9h0IYiM0Kv
         a3xyq0ww8R5bMBlrPUiLSEyC2ob53YaBHFhTMxBl6akGx7riQ+erDFA50hKsDpncnmkW
         pquMFXgtgB9uF/ofOXoaWX/TE1JVbnd4/0qh1M6SpEZwuEam5mXvp7/BbAbGLaG675ct
         9Ho2XTJrNutZPRRKx+UmTjkR5RnMfADxpj8LPUzJO1AsV8maqbwydDhR/KIMPOw60o9U
         5Lfw==
X-Forwarded-Encrypted: i=1; AFNElJ9vPDyKWIFvwwYmCk5g0Um3R23BlL3heylMKHU9uzAtYDvaMYQdevgFyYOjjrrUcI09CcExa2g=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyBysvEoF22U0OtWDKpvmq1kVamnKlw/IKBCKhv9tt2BqAwyrJA
	szN2wl1NPDBOBmNQE/IPUhcf+S2e/h4GwAlO7F3JOMbVVMBEeQ7D8/TXgboNAmVFVCS4AifQI9z
	JAR0xeOEZWdXVcHddmmLYhMv3RSzEFuvXHqH8OYcU0JjJKb4FCAXD5BI6Wodw/9uFepoRh1Me
X-Gm-Gg: AfdE7cmLDRThWA0TSw6hzXvPoOf9eUTGKInsI7uFOhpNPoY9udBl6064OX9MYCc/LVT
	3n1FdmbZzslkYwcDB9ffbuKUvi3LDH1P2jNXF4ZNAv12OBagN59k47ceBLrK+MaHWtIRS6PvOb+
	IR6gyfScO2quI/x6vaNSxbT5/dwpUQ+eyxxVGJrI2j682uVuLfKLBWyhJQF45TSquhRD0Aumrly
	GlKSluGnXfKz12mAo6dSEUzMQ9vQuDsNnHqP3DcVVkAzqX7OLaPakDmqmcpri+m/yd1MJOIzXAs
	BwbWc5eXYxUrlNw832QKXXkHBCbV9WNpze2kBYRR44Y/lPo4LkKnBdGA15XBVurHLrtxYuT1JSb
	Fxszl4SjU2MXmLD2kCjABXPc0AVWnNMccY3k=
X-Received: by 2002:a05:620a:171e:b0:92e:705f:1626 with SMTP id af79cd13be357-92e784f65a3mr825407785a.6.1783091226887;
        Fri, 03 Jul 2026 08:07:06 -0700 (PDT)
X-Received: by 2002:a05:620a:171e:b0:92e:705f:1626 with SMTP id af79cd13be357-92e784f65a3mr825395785a.6.1783091226326;
        Fri, 03 Jul 2026 08:07:06 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b628d65dsm295433566b.35.2026.07.03.08.07.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 08:07:05 -0700 (PDT)
Message-ID: <a2dd4a61-2585-40aa-9d05-18b66f3450d5@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 17:06:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/14] firmware: qcom: Add a generic PAS service
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org,
        konradybcio@kernel.org
References: <20260702115835.167602-1-sumit.garg@kernel.org>
 <20260702115835.167602-2-sumit.garg@kernel.org>
Content-Language: en-US
In-Reply-To: <20260702115835.167602-2-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE0OSBTYWx0ZWRfX2PeTS7Pw01Nh
 4hcXwZeG68+MCY4s1BZTCpUdPIZBrnVDk2WfUx2orDYDgel3A9LNhg4+2mos05Nf8VkawxYjnOk
 Dif7qJ4ti/4v/7HDcuXZHUJsGyCsU787Xs/6Xv3YetpAwU3cfHOC94yuDJFSnFojQW1xqyXl8Ht
 sBi2BKnKwTxbejmsPaUux6S+N/ZcKZsgnx2SUe3OfO12CMoPCAA47JSsAfDI2Vv/4+ZZlD5Netj
 htPLhBPkWex2/l7tzAIeP+3ciSvmYb2QO2D8YnTkvdpV6SdPqccuafHicHgaod7z0rpm1Sxi+c6
 OR5GfxaGiRvUV2zvZgBQZ6D6iwHFzr15uFIgX/9U9aVjXiQn5JSPzXmidV+hg9aGkPBFmiwvh3y
 hYRlfVEv/zmxtX8UhDGutaLcUldkJaDcCS/n98zhmb9UgQ7NVBM86/f/R47VS6ONprCYzJIpPMj
 t4jkKCZu5/XtUS5eJsA==
X-Proofpoint-GUID: VBvawVZaQOyDbjjO-87VgMjHrDRrLUxd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE0OSBTYWx0ZWRfXyyna0TXYplIZ
 rI42i+SQDsaUy0GNVOSaFQ8jF45/+DA6VYsvjcLZGLHQFiA+rdPDkarC+S4m5M5Wk7E0xZDp/Uc
 HLGMlePN8HI9wqS5oA1fbB6ACyG1M9k=
X-Authority-Analysis: v=2.4 cv=SPRykuvH c=1 sm=1 tr=0 ts=6a47d01b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=DWWpLck2SfFL7czMIZ0A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: VBvawVZaQOyDbjjO-87VgMjHrDRrLUxd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030149
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.49 / 15.00];
	BAYES_HAM(-2.99)[99.96%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	DNSWL_BLOCKED(0.00)[178.235.128.140:received,205.220.180.131:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_GT_50(0.00)[50];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 6FA1643A7A
X-Spamd-Bar: --
Message-ID-Hash: TQNMHXZ6KLJYXWCNTSMTJOXQQ5N4OJQC
X-Message-ID-Hash: TQNMHXZ6KLJYXWCNTSMTJOXQQ5N4OJQC
X-MailFrom: konrad.dybcio@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualc
 omm.com, amirreza.zarrabi@oss.qualcomm.com, jenswi@kernel.org, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>, Harshal Dev <harshal.dev@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TQNMHXZ6KLJYXWCNTSMTJOXQQ5N4OJQC/>
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
> Qcom platforms has the legacy of using non-standard SCM calls
> splintered over the various kernel drivers. These SCM calls aren't
> compliant with the standard SMC calling conventions which is a
> prerequisite to enable migration to the FF-A specifications from Arm.
> 
> OP-TEE as an alternative trusted OS to Qualcomm TEE (QTEE) can't
> support these non-standard SCM calls. And even for newer architectures
> using S-EL2 with Hafnium support, QTEE won't be able to support SCM
> calls either with FF-A requirements coming in. And with both OP-TEE
> and QTEE drivers well integrated in the TEE subsystem, it makes further
> sense to reuse the TEE bus client drivers infrastructure.
> 
> The added benefit of TEE bus infrastructure is that there is support
> for discoverable/enumerable services. With that client drivers don't
> have to manually invoke a special SCM call to know the service status.
> 
> So enable the generic Peripheral Authentication Service (PAS) provided
> by the firmware. It acts as the common layer with different TZ
> backends plugged in whether it's an SCM implementation or a proper
> TEE bus based PAS service implementation.
> 
> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
> Reviewed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> Tested-by: Vignesh Viswanathan <vignesh.viswanathan@oss.qualcomm.com> # IPQ9650
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
