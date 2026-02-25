Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2776EEFD202
	for <op-tee@archiver.kernel.org>; Wed, 25 Feb 2026 07:54:34 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 65991438C6
	for <op-tee@archiver.kernel.org>; Wed, 25 Feb 2026 07:54:33 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LnCbRcdN;
	dkim-atps=neutral
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A575D436F4
	for <op-tee@lists.trustedfirmware.org>; Wed, 25 Feb 2026 07:53:54 +0000 (UTC)
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5664393d409so2611995e0c.0
        for <op-tee@lists.trustedfirmware.org>; Tue, 24 Feb 2026 23:53:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772006034; cv=none;
        d=google.com; s=arc-20240605;
        b=KhgS4TwFZ6vYo8eI35in6xIuz0iI4XbjTCz2CZx8Exeugd8IB43ITlBmHiM0ruKu7j
         gw/LI+tLff1F7owS19vWDqlc/WU+nUCOxqjK1NDUmHsGPLcJyB4ZOwh6+CPmgtEQdrPB
         9ioxAl7CHnwWm/rORy5+pWwbFZIvaAVIh2ZPs4AmwpL4vONAcKU8hOko7ZwE+oJi8rto
         C4mW12qV/NqXc2sQ42z+MWDNgPD878Fxyy4Q4K1gz3kDTBjXZRim05fD4EiAB30+CrDL
         Kzg5/Pq7dGAqpVh25IoexcPWoC0g3IEucZkd/x+fSwVYj9V0hFeifk+566ey/MiyAa1/
         ZS8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=uz37p9nFoQsMERfIgIwJEg9Gh2ioyTWcSS/v79gSP6Y=;
        fh=DBvxCipNH2RlJe8Lt8jDz73G7et6cRT4xOp4aNQo0jg=;
        b=GOPEhF3r+K7gBNO58gfwsb4B9qwB9tyLz+SP297SEfZPx9l3zjpA+k53tWLQAKJ57z
         JBo+j4I+p6mLvQUzY0cTGjstflHyK7oOKd5Q6iVlwNRi7xa/sdzhqKwEXH/lQMAI7FV+
         gVMo2yzzzCcI9vhvL5D+7vsHGOOsZ57WSCiLuo+XkT47yus4p/ZTX1T9ZtOvq/vNyzof
         8N1v39ubNz0wiK7RRV8oMOWQIg/tl2Keo3nTmm1dAEoUF2XEpVd6oweFQ13i8vWMU0Sg
         Va3Oh0GGPX+ZOUYvo7sGeKgCaVdlQcDGXqDQY2HpGTb6NVXlUYoTMKbLta/0xpTNH6dR
         23yg==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772006034; x=1772610834; darn=lists.trustedfirmware.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uz37p9nFoQsMERfIgIwJEg9Gh2ioyTWcSS/v79gSP6Y=;
        b=LnCbRcdNqTMIgdiSNG8oFp5cuX4krqotRqvwt0HIROKMgbMNSVyjs78p7SL9FHkTmt
         80mCmQoirs6ikDzDaKkRYHEC1nHW3AAJM8dBA/hbniqhkvsp2hKWLlXHlqIxqKCVPTQY
         knKqPmgHMYnDvUq0QyuUVYK2LGm1WhM8lvwLDmw3WPBs5GRDqNJGhyYIQREVXyNE9Qxj
         JkDAc5Ev1eEqKJVuWnY1LTn4qreiKQ/33yeK4lZZr2/+7t5vrErDTn1ZMa2fQ5t5bn0T
         5pmyPHta8emktdN+odQtCL62EYJwvGDeppqr8/vf/s7bO1ei4qfijWg03u8cXrYU/QNo
         qO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772006034; x=1772610834;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uz37p9nFoQsMERfIgIwJEg9Gh2ioyTWcSS/v79gSP6Y=;
        b=Pmzqc5lxGpdFJhpxkIGyrb0acz8s4Xe4zgsjNnUuTIKl0s+/9RBKE5GaOd1N0OIDNk
         vm3D2XOlrdWbT2YfMCNQ6EG4nGgaGq5vWOXzLTydh04Bf5Ul5yW5BX0MM2Rfl+x6B+AT
         Tv4OOegcsIuPojGhSa/MzPygV00mmhoiaQ71fOkVwtrq1IGF4KjyzjE6TPXgbWXIgrVx
         LftgsVhntpUYkqu0gDzvsyBP2NHxuEuf2/XWn6Yuc0vRcHGfaq5Z9NTrXo73s6BAFvAT
         m2l7e01jaDEn3nW3uZKS4IpkO/qnsRul9liVVffXf87Nm14u8yFBzFfhbZjiNsPIMsLD
         uetw==
