Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 999BCD2E022
	for <op-tee@archiver.kernel.org>; Fri,  5 Dec 2025 07:40:21 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id DD16150018
	for <op-tee@archiver.kernel.org>; Fri,  5 Dec 2025 07:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1764920421;
	bh=SLsz6o6wa/A/P0AmVUwGqP/s2249k6OtNsqnIfJUor8=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=JBvVea+PUM5SHa3+nWMLRcOfiU+LHOOuWpOnGfuwQXqHYFBhL4MRYq2IQAsdLF3bY
	 RCmrZKQbPfK40SOKntCIlRxIlOVpMzbQGZAlpeo4LARqB+Zqfx2ZYowROoZNOsCOWi
	 FzQLyqGc7aXREfp6cO3Co7KvKh1eBM+qtX2cm4kxem/UDLvUuC9YVIoBI44+7jjhNI
	 ssqA9JpVbRT/HEYAEjcd2sN5d4UV89ats0OJN5dkj4LaPtqGYy2+3r0jtccCAoxJrW
	 Z1d++PYkTjf7H0rQYc8tgXuyWomW+l6S6iCJ2hZLGKZUGk1MOAvP+IJaWkgvPoKhhm
	 VYAKcnZIbzUqw==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 65BBE43075
	for <op-tee@lists.trustedfirmware.org>; Fri,  5 Dec 2025 07:40:09 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kApchRGN;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=a0AsMso9;
	dkim-atps=neutral
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B4L0oR02410859
	for <op-tee@lists.trustedfirmware.org>; Fri, 5 Dec 2025 07:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HJSeCF3At/m8hRrOOTpm1A6c1bw23oILf8ssK/HbvzA=; b=kApchRGNLosqa9TA
	mYIY5K/3a3hzb3OoiWS7qWwdUQDzLipMZqYTg84w8+bhQpSkM4v5BmK0Qp6YsnAW
	I877U/U5HPMHYyJIf+xw9ZI2eQ7W9Hu6xlhmuuIJODU/tgbyyPM9yAFSoMJqjJMB
	wuXCSP6IT9n2pCHe7A8bTuXEDMS8XUf15Gj1vAutnapXyDB6Ph81zdC+gJ6bM9ke
	4HNGZtG5YQHkeCMh3yyG2BM+PZqYzIU1ZwjtzXL5g/VlWpdQyNiIfeIfzg2L7xvb
	2Jv7Fz8xKS0gC+0q1yrgm+5oBG1xqxltESck9i6j5ct/05cgqK/tLNhXoW9b6NeS
	+sNrPw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4auhty9cp1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 05 Dec 2025 07:40:08 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7b9ef46df43so1929243b3a.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 04 Dec 2025 23:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764920408; x=1765525208; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HJSeCF3At/m8hRrOOTpm1A6c1bw23oILf8ssK/HbvzA=;
        b=a0AsMso9gM0n7xjSBCKugWt+bWe0k2v2pAIzwhJnDNCi81L3LO19FF3qc8hVfvg7Ry
         jQ0xp4cX9E2du12hVMz/H9Ao6LuCCa38xpwKiBhCWexA7b9s0OHXBsr2DzlCvC03ELHN
         fqVb5JVPSiszFjojgkVroUMhCo6hLZsVasz+FgKJfQ8JFCjL84Q0hhhRnjoaIbJRaXik
         cNTRDorPyzDNE3cIS4TofrF2gamQH1vUxgrizidTsD/eyFHpoqZKWacpLCeubwBBCTE5
         vypNKgu47Pq2YgIbYns1gydLIKQCl3WCB7ghy3Py8yH5OPP03cL34hhz72qbOZiTO+7Q
         wWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764920408; x=1765525208;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJSeCF3At/m8hRrOOTpm1A6c1bw23oILf8ssK/HbvzA=;
        b=mULugTmS9enR6Ue+QLAXmWNlK1Ym4bpFcNC6eFLi5/mwx5PUcSLQLv2H28yhDxAlCb
         vW9rSEKGgppjw1bm6h+8X74kgEPrMHgrJoSHdYj30oS4dBZo4rVxioJ8DSgr5VRUrAQd
         GjS0Sba62jDr1/er+1JzgD0+nU/CABwHpHVAfauW+rxtNLN0JLEUnAt9DMtKQCJmFBlT
         CpOoYZjo31a92ooDdkdboDLm+X8ExGRjrwKXeWA3pBwCXeR7DamNDcSLG2/wj9WhUhfp
         qIMS6TD2CJSselhkEDXV6B/Qyf12WAsPPHkQ5EbEVn9Z2det0uE1Xi1wFm901mKjKA+9
         ugcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeLG2DfG9jXIP2cJ/K7FWc5fNnN7/whdyUrVuxe6uPw35m0mH5CFam3qkV0vSuF6JGl5XWMTY=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzxkNuj+2OImNTBt7Cp4GC3NH7qwELVsZ7rZqRmxLQMvpwcyV/p
	6TrlhchgAT+TxKJT3UMZHtL6nAeiVfFi6XrJEA9zdzBQxtZ2wgOm2PioetfoyWf/Hcmk6dXAyXk
	2dbwXTudwPwY/242BokWa6accR3P2fyKV7kqKVppc7laeT3NKinSKvVQwZ73Ru6Mr17HkM7FI
