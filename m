Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 134C7FCC07D
	for <op-tee@archiver.kernel.org>; Fri,  6 Mar 2026 22:01:18 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 557E7431F4
	for <op-tee@archiver.kernel.org>; Fri,  6 Mar 2026 22:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1772834477;
	bh=swHjPgms4MZhnC7AecoYqmjnZlbvr8+euga4dr04mLA=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=uUh8lo518RjjpcTKxdBzAMfZnKLR7+0OjmXPGoE2u0ANJOy6mIAwcoqKdocRCyjCP
	 OZO1vuqmA8UrFPHioTQklIH2JSXUAH59bk5WsteWdyXBSaQhexu1YvMkn4kNbomIwr
	 8EEkyNPKrvUVj0okHYzEXzHK4WavalRj3qoAIjHa+jf/8ALUj0WPbjGM4jR9AdGvHH
	 84aJgptzNYSbwhifZO24G4A/4tqVH16tWt6tzanDIllQTtA1rbuXnetu6MWLsktAsH
	 OfNBvDGXCStbmJis6+GYYiAxOOl3iixbbdi/ruZ9TPzf2DQcCBMo4GIr/pOQKPt3Pr
	 PxQnXUpF7ckBg==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 07169431CF
	for <op-tee@lists.trustedfirmware.org>; Fri,  6 Mar 2026 22:00:57 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LZFxCCUn;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z3qAX+qp;
	dkim-atps=neutral
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626KWilb2041639
	for <op-tee@lists.trustedfirmware.org>; Fri, 6 Mar 2026 22:00:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gYR9JUD/FzJUCFovVZEtzoQZJUM7b6CyT+PGPqzVdqg=; b=LZFxCCUn6WpNEccg
	RJnzb64jVXdN3+LfB8r8zhZFKZvCxW7dwcQdYCpWhoWQ5zLxLUR1MJomYdDYFV7g
	52tgon9P+7hTkEdj68q9W2y7TrE9cQcZblIsqWVLvUR4AykkuAbEZdh0MT9gpOUz
	yn6Ebl0mn+fs0Z6dg+vdt16RUdTBDUpiWWvlf7fRoTPE4pboJgPsI061h4SS/io3
	Tp1FjnM5LfCpfd+0/fC/vvDevcujlhfid2NYFvI4lIa8Tutb81vWpz2IIkl66HLU
	0uPflehAB6a3WuWNrav5pU+XcrN8ONqkeOcPSYbv0jhXD6lYPAb8BSyHjYt1piO9
	kJQLhg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cqrf5u70x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 06 Mar 2026 22:00:56 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2bdf6fe90a9so8701546eec.1
        for <op-tee@lists.trustedfirmware.org>; Fri, 06 Mar 2026 14:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772834455; x=1773439255; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gYR9JUD/FzJUCFovVZEtzoQZJUM7b6CyT+PGPqzVdqg=;
        b=Z3qAX+qprjz7pWLCEQTjH3KMxYb0WosusC6SK9K0ZOIgMQV9qhOECqU0nl6BeftcZX
         YB0xcXqb/YEMTGjaGnol9gIO2j6pd6bjVTE98M9iLK1QZ+zivaSvoEdJ5kpqxZPrLCqe
         6Y6QBly90CCwsTerP3Pc52rBvubEQnEaUSsxax5d2wOqwd/DAKIRnah5wZ8ARtNeFDpw
         hNubftgqjuFdjZDDVsHGx8h5SnTOFkK4W6ThQX4jPjmQYeeM/NZtDqthOtwlx6o8nRdj
         AM4WRX4KDHRVd4yXyXJPD0aMUCUTVfQHtIQA5wUs3e3ANgRY2sUpM0XSxeW/2xn94zVO
         xsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772834455; x=1773439255;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gYR9JUD/FzJUCFovVZEtzoQZJUM7b6CyT+PGPqzVdqg=;
        b=PWsj1/5V/p2uN8L1x3C0VrfC+1l2engicWlHQ7PxVkMvWgcT6qBBss9ZpWvUBKpHX5
         ZnWz34N6mVwSx5nCU2ZQ38YcGJ13AK2SFLnZ6zFoXLLQ4a0kqcD1CBQEdshcwmVyiiVF
         NHBHxgVrLY4N9KRi8UNjtYRCzWTGdd7PUBJoEzx0E+1ZQJZRV4UlcVrzkSEtzg1C0IO2
         jvszwYbTXznsIDD6J80zp99ce4dXl/fNG20EFI3i10RqV0dBmhwdnUM877IY3g/4PKyc
         L+mwPOS3AFEnJrN41zpMHSGHokVmhxgf7Cmv2Vek9UNcenwYnvXvUpdETXQGJdMARzjo
         b15A==
X-Forwarded-Encrypted: i=1; AJvYcCXQH1xabVyXOWImAB0aK4aHDqUfF6MwGQ59iwB0mlDDSYHvfYgkf9Z6anBvZWe9XohSApad9ws=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yx3xZPuufZHCWBU0yFra6Nv9PrkiJ+d3w7W0Kia3DGdXsh54So/
	PIbTanKyzp5FiYNqID+FrIEkbtahsgoc86Lc2++QTvXvzjL5j1hxdt/NSY5HAPXpf9GHtMhg1dh
	Z9i7EQnIcDxH2jUK7SsN7uuGJVQCauzrxDLIBk8OMyj4xhbLHFzQiqFA9q9rkCuVt1rnIsfG6
