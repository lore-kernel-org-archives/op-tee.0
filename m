Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC42C5DF9D
	for <op-tee@archiver.kernel.org>; Mon, 24 Aug 2026 08:15:57 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C6A5245222
	for <op-tee@archiver.kernel.org>; Mon, 24 Aug 2026 08:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1787559356;
	bh=WpaLzITPBfDEBv1myDl/sGpGcKb3vi18o+wR2mF/Vyg=;
	h=Date:Subject:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=ebbVCTH9FpaADgyifwVYgj+E+xBs1EP6gbErP89ErbXUDHZ1Urtx3R5fP2Y/0hNCE
	 HH75cWZZbzSmzlMoa5pHfIgJn4qI+KutDJ8WBTl/oCX44hMurlsB/jm1JCpBFQhCPA
	 4+KwqG+wjxb9wY6EkcbVYgi+8p7oXRVb2o4TVWj+XbmHouyXjU6tFTECOZQttv45DM
	 4728gvH+98U2i+wLy16NNl+KamyJ6ZOJ/PdxYYCbcSWSkPEiOUIZ9AWuTVdNwEhgZC
	 Za7Gu6OaPoXfaPMdjVwhuzHsWMgq4P1PvlrKeT7vzOCYvG0ewbsIhE4Mz6o4WFPrn4
	 qzSO0v6AGCmBw==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id D3FF343EE9
	for <op-tee@lists.trustedfirmware.org>; Mon, 24 Aug 2026 08:15:47 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mI+f3j2i;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VyBD62JJ;
	dkim-atps=neutral
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O5RKAJ1478017
	for <op-tee@lists.trustedfirmware.org>; Mon, 24 Aug 2026 08:15:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=WpaLzITPBfDEBv1myDl/sGpGcKb3vi18o+wR2mF/Vyg=; b=mI
	+f3j2ifpR87VT4uk3BK22E5mJjGdv8D27JxMswNTEeuEAEGc1DTQrhnAA6IYDGsG
	jdWBMeSfyaSOByxAyDcSwHIB0cuSmZWhPscqKYkG4a5I25b+8yg0nLT8cFN6M4/M
	v9/zVILU0Clw/3CPTR2Lk8BL2cIJihA4ADRk3uhyhnCV7+QrdoIFQx3DWImomM0N
	oGqNhnZ7FnCm1g5crUtYNEg+HP4hnN5EOK+xYF5luyW2afPh2bUuylF+BW1Dz4ou
	gwUBYcnEKpXoidMB2zzJsEuMskCvlen8Lv/RMVFVVXz7yAzOFUXHmBxokNpQlKOR
	RXqSPvcLNqTOlpWa8/Ow==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g7528nx2e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 24 Aug 2026 08:15:46 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-837aaa9a3f6so137847297b3.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 24 Aug 2026 01:15:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787559345; cv=none;
        d=google.com; s=arc-20260327;
        b=UOLy/AO1nZy0c4jFWb+IoYe0HRTs+KpFCJbLXJpSP8rJcCeKqCuJrl/hfK8goIN5wW
         GkMhfZ84oZSSSdt0CSg30KtrjwenWWb9ryqCn1fNVyiQ4vfQbjB8v19O2VnxqpD1hk+g
         mrdLPtmkFf5OSGrnfw6D5vQeWynJ/YKZHSeFvS9nmZMo3wYB7Tur2GgM18OnVtxI3E1W
         UQMRszR6iMRs4SWPFDZe4iur45i4QKWBVqFwXC41oHGENl9g5PjXtzcSsmZ7b5D2w1Wd
         zcGfQStYJaBixMMO2nSuOU6D06vRzisOR2UwtfnPj772T2U8boduYipn90Q4mFW6a+//
         ygow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=WpaLzITPBfDEBv1myDl/sGpGcKb3vi18o+wR2mF/Vyg=;
        fh=DBvxCipNH2RlJe8Lt8jDz73G7et6cRT4xOp4aNQo0jg=;
        b=hcbTcQntiBfImUSDJlD6Gpx0L0JWfXDVaR8ZpGc9+yAo9xosVCdIh/4K9LNUU+Pa7a
         R9GtHKWEW8NqGIqzKFiZ3Ss3itRnUt7supuwsrlm+5rpUr8v1uMKc+JusVwixz0Fmcsw
         hG/glmnVKGAZ7cfjspH7rPp9aGWaoUWhHu+V2RVNbNNv0nGgi2a3pK0Xgav1vLeoTJUy
         ixM52Ephx86ZB9w5g+nhvnHf3SOlUkno4jJyK2W/5l40egw8jtpsLLxS0UyH+0S4CUpl
         hkNPqmFeLpzvtGplZdL81IZmiH9PwZuNRLWO4mrmP6E9WaWjAHTx+qmlxwUSKZymeguK
         xdxw==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787559345; x=1788164145; darn=lists.trustedfirmware.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=WpaLzITPBfDEBv1myDl/sGpGcKb3vi18o+wR2mF/Vyg=;
        b=VyBD62JJ2d/5x4a3Ur4Y6no9mk0FpvCa5r9iDraOEKgPQepRtR0tbkqho3/T6NJfkt
         buywKmvNMgX2Ya4YcFZEzLxakCman4rP3dX2f/iMzS0Tg9EK4M5UYoaHiclkKSgeaai+
         bQX+fLNao15ltYO071cTNHRo9Vv0xNGrz8DvNKABgvHXR58ibU8dm1yV7/3PAYalhz/z
         B5rkWGz4EQUDEE/R8eY4pUYrcCLS0xHOhmFTFIFrUjWHTyxAz1Gslqz4myODfCd+g5+h
         kPWTnPPat+Q5LCR7eJxB+aX8tJIhD9oMJA/i2EmgFf0o2SOySS1exfxwjNqgc2cp3XrM
         bMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787559345; x=1788164145;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WpaLzITPBfDEBv1myDl/sGpGcKb3vi18o+wR2mF/Vyg=;
        b=boA3IGzTssgYWQJ1pJDcaYMW9e2mdSrIxxTm/517JCy7J0CPu8XGm5j1cRFht3m74V
         RlJFaEE/bI5fRixes4QXf/53COK0aHPXRA6/amnxv7/jj/5pvQww/dN2b2vYci67j90S
         FSyEIpYGWYOIVbHz7/gzBJ6mkNNflo5NhYDyPyRgu5pjwvQi68kOd4h9vXcM9PWMM0Ok
         hrJk/DlXtPsT5i3UHPR2AGDIWPYQmYyUwPKA/qLfLfXn2Nr9I6P9w5GZY6i3oEHcYda6
         oBPSKaKx/haZWkgeM4y4LDQMlzflDkvWzn+vO8w4+uIBkUy0bVzjcBmVJuNnBj4HBj0y
         wgzw==
