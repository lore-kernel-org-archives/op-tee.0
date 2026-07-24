Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C216C531F9
	for <op-tee@archiver.kernel.org>; Fri, 24 Jul 2026 09:14:28 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7A31144F1F
	for <op-tee@archiver.kernel.org>; Fri, 24 Jul 2026 09:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1784884467;
	bh=zqEsShgAXBqN0aH+k3GZyo4o8q9MsmA9jZbpx9vwHmk=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Dj6hV+7qvvwDXBjTqYDvWuwO5r07Ey3OruEQwIhAeiRZ+Sx4z8h0OaBaxLesk4Dp7
	 UICGi2RPXRSK1lrcWFfDZUxFay6h8PE09tT6ifJNBoe/RyxeMBJ7St+opHHHvoy5YM
	 q7rcnyvBsa35QA4balTFfKHdlu8fyVcZy858urh7cBnr8hA9K1ejO6KvrzyvKYAbBo
	 b+npam1eHPi4EVEEuZ45YY2se/lIcY3Und2aekruSaPcdMIdElOhHM60vNLtbziDGO
	 5AD3F+89WRGOgxNOhEoeOKCWSbMXuLT6K48nEjQ2sRg976TQrZKmdPTGgOxI/USH7G
	 Fr0nPyHvRcsaw==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id D1587450D9
	for <op-tee@lists.trustedfirmware.org>; Fri, 24 Jul 2026 09:14:07 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l4hFSTH5;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fhg9Vhcj;
	dkim-atps=neutral
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O4li9E1510861
	for <op-tee@lists.trustedfirmware.org>; Fri, 24 Jul 2026 09:14:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k2dV0KsKWBGfkN52BkUxCSjB5VTckVJV0QF6l/hmvjc=; b=l4hFSTH5cPEQqGtT
	WHVT6YbsAjhV9PO3FYS0hKNp+mK8PWd0yZhhBEgfFA/k90IQK7W3AhWrlnaQknfZ
	CupvxRk15Dii/k3qbErVqefsmo0QWhA894QiNouUvUU71XFp0+HlQkqsqgoXPRdt
	nYiJWY2cYbuB+iDDo4iNBwAAvD8/2Z0L5wAbGKSiJ7hYNqfcP8aPsogy6Jh8IS5M
	fmz05QefB5DkmSqfq7ffmaSqLYP0ui29z3rOE8ItgZvTAUmD/Tntbl2pjbTnjVAI
	q3b99aNhZMGdimimdxiTGrK0qM3fQGD+KxCGO+ogPfQcRRr6wyZfiXc/Ca2uHnyd
	WWDiUg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkusrsx2h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 24 Jul 2026 09:14:06 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84240683a82so273714b3a.1
        for <op-tee@lists.trustedfirmware.org>; Fri, 24 Jul 2026 02:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784884446; x=1785489246; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=k2dV0KsKWBGfkN52BkUxCSjB5VTckVJV0QF6l/hmvjc=;
        b=fhg9VhcjYPgWoVWkhGrFHRiCVbVOAOak+RWtB193zn2F+lqTR5NJR9G16XidrGmpl2
         vPNmxP6SxnsfKnkBNfahiq/XFGullsrBCctVi9v1B8nXvHxodU/cgU7PkWCnUWxuT7Z3
         t8w7fdpZScpIKHzczpZEkF28wn91ky95totDyNuu6KKnkGt8f5MxtO+Zi95rkSS1PsD4
         8Ag7hFelyATj4PPlcq45i8Qw3epXL/EaYpFPRBlAti5N08gshcbdYFz1gU+jWkMP2LOt
         lFc02CK8fvhURmzwYqcFOC6pD7FrgD37dssrB2gF83cW7wIf5mZdZUCQvp7c1iIqruYu
         vKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784884446; x=1785489246;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=k2dV0KsKWBGfkN52BkUxCSjB5VTckVJV0QF6l/hmvjc=;
        b=qdTNq6uRF9PJ/RhF1Ag5HumKvgnu4TfNZZ+JS82C4z9PiSF9iiLPvDGIgOcNzM7LjD
         UqrdnQPQVrLtrlV+w+TCJ6Ar6oSzpfxIAOMB9/dWRYuqF4FLmwKCjxst89qotOGoUNPJ
         AWmd0lIDPQs6CKKIh63yHq2utWw154GPuLGUosGachrJ3OkWpNwTutnc8PQ6QZI+U0nq
         Utmf+fdPHWu720ZwBKS86FPT9Ovsl2H3rps0HanNsiUx8MgfYRq/iqqIROmDqRNyjyX8
         IXEINZemkCCeZrlMwusrUEhtoXYqg8BeeeCIIJ4mwE28T23+54qvEixJGVtKAPfxrbF/
         w7Uw==
