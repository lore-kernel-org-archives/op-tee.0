Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5BCCD6E7C
	for <op-tee@archiver.kernel.org>; Fri,  5 Jun 2026 12:01:40 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3C51444EEE
	for <op-tee@archiver.kernel.org>; Fri,  5 Jun 2026 12:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1780660899;
	bh=2Hu0OODba5Q6ygSS5Y6An9Vqwxw+RqBSG+XtkbbFEcI=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=uUdkbN9kTJMQRlZ9G8geWCu0uvOesg9sJqbykyCPKv6xQN02bqEg/SjGqF3gRSFga
	 l9EXIc/l9jrAm+1jWrCbD/dkDVH0CUQ39RPKwiA71i27vDpeVzT9ora3h0Q+yBRgM2
	 V+tWzgLZTu+C/GFtGFaXcIAvBl+QqymCL+t0i6ZVnAle5kjRii+We52pwij8IuCC3N
	 058N6iwb3OcFk8IgD0RYD1jgB8FZRleS8e/GTJ9Aoba6DThIsbtVLyVnYVhPzOs8qq
	 5WRWCPKIEz20NocQZxbQABE08BT9Wk/qjmFS1Ov9wtaOYVBCzpi68ESchub5v+zGB6
	 3Ic5855CRYR3g==
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4617644B02
	for <op-tee@lists.trustedfirmware.org>; Fri,  5 Jun 2026 12:01:32 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=f2xJecw+;
	dkim-atps=neutral
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4891b4934ffso68705e9.0
        for <op-tee@lists.trustedfirmware.org>; Fri, 05 Jun 2026 05:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780660891; x=1781265691; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eaRVw0ksze4pMdMwnejVPQNu/p5iHH1dKv1uIsvyi/U=;
        b=f2xJecw+XfYYxAIIa2mdKk3DE9P3+c1jUXKX94FqhcusmpIsSdRChF8NjbTTpGe1lV
         VgHdNYWdapNytQqc76YIMipuSfxSe0ua9+ICBt5KzJZ/B/LMxbMKdB4VkKvfuTg2D21S
         l/Wia8mhCSA2Smy3NQNlpBXEwRIEEahybLUnbaL4aWq41/KlKBaJ4tlwJ3q5/vL9G1aO
         QGq2Y1LbHnfR8B6cpiFufzgzB86mnmYUa6vMiVPL8WTBwTWSd7cgpd6NSJBkSBARZynd
         Q2CxnrORKcIy7b+hCkP+8gai4X2vSQfbX4uW2taZ5nRayxotLtxhwwfrttedYUx6fxUB
         46pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780660891; x=1781265691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eaRVw0ksze4pMdMwnejVPQNu/p5iHH1dKv1uIsvyi/U=;
        b=NAhzV1xClViB6yI6S8mtczgqhyyJdvgUPETKYTbh56bFoeDk9RTnGT0ayA/rPshg6X
         2g/oGVjZj9yyeNKgkhzv1l6qkQ319zNIATuFzHH2VBBIp5klDv9I7lbT+f8ez7pvrKsM
         WADvng/eq1sfOLjdvEoK/a/ANdEGl3tNmihk7fh1kYvChEsnN2Z2V6WTXQBkDxAETRT1
         Mg6jAXYX5veIeQ0qi+9IxSyMaZvrFG96Pn4IIEOqutTIatqWBHLnVB2Q26XTu1STzZFm
         GzvD2OpQuXmqSE7gD2wOAVRcF1S4F1QRp1CnfHO6Ydrxdn7sFlrIzIYRDW/fVhFIvHYL
         wNHA==
X-Gm-Message-State: AOJu0Yw+rdEt7u4Nhngh7qVFYXJcDHrR0ZGN4RngsQUXWLBc+odldiCN
	Oag8m//VhV30tzzTt7DWzSRn/s9tsQ6Mmz6LbrfQekOvoFnfuNnLde5WZ9KLMMT+JA==
