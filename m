Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCC2C43458
	for <op-tee@archiver.kernel.org>; Mon, 29 Jun 2026 13:35:20 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id CE19144E87
	for <op-tee@archiver.kernel.org>; Mon, 29 Jun 2026 13:35:19 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P0NFNSeG;
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A0BA044DB7
	for <op-tee@lists.trustedfirmware.org>; Fri, 26 Jun 2026 17:06:00 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4926046fbc5so13851505e9.0
        for <op-tee@lists.trustedfirmware.org>; Fri, 26 Jun 2026 10:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782493559; x=1783098359; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ctcxDsWWE5CsrZTwx1xGnbf39A7pUyPEOclo5R2hslQ=;
        b=P0NFNSeGTgAyEcENmfHxG55IKzmILlacwitAFe8W3Cm6BtvMB43c+zLbBngHkX48Jj
         xH7ff/oXc773KkghpsA5Ukjup1n33Yi7+vupv4wxAx7zXwS4S3Cxx22tv1ZYzVM92MwM
         x8AvLHzWVcPCECvvN2XE61qT0UReQMdWonIWDNpENJJ/NN+MFT8bUHpKDv1b1BPj2CNU
         aJcp69Rhh8IBtW1T0uowaw+PsyRTU9Qp59QFj8CjRNarbCxLcbUKO9/lMlvxpV0qX2eB
         nTMI0Cn0To8dFAGQgxlokEM+GQVkursGJ2IM7q89ZsRql3GGZLV4Kz6eozvNt0EPdZoj
         YI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782493559; x=1783098359;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctcxDsWWE5CsrZTwx1xGnbf39A7pUyPEOclo5R2hslQ=;
        b=lxdkItDcYsNeJTKKClyqtBL/fVnkqgeYoHlu1lojZ7Sp9Cy3QGyu6VBe+T89i4p+Al
         IDHJu+fE0HcTYRmZSjzwecNRG7ywh6GB4yh3//ZxM3JpO2v2yyRQOSljXSMzQF8HnKEG
         5N7vPSyohleXzLrMffSIEFHsEZeNr9YFlN2fUcv5TZOPu2xI2hbLBJ6relC1nvla+yTG
         wGilg3TFwjOu2gW+2xxsa8kqWLNMpHjprjVfolv5M3JIgc8qu9IP8h/yxaD6O6/ltHtj
         vnAu/Kmangr51WpcbNno7t45ncyHyjxP2MzU2dcb5tPlxWpNEvTA/Z0ICYhWb0tlgXpJ
         /Jug==
X-Forwarded-Encrypted: i=1; AFNElJ8SFwfFXJGYGP1ERejuJIxtrR6A9inx1PxAkx8pHCpIaapbhGDFHPNVMPwTOQMCxHE910fbeMg=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxYU3t08ARLzY2ayZdpSE2WEHVWXx/J9tdAUBmscnlMjO90e5TV
	80TRzCjQSeNaMZZfe17vGU6JCsrnvRR0teh9Kj8QCMFK2zBGsf73XZ3H
X-Gm-Gg: AfdE7cnk9hvdnQnY4fwNww7T0OrtqeU8Uw5TYtA/tFFOfyeG1aEDWeQCWCMnx1l2eon
	pYiocRdqfspus1r812Xy7Pbi1UaUVjoa7f9yfHo5kYZ8YmxVeDlpDyfrcl7Ir9ejIRAVQplAZLc
	/R/MYCS4v6CycynoJXRL7QyvA1BfGeQqI3kI9xfRjLtNdBcqn7DLvJDU4IxZcellnXf61p0V7HR
	/j8rNatt4FggPMubhUO0cqEiBlkSBCVTROHXL5TUtnOgsLU9hHhFgZFUwUl9xt4uRg7CpH6gxXX
	fITMkPU+HwY34GaMUVx3j2j6Bc2pxj3AUbgFjEJCj6mGyATHOeE9YHqSfB7kzCFvSpkPxa4G9BD
	Ida3XhvVbqeO80zaKiZHeZ/8m654vcfCR/9L7MoFG3gG8sfJqAFtQy3ZCpfqwVED0tcujiCYH7q
	9XPg7UPx4s8G9uSLRQ9pQVy4RIRpHRUTQwT7nyaPJ6SvoqrYy9nCRVaADfPLE/messqx/B9d1LB
	Qj4Vjo8