X-Gm-Gg: ASbGncsGZ0cmJtz/mgCyB9kuS4XCrWfO0RbWqf8g31Z28rXGq0lbdUgbE1Jf073K4m7
	1ebmQ8KU8UWMqbugY1tXpGqOn9aZdq054XxcPR5U6AmV9Oq9Pp2YsDG1xDJB0M2kmedGg2wjaeu
	+LiG3JIyXpsWIA65m7P6EyzHKBfZUJG0r+hY8AWJ3Su9eQBP4tvUWmjAH7cBxCLaTvqxuorpYbw
	TDoI7PAhQzLplva03BYhYY0HHjbUYZQtFdGr/ADsNOVi2PM5dW4zslDDj/+2qdEE7bXIxzv7FCR
	ZY60k3SQuRwmiU/M7rnoQR7U/drnQwoim7snKNmRlBOWijXWmRdhq/o7feDwxGPArc6UukSjqF9
	VBmImUgD9vyL+G1KZGhBQyDtNywqvzCov0UXmBLj/
X-Received: by 2002:a05:6a21:e081:b0:35e:5bcd:8310 with SMTP id adf61e73a8af0-36403841430mr6570369637.32.1764920405847;
        Thu, 04 Dec 2025 23:40:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPWks/H/75t2BiFU0f23jInK41OxLq7XlnRv/M3i1f+MsJTZDK+kxtGTDwgRWMG2zUQvfk1Q==
X-Received: by 2002:a05:6a21:e081:b0:35e:5bcd:8310 with SMTP id adf61e73a8af0-36403841430mr6570349637.32.1764920405394;
        Thu, 04 Dec 2025 23:40:05 -0800 (PST)
Received: from [192.168.29.116] ([49.37.148.233])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf6871f4d95sm3784817a12.14.2025.12.04.23.40.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 23:40:04 -0800 (PST)
Message-ID: <8c7cff73-fd42-4dfc-ad5b-265f8f09404f@oss.qualcomm.com>
Date: Fri, 5 Dec 2025 13:10:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: defconfig: Enable QCOMTEE for Qualcomm SoCs
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
References: <20251202-qcom_qcomtee_defconfig-v1-1-11bfe40a8ea4@oss.qualcomm.com>
 <ba60f51f-7676-402d-b602-c327d7496f34@kernel.org>
 <0196328a-86ef-48ef-9ea6-afbad520eb4f@kernel.org>
Content-Language: en-US
In-Reply-To: <0196328a-86ef-48ef-9ea6-afbad520eb4f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDA1MiBTYWx0ZWRfXx6FpB4MzSwoK
 TAOVrryqTmWsqg6bhM8JGsfaphau74VffHoqpTXfem4rcd1vVfU9dWDg0EmqTpMenQbH/CCNDWG
 88BkUXsnAeue/bF06kO5rNbKJl1ue2ugHsz8tCYrOnft8hcD+7EQ5j0q3n+2F5ezYor7bVmVSuA
 Rh3RsMu0MqR8bdNtaopFlDlLjdqcPCb5g/j4uB4/XI6ue1HSbOMcotIvG46psQX6DZVtzHAIwtp
 CP2Xs0vInBhC7LNPhpWRl707LtSYmeiPcLt+PPlr+JsGuYLkluzF0BwUn51MYmXJ1LcbYOBT/zB
 6Bl1iZTS6Nfq9AKyWtkGHi/59EjbEZUMpxT1tYlDpyUkxjj+QJGKUgxZZzR06Haf6BeoVvCuawk
 SWdh4Tj4I8ad/UBCxdTwbrSFMTgHEw==
X-Proofpoint-ORIG-GUID: M7vVaDrVFjm66MOU6TiMcDZLUbkYLRZO
X-Authority-Analysis: v=2.4 cv=DplbOW/+ c=1 sm=1 tr=0 ts=69328c58 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=v+kbWGyw1T97G6+vs1uYIQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=dfP7lP9M7TD7grZvy_wA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: M7vVaDrVFjm66MOU6TiMcDZLUbkYLRZO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512050052
X-Spamd-Bar: ----
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 65BBE43075
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	ARC_NA(0.00)[];
	URIBL_BLOCKED(0.00)[qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,mx0a-0031df01.pphosted.com:helo,mx0a-0031df01.pphosted.com:rdns];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.197:received]
Message-ID-Hash: QLFK2ZN25POWDSPYGX7D6XDZEROC3YOV
X-Message-ID-Hash: QLFK2ZN25POWDSPYGX7D6XDZEROC3YOV
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/QLFK2ZN25POWDSPYGX7D6XDZEROC3YOV/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

Hi, Krzysztof

On 12/2/2025 3:15 PM, Krzysztof Kozlowski wrote:
> On 02/12/2025 10:43, Krzysztof Kozlowski wrote:
>> On 02/12/2025 10:37, Harshal Dev wrote:
>>> Enable config for the QCOMTEE driver to facilitate communication with the
>>> Qualcomm Trusted Execution Environment (QTEE) on Qualcomm platforms.
>>
>> Which platforms use it?
>> Why this cannot be a module?
>>
> 
> Also, you did not really cc necessary lists. Use get_maintainers.pl on
> qcom soc code for example.

Sure, thanks for pointing this out, I will add the folks from Qcom SoC code in
the next patch. :)

Regards,
Harshal

> 
> 
> Best regards,
> Krzysztof

