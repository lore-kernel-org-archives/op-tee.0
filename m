Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07F46080785
	for <op-tee@archiver.kernel.org>; Wed,  4 Nov 2026 19:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=orkRQADS;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L5SC35i6
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 21B274539D
	for <op-tee@archiver.kernel.org>; Wed,  4 Nov 2026 19:38:13 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=orkRQADS;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L5SC35i6;
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 02A5445278
	for <op-tee@lists.trustedfirmware.org>; Wed,  4 Nov 2026 19:37:54 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4FjG0n2829051
	for <op-tee@lists.trustedfirmware.org>; Wed, 4 Nov 2026 19:37:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9/OFrJ8GGE9h5yRFJ66Xeugo3H18/5jrLH6ADJy3KDU=; b=orkRQADSaGoJA41q
	M3ucuAKlsyuMkNqB0/eHQR0+sNhCFqnjWtlyeLMDJRZMU06NlUf80dJHdEeqOqcp
	kzp42KOc/OY8+XBtwlEqh5LCaicasOhfM4/ZUr3NIQCmZ5zka/tNYzkQJdGIo3oG
	9NFzvoo0Lq3bEoH82qaWTSjSFEftDL2RRkHVr2UJvfL+IVFZlmW7NkRqNC5k1ZjS
	tDgxpjw69QdCPJ2iCGZlZwtLx7e6jyRpU+uZmExYqICFBDIEUaYiw5gz04kYN2na
	Ic5W9DcrjPCWuIxrdyU7TX5H1vtI+PJ52jWQWg/11U50uIRp5izUpoTzEKVQpXvu
	r5cxAQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr284tg1x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 04 Nov 2026 19:37:54 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8a030e0f9c1so1290225b3a.2
        for <op-tee@lists.trustedfirmware.org>; Wed, 04 Nov 2026 11:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793821072; x=1794425872; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9/OFrJ8GGE9h5yRFJ66Xeugo3H18/5jrLH6ADJy3KDU=;
        b=L5SC35i6/TBv49GlWaMacbQY8oS6y9PziJFJlDZHaRkpJAUThQy2g6RihE23jKOP9y
         IXoYbKK00jiidfc4Z59cpbE6NlDb4FWftA2stc8Yld1PmdwwvCW+XbCWsiLAESgbXHDu
         LVULlLr9/UuelREuheynONK2odRK4Yon7uOATHi7op9wtBvDTvV45WmJj8x6FVGrs0Wn
         tIlW/R3dz04bggyNeapw12Ym1hY2h4cbUNC7eHk2BpGS36eI47C69jUnIGDw1c8Serax
         EXwno/jgb02m1/MedINonvOHZDX3deYeyxtpd72zO2oqStFJBSDVCktxUGLRrTY+CES/
         WTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793821072; x=1794425872;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9/OFrJ8GGE9h5yRFJ66Xeugo3H18/5jrLH6ADJy3KDU=;
        b=x82OtnqHKTmTYofeBD/1yHP5FSFDRNLAk6szRxwdp8LVe1plk6YR99lMy6aVu4LK3y
         bPubt7ufA+PAYMDegvHtIQqA5RYoHM25Yyz+vLuf3n/sOBshD7KvFHoaNUyOPTOqnwGG
         M5qv/zsnE43tvLEdE7oCz6EfptRlwpL0TPLMeTtIP6mVnExg7H5ZC0572r4SAChlafM0
         hsJnzcllUzAgLJQVbZnqrrGssEQpr/I20XQEt8GxY4RIKhKsxJu/UIQjvEp9XkYXcvl9
         V/tDjM2ay8unJ1vvJUOj4QE1KpDutXo9HqKAN919q4D2M1AZAdcGe264YXXxFOGIQkR9
         4qKw==
X-Forwarded-Encrypted: i=1; AKwUvBwVcEa6I6erD9EgGmH6D33EAUBNb7uMkBncSi5u6hp+FxWreWokOLGdeAmErSCfjLyZyRscYl4=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z8GcRLcSmwBJP1kWER0nA+VrbR8gH8lIcyJYEsjIrjdeDz4HhIu
	s4jZZgIWQadx+fw+sMW8keiUJfHWou81cVVasRedBdWY64UAk/iqvtINoa7uQ8A4tDTcNm+74nN
	R+t05VZ2dSeF8dgsCpRRSmSee8/+w/U2qP3S7sO3RECZdtZg5LAAnVTDoek3aBrpZ80iA8Ok=
