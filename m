Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD70C5AC7A
	for <op-tee@archiver.kernel.org>; Fri,  7 Aug 2026 19:05:27 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 18BEE43EF3
	for <op-tee@archiver.kernel.org>; Fri,  7 Aug 2026 19:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1786129527;
	bh=rGW2ghxHJSBOukFdza6iEefzh7vnqBDByvp5KyzDRoQ=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=zoQLUWhvFTn8AvnsDFNzTt9rhUVM+LmL10pEF2+/X4QUd+LZLgQXZ0opNhjB60ccy
	 +UryQx1bQ44AQ8wdaYxUesanw5BnPGnJDRK+kyLUNjcUSaUEcpBY9Blbv99gX7T4CX
	 KWsCggY08D/0kEJEY/cG6Icy7EUnUVrvrCukc0dwT+w8JPZzFmIe4UlHDef0NrADVk
	 Pm/W1/UARPl+S94E7kR4uF4F85hiGXbTC7n3fi6W4Seu4HRrWlD1/RxVNM71EyoxP9
	 k37uIBc1lAu71zavhUxw9ydljQ/2C9do5x8kgjmYoEIghnbOoVpv9DVuktkVvKy0fS
	 ueiyaoEA3dgPg==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 471E043EF3
	for <op-tee@lists.trustedfirmware.org>; Fri,  7 Aug 2026 19:05:20 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JnMAxCq+;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8B5D36136E;
	Fri,  7 Aug 2026 19:05:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08BA71F000E9;
	Fri,  7 Aug 2026 19:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786129519;
	bh=3fSuyO8GJZ4kDdfxC451OM8OXFJyZ3cvtiX/sTHt2mc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JnMAxCq+dToC4REzUAPQKT6vnPPMciXJOEhYoh4pA2kecgge08K/PhhvcRE0qcuOI
	 WQYwPmksF2lnmbd//EXz1xNKltWZ90v9L2kYJmhc8HlG0KVPzJ96OWRCZDyWnm70pR
	 9CgINIYc4gtDGPEQrNh+njk52FRGYkce5IZSuAoQxRwJIZPkjLELc0kWbFQ81LLIob
	 /R0/c5M2rN3RoBat8lmmMzPI/wqoXqq+nISLkkn/zQtmHb7hF53lzvF0pe4Q0Aa4CI
	 TdIeKtJhfekj2hra1BLhcKJSdOM3OCW60mquJbITVgF71H2LNSxmPwue1f81ylblN2
	 jmOCeWlDN245A==
Date: Fri, 7 Aug 2026 12:05:13 -0700
To: Julian Braha <julianbraha@gmail.com>
Subject: Re: [PATCH v3] tee: remove TZMEM_MODE_GENERIC
Message-ID: <20260807190513.GA2638974@ax162>
References: <20260807175041.3299349-1-julianbraha@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807175041.3299349-1-julianbraha@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.00 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 471E043EF3
X-Spamd-Bar: -------
Message-ID-Hash: 5SNWIE22WPBV22U54CL4SN4R5SSTZ6BY
X-Message-ID-Hash: 5SNWIE22WPBV22U54CL4SN4R5SSTZ6BY
X-MailFrom: nathan@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: amirreza.zarrabi@oss.qualcomm.com, jenswi@kernel.org, sumit.garg@kernel.org, arnd@arndb.de, geert+renesas@glider.be, amirreza.zarrabi@oss.qualcomm.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, quic_eberman@quicinc.com, andersson@kernel.org, brgl@kernel.org, harshal.dev@oss.qualcomm.com, nsc@kernel.org, jani.nikula@linux.intel.com, kees@kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/5SNWIE22WPBV22U54CL4SN4R5SSTZ6BY/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Nathan Chancellor via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Nathan Chancellor <nathan@kernel.org>

On Fri, Aug 07, 2026 at 06:50:41PM +0100, Julian Braha wrote:
> 'select' does not work on config options in a 'choice', so currently it is
> possible to enable QCOMTEE without QCOM_TZMEM_MODE_SHMBRIDGE, even though
> this is needed at runtime.
> 
> There are no users of the generic allocator option,
> QCOM_TZMEM_MODE_GENERIC, so let's remove it. Then, we can remove the
> containing choice..endchoice, which allows the 'select' to work as
> intended.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Julian Braha <julianbraha@gmail.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

