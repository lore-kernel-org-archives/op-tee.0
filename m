Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCE3D5E12A
	for <op-tee@archiver.kernel.org>; Tue, 16 Dec 2025 10:56:20 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 846784FEE3
	for <op-tee@archiver.kernel.org>; Tue, 16 Dec 2025 10:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765882579;
	bh=U6FsoQY1KM0xY0RsYaXgu14HAV+C6QKFaN4NnFll0Vc=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=I6TxTUABZ/q5f+zGS8l76CCYJdG+Il7p6jxw2wbhBUkMnVT6Bqbe6SN2D1J5Dj9GJ
	 4BiBJ7/VWaY8R9eUVbSNKx1qBaDcMzM0jTYFE/Vk74biZJ+ovAUMm7tnBNcTHDBc7Z
	 XrTsOJyWjNZ90nTnwilDtNQp6NLffuR3sD3hCHI6QVE6BwtsG49JLMIqtYyRWqu4KY
	 faaGvHtX2aNIdGYHt1h9vUmxgOPP4SAE4c0eg7YLsUbEBIPk2nVjEnPWE6FiC7WtA/
	 LQ6VHXq696dF2NKOuF4Dp0w907/iphzXT5ch/c1JL3qS1D6KiCNDyUY2IxQgOglCGZ
	 XJz++wlGdeUXw==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4610C4FE8E
	for <op-tee@lists.trustedfirmware.org>; Tue, 16 Dec 2025 10:56:01 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b6OHuUgq;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=X9LVBhU0;
	dkim-atps=neutral
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BG85B4Q2869640
	for <op-tee@lists.trustedfirmware.org>; Tue, 16 Dec 2025 10:56:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oki31/DgsZ6+KzPwIohVz4qvXrFW1AnimENJ+INjaho=; b=b6OHuUgqaipIg7eX
	o/zFibA/JMxcrYY9VhNBSzvv3mhwSXg746mvpGhlxcSROS8WY0AK11hjXyO5yi4T
	kfZ/iSpIrksabGpPOGG9K43FIQHb/mqUxs5S1PjBw4UlL0OZnC6ndYNeqOdFtu29
	EEKKcae0N1ZqrqWT2urRO/UCkWb0Rjqm8L4YiMTaE3vYbhg76zVwYqwBl8qQHI9H
	m6DJxVn1rVpeHGTc+zYWQUpS6u6bN71IFc5kNbmTXskRxWanTOaFtAJvzJxSqMQo
	Jjkng4fq0kk/Nig3dMr+EhTtn6Ie5+YXt56GaACMiEhY8HeCl9witxpvipnu+utz
	br/WoA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b33kw8rtd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 16 Dec 2025 10:56:00 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34abec8855aso8179854a91.0
        for <op-tee@lists.trustedfirmware.org>; Tue, 16 Dec 2025 02:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765882560; x=1766487360; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oki31/DgsZ6+KzPwIohVz4qvXrFW1AnimENJ+INjaho=;
        b=X9LVBhU0+jCvcrefgHeoB1xkJPS0UHpTl2wmCRyacl/lLKewckFZ5CgwS/9ZDFOJcy
         nhblx4LYfWhTlPln/HGKLPlYwHxUv0Dxnrl40LZEbalFx+nSVdCfvpEorK4JI32UQMha
         TtLu1t92AmpL9UCOTuq6ontdGNRuSjhmHu2Yqssl4XuTBbNO3xmYma/TyfTOwL3tlGGI
         GIMo7EIA1JzPV3VxIsdaYmS8bK2chUXJVmMkrG2faMpmotaND8VXna0zGGjSAAO+y/++
         rynHfYSk8EKtaSfi69dCP8DMAD4EyM41lgV6Zg5LZFa5m/kTUiplmq51Zhe1SU/E4fn/
         TH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765882560; x=1766487360;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oki31/DgsZ6+KzPwIohVz4qvXrFW1AnimENJ+INjaho=;
        b=OSyqasu0G3gkJOVJR6zEJnE3njicMGwDFbt3Gk8dYI621uuB45CZ0Kwy+lSg6oqHGa
         x760s55NWSdv0jI8tlSxSaAqzCJoOo58VJHT+QXYhdIxdQUreUnLusHrM5fByoDzoE5t
         7xMTdJfBl11+THSK3Zdt8TQeUn9X3D6sOAnBXv390gjuEKK++/RXWaMXoDdyzpjjr64A
         GT2PAjTejQIwDnAZSiYXY+/iWewWreWP9MyFcVu/s0YzpwATTf5JKS3OXxPk1q1GPigi
         Zo4cYID1phN3g3pOiZYCzISTRKz7hnn9v32zC6umz7o1ZctAMyzdNdX0C83DvJABh3le
         GRIQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9aCagnork53OjqwIe+mj2VUORrJMt1tBcF8rxYGIlM1jVyYga/pNzDukIENLQwHtTHd+NZSk=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yzfp21vlgpS3pc2EJwAVGxFQ5BYvIM76ogdI5VRPwK0TNBHTiz7
	e/MOARGCe19j78uio5+hIIfL7nzha3MDTdSq6/YkmRreYagNQcOUJuwhpKiSgdyij7A8f+t4pd5
	y5+6qkJwS5cn/HCXjoWj6BW017OZxST9rfvuAWs388ALDFrb4zT4xJvGIQoOfvsuoCKdt0P7U
