Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B4ECC6B0E
	for <op-tee@archiver.kernel.org>; Tue, 13 Oct 2026 14:54:08 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5421A4528A
	for <op-tee@archiver.kernel.org>; Tue, 13 Oct 2026 14:54:07 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm1 header.b=T/YTUYjH;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=pHokbt07;
	dkim-atps=neutral
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C629241BDD
	for <op-tee@lists.trustedfirmware.org>; Tue, 13 Oct 2026 14:53:48 +0000 (UTC)
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 167AD7A01B5
	for <op-tee@lists.trustedfirmware.org>; Tue, 13 Oct 2026 10:53:47 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Tue, 13 Oct 2026 10:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1791903225;
	 x=1791989625; bh=IqGUDxkJK/Ctx6Y9jMVypDVuJ2SPUzmMYvhwUQxto48=; b=
	T/YTUYjHPAsj+3O9tQSEYZ0oovefnCISsE99tHdBRgfvZIMI09+uedFJ53GUHigS
	cAPkFuW5uMqtOAnV7p2cg+jysE++lsmmZ2KMnX6hFjlSzsc3MmPDfMLIV9e4S7Xg
	VMkOQEjy8Q1V8WCTC4XJCFsg/WiSwzOrEw0gwBeF0SqzSH67eSu2tjkbvnhBmKiy
	MWz4LfhO/8rI2HzUoa4a5PmiJ8Cl3Upob9vJUWC+wMOzMsByGaQphzqyHgeXhbMd
	NryxmZUQ/pe6OmsiedviDzbGRg/CN6sBH1e3HrMpSLWBvPQDV7rdsbJyJKGP/gaS
	f42GzoNl63VcyJ8ufVhEUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791903225; x=
	1791989625; bh=IqGUDxkJK/Ctx6Y9jMVypDVuJ2SPUzmMYvhwUQxto48=; b=p
	Hokbt07NkeiStaTC7tMwK/S3o+ZRiN5onMZV69kOCxBNjcqoPvyujkT1ngYlbA8Q
	n+eUYOaMOHxdH1+U8SFO+hh5HVYqRR3UcTOzAqnC45UdMq/ZN+5kWqMtGPZJTPcs
	ZYlgU7H7m5WcsDcSbY/Y/HGKF2uEqJkXLt8CSuTJ1iPffUatXqLwIIJgekzEI5AI
	APvI6hJ5XZyKxijR8ZREF67/WteZ3tTzKRGbepFKq1TT9T4Dl93bXpSLlvY5uaSG
	x2ZAfK8NefEsuayQMFqIH1vvjl8TRc8gzbFIrUczYLLpkr8IwG6lV6L8TXzqXHSv
	tz8mtjHzKhSJssXgHh1Hg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791903225; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PG9wLXRlZUBsaXN0cy50cnVzdGVkZmlybXdhcmUub3JnPg==;
	s=fm1:rsa-sha256:IIwwIVuzaLuTko09sXyJ57BOOMDvC7Bp4xLFbQccTxtt/6/
	d1pm9krhw+N6MIIwroHQ/OLbSKh7SxIoplXNAcyLXv5tPqgiSzfydBezdeLDvLNU
	0Q0vh2hfWGy74ex67GqJ9IFZqRbQoszVwcqKaS3kGF8gGRtGW0H6eN4Xes/XsMmR
	8EsnTy+zcpV0yBr9SaEEsOk+r+OCjgHtzNIhUFvydj5z/6bvEQW1av9XB4ZRqW/6
	G7Ewhf9gHmtLuz83BSvPpehnhKVALIZov0wTGZyfp9+RybB3pddpmNZ+r/FEBTfI
	RCy5vbd2G7DEIrRbyJKpECd1dt3NhecCC2Iug8Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Nq4GWnDkta2MoPdmShiTmeNLhGp7xeath2FtNV66Nio=:W/Q6dOnZvYi9E9Mv6/PVFTMVdV+MfNQHtWRO9HwIX6o=;
X-ME-Sender: <xms:9kXOao5_AwoCAJPgRCTflHjP9DZ22-pxp600o70J_M8t3R-ijX0_4g>
    <xme:9kXOaku3jf4c-hL67eYCYsqdP3Otc6An5I8-l4fmEPxRJlngjKZjabWF1bLzf07Xi
    tDhbpes2T4GN7AFaV0QqTXg3R-_uEr1Vpk8oZ5C6RL3Cf6oui8efonXTA>
