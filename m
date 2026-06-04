Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3C6CD6E68
	for <op-tee@archiver.kernel.org>; Thu,  4 Jun 2026 08:57:39 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A914144DBA
	for <op-tee@archiver.kernel.org>; Thu,  4 Jun 2026 08:57:38 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1AEAA438C1
	for <op-tee@lists.trustedfirmware.org>; Thu,  4 Jun 2026 08:57:31 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1wV3tJ-0001Lz-Q3; Thu, 04 Jun 2026 10:57:29 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1wV3tJ-00133Y-24;
	Thu, 04 Jun 2026 10:57:29 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1wV3tJ-00000003sF9-2Ild;
	Thu, 04 Jun 2026 10:57:29 +0200
Date: Thu, 4 Jun 2026 10:57:29 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: OP-TEE Contributions Forum, monthly meeting May 26
Message-ID: <mdof4zapmokna4wv3tm5a53tdrkyu2tvfrng7h5yzvoadwywnd@ph7l6otpgryv>
References: <CAHUa44GNE3wMTD-pu0fwyXquyAywiR6FjZBG53j=du-pb+8u1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHUa44GNE3wMTD-pu0fwyXquyAywiR6FjZBG53j=du-pb+8u1A@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: op-tee@lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.58 / 15.00];
	BAYES_HAM(-1.68)[93.03%];
	MID_RHS_NOT_FQDN(0.50)[];
	RCVD_IN_DNSWL_MED(-0.40)[185.203.201.7:from,2a0a:edc0:0:c01:1d::a2:received];
	FORGED_SENDER(0.30)[m.felsch@pengutronix.de,mfe@pengutronix.de];
	R_SPF_ALLOW(-0.20)[+mx];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:209379, ipnet:185.203.200.0/22, country:DE];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.847];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.felsch@pengutronix.de,mfe@pengutronix.de];
	R_DKIM_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DMARC_NA(0.00)[pengutronix.de];
	RCPT_COUNT_THREE(0.00)[3]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 1AEAA438C1
X-Spamd-Bar: -
Message-ID-Hash: UCOBISETULPTZ42EJXI5R67ZVYWT2PXW
X-Message-ID-Hash: UCOBISETULPTZ42EJXI5R67ZVYWT2PXW
X-MailFrom: mfe@pengutronix.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>, linaro-open-discussions@op-lists.linaro.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/UCOBISETULPTZ42EJXI5R67ZVYWT2PXW/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Jens,

On 26-05-25, Jens Wiklander wrote:
> Hi,
> 
> Tomorrow, Tuesday, it's time for another OP-TEE contributors' monthly
> meeting. For time and connection details, see the calendar at
> https://www.trustedfirmware.org/meetings/

Sorry I saw this e-mail to late since I was in Nice last week to attend
to the Embedded Recipes.

> Regarding Kconfig support:https://github.com/OP-TEE/optee_os/pull/7714
> It appears that the transition will take quite some time. We'll have a
> window when some variables have transitioned to be managed by Kconfig,
> but others remain managed by the makefiles. Do we care that variables
> passed on the command line may work differently, depending on whether
> they are managed by makefiles or Kconfig? Can something be done about
> it?

Could you forward me the outcome of this discussion? I hope to continue
the work next week, since we _really_ want Kconfig support.

Regards,
  Marco

> Any other topics?
> 
> Cheers,
> Jens
> 

-- 
#gernperDu 
#CallMeByMyFirstName

Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
