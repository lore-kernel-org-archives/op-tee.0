Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DFBC55172
	for <op-tee@archiver.kernel.org>; Tue,  4 Aug 2026 07:41:14 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 60A5D44FA1
	for <op-tee@archiver.kernel.org>; Tue,  4 Aug 2026 07:41:13 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=JJQ7XM5F;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ecyDkRPJ;
	dkim-atps=neutral
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2F72944E84
	for <op-tee@lists.trustedfirmware.org>; Tue,  4 Aug 2026 07:41:04 +0000 (UTC)
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.stl.internal (Postfix) with ESMTP id 456C71D00055;
	Tue,  4 Aug 2026 03:41:02 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Tue, 04 Aug 2026 03:41:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785829261;
	 x=1785915661; bh=KGGQHbz86WfZhmpyZv69QOpRbk9xCtxeaYn7y/ipLaE=; b=
	JJQ7XM5F82UHROiWJLyRJ2fZnBdArOg5gNUclvsaunN4pd83JJhwKpzW7/7khyIG
	3F8zhOjTXT2Tw3j5/Tj1CvavBM9bRbH7bKpONisxE2BpgQmF8EjN7fvPVeJiAdGm
	GRtElnvSyucznNryFC4nEX2ALaWZ4eSv9i6yijh8OibNbyBceGfFGo12D3Cs0WVU
	aEacn6bBj1y6XnOUo6irSEMNfn6nNU0P/Nen/+0EaKAMOGl9HnruxoAlCYTAncDv
	dtZfKn5SkSgidq1Vr6K2yCdgphoIb4rM1lWjOU+TRn5BDu3UMIM8ob2n+hbEcg0V
	qou8I9+jd1p2RwT5hz4hZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785829261; x=
	1785915661; bh=KGGQHbz86WfZhmpyZv69QOpRbk9xCtxeaYn7y/ipLaE=; b=e
	cyDkRPJiNLMLqK/jkgjF4sCX0uD0DzdezaxoFo96VZUZyUUU1WpdrLBFEbphmRlP
	1vIqhc/XIlH77+/kfTVpO8xybkQBjCAIoDOLhhKOIEcHUQwHK88Id7jppQ1clO+R
	MlbSC5ChBfFNz55ToQW1Wv74n6iLjpLCIIIDDwGOBKOn7PY5e8ITBCGZbabVX+aE
	9jdG3T1C94+j/p1ihYmeNqOo36P7nzzvNuexVuCjFxRoFvuz538RV2zpLGUTmJma
	HgcOkdbTqkf63paEDYtPIPrIBYMev13g7gStoM+V9QZUqXNQMCtdnvKz/x4fJsqx
	seHS9Jsl+DZl+lVK1thmA==
X-ME-Sender: <xms:hpdxasu0KollTCnBgE1EXgQ-yyHZCUszMmI3X3oXrudFQKgJZ7Fp4g>
    <xme:hpdxakQwUFZ6Rrraeu4TdUHa4RCDSNplPGfokXzx9MxZH6fpuWC_MeHXpQpJMLZg1
    eDeEKqtZ2Ocl9obT5qATN7QmEd_COpgvW4L-7YgSdPArke0DKHAUcs>
X-ME-Proxy-Cause: dmFkZTEzTZ0dEQDntje2aWKVKMF/6GWdKabltgrpvlRKhPYwOLLxQpm4DTkTDkzcrKtljj
    GOyJHZJJ6Cjydn7qGkYPSk+gZclo56OrUbHxfMSDYp85YCnVGqmBbcogw14sdAqfBshS76
    K7n7UbtDCsppLJXjtF24wAgl/uE2ceZS48dKmw796GCuT6iOOECj5exxPoKmV/Z8xl8+Wj
    Zi/J17Dgam7IPGpPYig32nY57H/dRrzfws7wDzODAxh+z3MHAcNeeEFuoaIG69jmzwRxni
    whfZCcVKDjk0xOmJIx9fjVXhgh0R+pAZiVm894BItgMQLTf1kFEIGXsa7C5tVnZ+R86uP9
    PViPEMytrfGCewL9s1ILxshSbWnCougAmiTUSelU/hihDh6+91xOolbkmm2vG8uRD+QiGq
    e4hJtZ836QoD3NQ3/44X5UeZdRckhrA76DQ4awlmq92qo3Ybw1iWnWQbNe4tdAD50Y8Pn6
    R0rVtevQR4CZ6sFNBYbjdyiCtgquCV2/64Txynr9H4167TUSExl2TFu99cYC0n5qGDtUbS
    S9kEiUZdl9oObkFnsfqf2bLMe9+GG0S0zo+UT9nu+KexYk9G1Xn7dVKewDjucT4Yi+nWLa
    v76K0q1DkMEWuVer7tqN5g2ss9GWxBJOzpVL4Tx6vmoQExtSTgJSCLZCN2hQ