X-Gm-Message-State: AFuF++lTJgMQ7DgrJkpf/a5POPSKbD/N8G72JU7iI6uM6WpyPuduDg5g
	BKJJTyu8QqZKuiiXwbJl+zCRgvFPQ6RviTz5AtUmFS3aIvEvikqjYbg5Ym3IsYNuZpPe6p6bRXX
	wFAaXgORMySUkURz2VNLFRzoGCDw60Pf73GPDKGv0S4lR1Jeff5URHBPoBdu37+fqK+3+Yl/0fW
	tEjgA8YAcFnWUT2EysH0h2w++j1dU9U4/faxvzI+zhgMYGF4qncKPR5vdRUQ==
X-Gm-Gg: AR+sD13k/Bs9X3bfOCLlJVvV7KR/2FsgurPMt8uciUaIODupoNHL1t3AJ67aB4oI29c
	ZSS3Ko8mKWwu+4D6ur6UfZu4GZ7cbibcNRTLjsVL0x+mvmCBPzW3DQanFC3QoFDY20FJcMKivNT
	iZQVsU+H7swJyAG3UxdIRYexJTlpBtY9hW3NdN5Yc0UPonscghdUhQiU4=
X-Received: by 2002:a05:690c:ec3:b0:81e:b78d:688b with SMTP id 00721157ae682-8470b1e9918mr118523997b3.12.1787559345366;
        Mon, 24 Aug 2026 01:15:45 -0700 (PDT)
X-Received: by 2002:a05:690c:ec3:b0:81e:b78d:688b with SMTP id
 00721157ae682-8470b1e9918mr118523927b3.12.1787559345014; Mon, 24 Aug 2026
 01:15:45 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 24 Aug 2026 10:15:33 +0200
