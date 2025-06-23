Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46AB3C7115D
	for <op-tee@archiver.kernel.org>; Mon, 23 Jun 2025 08:21:06 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8D0284092C
	for <op-tee@archiver.kernel.org>; Mon, 23 Jun 2025 08:21:05 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Nd9UB0Gd;
	dkim-atps=neutral
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B17C54092C
	for <op-tee@lists.trustedfirmware.org>; Mon, 23 Jun 2025 08:20:45 +0000 (UTC)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2e9071e3706so2374845fac.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 23 Jun 2025 01:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750666844; x=1751271644; darn=lists.trustedfirmware.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LuUWDtFsio1MmPc+v3RWUYuKlCT3pN1LifeDAXzNGgM=;
        b=Nd9UB0Gd0+vVKLG3Vmgh56RSQC7U51m9EG2sVNRS99o/9ZRpN/PwkZ4cuctw1ldTLU
         khY7VpG3bayO3YIDFZqPVGdSJBzRZo4q+1+xkgtMkd6TZlrNjcHPztdj+q4ZRGKqVLZQ
         WjHbExebLxOKoc1SvGCjbBgcsYkOFvlu4z/GmN2YqPRmdmpTNXf6IYilIKrgiAZ7Xw2W
         9sEKCPRGmhm1gz9agtp1o4wwGbOyEIE24B0xqf5OcZhEmYoZQW9cSAcysbRf/VhQcyNF
         43NGLiIv6sE0Tm4RDDhXdzh3PbVm9CdhYNYJqMFuwUxUn0WJ0sleYV4048q71rMZu8zR
         /uag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750666844; x=1751271644;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LuUWDtFsio1MmPc+v3RWUYuKlCT3pN1LifeDAXzNGgM=;
        b=nXGbSEuVGGPwn7Aram6ZAp/e+IkQXR+LhCvXztJ3IuidmiPq8HRhJakEq+o7+3wxSc
         fsoYi3rVqWslKltC9PDIwxIQfIIsEH2Ev2Iko26/TKT3ByJRtz24d0uff1nrmc5Vfy4X
         P4jSygnLg6zFpcQWP7OSNmiYDUt2yOG2TQ7oombCXN2fLJwjpixuNpRjwuPB21UmBnLE
         Bf+qX6Z5QxKvTAfkYOyG0EU4bQit51Z2xbt/T2B4ig+3OAF0K+CfTfWnFUjPN2PLcXHC
         ae7pqnH64B5Kkm8/16aBFUerZUwc4Brcq107KhXLKXHR1b0lNIHn9tHMDPJLyFLUomsn
         Ee/w==
X-Gm-Message-State: AOJu0Yy8ldHxsZsme+ZSQGFeNYnmPOK8sAbvEfay93P9wg2etbwXIcrQ
	cRuKeudzHcA+iRtV8+QXDskC25lsJgdCKUSZoHVR0Xx2PshmlAnfqlH4LEEvByo266am8h+jUY7
	/BNxx2SQOdEhtV3XMnWgJSYc92Z5zglvxbFTQ7PTRFfOowJgs6p/P+c3nqw==
X-Gm-Gg: ASbGnctB7gmjkoaWkD6hTfUjqBLSF4dHGZrWZ1cDGL1rH8w+Bi2HSTm07gvvR2cfxKy
	oAdesPH0JZattiw0VFl6zUvNvTl4cvdmx84vhsPR2Sqzg7MlFaD8//J6U8xNcMp8NB7WWyqmm8o
	Qk0gWUf2Y4T+D7o7MbbXazBxrZVupctm5de47PFPd9halk
X-Google-Smtp-Source: AGHT+IHCemzV67rAE3ncdFnC2PUR4ypU6KjqOTCaq4bwi7GdScEtJygWkxNJwaXVXWH/iHJgoE20ur5EMXQPGEabUNI=
X-Received: by 2002:a05:6870:4f0d:b0:2c2:3ae9:5b9c with SMTP id
 586e51a60fabf-2eeda51ca82mr8626939fac.2.1750666844259; Mon, 23 Jun 2025
 01:20:44 -0700 (PDT)
MIME-Version: 1.0
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 23 Jun 2025 10:20:32 +0200
X-Gm-Features: AX0GCFtO6df7OjWwNW6jkxPeVkiwk2s6GHSgmdBZUDuK0DqWKmf52sMNHlnj4b4
Message-ID: <CAHUa44FrowZy9yD2UHqf4Ywd1TaNm71KTqzGMt-n9XSs1i=o9Q@mail.gmail.com>
Subject: Linaro OP-TEE Contribution, LOC, monthly meeting June 24
To: OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B17C54092C
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.44:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.160.44:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[linaro.org:+]
Message-ID-Hash: SEV2ZX3XZLNVAW5DIYE44C3BJQ6HDIPS
X-Message-ID-Hash: SEV2ZX3XZLNVAW5DIYE44C3BJQ6HDIPS
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linaro-open-discussions@op-lists.linaro.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/SEV2ZX3XZLNVAW5DIYE44C3BJQ6HDIPS/>
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

- Jerome just announced that OP-TEE version 4.7.0 is scheduled for July 11.
- Dynamic memory configuration in OP-TEE is nearing an end with
https://github.com/OP-TEE/optee_os/pull/7426. I have a few more
patches in store, but almost all the big and difficult things are
done.
- The Secure Data Path patchset [1] is at v10

Are there any other topics?

[1] https://lore.kernel.org/op-tee/20250610131600.2972232-1-jens.wiklander@linaro.org/

Thanks,
Jens
