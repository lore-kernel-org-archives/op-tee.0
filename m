Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840C0CA9ED0
	for <op-tee@archiver.kernel.org>; Mon, 12 Oct 2026 09:17:59 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A7E3445217
	for <op-tee@archiver.kernel.org>; Mon, 12 Oct 2026 09:17:58 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm1 header.b=iDT5rFMt;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=W35bFjKf;
	dkim-atps=neutral
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 99BA343EE6
	for <op-tee@lists.trustedfirmware.org>; Mon, 12 Oct 2026 09:17:38 +0000 (UTC)
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id 03461EC081F
	for <op-tee@lists.trustedfirmware.org>; Mon, 12 Oct 2026 05:17:37 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Mon, 12 Oct 2026 05:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1791796656;
	 x=1791883056; bh=GJY0qHfhdj9lHENat8tBveKPiLmpddTE5X7F/5JKHlw=; b=
	iDT5rFMtIABrxoUiQ7QdTflV2Ff5aTe9/kl0gz8FxvlMRXhSCtvg0XODUpvSSQBY
	bIxXhN+ESwc1ha5UTyuTbvgHnNpQk9GxGfrZAQm/Q9FziZ1/uEjnB82aPeAAo0kN
	Jbp6fTeO4BiVPAOmALuYg+IZffqUU53zZdwnQ5tiB4kBE4sSUjp6Dt6//Mdmc2qz
	xbOyBN92z6QWX/hasYtUhmUa0E6a55Zf8aK3lTcmX8+DZPXNXQEdtYDAJDql8ygX
	ULPfzQos4UQv+ixKuKw4mhKstyiKuvrjfaa8IBUCXStS5/z+ZnDE2qE/69TC37Bg
	3K6z4bzb3Gls6LRebiYs3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791796656; x=
	1791883056; bh=GJY0qHfhdj9lHENat8tBveKPiLmpddTE5X7F/5JKHlw=; b=W
	35bFjKfIiqWzVZrMg8n+HWt9LIaMj5y3vow0bSbYfcc0N8X/uK4OSnZw/zyzjY85
	CVdhx2VyTwzpLEpepAXnw9k2UY7VFVsV3VLpwjcB/9O2FAG6sJpFMfzN9a++upPP
	Q4fIWds2d+2cRctOcVEY2OCgHudxzQclvl+w/Mt81/jGI4Vrgu1huNqS2I8zpNSZ
	ltPt+7MyTMauMJIfxLdDMdB5bBmGEcpcQXr0U2JjCb0cs/YfEJN8ycGtfYbrLzPE
	26WA3ShAn3OG9VJV2QOlNZGqAKtsy0hAoA+P1XlkdfVWukDvILuLHtTIA9nQAUxX
	MND6piYESn/pctuaHBmkQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791796656; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PG9wLXRlZUBsaXN0cy50cnVzdGVkZmlybXdhcmUub3JnPg==;
	s=fm1:rsa-sha256:Z1Tq58MNvF2MIDWx7gkjqCVlb+Uoz3kiFpHNaVUyH7BKeOf
	otkpHI+kEj/TJoufa9FFuNN+ie3PtAhph2Fuk9a75Urqy253hHRcKYZ+NwF8yl1C
	Hn91XRmnDzv8ffbZxRkNp//zzR9wJ8dr3zeO1GiWmp/4ZtLDOmjDby1Gd/v/mJhf
	N4mnlEEKi+PZ8SO8GZAAzW0oqF7g9bR8U3XKq3dkOQjkMept3PugPWDFmeAnGpV7
	HXij86Mw1g0hJEqHo9EXtVq6Pn2qXjeu+Tu1E+EHQkV3/JwyJk9NIiqw0F0GzBie
	s0qyvxpeypUiu7Lef3XRpIW+zUBWEJwaBDg4VhA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:bVtpMSKtpLhAe+mMBBoQbWPIbks4fgup1XAJvD3vbco=:vvu0r8CNgLquCqjXc2EUudX85AHvSHWoKB7SQGnc4io=;
X-ME-Sender: <xms:raXMaozfnJWk_rRv2n0uzJiOVbUB5WZq7bgXZRTChT4xLQ3R1N6AnA>
    <xme:raXManHKQf0exSld_99MEYoRwfOzXPUu4ZzDIZ26bKWLUWrbVPj2DV3a7vdGkDcKk
    TBY7CN933x-CLFE0SDRvEMpxhIzA9jvAPPXmAjj0Ayt5p7A-vxrUwB_>