X-Forwarded-Encrypted: i=1; AHgh+RrNN0GWGduchTv9DmyUOkF/YM1P9534dh3OpGUxOmpMnOxe4QE5OrnYsEAUsyf0380Zp2/0Yps=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxIVhAfAHPvjoJpBbAPzgJ/YvUHRttuLo5b4G6kUslVG1k3Tz5s
	LtIY9Xa03g/BRr9OGdw6bcIwmFqMDXgm+0b6qnx3UpQy6y2Fx/IeipvKb5t8C7ZlTbIjpFDQKly
	BJRvO18hhrVkq8arqQUyEis9fwqwHzzFdb2/A6UVRjLOhYpdsL2q9+M/O95WQxYFZgZ7k58ye
X-Gm-Gg: AR+sD12ywwVYN023fihd+LJuiF0FCW6teLCyCwwdz/1aWjO9xrZChFkt8hq29lEo4Rj
	CrmrV/nl5ni13OfZyp+qyRARLr4q47dvRs2LGvzwjX6G2gi/46E7B/NWUNqAOMQi/DvV9RSqxLP
	f/nAV7r+kiOIKu8JW3GMAZ1KSSYyGhEwWt+C4hdfNh2fdTTfUTuk/utc1xcJ8x4sQ4nbvK0p6WS
	x+HZjiYdRF9qwoSe2Oj/kgm7eAObHbTGfELows1fpGZjzAjJCzQByFAbcjpyoJCKsA3nD6t1Oca
	9DEeY2jXLaYTn/ixfLZdaI/E5piAINQxqcbB/5wkl/g2PFKQECcuuVmqc3yVDfkmmiVxdkB3yN/
	E67hBQw4n6Ss+IaXnsF+bptU8gH4=
X-Received: by 2002:a05:6a00:35c6:b0:847:9570:d408 with SMTP id d2e1a72fcca58-84e2e7f6e71mr6461449b3a.2.1784884445890;
        Fri, 24 Jul 2026 02:14:05 -0700 (PDT)
X-Received: by 2002:a05:6a00:35c6:b0:847:9570:d408 with SMTP id d2e1a72fcca58-84e2e7f6e71mr6461420b3a.2.1784884445464;
        Fri, 24 Jul 2026 02:14:05 -0700 (PDT)
Received: from [10.92.203.75] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e17237c3fsm4409302b3a.9.2026.07.24.02.14.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2026 02:14:05 -0700 (PDT)
Message-ID: <9d638808-3a51-432e-a31b-0d68d4dd95f8@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 14:43:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] tee: qcomtee: Add support for registering QTEE
 services on TEE bus
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com>
 <20260722-qcom_uefisecapp_migrate_qcomtee-v2-5-b8a8fcbe4211@oss.qualcomm.com>
 <xyfoylxowewyyivw4qkwjhtmukbejusmcucfrs6jnmrihpx2ep@koluyh6bgbre>
Content-Language: en-US
Organization: Qualcomm
In-Reply-To: <xyfoylxowewyyivw4qkwjhtmukbejusmcucfrs6jnmrihpx2ep@koluyh6bgbre>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA4MyBTYWx0ZWRfX7zGgQ+bax+IU
 WS5qjPeKoTb5KK88vNfdqpC/BOqlER2QAGXVEQoM0U/vJBRXDashtut0dnm+CFuHkWHsjZ3u7sA
 JD29oVtsGg1N0VEiTnro8rP5IStvBxc=