X-Gm-Gg: AYBFou01piMgXLRkzJK9NsP7tGBTr4W82f6ojppbmnAVA5ERvne/pOENAfYu33FbHNu
	UfvCWKQVk8+vCGf9NEEYgjEk6KGJw28zGU7olQzyB3qiO12OGvf9L3ORyWIAFSV4kSC8mD8A+Fn
	SKJm/IbKx/BX8w5TT6uwplIZBgjtWqRASHVt71+DE8Xqc5+L5jNwb3qM/iXAcEeVJEsEGxPeKk7
	k3QWElvJ3bxg86597KyMTIxZH6yN+HqPl2qmu/ocbSZtym0i72AFidC5Uk8N7EixWkI5jR709dd
	hTuzM894STx4aZ3yJpGoCd1i6mrTFcbNFujiM/9tEoFEnWIVxNcJEzfyaUt91mz9oFPi4gmmg5C
	nDdJBtZIsOjVGQ5NNX9Gthq2jV3MvW/S3Hv/NIsWgptckTp7nHMnSo2QbsTGt+wHxR36VI7s1LV
	SfIQ3b
X-Received: by 2002:a05:6a00:1f0b:b0:878:34d7:6a24 with SMTP id d2e1a72fcca58-8a9beb69d9amr14143266b3a.38.1793821071636;
        Wed, 04 Nov 2026 11:37:51 -0800 (PST)
X-Received: by 2002:a05:6a00:1f0b:b0:878:34d7:6a24 with SMTP id d2e1a72fcca58-8a9beb69d9amr14143249b3a.38.1793821071128;
        Wed, 04 Nov 2026 11:37:51 -0800 (PST)
Received: from [192.168.1.86] ([65.181.14.223])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09a7cc082sm1275492b3a.12.2026.11.04.11.37.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 11:37:50 -0800 (PST)
Message-ID: <6f2f8357-59ef-491b-95f2-d58feb362ba7@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 06:37:45 +1100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tee: qcomtee: user: check the parameter count from the
 supplicant
To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        HyeongJun An <sammiee5311@gmail.com>
References: <20260730062219.2836938-1-sammiee5311@gmail.com>
 <CAGgiveUc+TkGyGDxuuCLpHO=i22-4fn1CqjqnnmWLdWWYOZfPA@mail.gmail.com>
