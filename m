Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D946D4921F
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 12:34:33 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D200F4FD0E
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 12:34:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5CF644FB46
	for <op-tee@lists.trustedfirmware.org>; Fri, 12 Dec 2025 12:34:20 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDC9C1063;
	Fri, 12 Dec 2025 04:34:12 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8467C3F762;
	Fri, 12 Dec 2025 04:34:18 -0800 (PST)
Date: Fri, 12 Dec 2025 12:34:15 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v1 11/17] firmware: arm_scmi: Make use of tee bus methods
Message-ID: <20251212-cuddly-viridian-armadillo-be28fe@sudeepholla>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
 <46dae3cada663b3a5ae1989881d9e74ef40acce5.1765472125.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <46dae3cada663b3a5ae1989881d9e74ef40acce5.1765472125.git.u.kleine-koenig@baylibre.com>
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.05 / 15.00];
	BAYES_HAM(-2.75)[98.91%];
	MID_RHS_NOT_FQDN(0.50)[];
	FORGED_SENDER(0.30)[sudeep.holla@arm.com,sudeep.holla@foss.arm.com];
	RCVD_IN_DNSWL_MED(-0.20)[217.140.110.172:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_NO_TLS_LAST(0.10)[];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : No valid SPF, No valid DKIM,none];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:28939, ipnet:217.140.110.0/24, country:GB];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_SPF_NA(0.00)[no SPF record];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,wanadoo.fr,arm.com,kernel.org,lists.trustedfirmware.org,vger.kernel.org,lists.infradead.org];
	R_DKIM_NA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sudeep.holla@arm.com,sudeep.holla@foss.arm.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	NEURAL_SPAM(0.00)[0.743]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 5CF644FB46
Message-ID-Hash: 5EZJFKZ4GH2ABBJI3DACF5ZVNZ3UACWP
X-Message-ID-Hash: 5EZJFKZ4GH2ABBJI3DACF5ZVNZ3UACWP
X-MailFrom: sudeep.holla@foss.arm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Cristian Marussi <cristian.marussi@arm.com>, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/5EZJFKZ4GH2ABBJI3DACF5ZVNZ3UACWP/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Thu, Dec 11, 2025 at 06:15:05PM +0100, Uwe Kleine-K=F6nig wrote:
> The tee bus got dedicated callbacks for probe and remove.
> Make use of these. This fixes a runtime warning about the driver needing
> to be converted to the bus methods. Note that the return value of .remove=
()
> was already ignored before, so there is no problem introduced by dropping
> the error returns.
>=20

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--=20
Regards,
Sudeep
