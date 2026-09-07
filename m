Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E93AC79F9E
	for <op-tee@archiver.kernel.org>; Mon,  7 Sep 2026 09:52:56 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id AAA1F450B0
	for <op-tee@archiver.kernel.org>; Mon,  7 Sep 2026 09:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788774775;
	bh=RAk4/+0VANubwExV/eikqowXjMZXGsN/RmDQCnJKXPk=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Gj3K5LHRPi2TLx9NcWZGZwBqWAmHZ5LmOr2j//BXQDX76c6WD2a2vlFr3g6lFoncO
	 XeHuGKexvSWFTx3qNBcQoLHaEPdXcbXEMnr2fUfe5o/G9TR6k+j+ptmjhtkR2bE1Z7
	 CRyXhCU5fHBcpb4N43G9/FYvGgw9+n0Mjhbp6mVRGOq7n7QrWv+fO/PxMttD0Pv/cS
	 4aqqqMYHllj4oh3R67FG+7e4np8Pdg72CizPVpQzRcizFcb+fkjtTS6189sg6/6mKZ
	 RtaapWLrhxn1iwhAh7blQCh5JMiAs0EbPp85wxcMdKZ5sjUQBVHaNBcJPhn5nXRCsA
	 14ppx0/mybTlQ==
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1DA454370D
	for <op-tee@lists.trustedfirmware.org>; Mon,  7 Sep 2026 09:52:49 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=EZGWdyIu;
	dkim-atps=neutral
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so3781927f8f.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 07 Sep 2026 02:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788774768; x=1789379568; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kqgfejYSVwSnwDj4+nn08kyPi4IgtneNSDWgXEMZ2iw=;
        b=EZGWdyIuArUTfkfeyk4ZRVFRYqaAxK4Mmq3FYuYbDpydaFKnKKcpMyUoO9oFde3igR
         sMUF29laHwuHDpiPRJ4qz5XgtYT5cyR50XQk9jmkU5fYH6ScFQRrHIiUZMYZM9QgJfCP
         hJUxtewX3s9tewB1IX6CgQBGXaYmO3vSqdCKlYrE8/HCsazkor/hrYMY7jA+KBc/5meG
         meboLKJz3MP9/89k0r6Gd9b2tedIPBHq86j2iQuidRlS5HQtniCtwHziGBtNfPqBm9TK
         35kbAj7u8O+B2oYnB/Nh5CMbE5c/KT+xEsp9fq00ZilAYBmY/+i9IUUp50G2qVsH9vD4
         iudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788774768; x=1789379568;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kqgfejYSVwSnwDj4+nn08kyPi4IgtneNSDWgXEMZ2iw=;
        b=HCzwnTg7CFAhxF5Cj7wapoKLKKExqyo0eT+gYXVd7kzMz5qYKVb/ihRy5cLGSOMTXF
         gAXthbuE+aa8sd9HqZhXAgqH72qIPv880yDNRDy9UYCtoxb8/lOUq4EIletQxNvJ+Jxi
         O4mm/6PXFejlqzQiF6bPNQ2p/mqmYBNGlE9afMBydCXHlHB4TXhbcKa4XyOV4ftAJm1L
         UTnR3BNJWQVEcL2zza0350LA3oKAk70P5Blcs1JOqDiDhV7PjoHc8brH2Vx6BGi+ytsY
         4rq+BeHM6pHU8kFJ1EtCNtULr35O8VsriIJD0T9NcpfHa8ILbghyX1ubVVM8woftPXWS
         Fgqg==
X-Forwarded-Encrypted: i=1; AKwUvBzPqstUoq/3/gxrL1uK0th1Iq+NdcoA8KR0vrQLhCgDt261qRUs0LtR/P2yEz9GSqNuGXOXzFU=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++kZzG7NckfPtrbONPGbL7/IklQPdflICKZPhyQlCwmV91AxCtsP
	NETK1kqVUzs83OFKQbRdx66NEaY0QSye+Mt0O7Nc9su4qC0+4gOuEc7HPF0ewmbv/w==
