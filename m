Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0BBAEFCBD4
	for <op-tee@archiver.kernel.org>; Mon, 16 Mar 2026 07:12:33 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1482141882
	for <op-tee@archiver.kernel.org>; Mon, 16 Mar 2026 07:12:33 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ahT3Q/tt;
	dkim-atps=neutral
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C37F341882
	for <op-tee@lists.trustedfirmware.org>; Mon, 16 Mar 2026 07:12:13 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a0ff30b240so5076372e87.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 16 Mar 2026 00:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773645132; x=1774249932; darn=lists.trustedfirmware.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eq6ELLjGNJ8R4s2BpmTpbSt0Wq3B9jPYaS+2zlsM9NA=;
        b=ahT3Q/tteG3fH5g80iFaNqSjPRxckh3sTmipsGEtc0v56Q/ENCpMQevreS9MXqQcTg
         7Q0QvYKudEH2qSRTG0CvDKRxC7ZxlblU+iUOJXdNqOHUf5dvY3/pMXi8mmYYNII6YTkN
         rXBG9sM50D8i6N3WRomcCoKRZNZsXHTmAGydDHiXF5hBWGBGRSQT/sV4tFmTfgDroBRs
         cUmLoHrrF7fZQN5ntKIwbT6AetLaoUqjdb6CX7XZKNekrh7HoVf82dUPiUXQBT7WJNHs
         SkSHrpO9Putrvd1ex77nwrNxhiuirQl5YP7BiWLm1Z+ZPomiJkNyKJJ0j9gJz8do/SK7
         UcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773645132; x=1774249932;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eq6ELLjGNJ8R4s2BpmTpbSt0Wq3B9jPYaS+2zlsM9NA=;
        b=agVhghbAjAxdhWmLVrvUU7DpBnEloI0jFsWs7kolnavOqPBnMoQml1+EpTK0JWV4od
         OoZK2s2k0x5YGnv8RYZQ9kK4sS18YNrP8ibdYal5O9/g2SZPhsLcofo4AYG7uP6lS5WS
         oYPZFne/tdYpBjOfrgD/HSuJvISkCUWb6l9qfHhpjYtZ3Xkvr0yhwpTL4JXVz0buS5vc
         6Wle+nYOMlAmflRRV1RD85GL1BI34RBdFCV+nwShzPJ/w6+MiPVyvYMRcGb50R9JbN1U
         EvHJp2idDRRa/RCMvDBEfzoPMiJpDP1ILhGkR+6TnLYpCOADZjwLWVM/h7xaFPzYIMQ6
         NIXg==
X-Forwarded-Encrypted: i=1; AJvYcCWqqMnNGUoseyK2y/za6VCoaGdALh8niSQkZzowF8xuswA8NXBfj6s8ojY5iGCYsWDj+AZbG3I=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yza2qHWt9rFbk9GN+zE6V9eVt3eCECXfmtq7wawN0kGDlsMEZKG
	m+hgLHJnfi7y67WPfLqmDhecTcmN3GV88WPS6xU0ddVuMXg4MdKa+xnhbYtPurVGaq7t+Q==
X-Gm-Gg: ATEYQzyH3Vm0FW4Ujqv/YLhHol7zAGlYrIkHB22rRMLqHvvethhhEYGAYOgrSamJ7+g
	OYglnVMIt+eSH//jGgp9k4TftBzCRxWeQ702uS1E/r9EOVyrStMXI1HnRpxRkE651tLbrEUKMcc
	GJm0Hg0FFv/LMaRI0/ENNyuksFqU/GodiUf0kGxd+j16qr/z/nA0O1rj759wOlIBH9rwtcCjare
	BoJE5WoT1GINUpUd8GxE3i3OFHgFTx/NYQjvD2sAUGOrPR+JPc7VtlLu0Blh775yP+km5vJ5ZzX
	ph2tTmGYIZgf80dx/Otps1MevziZQFr4jnSl0hSe8lYu2WFmS/dkHlvrzVVxZKyLBqOgfj6trvK
	3lacnvVRtfzC+pHenUSBVE/xp8XckYlBx+atc/egbhMjzr0I90PTvuvnqm5p3LLA/Pfhfu7nFr0
	izKB31NtJt0FFojrIgR4y/Um3ER/V5rY2BMVBB60akEmEI5vJQ0RDtwrWTS6aKfN76kUNduUMF2
	gl8J4a/fzM+5R0Tr/A=
X-Received: by 2002:a05:6512:2244:b0:5a1:8b9:6d12 with SMTP id 2adb3069b0e04-5a162afb89emr4516634e87.24.1773645132499;
        Mon, 16 Mar 2026 00:12:12 -0700 (PDT)
Received: from rayden (h-79-136-84-34.A175.priv.bahnhof.se. [79.136.84.34])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a15981e963sm2810529e87.64.2026.03.16.00.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 00:12:11 -0700 (PDT)
Date: Mon, 16 Mar 2026 08:12:10 +0100
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm@kernel.org, soc@kernel.org
Subject: [GIT PULL] OP-TEE fix for 7.0
Message-ID: <20260316071210.GA2470832@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MISSING_XM_UA(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.167.45:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[79.136.84.34:received,209.85.167.45:from];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C37F341882
X-Spamd-Bar: ---
Message-ID-Hash: RMJNDBMBYGET3XQWRRPLBTPIVFWJHQOO
X-Message-ID-Hash: RMJNDBMBYGET3XQWRRPLBTPIVFWJHQOO
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/RMJNDBMBYGET3XQWRRPLBTPIVFWJHQOO/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hello arm-soc maintainers,

Please pull this patch fixing a use-after-free race in the OP-TEE driver
where a client exiting prematurely could free a request still being
processed by the supplicant.

Thanks,
Jens

The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  gitolite.kernel.org:pub/scm/linux/kernel/git/jenswi/linux-tee tags/optee-fix-for-v7.0

for you to fetch changes up to 387a926ee166814611acecb960207fe2f3c4fd3e:

  tee: optee: prevent use-after-free when the client exits before the supplicant (2026-03-02 14:36:50 +0100)

----------------------------------------------------------------
OP-TEE fix for v7.0

Fix a use-after-free race between client and supplicant by serializing
request access with the supplicant mutex.

----------------------------------------------------------------
Amirreza Zarrabi (1):
      tee: optee: prevent use-after-free when the client exits before the supplicant

 drivers/tee/optee/supp.c | 107 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 74 insertions(+), 33 deletions(-)