X-Proofpoint-ORIG-GUID: IkoSKhLbmQhifKwaMbo1EknWgwQ4eY5w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA4MyBTYWx0ZWRfXy4dDQS6Gz9VD
 qKkgl8Ap7r9G55SdT1I/60ImahfACwx0/UcT8CbQ3sgCAs8/m4fZh8JFbYC/8I/nN2jrRErjZj1
 0JCOWZ4RCyYAqJE0eHlr8TuzmaooXHCpwJsizWIH9uIWWzqi2dW8FUxv3vr8xckw8XPZU3pb5co
 MHsqEsMkafdkFaOOxUZhv1WHomClWHIfkK6F59aQE6dEjBYJiHlQSfqEWPbwq0ntKq9dmrkLG7+
 iATNhwb3twKVRlNizBwd4U6MHXDMZ8Ol5BqqbnHj2YArpLpVNDWrdBTqg/N7oYjObJhNC4quCZj
 eJa5gUjbYIBsH7CuS+b8lesEYfsteE0FYg5A1okSPY+rOJCIoJypyEcYCpi8q9Haczx1ytdcuQg
 dvG70FIb3v+WL94AB6dP3VVg49dGlqk38jvOj+/mZ09Y7a5SHwmnfnp4p7fGnTzRSOx0dqO3xnr
 ANDuuXXL9ARPJAys8KQ==
X-Authority-Analysis: v=2.4 cv=PtejqQM3 c=1 sm=1 tr=0 ts=6a632cde cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=gsbhc2nskAa0CSx_u8cA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: IkoSKhLbmQhifKwaMbo1EknWgwQ4eY5w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240083
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	RCPT_COUNT_TWELVE(0.00)[13];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.210.199:received,202.46.23.19:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: D1587450D9
X-Spamd-Bar: ------
Message-ID-Hash: 4BHGJGPMDC5LMHP5H5SQNRUNLSNTDTF3
X-Message-ID-Hash: 4BHGJGPMDC5LMHP5H5SQNRUNLSNTDTF3
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jens.wiklander@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/4BHGJGPMDC5LMHP5H5SQNRUNLSNTDTF3/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

Hi Dmitry,

On 22-07-2026 01:59 pm, Dmitry Baryshkov wrote:
> On Wed, Jul 22, 2026 at 12:29:16PM +0530, Harshal Dev wrote:
>> QTEE exposes certain secure services implemented either within the QTEE
>> kernel or via pre-loaded Trusted Applications (TAs). Such always-available
>> services can be readily accessed by TEE client drivers via QTEE's
>> object-IPC protocol if the service is registered as a device on the TEE
>> bus.
>>
>> One such service is the EFI-variables service, implemented by the
>> uefisecapp TA which enables kernel clients to access EFI variables at
>> runtime.
>>
>> Maintain a static list of such always-available secure services and add
>> support for the QCOMTEE driver to register these services as devices on
>> the TEE bus during probe.
> 
> Is it always available on all platforms supporting QTEE?

The uefisecapp service is very old. I know that it has existed since the oldest
SM8x50 chipset. Every upstream supported target currently has support for it, since
they all have UEFI somewhere in the boot chain to load the uefisecapp TA from
the storage partition.

But as we expand this list, it's possible that certain services might not be available
on older QTEE versions, in that case the service will never be registered on the
TEE bus and so the TEE client driver will not probe.

Regards,
Harshal

> 
>>
>> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
>> ---
>>  drivers/tee/qcomtee/call.c           | 160 ++++++++++++++++++++++++++++++++++-
>>  drivers/tee/qcomtee/core.c           |   9 +-
>>  drivers/tee/qcomtee/qcomtee.h        |  12 +++
>>  drivers/tee/qcomtee/qcomtee_msg.h    |   1 +
>>  drivers/tee/qcomtee/qcomtee_object.h |   3 +-
>>  5 files changed, 177 insertions(+), 8 deletions(-)
>>
> 

