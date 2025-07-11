Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D75C83F1A
	for <op-tee@archiver.kernel.org>; Fri, 11 Jul 2025 09:47:52 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id EE609430F5
	for <op-tee@archiver.kernel.org>; Fri, 11 Jul 2025 09:47:51 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=JnP9IxnA;
	dkim-atps=neutral
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0F92F3F6AC
	for <op-tee@lists.trustedfirmware.org>; Fri, 11 Jul 2025 09:47:38 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae3cd8fdd77so387848666b.1
        for <op-tee@lists.trustedfirmware.org>; Fri, 11 Jul 2025 02:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752227257; x=1752832057; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5WlF5JjolXJJUK6BunranJX6ggIBGwq3hpxmHlW6OI=;
        b=JnP9IxnA6wgCj5SRRyA/jQ9dtWia9RO+ZDhJjlUHPkJv0nD8RNXQQhK2XecoZ9Rh7A
         sJRrKI7mfAjD1tr/+VytemGfDQ96wF45yinDmSlabZBtZWmeslxwKiMZtkCBm2WJYZ7F
         4lUht58DDxffaLb8IO2sz9/6MSj1nUNhIZB5F0356z59QQSWs8iHezvB6Tjrc/RgGVzW
         jcuqKE+bYxQu/L7ex7ZvFTsPR/RGHQk1eceShVuKh0yvoZvwWTjmDhgbEDd9xb7/1PkX
         l5+19Bsbgew0ESNTaN4qkoIJHjg5rE91lYgInfctnCBIPJNb4IMdK+UOoBsAdYaK0OCR
         ogZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752227257; x=1752832057;
        h=content-transfer-encoding:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b5WlF5JjolXJJUK6BunranJX6ggIBGwq3hpxmHlW6OI=;
        b=Mm105u5DPe0vYTRg5dUonFKzF9Qy65gscZ4zBLxwlK5WmhP6frytszxyi+1+zb432C
         W9j4CayrGlrnU6tly8T2EktJlI0xN4n5KyhI9C5wLwNRpBRBg9avX5s/7mS6n5O5Iok8
         d11bPjWBOI/Zj/fzrztJgsoLFGMS94Q6JewFW19pxVZu+/k5iprgbsFpzz+vVeWREU1z
         KAZgA4Ayl9FB5npix0VNr/KNnoEi87lXR1NLDflTBTdlKWvJHnId2oT5pMSg61F6vph8
         YuFg/dgYM7a2anQyYlIn/4QbuXPXP7BYzIFJ6wI1/oaP2U1jAis7FWaOvM2ByqhO9Iw1
         ykrQ==
X-Gm-Message-State: AOJu0YxfuH9lGP9UYoBngbafMvU3V9RKPedKKg5rueTBQ0MdMXV+RMeb
	pMJ9ajfQiYZJa7gQPlpxf84AT8yRZOLUD1TIcyEky8NvkOolmf/aVX9FY4EC9xIsQv3kB7wDsei
	UOzkXNNT9w+HUOmw=
X-Gm-Gg: ASbGnct3PBFIcbM7d5c7xRwUHvP8WpLRCb/z4hbsvQ6tGHQ9X/l1XZa5Za+4pMoVd6f
	wIHnou6NkafWieCNNFE9oiuOt8Ew3/Rc7kNI0snm51fgB473992dmsFFhrphJClD5DqS8xa2hcB
	kYljsYwwJAxu5dCPyJ8AAM7ETym9lzOEYJZlieFQ786emWeDYSGFvvkRhPWSZh7Kspuht3LlKtd
	NwS9q12Si/XT/sN52I2+PsiNoJsIV/LeYoS3IpsaU4pLmtAIMIoa+f7Zhjt9S7t4MFo7VCgx+eA
	GQVFGVI0Qy7DUxnh0P0KeuS58JJVCI90xffGN7r1z6lfAwk5NEaclV1xzaG6Uf1Im37FG0D8cTZ
	yVK5M/CjNknzsysU0tXlq2icIpYYtN/uM5ClsdU+9uQSn4LKz2OW11afR3tA9lzeOCVjC0C5gpZ
	RSwQ==
X-Google-Smtp-Source: AGHT+IHlU3nXC43MvGYmZdufIjuAqfYHLWWcoHSYnZo7IpnH9QtMQ1bdyIa121E+ylQT7V5SjMrRaQ==
X-Received: by 2002:a17:907:962a:b0:ae0:3f20:68f8 with SMTP id a640c23a62f3a-ae6fcbc2c32mr271433466b.39.1752227256648;
        Fri, 11 Jul 2025 02:47:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9? ([2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82e3a8csm269513166b.154.2025.07.11.02.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 02:47:36 -0700 (PDT)
Message-ID: <f990e446-a026-4543-98bd-5244d51e650a@linaro.org>
Date: Fri, 11 Jul 2025 11:47:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
To: "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>
Subject: OP-TEE 4.7.0 has been released
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 0F92F3F6AC
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.29 / 15.00];
	BAYES_HAM(-1.19)[89.06%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.218.46:from];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	DNSWL_BLOCKED(0.00)[209.85.218.46:from];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[linaro.org:+]
Message-ID-Hash: OWBVDVLKOL7WK4DYJ6VERZP27WO7HOT4
X-Message-ID-Hash: OWBVDVLKOL7WK4DYJ6VERZP27WO7HOT4
X-MailFrom: jerome.forissier@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/OWBVDVLKOL7WK4DYJ6VERZP27WO7HOT4/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

I'm pleased to announce that OP-TEE version 4.7.0 is now available.
The list of changes can be found in the changelog [1].

We have two known issues in this release [2][3], both related to SPMC
at S-EL2 (with Hafnium).

A big thank you to everyone who participated with contributions and
helping out with testing the release [4].

[1] https://github.com/OP-TEE/optee_os/blob/4.7.0/CHANGELOG.md
[2] https://github.com/OP-TEE/optee_os/issues/7445
[3] https://github.com/OP-TEE/optee_os/issues/7450
[4] https://github.com/OP-TEE/optee_os/commit/86846f4fdf14f25b50fd64a87888ca9fe85a9e2b

Regards,
-- 
Jerome