X-Gm-Gg: AYBFou3pbLYH84kcGBD7WLIpPWKTflTmAlbc6ENunZAMvll4e5YObWLLvHN1UjEDce6
	pvnITIuUnyD4jLJsobm2NOcIYGY5lS6qno/f4hcpdWXCmbJOZYkLN1YOZJcL0yu7mYEcM7zVNjD
	HX39AL5OO9tsTV987a4sYNsT+col/firTM+dp8rfG5F9EwZGiJDiZrlHzjXlS4i4OgrLCSPZ/kU
	Vu8t7cLs4sy9VXzJaEOway9ZAHyS8kxH3rTyC4YRjHui9jUqXyNbUk06Jn6mILqu8ht2Yecj+ex
	KnodR5HBYiLeT2ZrtVz/JEG3i4wJ8bCN2c7j9OylNWNyUVqGR8RZxQ9hHhU4t977ktZpYDAPJpb
	8x8Mw6tNHQiwDfH/ovzjbZylflBJvTw4Gw70+i5+yh9A77zgX4km1WRjJm7LQjaSV0uOJAp/WQ5
	w/SSFORSuZXj8ONKkIUceQaqQ1EEZ/iB9e+f0Z8a8GuZh2jq0mN9DKrRx7u/skrhT8+Wjw7VTbM
	6FoMo/7lkw8+7LiOp+JH3WgoychFCo/
X-Received: by 2002:a05:6000:4b1d:b0:485:8c16:a32a with SMTP id ffacd0b85a97d-4858c16a5a7mr19950748f8f.31.1788774767486;
        Mon, 07 Sep 2026 02:52:47 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bf3f0sm30012615f8f.33.2026.09.07.02.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 02:52:46 -0700 (PDT)
Date: Mon, 7 Sep 2026 10:52:43 +0100
To: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v9 03/10] set_memory.h: Introduce
 can_set_direct_map_range()
Message-ID: <ap6Ja02S5IDqWRHC@google.com>
References: <20260902104712.2399797-1-vdonnefort@google.com>
 <20260902104712.2399797-4-vdonnefort@google.com>
 <ap3BVr5hHwA499gu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap3BVr5hHwA499gu@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.221.47:from];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.221.47:from];
	DNSWL_BLOCKED(0.00)[104.155.91.135:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 1DA454370D
X-Spamd-Bar: ---
Message-ID-Hash: GVVGPYMSK3KKL5KINA3NGQ4ZZPVWHBOI
X-Message-ID-Hash: GVVGPYMSK3KKL5KINA3NGQ4ZZPVWHBOI
X-MailFrom: vdonnefort@google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org, sudeep.holla@kernel.org, jenswi@kernel.org, robh@kernel.org, mark.rutland@arm.com, sumit.garg@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/GVVGPYMSK3KKL5KINA3NGQ4ZZPVWHBOI/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Vincent Donnefort via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Vincent Donnefort <vdonnefort@google.com>

On Sun, Sep 06, 2026 at 10:39:02PM +0300, Mike Rapoport wrote:
> On Wed, Sep 02, 2026 at 11:47:05AM +0100, Vincent Donnefort wrote:
> > While can_set_direct_map() tells whether the direct map can be modified
> > globally, can_set_direct_map_range() checks if a specific range can be
> > modified. e.g. if mapped at PTE-level.
> 
> set_direct_map are going to have number of pages parameter soon:
> 
> https://lore.kernel.org/all/20260903-execmem-set-vm-perms-v0-2-v3-1-949b64a9f755@kernel.org
> 
> so this check can be a part of arm64::set_direct_map

ack.

> 
> I wouldn't expose can_set_direct_map_range() as a public API and rely on
> the callers to "Do The Right Thing".

ack.

Thanks for having a look at the series.

-- 
Vincent


>   
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > 
> > diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
> > index 3030d9245f5a..88175c3fa751 100644
> > --- a/include/linux/set_memory.h
> > +++ b/include/linux/set_memory.h
> > @@ -44,6 +44,12 @@ static inline bool kernel_page_present(struct page *page)
> >  {
> >  	return true;
> >  }
> > +
> > +static inline bool can_set_direct_map_range(struct page *page,
> > +					    unsigned long nr_pages)
> > +{
> > +	return false;
> > +}
> >  #else /* CONFIG_ARCH_HAS_SET_DIRECT_MAP */
> >  /*
> >   * Some architectures, e.g. ARM64 can disable direct map modifications at
> > @@ -56,6 +62,14 @@ static inline bool can_set_direct_map(void)
> >  }
> >  #define can_set_direct_map can_set_direct_map
> >  #endif
> > +
> > +#ifndef can_set_direct_map_range
> > +static inline bool can_set_direct_map_range(struct page *page, unsigned long nr_pages)
> > +{
> > +	return can_set_direct_map();
> > +}
> > +#define can_set_direct_map_range can_set_direct_map_range
> > +#endif
> >  #endif /* CONFIG_ARCH_HAS_SET_DIRECT_MAP */
> >  
> >  #ifdef CONFIG_X86_64
> > -- 
> > 2.55.0.970.g62bdec98f9-goog
> > 
> 
> -- 
> Sincerely yours,
> Mike.