X-ME-Proxy-Cause: dmFkZTFrHEGwKBdVR8IwyDUhNgBLm/x6Ectrg5hjHEv4JpB9TqYBiUC4MIz/WeB/VY+cav
    bPTsUM3S7qwhTFTfV8wWYPu7WnJ/9SVdOg/ka9qBCp9p8r+/Ps3fHFlTE1M7H80I11Mi2K
    hFYAqlQep0Z2JoB0Q6mut7vLvApSpCXTxDx6Ld/9VH/ErXV2gMCrz4TNnfXy5k9qJfw34e
    nY5VTAt8Cf7w+d7m/8+HQM4omRGrcopizMeaD5fTkJjEH+Pid/kvF9V9R87faGzSpFU4Ey
    mPnF9KagJocqP6aLsbL1Rb087DI7j6rbs+k8YEK4gkIpo3+d+zQD1/PNZc6flKvtoLERtm
    IpDxb290wPo7UZ/ZnQPV8EQIstcOYP76q6FDIoSWNQdUBXWfWokrwWSd5Rqd7JdN7NAwNd
    0dyX/gisWLWv7ye2UhF696VRVx+R2fxqARHS5Isvj+I78Jt3XQlwApw0Wyd9oHmz/W5J5V
    tDQaoft1Ky6Y/DGu628KNGev9NdHVksY7rH+6Sdh/XVJHKl8+sAG5mACwBXsLt9aLsQxrf
    nH4Dy33QhCcoOH3ekNTYcELNc3uhBpGcbwweOfsTVKb4F4S66Cd0l5hxGkbYnZDvD/I7+G
    ryBljAMjn+lfH985e81O9hCBLjHH0jhj2mFHoG3ti0+dPi5iz3WdrnQlxr0w
X-ME-Proxy: <xmx:r6XMakkke45n4IRYvHAofzWv47KztiwMtx0P6hkjYCCbHL9Ki8TbZw>
    <xmx:r6XManhKxQU7R-Usv3JT8lK-DnsRMBiRB9cj4mGYz_TKWgKlKPGzLw>
    <xmx:r6XMasffS7WYDmJbsRdsoVjcnkj3OucT7u3v38Nz7NCwV_UbqDd6Bw>
    <xmx:r6XManiBvB0j6rqLAOagmsSbGvkFMPKm4mDKqaj8C1Mve6uiPqMAkA>
    <xmx:sKXMag1JNXA3QvxkXkraEhiRwg_RGFjjf4R7G8pRfkoDDk9M9PAVatDC>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id C253632A0093; Mon, 12 Oct 2026 05:17:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: Anz6JKCoHeJg
Date: Mon, 12 Oct 2026 11:17:13 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jens Wiklander" <jens.wiklander@oss.qualcomm.com>, arm <arm@kernel.org>,
 soc@kernel.org
Message-Id: <8f4ca3ff-8a71-4ab7-a442-9ba38ec74c63@app.fastmail.com>
In-Reply-To: <20261003144629.GA929824@rayden>
References: <20261003144629.GA929824@rayden>
Subject: Re: [GIT PULL] TEE fix for v7.3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.95 / 15.00];
	BAYES_HAM(-2.96)[99.85%];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm1,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:103.168.172.128/27];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	ASN(0.00)[asn:151847, ipnet:103.168.172.0/24, country:AU];
	TO_DN_SOME(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[103.168.172.150:from];
	ARC_NA(0.00)[];
	DWL_DNSWL_NONE(0.00)[messagingengine.com:dkim];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[arndb.de:dkim];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 99BA343EE6
X-Spamd-Bar: ---
Message-ID-Hash: 3Y5IJQE2NSGMNZN2O77Y26OCO6WE5Z2S
X-Message-ID-Hash: 3Y5IJQE2NSGMNZN2O77Y26OCO6WE5Z2S
X-MailFrom: arnd@arndb.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/3Y5IJQE2NSGMNZN2O77Y26OCO6WE5Z2S/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Sat, Oct 3, 2026, at 16:46, Jens Wiklander wrote:
> Hello soc maintainers,
>
> Please pull this small fix for the TEE subsystem. I've only had the patch
> in linux-next for a day, but it has passed my local smoke tests.
>

Hi Jens,

It looks like the patchwork bot missed that I merged this one, I have
now marked it as mainlined in patchwork as it was part of last week's
pull request already.

     Arnd
