Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41927C43458
	for <op-tee@archiver.kernel.org>; Wed,  1 Jul 2026 07:21:42 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8498444AE4
	for <op-tee@archiver.kernel.org>; Wed,  1 Jul 2026 07:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1782890501;
	bh=Sdja9Taew43ZmnngDyoOZwsXrpeJ6MEbPJqdiJq748Q=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=SmqQt1MCc0YZWPJ4zUMVNlp1KH+uynk9HwQwKfxnyXjSO+kWljYbz6DJTIn+uNmr0
	 dwJNfRPcZQAaj5Q7SpJdqX+iuT48bokjRsv6G4CD7KL6aRf+UfCLSVQFhItGCur7Hd
	 oNSKQInhcZddETToRYWzk9Qa1MxL02dmXXMXchHx7UP8tbBiBYyOv63kIQU7AW8JV7
	 iF3cN+l4+HkDsAhLfMT9bMfl9/Pd8i3JPa8AmdzdlB8SPrSnaFQ3btuLOiww/Ahq6T
	 64kPI0cxkH7KEgSMFPg+CViUMcTx7+SFTGKPBLJwm72PshSvOCQxQzqOlzZlrmaKPF
	 KKvwqVoSjgcFA==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id CA75943EBF
	for <op-tee@lists.trustedfirmware.org>; Wed,  1 Jul 2026 07:21:34 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lxnOmPYi;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 32F9B6001D;
	Wed,  1 Jul 2026 07:21:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192F21F000E9;
	Wed,  1 Jul 2026 07:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782890493;
	bh=E8QuM5x7gXGTaLLIIkxCkvrp1Q5hGaoiUi54XE05gBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lxnOmPYiTm5nMcXoRupb4T809lC2MPU9MotfSPQqFnkS0hl7wSnlOIbrJDt7bYekA
	 sVI7f9YSbJwxbO3u0XfHBURHRZlAAzBwjcRa7ShoFl4mSAzdL250vAQBhsVYHLxYOz
	 lJ7pSTB5tl4owIgtmPSU9hPFWTm9fZYAtim76KJHfRmZutumZgDE16fIPAKf8KLzGa
	 zVY3+Rs/vv9nPdSM0Sa5+CPx4HzOg9SPN/Q04wZ7M/iIGeGJECFNKF6x+a/WnF5n0v
	 t4eo5mj5Bhhv0l95T8RNDIP4NtlQqGPv6v66blXrshDRtF6evB4iQ39jw3D4Nl6tV3
	 sixI5cetuXoTg==
Date: Wed, 1 Jul 2026 12:51:14 +0530
To: Julian Braha <julianbraha@gmail.com>
Subject: Re: [PATCH v8 02/14] firmware: qcom_scm: Migrate to generic PAS
 service
Message-ID: <akS_6izxrhgK-I22@sumit-xelite>
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-3-sumit.garg@kernel.org>
 <ac8c92cb-21f2-4274-8fe6-f771fe48eec7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <ac8c92cb-21f2-4274-8fe6-f771fe48eec7@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.00 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[100.103.45.18:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	ALIAS_RESOLVED(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: CA75943EBF
X-Spamd-Bar: ----
Message-ID-Hash: HHCP6VFNHN6SHB6M5GUSXCG2HKKJAIOL
X-Message-ID-Hash: HHCP6VFNHN6SHB6M5GUSXCG2HKKJAIOL
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: andersson@kernel.org, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.ka
 ndagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>, Harshal Dev <harshal.dev@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/HHCP6VFNHN6SHB6M5GUSXCG2HKKJAIOL/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

T24gRnJpLCBKdW4gMjYsIDIwMjYgYXQgMDY6MDU6NTRQTSArMDEwMCwgSnVsaWFuIEJyYWhhIHdy
b3RlOg0KPiBIaSBTdW1pdCwNCj4gDQo+IE9uIDYvMjYvMjYgMTQ6MzQsIFN1bWl0IEdhcmcgd3Jv
dGU6DQo+IA0KPiA+ICBjb25maWcgUUNPTV9TQ00NCj4gPiArCXRyaXN0YXRlICJRdWFsY29tbSBQ
QVMgU0NNIGludGVyZmFjZSBkcml2ZXIiDQo+ID4gKwlzZWxlY3QgUUNPTV9QQVMNCj4gPiAgCXNl
bGVjdCBRQ09NX1RaTUVNDQo+ID4gLQl0cmlzdGF0ZQ0KPiBJIHRoaW5rIFFDT01fU0NNIGlzIG1p
c3NpbmcgYSAnc2VsZWN0IElSUV9ET01BSU4nLiBSaWdodCBub3cgSSBnZXQgYQ0KPiBidWlsZCBl
cnJvciB3aXRob3V0IGl0Og0KPiANCj4gZHJpdmVycy9maXJtd2FyZS9xY29tL3Fjb21fc2NtLmM6
IEluIGZ1bmN0aW9uIOKAmHFjb21fc2NtX2dldF93YWl0cV9pcnHigJk6DQo+ICAgZHJpdmVycy9m
aXJtd2FyZS9xY29tL3Fjb21fc2NtLmM6MjUxMjoxNjogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0
aW9uDQo+IG9mIGZ1bmN0aW9uIOKAmGlycV9jcmVhdGVfZndzcGVjX21hcHBpbmfigJk7IGRpZCB5
b3UgbWVhbg0KPiDigJhpcnFfY3JlYXRlX29mX21hcHBpbmfigJk/IFstV2ltcGxpY2l0LWZ1bmN0
aW9uLWRlY2xhcmF0aW9uXQ0KPiAgICAyNTEyIHwgICAgICAgICByZXR1cm4gaXJxX2NyZWF0ZV9m
d3NwZWNfbWFwcGluZygmZndzcGVjKTsNCj4gICAgICAgICB8ICAgICAgICAgICAgICAgIF5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4gICAgICAgICB8ICAgICAgICAgICAgICAgIGlycV9jcmVh
dGVfb2ZfbWFwcGluZw0KPg0KDQpUaGlzIGlzc3VlIHNob3VsZCBiZSBpbmRlcGVuZGVudCBvZiB0
aGlzIHBhdGNoLXNldC4gUGxlYXNlIHN1Ym1pdCBhDQpzdGFuZGFsb25lIGZpeCBmb3IgdGhpcy4N
Cg0KLVN1bWl0DQo=