X-Gm-Gg: AY/fxX4NV7/ngAs+64dPAOOnD4HaBVhIWAvFff12IrkjKeeT8KiVfPwUCMaFUBySoSe
	BtgiQD+M2CM0GqodQzIDRGosrOzLySVsEJd7GOGihc8JnRPQ5KeUg20bkpvJ3TdVYlSURd8FM6k
	ykTloDyHc3/wkK+jHIGAn/Au+NUbn0enZWpcNP4AYpkkWAq3TSBDKpTV+K3iR3v1ZikOhRNR9Zp
	WITKWEePAhkmahlo0BNzwZ+HnBCudkcQ7bWmdP7JyZ6D4Jh8mnzVcIEPsE59cPh/VyD4E/81h5E
	/p1QWEpedw/ahuusdkWA71tsQJaEFsEl3OCVY6r3MuKMXVz8Kde0/IWWfFuDPYKRd7du33YXNEl
	9zB+FBo2Pk4H+CnF/N3BQYX+2PgeopawfnCp0Gy4=
X-Received: by 2002:a17:90b:2e0c:b0:34a:8e4b:5b52 with SMTP id 98e67ed59e1d1-34abd6cc4ccmr11105464a91.8.1765882559605;
        Tue, 16 Dec 2025 02:55:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrvhxL/1OIe2D/GBuAobttB7vmHPJWOQlRriLy1UbuK0EuA2bfX1PNz1XLE0mXVVGn4xs3Zg==
X-Received: by 2002:a17:90b:2e0c:b0:34a:8e4b:5b52 with SMTP id 98e67ed59e1d1-34abd6cc4ccmr11105452a91.8.1765882559165;
        Tue, 16 Dec 2025 02:55:59 -0800 (PST)
Received: from [10.217.223.121] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe294a00sm12076710a91.12.2025.12.16.02.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 02:55:58 -0800 (PST)
Message-ID: <ba8554b7-499b-4fb8-b792-471d83cf3893@oss.qualcomm.com>
Date: Tue, 16 Dec 2025 16:25:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tee: fix tee_ioctl_object_invoke_arg padding
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
References: <20251204101730.1036671-1-arnd@kernel.org>
 <CAHUa44H1Ejbbuzr1hF1HrT69JGgnvfkkDkh+9KvEvBT+eWBDhw@mail.gmail.com>
 <0b061075-ab71-4ac1-93ec-438ddaaec903@oss.qualcomm.com>
 <aTbCqyOuprPOyU4X@sumit-X1>
 <2c0d09b7-0d8c-4bf2-a1bd-1dc4b58cd0a8@oss.qualcomm.com>
 <3aacf997-3a21-4e4b-b6bd-c55c36fb4c74@oss.qualcomm.com>
 <CAHUa44GO-D1YcQ_36pe-vQ83fB9rcOkny+M7a=CThAxWb6TLTQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHUa44GO-D1YcQ_36pe-vQ83fB9rcOkny+M7a=CThAxWb6TLTQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=TLpIilla c=1 sm=1 tr=0 ts=69413ac0 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=ZhWf7fvzcGQh0Gx6-UQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: GoFbYD-eKK3O8Lb7Xtttx4xD7KmAnB5D
