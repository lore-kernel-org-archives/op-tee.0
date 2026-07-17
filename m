Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADB2C44516
	for <op-tee@archiver.kernel.org>; Fri, 17 Jul 2026 10:28:56 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B0B8E44D43
	for <op-tee@archiver.kernel.org>; Fri, 17 Jul 2026 10:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1784284135;
	bh=FrzGBNDFQThK5Z24aEUTBD1+/YC8abd1ewg2XwUi008=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=rI1KhBOt6QYybcvnjD/GfvaQ4LgDkXhTfnY5QDlfoDwlu6YBMDt3DRPUhiemQXKbm
	 RFgScfyIxYFcsAx1VmNRmURj3DAF69j2C3wb50kG4eaUloe1e6S22OTRFeSioFWWph
	 T83VCEUYW/jrzuCWT6Kow4ptzgi5GYS9E6vDMZp5bIw4s91sJZpbrJiX8wcprh38dW
	 AwGYGzTUnr58PVwkIvGaXpgcCbx0gSZtA+CSHiwiIkqnPVOz41UG4zJnNim55EVYn3
	 T8diVb9Jk+7rfukVUWg703/5qWzFXtwwz/7GsKCs//N0kMA+jH6Y3YCharNL322FPX
	 bqWe+eBwE9dWg==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6E6DA43154
	for <op-tee@lists.trustedfirmware.org>; Fri, 17 Jul 2026 10:28:49 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lWMM+cx8;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=c5EwMfiO;
	dkim-atps=neutral
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HASm5f1348789
	for <op-tee@lists.trustedfirmware.org>; Fri, 17 Jul 2026 10:28:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GJCYGiRTawctkNCl84JlSf9o1HOO8bimM+ytWBDPjmM=; b=lWMM+cx8feBhLbB2
	RcU69sEZ19EFRyEhb9A1VlQL2OUkZVo0zr4NEVHWXcWmLjf27vyWPqvPIact2Msw
	UDwA1jROHqthGHeU5NDvInGMXMVrIhNhQU16pVHxzDhT2t9TEyou1FZfnxC58mjA
	vbXQasGZKE8BdB73UcxL1DYH2WDua+oxEAbonDLS2LvmLtoJBVUTpeKFe5UU/zpQ
	C8lhuWYMg+Mmp53VPnVDFBAfghi/ZuGv3OPNVGNv4sMrNaQTMo2LPIxroj+oJjkM
	GfJYhP6YC2EpoEpz0g3y+CTA1nlwwKQP8kNEsy+3sMfFVSYjurYDHtXFEP1iE8/y
	fsfRMA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fffag8u46-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 17 Jul 2026 10:28:47 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c19493ac2so144896381cf.1
        for <op-tee@lists.trustedfirmware.org>; Fri, 17 Jul 2026 03:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784284118; x=1784888918; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GJCYGiRTawctkNCl84JlSf9o1HOO8bimM+ytWBDPjmM=;
        b=c5EwMfiOEk5oKLxSu5kuqQV7UCB0QSchQXcIPRxcdCOCraHjQ5ZudszeMxtIzfl3gS
         M3Qdr1y1b4Wkiv4RLL6xk3XeiQ0+/QyD54vzNb2cRvBqVpODfIoTvsmozHyn06doRH0v
         WkHhXYkVj+H7KMD1PUYZZqV4e/0kYW1kFs6Q7BEknk511yVgVSZrNUk6x7xc45Cfn8rZ
         ES6qvkyks7QxyzbfABXXn8/gSRCR5xKX4UOmiYCup3WJIwnUT9wmvIxw+A/nTkwMVA3r
         JtHmBQ0Z3CAu37GxbLcsepm9QGp2VDgdDJeaZKYbYGEjRM+m1FbR4rF+iego8M+GTHpN
         g9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784284118; x=1784888918;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GJCYGiRTawctkNCl84JlSf9o1HOO8bimM+ytWBDPjmM=;
        b=LsJTB4GYZxAkk+Q8GH3BWDkfcNTBzw5nrIBNY0MMEpmZraJIgca2m3NqdAbK/i3HeM
         QsUdSLDFbf+fHbF9wRqUE6xJKKgkG7HCSH2nm9jnXxysB6ZogjxCEcf2em8xAfVGTXnN
         930RBKIr8w4/NO3Ndrk6fqDM0hCT2hcE9Zv5rBGIGaatdqYcqb1v1KdfAlvhlBGRErM0
         SNtnDrv7c1aeQoHWJgeXeOg/BsT2xm7ESrt5l80dprMWg9HUj8gZisppZTE4P6F0VbCO
         +9G0fVy8Tzs3IiP6J32lQELp5ypvuIoEkvXsjFHp/36BH8dppuVuZ6SEECDd6DwXWXyo
         jfWQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp3U/jTaSt6rd+pzHlzD1m2qz9CXcIkyvulW2iLbGBYx+B6FOp1+D7IvE2YMKnBZ8OCPdzzMXA=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxzwoUxf4/Wt2TD45XNREKJONiOZEfJ+RMwdlyn+yi2ebhi+7FZ
	s+2qAIptq0KgLpdNGZVuqZROlRXQAFHUucg3Rn7CZa9Mi+Blav/lUdX++0rcB+Zly1lBC3RD4fS
	yEM3RaT3orHMBE9j7Z+mnONyBiXfQ1L/m3TFOzMFdNsGP3TcFZWNuKDromopAc+hyW6Dak2QS
