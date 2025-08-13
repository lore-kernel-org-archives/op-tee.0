Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8964FCA0EC4
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 07:49:54 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C488A4FC91
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 07:49:53 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qIK3Om9j;
	dkim-atps=neutral
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2E28A42EBB
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 07:49:40 +0000 (UTC)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-61b7e44f8b3so722741eaf.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 00:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755071379; x=1755676179; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfeJn6OXLOSd2GklhvEK2KXBF/te/QhNlLJRLLpT6NU=;
        b=qIK3Om9jqEhkL1Jrien+z8KheltuWawPIDP9phfNJjQT8KTNOkCZgyShhC+UcCBJWa
         yLzIRYONxpbnBeH0wOuWCpQlsGuVq+MH2ZcqmI7oxIC8KJcACk/Dy3wbHiLLa+8o74tv
         hnBccAx/9H7mGDgrBefUj24KEb/65L7Ktc1ST6BZvXSs+SA5own46ibxjSqemUgF6bMy
         xY40+mw+cyX0R3EcWJGsaUuaCs9Yj0Q/z8LyZBvtlYZBplx/ur/z2NeX9Nu/wt0lcZ+A
         VF0ZxKkXzQLM0z4pD90BW0XaaMlMjpr/ykl51I7RN369ZOAltbI5SraobGTbHMZ+Q9di
         MrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755071379; x=1755676179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wfeJn6OXLOSd2GklhvEK2KXBF/te/QhNlLJRLLpT6NU=;
        b=QSEvQmR0rvet8Z1ISgMxvMvXTWlvGMwwAbfXwUmN5WyXjPszIkNa8VRd7x5sUyWgOu
         bd1ZW2AHoH2PdnL76rWd3+ZeZ3P/u05g7jiuGONmvaxmFXLzhp4o/P8Awf9NkG+mg6Yl
         nCAAzTkpzECAQFHDpa+1x0qERukuvGNn7k1p6/xLAoW721NRoofqsRJ/eCWrDHmwY/Cg
         B5t9b/DOzMS5pHjpO8lcUAb4hSTQgoGEaCOGM/1vrMsSGkbvRLhSSDkNiD2C1Lc4YczH
         Hy6XkzqTU+RgDE/NRIZoQG3uB00DYmsV54sCzMb0H1b2i+G3ttvP4twcpzwNCoTofG3d
         4Bjg==
X-Forwarded-Encrypted: i=1; AJvYcCWp6oMrBnUOiFPvD9P0Vg63xMU0pSXGjJB+BhaE3pZb4D7zhX53mcnA8b6KxCGiYzeJfNd9ATo=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyUdIwy3fg9I8fmFf+vMD8YJnCvNJxh8oLFvs6DVk3+4q4Lv0SM
	XVPBzi5iW9SKQx7CeapzNscu+Ojl0qbqOBAachOalCnrtvVI3XMWIb0QhwlkBWq0f/C1gWOw3MS
	KHbpgPz7O3GDndVonPEbf7o1iRs5hOqJWQqs5Rnukt64I
X-Gm-Gg: ASbGncs5x0BDaFI+2gHM7VbD8HOA6TX4Oup9apcGk/Jk1CG8Kck0BZJ0ECfEhHLAH8m
	Kzme+rfPsP8ev9XsUWQew4yRFmrsLC2QHfIQhuoZ8NGNNyhXHW2VbkzH0IVnwZjxuHSikph0hSw
	N3RTdN3dU+8KCk+gZxPK8Wpq+xcVScq55EOzEH2mzSVj2m5YgSRYfvVM7N/cm6HnBvB9Kc4GZ8C
	XiACUs7uXYfr6eiWJs=
X-Google-Smtp-Source: AGHT+IFAfPPXVnV/fIsv8KnI8b8Bl+IOsf+U5t0pmvRJM0gZ8xG3AukFt3DXdXVb9aF/gWZVqDSUuTyRuSP2uDtgU3s=
X-Received: by 2002:a05:6820:1ac1:b0:619:a6c0:b4b with SMTP id
 006d021491bc7-61bc758538amr1013523eaf.5.1755071379266; Wed, 13 Aug 2025
 00:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
In-Reply-To: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 13 Aug 2025 09:49:27 +0200
X-Gm-Features: Ac12FXyfvHrDtrackOzZC99WcBb71C_WC3_DT2d5Ppi_3YWKQtwtthH808vWulI
Message-ID: <CAHUa44FJ9iRMyDHffRBwgxxX27vTwsAwNiCCEGQ8fMQPZS_D+g@mail.gmail.com>
Subject: Re: [PATCH v7 00/11] Trusted Execution Environment (TEE) driver for
 Qualcomm TEE (QTEE)
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2E28A42EBB
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.40 / 15.00];
	BAYES_HAM(-1.30)[90.10%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.47:from];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_TWELVE(0.00)[20];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	ARC_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.161.47:from];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: MAK36SX6OK74VASOYGZWWWN2GTMH62PA
X-Message-ID-Hash: MAK36SX6OK74VASOYGZWWWN2GTMH62PA
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Apurupa Pattapu <quic_apurupa@quicinc.com>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/MAK36SX6OK74VASOYGZWWWN2GTMH62PA/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Amir,

On Wed, Aug 13, 2025 at 2:37=E2=80=AFAM Amirreza Zarrabi
<amirreza.zarrabi@oss.qualcomm.com> wrote:
>
> This patch series introduces a Trusted Execution Environment (TEE)
> driver for Qualcomm TEE (QTEE). QTEE enables Trusted Applications (TAs)
> and services to run securely. It uses an object-based interface, where
> each service is an object with sets of operations. Clients can invoke
> these operations on objects, which can generate results, including other
> objects. For example, an object can load a TA and return another object
> that represents the loaded TA, allowing access to its services.
>

There are some build errors/warnings for arm and x86_64, see
https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/jens/plans/31DmCOn1pF=
2JGVDk3otBOXOL6kV

Thanks,
Jens
