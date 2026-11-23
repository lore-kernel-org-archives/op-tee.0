Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C22606A327
	for <op-tee@archiver.kernel.org>; Mon, 23 Nov 2026 12:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=d5GzVKAC;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hQamuCjA
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 427E1454C0
	for <op-tee@archiver.kernel.org>; Mon, 23 Nov 2026 12:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1795435883;
	bh=iUuH6nLwkMd1IFP/M5xEqJavevtzjZI19EeKY1bvsAo=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=d5GzVKACchV0dsUmVAai2WP9Hybkv9Xnmn+ZcoQ63I3WPCBj7u95WLntRj1iRxGTj
	 c5WMUbTH0Kv5zuBTqmkk+evGZ3BwlhrjyCJ/kIGIM00p963ISflmF2peLg8IwWhWKc
	 qlI+PRVA7A2A9c6Gzi7EVpSVyQkNXD376FpgMhkuXMLOEnEvyywyj34JuOn3J3qKfE
	 jNjs31teVBM1+CKlepaE/cBItiMCpyN9MP6SlGgectZCnFFWCVV0qnqTAQuzdnGPB5
	 0qJYRC0jcJ9B1fuCVgC/wTlGbXYefs6vOj5dwwrFysQkUw77viwKCOK/qE+wvil9xM
	 /R6Cx+ei2r0IA==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with UTF8SMTPS id E57BB44A43
	for <op-tee@lists.trustedfirmware.org>; Mon, 23 Nov 2026 12:11:17 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hQamuCjA;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with UTF8SMTP id 47DDA620B7;
	Mon, 23 Nov 2026 12:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2ACD51F000C4;
	Mon, 23 Nov 2026 12:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795435876;
	bh=3Eh7AtJFr/uR9z6jF6Gx5kvJFnPR9rDrn/UUs08sdns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hQamuCjAL00ho8wuAS/xxVYieoyQgKpz3vy0va43FUKk/hFwrbG6HzxETV4CPonrt
	 k6jRu1ZOOtEWQhRCEvXtWxedbA8rH8OmH5G9Y+BVpuIHAGJk91cXf0mLNnnojRcdUj
	 qSaXcxSIYXF49xIPCkBP8y3ijLUXYm9PmxXpVMjadfNtsJhik07hKDBj6ZsYokPsHx
	 Rcc4cnD2AigMAxeskn6n0WGYBuUUq0kFKMe8Dt6a6ijFzvVBvp9CvR9Yd4LBFa/l1R
	 qi5fkN6MIlAIbUe+StU8kBx84vegQRFf4wZ6C5FKplP1e/LEdlfU5TiCBE1BhkDXC4
	 kA0JmqcFgg8tQ==
Date: Mon, 23 Nov 2026 14:11:12 +0200
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Subject: Re: [PATCH v5 2/3] tpm: Introduce Qualcomm TPM driver
Message-ID: <awQtYP7tFjTN1Mm0@kernel.org>
References: <20261120-tpm_qcom_driver-v5-0-3d9321ace107@oss.qualcomm.com>
 <20261120-tpm_qcom_driver-v5-2-3d9321ace107@oss.qualcomm.com>
 <awGtGoxtker8a9kG@kernel.org>
 <8aed0815-685d-41b3-af2e-0055bc6ad920@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8aed0815-685d-41b3-af2e-0055bc6ad920@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-2.56)[98.02%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	RCVD_IN_DNSWL_MED(-0.20)[172.105.4.254:from];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,gmx.de,ziepe.ca,vger.kernel.org,lists.trustedfirmware.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: E57BB44A43
X-Spamd-Bar: ---------
Message-ID-Hash: OFIEVDUPNSLV7JEQCC3YKNSJHPY3JHNK
X-Message-ID-Hash: OFIEVDUPNSLV7JEQCC3YKNSJHPY3JHNK
X-MailFrom: jarkko@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/OFIEVDUPNSLV7JEQCC3YKNSJHPY3JHNK/>
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

On Mon, Nov 23, 2026 at 02:48:17PM +0530, Kuldeep Singh wrote:
> >> +module_tee_client_driver(tpm_qcom_driver);
> >> +
> >> +MODULE_DESCRIPTION("TPM driver for Qualcomm TPM TA");
> >> +MODULE_AUTHOR("Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>");
> > 
> > MODULE_AUTHOR() field is not that useful and nobody keeps it up to
> > date, so you never can rely on it. Not NAK, but just underlining
> > how litte it is worth :-)
> > 
> > Copyright and authorship is anyhow recorded by Git and
> > MAINTAINERS document.
> 
> Ahh, I noticed couple of other drivers doing it so took it as reference
> and adapted here. Seems MAINTAINERS is updated correctly so folks can
> rightly reach out to me for any dsicussion/issues later on.
> 
> Btw thanks for mentioning. Will keep a note for the next time!!

Yeah, there could not be more copyright- and authorship-focus project
than Linux. I mean even this discussion is recorded to lore, and can be
used against me in court ;-) Probably most corporate-safe project in the
world when you think of it.

Br, Jarkko
