Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E966C79F8C
	for <op-tee@archiver.kernel.org>; Sun,  6 Sep 2026 19:39:19 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 668E544FA8
	for <op-tee@archiver.kernel.org>; Sun,  6 Sep 2026 19:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788723558;
	bh=SwPbaSE+r+ad668efSoIxC0WMFREdoKaVVaUwRCmmZk=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=cGrHjq8i95WNulUBUhb2fIcjX3rwxAYDY264e8pODOLtBWm8XUsfw3Amsjd7eDYp0
	 T+YkRpE/rGP8IFdwTbSJZRuFOW8odFmfMUsarH9JqrMap/5jEeYLSsNXS5vxW5tKQP
	 BUlvwA//hMfDmD4zKcyZKRaKlffNKG3YgLQw5AAxkrRmbvEzNumMRCOdPFOx/JPwvA
	 272OVdQ/0h/to1HikmfNYglCu+BRnMr4tl0seCEJhM7Pt793upKjUXp+vRjbx5SntJ
	 4QMJlf8tD1+eFNV+KPZp5gX4OlPeo2UY0bP1FED/AEue/9u+0PswIkbNXe78CRcJn7
	 pjYGxZUS/zrRw==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B0EEB44FA8
	for <op-tee@lists.trustedfirmware.org>; Sun,  6 Sep 2026 19:39:11 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iQNoTprd;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 25E51601F9;
	Sun,  6 Sep 2026 19:39:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 625C61F00A3A;
	Sun,  6 Sep 2026 19:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788723550;
	bh=V0dlg/OCZ/KvufmAUs7+NibuZAe4qcL98ZBaXdAOiso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iQNoTprdzIABHeaY8m1+qIYrChSBW4YR5g56ND0IDGxjVrUjtu75iXcCInOb1364I
	 +wTB43doqgMJLnfBYJoSskumSgUkqMuUSGSIyoiPPsV5IWdYEYUL+GqtDQkjrs8b/w
	 R6nDfbG6LsyEfVITroBVaYZCYKvjcF1I8vSvuQf2oWbg1ZiodwnpaEcX1THbxmnSe+
	 IHQQ7ZglbTz7DzRXjtIv6JDrqgE4UHHd8b9zAX216R+bHlW31/yMX2GKkwGDEUCJoJ
	 YO213e8leFhpd/Q0nqRYPJDTLfgotLWQBIY2H1TusP0BQqbzqo8eIUTF+jNybiPMEk
	 M4oRLiEK08ijQ==
Date: Sun, 6 Sep 2026 22:39:02 +0300
To: Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH v9 03/10] set_memory.h: Introduce
 can_set_direct_map_range()
Message-ID: <ap3BVr5hHwA499gu@kernel.org>
References: <20260902104712.2399797-1-vdonnefort@google.com>
 <20260902104712.2399797-4-vdonnefort@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902104712.2399797-4-vdonnefort@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.00 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[18];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B0EEB44FA8
X-Spamd-Bar: --------
Message-ID-Hash: 2JLFVWBAVFNWNNKIUR72LP26WG4K2JEB
X-Message-ID-Hash: 2JLFVWBAVFNWNNKIUR72LP26WG4K2JEB
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org, sudeep.holla@kernel.org, jenswi@kernel.org, robh@kernel.org, mark.rutland@arm.com, sumit.garg@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/2JLFVWBAVFNWNNKIUR72LP26WG4K2JEB/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Mike Rapoport via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Mike Rapoport <rppt@kernel.org>

On Wed, Sep 02, 2026 at 11:47:05AM +0100, Vincent Donnefort wrote:
> While can_set_direct_map() tells whether the direct map can be modified
> globally, can_set_direct_map_range() checks if a specific range can be
> modified. e.g. if mapped at PTE-level.

set_direct_map are going to have number of pages parameter soon:

https://lore.kernel.org/all/20260903-execmem-set-vm-perms-v0-2-v3-1-949b64a9f755@kernel.org

so this check can be a part of arm64::set_direct_map

I wouldn't expose can_set_direct_map_range() as a public API and rely on
the callers to "Do The Right Thing".
  
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> 
> diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
> index 3030d9245f5a..88175c3fa751 100644
> --- a/include/linux/set_memory.h
> +++ b/include/linux/set_memory.h
> @@ -44,6 +44,12 @@ static inline bool kernel_page_present(struct page *page)
>  {
>  	return true;
>  }
> +
> +static inline bool can_set_direct_map_range(struct page *page,
> +					    unsigned long nr_pages)
> +{
> +	return false;
> +}
>  #else /* CONFIG_ARCH_HAS_SET_DIRECT_MAP */
>  /*
>   * Some architectures, e.g. ARM64 can disable direct map modifications at
> @@ -56,6 +62,14 @@ static inline bool can_set_direct_map(void)
>  }
>  #define can_set_direct_map can_set_direct_map
>  #endif
> +
> +#ifndef can_set_direct_map_range
> +static inline bool can_set_direct_map_range(struct page *page, unsigned long nr_pages)
> +{
> +	return can_set_direct_map();
> +}
> +#define can_set_direct_map_range can_set_direct_map_range
> +#endif
>  #endif /* CONFIG_ARCH_HAS_SET_DIRECT_MAP */
>  
>  #ifdef CONFIG_X86_64
> -- 
> 2.55.0.970.g62bdec98f9-goog
> 

-- 
Sincerely yours,
Mike.
