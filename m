Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E40FACA5FC4
	for <op-tee@archiver.kernel.org>; Fri,  2 Oct 2026 14:59:34 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id F0981454FF
	for <op-tee@archiver.kernel.org>; Fri,  2 Oct 2026 14:59:33 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm1 header.b=dNcx5gqJ;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=CdT5+EeY;
	dkim-atps=neutral
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C96F844A45
	for <op-tee@lists.trustedfirmware.org>; Fri,  2 Oct 2026 14:59:26 +0000 (UTC)
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 36B7C7A00F4
	for <op-tee@lists.trustedfirmware.org>; Fri,  2 Oct 2026 10:59:26 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Fri, 02 Oct 2026 10:59:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790953164;
	 x=1791039564; bh=/RBlyfe1Mgv6R04PMaBhoX6CHFIp9V+NLKVrO6k0p4o=; b=
	dNcx5gqJvNk4zRIgpqFFiHT5EviIY+Fl3qLxYv/KpkQh9EZFW/Z+p6W4OZXxs6Li
	t1EVUxT+qs5N2F78XrA8BA6SadyzgP2SkTJdQriVMy4phzSrF/NTCw3Zet7a07MT
	cUNjepOSBalXFwc36FRTlYI86oQFToauoOCJ1vlkF+ZopIxo3X/BaG18+1TfTcAo
	QTb0tYWOqbAYus1RrT7O/3BzFsE1cPbOZ7/AkM6y+ROYgbVa8G0HbaEbzjg7K4zt
	2LhV/0HVQAArlDfpZ/hdrkU+LElLGMnZDjj21OjCkaenD9TFO65KxeBex2vp/wWl
	596HfRjQMBt+8F9bvawCZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790953164; x=
	1791039564; bh=/RBlyfe1Mgv6R04PMaBhoX6CHFIp9V+NLKVrO6k0p4o=; b=C
	dT5+EeYK3932VO9mXatMUlbKm0ytctxOb9fkiMBT30IzlQ3RftWKR7pHJu/R1QgB
	90dKyteOHzwg3e6meGnJ3qq17E/Gs82OCeEM5Gy9Wkzvf2gX/tXmZLZ6Pio4AARf
	EHyd1fVz0m5aftWURqJLSdwwoDugADoB0PcIJmkxgpngqaIfo5coKErIy6e3xveQ
	0i1Dc2YCu3C8Nb968+QkK9M9mdQ/4SQPNaoGUvxImxP7VRCnD7X1UjddquwDB0zL
	RHwQFT1ADf9v394m9wwrfFu3VMEF18zwE1AyB8V4o/wdPU5JdmqqybHT5mUeDFpw
	u6Cd4YcliFiiusGpBXhJQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790953164; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PG9wLXRlZUBsaXN0cy50cnVzdGVkZmlybXdhcmUub3JnPg==;
	s=fm1:rsa-sha256:MBM0+8jUuVfA08DWmaDrdC5znK/ueAVpbCP7eMUbpOxXrQb
	em4atvVpNwzgiazzdmVp3fz1WPOp8bzC340N1ZVas+WENSMQIflGBUV9kk86AuH4
	Js/pxrruCmbTIRW3ygsMd6lLTQF1iKTL706gch/iQn7g0DkrrAKPqhgzsXsM5JqM
	BPb+HOn/YiGh1TIdnetgkuJ7DmV88hyFsLJ5St6uovq8uBupt7iQzQmYb/kBfMM4
	EgSG40gn4eSZb9i9X9pQEjwlyZquF/J24A8s8zRqlZGv/1Ur0hDH7VsKLRpsJ/WY
	lCS6+4aoBRzt1pAWGdv/QBUEYdAb1EW+ArWrFFg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:2Ije8LP0WNR3wslYmdZ2aSayPTYymwLvGkBMtGd9SKU=:CF0W5d8WeMXiN28AAdFuRXYkCxdYb/VESvohxnVUgDQ=;
X-ME-Sender: <xms:yca_alaF9rSJz7a16Gya1srH6SOi1TFFn3X80V39M99sgDDtSJfr0A>
    <xme:yca_anPdmOMJo-MVLEMbDocaM0vW1EW8Y5mjxmRtGqSI7OOXN7fbJgWNy6EDYPaiX
    sHeyzTQiV_yci1dlt4pybU5sAjUyjq3CXwi8L-MykJSJMk9Eva35Lw>
