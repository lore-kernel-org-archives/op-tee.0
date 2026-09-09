Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A3DC79FB7
	for <op-tee@archiver.kernel.org>; Wed,  9 Sep 2026 16:03:10 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9CB08434A5
	for <op-tee@archiver.kernel.org>; Wed,  9 Sep 2026 16:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788969789;
	bh=ze/7Z0bu8ix+pxZoxnVSm4HhW9KxxkbdWmFN1BdD4UQ=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Dw5aFd8AOkq2yQyw36GQ0hUeNhP2prVr2yrlq3REC+K3VWFbMAiAzc8bs0qFMdc2i
	 jTO1znfUmDHvs5ff++l0O5Xkl2sIN+UBUxnMfCjfP/Q2UfQ73Zca2uZqj9KQimenBx
	 0xOrc3m/uDgTX0k4vjqQ3e54FZysimrkXzBn07roHoNhNQQbzpYh1vEMiD/gEnJI8p
	 7ky+zf0jJaAemqTc+/u17UGZLc8ERoaBvZM0uxOueabhMjv8Uy1NTn2tbTMWcfon54
	 KWqIEMXhrjXXPor9zIxwrl6T+6KIIbdVJEbtUNDBxt+Fde3Mhv9CXRHp6CwItR9Y+X
	 iTRThiAeoQwUA==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with UTF8SMTPS id 910E9434A5
	for <op-tee@lists.trustedfirmware.org>; Wed,  9 Sep 2026 16:03:00 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fr9yx7Ku;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with UTF8SMTP id EECA4601EF;
	Wed,  9 Sep 2026 16:02:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1E2401F00A3D;
	Wed,  9 Sep 2026 16:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788969779;
	bh=fvpaif8SiWxOgwwNCHVu5uatFd8pM8O7cXEt4RsdiJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fr9yx7KuD6gJJ3pwJLcI1mMlIDce4aem0AHTM6I5CB4yG1ajj4hm6ji9PPSL2FcYx
	 trc1tIvAblHO634KnPmwSdr4Ofz9CEXL/ZiEpRHVZ480JUhhr3QwN6zbluW4VmiQb6
	 DH33xZ4HD82WnvyQhcgKCDlXTKlNANMD8zuGrNUs4QqTsUUBlNLz6lEuUqGB365Eme
	 rpGJviGTHqIIZBu64RNFbfjYhlT+IK30PxuEdX3qx/9PqKPWzCnHerUuINJxApJ5w7
	 VX4lIUU14n8TPx+xpGXzuLEFqKBxzeoH+mMW429y6rnX7q5mEAGIUwbtRpG9KhcduE
	 zrGUFMZ2hqD3w==
Date: Wed, 9 Sep 2026 19:02:55 +0300
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] firmware: tpm: Introduce tpm-qcom driver
Message-ID: <aqGDL2qZ0sZNMG0f@kernel.org>
References: <20260831-tpm_qcom_driver-v1-0-6f16fa6924fa@oss.qualcomm.com>
 <20260831-tpm_qcom_driver-v1-2-6f16fa6924fa@oss.qualcomm.com>
 <apbXKZrjFdK1vrny@kernel.org>
 <38984608-4b5c-4355-ad85-8c5a1fb78cb2@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38984608-4b5c-4355-ad85-8c5a1fb78cb2@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.00 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,gmx.de,ziepe.ca,vger.kernel.org,lists.trustedfirmware.org];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 910E9434A5
X-Spamd-Bar: --------
Message-ID-Hash: T5J5VZTCR4OGL3E5NPE2R3ZTOUYC2B7M
X-Message-ID-Hash: T5J5VZTCR4OGL3E5NPE2R3ZTOUYC2B7M
X-MailFrom: jarkko@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/T5J5VZTCR4OGL3E5NPE2R3ZTOUYC2B7M/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jarkko Sakkinen via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jarkko Sakkinen <jarkko@kernel.org>

