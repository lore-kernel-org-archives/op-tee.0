Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BB4D3B7E1
	for <op-tee@archiver.kernel.org>; Mon,  8 Dec 2025 12:54:36 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 93519431A7
	for <op-tee@archiver.kernel.org>; Mon,  8 Dec 2025 12:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765198475;
	bh=lBCWOuGoUt4j9CX2ND8CKNvPAMHuPeTLdIBb5YojDGo=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=3htkY0xY/Je9lXPQdJv2DYrBI+td7Hh6MlsVr0Luue5mE4ufCqNYP/C5EK246UZ83
	 ea1kZS+SthNt2vxhXJByl/fDwDH5BgMBUJoQ7oe2dv2JbqwD9kF4Eg1D1F0Lq5liye
	 zhs/MB1N0VCqS12tTLVwP0Kmtl4tPtmMNXmlvCoFa8xcekxQnWUcVTUq+y9hNB9HIk
	 /xs9LgaGxEl/MxR0sXN8FoQHxY9EYYec+BQNhQANWCGsK/+SgEsdyPgu2tuZL7rS3c
	 Eqan9CAmYPBa/4gxdX3rwRhSRGzdxGmho9k++TRbcm7XR43ZkA8X9WAXf0cZt9ci2i
	 3h5EtWSpKaskg==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8FAC3431A7
	for <op-tee@lists.trustedfirmware.org>; Mon,  8 Dec 2025 12:54:22 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PBb+1WSw;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q8O1KDMV;
	dkim-atps=neutral
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B88ab4C096382
	for <op-tee@lists.trustedfirmware.org>; Mon, 8 Dec 2025 12:54:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f8NW0eaIjc+/bup2mAkhtGsrWNXPoYpo4XqyUD9efLk=; b=PBb+1WSw63YxN4kz
	y6Zuccu7OaSLyKKqukOrjIbfV0uaBTdNMwdYOssPHT9Bowhd7dYfP97+eZFQ/l1r
	hfMGjynIEaSLf4ejgJ3LDabAU4WHlZTuRLVVoH6Duy4eFO8tOfwn1CbiCBd1gXqA
	WQXl8VAHc9XBCDcEzhoQ8BdPmWuAVaodbwUhaiJ9olclmZrOKHdJIhi8wvnNtJ4B
	a2nAZS46+N+c6EugtznuMuKJ5tEBAq/jPitbGXdKn2hJMtkLLgA8bxs4vJCCHWnm
	XPRrcAV8k6rMAsrIwUhSHY/PMGE39Pu/AFjt/iGB9ZecBPhHOUScIiB8pmqeg1io
	PPj43w==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4awuafrqnb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 08 Dec 2025 12:54:21 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-be8c77ecc63so6436222a12.2
        for <op-tee@lists.trustedfirmware.org>; Mon, 08 Dec 2025 04:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765198461; x=1765803261; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f8NW0eaIjc+/bup2mAkhtGsrWNXPoYpo4XqyUD9efLk=;
        b=Q8O1KDMV/RpocbORrN8H8ubxrm9VM9d+8Y79mDRgO9RXRJUMBqHO/jZGN2o1DQWryb
         pnGrUyOPvZTSL7s/SbcgGHwns89itcMVhu/EzU3YyCZ8JEbJbe8/pdwa3eRjm4FEP4iq
         Sd9Wti+J94W5llBzOFDCaAGg74MkKbS9rm8sr3VkCXFa5ce8VGmuQP4bNJ1lsAkVxHag
         8n9qezibr0dvQVg8YdOkMl9caO72x2h2ztY8gg2LSHM6S6ugH8fhSXAtiTS8AJP5dGnR
         JkNbPIqLaQww9FlZ59lmuKiinDevwoiDGrGQXoEk+6RKvo4S6HduV3Xc/z3JDbpVZrKW
         t66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765198461; x=1765803261;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f8NW0eaIjc+/bup2mAkhtGsrWNXPoYpo4XqyUD9efLk=;
        b=I0lBFgQIbUJ27u8+UramHkQSvGXSIgZ1Wf/suByVST+lMNMuyvVkXkgmKfwX50oEfQ
         +zVCTuRnPMTIhZm6u6w1s3y+wTDZa8Ek48REAccAfXftncyzdRh2y3t1zMVyELMfuCSw
         qK068RKKDgD5PhUEcz5czmvotT9r5IQYD6g8zC7u6wts8myI+Ib85YvJ0y3oWyxKZDNt
         8aBi8xalkUaLCicHVUvqM3LfjJNcWPVmZV8qWcfiHlqobIjXsHB27tVoZ+nPltaKIC7m
         q3CK0z8Ro0dQG56kLdhj+1Pr/ARs78D09podNbeUHPWswwgugEbM0uwCrF3reds8kZTE
         jEiA==
