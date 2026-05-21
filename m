Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F8D2CD5BB3
	for <op-tee@archiver.kernel.org>; Thu, 21 May 2026 12:55:28 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6FC3744DF6
	for <op-tee@archiver.kernel.org>; Thu, 21 May 2026 12:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1779368127;
	bh=oNESJaglCL1dzgX1GFakHoQU9tj1dtl7uwau92+WcXc=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=deYz8+TKteQAtcpHdDtTNATvlTNZXXwqtNgavQSkJM5fNT2TDqBtUz1WKomfNnyW4
	 WkSKselOF9UdMLBPrEVRZGSi3vp/XsxzNizQJ41ZeHHoSokqJO1YQ+PI6IVLWUfonp
	 xv5trRojKVzgkmRvFMI1w2KtInEMjWYB2x2bOAhQnKq0zmN2/9kOEFoNrYsNFBe6iT
	 onx+8oBxjqKQPRUn7KZ3JQ3Rv4UX/I7WyPWjD8WF7In8m4a5O++psk+U+0AMJdqGUQ
	 eKuxC4WdDafHGJJbR0q0wbLR9PrME0DcP2Ifd/eDAhFfzLZb4Sbt++cf6I9TbLGtji
	 YmIj1iXOncpmg==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6D30643824
	for <op-tee@lists.trustedfirmware.org>; Thu, 21 May 2026 12:55:18 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XpgFNDcZ;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 09A2D601F3;
	Thu, 21 May 2026 12:55:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B23E1F000E9;
	Thu, 21 May 2026 12:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779368117;
	bh=Yr/9hqel5Ty7gJs+k9crOmQVKqRYap/VGhhoyrbDA9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XpgFNDcZjIVY1mOkaN0Kgu/WBJ513yFFIh2BykmcZhcM0Ly8zIOzBatosDmsUVOtf
	 9WlpeZpBVuqp58MnGm57uDZ/B9TA1HUAyX3LLDbZk1cvWvT6XDr+UcTNEaUsN0TeUH
	 8MzKqr+28wazSELnUGFpFEJjLWTLsyl86+yJosRYlvhlWFYKarbvrku9JD9aeEp9ud
	 XaLXCSNQ923dEvXzPQPJ6DbW5t0hJA94ProbfTBUWOnRSgJBdCV0b9m55kIEr1LCp6
	 TXyAPDKwbYRzzWRQiFtv/VLqsMOf3saXZrXsGkbKbVUbOMYSRZF6NAtVHk6BmW2zdv
	 BOfYgZe4dRE9g==
Date: Thu, 21 May 2026 13:55:13 +0100
To: Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH v4 3/5] firmware: arm_ffa: Fix Endpoint Memory Access
 Descriptor offset calculation
Message-ID: <20260521-lynx-of-uncanny-intensity-9e37a1@sudeepholla>
References: <20260520204948.2440882-1-smostafa@google.com>
 <20260520204948.2440882-4-smostafa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520204948.2440882-4-smostafa@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254:c];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DNSWL_BLOCKED(0.00)[172.105.4.254:from];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 6D30643824
X-Spamd-Bar: ----
Message-ID-Hash: OTUWNBMDDFHIQFAGBJ7C7IVSC2LAGGPW
X-Message-ID-Hash: OTUWNBMDDFHIQFAGBJ7C7IVSC2LAGGPW
X-MailFrom: sudeep.holla@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@kernel.org>, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, sumit.garg@kernel.org, sebastianene@google.com, vdonnefort@google.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/OTUWNBMDDFHIQFAGBJ7C7IVSC2LAGGPW/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sudeep Holla via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sudeep Holla <sudeep.holla@kernel.org>

On Wed, May 20, 2026 at 08:49:46PM +0000, Mostafa Saleh wrote:
> From: Sebastian Ene <sebastianene@google.com>
> 
> Use the descriptor's `ep_mem_offset` to calculate the start of the endpoint
> memory access array and to comply with the FF-A spec instead of defaulting
> to `sizeof(struct ffa_mem_region)`.
> This requires moving `ffa_mem_region_additional_setup()` earlier in the setup
> flow.
> Also, add sanity checks to ensure the calculated descriptor offsets do not
> exceed `max_fragsize`.
> 

Core change remains same as v3 except improved error checking, so my
review still applies.

Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>

-- 
Regards,
Sudeep