X-ME-Proxy-Cause: dmFkZTFXVycTGfb7P92y2Ed3FrEYP/S3kozu0kL1Km1AmpmUL6OoqPjQAk4qD8SiLnDMPN
    O/OiP/NiYyzc0jDCuqskm9R/PeGNm0WgUEgVqVcjR66BxEathivYnSGG6G5EhpDV2LKNtK
    MPK0p50NehCpMsepnk/SSraY+7Q+FWyfoxRkbLHZHH+RQdPiaLVtGaNfysXoF3tVR9wxup
    QQxsTvNMK2H9KMR0vJ++4xoS7lOpeAcPN/hYGWTJRnOx6gHjdIEp2utK27NgNZ3ArJJahm
    ROz16KAXDODxvtiyKljvHe9XX7i2lZ2a/ghkfKP3HCsUrovqYmG4IjcEC6qaP5jTbJ4pXX
    YnrZDNb6cZr252SrkJrGzBn3LXxcP53jW1BCUCVXhVhnapO42jZ/g9WQKTxDpTMrAHP5Hc
    jR3oRVi7jn2irwtQ+u4l382bB2DUDe9P7MaPj7FH0d7sTxqkdIHf94voLvOXNwnC31VNXD
    tmlPZ9BWdesVzaLeVKromEnsyl5IZtDMPJVIILCPV8X1VjqSbZR2UTNJO0RjsJIGeJuhH3
    VigUBPcDd/YwCt5gp9uJ6kwdquGDAOYQJR0baX6DEFCIYpwKd0vs/l2V7+U3C+ZXiG8Q05
    YWrVqIWZ7onqR3mQwgjHJtsm3oOt5Zqw7gwJd4kbJPAU0nPQ8WfoYur1OZhQ
X-ME-Proxy: <xmx:ysa_asNweVpvIzWX4u4WHl7K6DgrNmKR4ODO2Mwyvu7ldLY8fYbSmQ>
    <xmx:ysa_amp2Oab9AQd_fidORZs4A1wqoGFehmC8AF87eOhruKooQo7_Tw>
    <xmx:ysa_atEBVsVhtdxTGKn65oTOs9BwY5lCD999C3SEPPySwMHEK1rM2Q>
    <xmx:ysa_arr72RnNUV5kcGoNKibzFhtty2UmxCDVJM5AQfsiXI2WRbb0Ew>
    <xmx:zMa_aueLglEDvQvUXRiUOQQqTQLonTZOJEWIak3QfOe8FFLCndJ-E8pZ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 2EF0A32A008A; Fri,  2 Oct 2026 10:59:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: Aw6mAajFSntB
Date: Fri, 02 Oct 2026 16:59:01 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jens Wiklander" <jens.wiklander@oss.qualcomm.com>, arm <arm@kernel.org>,
 soc@kernel.org
Message-Id: <84c1dc64-6380-42e6-a501-9be86666e5e7@app.fastmail.com>
In-Reply-To: <20261002142443.GA778834@rayden>
References: <20261002142443.GA778834@rayden>
Subject: Re: [GIT PULL] OP-TEE fixes for v7.3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.09 / 15.00];
	BAYES_HAM(-3.00)[99.98%];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:202.12.124.128/27];
	RCVD_IN_DNSWL_LOW(-0.10)[202.12.124.158:from];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:151847, ipnet:202.12.124.0/24, country:AU];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_BLOCKED(0.00)[messagingengine.com:dkim,arndb.de:dkim];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C96F844A45
X-Spamd-Bar: ----
Message-ID-Hash: MMCREURKKJYZZGAB4YYYK6MTCRKGQM2V
X-Message-ID-Hash: MMCREURKKJYZZGAB4YYYK6MTCRKGQM2V
X-MailFrom: arnd@arndb.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/MMCREURKKJYZZGAB4YYYK6MTCRKGQM2V/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Fri, Oct 2, 2026, at 16:24, Jens Wiklander wrote:
> Hello soc maintainers,
>
> Please pull these fixes for the OP-TEE driver in the TEE subsystem.
>

Hi Jens,

I noticed that the contents of this branch are not in Linux-next.
Is this intentional?

      Arnd