X-ME-Proxy: <xmx:iZdxaptSf1PYI7khll4bcky-pyWIu0WJhbjZREThpopolqC2dS4ARA>
    <xmx:iZdxav9QP_w4WIbyYXX02oCxcMy7fndrKgXzCV7LXgocMWtWl0P20A>
    <xmx:iZdxavaJlLTWjmMwM3LtzR89mQpHrI64GZX9i1JA019H2M21CCKHoA>
    <xmx:iZdxaloPcaHVDyjqR2rgk9Np97quTLTP4fwZBbesMbSWy6W_VD9HIQ>
    <xmx:jZdxaml-vHqIGsPGCz62PunWk2ghw7NMTY5tqmjn6Hepb-XF1ewGBog1>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id B559D32A0066; Tue,  4 Aug 2026 03:40:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: Afr29kaEQ4co
Date: Tue, 04 Aug 2026 09:40:28 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Amirreza Zarrabi" <amirreza.zarrabi@oss.qualcomm.com>,
 "Julian Braha" <julianbraha@gmail.com>, jenswi@kernel.org
Message-Id: <a2c4c420-d7df-4fad-a952-e77192e1822b@app.fastmail.com>
In-Reply-To: <63cfff1e-359b-4db9-97a8-43d97abb0369@oss.qualcomm.com>
References: <20260729203845.387239-1-julianbraha@gmail.com>
 <63cfff1e-359b-4db9-97a8-43d97abb0369@oss.qualcomm.com>
Subject: Re: [PATCH v2] tee: remove TZMEM_MODE_GENERIC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.14 / 15.00];
	BAYES_HAM(-2.55)[97.97%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm2,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:202.12.124.128/27];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[202.12.124.149:from];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:151847, ipnet:202.12.124.0/24, country:AU];
	TAGGED_RCPT(0.00)[renesas];
	RCVD_COUNT_THREE(0.00)[3];
	DWL_DNSWL_NONE(0.00)[messagingengine.com:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,kernel.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 2F72944E84
X-Spamd-Bar: --
Message-ID-Hash: RRPPNZQ7HNZKTRAXRIJWCF7PLAXTHWAO
X-Message-ID-Hash: RRPPNZQ7HNZKTRAXRIJWCF7PLAXTHWAO
X-MailFrom: arnd@arndb.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, amirreza.zarrabi@oss.qualcomm.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Elliot Berman <quic_eberman@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Harshal Dev <harshal.dev@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/RRPPNZQ7HNZKTRAXRIJWCF7PLAXTHWAO/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Tue, Aug 4, 2026, at 06:29, Amirreza Zarrabi wrote:
> Hi Julian,
>
> With this change, is QCOM_TZMEM_MODE_SHMBRIDGE still needed?
>
> I think QCOM_TZMEM_MODE_SHMBRIDGE can therefore be removed entirely,
> along with the conditional declarations and stubs in qcom_tzmem.h and
> the corresponding select in the qcomtee Kconfig.

Looking at it again, I see that the patch does not actually do
what I had expected. As you say the option no longer has any
effect at all, when I thought the tzmem driver would just default
back to generic mode without shmbridge being enabled.

What we probably want here is to change it to

#ifndef CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE
   ...
#else
   ...
#endif

to keep the behavior unchanged and just fix the Kconfig logic.

    Arnd
