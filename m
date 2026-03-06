Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802E2FCC076
	for <op-tee@archiver.kernel.org>; Fri,  6 Mar 2026 22:16:37 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id BE4E941937
	for <op-tee@archiver.kernel.org>; Fri,  6 Mar 2026 22:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1772835396;
	bh=ozp5w2u9J7nebog4KwPAIQaw9Q3GF+gWT8k1KRnFxn4=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=yO6XMcBc+qnbLw/CFXKGLI+brWALlOx3jvP3D9EEa/7ozc9kaWYADQeHik1YjChUW
	 CneOUzs8+kEIgwCu+/JzySq0Z80/9dmiJXxZP0ZpGMMKevgtz3WcUwUZarmlEKPchU
	 8pzlz9fnO0+K1jGsiJg5QbWpXurliOF2PRdkuFTRilDATK4MxmXpIfETl4TLmvkJuf
	 sZtdhI8Hd045ws3OKH3wig2w+MHBLSLh4FZvyRYYND6ZD42rlm0ZJ6mVKJtdJ2ieHU
	 qRbrbSNyrlbee0QyErmLtwhLbETMMl7QXBH8jKtppVNVNsCE3ZytwZuXro81zQTy/E
	 +uE3qFfxgePiw==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4646E41937
	for <op-tee@lists.trustedfirmware.org>; Fri,  6 Mar 2026 22:16:17 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SfSjst4G;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=e+IPTSfI;
	dkim-atps=neutral
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626KX0272042182
	for <op-tee@lists.trustedfirmware.org>; Fri, 6 Mar 2026 22:16:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i8xe+5eaNei8a3fpTPt0x8f/YBdZqjrjrkxNfSV82tg=; b=SfSjst4GB8hij3Ya
	xumyToC4COQ43yIm2aQSarzCnpo0ypGv1UWid+nyf1aAiMF0Mu+lt8Jlnh6wZEzC
	z4nAMHqTQKPfGzFi4Ldw17z950DNAf03OiMcQDe7wwE/yO+WD8U5uSjNlAz+xe+E
	DI126rXVobs/QALLHK6ZUrp94YQkgg6+6YV5FIgosf83knfO3y+5DeVGfbKpw505
	0N1VQxl+B1ZgE5cgBtv5aVouUiY6VafcBs3QVFZGcpXdHBxf4sdQkDacB7oeO5Xn
	213NzZUpLBiKTugTF1ByolEGCHvJCbJb5CxMg1cmT9VYtIEhF2oy8+NVVw03lLlg
	Bzz1rw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cqrf5u83j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 06 Mar 2026 22:16:16 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2bdc1b30ac8so958390eec.1
        for <op-tee@lists.trustedfirmware.org>; Fri, 06 Mar 2026 14:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772835376; x=1773440176; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i8xe+5eaNei8a3fpTPt0x8f/YBdZqjrjrkxNfSV82tg=;
        b=e+IPTSfIk2OV9omhrjWx4CGVaDKE8Lh3KrDj6XjMJpAYt8BmejV6yGX3iatcEJqYM5
         MDws/cOsyBdMBl2t2eSQsnvoEvKPaEOOFkrs0iWN0QCdbGYVVDpZaNIT6Bpr4XMWC3mI
         TcPHs0viiuKDzecheZ8xSCcOCIQrS1Xi3wU5kNa55kJkdp9Zu4D6dUH1/I6W5wnQVoBz
         zYA+OT5LeJ6FwXaKds6hSyivvu+wiW6hbMflZAAX/GbiTuHvrvohI++T/Zbvp5igEObd
         +c2rIiO8Gp3m6UoeOa4eIbo4NwxkZppduWmh9lys/VdKaerWl0RR0KwsW8oK+dKs0QQ7
         C6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772835376; x=1773440176;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i8xe+5eaNei8a3fpTPt0x8f/YBdZqjrjrkxNfSV82tg=;
        b=luprhO96hmWvwOxkR3qkBIFmia2L12jvIcSDTo65ONy61Wc5RulLQE29NQjwxpB9DJ
         xTL2yO2NHmITS8ROXbiI19clXI1n4PT6rAUJD+lrd2KDjn/+qfnAGOTp+dTYDoSzMBtd
         DYwvEi/vXAOMocftxhKtrRG7HSI/DSE7Tz3YjmOGWw6xW6iZw1HmFZBiAuv6olugs2ni
         nvieWd0sr5kfSLANWdQKryUir29EwO2S5LFMM/1OD4ynPzuY/HVNU5HR6DjmD1tYW1+S
         Pu4/gPPmwIqy83xMUHRLuvd3I2qFmYvwfNomXDGEnV16eXPwmoK2l1KYb7Vyg+EYBylI
         UX4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWV1QypLm+gyTuY+dZ5sq8lH9M0YGgKEv3N4DwYtHZXTR+ltiS3O7xx9f4AXHc4Pj+Ig+uW3tQ=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yxmb9pLUF7vF+YxuCHX12X6d6ivHEt4tixdOnXSoDryJjWdhny5
	t16tHCtNhMIK1p9BWYi8hLl75msE3FdzyN94b7fPqR7xrN1wUqNiXqz3irB16cZ2x/jfv8UCvIq
	T+YXBd9R6cqARHaSP6rXSNhGbFhf3T0gRnCBkRh5hwTG9OqUc2rdULv6Ge72t+8JWA81UBF6c
