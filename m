Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF0CCCA471
	for <op-tee@archiver.kernel.org>; Fri,  3 Oct 2025 12:33:11 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 72EEB41BA4
	for <op-tee@archiver.kernel.org>; Fri,  3 Oct 2025 12:33:10 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=TEeQthjS;
	dkim-atps=neutral
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4116441835
	for <op-tee@lists.trustedfirmware.org>; Fri,  3 Oct 2025 12:32:53 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6228de280a4so4439745a12.2
        for <op-tee@lists.trustedfirmware.org>; Fri, 03 Oct 2025 05:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759494772; x=1760099572; darn=lists.trustedfirmware.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=17gCoEjvIQcUQufFQtAKqNf5Qc0ovnSmzCsZHusGb9k=;
        b=TEeQthjSfTlC+NoqmEPj1muX3L0cNm+P3TZRvOv1lGwRlQbkk3AqPxBmC/Oib0cRqE
         ol8gZks5E3EDGCwwiDANo58Lic4EqnU5wZqIVje9pP7wx0qIAWEKxLBDFy+hLCcaBpVk
         JHBhdwH+geGZnAnw+VKxiVBqSOvWvFNnPqtdmGdD7VhJnV/uDEWl99AjBmbg9qK65Zug
         DBS8vfxzsCoFghABPfeqD55ZkKdqK/hJEik0oBOFmDKNuDo1nUwhFIZuxivgAbIxO13a
         hVxSEYKr09nHW86MtFhbJmOrjal3AouTyh2G8fVynsyGLDC/unvVB4KLYdF1ZpQ7Ke6q
         94Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759494772; x=1760099572;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=17gCoEjvIQcUQufFQtAKqNf5Qc0ovnSmzCsZHusGb9k=;
        b=J6VBg3HRTPn6CjW0S+bwLs7axfdYny1VNpAaigLtx9aiifZ3zk5T4JonlJYfzZchqR
         HV91kndbMSJ9jYbUlHGOWbUN3IyIuXs9Ob0OwBYYkbTnzW8dBthyKgd18t4QFUZG5IV0
         e6I0GMTqHf2ls5G4QOATdsulSry0YivE/sc1hXj1jEQkBsBGDt5vjUAiJYxoNZRal32K
         mMuxNbpHaHtJEShw7Hf0qaP70P/2Mj0tVBK3UVUGjUF733zCt0vfzOSKueHUj4pmnSMv
         8/9/BJcskgC3O9W8I0okUAJIm5fEHL+8/7oNlYNO10rDqA7rItnbPzd6jtYdWhb3V+n/
         oczQ==
X-Forwarded-Encrypted: i=1; AJvYcCVse/2VT3EdJENdfsa8v96KjOocD2wmwez8Q5lJsjmAQR6JhG2Oxme4inyT+OsCAgjjREN3jcc=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwmeLZ9Iz7GaGGAok7XlTwiK28Vc7Zi/q3BrueWvlBZwi7foifo
	e4L6xPs/EyQ51f9mdQ80i0N2tus3Ap6BLCI6pxB/RH96EDOyAzDngtnWv0kPA8sbDZrbG6CmZM0
	3tm1/U5g=
X-Gm-Gg: ASbGncuc1SgrKXVDmUINb64V76nrn7vRXYjCA5EkHjeDRaiU/HMjn/eNg+IkNq2oFbY
	gLdZoiO1VOzXYvCoI88+V5e9HPh1FREU1f4/ff1aqrZ0miYhG979SqkT7t8KUuFrAnrwB6iqC0/
	hzZYLo/sJX7UkRSiOZf22q27JA+W823+DgDnbg3vdEMBjF8suZKLhbk15eaIJ7WuHrjBNmksbaJ
	2aE5wFJAlmPTGJuXaEVMegfZLoLLbfOinBC8LOxNBZz1718Zyjhx9khdfX6ivJF4FGSs7H+RE1b
	u9H6puE7rwxYzzvMewYad+LSNmkuZz8aZDHwoOPUpMdLUadgFzTQ3HJiD0g1uD1gtLNuybV0JaX
	QnFML/6PC2UjyL5+5bdcq++u1M59p/NkCSdJt7xu9dM0TSaIBqipbGLBsItNVoLWBn/rjOhA9v7
	8IG48UMGCLo03NH9zg8YpM6Vq6LCo=
X-Google-Smtp-Source: AGHT+IEoFFTeRxLCKlCPFN/zmcwyyLcUjEt0wTRNto+jUB9IZ+gep75jgaZbEeIo6QfYakU8Sdy8iw==
X-Received: by 2002:a17:907:961e:b0:b48:730:dbaf with SMTP id a640c23a62f3a-b49c25514acmr373047366b.25.1759494772108;
        Fri, 03 Oct 2025 05:32:52 -0700 (PDT)
Received: from rayden (h-37-123-177-177.A175.priv.bahnhof.se. [37.123.177.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652aa62csm427437866b.19.2025.10.03.05.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 05:32:51 -0700 (PDT)
Date: Fri, 3 Oct 2025 14:32:49 +0200
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm@kernel.org, soc@kernel.org
Subject: [GIT PULL] TEE QTEE fixes for v6.18
Message-ID: <20251003123249.GA1063437@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Rspamd-Queue-Id: 4116441835
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.208.52:from];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: XRGG7VBHMN2ZP7O2IMVZQIHHDBGD5A5A
X-Message-ID-Hash: XRGG7VBHMN2ZP7O2IMVZQIHHDBGD5A5A
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/XRGG7VBHMN2ZP7O2IMVZQIHHDBGD5A5A/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hello arm-soc maintainers,

Please pull these small fixes for the TEE QTEE driver introduced in v6.18
merge window.

Thanks,
Jens

The following changes since commit dcc7a571a3665a16581b5b18ca6b113f60a9a41a:

  Documentation: tee: Add Qualcomm TEE driver (2025-09-15 17:34:06 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git tags/tee-qcomtee-fixes-for-v6.18

for you to fetch changes up to 3b63efa21bc6acc1a0fadd1dd0f0e1988a4c0177:

  tee: QCOMTEE should depend on ARCH_QCOM (2025-10-02 08:31:10 +0200)

----------------------------------------------------------------
TEE QTEE fixes for v6.18

- Adds ARCH_QCOM dependency for the QTEE driver
- Fixing return values for copy_from_user() failures
- Guarding against potential off by one read

----------------------------------------------------------------
Dan Carpenter (2):
      tee: qcom: prevent potential off by one read
      tee: qcom: return -EFAULT instead of -EINVAL if copy_from_user() fails

Geert Uytterhoeven (1):
      tee: QCOMTEE should depend on ARCH_QCOM

 drivers/tee/qcomtee/Kconfig | 1 +
 drivers/tee/qcomtee/call.c  | 2 +-
 drivers/tee/qcomtee/core.c  | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)
