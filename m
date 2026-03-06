Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C5FF0182E
	for <op-tee@archiver.kernel.org>; Fri,  6 Mar 2026 11:53:20 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id CE725438A9
	for <op-tee@archiver.kernel.org>; Fri,  6 Mar 2026 11:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1772797999;
	bh=Z+OP+Frmk8PTztxIx1kU+lYtsUJc/JdSqfG/6fvWrME=;
	h=Date:To:References:Subject:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=zA8r9V4A1WJayNnNs1mBonxSJkj7U8Solko+9Kmsfsok7tvZzODtwY4xCc59R8N/Z
	 5jLRorwcvdhylWeq7U0VyaFn6l36MHDBkizJ5d5IFtk27zuGx8H3qMONQ7pnjDvRd2
	 RAzR96YprG1sEepLjJN8gBeackVgx5EBRLYcqk8/6UmUMSdvDwr96xkEvpIOvvwrgn
	 H49ow06f6qHtCGhhSIBVQNd6EB1PWM6oDcx2bOzNlHMG5z9JuwlWRwPe3VV+3vPc1u
	 1g+1N6LQYbl2qzCT1cH6iC/HYSoTB2u1Xslx/bnMRa9teNgQgWfIEqL0ZYDlFE9Ena
	 VcdGhn3mcUCCw==
Received: from mout.web.de (mout.web.de [212.227.17.12])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1961E41937
	for <op-tee@lists.trustedfirmware.org>; Fri,  6 Mar 2026 11:52:59 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=pjbKKorn;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1772797962; x=1773402762; i=markus.elfring@web.de;
	bh=/1rX7wd4BEjJDAzBHRrSKQB6zvMSiWQfDT9upLx84Zg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pjbKKorn1q9+sWUpeZEAUc8PRNVjTTaX2Tof4mzp9naU1NRcGIWkhCu923JNm/iC
	 i8KwkPc34KP38xG/MwOZPvH7GD2b/FQQq9RZpzpfkzIoWKJdyBtQWG/M+x4yIulOW
	 tss5u3SW1bZUFvKKZg8dGOFnbOaq6N1hFzXa0lpcupCpWQy083q8qo1MlUkzkRdUq
	 Y5XV9eviPMTvNkC5yZOJBEj7mUi1G0QLErDpkVfsNcP3B46trStpksTaajsKJQpgn
	 xsjaNjTMUo0m4TsaILpDub7cIlIU8gOVxBPOSfXfH8swhtPSW46dlcewV4a4aGVw2
	 K8cssBDsjjBuozC2Bw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQPZj-1wKhaK3mqH-00HpMJ; Fri, 06
 Mar 2026 12:52:41 +0100
Message-ID: <2e15b2b8-7dd4-4e63-b9a9-a664323ebb36@web.de>
Date: Fri, 6 Mar 2026 12:52:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chen Ni <nichen@iscas.ac.cn>, op-tee@lists.trustedfirmware.org,
 Jens Wiklander <jens.wiklander@linaro.org>
References: <20260305083312.1040969-1-nichen@iscas.ac.cn>
Subject: Re: [PATCH] optee: Check return value of tee_shm_get_va()
Content-Language: en-GB, de-DE
In-Reply-To: <20260305083312.1040969-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jobSu1iFwiWMgxxI2JHBJxugvNyluddBYEQxqOB5kRBnZqToVV5
 gNvvAD7i0cSH4WAyTa9Wt6vnYsMJGOfQ9VAY1sOGVTzpJr4Oqb43AjmGbbqUgaeEA0yPxaU
 f64Zfr70oYHBTrBMviLAmKtZOGLHPWdFn8FqMSm3R2epJD/5bMG6uo3MOAqhc5qRWF3WeJu
 3IQe6rj5Rn9dMRLb5y3/Q==
UI-OutboundReport: notjunk:1;M01:P0:yMAo+D9lRKc=;JYB9EILXWKlZBylAOrekmXtQmoJ
 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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	ONCE_RECEIVED(0.20)[];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	R_SPF_ALLOW(-0.20)[+a:mout.web.de];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[212.227.17.12:from];
	RCVD_IN_DNSWL_LOW(-0.10)[212.227.17.12:from];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_FROM(0.00)[web.de];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[web.de:+];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:8560, ipnet:212.227.0.0/16, country:DE];
	ALIAS_RESOLVED(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_ENVFROM(0.00)[web.de];
	NEURAL_HAM(-0.00)[-0.464];
	DWL_DNSWL_BLOCKED(0.00)[web.de:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 1961E41937
X-Spamd-Bar: ---
Message-ID-Hash: Z7YCWGDRINKPJD5TEV7NSSFX7JPMVFSZ
X-Message-ID-Hash: Z7YCWGDRINKPJD5TEV7NSSFX7JPMVFSZ
X-MailFrom: Markus.Elfring@web.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: LKML <linux-kernel@vger.kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/Z7YCWGDRINKPJD5TEV7NSSFX7JPMVFSZ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Markus Elfring via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Markus Elfring <Markus.Elfring@web.de>

=E2=80=A6
> +++ b/drivers/tee/optee/rpc.c
> @@ -393,6 +393,11 @@ static void handle_rpc_func_rpmb_frames(struct tee_=
context *ctx,
>  			    params[0].u.memref.shm_offs);
>  	p1 =3D tee_shm_get_va(params[1].u.memref.shm,
>  			    params[1].u.memref.shm_offs);
> +	if (IS_ERR(p0) || IS_ERR(p1)) {
> +		arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
> +		goto out;
> +	}
> +
>  	if (rpmb_route_frames(rdev, p0, params[0].u.memref.size, p1,
>  			      params[1].u.memref.size)) {
>  		arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
=E2=80=A6

How do you think about to use an additional label for the shown
error code assignment?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv7.0-rc2#n526

Regards,
Markus