X-Gm-Message-State: AOJu0YxVbT2gf9RYsSb/o2gk9en+xLetpeD/MvjozYR6zYkk4vt6+T7l
	6/mW44SQtEyaNEVPlstTO8+jucBUp9uD0byzQHCgwx/PolnHLkVUCUClkP+VX/c4qEx2CmRCqM9
	ndoMqDlKtGh2Ao1YK5hvaBpQEFUH8MAXMww==
X-Gm-Gg: ATEYQzwmR3qHBkHe9DsyD3Iv5ObqsBzVqcq1xThG5YVPoHLr6WcFIywN3sVQdrEg0Vi
	YBUrLiJ/RZpZjEhHKnDa6oo4cVK7RDu3ytVnfw7JNEMlpnOOEAPtHne8x6Dvr2A/HOgrGAO1qGr
	UUnMrwPyncMSm0mLBkGKH3zdC88qxuyaxJ9D5slMloPXvd/oGUAUSgygz5gfRRfmkIZMbPFszFO
	xaSQS+TczPLKKzFYJyBtkwxw1iQ+/X61Fq6S9fiqconi0um/sX7CfZuZY37ykaw7WyB9NeUuDG5
	brXIBCueTBmA8Z8dRorpDNRDpRq5AZk4w/JBA82/
X-Received: by 2002:a05:6102:2929:b0:5fe:af0c:79ff with SMTP id
 ada2fe7eead31-5feb3027765mr5538990137.19.1772006033905; Tue, 24 Feb 2026
 23:53:53 -0800 (PST)
MIME-Version: 1.0
From: Yuanjia Yeh <yeh.ooxx@gmail.com>
Date: Wed, 25 Feb 2026 15:53:43 +0800
X-Gm-Features: AaiRm50AqV4tLZGjykCmQ17B6B_zlA1bWnsXekbxOF5xajPec1Tv3b6u2iRh6TE
Message-ID: <CABcfEOfmr+xL_uOmmXfQkvZiME0-Mk3-KK1xSS5kCW-ervTTHQ@mail.gmail.com>
Subject: Re: [PATCH v5] tee: optee: prevent use-after-free when the client
 exits before the supplicant
To: op-tee@lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.02 / 15.00];
	BAYES_HAM(-2.02)[95.16%];
	FAKE_REPLY(1.00)[];
	ARC_ALLOW(-1.00)[google.com:s=arc-20240605:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCPT_COUNT_ONE(0.00)[1];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.221.169:from];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.221.169:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A575D436F4
X-Spamd-Bar: ---
Message-ID-Hash: 3BYTYYS72ODE3Q3IN4AMTPMIF5SFFIKI
X-Message-ID-Hash: 3BYTYYS72ODE3Q3IN4AMTPMIF5SFFIKI
X-MailFrom: yeh.ooxx@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.5
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/3BYTYYS72ODE3Q3IN4AMTPMIF5SFFIKI/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

SGkgYWxsLA0KDQpXZSBjYW4gcmVwcm9kdWNlIHRoZSByZXBvcnRlZCB1c2UtYWZ0ZXItZnJlZSBp
c3N1ZSBvbiBvdXIgcGxhdGZvcm0gdmlhIGFuDQpvdmVybmlnaHQgcmVib290IHRlc3QNCg0KVGhl
IHZlcmlmaWNhdGlvbnMgYXJlIGxpc3RlZCBhcyB0aGUgZm9sbG93aW5nDQoNCi0gV2l0aCB2MiAr
IE1pY2hhZWwgV3UncyBwYXRjaDogSXNzdWUgcmVzb2x2ZWQuDQotIFdpdGggdjQ6IFJhY2UgY29u
ZGl0aW9uIG9ic2VydmF0aW9uIGFuZCBhbHJlYWR5IHJlcG9ydCB0byBBbWlyDQotIFdpdGggdjU6
IFJhY2UgZml4ZWQuIFN0YWJsZSBpbiBvdXIgdGVzdHMsIGluY2x1ZGluZzoNCiAgICAgIHh0ZXN0
ICsgcmVib290IGxvb3AgKDMwMCBjeWNsZXMpDQogICAgICBjb250aW51b3VzIHJlYm9vdCB0ZXN0
ICgxMDAwIGN5Y2xlcykNCg0KICBObyByZWdyZXNzaW9ucyBvYnNlcnZlZCB3aXRoIHY1Lg0KDQpJ
ZiB0aGVyZSBhcmUgbm8gb3RoZXIgY29uY2VybnMsIHdlIHJlY29tbWVuZCBhZG9wdGluZyB2NS4N
Cg0KSWYgbmVlZGVkLCBwbGVhc2UgYWRkIHRoZSBmb2xsb3dpbmcgdGFnOg0KVGVzdGVkLWJ5OiBP
eCBZZWggPG94LnllaEBtZWRpYXRlay5jb20+DQoNCll1YW5qaWEgWWVoDQo=
