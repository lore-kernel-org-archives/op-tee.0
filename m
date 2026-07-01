Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABCCC43458
	for <op-tee@archiver.kernel.org>; Wed,  1 Jul 2026 11:11:06 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 582A944F8C
	for <op-tee@archiver.kernel.org>; Wed,  1 Jul 2026 11:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1782904265;
	bh=Mss/+zmnFuj/GcEk/8iZUOhnCUHq9IN+s8ytgh3BqH0=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=GaL3n/54XJyBzdu3u8B4ltMYpaeZ+uZ389Z8Z0MLUOgQJvWYm9moCURb10vEr22pR
	 3e9v1VHbnGJVQBolmt3+9EdPkKMZhNXnwAYmX0xjOuPySv254+jQrbWeMtbK6fRDWV
	 H/oX4q7/hROcbdw2IDdCRuZt81oHUpf6uY8tVfQ2zN56B8QmTEHLLYGV2Eb8YoWrCI
	 4/Kq3eN/gpqfw87iRuwVilsewjZx3igR68XfxvT0yNmwUW59NIbb4jPOJ7zXkTDWjL
	 0EErhPjP1zd4aj6xSxsS8J/yNV6Sm9CsB8UGGTA9F86BePTFb7Y8hvDdBb4Q5oo86X
	 GO2TxogKKauqQ==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A19D24498F
	for <op-tee@lists.trustedfirmware.org>; Wed,  1 Jul 2026 11:10:58 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EiVY6z7c;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HL/iZbjy;
	dkim-atps=neutral
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661A8RJF761296
	for <op-tee@lists.trustedfirmware.org>; Wed, 1 Jul 2026 11:10:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n5nBOf/Ov1F+rraEj62zHawTRB/8BjMFTvGV2tnm9N4=; b=EiVY6z7c4AclhJxv
	IjydyH+Cf8APmGkuVaT66N2cKfurEuN4IifGkWx74mHARak9ukggNmPfdqugDsc/
	jbMa3p+k64vQkZ76ffbcdebzndLfIVYO0bnFRSykzIvsd8t+mQmKLWuAowNrWiIu
	o2kSM8Vs8TO+emdmY3tkXQEku/1WkpkUYKJCyoE+FVfZlzIur/hxrub8JBCNXlPj
	L3caq2QjgybbdwaC1QRAGosiePnSltCTrmJozbzWw3+EUbdZWH2ljPtchgjGssHm
	muLzoeFipStVoy+j7zPbClKblFd6XHlaLLivvkoVXLUWnGFBhw4wURAD0a7wHw0d
	a1wavg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4kgw3qmf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 01 Jul 2026 11:10:57 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51bfe75b7dbso1172061cf.3
        for <op-tee@lists.trustedfirmware.org>; Wed, 01 Jul 2026 04:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782904256; x=1783509056; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n5nBOf/Ov1F+rraEj62zHawTRB/8BjMFTvGV2tnm9N4=;
        b=HL/iZbjyVplVkZ4tWZ83cQns24/AXHa6WhyhQimxOcdf0vIbs2uKZ3FZ+3l4uY264i
         lNL1CCzTgNddHugiypPM2g4McqhCO/QprwfQfKChC2FX4rIUpkSo7Xmggf3cn06y+4Ib
         ZU1UtmKHeil/x8Iqj9d8WAhPBQyaD3coe9kd9ojotJJWbTom5Df6fA0mlHxpb1umjEQA
         QYkIHdl2HNQofjjtUmGSZTQcwy8la4/VXtiprQeqo8ER+YkIFszuPn7ksczodWX011dg
         bg0NbV/6uEFx3GD6iSn5882yMk4bW+UqGSUEbAES8LBL9UGdDXdfZqhij3dzq6e4zAB1
         cGMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782904256; x=1783509056;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n5nBOf/Ov1F+rraEj62zHawTRB/8BjMFTvGV2tnm9N4=;
        b=a8vJ9tLnD1kv4C/zewVcWcVqnS9FUKQoQc8XRV+TqQbOT+xvzXJUyCnBVIcC/U5WwX
         aGNT0wCq17esNHdnwok+1xfpuHXUMjRH9Gxoc64pNlQ3ePhMs4X5ECUhDbhsv87E/AS5
         39jAieGwnMJj5oxkzdTs5Y4w86QgkCe5B+8T4mernTRU650ZwPcjqIz/4odFriLhwZNx
         7mhrF8zMqVlP8efWP13mn3E3pguSbZ1n3Z65TkF4RevP94V2vEirGxXeD+csIPB28NWN
         BfzOalbjC84dayVZTARO7iQscd70R0og5noH7aI/IGFwdApX5rgN13DrG87WDBMyFV3U
         GRPA==