X-Gm-Gg: ATEYQzwGoHvBjnVXko3ASNDCwWc7X+88TYcXP7AdA0/RDUY8hxxP6wSbN3aCQO7EfRe
	KEANd2HYQQKMrHeLMHfjQF2BZUTKULktHAKWKrTBwJiENK7PxD1IoXR7ePdAIfYcmYEjF+efjp0
	HicLm1YcJ3TFe2DSoI57p/NFcXGLfaaI9W5coWgtl0EE5p2P9ho1xiZWin/KF2uravKz3JPYcnr
	1M9rFXM88/+M1VLYtJ5MjrFDiLBt75J7X8vzEIg3mugGEc+4FzsHUkhGI/8LOz7cwRxXiw2NLM6
	5LORO8F6rHeSofGs8L9Bg08a8bwiluJ2oVkkRanrP3qaraJM68Rv7Jzxs2mNOTBtCutSDIN+VAH
	ZQpTQz/aIqxi3bL6f7EHEK62Wu/fRXdX5Ddwn+giv6hIXmxxcb3qwz0MgZO1FaE5AFPKL53hiRU
	Mu0gY9
X-Received: by 2002:a05:7300:641d:b0:2be:1b95:2400 with SMTP id 5a478bee46e88-2be4e0655c8mr1446277eec.23.1772835375690;
        Fri, 06 Mar 2026 14:16:15 -0800 (PST)
X-Received: by 2002:a05:7300:641d:b0:2be:1b95:2400 with SMTP id 5a478bee46e88-2be4e0655c8mr1446255eec.23.1772835375083;
        Fri, 06 Mar 2026 14:16:15 -0800 (PST)
Received: from [10.134.65.116] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f94823esm2301765eec.20.2026.03.06.14.16.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 14:16:14 -0800 (PST)
Message-ID: <f825ae05-6285-4d10-9d66-578fb1221495@oss.qualcomm.com>
Date: Fri, 6 Mar 2026 14:16:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] firmware: qcom: Add a generic PAS service
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org
References: <20260306105027.290375-1-sumit.garg@kernel.org>
 <20260306105027.290375-3-sumit.garg@kernel.org>
 <e0a86461-c136-4371-99cf-c0b0d31443a3@oss.qualcomm.com>
 <13091f47-938d-43fb-a8c0-4b081818b557@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <13091f47-938d-43fb-a8c0-4b081818b557@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: pzCgiIniWD43I96o7-U_I60XYgo3rGap
X-Proofpoint-GUID: pzCgiIniWD43I96o7-U_I60XYgo3rGap
X-Authority-Analysis: v=2.4 cv=L+oQguT8 c=1 sm=1 tr=0 ts=69ab5230 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=Js8INul6CuAu6eKS1T4A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDIwOSBTYWx0ZWRfXwQtv/KrFYQHZ
 R0up5DEG0JNH5Ho6M+PncMznUcHDzvlOBJn8pE4xYwBNXuJMGUCPTgaeME3mI70MHRyNihMVBO1
 sUWYAgc9biJxgth2NPnBpo/n+g2fBvyIp7mqbYL9fdaAMMAbgpGk5yLQfNoLmjTtqPIPOXGhBl8
 M/MS6NZYqGbg0tzR62aX/aMVCPfbH5mE0kRoCMRnDb1yZl9suJuYH0dW7TLedECQ4QfyZk41jMj
 s4+52+4OiA5jfd+B+8ynHG/YUeHADCEzk2uBocq1852D5k3n7N+R7cF8u1jeNAQIRyO22p6MAb5
 Xg5CH4Wb1jZTRIR60ukUq2zZm+2s7jDYmRoaixLKt/v8sPUCO774c1xzf1u8MW1ZHJM0X0bLmHT
 mbf5bidHcbh8un0AsY50pAuEo/pKCRpf0qNrj6gx3qwX4AmkLJGpN4qxEJV38R2KVc+hWDjOEVX
 h/+mCBwdqgjX8jc1NdQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_06,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060209
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.30 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_MED(-0.20)[199.106.103.254:received];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	RCPT_COUNT_TWELVE(0.00)[49];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.199:received];
	NEURAL_HAM(-0.00)[-1.000];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4646E41937
X-Spamd-Bar: ---
Message-ID-Hash: VXPUJUFE4W7L6GKPBSKIGKFXWQDSGTCM
X-Message-ID-Hash: VXPUJUFE4W7L6GKPBSKIGKFXWQDSGTCM
X-MailFrom: trilokkumar.soni@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/VXPUJUFE4W7L6GKPBSKIGKFXWQDSGTCM/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Trilok Soni via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Trilok Soni <trilokkumar.soni@oss.qualcomm.com>

On 3/6/2026 2:00 PM, Jeff Johnson wrote:
> On 3/6/2026 11:47 AM, Trilok Soni wrote:
>> On 3/6/2026 2:50 AM, Sumit Garg wrote:
>>> +MODULE_LICENSE("GPL");
>>> +MODULE_AUTHOR("Sumit Garg <sumit.garg@oss.qualcomm.com>");
>>
>> What is the convention for Qualcomm authored drivers? In some drivers
>> I find that Qualcomm doesn't add MODULE_AUTHOR. Can Qualcomm community
>> clarify it here. I prefer consistency here for the Qualcomm submissions. 
> 
> WLAN team was told to not have MODULE_AUTHOR(), so ath10k was the last WLAN
> driver that had a MODULE_AUTHOR() -- ath11k and ath12k do not have one.
> 
> And in reality it is very rare for a given module, over time, to only have a
> single author. The git history contains the real authorship. So just for that
> reason I'd drop it.

I agree and that is the same guideline I follow for the drivers we write
downstream. I just want to make sure that we discuss it here. We may not be able
to find one single solution, but I prefer to get consistency for Qualcomm
submissions. 

---Trilok Soni
