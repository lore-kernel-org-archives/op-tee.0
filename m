Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF7BCD74EFD
	for <op-tee@archiver.kernel.org>; Mon, 26 Jan 2026 12:56:17 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1697B436D8
	for <op-tee@archiver.kernel.org>; Mon, 26 Jan 2026 12:56:17 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bFWgTmoS;
	dkim-atps=neutral
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id DC5C3430D6
	for <op-tee@lists.trustedfirmware.org>; Mon, 26 Jan 2026 12:55:51 +0000 (UTC)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-65f59501dacso3059940eaf.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 26 Jan 2026 04:55:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769432150; cv=none;
        d=google.com; s=arc-20240605;
        b=KJ3LUeE/eLhDbBNUkQEBSSWHKyhJCK3NAKlVOIBMpE97nQMe1CgzAko3bcTOAlDay0
         nDI9FQyrCFJepA9ndtM5ao2Tl4HZ0zTw4W9hcbEj4347UxeKnd1W+SEvYHO6d/MYyqt6
         qYJvS2pmKSyqWJMp+xNRHmU0XVjJG3cjAeXnnsSb3NvKmP1CbUDod5lBsFflpJRWDAaC
         HcJd1w/tr9bFF0dQQF9FaE9OD3Ia23RonV/pIKqDPmxeKY+P0dKQeu/sgRgx1HTsJU3e
         8hSuY2iDrGUJ3dq/12j7xo9Ca7tfnKMrMflqQJGBqUg2Ujn52jghOTFk8JXor1iniSG7
         LHBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=+/0y9tbmXAoDHvNFOtoDda395NVWAV2l7zCFF/1J+ec=;
        fh=QMgjRTud3zRGrIikisptnJQ9eIvAhpU2BvrMJA0Z90w=;
        b=LGZ9D5D0FfkuVEDDvFmhaKfzzItVq00AlWS8DIMnTduv0JcgwcB3JA5sLFvByODOjF
         vqSWfF0bfuDAvvLYY047wEtkKrm9REbKgjql1G1eUbdZaKQFXQ7FqBNrA+NHq/eWNUUf
         sxembz16V/3+2jxLVQqugGjcfDJzsHFwtYZ7NxPJwEttyqh+jSVqmY/qd6n+cU4yjzqZ
         /U8A1ne3ZTuTgMoKaIC++kN9FZ+boW/SoB2bInjV4J36fxyN1+bqrTaKs56VVBN2GChf
         WM9DGEUWqobhchlr/E4+OzyrUXkM+JNiqQ229MjXAOg0wUQcdsej2+vVJi6PQZHCvzsT
         jm3w==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769432150; x=1770036950; darn=lists.trustedfirmware.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+/0y9tbmXAoDHvNFOtoDda395NVWAV2l7zCFF/1J+ec=;
        b=bFWgTmoSRZkS7LedgRwBoFJPLvHOP4RWQaVCOqGIWtUaLahYRYzhQEzdyKczZSjbsn
         Eq3n+I7wNHaPCnciW01Ox+vbb9H490QOh3b/eZ71hrx8LY8Pw9H232ghXnruRAj6NdgG
         JsECg1CZlrFE6NthjjhyJ3QeL4tnao3hO5f/GWlIheP5MYHUy8cN0vQPn0fKugMVCFdz
         WbHAi6j4W8sllA370EfXn7/uWkJEifm538p3dF9nMYTnwoD6lap0jUWmD3GGH29eMGDI
         RTjKnE5IePk025libqjTxH9UrmQXo6ic/HkF9xTrB63PoJInQPfm5j5bENRk3EuWs2MM
         tOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769432150; x=1770036950;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+/0y9tbmXAoDHvNFOtoDda395NVWAV2l7zCFF/1J+ec=;
        b=d5LIuhuX12rNVeEDXHCfk4ZgaBwPJ7eNEalaRaG+SwIfuAPTFByQkmsCkVJ7sAyeEr
         5uLcoGO7S6pofWc/TzIyPdzBqb1fb/comU2nsKbznTfMh832mjuUcUjdYGjI48lHrBXU
         jHeXJryzhZuEmWH95JL3myxi+2fUHzIoo8mKdtzjdDQz0cgctgo6Xa+6813lZs3UVi0Z
         /SxNtHAsKAg8a2iR6abXGqNwNBRY/HFgAdVQK97fURkk+k4rRnB6dTahxfpJ3iFzgLXD
         bk48/Tu/oA/AW43vEskTD1yPNydDr2W3xTF6VG5olGL37IkgvV/PH0kkTKmwWiu7BMih
         aE3A==
X-Gm-Message-State: AOJu0YxyoNE0U3FOYzG+ozA6i9JnNcOrQNKqQgWCRSLTVva2dYQYsJtv
	+5Ybc2ilhCs855giUJ1uCBob+b4egGQF3MkkdtzkEWy6Y0j9YIXu60SsO+pqoNtQIENECQY0M8w
	2ZGGAoT9w+Wu8bKGQ+3yfz/Va3qt3gEZAVJxmh7PsywJeYFJqp1obnYO1yA==
X-Gm-Gg: AZuq6aIHbvy+rH+UEsTMcD3JAMEno2U6I4+rEaaEX0kbjl5S7H2KljKyEVD3Qtx5OXU
	VHfN0nzeYqh1dzhtlVsGjRM5kst1USHckyjIw9Fs6nQL8iFP91VYLADz6uKzK4FESzqdqG9j4Zg
	hSKJp6Cf0m3ZaQv0K0w6uB/O3AI8yLZxPnGk7wVgqr3sUpmJYLc8tuSE+fEjjIkwvdehlRib1f8
	QAmG/cwxlX7No87JRCwuTmZ86dRG9S2TbbaqSYIYmNVye7MoXi//g5NrgVJvYRlrBB2d1ZOrTwe
	wCb30+R30mzneemPri1v2GbFhw==
X-Received: by 2002:a05:6820:f02a:b0:662:c7bf:e3b3 with SMTP id
 006d021491bc7-662e04c7213mr1963593eaf.83.1769432150466; Mon, 26 Jan 2026
 04:55:50 -0800 (PST)
MIME-Version: 1.0
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 26 Jan 2026 13:55:39 +0100
X-Gm-Features: AZwV_QjOEKtIg5KdaH6QC3z_t6MreCMg-Qd0Dw9DYWIvaMjvefs2PeE3MJ78ovo
Message-ID: <CAHUa44H3UR+Eno=fvinEqXm1-MPnVuGr7KMxf7bjD63DkZ7fdw@mail.gmail.com>
Subject: Linaro OP-TEE Contribution, LOC, monthly meeting January 27
To: OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.09 / 15.00];
	BAYES_HAM(-2.99)[99.94%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20240605:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.44:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.161.44:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: DC5C3430D6
X-Spamd-Bar: -----
Message-ID-Hash: T4UH3NVMRPH6OAEPJEXZF5EQTKHYYC7D
X-Message-ID-Hash: T4UH3NVMRPH6OAEPJEXZF5EQTKHYYC7D
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linaro-open-discussions@op-lists.linaro.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/T4UH3NVMRPH6OAEPJEXZF5EQTKHYYC7D/>
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

- OP-TEE version 4.9.0 released

- Following our discussion at the last LOC regarding exporting OP-TEE
version information via sysfs, the latest version of the patch [1] has
been accepted.

- Any other topics?

[1] https://lore.kernel.org/op-tee/20260112154833.78546-1-aristo.chen@canonical.com/

Cheers,
Jens