Content-Language: en-US
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
In-Reply-To: <CAGgiveUc+TkGyGDxuuCLpHO=i22-4fn1CqjqnnmWLdWWYOZfPA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=JdQpPkKV c=1 sm=1 tr=0 ts=6aeb8992 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=YVmDP9EW+FTsGeEl22X1ng==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=47U92Yqy_zLrgJxgMLYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: biWVB_NKo_fD0Rukir-tmpp6L8eyghY6
X-Proofpoint-GUID: biWVB_NKo_fD0Rukir-tmpp6L8eyghY6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA3OCBTYWx0ZWRfX/44gQB1tnTPK
 OvSYLYtIoup+lx9+ytUKywlCN19TnSLAQkyPsqQODlH98o4NC/zEWWFPNNMhlUz0ytSDGmhEOn/
 yv0cxImZgf1AeUn2ad0twt9SxmT4Qugy2Gs+Zq1McT4ZKSGsUg8XmxBLJ3DlLlzXfjvOPuHbiEo
 nh3GV2xz6al98GQWFOTu4DV8Yj0wvA690lbnel8PywDYCrom5QYi7lG4N7hDXfkmHNh0INwud9X
 JKdOfNhisEHYjCR7Sl/aD/KDz/QEjlHvXzlRrjCi0eZiA4tPmMf6sMAG5uQuqnPIQeMoUeu4V0+
 USTuUwm/GjSCz9c5i3ovhSggMu/gcJ8oYkSZYGDxelFpFDVALLCYa3VZK8McrH7SSMFMBN+5YBx
 z2mJI2LuKIoUg4CrshWUnfB0gv6EUZNql+/IZiPeirK+EvuJDJukBTyDWT/+VOwX4z3tws9df/w
 i7DiDhOG0+lk5Va5mHA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA3OCBTYWx0ZWRfX1DTz+faf1xKT
 2s95HGb9e/ppZ+R7yn4Yke1zjiHdvsDSY/X67Efg1Ibieqb/C3LtwFZN3xz5RPALM+6v6Z46DyG
 LQ9QFQoNCwkckl5YtTjxVzZY/F82flU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040078
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[oss.qualcomm.com,none];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.199:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DNSWL_BLOCKED(0.00)[205.220.180.131:from];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 02A5445278
X-Spamd-Bar: ---
Message-ID-Hash: 7SRMP2IXXYQYPNVQPFSEDF4WFSNHQDFY
X-Message-ID-Hash: 7SRMP2IXXYQYPNVQPFSEDF4WFSNHQDFY
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/7SRMP2IXXYQYPNVQPFSEDF4WFSNHQDFY/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgSmVucywNCg0KT24gMTEvNC8yMDI2IDQ6NTggQU0sIEplbnMgV2lrbGFuZGVyIHdyb3RlOg0K
PiBIaSwNCj4gDQo+IE9uIFdlZCwgQXVnIDUsIDIwMjYgYXQgMTE6MjPigK9BTSBIeWVvbmdKdW4g
QW4gPHNhbW1pZWU1MzExQGdtYWlsLmNvbT4gd3JvdGU6DQo+Pg0KPj4gVGhlIHFjb210ZWVfY2Jf
cGFyYW1zX3RvX2FyZ3MoKSB3YWxrcyB0aGUgYXJndW1lbnQgYXJyYXkgUVRFRSBhc2tlZCBmb3Ig
YW5kDQo+PiBpbmRleGVzIHRoZSBwYXJhbWV0ZXIgYXJyYXkgdGhlIHN1cHBsaWNhbnQgc3VwcGxp
ZWQsIGJ1dCBpdCBuZXZlciBsb29rcyBhdA0KPj4gbnVtX3BhcmFtcy4gQSBzdXBwbGljYW50IHRo
YXQgYW5zd2VycyBURUVfSU9DX1NVUFBMX1NFTkQgd2l0aCBmZXdlcg0KPj4gcGFyYW1ldGVycyB0
aGFuIHRoZSByZXF1ZXN0IG5lZWRzIG1ha2VzIHRoYXQgd2FsayByZWFkIHBhc3QgdGhlIGVuZCBv
ZiB0aGUNCj4+IGFsbG9jYXRpb24uDQo+Pg0KPj4gVG8gZml4IHRoaXMsIHJlamVjdCBhIHJlc3Bv
bnNlIHRoYXQgaXMgdG9vIHNob3J0LCB0aGUgd2F5IHVyZXFfc2VsZWN0KCkNCj4+IGFscmVhZHkg
ZG9lcyBmb3IgdGhlIHJlY2VpdmUgZGlyZWN0aW9uLg0KPj4NCj4+IEZpeGVzOiBkNmUyOTA4Mzdl
NTAgKCJ0ZWU6IGFkZCBRdWFsY29tbSBURUUgZHJpdmVyIikNCj4+IEFzc2lzdGVkLWJ5OiBDbGF1
ZGU6Y2xhdWRlLW9wdXMtNQ0KPj4gU2lnbmVkLW9mZi1ieTogSHllb25nSnVuIEFuIDxzYW1taWVl
NTMxMUBnbWFpbC5jb20+DQo+PiAtLS0NCj4+ICBkcml2ZXJzL3RlZS9xY29tdGVlL3VzZXJfb2Jq
LmMgfCA0ICsrKysNCj4+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+Pg0KPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGVlL3Fjb210ZWUvdXNlcl9vYmouYyBiL2RyaXZlcnMvdGVl
L3Fjb210ZWUvdXNlcl9vYmouYw0KPj4gaW5kZXggMTA0NTJmY2M3Y2NiLi4yYTU5NGFlMjk5ZGEg
MTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3RlZS9xY29tdGVlL3VzZXJfb2JqLmMNCj4+ICsrKyBi
L2RyaXZlcnMvdGVlL3Fjb210ZWUvdXNlcl9vYmouYw0KPj4gQEAgLTUwNyw2ICs1MDcsMTAgQEAg
c3RhdGljIGludCBxY29tdGVlX2NiX3BhcmFtc190b19hcmdzKHN0cnVjdCBxY29tdGVlX2FyZyAq
dSwNCj4+ICB7DQo+PiAgICAgICAgIGludCBpOw0KPj4NCj4+ICsgICAgICAgLyogU3VwcGxpY2Fu
dCBjYW4gbm90IHNlbmQgZmV3ZXIgcGFyYW1ldGVycyB0aGFuIHJlcXVlc3RlZC4gKi8NCj4+ICsg
ICAgICAgaWYgKG51bV9wYXJhbXMgPCBxY29tdGVlX2FyZ3NfbGVuKHUpKQ0KPj4gKyAgICAgICAg
ICAgICAgIHJldHVybiAtRUlOVkFMOw0KPj4gKw0KPj4gICAgICAgICBxY29tdGVlX2FyZ19mb3Jf
ZWFjaChpLCB1KSB7DQo+PiAgICAgICAgICAgICAgICAgc3dpdGNoICh1W2ldLnR5cGUpIHsNCj4+
ICAgICAgICAgICAgICAgICBjYXNlIFFDT01URUVfQVJHX1RZUEVfSUI6DQo+PiAtLQ0KPj4gMi40
My4wDQo+Pg0KPiANCj4gTG9va3MgZ29vZC4gQW1pciwgZG8geW91IGFncmVlPw0KDQpZZXMuIEl0
J3MgY29ycmVjdC4gVGhlIGNoZWNrIGlzIG1pc3NpbmcuDQoNClJldmlld2VkLWJ5OiBBbWlycmV6
YSBaYXJyYWJpIDxhbWlycmV6YS56YXJyYWJpQG9zcy5xdWFsY29tbS5jb20+DQoNCkJlc3QgUmVn
YXJkcywNCkFtaXINCg0KPiANCj4gQ2hlZXJzLA0KPiBKZW5zDQoNCg==