On Wed, Sep 02, 2026 at 02:52:17PM +0530, Kuldeep Singh wrote:
> On 01-09-2026 19:16, Jarkko Sakkinen wrote:
> > Short summary has a different driver name that is implemented i.e.,
> > it should has "tpm_qcom", not "tpm-qcom".
> 
> True, let me make more generic like "Introduce Qualcomm TPM driver"
> instead of having driver filename in commit title for any confusion.
> 
> >>  MAINTAINERS                 |   7 +
> >>  drivers/char/tpm/Kconfig    |   9 ++
> >>  drivers/char/tpm/Makefile   |   1 +
> >>  drivers/char/tpm/tpm_qcom.c | 371 ++++++++++++++++++++++++++++++++++++++++++++
> >>  drivers/char/tpm/tpm_qcom.h |  82 ++++++++++
> > 
> > Rename it as tpm_qcom_tee just to be aligned on how Microsoft's fTPM
> > driver is named.
> 
> I'd say firstly microsoft ftpm driver should be renamed.
> For example, MS ftpm is based on optee(session based context) whereas
> Qcom tpm driver is based on qcomtee(part of same TEE subsystem but uses
> completely different mink-ipc based sharing mechanism).
> So, it's completely different driver compared to MS.
> 
> My suggestions:
>  - Rename MS driver i.e tpm_ftpm_tee.c -> tpm_microsoft.c
>  - Rename Qcom driver i.e tpm_qcom.c -> tpm_qcom.c

This goes for argument using tpm_qcom.c but we don't rename ko's in
normal circumstances (unfortunately so).

> 
> I see pattern like tpm_{loongson/atmel/ibm} etc. so better to follow
> this convention?
> 
> If ever need optee/qtee to specify, more namings can be tpm_ftpm_optee.c
> and tpm_qcom_qtee.c?
> Personally, I don't prefer tpm_ftpm_tee.c as it's all generic name with
> no optee specification.
>  >
> >>  5 files changed, 470 insertions(+)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 47b04968e79a..cfa5b66823c7 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -22636,6 +22636,13 @@ S:	Maintained
> >>  F:	Documentation/tee/qtee.rst
> >>  F:	drivers/tee/qcomtee/
> >>  
> >> +QUALCOMM TPM DRIVER
> >> +M:	Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> >> +L:	linux-arm-msm@vger.kernel.org
> >> +S:	Maintained
> >> +F:	drivers/char/tpm/tpm_qcom.c
> >> +F:	drivers/char/tpm/tpm_qcom.h
> >> +
> >>  QUALCOMM TRUST ZONE MEMORY ALLOCATOR
> >>  M:	Bartosz Golaszewski <brgl@kernel.org>
> >>  L:	linux-arm-msm@vger.kernel.org
> > 
> > this change should be a separate patch.
> 
> Ok, let me make MAINTAINERS entry as separate patch.
> Also, i noticed none of other driver are being even compiled as 'M' like
> atmel, ibm etc.
> Any obvious reason behind this?
> Should i enable tpm_qcom as Module in this patch only.
> 
> >> +	print_hex_dump_debug("tpm_qcom req: ", DUMP_PREFIX_OFFSET,
> >> +			     16, 1, req, req_len, true);
> > 
> > Please don't do this. It can put production systems at risk.
> 
> Ok. I want to dump some contents on failures which makes debug easier.
> Instead of dumping entire req/rsp buffer, dump tag, reqlen, rsplen etc?
> >> +static struct tee_client_driver tpm_qcom_driver = {
> >> +	.id_table	= tpm_qcom_id_table,
> >> +	.probe		= tpm_qcom_probe,
> >> +	.remove		= tpm_qcom_remove,
> >> +	.driver		= {
> >> +		.name	= "tpm-qcom",
> 
> Whatever naming we'll decide, I'll update same here too.
> 
> >> +
> >> +/* dTPM SPI transfer optimization:
> > 
> > Block comments AFAIK should be
> > 
> > /*
> >  * <TEXT>
> > 
> 
> Let me fix it.
> 
> -- 
> Regards
> Kuldeep
> 

BR, Jarkko
