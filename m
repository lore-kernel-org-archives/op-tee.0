Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7298E95A77
	for <op-tee@archiver.kernel.org>; Tue, 30 Dec 2025 11:10:48 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 256474FF0C
	for <op-tee@archiver.kernel.org>; Tue, 30 Dec 2025 11:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1767093048;
	bh=cbvXc3P0gkf4daKd1w9/tAFqdLjRVYHyMeg6AMHP2II=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=ABHs1G6vkDSEznAJXw1fdcD7k9XlLMPkXVfFk2yO5Oa46JOcMJr8aUWPIpLN5d2Vf
	 PDMJPegO4rHD6loubhC1NYRCRZUDVXDjl3xWtiy9ipXq3P1ezMV7G/I5lO63n5W1Bx
	 PzdZM3pBe5y/H/YfQEyoWb9TdlcxJD60OD7ERsy0TjfxjXOPvEPyrgt7gXbnH/pgSW
	 yLvW1eFaqMfjXMAxFA729BR7rT3+BsiJEAfqNTITTRoOxBRSZkGxerTJdvGiFH0s/0
	 CMnNGDdrK9tsnSAeZaFIP2R1CI6CZiNt9pLzObLIk5w27IHDV1utGBk4CMB1AUmenu
	 IRz7qazkebW9A==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id DCC5941877
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Dec 2025 11:10:30 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jj2yeHVN;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6D0CD6000A;
	Tue, 30 Dec 2025 11:10:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9382C4CEFB;
	Tue, 30 Dec 2025 11:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767093030;
	bh=cbvXc3P0gkf4daKd1w9/tAFqdLjRVYHyMeg6AMHP2II=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jj2yeHVNMmcWbZyQ36+LsSqqhNrtnHbfbuBptIp2dJC9tpdZ2dUqoxzH8uM6U4nOO
	 c8YKQI3+3VLUa1uMz3vu/GaVWH8AE/gXfc6AW9OqQ7mcPmLDpS3P4a79iExn7QA/TC
	 3KUwP+ScfDmyPf3afJ0CCy8iKO5grkAEX8Aq7RBKBUHyiPalEeTxN88D2p2JEKKnNg
	 LRdyueOslm5SLJU2uOCyT7aVMqaAAfpuyChpy+iYoN+f+aW3ek03ZgqAPr82ASPYWK
	 TWsVQzmjCu9iGYtsxlKEPAxes3k5fKUBZDmse9Q8s1I1E6v9WPLEqWTZFpe5Ykk5tz
	 r26EZ2pH+d5/A==
Date: Tue, 30 Dec 2025 16:40:21 +0530
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v20 1/6] dt-bindings: firmware: Add TEE remoteproc
 service binding
Message-ID: <aVOzHWmlJ-eneS-2@sumit-xelite>
References: <20251217153917.3998544-1-arnaud.pouliquen@foss.st.com>
 <20251217153917.3998544-2-arnaud.pouliquen@foss.st.com>
 <20251229232530.GA2753472-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251229232530.GA2753472-robh@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.92 / 15.00];
	BAYES_HAM(-2.92)[99.65%];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[dt];
	BLOCKLISTDE_FAIL(0.00)[100.75.92.58:server fail];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: DCC5941877
X-Spamd-Bar: --
Message-ID-Hash: B5CJS5KCC7RJCWT5E7G3U4CJTGQYMJIV
X-Message-ID-Hash: B5CJS5KCC7RJCWT5E7G3U4CJTGQYMJIV
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/B5CJS5KCC7RJCWT5E7G3U4CJTGQYMJIV/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Mon, Dec 29, 2025 at 05:25:30PM -0600, Rob Herring wrote:
> On Wed, Dec 17, 2025 at 04:39:12PM +0100, Arnaud Pouliquen wrote:
> > Add a device tree binding for the TEE-based remote processor control
> > service implemented as an OP-TEE Trusted Application identified by
> > UUID 80a4c275-0a47-4905-8285-1486a9771a08.
> > 
> > The TEE service node is a child of the "linaro,optee-tz" firmware node and
> > acts as a container for remoteproc devices that are controlled via TEE.
> 
> Is this generic for any remoteproc device or just ST's remoteproc. Looks 
> like the latter to me.

That's true, the DT description of the remoteproc subnode is very
specific to the vendor which in this case is ST.

> 
> > In addition, the "linaro,optee-tz" binding is updated to specify the
> > '#address-cells' and '#size-cells' values used for child TEE service
> > nodes.
> 
> I'm pretty sure I already rejected per service/app child nodes for 
> OP-TEE when its binding was submitted.

That was the reason to have discoverable TEE bus in first place and I
have been motivating people to dynamically discover firmware properties
rather than hardcoding in the DT.

> If we do need something in DT 
> to define some resources, then can't we have some sort of 
> standard/common communications channel? I don't care to see some sort of 
> free-for-all where we have every vendor doing their own thing. OP-TEE 
> needs to standarize this.

I suppose this requires a wider scope work as you can see the DT resource
dependence from here [1]. By standardize communication channel, do you
mean to say if adding an alternative backend to fwnode for TEE in
parallel to DT, ACPI or swnode is the way to go for discovering fw
properties? Or do you have any other suggestion here?

Along with that the corresponding subsystems has to adopt fwnode APIs
instead of OF APIs.

[1] https://lore.kernel.org/all/0e5a44df-f60a-4523-a791-6318b3c81425@foss.st.com/

-Sumit