X-Forwarded-Encrypted: i=1; AFNElJ9tWsg1aAeQfNwnbZUfCqf1uiatOPxwHPLfwct90x0ndr2CqWGyaN1hfsilCwoOrxIlh93riAc=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyvomMTEKFcK5brNh5+uIoETJ0Glk/KKrjts+EsDzA9R3EFT2zE
	3o0NOzF9W9USj/jEODHPcx9hOwxKOvyAhdt8gNSckaRGpLvKmGvJHXYtkieap7P0xHGBDlReCyy
	lAYLFUt2W33BtEj0YBG73UdwStXE1127lm69mEcvqOMmcJvumI1BfJr+wNyKJMAOIZuokq0Cz
X-Gm-Gg: AfdE7ckaSRvjSifctQpLvFP2xygTtmSLeGGbe/AWBQ/KIR/cVzbDKosKRbR+5xt/Gy/
	1JVmGP7hOT+M1fx7RM6WX6pRMJfwmNOsKcVMgNxesQbiQV1jO50mj/6tcjTtJv1rCq+uSJUBj3z
	D/K/TDHtINbpq6Q+6/4pyVzJnqNO1nJQGnLOxdNRxdaIZayqYxxI5iCWwVFQk/IrkGIbSnD0hhc
	G/tBkD4UInNi5LsjeR5WMRyJ6nppvXv2lseSVll5acySybCtArffPQ6OPT0LF2L79HslSclZC8r
	J6G0JBqiAOTowVQDiak09OyElQAGRDw836Lv64ivURpmsQjn8XZ1fQN1itCqIiwFZE5DjTNAFyl
	iyKd67KDr5bNi13kb3W8xW1t3WL8Ag8wVrfQ=
X-Received: by 2002:a05:622a:164f:b0:51c:d16:b498 with SMTP id d75a77b69052e-51c26b4ff5cmr8481741cf.10.1782904256301;
        Wed, 01 Jul 2026 04:10:56 -0700 (PDT)
X-Received: by 2002:a05:622a:164f:b0:51c:d16:b498 with SMTP id d75a77b69052e-51c26b4ff5cmr8481381cf.10.1782904255890;
        Wed, 01 Jul 2026 04:10:55 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6987c3b5ba9sm2553522a12.7.2026.07.01.04.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 04:10:55 -0700 (PDT)
Message-ID: <392d38bd-8bc8-4567-a79c-dca7a1bb8e34@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 13:10:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: qcom: scm: add missing IRQ_DOMAIN select to
 QCOM_SCM
To: Julian Braha <julianbraha@gmail.com>, andersson@kernel.org
References: <20260701110344.1999068-1-julianbraha@gmail.com>
Content-Language: en-US
In-Reply-To: <20260701110344.1999068-1-julianbraha@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=Co2PtH4D c=1 sm=1 tr=0 ts=6a44f5c1 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=46PZNAZc7cL1ucK_2EcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: JBh7Gel_ERs0YCriRj8faivXXvkDLsvi
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDExNyBTYWx0ZWRfX+FNGQJhqhGNq
 rN0R0eo76zpXMN2xYJ0cosZVXsaMbQ8PFhudHjVoYXOaSRrHtBWCBMaCPZfH9w1+ebwiZpaFGEl
 /NzpxkuOcF94KyPojjNopq6MBVZr8xM=