X-Gm-Gg: ATEYQzx70IG/Eroim6Sm5WAn76zam0zWbetbGwfapaPy4mXMZAj97CKrwMHtvbZwRug
	vfPY9jryu5KbzZdn8tGP3RByw9QHyS1JMq29HpjZqeKB74i+cc/eLZPlKo7R9sOyfYvG4dOlxtR
	RhM0gIh7UswgNgrCvnnTZExBTrj0uVO6Z6vBy0InghhAAdIOnTgGCg4iIUG9665KDS86vyL7k78
	nLJ37QhfiWGIH1+cgThLLUuuPayqQcBgrUp0nEOW4zPy8IBnYsoxBo40RjFBa0A57MxO4mB/IQx
	3Jc4s6JCHwl5k/l9IvPe3y7e/3OxPTwHXXktXEhv5grsXLw1/pWwznUd19U70RGY+tzkXZtddpX
	+5IsNPc0TA882sGJaC32K0Kdu5gydMzwj8m4/xi+qIf2pPp3n1R8CTjTIBMM0dCjTqt5HaC7Qqt
	HUR7sFlMpgy1Tplw==
X-Received: by 2002:a05:7301:608a:b0:2be:1946:8587 with SMTP id 5a478bee46e88-2be4de8f969mr1272720eec.9.1772834454911;
        Fri, 06 Mar 2026 14:00:54 -0800 (PST)
X-Received: by 2002:a05:7301:608a:b0:2be:1946:8587 with SMTP id 5a478bee46e88-2be4de8f969mr1272665eec.9.1772834452873;
        Fri, 06 Mar 2026 14:00:52 -0800 (PST)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f80cc1dsm1962924eec.3.2026.03.06.14.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 14:00:52 -0800 (PST)
Message-ID: <13091f47-938d-43fb-a8c0-4b081818b557@oss.qualcomm.com>
Date: Fri, 6 Mar 2026 14:00:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] firmware: qcom: Add a generic PAS service
To: Trilok Soni <trilokkumar.soni@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org
References: <20260306105027.290375-1-sumit.garg@kernel.org>
 <20260306105027.290375-3-sumit.garg@kernel.org>
 <e0a86461-c136-4371-99cf-c0b0d31443a3@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <e0a86461-c136-4371-99cf-c0b0d31443a3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: JXE7apGqAdBDh4e7Z3S0XkCqxAfHomyO
X-Proofpoint-GUID: JXE7apGqAdBDh4e7Z3S0XkCqxAfHomyO
X-Authority-Analysis: v=2.4 cv=L+oQguT8 c=1 sm=1 tr=0 ts=69ab4e98 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=JJlnT80H4U8AMWgPcGUA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDIwOCBTYWx0ZWRfXx8YklEdR24PB
 UqU7tpIUjGDZjKjqOceV4h+qhpWM83tu2pexoBwDidRBRQmr9duaJbzXSk/QJmM4UE6OS+pP1kF
 VyzwEfaX1Il+c7jg68mAmD3UW49CgrgRZl/kS8CsrVURQ3ByII7svYtQSS8AZAvqMAsU38cgCse
 Vu+UssOXFnE6fUfPYt+d/GvDNinBvNZaO1I5dkzBlZnZt5wNIZSzhzmL92sc/d/NruSSENdEIOz
 /dfC73+kwksICF1mXwaktaf5OUI1AS7GadMgJWQ+HVk5n45D5Mk/jhjFKnZ89hM5phycEsJKlMv
 AGpb39/Y821QwDrY86hY0mOg/VRsGOEvLls3Aw+sXES7LIzgr0NYO9br9/l/W0i79LA1W7Bx/Xq
 9SCb8YoQk60xp3X3/YauKLfv9yteN3vXBEfVHX5hoKU3hu3xJJlE1/GMT76gMKXqK5EjH2+LQT0
 LZ1rX+fdADBnljNOEUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_06,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060208
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[49];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	DNSWL_BLOCKED(0.00)[24.130.122.79:received];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.197:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 07169431CF
X-Spamd-Bar: ----
Message-ID-Hash: RROWJMLR6XNZ4OHB7PLG6W6ONPXLSZLH
X-Message-ID-Hash: RROWJMLR6XNZ4OHB7PLG6W6ONPXLSZLH
X-MailFrom: jeff.johnson@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/RROWJMLR6XNZ4OHB7PLG6W6ONPXLSZLH/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jeff Johnson via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>

On 3/6/2026 11:47 AM, Trilok Soni wrote:
> On 3/6/2026 2:50 AM, Sumit Garg wrote:
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Sumit Garg <sumit.garg@oss.qualcomm.com>");
> 
> What is the convention for Qualcomm authored drivers? In some drivers
> I find that Qualcomm doesn't add MODULE_AUTHOR. Can Qualcomm community
> clarify it here. I prefer consistency here for the Qualcomm submissions. 

WLAN team was told to not have MODULE_AUTHOR(), so ath10k was the last WLAN
driver that had a MODULE_AUTHOR() -- ath11k and ath12k do not have one.

And in reality it is very rare for a given module, over time, to only have a
single author. The git history contains the real authorship. So just for that
reason I'd drop it.

/jeff