X-Forwarded-Encrypted: i=1; AJvYcCVPKpZy/7ZqjCaAOelfhfv1YOmqsJmc95uq1ZUC16bCaPA1fWfbcNJHF96clUdbnY147gwbqP4=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzwDls52qgR0tBlqVOQRIJcq2j1YCM+8OJuu9oLeDssmqBoM5F7
	qyh6yMHiRHeQuv7vL+Ft7fkN4wDmrJUDYC9LTMWr4fassdlWH72/8QTNEvlCNEF4Rk5N6D7rMD8
	oEmaba1sic+5K5KMsRo+CCKQndTkqracoWLskMYOLFe+b6NjZIrVpIbUkBqAsztY9zYX4TPjD
X-Gm-Gg: ASbGncth8V7FuKxyxZOoThXm0Tl7FwSpg3b1FrzchcAIM9R1+yfCZAI3ZQUB+WHGmNJ
	aMqwHZ8fy87jqqOgHfIns9fmRsSMmgWT81Adz52M011/K9I5H/zG30CNCSuEfD0Z/ma/dd4QO2y
	dI8O6DURAPRPNkYZ6FlfDF5TWE9KAOSjRE+wWpDPHgedNyIJ5XbZi01G/jt6s0ZzQPGYzjP5PIi
	3hV/mjr9WTl1WsGv7JyhcadcTPjfPhZqdZtwVNkjIqPlFFylFxij3m0SKlA9PI3MSWSMBvxVGTI
	xhYFIEVZtRiAmU2iwkjhmMkjM1ZAaInQlZXg1AtJTvhb+MWEecQCkUlS/OuRQKLqdCFaorCRzyj
	fsIP6kpDqUEld+4HzGczui+1eZPoZiSwyCZEgyw4=
X-Received: by 2002:a05:6a21:3288:b0:334:a11e:6bed with SMTP id adf61e73a8af0-36617e8a4e7mr7819570637.29.1765198460695;
        Mon, 08 Dec 2025 04:54:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7OUkYAdQN7i8QZ9P5DCVYGpdvwsmAM8jPa2jw2GtZJTdd1JqInCFhs2mSHfHefLyYpmevhA==
X-Received: by 2002:a05:6a21:3288:b0:334:a11e:6bed with SMTP id adf61e73a8af0-36617e8a4e7mr7819539637.29.1765198460150;
        Mon, 08 Dec 2025 04:54:20 -0800 (PST)
Received: from [10.217.223.121] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf748c6bcacsm11868865a12.0.2025.12.08.04.54.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 04:54:19 -0800 (PST)
Message-ID: <2c0d09b7-0d8c-4bf2-a1bd-1dc4b58cd0a8@oss.qualcomm.com>
Date: Mon, 8 Dec 2025 18:24:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tee: fix tee_ioctl_object_invoke_arg padding
To: Sumit Garg <sumit.garg@kernel.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jens Wiklander <jens.wiklander@linaro.org>
References: <20251204101730.1036671-1-arnd@kernel.org>
 <CAHUa44H1Ejbbuzr1hF1HrT69JGgnvfkkDkh+9KvEvBT+eWBDhw@mail.gmail.com>
 <0b061075-ab71-4ac1-93ec-438ddaaec903@oss.qualcomm.com>
 <aTbCqyOuprPOyU4X@sumit-X1>
Content-Language: en-US
In-Reply-To: <aTbCqyOuprPOyU4X@sumit-X1>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=ep7SD4pX c=1 sm=1 tr=0 ts=6936ca7d cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=tbvlgjoc70kLmXw65C8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: m7QRGChrIsvT7jI5zp8O2ze0a-VbYuqw
X-Proofpoint-GUID: m7QRGChrIsvT7jI5zp8O2ze0a-VbYuqw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDEwOSBTYWx0ZWRfXwSg5bhGvXNX0
 ge4JHYyeYLhzjRaHlV2SmNaIQfrv1sg1+lpribn0R0AJsD327faWD/NA8A8dkLF+CSyPjRFCvpF
 kWIFd6LV1BNYddODD6EW0x1PnNySmt9CFwnpMKAo3i+uksVYHRH0PN4I4phvtQMKH5Y1V2m+trN
 PZWcM3yufEugnu+vRCtLUMPuSDzyW9Fym/ox7UK5cLsxCNl0RgxFybBG1lG6NNti+JsID8wGAcH
 3gQq7pWwqAblXQK5Fy/z1/q38/oVWrM/jv6W0stFISe52s943B6oZlgFiIuaVzhaCfs9qYNYVAp
 0GADj+Mvy0cEEursE6uKQpIqKPsI425z5QbjcSyK9/FuLNzBnIm0VVEANk5fzfW8GyzmWW5TQno
 1XIIMh5eq1PWNP8oMGZ3W9FFDf0beg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512080109