X-Proofpoint-ORIG-GUID: GoFbYD-eKK3O8Lb7Xtttx4xD7KmAnB5D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDA4OSBTYWx0ZWRfX+t9ZtS7TikzO
 JLgwn121shnkp6+MVpSSCGzbn/1hHnN6Y6PxykjAwiHncLYLlMIQ8QXcG25+oiYJ4HamsvO9Op7
 6HIZ1jgsOI3+ZFU972eFJ5mP37kJItTcWYT383l/P5K/hntcaiHOszJiLth75dFDtOokz9So78j
 YscfeBRTuMIshukkiQIK3hEY3HHBp/9yEv5dvoQSF41VmbO0PRyfoOpZAiiQxpgWQ08BvDhVxGH
 UTyS5bEFa6CCc12NJ13NhlR+nzOsB//HNdrduaIaftPxK6QFYvwIk1DszTwAsGisTz1phO2CWjr
 V2oqYDn10lL34+rcXUhlai0dD52jVuQzRhDfnD7Cw+eF8lpzbXODvsGSxjq9AD6yxuwxm8rT3Jz
 CryfwmboYO0N3wlemBi/U9YIX/rUlQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_01,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 adultscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512160089
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.69:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[202.46.22.19:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4610C4FE8E
X-Spamd-Bar: ------
Message-ID-Hash: OVXXUPOVIQ7SI44CPBTJ6V45DBAMYJVD
X-Message-ID-Hash: OVXXUPOVIQ7SI44CPBTJ6V45DBAMYJVD
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Sumit Garg <sumit.garg@oss.qualcomm.com>, Alexandre Ghiti <alex@ghiti.fr>, Etienne Carriere <etienne.carriere@foss.st.com>, Randy Dunlap <rdunlap@infradead.org>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/OVXXUPOVIQ7SI44CPBTJ6V45DBAMYJVD/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

SGkgSmVucywNCg0KT24gMTIvMTYvMjAyNSAxOjE4IFBNLCBKZW5zIFdpa2xhbmRlciB3cm90ZToN
Cj4gSGksDQo+IA0KPiBPbiBUdWUsIERlYyA5LCAyMDI1IGF0IDQ6NTTigK9BTSBBbWlycmV6YSBa
YXJyYWJpDQo+IDxhbWlycmV6YS56YXJyYWJpQG9zcy5xdWFsY29tbS5jb20+IHdyb3RlOg0KPj4N
Cj4+IEhpLA0KPj4NCj4+IE9uIDEyLzgvMjAyNSAxMTo1NCBQTSwgSGFyc2hhbCBEZXYgd3JvdGU6
DQo+Pj4NCj4+Pg0KPj4+IE9uIDEyLzgvMjAyNSA1OjUwIFBNLCBTdW1pdCBHYXJnIHZpYSBPUC1U
RUUgd3JvdGU6DQo+Pj4+IE9uIE1vbiwgRGVjIDA4LCAyMDI1IGF0IDA0OjI0OjE3UE0gKzExMDAs
IEFtaXJyZXphIFphcnJhYmkgd3JvdGU6DQo+Pj4+PiBIaSwNCj4+Pj4+DQo+Pj4+PiBPbiAxMi81
LzIwMjUgMTI6MjcgQU0sIEplbnMgV2lrbGFuZGVyIHdyb3RlOg0KPj4+Pj4+IEhpLA0KPj4+Pj4+
DQo+Pj4+Pj4gT24gVGh1LCBEZWMgNCwgMjAyNSBhdCAxMToxN+KAr0FNIEFybmQgQmVyZ21hbm4g
PGFybmRAa2VybmVsLm9yZz4gd3JvdGU6DQo+Pj4+Pj4+DQo+Pj4+Pj4+IEZyb206IEFybmQgQmVy
Z21hbm4gPGFybmRAYXJuZGIuZGU+DQo+Pj4+Pj4+DQo+Pj4+Pj4+IFRoZSB0ZWVfaW9jdGxfb2Jq
ZWN0X2ludm9rZV9hcmcgc3RydWN0dXJlIGhhcyBwYWRkaW5nIG9uIHNvbWUNCj4+Pj4+Pj4gYXJj
aGl0ZWN0dXJlcyBidXQgbm90IG9uIHg4Ni0zMiBhbmQgYSBmZXcgb3RoZXJzOg0KPj4+Pj4+Pg0K
Pj4+Pj4+PiBpbmNsdWRlL2xpbnV4L3RlZS5oOjQ3NDozMjogZXJyb3I6IHBhZGRpbmcgc3RydWN0
IHRvIGFsaWduICdwYXJhbXMnIFstV2Vycm9yPXBhZGRlZF0NCj4+Pj4+Pj4NCj4+Pj4+Pj4gSSBl
eHBlY3QgdGhhdCBhbGwgY3VycmVudCB1c2VycyBvZiB0aGlzIGFyZSBvbiBhcmNoaXRlY3R1cmVz
IHRoYXQgZG8NCj4+Pj4+Pj4gaGF2ZSBpbXBsaWNpdCBwYWRkaW5nIGhlcmUgKGFybTY0LCBhcm0s
IHg4NiwgcmlzY3YpLCBzbyBtYWtlIHRoZSBwYWRkaW5nDQo+Pj4+Pj4+IGV4cGxpY2l0IGluIG9y
ZGVyIHRvIGF2b2lkIHN1cnByaXNlcyBpZiB0aGlzIGxhdGVyIGdldHMgdXNlZCBlbHNld2hlcmUu
DQo+Pj4+Pj4+DQo+Pj4+Pj4+IEZpeGVzOiBkNWI4YjBmYTE3NzUgKCJ0ZWU6IGFkZCBURUVfSU9D
VExfUEFSQU1fQVRUUl9UWVBFX09CSlJFRiIpDQo+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEFybmQg
QmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+DQo+Pj4+Pj4+IC0tLQ0KPj4+Pj4+PiBUaGUgbmV3IGlu
dGVyZmFjZSBzaG93ZWQgdXAgaW4gNi4xOCwgYnV0IEkgb25seSBjYW1lIGFjcm9zcyB0aGlzIGFm
dGVyDQo+Pj4+Pj4+IHRoYXQgd2FzIHJlbGVhc2VkLiBDaGFuZ2luZyBpdCBub3cgaXMgdGVjaG5p
Y2FsbHkgYW4gQUJJIGNoYW5nZSBvbg0KPj4+Pj4+PiBhcmNoaXRlY3R1cmVzIHdpdGggdW51c3Vh
bCBwYWRkaW5nIHJ1bGVzLCBzbyBwbGVhc2UgY29uc2lkZXIgY2FyZWZ1bGx5DQo+Pj4+Pj4+IHdo
ZXRoZXIgd2Ugd2FudCB0byBkbyBpdCB0aGlzIHdheSBvciBub3QuDQo+Pj4+Pj4+DQo+Pj4+Pj4+
IFdvcmtpbmcgYXJvdW5kIHRoZSBBQkkgZGlmZmVyZW5jZXMgd2l0aG91dCBhbiBBQkkgY2hhbmdl
IGlzIHBvc3NpYmxlLA0KPj4+Pj4+PiBidXQgYWRkcyBhIGxvdCBvZiBjb21wbGV4aXR5IGZvciBj
b21wYXQgaGFuZGxpbmcuDQo+Pj4+Pj4NCj4+Pj4+PiBUaGlzIGlzIGN1cnJlbnRseSBvbmx5IHVz
ZWQgYnkgdGhlIHJlY2VudGx5IGludHJvZHVjZWQgcWNvbXRlZSBiYWNrZW5kDQo+Pj4+Pj4gZHJp
dmVyLiBTbyBpdCdzIG9ubHkgdXNlZCBvbiBhIGZldyBhcm02NCBRdWFsY29tbSBwbGF0Zm9ybXMg
cmlnaHQgbm93Lg0KPj4+Pj4+DQo+Pj4+Pj4gSSB0aGluayB3ZSBzaG91bGQgdGFrZSB0aGlzIHBh
dGNoLCBidXQgbGV0J3MgaGVhciB3aGF0IG90aGVycyB0aGluay4NCj4+Pj4NCj4+Pj4gWWVhaCBz
aW5jZSBpdCdzIG5vdCBhbiBBQkkgaXNzdWUgb24gYXJtNjQgcGxhdGZvcm1zIHdoZXJlIFFURUUg
cnVucywgc286DQo+Pj4+DQo+Pj4+IFJldmlld2VkLWJ5OiBTdW1pdCBHYXJnIDxzdW1pdC5nYXJn
QG9zcy5xdWFsY29tbS5jb20+DQo+Pj4+DQo+Pj4+Pj4NCj4+Pj4+PiBUaGFua3MsDQo+Pj4+Pj4g
SmVucw0KPj4+Pj4+DQo+Pj4+Pg0KPj4+Pj4gSSBhZ3JlZS4gV2Ugc2hvdWxkIHRha2UgdGhpcyBw
YXRjaC4gQXMgbm90ZWQsIHRoZXJlIGFyZSBub3QgbWFueQ0KPj4+Pj4gY2xpZW50cyByZWx5aW5n
IG9uIGl0IHlldCwgc28gdXBkYXRpbmcgdGhlIHVzZXJzcGFjZSBzaG91bGQNCj4+Pj4+IGJlIHN0
cmFpZ2h0Zm9yd2FyZC4NCj4+Pj4NCj4+Pj4gWW91IHNob3VsZCByYXRoZXIgdGVzdCB3aXRob3V0
IGFueSB1c2Vyc3BhY2UgbGlicmFyeSB1cGRhdGUgdG8gdGVzdCBpdCdzDQo+Pj4+IG5vdCBhbiBB
QkkgaXNzdWUuIEp1c3QgZm9yIGNvcnJlY3RuZXNzIHNha2UsIHlvdSBjYW4gdXBkYXRlIHRoZSBs
aWJyYXJ5DQo+Pj4+IHRvby4NCj4+Pj4NCj4+Pg0KPj4+IEknbGwgdGFrZSB0aGUgdGltZSB0byB0
ZXN0IGl0IGF0IHNvbWUgcG9pbnQgdGhpcyB3ZWVrIGJvdGggd2l0aCBhbmQgd2l0aG91dCB1cGRh
dGluZw0KPj4+IHRoZSBsaWJyYXJ5IEFCSS4NCj4+Pg0KPj4NCj4+IFN1bW1pdCwgdGhhdCB3YXMg
dGhlIHBsYW4gZnJvbSB0aGUgYmVnaW5uaW5nLCB0aGF0J3Mgd2h5IEkgZGlkIG5vdCBhZGQgIlJl
dmlld2VkLWJ5OiINCj4+IGluIHRoZSBmaXJzdCBwbGFjZS4gVGhhbmtzIEhhcnNoYWwgZm9yIHZv
bHVudGVlcmluZy4NCj4gDQo+IEFyZSB3ZSBnb29kIHdpdGggdGhpcyBwYXRjaCBub3c/DQo+DQoN
ClllcywgdGhpcyBpcyBnb29kIGZyb20gb3VyIHNpZGUuDQoNClRlc3RlZC1ieTogSGFyc2hhbCBE
ZXYgPGhhcnNoYWwuZGV2QG9zcy5xdWFsY29tbS5jb20+DQoNCj4gQ2hlZXJzLA0KPiBKZW5zDQoN
Cg==