One small nit below but I would only send v4 if there are other things
to be addressed.

A note to the maintainers: We would like to turn selecting a choice
symbol into a hard error in 7.4, so please consider picking this up for
7.3-rc1.

> ---
> Changes since v2:
> - add back stubs for when CONFIG_QCOM_TZMEM_MODE_GENERIC=n
> - updated help text accordingly
> 
> Link:
> https://lore.kernel.org/all/20260729203845.387239-1-julianbraha@gmail.com/
> 
> Changes since v1:
> - remove TZMEM_MODE_GENERIC instead of removing the dead select
> 
> Link:
> https://lore.kernel.org/all/20260715092539.18384-1-julianbraha@gmail.com/
> ---
>  drivers/firmware/qcom/Kconfig      | 26 +++++---------------------
>  drivers/firmware/qcom/qcom_tzmem.c |  4 ++--
>  2 files changed, 7 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
> index c7f8413ab996..95b968d88dc3 100644
> --- a/drivers/firmware/qcom/Kconfig
> +++ b/drivers/firmware/qcom/Kconfig
> @@ -34,33 +34,17 @@ config QCOM_TZMEM
>  	tristate
>  	select GENERIC_ALLOCATOR
>  
> -choice
> -	prompt "TrustZone interface memory allocator mode"
> -	depends on QCOM_TZMEM
> -	default QCOM_TZMEM_MODE_GENERIC
> -	help
> -	  Selects the mode of the memory allocator providing memory buffers of
> -	  suitable format for sharing with the TrustZone. If in doubt, select
> -	  'Generic'.
> -
> -config QCOM_TZMEM_MODE_GENERIC
> -	bool "Generic"
> -	help
> -	  Use the generic allocator mode. The memory is page-aligned, non-cachable
> -	  and physically contiguous.
> -
>  config QCOM_TZMEM_MODE_SHMBRIDGE
> -	bool "SHM Bridge"
> +	bool "TrustZone interface memory allocator: SHM Bridge"
> +	depends on QCOM_TZMEM
>  	help
> -	  Use Qualcomm Shared Memory Bridge. The memory has the same alignment as
> -	  in the 'Generic' allocator but is also explicitly marked as an SHM Bridge
> -	  buffer.
> +	  Use Qualcomm Shared Memory Bridge as memory allocator. The memory has the
> +	  same alignment as in the 'Generic' allocator, which is used when this option
> +	  is disabled, but is also explicitly marked as an SHM Bridge buffer.
>  
>  	  With this selected, all buffers passed to the TrustZone must be allocated
>  	  using the TZMem allocator or else the TrustZone will refuse to use them.
>  
> -endchoice
> -
>  config QCOM_QSEECOM
>  	bool "Qualcomm QSEECOM interface driver"
>  	depends on QCOM_SCM=y
> diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmware/qcom/qcom_tzmem.c
> index 0fd9581275f1..510474902c3a 100644
> --- a/drivers/firmware/qcom/qcom_tzmem.c
> +++ b/drivers/firmware/qcom/qcom_tzmem.c
> @@ -50,7 +50,7 @@ static struct device *qcom_tzmem_dev;
>  static RADIX_TREE(qcom_tzmem_chunks, GFP_ATOMIC);
>  static DEFINE_SPINLOCK(qcom_tzmem_chunks_lock);
>  
> -#if IS_ENABLED(CONFIG_QCOM_TZMEM_MODE_GENERIC)
> +#ifndef CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE

I realize you likely did this to keep the diff small but I think
negative conditional checks are harder to read than positive ones, so I
would consider making this an '#ifdef' and flipping the branches.

>  static int qcom_tzmem_init(void)
>  {
> @@ -67,7 +67,7 @@ static void qcom_tzmem_cleanup_area(struct qcom_tzmem_area *area)
>  
>  }
>  
> -#elif IS_ENABLED(CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE)
> +#else
>  
>  #include <linux/firmware/qcom/qcom_scm.h>
>  #include <linux/of.h>
> -- 
> 2.55.0
> 

-- 
Cheers,
Nathan
