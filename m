Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E9F8CCF9EB
	for <op-tee@archiver.kernel.org>; Mon, 27 Oct 2025 07:51:35 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id DD0D543247
	for <op-tee@archiver.kernel.org>; Mon, 27 Oct 2025 07:51:34 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KkQl+uCT;
	dkim-atps=neutral
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 413EF431B3
	for <op-tee@lists.trustedfirmware.org>; Mon, 27 Oct 2025 07:51:25 +0000 (UTC)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6542eb6dae0so2313250eaf.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 27 Oct 2025 00:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761551484; x=1762156284; darn=lists.trustedfirmware.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=66XHHom+LsQ+btLE76AJdXwhxd40zi2OWQ2GcgyEznY=;
        b=KkQl+uCTFdUZDWyejifCT0bWrSTyfjkYOyl74jGnHT6gKRssGqEeak9kyq0XCPm5js
         pB0/st88zmeCe2GdU/B38oFBYtsSFHNZ//jLZIxKHVEVQe5fwQfGR/bcuSSqvMsBe8ep
         ec9I7BxiXwUwi4C3w1HT31f44hpW7YQ4g9oN9l4316QzJTcydwDp2H/Om2CwBHQE+U7+
         48hc1dShu0TUogjpI7e1SYfJrnu9/5YGjKHl+HEosTg/NITr1fLVrixeHxd9cBE0oDuF
         Ejul+SNzNhXhL4FEHt8nWwUcWytPAnD4zDElTFy2dmQyBeDeBXjXcN1isXKJ64UAMEgC
         d3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761551484; x=1762156284;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=66XHHom+LsQ+btLE76AJdXwhxd40zi2OWQ2GcgyEznY=;
        b=qXmm2gF0LO6DvQorPqVzWz0x8aAhdPdhn8UwR80B7MJVfF3GwJnXYtVa9rnoFQvx+a
         x1xcWYCGvJ2m+Dw+oX54q3lRCFhR94O/JPAJkljAYTKvYpi+889YKJWQCCA6MhYl/IXE
         n/8sS3xBCjCnXkOlqjebYB8YumDaurLgiy7jIt+iR5Kj9Jg/UryJvz7pPQ+u5UB/j4Nd
         3j1x3lFSU8X6qAOjwEDqc13wTunQ8O4U2KdB3KRmnnuiLVzKjc4HCpT70k3gW0s36imb
         qmAtJMgGZSkzx3Y4enCLz0nI3CAsI/AXe3HmVcFH1JdP5fE3CZqmaWrQVoH1nd41eUT5
         sZDQ==
X-Gm-Message-State: AOJu0YxakIxx2Ikx1JI1Lqq49RDz8nav0JZAXFI86dYboFoTV+Y99BYn
	6Hx9I0YU0zxWvg7Db+EX2MtoH0OyBt+VXsxdL9EKwGTKNTkIGp+9TOskrdJpTej65VLnQBU3xPA
	En8lWPvap2FEg8Na9zvJEkteCeLJXfzrtqJ7ANVJ/H1J0vNXx0b1SjnxagA==
X-Gm-Gg: ASbGncsgtCP0PVCmxXC/c7/fjUJF88CGZ6ESxBk9t2zQEZvSB+HWFM3o0TiE7bMZ3sy
	WfFxSYuRH6fpQBiZdjNof5HZC587/kbVwtumlFRaMp2dlYcuMNiM4ZimmuL7lXgXVmNwOCxcnF6
	XjNa5XV2klnAHZkAHzIAk+uT471qaPMwvmV81+akzPMOfOlHBCKGfpFfGpcAa32DSSwXG+UIccz
	HjDHDbvF5O5eXP19KJEhoLyKnViN7us7OWsw44+cux2yM1iBilpXzV38OM=
X-Google-Smtp-Source: AGHT+IFxRqMjdjjw21+auG+i2bt9rZmO9jFZrVs5SBz1wEbjIBialzyBEHb4MH9v3M4xKxXnP/ciQs6d1wPJVp9s7X4=
X-Received: by 2002:a05:6820:f06:b0:650:9205:bd15 with SMTP id
 006d021491bc7-651c7e52d3fmr403415eaf.6.1761551483790; Mon, 27 Oct 2025
 00:51:23 -0700 (PDT)
MIME-Version: 1.0
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 27 Oct 2025 08:51:12 +0100
X-Gm-Features: AWmQ_bkz6J_hYw4XOwgz3t99SXRepbtgO-3hUKCzKN4KhJkyTL_r0GO54uIRSxI
Message-ID: <CAHUa44EubqJk4Gv+X46iAAnamn=n+oCGWqadaQDftmApHX208Q@mail.gmail.com>
Subject: Linaro OP-TEE Contribution, LOC, monthly meeting October 28
To: OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 413EF431B3
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.05 / 15.00];
	BAYES_HAM(-0.95)[86.66%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.52:from];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ARC_NA(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.161.52:from];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: FCL6KI7YKGYID5XS3QUGDBKFW3ZHFD4S
X-Message-ID-Hash: FCL6KI7YKGYID5XS3QUGDBKFW3ZHFD4S
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linaro-open-discussions@op-lists.linaro.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/FCL6KI7YKGYID5XS3QUGDBKFW3ZHFD4S/>
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

- OP-TEE version 4.8.0 has been released
- We have an op-tee channel at the Trusted Firmware Discord server
[1]. Last week, there was a message about improving the order of all
the config options we have in OP-TEE, the CFG_* variables. In the long
term, we might still aim for Kconfig, but that's quite a large step.
However, there are intermediate steps that we can take. I hope we'll
see more of this.

Are there any other topics?

[1] https://www.trustedfirmware.org/faq/

Cheers,
Jens