X-Gm-Gg: AfdE7clVk2ZGFPNwMv94u3+SJlOylZ+Q6N3C40K90VVnwAGBLh3ULRNq97MCuXExiZe
	yvMC9GtwEyQe/8Dx6bKmt8Ny2ZmrnrA/UD7F9Ha5KrJ0mn+SAuPY1EOA10ZIdl94d6lkKWcWeO9
	jxL080vpCJVg/Gp0Qm7CFnyeqR5GmaWvlalRQYBr+sYQk5mX+2DsFiqICdyEgUIdQ+2iJP3j0YX
	BcjAcnOcOTw2BJ3px2YkS22heiYWRNE/0U8qD8Q49koerpKGe5mKBFP7o9Kzr3FGPsGsv75Q1W6
	3B1jSO1DbwvdUVqpWE/GWFPqwcuGJqpNuVBDtW5zXmF7j1npCfOt7x/uaUBIoBj8F5WFd9argko
	m9wPK+QxhTSaRpbWqwtGpjcmxaGYCb1BVzvk=
X-Received: by 2002:a05:622a:228a:b0:51c:667:7e30 with SMTP id d75a77b69052e-5213e28e24emr15579841cf.47.1784284118494;
        Fri, 17 Jul 2026 03:28:38 -0700 (PDT)
X-Received: by 2002:a05:622a:228a:b0:51c:667:7e30 with SMTP id d75a77b69052e-5213e28e24emr15579581cf.47.1784284117985;
        Fri, 17 Jul 2026 03:28:37 -0700 (PDT)