X-Spamd-Bar: -----
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8FAC3431A7
X-Spamd-Result: default: False [-6.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.197:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[205.220.168.131:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
Message-ID-Hash: 5JKM7VJ4QH4UM3TZ2BXCOTOL7VH34BEQ
X-Message-ID-Hash: 5JKM7VJ4QH4UM3TZ2BXCOTOL7VH34BEQ
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Arnd Bergmann <arnd@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Sumit Garg <sumit.garg@oss.qualcomm.com>, Alexandre Ghiti <alex@ghiti.fr>, Etienne Carriere <etienne.carriere@foss.st.com>, Randy Dunlap <rdunlap@infradead.org>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/5JKM7VJ4QH4UM3TZ2BXCOTOL7VH34BEQ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

DQoNCk9uIDEyLzgvMjAyNSA1OjUwIFBNLCBTdW1pdCBHYXJnIHZpYSBPUC1URUUgd3JvdGU6DQo+
IE9uIE1vbiwgRGVjIDA4LCAyMDI1IGF0IDA0OjI0OjE3UE0gKzExMDAsIEFtaXJyZXphIFphcnJh
Ymkgd3JvdGU6DQo+PiBIaSwNCj4+DQo+PiBPbiAxMi81LzIwMjUgMTI6MjcgQU0sIEplbnMgV2lr
bGFuZGVyIHdyb3RlOg0KPj4+IEhpLA0KPj4+DQo+Pj4gT24gVGh1LCBEZWMgNCwgMjAyNSBhdCAx
MToxN+KAr0FNIEFybmQgQmVyZ21hbm4gPGFybmRAa2VybmVsLm9yZz4gd3JvdGU6DQo+Pj4+DQo+
Pj4+IEZyb206IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+DQo+Pj4+DQo+Pj4+IFRoZSB0
ZWVfaW9jdGxfb2JqZWN0X2ludm9rZV9hcmcgc3RydWN0dXJlIGhhcyBwYWRkaW5nIG9uIHNvbWUN
Cj4+Pj4gYXJjaGl0ZWN0dXJlcyBidXQgbm90IG9uIHg4Ni0zMiBhbmQgYSBmZXcgb3RoZXJzOg0K
Pj4+Pg0KPj4+PiBpbmNsdWRlL2xpbnV4L3RlZS5oOjQ3NDozMjogZXJyb3I6IHBhZGRpbmcgc3Ry
dWN0IHRvIGFsaWduICdwYXJhbXMnIFstV2Vycm9yPXBhZGRlZF0NCj4+Pj4NCj4+Pj4gSSBleHBl
Y3QgdGhhdCBhbGwgY3VycmVudCB1c2VycyBvZiB0aGlzIGFyZSBvbiBhcmNoaXRlY3R1cmVzIHRo
YXQgZG8NCj4+Pj4gaGF2ZSBpbXBsaWNpdCBwYWRkaW5nIGhlcmUgKGFybTY0LCBhcm0sIHg4Niwg
cmlzY3YpLCBzbyBtYWtlIHRoZSBwYWRkaW5nDQo+Pj4+IGV4cGxpY2l0IGluIG9yZGVyIHRvIGF2
b2lkIHN1cnByaXNlcyBpZiB0aGlzIGxhdGVyIGdldHMgdXNlZCBlbHNld2hlcmUuDQo+Pj4+DQo+
Pj4+IEZpeGVzOiBkNWI4YjBmYTE3NzUgKCJ0ZWU6IGFkZCBURUVfSU9DVExfUEFSQU1fQVRUUl9U
WVBFX09CSlJFRiIpDQo+Pj4+IFNpZ25lZC1vZmYtYnk6IEFybmQgQmVyZ21hbm4gPGFybmRAYXJu
ZGIuZGU+DQo+Pj4+IC0tLQ0KPj4+PiBUaGUgbmV3IGludGVyZmFjZSBzaG93ZWQgdXAgaW4gNi4x
OCwgYnV0IEkgb25seSBjYW1lIGFjcm9zcyB0aGlzIGFmdGVyDQo+Pj4+IHRoYXQgd2FzIHJlbGVh
c2VkLiBDaGFuZ2luZyBpdCBub3cgaXMgdGVjaG5pY2FsbHkgYW4gQUJJIGNoYW5nZSBvbg0KPj4+
PiBhcmNoaXRlY3R1cmVzIHdpdGggdW51c3VhbCBwYWRkaW5nIHJ1bGVzLCBzbyBwbGVhc2UgY29u
c2lkZXIgY2FyZWZ1bGx5DQo+Pj4+IHdoZXRoZXIgd2Ugd2FudCB0byBkbyBpdCB0aGlzIHdheSBv
ciBub3QuDQo+Pj4+DQo+Pj4+IFdvcmtpbmcgYXJvdW5kIHRoZSBBQkkgZGlmZmVyZW5jZXMgd2l0
aG91dCBhbiBBQkkgY2hhbmdlIGlzIHBvc3NpYmxlLA0KPj4+PiBidXQgYWRkcyBhIGxvdCBvZiBj
b21wbGV4aXR5IGZvciBjb21wYXQgaGFuZGxpbmcuDQo+Pj4NCj4+PiBUaGlzIGlzIGN1cnJlbnRs
eSBvbmx5IHVzZWQgYnkgdGhlIHJlY2VudGx5IGludHJvZHVjZWQgcWNvbXRlZSBiYWNrZW5kDQo+
Pj4gZHJpdmVyLiBTbyBpdCdzIG9ubHkgdXNlZCBvbiBhIGZldyBhcm02NCBRdWFsY29tbSBwbGF0
Zm9ybXMgcmlnaHQgbm93Lg0KPj4+DQo+Pj4gSSB0aGluayB3ZSBzaG91bGQgdGFrZSB0aGlzIHBh
dGNoLCBidXQgbGV0J3MgaGVhciB3aGF0IG90aGVycyB0aGluay4NCj4gDQo+IFllYWggc2luY2Ug
aXQncyBub3QgYW4gQUJJIGlzc3VlIG9uIGFybTY0IHBsYXRmb3JtcyB3aGVyZSBRVEVFIHJ1bnMs
IHNvOg0KPiANCj4gUmV2aWV3ZWQtYnk6IFN1bWl0IEdhcmcgPHN1bWl0LmdhcmdAb3NzLnF1YWxj
b21tLmNvbT4NCj4gDQo+Pj4NCj4+PiBUaGFua3MsDQo+Pj4gSmVucw0KPj4+DQo+Pg0KPj4gSSBh
Z3JlZS4gV2Ugc2hvdWxkIHRha2UgdGhpcyBwYXRjaC4gQXMgbm90ZWQsIHRoZXJlIGFyZSBub3Qg
bWFueQ0KPj4gY2xpZW50cyByZWx5aW5nIG9uIGl0IHlldCwgc28gdXBkYXRpbmcgdGhlIHVzZXJz
cGFjZSBzaG91bGQNCj4+IGJlIHN0cmFpZ2h0Zm9yd2FyZC4NCj4gDQo+IFlvdSBzaG91bGQgcmF0
aGVyIHRlc3Qgd2l0aG91dCBhbnkgdXNlcnNwYWNlIGxpYnJhcnkgdXBkYXRlIHRvIHRlc3QgaXQn
cw0KPiBub3QgYW4gQUJJIGlzc3VlLiBKdXN0IGZvciBjb3JyZWN0bmVzcyBzYWtlLCB5b3UgY2Fu
IHVwZGF0ZSB0aGUgbGlicmFyeQ0KPiB0b28uDQo+IA0KDQpJJ2xsIHRha2UgdGhlIHRpbWUgdG8g
dGVzdCBpdCBhdCBzb21lIHBvaW50IHRoaXMgd2VlayBib3RoIHdpdGggYW5kIHdpdGhvdXQgdXBk
YXRpbmcNCnRoZSBsaWJyYXJ5IEFCSS4NCg0KUmVnYXJkcywNCkhhcnNoYWwNCg0KPiAtU3VtaXQN
Cj4gDQo+IFsuLi5dDQoNCg==
