Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D576C54FB3
	for <op-tee@archiver.kernel.org>; Mon, 26 May 2025 09:16:09 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4970B42E82
	for <op-tee@archiver.kernel.org>; Mon, 26 May 2025 09:16:08 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HQZUuB4P;
	dkim-atps=neutral
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 359F43F5E6
	for <op-tee@lists.trustedfirmware.org>; Mon, 26 May 2025 09:15:50 +0000 (UTC)
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-72bceb93f2fso1565358a34.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 26 May 2025 02:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748250949; x=1748855749; darn=lists.trustedfirmware.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kJ5PS7Ra3wlvAxT1anyDisdL+kDrGCQjW8q8vhIT34k=;
        b=HQZUuB4PylUH+FgMFTaaKSHVzkH8O0hm1ZtIhbNL1DUn6UhTXypE2WPA1SL62oJrtM
         RG1NOTEn9pM3U27zijo155VoHyd1K17GSrjRdVLzRI2XASEu2VyTuD3+baTa4eWuAWLH
         l7pDKokRVZidm8RgaLE9Zg8vgUwvyVqRsRFq1wtQujUupdndtamIdOex+mv9jPVN6197
         jdSQLcwx5beUoyfFAFMJrmHaCQK4gsq89Zx7s2LKyJI6d/OSbUyRgW6xeuRgQ29noKkV
         Z4yFgvl+BY5Q1zjaG2LmNjQXYdl3x2AKuJ4DZF5GYQkQbY2yy89oQjhcOxBf6y+fSl4H
         JGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748250949; x=1748855749;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kJ5PS7Ra3wlvAxT1anyDisdL+kDrGCQjW8q8vhIT34k=;
        b=PsJHkOf9bVVBmW0bFKjl7rDGIYft16dhJ1M6gkjGU/kV3VsLF4YI9YM5Z2XANJF4eQ
         eB5SR1ydkD+8RnepjJPKycPCnwPTBn3ZLIk0zQvNXvzg3RhksXuX1tC2tcSit7OkU/f3
         Jm0ilYQkthZZZOWa9PSLV13yU3BCEDMT9rjNsXE9JANrNY5YyUtwmF8AXLRG5geyUcoM
         49slrFcWg8lihjjWifE0+PjgncV3b9euBPCEWk29cj/XmGfJEoWQglItmsZ33EbHF/Eb
         xaz9MDD05v9kaPlFvjstFgjG6GpbgtyWksVzMZRz60+hoSWHtheqVfzhCn5oV8dC6llm
         XFCg==
X-Gm-Message-State: AOJu0YznYLInEhdzV8u2VVy4rMGqbNUZx8QHXiAuVzBhRdrLXxuXxPfi
	1WG9bihTXCaoX3R8qownkRPPZRhf9vbVXsJIjRetjOJEpsPVIrNIXOUNTHZpvYKCsorZTztIMzM
	3fSfTVO8RZthGJveZhHBTAKphvJczIQYzqlxOBZq1iTcOlpQvNNTKtj34HQ==
X-Gm-Gg: ASbGncuG5V7TJ/N0To18Nijl/V3nmVVPW/9s0gM/BVyYQHABx+4j49COR5dSkkR46Jr
	9dTn69h88clbk2w8+YUiy3eR+QRzBXAMSj6sk2llAenpnrWuka3PPtzEs2IFI3ZglUcEA+lHRlT
	zV1EBqIJHi/8I3wGwaoSuemCHhXWcE7VYCAA==
X-Google-Smtp-Source: AGHT+IGpteYxmSQMYHIdMvo1bWT3CSD4mfnZtOR4fJty4/9fxTJDnHPFgMVLtA4cK6R2tQdCDHhTAZ1Iymc9Vmr2EdI=
X-Received: by 2002:a05:6808:1b20:b0:400:fa6b:94bf with SMTP id
 5614622812f47-4063cf607e0mr7790355b6e.4.1748250948611; Mon, 26 May 2025
 02:15:48 -0700 (PDT)
MIME-Version: 1.0
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 26 May 2025 11:15:37 +0200
X-Gm-Features: AX0GCFswDDYVl7QhVoszTpNJWbvZe-GLV3HkGEKBwe1reAKs7JnST4EZRmxZzBQ
Message-ID: <CAHUa44HpAVR+sDM-Jb6DWo_goFMRZt3VVpi7Kg=5+aYpJLssZw@mail.gmail.com>
Subject: Linaro OP-TEE Contribution, LOC, monthly meeting May 27
To: OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.09 / 15.00];
	BAYES_HAM(-2.99)[99.96%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.210.42:from];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_TWO(0.00)[2];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.42:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 359F43F5E6
Message-ID-Hash: 45SNXOQKFLO46N6ZNQIU6SSDPNH2VWOF
X-Message-ID-Hash: 45SNXOQKFLO46N6ZNQIU6SSDPNH2VWOF
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linaro-open-discussions@op-lists.linaro.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/45SNXOQKFLO46N6ZNQIU6SSDPNH2VWOF/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

Tomorrow, Tuesday, it's time for another LOC monthly meeting. For time
and connection details, see the calendar at
https://www.trustedfirmware.org/meetings/

OP-TEE version 4.6.0 was released on April 25.

Amir posted a v4 [1] of the QTEE driver. Sumit and I have spent quite
a bit of time reviewing this, but it would be welcome with comments
from others, too. For instance, for "tee: add
TEE_IOCTL_PARAM_ATTR_TYPE_UBUF" which adds yet another type of memory
reference.

optee_ftpm Issue "Warning in _plat__GetUnique()" [2], digging in this
reveals further issues.

[1] https://lore.kernel.org/lkml/20250428-qcom-tee-using-tee-ss-without-mem-obj-v4-0-6a143640a6cb@oss.qualcomm.com/
[2] https://github.com/OP-TEE/optee_ftpm/issues/15

Are there any other topics?

Thanks,
Jens