X-Gm-Features: AcwNN1V8V9lK5yFBqQUmmoEbEfrZ6mypkgQwJmn_7KZ6kV5JraNuN4UoZ4Sh768
Message-ID: <CAGgiveV6=aBBm4__KBZVZH9rXF70N-Y+iWEEy-Y-BgYeF5uEdQ@mail.gmail.com>
Subject: OP-TEE Contributions Forum, monthly meeting August 24
To: op-tee@lists.trustedfirmware.org
Content-Type: text/plain; charset="UTF-8"
X-Authority-Analysis: v=2.4 cv=DsJmPm/+ c=1 sm=1 tr=0 ts=6a8bfdb2 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=b45o4kL6AAAA:8 a=1vxj15BfN1v6TZz8fbIA:9
 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22 a=dhdsR-PFWuPJUldTnwXm:22
X-Proofpoint-GUID: Zhkwka2ZMqi1N16IKf4JdxCwUUbeAgWV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA3MSBTYWx0ZWRfX19WMTy92LpOo
 a7fh1h0O2DXBY8P8V1apFCyvfxy/yyU0sHMTMxefZn0v+wlCziDUR3xLp1OpKRmaE4DbX3qRZvG
 jemZVTwKPRWYesGUP/TAYhsrDwNzVfBUXX9QTpeizaB1FpYv54MZd1phGSDEq5uV+oyUq7QvkZl
 zxCADXGVuQ1imsd7/HDF0AX+dcAWD9ntgoq+CIXPG+Al5CBMgWQkX9+ybtnGyykC9+ZnSd+jOlw
 iPw81YcyYSvUVDO89M0qvm6uWSpQD43h9GHV+3UOccO2bbhZiF7DM77eDp9gmVZSEV5mVg8F82P
 gQEvngBIo9IwJhDc3etT09tmJC6LlyUOYA8Ftl/l53jLuTEZwmj0huYE7lfI7gEwdMc21BRSJIi
 p+bV1JCVcC97vog3tO/K8Rc6tAi/fmfTzQvvTb8qmLRA20bKnsvWjZP6phl7sEFb+jSJBxUaMyZ
 Qk922ChB1FfXl20RjTg==
X-Proofpoint-ORIG-GUID: Zhkwka2ZMqi1N16IKf4JdxCwUUbeAgWV
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA3MSBTYWx0ZWRfXwQrbTyssJLOC
 pBvKnaK9LyMeVe47PHlYHUM0KTYmQvgRD4KHG9EomC/+MUcRSwmNxBVsZeZHuKk/eAtNY2bk+Ua
 7yMMwVoDwCGIaCz4QHTwNkR+oQuG/wc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240071
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.10 / 15.00];
	BAYES_HAM(-3.00)[99.98%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[qualcomm.com:dkim,trustedfirmware.org:url,mx0a-0031df01.pphosted.com:helo,mx0a-0031df01.pphosted.com:rdns];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.197:received];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: D3FF343EE9
X-Spamd-Bar: -------
Message-ID-Hash: F6PH6YR757XGY6XJCLY7AA4ID6L4TJLJ
X-Message-ID-Hash: F6PH6YR757XGY6XJCLY7AA4ID6L4TJLJ
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/F6PH6YR757XGY6XJCLY7AA4ID6L4TJLJ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jens Wiklander via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>

Hi,

Tomorrow, Tuesday, it's time for another OP-TEE contributors' monthly
meeting. For time and connection details, see the calendar at
https://www.trustedfirmware.org/meetings/

Following up on some points from the last meeting:

The OP-TEE 4.11.0 release is planned for October 16. We skipped the
July 17 release earlier, so this release will be a bit larger than
usual.

During the last meeting, we discussed giving Etienne merge rights.
He's already part of "THE REST" in the MAINTAINERS file, so this makes
a lot of sense. It's also good to see how we can staff during holiday
seasons. It would also be nice to have more people in "THE CORE
REVIEWERS".

Help reviewing vulnerability reports and their fixes is most welcome.
We should probably take this offline. If someone can help review or
even draft fixes, please drop me a note, and we'll figure out how to
work together.

Any other topics?

Cheers,
Jens
