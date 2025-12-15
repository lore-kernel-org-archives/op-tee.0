Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB58D5B861
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 19:03:17 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id BE0134FE9C
	for <op-tee@archiver.kernel.org>; Mon, 15 Dec 2025 19:03:16 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=CriDStfW;
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 183D545454
	for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 19:03:00 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso24565955e9.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 15 Dec 2025 11:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765825379; x=1766430179; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZvQwruhu7sYt5Bk5SrrztsXfeD2aNCw59rPyvKluv5M=;
        b=CriDStfW4vOeUGBDaBaM9lGaFvRhq9SB+VCXuHsA/PI/AyX89+KDSIJN3mqYLBqiC0
         zfNNFaxVtP6x0U0OBDxf7oZlYmJn5D9VSlOPAjuicKArb/CQI+tIft3IRrEgqdjy1vn2
         MYDmtRGyZixDTIzdwkqCKZiJmWjIiOmk4p9pLlYxOisSgG1Br9Lx3sjccGI4gqIKr7DN
         BMQBUcLl4sRZ2ICum0ZZLyjeB7Ocj60y5C7KzGUfNvMJjMVyhlj89fo93q6U1ou9ll2b
         NoYW52gG5CBu/9X1RPR1e64IGoz62Lzd7jvX4Fme7fonqHmT9VdmRjg9lIw8F/y77dHB
         dAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765825379; x=1766430179;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZvQwruhu7sYt5Bk5SrrztsXfeD2aNCw59rPyvKluv5M=;
        b=Omg/UoB8GjsVn1a/KJFBqkPNsiLFsYV9m5vrNqCZBL8djTxcUOMvBzMyldaraCjqnF
         Duh5S5mP9jRTqWR8uTTd6GhRrWFnb2GXxtpXgr7lhF6egCUNAgkxSsIa4p5WdZp0rftv
         juTK1M8lgGSuAKRu5nJkMEZBAw1SXo7n+y1+JDe42skY09GURpym3L82YxYjGHhEkTC0
         rIO8r3rBRdtuFkZzsqNsQDv8xLGIaNFJA7Gt2l6EWI8KG8WvTwkSd1cYbMHTqb9O40aw
         ESZejrFwQBMgtRNhDCSJSTm+oNVMAOiLEAy2bjrLn/lZLV+iAD0AE39s/upvV3f5f3Tl
         PJHA==
X-Gm-Message-State: AOJu0YyeaSCjw8EoR/lYrojWCYls52DddbHdoDtb6OA194tU9NtoTztI
	I9OhWrvnWzMM/g/KsbsxbD6A+nShtjCGQp/5BC/4XyYLYNGfdJmjuGEV9iXzA1rEluPwew==
X-Gm-Gg: AY/fxX7xCli9fotXDa5HvGEzrspL52Ucjxi8wyYJz3zuRZDl9yur2FJFomx+XYifDtI
	t/4I0D9vk2T+f62ri46RkGi7cRN2oCWe9qeyZSZcNc9XgolwHbc15bOdTsJZGPMgdVXmTQysYYr
	h9dsdhF9ZxKK3nreYJa9z3MoTQWRb3ANkuNSX9qclJvbtKMdd9YBgObApdFzfXjcHrBLbcRrrD0
	U+0pdW+52DYwxnYtkt+hqeK4ImZjPU6hek2cxVevxvI/gPrE9TJCWQJXGIp/bDiZKT3O77iMGrF
	r7aMDhVU2YmAajzHZz+vOn8v32POTqDDkKi27g0EgpNiR8SzY5HSrGfMsLvAZjm/gZxp3qZiPzs
	kecu8AtBL2W60u2+irYc+NVDMakMGkLc3snrEQsAq322TzXqqcE/d48gVqKSuTdvI2/EC2fOz6d
	0UZ3PMQ0H197TEkUBl
X-Google-Smtp-Source: AGHT+IHdj25gGPkd5vrLu+aSOPm8RfmbsG4Yeb3c3HGUX44P3X0+iRZR23wm19u8n5yuC2IHGpCw9Q==
X-Received: by 2002:a05:600c:608d:b0:477:632a:fd67 with SMTP id 5b1f17b1804b1-47a8f8c16bfmr138675345e9.12.1765825378931;
        Mon, 15 Dec 2025 11:02:58 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47bd6000d97sm918495e9.5.2025.12.15.11.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 11:02:58 -0800 (PST)
Date: Mon, 15 Dec 2025 22:02:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Valentin Caron <valentin.caron@foss.st.com>
Subject: build breakage with SCMI
Message-ID: <aUBbXjP7B0jDVkeN@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.96 / 15.00];
	BAYES_HAM(-2.96)[99.82%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.45:from];
	FROM_EQ_ENVFROM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.128.45:from,196.207.164.177:received];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 183D545454
X-Spamd-Bar: ---
Message-ID-Hash: B7QAAD55TM5HDVB55KGAOGDMDSMC3GJC
X-Message-ID-Hash: B7QAAD55TM5HDVB55KGAOGDMDSMC3GJC
X-MailFrom: dan.carpenter@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, Valentin Caron <valentin.caron@foss.st.com>, Jerome Forissier <jerome.forissier@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/B7QAAD55TM5HDVB55KGAOGDMDSMC3GJC/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

V2hlbiBJIHRyeSBidWlsZGluZyB3aXRoIGBtYWtlIHJ1biBXSVRIX1NDTUk9eWAgdGhlbiB0aGUg
YnVpbGQgZmFpbHM6DQoNCmNvcmUvbGliL3NjbWktc2VydmVyL3NjbWlfc2VydmVyLmM6IEluIGZ1
bmN0aW9uIOKAmHNjbWlfc2VydmVyX2luaXRpYWxpemXigJk6DQpjb3JlL2xpYi9zY21pLXNlcnZl
ci9zY21pX3NlcnZlci5jOjgzOjIyOiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVu
Y3Rpb24g4oCYc2NtaV9jb25maWd1cmXigJkgWy1XaW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRp
b25dDQogICA4MyB8ICAgICAgICAgICAgICAgICByYyA9IHNjbWlfY29uZmlndXJlKGNmZyk7DQog
ICAgICB8ICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+DQoNClRoaXMgd2FzIGlu
dHJvZHVjZWQgaW4gY29tbWl0IGNlNmVhNDExMjAwOCAoInNjbWktc2VydmVyOiBjb25maWd1cmUN
ClNDUC1maXJtd2FyZSBmcm9tIERUIikuICBBIGdyZXAgZm9yIHNjbWlfY29uZmlndXJlKCkgdHVy
bnMgdXAgZW1wdHkuDQpXYXMgcGFydCBvZiB0aGUgY29tbWl0IG1pc3Npbmc/DQoNCnJlZ2FyZHMs
DQpkYW4gY2FycGVudGVyDQoNCg==
