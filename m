Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E26FC98328
	for <op-tee@archiver.kernel.org>; Fri, 25 Sep 2026 14:46:14 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 82724452F7
	for <op-tee@archiver.kernel.org>; Fri, 25 Sep 2026 14:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790347573;
	bh=p0PFFd8yXsrlXtWAvwAzBFeHxCTI3rh2mZPNKGMNyck=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=IY3khaEY/qUdQyxu/a5459ZitpTTAAluy0nWPl9vDJ58KDc6NqdgG+eS6lkHSkuvU
	 sQnupmd/tDI3UqiFSB8MhmEP9PI/gjmMJ1BNOBaWvwb0UvBAppz1WckvUt9caF5wI5
	 Sv5Be1cnUrA1fok4BBjpl4t/M9ucCt2roENe3Iubp3L7nslEPDDdm7/pi+psaFnTXr
	 ZDHf+Elx+ARYqbX0qC7HNDlAPkC0q0zBI6G1JcK4TzPLnpTDFalp7VJAJtB+WZLzF5
	 v3rgI0Ww9wfDP8OXiOqVxLmPgLyNCGBOSdm//f7bW50Ga6uDg61nsdg7wle9NUG0t3
	 bjvGutCnDB4Aw==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with UTF8SMTPS id B3A2544445
	for <op-tee@lists.trustedfirmware.org>; Fri, 25 Sep 2026 14:46:06 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jpZZ2kDJ;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id EC5BD40747;
	Fri, 25 Sep 2026 14:46:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4CA8A1F00898;
	Fri, 25 Sep 2026 14:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790347565;
	bh=H1vHhX67qXhb8YQtEjUFRBlito2qAR/0NOGcmGalPZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jpZZ2kDJ3MPp7sM2WVzltrEnf/B+tmv2NnkZyELjRTpbmHjy3w6N/gsTDkdg2zyCK
	 MLI8hHiEis1XBJyJSRRQt+lZdZaVBf2y1QQsJNl7ioz8T8CPki4H0awihS/w/LK/9y
	 vl3T3qOwN8hHs+FKNZVpNYFGe1iD0rn6Zf6l1EVpanJWHne2Jpbpn5OI8e/QGOCUoF
	 LJNilz1jR5PbtsPZbv5XdF+cKDImO9duT8xGOUVesEE4DlayCRoce5NwV+AM4oGhbj
	 AaGQ/dGEvDOnjN3Je0VJt8t2fJDxp3V8AMRLHs1gIFrxsZoZCuB5xiOZxCXRr/msKB
	 5VfSiIwSWuuow==
Date: Fri, 25 Sep 2026 17:46:02 +0300
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/3] Add TPM support via Qualcomm TEE TPM TA
Message-ID: <araJKqHdeXstD7nR@kernel.org>
References: <20260907-tpm_qcom_driver-v2-0-71a6b1752da8@oss.qualcomm.com>
 <aqyZtHynb2nuQT-P@kernel.org>
 <d555ee76-3999-4ed0-be6a-ca07354af6d4@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d555ee76-3999-4ed0-be6a-ca07354af6d4@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-8.73 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-2.73)[98.82%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,gmx.de,ziepe.ca,vger.kernel.org,lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-0.999];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[172.234.252.31:from];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B3A2544445
X-Spamd-Bar: --------
Message-ID-Hash: BUMQ2SPKBW3F4OTXDSGN5LP4RYDRWYW5
X-Message-ID-Hash: BUMQ2SPKBW3F4OTXDSGN5LP4RYDRWYW5
X-MailFrom: jarkko@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/BUMQ2SPKBW3F4OTXDSGN5LP4RYDRWYW5/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jarkko Sakkinen via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jarkko Sakkinen <jarkko@kernel.org>

On Mon, Sep 21, 2026 at 02:06:43PM +0530, Kuldeep Singh wrote:
> > Causes merge conflicts with my tree when applied with git am (actually
> > b4 shazam).
> 
> Jarkko, this series was sent based on tag next-20260828 after applying
> prerequisite series[1]. Some minor Makefile/MAINTAINERS conflict was
> observed IIRC.
> 
> Kindly note for merge strategy, prerequisite series[1] will be merged
> via TEE tree and current series need patch 1-5(not patch6) only as
> prerequisite.
> 
> To merge TPM series, it's better to pick from your tree and TEE
> maintainer can ACK patch 1/2 for seamless integration?

So I'm just having trouble following so: what is the best option
for you? What do you want me to do? Which route you prefer?

> 
> [1]
> https://lore.kernel.org/lkml/20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com/
> 
> -- 
> Regards
> Kuldeep
> 

Br, Jarkko
