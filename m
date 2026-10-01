Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61296CA5FCB
	for <op-tee@archiver.kernel.org>; Thu,  1 Oct 2026 13:01:47 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 906A2454CA
	for <op-tee@archiver.kernel.org>; Thu,  1 Oct 2026 13:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790859706;
	bh=aYM8kuL4R9V0ZoKbWoFr2TeUgfNiLnh6WK+8UOczA0s=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=LrwNFwhpH+StiPQhVcVVaNUslAQ0RfVVdDdBtwFUkOZ2V+pHEqpY/Bkc0Dv8cO0Hc
	 4aclkyzQQN79qiPNvgsHAlBjBr7h+udR6GYjE3ZylFzFZj3FdL7XavXVTDBV4oQK+Y
	 lGx7wm+0ylZpRZyqajaXBaHtTxU1T4gqNy5GSiSSxwToclKfQNyqbWnKVpQj+HjU+o
	 IsNwXfLWaAM9hSpbAKt3R9zQwbxiKEzmgtapoq4yuN4IcNlMYbVNsYmUau6SMRAL+R
	 ICc8ZWuI8xDqC/YQdvgNtkJviPFW4RZF7jPGijUGBWC1e05lEFvcnhcCYY9NCIjzg8
	 WNMBH2GueL9/g==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 05EBD43716
	for <op-tee@lists.trustedfirmware.org>; Thu,  1 Oct 2026 13:01:38 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LdRZ+4sK;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 545B043632;
	Thu,  1 Oct 2026 13:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72E41F000FF;
	Thu,  1 Oct 2026 13:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790859697;
	bh=M4fP7Q2RZi+V4A/cdl0vS7LFLqAUgwwbTAklTftriPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LdRZ+4sK9ffUg+GHhtOGut4w8Tm9uzr+blbGD6yTPRzjT2QnelaRTLYw4/zRUMhyL
	 Q2NMGeYpl7dW8X9cHW2lqf5YuxcDhPbr4bd0uB8MNu1I05PkJrZfgwoOAS3Sp3RQrO
	 3m1js/sNpniDLO6bmgXIj7HkSaBrLx0uZ00t/h64Nv/W89OdStwON+9GRUN8jfXEMN
	 edl27Lo75oTtn1ONeD/rYDGgq0iGhFaDb3opb/wiNwrTIOYzavaHPMFrLfh9OiiGHF
	 HtFLWyJPufjnm1N3k5k9ZM7m8AdgmFs5vimTZWjC/CKmZVH10OoQ9NGLxa00nZw+UJ
	 okkjjNoJN25KA==
Date: Thu, 1 Oct 2026 18:31:32 +0530
To: Georgiy Osokin <g.osokin@auroraos.dev>
Subject: Re: [PATCH] tee: shm: reject zero-sized allocations in
 tee_dyn_shm_alloc_helper()
Message-ID: <ar5ZrHihBjaFKf5U@sumit-xelite>
Mail-Followup-To: Georgiy Osokin <g.osokin@auroraos.dev>,
	Jens Wiklander <jenswi@kernel.org>,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, lvc-project@linuxtesting.org
References: <20260928143113.1700001-1-g.osokin@auroraos.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260928143113.1700001-1-g.osokin@auroraos.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.20 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	RCVD_IN_DNSWL_MED(-0.20)[172.234.252.31:from];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31:c];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ARC_NA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 05EBD43716
X-Spamd-Bar: ---------
Message-ID-Hash: GZ7GY4VKTGIBBAELWJXC46Q3ROJ6B364
X-Message-ID-Hash: GZ7GY4VKTGIBBAELWJXC46Q3ROJ6B364
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jenswi@kernel.org>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, lvc-project@linuxtesting.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/GZ7GY4VKTGIBBAELWJXC46Q3ROJ6B364/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Mon, 28 Sep 2026 at 17:31:13 +0300, Georgiy Osokin wrote:
>tee_dyn_shm_alloc_helper() derives nr_pages from a caller-supplied size
>and passes it to alloc_pages_exact() without checking it. For size == 0
>nr_pages is 0, and alloc_pages_exact(0) calls get_order(0), which is
>documented as undefined and returns BITS_PER_LONG - PAGE_SHIFT. The page
>allocator then trips its order > MAX_PAGE_ORDER warning and fails the
>allocation; on a panic_on_warn kernel that ends the boot.
>
>This can be triggered by TEE_IOC_SHM_ALLOC with struct
>tee_ioctl_shm_alloc_data where size is 0.
>
>Reject a zero page count, as register_shm_helper() already does for the
>register path.
>
>Fixes: cf4441503e20 ("tee: optee: Move pool_op helper functions")
>Cc: stable@vger.kernel.org
>Cc: lvc-project@linuxtesting.org
>Signed-off-by: Georgiy Osokin <g.osokin@auroraos.dev>
>---
> drivers/tee/tee_shm.c | 4 ++++
> 1 file changed, 4 insertions(+)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

>
>diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
>index 6742b3579..daa4af1e0 100644
>--- a/drivers/tee/tee_shm.c
>+++ b/drivers/tee/tee_shm.c
>@@ -343,6 +343,10 @@ int tee_dyn_shm_alloc_helper(struct tee_shm *shm, size_t size, size_t align,
> 	unsigned int i;
> 	int rc = 0;
>
>+	/* get_order(0) is undefined and exceeds MAX_PAGE_ORDER. */
>+	if (!nr_pages)
>+		return -EINVAL;
>+
> 	/*
> 	 * Ignore alignment since this is already going to be page aligned
> 	 * and there's no need for any larger alignment.
>
>base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
>-- 
>2.54.0
>
