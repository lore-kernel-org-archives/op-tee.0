Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446FACCD183
	for <op-tee@archiver.kernel.org>; Mon, 13 Oct 2025 09:39:07 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7A862431C4
	for <op-tee@archiver.kernel.org>; Mon, 13 Oct 2025 09:39:06 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=JJVvsX1T;
	dkim-atps=neutral
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2D319409F2
	for <op-tee@lists.trustedfirmware.org>; Mon, 13 Oct 2025 09:38:36 +0000 (UTC)
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-43f554ed252so2274146b6e.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 13 Oct 2025 02:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760348315; x=1760953115; darn=lists.trustedfirmware.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SCipGXhSlLg3kBAROCglKK3pkbQJ2OybkuqfhXkkxG8=;
        b=JJVvsX1T/7YCTJv31cgbCmWuDvvU5a9MbsB35nm/h7fwhQrrtf46rlMqXE/BoyRSD6
         U3trYMx+Ehmf/lCtYj8VRyDGUFEZJ1yv423BR3SCX95M114eqdrwkkoX2UFiZDxeHSVl
         Rw0a+l0xjEzRp7pAJxKdh/rxW0UHU4Gb/AUcR8WNpJM1u4KsvUQbqZDKICkE6MQHy51n
         5JN6IIaBiI5emHMt4HgDkqKBkogtELBEORmq0Tp4dBogjsCFyZ8wdGeeF134054Uo4eS
         Se8mFRTWONTb7tdRBMjszlXP757QRDk5hyf15Jy5KtCqbLMPu8hZPQkTUeKWzePGUlIV
         X+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760348315; x=1760953115;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SCipGXhSlLg3kBAROCglKK3pkbQJ2OybkuqfhXkkxG8=;
        b=gDVoy1nIhgYbw+CKPQs9f6sLhUfMnVt8b3K0BhkvR3ob0P5GsRUgpxrTsc57c/QhYh
         0M4eFkqg8WmgDxezJ5mTnXns+f7/l6yTvjFkPPJX6pB/eaOod9/wqGd3/Y4D+biQZI3I
         AZU2pp7RPB+f+nX/4eK7YLSSFABcrAukZ433MSXFJ2hb2p22WovzhjfUiLK88wQtD6/I
         Vh0gXEO/3jvCRsQXoaxJyfrqnDtTWw+/5QT7FyjYB4FaWPpXjsQX40cXfv2sNQfqimAb
         TPFc1mSIa995HeHEpIFFlpuxcMUxbBctsupumKSTrlUlr4T/Re8lenM99BeX1f0LTm4V
         R22A==
X-Gm-Message-State: AOJu0YzQbu1wROuLldh2OHmkt5Yzcn4D0xnO5Ovr5ClGOKNaknVz+/uJ
	w2D5w7EYLnKtCW9C0I8yK4vMVxQIvcpGzA/JsWrVAVWBadELduWhNE9lS4n9fFOZuMErkNgb0O7
	L/qoIqCCxsjWF/vf1Ob9kJyfWzhGS8mb0UgANTtXBn8nRA8KJQW2bw9nykK9cFvo=
X-Gm-Gg: ASbGnctNAAQO9ShhyYD+pVyxgRZM+/cTAPvx+Ex00NGmeOCehs0J6f1cWF0ZWFNXhb4
	RmyAM1EWCzWf/8loOmszjMZ7tPxvsDhXbPI/V60en71RYY0Ux0EYXUAYIUp12ZWc5xz64hBHj8+
	0cDr+Z1n1lJetZ7z6J1V1AEHJR8hIBc+F/4lcrrogbCt8SFHeBUW+KK1KOw+6+A+doYd/hD9ZRG
	1rSA8654qIHsg176EelaL7tU8DQaZrRYA5+J9Q=
X-Google-Smtp-Source: AGHT+IFX72X37LU3XV507Mh7qSj9wmMlbwqgo6B1SaBzHKzJ3BBqH7TaDEbj7LDnQqt6t+r8kFH5s+V1mUzoqMyGEUQ=
X-Received: by 2002:a05:6808:17a6:b0:441:c793:d734 with SMTP id
 5614622812f47-441c793e3c6mr2770246b6e.11.1760348314746; Mon, 13 Oct 2025
 02:38:34 -0700 (PDT)
MIME-Version: 1.0
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 13 Oct 2025 11:38:23 +0200
X-Gm-Features: AS18NWC5dS-4eDZREVWwtTZUtRSykiFXAh8EX0dRUgkkdujoEQenlzKmmFaM3Rg
Message-ID: <CAHUa44HNTP3YetCcifsKqcbpbA0XKpVkZ+a4BWucjUoY=ivZcA@mail.gmail.com>
Subject: Preparing for OP-TEE 4.8.0
To: OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 2D319409F2
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.88 / 15.00];
	BAYES_HAM(-2.88)[99.46%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCVD_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	MISSING_XM_UA(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.167.170:from];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.167.170:from]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: OO5NQOIEPGZRFVAHVXEKRQT4I2QQUQSU
X-Message-ID-Hash: OO5NQOIEPGZRFVAHVXEKRQT4I2QQUQSU
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/OO5NQOIEPGZRFVAHVXEKRQT4I2QQUQSU/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

[BCC all OP-TEE maintainers]

Hi OP-TEE maintainers & contributors,

OP-TEE version 4.8.0 is now scheduled to be released on 2025-10-24. So,
now is a good time to start testing the master branch on the various
platforms and report/fix any bugs.

The GitHub pull request for collecting Tested-by tags or any other
comments is https://github.com/OP-TEE/optee_os/pull/7567.

We will create the release candidate tag 4.8.0-rc1 this Friday,
allowing for a one-week testing period before the planned release.

You can find more information related to releases here:
https://optee.readthedocs.io/en/latest/general/releases.html

Thanks,
Jens
