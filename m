Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 104DEC71141
	for <op-tee@archiver.kernel.org>; Wed, 11 Jun 2025 18:10:03 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3F2DB4312A
	for <op-tee@archiver.kernel.org>; Wed, 11 Jun 2025 18:10:03 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B855F40928
	for <op-tee@lists.trustedfirmware.org>; Wed, 11 Jun 2025 18:09:42 +0000 (UTC)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1uPPtN-00012L-8z; Wed, 11 Jun 2025 20:09:41 +0200
Message-ID: <89ad64f2-fbda-48a3-9a27-5eaff5be9292@pengutronix.de>
Date: Wed, 11 Jun 2025 20:09:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE, de-BE
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
To: manish.pandey2@arm.com
Subject: Firmware Handoff for DT Overlay created by OP-TEE?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: op-tee@lists.trustedfirmware.org
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.24 / 15.00];
	BAYES_HAM(-2.94)[99.73%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	RCVD_IN_DNSWL_MED(-0.20)[2a0a:edc0:0:900:1d::77:received];
	ONCE_RECEIVED(0.20)[];
	R_SPF_ALLOW(-0.20)[+mx];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ASN(0.00)[asn:209379, ipnet:185.203.200.0/22, country:DE];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_SPAM(0.00)[0.940];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DNSWL_BLOCKED(0.00)[185.203.201.7:from];
	DMARC_NA(0.00)[pengutronix.de];
	RCVD_TLS_LAST(0.00)[];
	RBL_SENDERSCORE_REPUT_BLOCKED(0.00)[185.203.201.7:from]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B855F40928
Message-ID-Hash: NJEEVUGANXBL3JORAB5KTA6E5TFB76TS
X-Message-ID-Hash: NJEEVUGANXBL3JORAB5KTA6E5TFB76TS
X-MailFrom: a.fatoum@pengutronix.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, BAREBOX <barebox@lists.infradead.org>, rouven.czerwinski@linaro.org, Michael Tretter <m.tretter@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/NJEEVUGANXBL3JORAB5KTA6E5TFB76TS/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hello Manish,

In your recent talk[1] at LinaroConnect about the Firmware Handoff
specification, you were asking about what other use cases it could
address for OP-TEE.

We ran into a possible use case that we would like to share:

BL2 can pass a DT to OP-TEE, which it would use to discover memory and
to fix up with memory reservations covering the memory it carves out for
itself.

OP-TEE also supports passing along the reservations as a device tree
overlay. AFAICS, there is no way currently to have both: A DT for OP-TEE
to probe hardware from and a way to pass the normal world a device tree
overlay in return.

I think this could be neatly addressed with Firmware Handoff and would
be a motivation for us to implement support in barebox BL2/BL33 to take
advantage of this. The current way is suboptimal as we would prefer the
DT passed to OP-TEE to be read-only. This avoids either having to copy
it or to pad it sufficiently in anticipation of it growing with the
addition of the new nodes.

[1]: https://www.youtube.com/watch?v=RxU798h8aiE

Cheers,
Ahmad

-- 
Pengutronix e.K.                  |                             |
Steuerwalder Str. 21              | http://www.pengutronix.de/  |
31137 Hildesheim, Germany         | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686  | Fax:   +49-5121-206917-5555 |