X-Gm-Gg: Acq92OFY5RcEzse9zSnahJXROhaaV+9paRlxT3TRBx/8pZfREYzO+tBTha9W3kCoFo7
	Aze3KHTCyXjlb95nsnK0WsPE0vuBkzBfz4jgLn1e5CAxucQjTh47cTfbGZUeSjtcHwLaB6+dTep
	Jo1YEcIeM0TLrNTabHbxoUu32dwbL9M7ok6UJSP4MH999tegohbNR6tkJkpIMfL26xHXcmzhRMp
	6ELIVpxCG7iYkDEjpVeiOuwFRN7P9tXhYm+GlkvEzaHw+0+rQZ41xcJp7HgYGrl/ul573uiFFWR
	HJ/wrRR1iqgZsEeRyf/AxGpmgQNbY8jTIxUgTyEAuMtGx72aRQ2c4n7dtbjJeZBgYHcNZg1ghSk
	xmOTbDaszh+RpzVDUqgTTTBzvm4hZqOhzGP2hzBzsJF0QBupKlShKdRJxbz5FOSJCtLlKEXui7G
	TZYfokfWtKG7yYl68dX2+j0lo81jiqOvUv7ALylifw4svnCCT6n9xEUh2/45To1zQ/46hhT7NTZ
	haotKXX
X-Received: by 2002:a05:600c:896:b0:490:ab15:b9e8 with SMTP id 5b1f17b1804b1-490c2c782fdmr493135e9.2.1780660890657;
        Fri, 05 Jun 2026 05:01:30 -0700 (PDT)
Received: from google.com (220.71.199.104.bc.googleusercontent.com. [104.199.71.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc4082c3sm144221845e9.13.2026.06.05.05.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 05:01:30 -0700 (PDT)
Date: Fri, 5 Jun 2026 12:01:26 +0000
To: Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH v5 1/6] optee: ffa: Add NULL check in
 optee_ffa_lend_protmem
Message-ID: <aiK6lgW5YFWSMTxf@google.com>
References: <20260526151934.3783707-1-smostafa@google.com>
 <20260526151934.3783707-2-smostafa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526151934.3783707-2-smostafa@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.44:from];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.128.44:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4617644B02
X-Spamd-Bar: ---
Message-ID-Hash: ANQSVE7DJDDYPE6B6ZWCD3UMBDZI7RZP
X-Message-ID-Hash: ANQSVE7DJDDYPE6B6ZWCD3UMBDZI7RZP
X-MailFrom: sebastianene@google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, sumit.garg@kernel.org, vdonnefort@google.com, sudeep.holla@kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ANQSVE7DJDDYPE6B6ZWCD3UMBDZI7RZP/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sebastian Ene via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sebastian Ene <sebastianene@google.com>

On Tue, May 26, 2026 at 03:19:29PM +0000, Mostafa Saleh wrote:
> Sashiko (locally) reports a possible null dereference under memory
> pressure due to the lack of validation of the allocated pointer.
> 
> Fix that by adding the missing check.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/tee/optee/ffa_abi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index b4372fa268d0..633715b98625 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -698,6 +698,9 @@ static int optee_ffa_lend_protmem(struct optee *optee, struct tee_shm *protmem,
>  	int rc;
>  
>  	mem_attr = kzalloc_objs(*mem_attr, ma_count);
> +	if (!mem_attr)
> +		return -ENOMEM;
> +
>  	for (n = 0; n < ma_count; n++) {
>  		mem_attr[n].receiver = mem_attrs[n] & U16_MAX;
>  		mem_attr[n].attrs = mem_attrs[n] >> 16;
> -- 
> 2.54.0.746.g67dd491aae-goog
>

Thanks for fixing this and for including my other patches in the series
Reviewed-by: Sebastian Ene <sebastianene@google.com>

Sebastian