X-Received: by 2002:a05:600d:864a:20b0:492:5bf9:d149 with SMTP id 5b1f17b1804b1-4925bf9d18amr186215685e9.5.1782493559068;
        Fri, 26 Jun 2026 10:05:59 -0700 (PDT)
Received: from [10.128.11.240] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46fe25429d5sm1694876f8f.7.2026.06.26.10.05.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2026 10:05:57 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <ac8c92cb-21f2-4274-8fe6-f771fe48eec7@gmail.com>
Date: Fri, 26 Jun 2026 18:05:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/14] firmware: qcom_scm: Migrate to generic PAS
 service
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-3-sumit.garg@kernel.org>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260626133440.692849-3-sumit.garg@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[49];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.42:from];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.42:from];
	TAGGED_RCPT(0.00)[dt,netdev];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A0BA044DB7
X-Spamd-Bar: --
X-MailFrom: julianbraha@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: 2QKVNQQ3GRR2IZYKP5QDRSOH6JQCCFCB
X-Message-ID-Hash: 2QKVNQQ3GRR2IZYKP5QDRSOH6JQCCFCB
X-Mailman-Approved-At: Mon, 29 Jun 2026 13:35:14 +0000
CC: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.
 com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>, Harshal Dev <harshal.dev@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/2QKVNQQ3GRR2IZYKP5QDRSOH6JQCCFCB/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

SGkgU3VtaXQsDQoNCk9uIDYvMjYvMjYgMTQ6MzQsIFN1bWl0IEdhcmcgd3JvdGU6DQoNCj4gIGNv
bmZpZyBRQ09NX1NDTQ0KPiArCXRyaXN0YXRlICJRdWFsY29tbSBQQVMgU0NNIGludGVyZmFjZSBk
cml2ZXIiDQo+ICsJc2VsZWN0IFFDT01fUEFTDQo+ICAJc2VsZWN0IFFDT01fVFpNRU0NCj4gLQl0
cmlzdGF0ZQ0KSSB0aGluayBRQ09NX1NDTSBpcyBtaXNzaW5nIGEgJ3NlbGVjdCBJUlFfRE9NQUlO
Jy4gUmlnaHQgbm93IEkgZ2V0IGENCmJ1aWxkIGVycm9yIHdpdGhvdXQgaXQ6DQoNCmRyaXZlcnMv
ZmlybXdhcmUvcWNvbS9xY29tX3NjbS5jOiBJbiBmdW5jdGlvbiDigJhxY29tX3NjbV9nZXRfd2Fp
dHFfaXJx4oCZOg0KICBkcml2ZXJzL2Zpcm13YXJlL3Fjb20vcWNvbV9zY20uYzoyNTEyOjE2OiBl
cnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24NCm9mIGZ1bmN0aW9uIOKAmGlycV9jcmVhdGVfZndz
cGVjX21hcHBpbmfigJk7IGRpZCB5b3UgbWVhbg0K4oCYaXJxX2NyZWF0ZV9vZl9tYXBwaW5n4oCZ
PyBbLVdpbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0NCiAgIDI1MTIgfCAgICAgICAgIHJl
dHVybiBpcnFfY3JlYXRlX2Z3c3BlY19tYXBwaW5nKCZmd3NwZWMpOw0KICAgICAgICB8ICAgICAg
ICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCiAgICAgICAgfCAgICAgICAgICAg
ICAgICBpcnFfY3JlYXRlX29mX21hcHBpbmcNCg0KLSBKdWxpYW4gQnJhaGENCg==