X-ME-Proxy-Cause: dmFkZTGaUJ3zbGnrOPZpOzd/IP+K0M72eNM826j+SoR+A/LV9dMLehrPwl9uzrHl5B6tWo
    FGpZdGxxutJaOFFdC9JMqM4TdwzgV81s5Cq5d3owtow4KJalTKGuLJFD5OjO3YKogaS00D
    kOJdju1cGLmF/ouJQBsMUiUo+2rujY+bMKq8i797Que4dXvvXco5FjPsTrUC212BDur+Mm
    MUn9xhlKBmnK4QgTyzv2tQN9kynMALqlaIaN8i6GQ4sOZPDww/0PfwIKWKUX/VyiVHopdW
    ug44LJH6zVe+l4VF2NKF09AHTewPdjaN8fAsu5JDdAejt3rHRf15KH0n8xjhhexdJL3yiW
    UkU0oV00Er716KqjaKiVFhgrsL4IxGk8YfChoOnR552MZHo6vTl7n9vCAcjKEr3cJmfUGP
    D3YuP94fiB4IOBSFvhZRiPjkN+kyB7YBnrn/HvDYOSeQaDM1D8CVIjcwuW7f3tOmXT1p05
    etE0cJMogqc9Tm8Lq4l6M+9uWoEtjxI7xidbVsxc/pFDq3y/o6AB24jBjbXcUY/P3KGlTk
    FjdPICQjl2Fo7G5YITGjF9ShZ6QVVDUjXHJsyHoC66N0XwH5NhD5nFIzpe+JY8hm734cW/
    DGBduuhV0zWu9ecBDU62ns7cbNL0F71ImV7WAB+v/By4feVcrWaUjZtEXusg
X-ME-Proxy: <xmx:90XOamxaL7MD1YAHGaon-TTZpbsD_QlDE8bn5R2yMSOFUljWWMENDw>
    <xmx:90XOai_2pWgrRp9Is_ZSMf7PflSlJzvU5PzSDviz_hbUn6gETIYueg>
    <xmx:90XOamjg4KY0XQNJNrndweESQ9HwPeY_yx5_AHxdDuFXV7bSUf2ymw>
    <xmx:90XOahFcinmFlk0DF6ffiweGLsaRBDcWebI8P0yJ6MNtyyNyf7ISPA>
    <xmx:-UXOav84Vkaxekz2MBVQvOMNGopqdjzUas4NjgKRrC7VbXnhOT0B4FU3>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 704BE32A008F; Tue, 13 Oct 2026 10:53:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: A_NvT-8FSIng
Date: Tue, 13 Oct 2026 16:53:21 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jens Wiklander" <jens.wiklander@oss.qualcomm.com>, arm <arm@kernel.org>,
 soc@kernel.org
Message-Id: <522a2d28-2ac9-4a56-8a61-477be3dfbbd9@app.fastmail.com>
In-Reply-To: <20261002145140.GA784348@rayden>
References: <20261002145140.GA784348@rayden>
Subject: Re: [GIT PULL] OP-TEE update for v7.4
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.99 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm1,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:202.12.124.128/27];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	DNSWL_BLOCKED(0.00)[202.12.124.157:from];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:151847, ipnet:202.12.124.0/24, country:AU];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[arndb.de:dkim,messagingengine.com:dkim];
	RCVD_COUNT_THREE(0.00)[3];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C629241BDD
X-Spamd-Bar: ---
Message-ID-Hash: 5OF2NOYHQMIBRF6N5UNTFHIDGVYBBH34
X-Message-ID-Hash: 5OF2NOYHQMIBRF6N5UNTFHIDGVYBBH34
X-MailFrom: arnd@arndb.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, Marouene Boubakri <marouene.boubakri@oss.nxp.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/5OF2NOYHQMIBRF6N5UNTFHIDGVYBBH34/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Fri, Oct 2, 2026, at 16:51, Jens Wiklander wrote:
> for you to fetch changes up to ccd4b23398acaf2139cf04f1ba0a66150cbf2663:
>
>   tee: optee: build the Arm-specific code only on Arm (2026-10-02 
> 16:28:41 +0200)
>
> ----------------------------------------------------------------
> Build the OP-TEE driver's SMC and FF-A code only where supported
>
> ----------------------------------------------------------------
> Marouene Boubakri (1):
>       tee: optee: build the Arm-specific code only on Arm

I had a look at the contents and saw that it keeps the
IS_REACHABLE() checks that are notoriously error-prone.
E.g. this part just looks broken:

@@ -257,8 +266,12 @@ struct optee {
        const struct optee_ops *ops;
        struct tee_context *ctx;
        union {
+#ifdef CONFIG_HAVE_ARM_SMCCC
                struct optee_smc smc;
+#endif
+#if IS_REACHABLE(CONFIG_ARM_FFA_TRANSPORT)
                struct optee_ffa ffa;
+#endif
        };
        struct optee_shm_arg_cache shm_arg_cache;
        struct optee_call_queue call_queue;

The presence of the 'ffa' member in the union is conditional
on whether the driver that includes the header is a loadable
module or built-in, and this changes the entire structure
layout if both types of users are present.

The intention of the patch does make a lot of sense,
but as far as I can tell, only the Kconfig change is
actually required, while the added preprocessor checks
only make it harder to read and it should have been
sufficient to change the existing IS_REACHABLE() to
IS_ENABLED() for consistency.

Sorry I did not notice this one earlier as I was travelling,
but I think I can't pull this version, please respin.

      Arnd
