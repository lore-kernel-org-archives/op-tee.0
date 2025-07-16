Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8809EC83F1B
	for <op-tee@archiver.kernel.org>; Wed, 16 Jul 2025 15:41:59 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id CE23E3F6A5
	for <op-tee@archiver.kernel.org>; Wed, 16 Jul 2025 15:41:58 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=lRjkzWVZ;
	dkim-atps=neutral
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6DF6A3F6A5
	for <op-tee@lists.trustedfirmware.org>; Wed, 16 Jul 2025 15:41:34 +0000 (UTC)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-41bc2668f46so22234b6e.3
        for <op-tee@lists.trustedfirmware.org>; Wed, 16 Jul 2025 08:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752680492; x=1753285292; darn=lists.trustedfirmware.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ByCIlO8/mIlVWjIDNREWcSxI/s+KedTZxSIl1G07ROk=;
        b=lRjkzWVZZDepy2u7KbNvAJFk7llvjB0s2FCe9oHPbNHB7i1373GtQFfouhEqMkCkyx
         IuEuFn3DiOmF8v5+CS7OVl8IBA4qmq+AoJ/tat9KvsSbvv9aRscPM05BcRir1oZDMPTF
         oyn9x9BdlywSc8HUQDiWe4yVpgwYgI7S02k7G7cIcPPoObFMI4hDJ0VyR4/+jMDuvGfw
         s3uLJDq/JExEXpgPBY5wJbiFmeiVofRsr0mTbuRag5c9rp27xMVD4eB2MX+m8BDMJq4y
         0bgImC4BIWgaONvPToCd2Pvy9YhJXOqpdFsVODZ/gYBC8Nt8JU0KgmgzpHV0UXUavPHu
         gZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752680492; x=1753285292;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ByCIlO8/mIlVWjIDNREWcSxI/s+KedTZxSIl1G07ROk=;
        b=RXh+lcOQqZ/fkegA7MAzRjhusPFphu76mpy+7siTk+Y6BK3qrZoXjw9/SMdnRX77BW
         ip3gPJdSS2zLYOiwl3vJO4w6FmfDkU3xJchUGG4IHdTBqc48nViKt4nrZwGq/hgekZSc
         pgbpnFtoKjDNtAQCXN94o64ExpM8LB6uPQJtvNs6WYA4lGygfi8dc8IqpZjCo7NvuVds
         MbO65s2bLEoMTOI3rRwe9z3+CJwL/NPAD6o5JaMs2CndAWkly/uu9os+w02B/tj57txD
         GvH2L8bDVjtbxdy/RTNLaJMOVKCdQg1ZZu54174mjGLi0MlGdUIwI6nPXfToZNcz44tF
         kVOw==
X-Gm-Message-State: AOJu0YzBKks5wA4yWM3TV5v1VHYpRvNJYn9Z716K9GaFAIctBYx/ApHP
	ZTRMyoE8giIXIR8zh1z5diZVXyUG26g7oZKVLDqpX7YzntSl4eu1yye9oVXnJ5TH0CvXP+ByWL5
	iVkpV6to5443XLo8L8Y240o/YKKQb5EKcdLOLAAxIJObZujF9CwwwDT7UcI4i
X-Gm-Gg: ASbGncuM7gBx3PNjH4bZO7JZYNBmfSjZfEeVFyZXT/48Teh6poErVsCgUoOnSAVR2FO
	jiMM99g/GreQUa/coxOtUGB0g3bkJqi1JFGFXA/csEpJYFj64zelmn0tlGvxVbdAa5GOsbXSn1E
	g2+agD9/bxVvSc1kwUBePU8pVh8j8AL2TbVVvfKXrvHMVUrqIY+G+QV1YEz7JM9mjqeFF/u6AS0
	FBJ6jhi
X-Google-Smtp-Source: AGHT+IHyYWlIreVFF5+8hha7ZWcjyyUUjVnE4gAPaGbnmLdnjDn94t0IacfLoDGS3ARoL6kiD5gdgiAItg09/IusO2Q=
X-Received: by 2002:a05:6808:3505:b0:40a:52e5:37d5 with SMTP id
 5614622812f47-41ced9971d5mr2712687b6e.2.1752680491903; Wed, 16 Jul 2025
 08:41:31 -0700 (PDT)
MIME-Version: 1.0
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 16 Jul 2025 17:41:19 +0200
X-Gm-Features: Ac12FXyvu_KYhm8XCzV7MzzV4nPmirrBE9OGLs1Ug5y8-3PlQ1Lt-o8jAMP2rJk
Message-ID: <CAHUa44HJVHeXFSxQpmK7joC6Nzm0Nd2+6A2SrpSES7Rh5j74iA@mail.gmail.com>
Subject: Canceled Linaro OP-TEE Contribution, LOC, monthly meeting June 22
To: OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 6DF6A3F6A5
X-Spamd-Bar: -
X-Spamd-Result: default: False [-1.80 / 15.00];
	BAYES_HAM(-0.80)[84.78%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RBL_SENDERSCORE_REPUT_BLOCKED(0.00)[209.85.167.180:from];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.167.180:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.167.180:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
Message-ID-Hash: GUPADPW5JD22H32BMWVVHE4XCTEFPHN6
X-Message-ID-Hash: GUPADPW5JD22H32BMWVVHE4XCTEFPHN6
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linaro-open-discussions@op-lists.linaro.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/GUPADPW5JD22H32BMWVVHE4XCTEFPHN6/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

The LOC meeting in June is cancelled due to summer vacations.

See you in August.

Thanks,
Jens