X-Proofpoint-GUID: JBh7Gel_ERs0YCriRj8faivXXvkDLsvi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDExNyBTYWx0ZWRfX12/HBtfMVXyU
 KC8S7pe1W54Oiz1bqzJ4DbtH7cVACTaqevx6odWdSnvIib+n58fI0RStugdM7vzymnhmJk9eIMi
 URkK6N8LIco9ndzzhENNodiWQ8D72MH9QZzdFuyPLgn6RU5MfV3KTl+5LV2raNvHSSGSkU7xYyV
 e8rNJFPJrmLiWrtd7P/XMdfw+b0nZKVCOWsku5og/zezI0jws24Ygdk/VYUqJx/0xQLiOFg9snm
 pQTjw0R+kwG6cTIXP3yHCOAwGGd+UKVfTguivF9QF3Xl605P038jrDAvLi7Toy0M6R54y2ttgEu
 JlcyrkW7g1r2+HRZ6xCoVfIz2rJ5xs03s/FJVeDY9ahwCYJwprs2E4JxOKm7UtrkFXK/E91Mv7X
 3ow/O/F2NNQA0lJJxSWUFV4vsWiwJ1c0gsbkATLwWJz/uxjpfF1+1vmdXPTnilZnW35fh+lm6n6
 Hy5p87/roG6FbEeVfPQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010117
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCPT_COUNT_GT_50(0.00)[50];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.200:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A19D24498F
X-Spamd-Bar: ---
Message-ID-Hash: JR3RLIFHY7SIWCLK4T56LCYZOJXTLCEF
X-Message-ID-Hash: JR3RLIFHY7SIWCLK4T56LCYZOJXTLCEF
X-MailFrom: konrad.dybcio@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: sumit.garg@kernel.org, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.k
 andagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, sumit.garg@oss.qualcomm.com, harshal.dev@oss.qualcomm.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/JR3RLIFHY7SIWCLK4T56LCYZOJXTLCEF/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Konrad Dybcio via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

T24gNy8xLzI2IDE6MDMgUE0sIEp1bGlhbiBCcmFoYSB3cm90ZToNCj4gJ2RyaXZlcnMvZmlybXdh
cmUvcWNvbS9xY29tX3NjbS5jJyBjYWxscyAnaXJxX2NyZWF0ZV9md3NwZWNfbWFwcGluZycNCj4g
c28gaXQgd2lsbCBmYWlsIHRvIGNvbXBpbGUgaWYgSVJRX0RPTUFJTiBpcyBkaXNhYmxlZDoNCj4g
DQo+IGRyaXZlcnMvZmlybXdhcmUvcWNvbS9xY29tX3NjbS5jOiBJbiBmdW5jdGlvbiDigJhxY29t
X3NjbV9nZXRfd2FpdHFfaXJx4oCZOg0KPiAgIGRyaXZlcnMvZmlybXdhcmUvcWNvbS9xY29tX3Nj
bS5jOjI1MTI6MTY6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbg0KPiBvZiBmdW5jdGlvbiDi
gJhpcnFfY3JlYXRlX2Z3c3BlY19tYXBwaW5n4oCZOyBkaWQgeW91IG1lYW4NCj4g4oCYaXJxX2Ny
ZWF0ZV9vZl9tYXBwaW5n4oCZPyBbLVdpbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0NCj4g
ICAgMjUxMiB8ICAgICAgICAgcmV0dXJuIGlycV9jcmVhdGVfZndzcGVjX21hcHBpbmcoJmZ3c3Bl
Yyk7DQo+ICAgICAgICAgfCAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
DQo+ICAgICAgICAgfCAgICAgICAgICAgICAgICBpcnFfY3JlYXRlX29mX21hcHBpbmcNCj4gDQo+
IEEgcGF0Y2gtc2V0IGluIHJldmlldyBwcm9wb3NlcyBtYWtpbmcgUUNPTV9TQ00gdmlzaWJsZSBp
biB0aGUga2NvbmZpZw0KPiBmcm9udGVuZCwgc28gbGV0J3MgZW5zdXJlIHRoYXQgaXQncyBzYWZl
IGZvciB1c2VycyB0byBlbmFibGU6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvYWtT
XzZpenhyaGdLLUkyMkBzdW1pdC14ZWxpdGUvDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKdWxpYW4g
QnJhaGEgPGp1bGlhbmJyYWhhQGdtYWlsLmNvbT4NCj4gLS0tDQoNClJldmlld2VkLWJ5OiBLb25y
YWQgRHliY2lvIDxrb25yYWQuZHliY2lvQG9zcy5xdWFsY29tbS5jb20+DQoNCktvbnJhZA0K
