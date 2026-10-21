Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79E5606A319
	for <op-tee@archiver.kernel.org>; Wed, 21 Oct 2026 07:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=ng6TkQu7;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MTpDnlQO
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0F1E3451AE
	for <op-tee@archiver.kernel.org>; Wed, 21 Oct 2026 07:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1792568988;
	bh=YzuQhVEBFOqisv/IgSPAGTLdBJUM+5xyO3KfpJWlxKg=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=ng6TkQu7IMD4lImXGtomuGR9REEjw/KUXrIhFqkGHfClFjcMb6DPOn2vDQYxzaqDZ
	 EPSNF0MafOp/700tJglwZvJzEjvetKRDveUNjcSONCOjSghy6rg/eA4keI+j+jp72w
	 okfTPAHGWqHinnvFsgQqzBh24bWvfLq6tND6WGzQaOzrKxoNdO/FruLP89B3RrHs55
	 GrkEbxGZXvx/7SFfN/ToYdVo+ZpxUhFocJNE2KVKix0M2zx2UvfT7XF8PNg5R15oYY
	 ZVwvXSXIJNLA7+JrNmfGKkTwLG6Qt7zk4hvhVOo2UsMBkgTQB0pIGxKzgxwjm2Ytsp
	 +uNCCUvoRkwOg==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with UTF8SMTPS id 4FA2741BDC
	for <op-tee@lists.trustedfirmware.org>; Wed, 21 Oct 2026 07:49:30 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MTpDnlQO;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id A2B3941625;
	Wed, 21 Oct 2026 07:49:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 086E41F000C9;
	Wed, 21 Oct 2026 07:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792568969;
	bh=Mw9ALp5m6wk+v40aZBRs95cwBAwuR1QaIazcbE7LyXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MTpDnlQOpJ5O/IXlzsIQN/HhAQvO4OdgtMBaN6SEtfIfE1hth364NrneDgPzjmPDj
	 JpCJ2l1A2vjS86ClRaG79NTWDYxEKx01PxJRrDR6/+Gu0fbVwK+QlWw3Z7MX+yxNFf
	 s1gew//0fW9SahPGm3lipgOyxGZDA91358P3XTKyTGHY9WMDrJjHCLLVZ1ETap5/4C
	 XEthzrj2YmVP05kACZxHr0uEaxpK8tMEXtn6VVqqH439EnKWmLPOssbrprGYdScp/I
	 Fh9rVEYIoK/ZrGVV+j8Q6ixWQsoZVOIVIhZmu4jlPGBycL/9PC8SERkoiUmzTtH+nM
	 WIj5MHMcTo2Ww==
Date: Wed, 21 Oct 2026 10:49:25 +0300
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Subject: Re: [PATCH v4 0/3] Add TPM support via Qualcomm TEE TPM TA
Message-ID: <athuhfkfGPZp_YXT@kernel.org>
References: <20261019-tpm_qcom_driver-v4-0-6889b9804ba7@oss.qualcomm.com>
 <atYZXRLf3YPZhiNB@kernel.org>
 <8896d867-dfba-4d63-a0f0-5686c572b262@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8896d867-dfba-4d63-a0f0-5686c572b262@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.69 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-2.99)[99.94%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	RCVD_IN_DNSWL_MED(-0.20)[172.234.252.31:from];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,gmx.de,ziepe.ca,vger.kernel.org,lists.trustedfirmware.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4FA2741BDC
X-Spamd-Bar: ---------
Message-ID-Hash: 7XW4R7NMQP63AKCRQP265SV4VSOQFVRD
X-Message-ID-Hash: 7XW4R7NMQP63AKCRQP265SV4VSOQFVRD
X-MailFrom: jarkko@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jenswi@kernel.org>, Jens Wiklander <jens.wiklander@oss.qualcomm.com>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/7XW4R7NMQP63AKCRQP265SV4VSOQFVRD/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: Jarkko Sakkinen via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jarkko Sakkinen <jarkko@kernel.org>
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 11:21:33AM +0530, Kuldeep Singh wrote:
> > Applying this pulls tons of TEE patches:
> > 
> > Applying: tee: qcomtee: Track the object invocation context
> > Applying: tee: Add kernel client object invoke helper
> > Applying: tee: qcomtee: Allow object invokes from kernel clients
> > Applying: tee: Export uuidv5 generation for TEE backends
> > Applying: tee: qcomtee: Add support for registering QTEE services on TEE bus
> > Applying: firmware: qcom: Add support for TEE based EFI-var client driver
> > Applying: arm64: defconfig: Enable UefiSecApp TEE client driver for Qualcomm SoCs
> > Applying: tee: qcomtee: Register qcom.tz.tpm service for discovery
> > Applying: tpm: Introduce Qualcomm TPM driver
> > Applying: MAINTAINERS: Add Qualcomm TPM driver entry
> 
> Yes, first 5 are tee patches prerequisite for tpm series as mentioned in
> cover letter too and this series can only be merged once Jens can pick
> dependent series[1] in linux-next.
> 
> Since, v7.4 merge window going to start soon so i doubt Jens can pick
> for v7.4.
> 
> Jens, Any plan/timeline you are aiming to pick series[1]?
> I see it's mostly reviewed with no other relevant feedback to be addressed.

Maybe it is better to pick also TPM patches through your tree when
you choose to so that this will go in-sync.

> 
> [1]
> https://lore.kernel.org/lkml/20261015-qcom_uefisecapp_migrate_qcomtee-v5-0-1460691b35d3@oss.qualcomm.com/
> 
> -- 
> Regards
> Kuldeep

Br, Jarkko
