Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B7ACAC5B8
	for <op-tee@archiver.kernel.org>; Thu,  2 Oct 2025 08:41:41 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E2F1243205
	for <op-tee@archiver.kernel.org>; Thu,  2 Oct 2025 08:41:40 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=T0C5jfM6;
	dkim-atps=neutral
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B68804187E
	for <op-tee@lists.trustedfirmware.org>; Thu,  2 Oct 2025 08:41:26 +0000 (UTC)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-36ce5686d75so657111fac.3
        for <op-tee@lists.trustedfirmware.org>; Thu, 02 Oct 2025 01:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759394486; x=1759999286; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRs2HgZQCtBeGXI9qj8l0L5wA46oSCjHp6c77COo6HE=;
        b=T0C5jfM6nXEkTmq5H5uGls8j9MjDs1e1gPIvdSCskqiqKVMdHIC22fg4JNKFbYCUp4
         gGX0Cv9w+QDHJU0W3J9QGE2rvJPpHtMFB8YArfr0IfsuTa2pJniG+NZ5YsDIcgAdd4VI
         o0TtvQtgR+H+6+fFMIlhD8MYZCuDQ9Td1ryahERTIhg8+FZQUtCPfPELylBf4CibG/Z7
         J++OeeoUFIZ0PwDAgFLSj0Kugyu7wm53fh8cmp2RnDlKqMBhgmZtsdkt5Jtzv94FjPVa
         bWyQLhoixfdLH5V712kcGfbfl04qNsRqgdm2xdK4EhOKyLUoLEzjFQRuZRdmk/g+EGSJ
         twow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759394486; x=1759999286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRs2HgZQCtBeGXI9qj8l0L5wA46oSCjHp6c77COo6HE=;
        b=Ypjr/gwWJfh3DUP6iZ8TSbFAY5KWrFcXvBnGIniR5rp3TRzAcEFmNbGnGbl2hOo8nF
         ZAFs1f80AkMz/i9f4XzH/v2ai4a2M24nK4/nYHABj2SLekozP5uvfurFDtbudIl1up5i
         hJy+ONrgul/2OLLXT348NLN1QRG9TXxnThx9oSWv+U9FdR22oKTYiE2ZV+gWOnILt6wD
         W5scxZA8XcEAvoBRvIMhHy0YJ77d1ZBenuE2MyxlhlJgXVn6IAaNifWfTuCQVNRn0qtI
         VcC0dTLaVSaNchtHsbryF9oqo+gHzgvqVG64chQpxkP4AjmW3M6SB8OWu36TcgIWTsTW
         CHuA==
X-Forwarded-Encrypted: i=1; AJvYcCWtEoHYTWjm05hGYxpV/IphZ+oKKFqjhC/engLCZjgsdFb6GKgr19Cv2yQdxaX7LRQJWInTgbI=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxDBOjFUemeH7KLczeH23Ww9CHycWvt60hUKxXAYQ4Eei4DoJXX
	RSKvzeK2/hB/x+UorCBtcUNoaOOolAV0/eGetcsUtM8JJTmwjAJDWH8cHpFoz2S60MgNJGMTiv2
	1tN822xzUpOpG/hJrwCYV+R+xNHWptnc14FWu0iqE9Bn4
X-Gm-Gg: ASbGncsa8DhIAt3eJRZlCjntQS3sbyzjPzG+rTU9rjSD4L+SPcI8KX1KjrlYAhXtbaL
	vRdgrZZ8PwvfpCnr5chZO9i2yCrqWmgahH+EYT2HXF6bBEEzDHSryd/PvOZcXJwpffrSf49PxhT
	F1ZD6mAmAkJ9Nws34QJ/ZYWSK4Uy04Y2He20/jUwBxH3gAEa2il46ehIRLjXfaFW20bNdecTicO
	IcTsKoA+ySAD8sJm1FtSjytJKivkZzeg2lL
X-Google-Smtp-Source: AGHT+IFdxe19aSB3FNHWco6xM2pvw1ZN8obwBln7idZ5E/P9IK5Q/zYbBXb1d3G6WQQ45jHzBmBw7fP/yjYIvCTtv1I=
X-Received: by 2002:a05:6808:3092:b0:43f:7cd4:4fc4 with SMTP id
 5614622812f47-43fa402c2c6mr3295400b6e.5.1759394485922; Thu, 02 Oct 2025
 01:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <d0b14c3d51245f9eda2341504c05bd0f5b0828b7.1759243439.git.geert+renesas@glider.be>
 <a5907537-cecc-4564-bae5-981d3ad85d7c@oss.qualcomm.com>
In-Reply-To: <a5907537-cecc-4564-bae5-981d3ad85d7c@oss.qualcomm.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 2 Oct 2025 10:41:14 +0200
X-Gm-Features: AS18NWD-0rE6kz3-A73Pl3SUY0al8gOtGel9P-SlAuJ2V3nZRT-_jgAcPjsmPd0
Message-ID: <CAHUa44FcCyqaWCbsdEMj=Jr9vcsxHh+nK1qOqpbtJsx89C7tqQ@mail.gmail.com>
Subject: Re: [PATCH] tee: QCOMTEE should depend on ARCH_QCOM
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B68804187E
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.57 / 15.00];
	BAYES_HAM(-2.97)[99.88%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.160.45:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.45:from];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: SAW3PFWPGAR4RZISMGPS7N4D3IFKXNG6
X-Message-ID-Hash: SAW3PFWPGAR4RZISMGPS7N4D3IFKXNG6
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Geert Uytterhoeven <geert+renesas@glider.be>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/SAW3PFWPGAR4RZISMGPS7N4D3IFKXNG6/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Wed, Oct 1, 2025 at 10:23=E2=80=AFAM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 9/30/25 4:44 PM, Geert Uytterhoeven wrote:
> > The Qualcomm Trusted Execution Environment (QTEE) is only available on
> > Qualcomm SoCs.  Hence add a dependency on ARCH_QCOM, to prevent asking
> > the user about this driver when configuring a kernel without Qualcomm
> > platform support.
> >
> > Fixes: d6e290837e50f73f ("tee: add Qualcomm TEE driver")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Applied.

Thanks,
Jens