Received: from trex (182.red-79-144-196.dynamicip.rima-tde.net. [79.144.196.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2eddb8sm76488975e9.14.2026.07.17.03.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 03:28:37 -0700 (PDT)
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Fri, 17 Jul 2026 12:28:35 +0200
To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Subject: Re: [PATCH v1 2/2] ufs: rpmb: use a fixed-length RPMB dev_id
Message-ID: <aloD00lgh6gCzsCG@trex>
References: <20260716083728.2226422-1-jorge.ramirez@oss.qualcomm.com>
 <20260716083728.2226422-3-jorge.ramirez@oss.qualcomm.com>
 <CAGgiveXtErFjDgxN9reR7s705U3wnnH65c4Su06ZQz_7EYwzuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <CAGgiveXtErFjDgxN9reR7s705U3wnnH65c4Su06ZQz_7EYwzuA@mail.gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEwNSBTYWx0ZWRfX+GsV43nojuYN
 jY8etnEOexIL1K0BpIHFbmznwcXWtuqN5I2kFPw7KSyhCmCDoENok/dBAfssj5QKIScbO4/uEmG
 cYKxrFBzX/dTwHLK7P5MKPZJytpp11mUqaC+veHX2HfA+a3xupg/iGZBUuPJy+yr0F8ScVREEzM
 hnStV8IrQtp0mq0VBr4iBYABo3DQ7mp0ewfJ0QVV73g7g4SCQ9oLMNLGoFx44ZNhAurqOLHT8zp
 VAkKoUKSUb8JaHfG+kC983YUagXkCmIX99bxdhaIKLab7gF26easaHIeyi43K+lT1M9/HCkYXF0
 K3uyFhRE+5iq+IVMhfQl4RSbD6/FIYoHHs5dsyd1hruj/TbimIS9S5cbEyq3qwbOuOAODTyDPJg
 ZmAwoHQyuPP5dPlKAmXHymWbvP83ijN+Gpux1rK+VotIFXvPJiak612yE86gyUmXNm8IyetaFWT
 F9gLMbmB3wXYPX9XsPw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEwNSBTYWx0ZWRfX88hWFmmwLMIK
 Q/1vlWJ0OAoIgzUEvh0LEWccTd7aHQciAOuw0YpYAFOSAl7/d4YqJ2j/e61oX+ZIzRX9TxfXtVy
 FJ+5ON4rUP9vC3uRkVQI1nLLs9zg4w8=
X-Authority-Analysis: v=2.4 cv=KZfidwYD c=1 sm=1 tr=0 ts=6a5a03df cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=2lELrtOEK2EaG96G7mOeag==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=NEAV23lmAAAA:8 a=voM4FWlXAAAA:8 a=EUspDBNiAAAA:8 a=AhAad4elxc9sd5kYIg8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-GUID: ceZbgwl-aPaZvpnzA0iqknwXjwckDAp_
X-Proofpoint-ORIG-GUID: ceZbgwl-aPaZvpnzA0iqknwXjwckDAp_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170105
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.200:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 6E6DA43154
X-Spamd-Bar: --
Message-ID-Hash: BTXQJRKJSCCHNU6WK2HCFRAGCM623OUY
X-Message-ID-Hash: BTXQJRKJSCCHNU6WK2HCFRAGCM623OUY
X-MailFrom: jorge.ramirez@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org, James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com, beanhuo@micron.com, can.guo@oss.qualcomm.com, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, jenswi@kernel.org, sumit.garg@oss.qualcomm.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/BTXQJRKJSCCHNU6WK2HCFRAGCM623OUY/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jorge Ramirez via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>

T24gMTcvMDcvMjYgMTE6Mzg6MzEsIEplbnMgV2lrbGFuZGVyIHdyb3RlOg0KPiBIaSBKb3JnZSwN
Cj4gDQo+IE9uIFRodSwgSnVsIDE2LCAyMDI2IGF0IDEwOjM34oCvQU0gSm9yZ2UgUmFtaXJlei1P
cnRpeg0KPiA8am9yZ2UucmFtaXJlekBvc3MucXVhbGNvbW0uY29tPiB3cm90ZToNCj4gPg0KPiA+
IFRoZSBSUE1CIGF1dGhlbnRpY2F0aW9uIGtleSBpcyBkZXJpdmVkIGZyb20gdGhlIGRldl9pZCBo
YW5kZWQgdG8gdGhlDQo+ID4gUlBNQiBzdWJzeXN0ZW0uIE9QLVRFRSBpbXBsZW1lbnRzIHRoZSBl
TU1DIFJQTUIgZmxvdywgd2hlcmUgdGhlIGRldl9pZA0KPiA+IGlzIHRoZSBlTU1DIENJRCwgYSBm
aXhlZCAxNi1ieXRlIHZhbHVlLCBhbmQgaXQgZGVyaXZlcyB0aGUga2V5IG9uIHRoYXQNCj4gPiBh
c3N1bXB0aW9uLg0KPiA+DQo+ID4gVGhlIFVGUyBSUE1CIGlkIGJ1aWx0IGhlcmUgaXMgIjxkZXZp
Y2VfaWQ+LVI8cmVnaW9uPiIsIHdoaWNoIGlzIHZhcmlhYmxlDQo+ID4gbGVuZ3RoIGFuZCBsb25n
ZXIgdGhhbiAxNiBieXRlcy4gUGFzc2luZyBpdCB2ZXJiYXRpbSB3b3VsZCB0aWUgdGhlDQo+ID4g
ZGVyaXZlZCBrZXkgdG8gYSBsZW5ndGggT1AtVEVFIGRvZXMgbm90IGV4cGVjdCBhbmQgZGl2ZXJn
ZSBmcm9tIHRoZQ0KPiA+IGZpeGVkLUNJRCBlTU1DIEFCSSwgcmVxdWlyaW5nIE9QLVRFRSB0byBi
ZSB0YXVnaHQgYWJvdXQgdmFyaWFibGUtbGVuZ3RoDQo+ID4gVUZTIGlkcy4NCj4gDQo+IFllcywg
aWYgaXQncyBwb3NzaWJsZSwgSXQncyBuaWNlIHRvIGF2b2lkIHRoYXQuDQo+IA0KPiA+DQo+ID4g
SGFzaCB0aGUgVUZTIGlkIGludG8gYSBmaXhlZCAxNi1ieXRlIGRldl9pZCB3aXRoIGJsYWtlMnMg
aW5zdGVhZC4gVGhpcw0KPiA+IGtlZXBzIHRoZSBkZXJpdmVkIGtleSBzdGFibGUgYW5kIHVuaXF1
ZSBwZXIgcmVnaW9uIHdoaWxlIG1hdGNoaW5nIHRoZQ0KPiA+IGVNTUMgQ0lEIGxheW91dCBPUC1U
RUUgcmVsaWVzIG9uLCBzbyB0aGUga2V5LWRlcml2YXRpb24gQUJJIHN0YXlzDQo+ID4gaWRlbnRp
Y2FsIGFuZCBubyBPUC1URUUgY2hhbmdlIGlzIG5lZWRlZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEpvcmdlIFJhbWlyZXotT3J0aXogPGpvcmdlLnJhbWlyZXpAb3NzLnF1YWxjb21tLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgZHJpdmVycy91ZnMvY29yZS91ZnMtcnBtYi5jIHwgMTkgKysrKysrKysr
KysrKysrKystLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Vmcy9jb3JlL3Vmcy1ycG1i
LmMgYi9kcml2ZXJzL3Vmcy9jb3JlL3Vmcy1ycG1iLmMNCj4gPiBpbmRleCBkMGM3ZWE3YTM2ZjQu
LmI4MDA4NzEyNjliYiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3Vmcy9jb3JlL3Vmcy1ycG1i
LmMNCj4gPiArKysgYi9kcml2ZXJzL3Vmcy9jb3JlL3Vmcy1ycG1iLmMNCj4gPiBAQCAtMTAsNiAr
MTAsNyBAQA0KPiA+ICAgKiAgICAgQ2FuIEd1byA8Y2FuLmd1b0Bvc3MucXVhbGNvbW0uY29tPg0K
PiA+ICAgKi8NCj4gPg0KPiA+ICsjaW5jbHVkZSA8Y3J5cHRvL2JsYWtlMnMuaD4NCj4gPiAgI2lu
Y2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvZGV2aWNlLmg+DQo+
ID4gICNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4NCj4gPiBAQCAtMjEsNiArMjIsNyBAQA0KPiA+
ICAjaW5jbHVkZSA8bGludXgvdW5hbGlnbmVkLmg+DQo+ID4gICNpbmNsdWRlICJ1ZnNoY2QtcHJp
di5oIg0KPiA+DQo+ID4gKyNkZWZpbmUgVUZTX1JQTUJfSURfTEVOICAgICAgICAgICAgICAgICAg
ICAgICAgMTYgICAgICAvKiBNYXRjaCBlTU1DIENJRCBMZW5ndGggKi8NCj4gPiAgI2RlZmluZSBV
RlNfUlBNQl9TRUNfUFJPVE9DT0wgICAgICAgICAgMHhFQyAgICAvKiBKRURFQyBVRlMgYXBwbGlj
YXRpb24gKi8NCj4gPiAgI2RlZmluZSBVRlNfUlBNQl9TRUNfUFJPVE9DT0xfSUQgICAgICAgMHgw
MSAgICAvKiBKRURFQyBVRlMgUlBNQiBwcm90b2NvbCBJRCwgQ0RCIGJ5dGUzICovDQo+ID4NCj4g
PiBAQCAtMTU0LDYgKzE1Niw3IEBAIGludCB1ZnNfcnBtYl9wcm9iZShzdHJ1Y3QgdWZzX2hiYSAq
aGJhKQ0KPiA+ICB7DQo+ID4gICAgICAgICBzdHJ1Y3QgdWZzX3JwbWJfZGV2ICp1ZnNfcnBtYiwg
Kml0LCAqdG1wOw0KPiA+ICAgICAgICAgc3RydWN0IHJwbWJfZGV2ICpyZGV2Ow0KPiA+ICsgICAg
ICAgY2hhciAqZGV2X2lkID0gTlVMTDsNCj4gPiAgICAgICAgIGNoYXIgKmNpZCA9IE5VTEw7DQo+
ID4gICAgICAgICBpbnQgcmVnaW9uOw0KPiA+ICAgICAgICAgdTMyIGNhcDsNCj4gPiBAQCAtMjEz
LDggKzIxNiwxNyBAQCBpbnQgdWZzX3JwbWJfcHJvYmUoc3RydWN0IHVmc19oYmEgKmhiYSkNCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycl9vdXQ7DQo+ID4gICAgICAgICAgICAg
ICAgIH0NCj4gPg0KPiA+IC0gICAgICAgICAgICAgICBkZXNjci5kZXZfaWQgPSBjaWQ7DQo+ID4g
LSAgICAgICAgICAgICAgIGRlc2NyLmRldl9pZF9sZW4gPSBzdHJsZW4oY2lkKTsNCj4gPiArICAg
ICAgICAgICAgICAgZGV2X2lkID0ga3phbGxvYyhVRlNfUlBNQl9JRF9MRU4sIEdGUF9LRVJORUwp
Ow0KPiA+ICsgICAgICAgICAgICAgICBpZiAoIWRldl9pZCkgew0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgIGRldmljZV91bnJlZ2lzdGVyKCZ1ZnNfcnBtYi0+ZGV2KTsNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICByZXQgPSAtRU5PTUVNOw0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgIGdvdG8gZXJyX291dDsNCj4gPiArICAgICAgICAgICAgICAgfQ0KPiA+ICsNCj4gPiArICAg
ICAgICAgICAgICAgYmxha2UycyhOVUxMLCAwLCBjaWQsIHN0cmxlbihjaWQpLCBkZXZfaWQsIFVG
U19SUE1CX0lEX0xFTik7DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgICBkZXNjci5kZXZfaWQg
PSBkZXZfaWQ7DQo+ID4gKyAgICAgICAgICAgICAgIGRlc2NyLmRldl9pZF9sZW4gPSBVRlNfUlBN
Ql9JRF9MRU47DQo+IA0KPiBUaGlzIGNoYW5nZSB3aWxsIGJyZWFrIGN1cnJlbnQgdXNlcnMgb2Yg
dGhpcyBpbnRlcmZhY2UsIGlmIHRoZXJlIGFyZQ0KPiBhbnkuIFRoZXJlIGFyZSBjdXJyZW50bHkg
bm8gdXBzdHJlYW0gdXNlcnMgaW4gT1AtVEVFIHNpbmNlIHlvdSdyZQ0KPiBhZGRpbmcgdGhhdCB3
aXRoIGh0dHBzOi8vZ2l0aHViLmNvbS9PUC1URUUvb3B0ZWVfb3MvcHVsbC83ODgxLCBidXQgSQ0K
PiBzdXBwb3NlIHRoYXQncyBub3QgdGhlIG9ubHkgdXNlIGNhc2UuDQoNCg0KSSB3YXMgd29uZGVy
aW5nIHRvbyAtIGJ1dCBzaW5jZSB0aGlzIGlzIGFuIE9QLVRFRSBkcml2ZXIgKGF0IGxlYXN0IHRo
YXQNCmlzIHdoYXQgdGhlIG1vZHVsZSBkaXJlY3RpdmUgc2F5cyBhdCB0aGUgYm90dG9tIG9mIHRo
ZSBmaWxlKSAtIEkgY2hvc2UNCnRvIGRvIGl0IGhlcmUgKGNsZWFuZXIpLg0KDQpCdXQgd2UgY291
bGQgdGFrZSBjYXJlIG9mIHRoaXMgb24gdGhlIHJwYy5jIGluc3RlYWQNCg0KQSBzaW1pbGFyIHNv
cnQgb2YgY2hhbmdlIHdpbGwgbmVlZCB0byBnbyB0byBVLWJvb3QgYnV0IHNpbmNlIHRoZSBjdXJy
ZW50DQpDSUQgaXMgYnJva2VuIGFueXdheSwgSSBiZWxpZXZlIHdlIHdpbGwgYmUgYWJsZSB0byBn
byB0aGF0IHJvdXRlIGFzDQp3ZWxsLg0KDQpTZWU6IGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5v
cmcvcHJvamVjdC91Ym9vdC9wYXRjaC8yMDI2MDcxNzA5MzAxMy4zMjUzNjQzLTEtam9yZ2UucmFt
aXJlekBvc3MucXVhbGNvbW0uY29tLw0KDQpCVFcgSSBuZWVkIHRvIHNlbmQgYW5vdGhlciByZXZp
c2lvbiBvZiB0aGlzIHNldCAod2UgbmVlZCB0byB1c2UgYmxha2UyYg0KKHRoZXJlIGlzIG5vIHN1
cHBvcnQgZm9yIGJsYWtlMnMgaW4gVS1ib290KS4gQnV0IEknbGwgd2FpdCBmb3IgY29tbWVudHMN
CmlmIHRoaXMgaXMgdGhlIHJpZ2h0IHdheSB0byBnbyBpbnN0ZWFkIG9mIHVzaW5nIGZ1bGwtc2l6
ZSBzcmluZ3MgKGllLCA4OA0KY2hhcmFjdGVycyBvbiB0aGlzIHBhcnRpY3VsYXIgY2FzZSB3aGlj
aCBzZWVtcyBkZXNwcm9wb3J0aW9uYXRlIElNTykNCg0KPiANCj4gQ2hlZXJzLA0KPiBKZW5zDQo+
IA0KPiANCj4gPiAgICAgICAgICAgICAgICAgZGVzY3IuY2FwYWNpdHkgPSBjYXA7DQo+ID4NCj4g
PiAgICAgICAgICAgICAgICAgLyogUmVnaXN0ZXIgUlBNQiBkZXZpY2UgKi8NCj4gPiBAQCAtMjI4
LDYgKzI0MCw4IEBAIGludCB1ZnNfcnBtYl9wcm9iZShzdHJ1Y3QgdWZzX2hiYSAqaGJhKQ0KPiA+
DQo+ID4gICAgICAgICAgICAgICAgIGtmcmVlKGNpZCk7DQo+ID4gICAgICAgICAgICAgICAgIGNp
ZCA9IE5VTEw7DQo+ID4gKyAgICAgICAgICAgICAgIGtmcmVlKGRldl9pZCk7DQo+ID4gKyAgICAg
ICAgICAgICAgIGRldl9pZCA9IE5VTEw7DQo+ID4NCj4gPiAgICAgICAgICAgICAgICAgdWZzX3Jw
bWItPnJkZXYgPSByZGV2Ow0KPiA+ICAgICAgICAgICAgICAgICB1ZnNfcnBtYi0+cmVnaW9uX2lk
ID0gcmVnaW9uOw0KPiA+IEBAIC0yNDAsNiArMjU0LDcgQEAgaW50IHVmc19ycG1iX3Byb2JlKHN0
cnVjdCB1ZnNfaGJhICpoYmEpDQo+ID4gICAgICAgICByZXR1cm4gMDsNCj4gPiAgZXJyX291dDoN
Cj4gPiAgICAgICAgIGtmcmVlKGNpZCk7DQo+ID4gKyAgICAgICBrZnJlZShkZXZfaWQpOw0KPiA+
ICAgICAgICAgbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKGl0LCB0bXAsICZoYmEtPnJwbWJzLCBu
b2RlKSB7DQo+ID4gICAgICAgICAgICAgICAgIGxpc3RfZGVsKCZpdC0+bm9kZSk7DQo+ID4gICAg
ICAgICAgICAgICAgIGRldmljZV91bnJlZ2lzdGVyKCZpdC0+ZGV2KTsNCj4gPiAtLQ0KPiA+IDIu
NTQuMA0KPiA+DQo=
