Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C341CA101F
	for <op-tee@archiver.kernel.org>; Fri, 12 Sep 2025 09:10:19 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id DC8724FDF1
	for <op-tee@archiver.kernel.org>; Fri, 12 Sep 2025 09:10:18 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PEbB2+bc;
	dkim-atps=neutral
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3B2BD42EA5
	for <op-tee@lists.trustedfirmware.org>; Fri, 12 Sep 2025 09:10:04 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so255344366b.3
        for <op-tee@lists.trustedfirmware.org>; Fri, 12 Sep 2025 02:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757668203; x=1758273003; darn=lists.trustedfirmware.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gdfBB7kobN4wJK8/RorJexdvYFnM7nbQB2ZHPDHvDh8=;
        b=PEbB2+bc+71G4RxHPDxyxZad1+Klib+iHW/BXYdVWHFarGYzWhleZ0QqUtIQ8LGXmY
         BB9M/Qz18b9vPdEbec6B5s6K/wJSTQQdZZIYLjMlwdTlgduDGKDEYQIKQYUm9Vmgaaw2
         h/52x7UfwS2z4/2fuhuDrc07RoZLiCyBhXuDcS3UEcQOjuyuY3/lh9x0m/6ZuVZilqD+
         7LTipkWJQqe+BA1BDo+6uT2A4if9FJ4slPTbMk3JR2hZNFs7BGGz41D1hlzrkomrc/7Y
         6UoR2aqq1aI5VV1909altwr/F6HxlgDWTB6v5zu5M/wWWNBFvxB3HB95CWJjKJVb9KL6
         qeDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757668203; x=1758273003;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gdfBB7kobN4wJK8/RorJexdvYFnM7nbQB2ZHPDHvDh8=;
        b=OGUkBmElIxLX3KmvqUmBrM1WLLAsiHnUjSs7PPP9bKi+6fPuS9z8KdKNNK0jz3HIQu
         aIZJIevxTUOKYDrj25JR9JEOqVVXIeUwzflBbAZndjmdgfl9Slp271uq4fCVhyl/gx2d
         eufSu1zBSaibYDCQq7AKGdX6fBIXVu7nZp5fgeHFlA6NY4d5bTq8aOpiKgSr7gHVPgkB
         sV/bmcx+9N2hmgzCCYTrPIl4osIgzGN/Ho9nN3uGKwMdJpHYTlBTyigsJUTbqASpRe8W
         hPqtrTMwcrt/AQ091e9cfTOIKiIxYeY9PC1kQBuZUs9RD/9c5DkvRjXPjipmWpKqKy6k
         UByw==
X-Forwarded-Encrypted: i=1; AJvYcCWo2+C88DAV79caXSXXKuEc3Jfx9DG/0ndxW0khuAEI7O89LRLJ3JZUILQ+XoKRy8GpTAE6tao=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzqRw7gTD5AnxjhgE8Ly2JAy+aZIASDFTWke8vahVFN1J/eoDuE
	DPaovR1Z/VwcQq9k4Zh2BEENh64NQVLwZOoaig3pe5W1jJUH2kfKBAy+bg8/TXR7F3LLAQ==
X-Gm-Gg: ASbGncvYZbjv5Z5diZzmz0yr908pQElnv6RiN3su0OzCE7tUiOy9xtBjKj4Kd5uNu2U
	D+iTMBhjQ/WinMSGt2vbx94eSKSZPVUQTJGHuhxYNMmOSkI/78apxa8Rh17P1RWLCBJheAlPjOU
	eFYP2IYafKGCj73Dy0Clxqg72IKrxHFxcqi1XQueo4Y6QXm8u24q9n17AqL8AbPJJzv6wCkH5Wr
	DjszTfgAkumfcvdHxJteks+S0hSI+j33T4slwfdNiycyd2MF3yCSX+qIs6G66zEGGEqvArptzUi
	JD1snJcmSpsNdTO5QSa9DyuRZzlThciIQda8yx31d0QOw07RzBqoQyVpe6ck+FY43Bbj7eRw6IV
	6dxBoQ7zPfsD5FPLEyEmRCzMzi+v6zm9OYxydg+iEkRrHdCFOr3gc5ge5BMSwW9FKefqQHp8vGO
	M=
X-Google-Smtp-Source: AGHT+IFuuHFceMoZ2ipUeSDV0l2sTDEKnIKxUvMqoFX9PBY3aeszRH7ix8zGbjWkfgqomp+Bhqsb2A==
X-Received: by 2002:a17:907:e885:b0:b07:c909:ceb0 with SMTP id a640c23a62f3a-b07c909d374mr116578966b.32.1757668203078;
        Fri, 12 Sep 2025 02:10:03 -0700 (PDT)
Received: from rayden (h-37-123-177-177.A175.priv.bahnhof.se. [37.123.177.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07c6110c27sm125678266b.66.2025.09.12.02.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 02:10:02 -0700 (PDT)
Date: Fri, 12 Sep 2025 11:10:00 +0200
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm@kernel.org, soc@kernel.org
Subject: [GIT PULL] TEE improve sysfs for 6.18
Message-ID: <20250912091000.GA1441709@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Rspamd-Queue-Id: 3B2BD42EA5
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.218.44:from];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: J3TBLCOCONH35DMZF63O4OJO5AAJIIZS
X-Message-ID-Hash: J3TBLCOCONH35DMZF63O4OJO5AAJIIZS
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/J3TBLCOCONH35DMZF63O4OJO5AAJIIZS/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hello arm-soc maintainers,

Please pull this small patch for the TEE sysbsystem. It updates to use
sysfs_emit() instead of scnprintf() for buffers passed to userspace.

Thanks,
Jens

The following changes since commit 038d61fd642278bab63ee8ef722c50d10ab01e8f:

  Linux 6.16 (2025-07-27 14:26:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git tags/tee-improve-sysfs-for-v6.18

for you to fetch changes up to 1faa0d62a19bb8a4b9022b603472e7127974cb55:

  drivers: tee: improve sysfs interface by using sysfs_emit() (2025-08-04 11:05:23 +0200)

----------------------------------------------------------------
Use sysfs_emit() for sysfs buffers to userspace

----------------------------------------------------------------
Akhilesh Patil (1):
      drivers: tee: improve sysfs interface by using sysfs_emit()

 drivers/tee/optee/core.c | 2 +-
 drivers/tee/tee_core.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
