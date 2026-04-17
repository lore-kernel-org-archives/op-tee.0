Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8928F43688
	for <op-tee@archiver.kernel.org>; Fri, 17 Apr 2026 10:08:48 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1984043E48
	for <op-tee@archiver.kernel.org>; Fri, 17 Apr 2026 10:08:48 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bLwg9cpc;
	dkim-atps=neutral
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id D6C0143E48
	for <op-tee@lists.trustedfirmware.org>; Fri, 17 Apr 2026 10:07:21 +0000 (UTC)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-38cc8708d76so3934221fa.3
        for <op-tee@lists.trustedfirmware.org>; Fri, 17 Apr 2026 03:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776420440; x=1777025240; darn=lists.trustedfirmware.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pypCN2FEx3DztZKcpADUYxk5E/N+YZJWi7HnwVX/URE=;
        b=bLwg9cpceQ2rjqqCoSUvWTHEJi3ZLaN8c0Z9w6NgJ2KWP4/2wETO7vRh0VqhTemnHI
         xRXhC+/ADA6TgYXCEkjJ14qbZG2Ejm2NcW0Phl9ITgYYs6C1MzkDGno3IWCeElJl6Atr
         WR1GRobgPwsCrhAWXWW0DfM+jUbbw3TzlslcFW9o6WqdAr50k4Ud1TwYU8k/XrsnCGmm
         8gDtNPlznWd0XAC4Z3Tdbs6bvVItPLOWURH/BTF5YaV4/CWOGcSA56gOYwfuZ2EayNuM
         m4Pmy7u+IVznGzCaxse+L0ImG/YbscRpyoAya9HcAvi+PohIhTBFhzEmhzGk8MPXCbN2
         j/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776420440; x=1777025240;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pypCN2FEx3DztZKcpADUYxk5E/N+YZJWi7HnwVX/URE=;
        b=jDoHyVuZj16lJIunvGaIhGsXitxnQWtXz3MNYUlRc7yiwfzfRjsgTKxYT6IwwjqH7Q
         QGOPA+Vro4Czh+3xpCp8GtTrrgSDD2k6VqAZhwFhf8JuwyYkyfnw1Iz6xRRt7YKD+1b3
         O/zgl6peQyA+4em1/TcUhmGhMO+8tG+Y2lUpc0pCjY/oHO6xvd9DNoHH2uZgjqRCvXP3
         VLcxoqzuC1SJt0zGaaFjIGeVdUx2k12oRJYzapsecrbaRbJOV4v8Z7aWkN3Eh/eRYYX0
         RWj9kKeyxKtKN1oZ6m0ZRERFFNb4w8UTIVGSFW/+wv4QHt6q0KazPm+a4uswu4l+uehu
         LSHg==
X-Gm-Message-State: AOJu0YwothPaIU5DboRtgQFnEO1LsOGPRORsGVgJ1D5uvrb9oBmQt7AH
	B9MaHU0ifaQdfliU4OBBqbSaeskZhSBnvdLRDgamfv2b1tM+PkRMYTIWU6A0Zg/igBkCjd/IbHQ
	I+7+wrBnhsbV5
X-Gm-Gg: AeBDievyWWxn8y+Q54a5r/PKHzlcaADMJZrm+kcf5CibexV6AQRL5lkwwQflUEgzyjo
	5UJbcP2lAU3H7MsQvnuFpqHB6QzL814gHmucDDygHQO3hnB1kqZSVUegBx5MG4ksIr+fTTVkRCU
	0g4mZf1pl2LSwpJNvC7qRmOFoazb2sI+qCnLOATVuV99+rSNfC/U1+xRKIDIUpqK55+/uVsPx/O
	ixFTmYlTL4r6HxExAsKpnmPcq7lSDlEcsgBHMsYIlQPZA7yKdhvQrXn1qoV2qJpq6euEAqTERCq
	zdkVpqTSVaQoYeXsZPTjA0IjrNNdgyPlQ6nvFf7LBroe3sH4i9ruq+aIU5PdIe841U59ULO/toF
	l4hWDFJsSkuO27aP7tnVdYDxteH5H/92EcrONaMkdIuzNu7VdkmGXcl9Li49m5d9XVxgczKGf0Q
	h0i+FUtHirU70AX9xq5+pDTLrtDcaX3oHCtzWNaTsJLKIBge74gW64xYmzGF33lNZtwKbjinNys
	eISLL4Yhhm7AiItUWsC/jxJNbcWEg==
X-Received: by 2002:a05:6512:10cc:b0:5a3:cd94:df73 with SMTP id 2adb3069b0e04-5a4172e7f45mr838194e87.38.1776420439568;
        Fri, 17 Apr 2026 03:07:19 -0700 (PDT)
Received: from rayden (h-79-136-84-34.A175.priv.bahnhof.se. [79.136.84.34])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4185bc64bsm272540e87.31.2026.04.17.03.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 03:07:18 -0700 (PDT)
Date: Fri, 17 Apr 2026 12:07:15 +0200
From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: OP-TEE 4.10.0 has been released
Message-ID: <20260417100715.GA2057244@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.67 / 15.00];
	BAYES_HAM(-1.17)[88.92%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.208.182:from];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[79.136.84.34:received];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.208.182:from];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: D6C0143E48
X-Spamd-Bar: -
Message-ID-Hash: DPPOTJQW7NDQH2MLT2F7G3OCB2YRH3C4
X-Message-ID-Hash: DPPOTJQW7NDQH2MLT2F7G3OCB2YRH3C4
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/DPPOTJQW7NDQH2MLT2F7G3OCB2YRH3C4/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

I'm pleased to announce that OP-TEE version 4.10.0 is now available.
The list of changes can be found in the changelog [1].

A big thank you to everyone who participated with contributions and
helping out with testing the release [2].

[1] https://github.com/OP-TEE/optee_os/blob/4.10.0/CHANGELOG.md
[2] https://github.com/OP-TEE/optee_os/commit/753afbbee1682f5d16fd30e87b31058a4fd4f4b8

Regards,
Jens
