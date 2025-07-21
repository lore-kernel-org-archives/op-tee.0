Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB095C83F1A
	for <op-tee@archiver.kernel.org>; Mon, 21 Jul 2025 10:57:29 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 260C445451
	for <op-tee@archiver.kernel.org>; Mon, 21 Jul 2025 10:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1753095449;
	bh=G4P6/2JTGrggH0efUzuDB2Z/ZXbJ0SjII+o3EJPGz2U=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Ekl5+OfEDT9UwQU1iMqAwVR7hExt4tiFdQdr+7oqFdQBt4YwU8e/aKz5SWUwWUS2T
	 imDgeF2BQtXzKoUSY0tQJ5eJ3EPD2qos6joC0qAUVnrTXogrDy/jlCSFYiAGmev3et
	 cH1prY1gzZ7thIaZUseHtgaNRhIXZo0Cbi9wuleVHXP1nunqMdo642mrkXtqFOrvMa
	 Z+PfgFH5URlF4WuT1K+jWg7jL8gm7r37CGZHXqceF3DrprUwFVfhWuZaKKtJKaFPZA
	 6/jGgWrOR6g3XUZ4to9smx97n+QuvavpQFgVtT691KW1hDN1sjxGA/x1KGyCxeESbF
	 HQZDD/fMpp89g==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B15ED3F678
	for <op-tee@lists.trustedfirmware.org>; Mon, 21 Jul 2025 10:57:03 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CZ3EYNJn;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 127AF43A03;
	Mon, 21 Jul 2025 10:57:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F39CC4CEED;
	Mon, 21 Jul 2025 10:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753095422;
	bh=G4P6/2JTGrggH0efUzuDB2Z/ZXbJ0SjII+o3EJPGz2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CZ3EYNJnCZsdoKuUkT8rs31DLTwT/e6QucWVHW/x4X+RyHAEW0wl++6/dbugAqXdJ
	 QFD8+wE5KYraHyjzq3HmYqD7sPfzooBmkfY0ViB3a5H4wIiJEU3R2mxOFOuIO5jNBO
	 zv/sYKkHSg9/lkngYDcsMdXXxH2iIsf9/o0P2xVPjOlEfvzcTthnjzX6ochIw8RLIO
	 xim3moRP8OZiWMpfuMR/dILib1YoQWJS8nT1dVEg88mp2V76p4gpT+JO6iH0B3OXYB
	 tVYoj9XUSZ19aIfr6q4ctqUWOhWdoGFm5sbfmZsic5AA35NTirp5uFfsTJhYY7aNR9
	 /bUj5GkI9GOTQ==
Date: Mon, 21 Jul 2025 16:26:57 +0530
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Subject: Re: [PATCH] drivers: tee: improve sysfs interface by using
 sysfs_emit()
Message-ID: <aH4c-bAN28Gmq86k@sumit-X1>
References: <aHpohUxxSH42w16U@bhairav-test.ee.iitb.ac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHpohUxxSH42w16U@bhairav-test.ee.iitb.ac.in>
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B15ED3F678
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-5.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,lists.trustedfirmware.org,vger.kernel.org,gmail.com,linuxfoundation.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Action: no action
Message-ID-Hash: 742QICR5COY7YQNINWGCSF37Y4RCX6NN
X-Message-ID-Hash: 742QICR5COY7YQNINWGCSF37Y4RCX6NN
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, akhileshpatilvnit@gmail.com, skhan@linuxfoundation.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/742QICR5COY7YQNINWGCSF37Y4RCX6NN/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Fri, Jul 18, 2025 at 09:00:13PM +0530, Akhilesh Patil wrote:
> Replace scnprintf() with sysfs_emit() while formatting buffer that is
> passed to userspace as per the recommendation in
> Documentation/filesystems/sysfs.rst. sysfs _show() callbacks should use
> sysfs_emit() or sysfs_emit_at() while returning values to the userspace.
> This change does not impact functionality, but aligns with sysfs
> interface usage guidelines for the tee driver.
> 
> Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> ---
>  drivers/tee/optee/core.c | 2 +-
>  drivers/tee/tee_core.c   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Nice catch.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index c75fddc83576..ce44e3498d37 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -72,7 +72,7 @@ static ssize_t rpmb_routing_model_show(struct device *dev,
>  	else
>  		s = "user";
>  
> -	return scnprintf(buf, PAGE_SIZE, "%s\n", s);
> +	return sysfs_emit(buf, "%s\n", s);
>  }
>  static DEVICE_ATTR_RO(rpmb_routing_model);
>  
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index acc7998758ad..944f913f8592 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -977,7 +977,7 @@ static ssize_t implementation_id_show(struct device *dev,
>  	struct tee_ioctl_version_data vers;
>  
>  	teedev->desc->ops->get_version(teedev, &vers);
> -	return scnprintf(buf, PAGE_SIZE, "%d\n", vers.impl_id);
> +	return sysfs_emit(buf, "%d\n", vers.impl_id);
>  }
>  static DEVICE_ATTR_RO(implementation_id);
>  
> -- 
> 2.34.1
> 
