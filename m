Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77AE2CD8CA8
	for <op-tee@archiver.kernel.org>; Fri, 12 Jun 2026 13:48:40 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A7A3544D93
	for <op-tee@archiver.kernel.org>; Fri, 12 Jun 2026 13:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1781272119;
	bh=Bhp0IFm7+Cp5BAsXzJWBHTHsg7efmZh/L6u74kV8G6M=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=P/ysYdxsSzjW1mclxfVHAFGlK3szT+sLzaovJyVN6uhTIhstPFOdIxWZXPPGhSFaK
	 BJEI6ZZaBs0kVEh1T3EmgKdab8cWPWuZKyvmQToGhE/ZOQ2VR3jBWUYyEg4Z6Zzq5w
	 PM3w+qti7LR1jBhApXDTDuktR8mdEWnLlkKzwZPpSdr11zJ0wobmbTTyZARJ1b/Jqg
	 tS3pMsHbKeZnJc7S9nvWtCg1j+oGr56g+MD2Na8pgRVIEx3xq5gyFfb5nrtCEtEvsV
	 8EetCi1LsmgFyOe7270IdiDF56TOeyhNdbMq5eIhrJitfZZ0SOsSwohUCgLPyooN7f
	 SXeI1pF6tiKjA==
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7DCCC444F8
	for <op-tee@lists.trustedfirmware.org>; Fri, 12 Jun 2026 13:48:33 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Rl6tkZaC;
	dkim-atps=neutral
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490bb5ad3bdso60235e9.1
        for <op-tee@lists.trustedfirmware.org>; Fri, 12 Jun 2026 06:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781272112; x=1781876912; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LPd03DCEhnxVnAon/lJc1dl4riij9fpdXdHb1nTxRzM=;
        b=Rl6tkZaCXahbBxB9vlcU39vc7Zj+mzSvPs3yzlT++/BtFAaKFra6/UvbS5UUv+tN53
         bksqO0qBEbe19n7Ie/ZYOoxu5Nq4Y+uqpp27JXXsQO8a9HrtmbTybmDUQcXJ5w45JI1D
         eyZAghOFU4jQBQF3T5DsQabAYuFsVS5Ypl6+jWMQqAYc1/ZQ3+DNa8W5kvk9k3OHUhvV
         O9gDW/qSatDgCM25fijRacwEU/HLG+f/Rhbd2QnamXRxMYXJsJ2WxQntjCdymc8g1lf7
         4FYlTtnThGrbEsCpnf8DeLQti02TD/25l0gySvhJS/2SXfUyEesfH7+vPxNR9O/G4QxK
         1q1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781272112; x=1781876912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPd03DCEhnxVnAon/lJc1dl4riij9fpdXdHb1nTxRzM=;
        b=RKY2oPi7wdtRXdKeW5NtL1l3Xrn3IULa8NwZsjs2Bzx1Kth6mFZd7ePaKakkn+C/tG
         87SqUPLnlfYYOpKr4PW5k2ZY0FutpPzzwWXTr4zpY8iEfhUcjkvbSAyciApkPEnXPbls
         HU2hr5Inv48zbzQgINQV6NhTgUalFU6QIyPA5TAlRRY4Yvh31W9HdpzAvMazaXjnRTaF
         2oFJGbMTafwYnvGPeMdHRigyjac8TiMBmq+bywAGOfNmcEkoEx2q7YpDeTxI0hpzC4bY
         YzoZjzhbcm1YTN/NBdyhvA4AvSdGtq6up1z/yDRq4NVCO2zszvzaszmC2bcxbf0PIxRJ
         DNdA==
X-Gm-Message-State: AOJu0Yy/p/kU7k6BxSulzMEhbRxwtWhnZDobwelpbzY2ccq1zwcfVRR5
	mrbUao72KoNfmyTwzneVo3OgbwaGzRI8X5wowX94cb/UCwxNMEnWh4OsSMMue1nSFQ==
X-Gm-Gg: Acq92OGtx3TBOGjLzR7Qh9s5u80gcwmJ4qxZxN4pHOZj1Ym6y5sVma1iinfm+p6APp6
	VxpnUO9nTIPzNhAlop8dFm699yLjkceY9rmM8DP1X1M+Lgo9OAotQn02bDlkKWnHSF+WHoWqKab
	1wtyC6VtiNXMPhtJz7FTl9ADdfpeMsDbPPO2NTqAA/XQdGzR52sWfXSLwQgjVFGTmtwJe02RjX+
	IMUoFheMVvQPyqkZ7fnNN2g1SoG/vuz1WEA0SBM7Tcslja57LloB5WblqrRtllSOaSBuc23DiVm
	2eIZfSxCdNyxlOT33qpSikQo93gzC43MUqYtSwc+O2DMdi2iYhN5s+uzOv0RUcAQeN3YkheDylC
	UTsTfvQ+tKFP5QBaBe+YN7tlWkaRmUxylwPOs23Ju8Jp55Q6TcLp4Ucvur0Zr/IPaWa3Mmlg6xi
	FHEKNfQIS1GfHUPBjz+QS+4WjpJGLhatM+PfwzVfJGqHieO5OBrik4Dtu3Qg/+u09GLA8x4g==
X-Received: by 2002:a05:600c:a149:b0:490:be1f:66bc with SMTP id 5b1f17b1804b1-490ea57d327mr1097535e9.4.1781272111887;
        Fri, 12 Jun 2026 06:48:31 -0700 (PDT)
Received: from google.com (143.11.148.146.bc.googleusercontent.com. [146.148.11.143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e2d09a85sm146043915e9.14.2026.06.12.06.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:48:31 -0700 (PDT)
Date: Fri, 12 Jun 2026 13:48:27 +0000
To: Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH v6 3/6] firmware: arm_ffa: Fix Endpoint Memory Access
 Descriptor offset calculation
Message-ID: <aiwOKyXN_68A54_0@google.com>
References: <20260527150236.1978655-1-smostafa@google.com>
 <20260527150236.1978655-4-smostafa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527150236.1978655-4-smostafa@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.50:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[google.com:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.128.50:from,146.148.11.143:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 7DCCC444F8
X-Spamd-Bar: ----
Message-ID-Hash: 5ZWGMDXKVDAS2LVWDMQIKBMCYLDUNCMX
X-Message-ID-Hash: 5ZWGMDXKVDAS2LVWDMQIKBMCYLDUNCMX
X-MailFrom: sebastianene@google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, sumit.garg@kernel.org, vdonnefort@google.com, sudeep.holla@kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/5ZWGMDXKVDAS2LVWDMQIKBMCYLDUNCMX/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sebastian Ene via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sebastian Ene <sebastianene@google.com>

On Wed, May 27, 2026 at 03:02:33PM +0000, Mostafa Saleh wrote:

Hi Mostafa,

> From: Sebastian Ene <sebastianene@google.com>
> 
> Use the descriptor's `ep_mem_offset` to calculate the start of the endpoint
> memory access array and to comply with the FF-A spec instead of defaulting
> to `sizeof(struct ffa_mem_region)`.
> This requires moving `ffa_mem_region_additional_setup()` earlier in the setup
> flow.
> Also, add sanity checks to ensure the calculated descriptor offsets do not
> exceed `max_fragsize`.
> [@Mostafa Harden error checking]
> 
> Fixes: 113580530ee7 ("firmware: arm_ffa: Update memory descriptor to support v1.1 format")
> Signed-off-by: Sebastian Ene <sebastianene@google.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  drivers/firmware/arm_ffa/driver.c | 16 +++++++++++-----
>  include/linux/arm_ffa.h           |  2 +-
>  2 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> index 059e2aae7ca0..bed4bd48963f 100644
> --- a/drivers/firmware/arm_ffa/driver.c
> +++ b/drivers/firmware/arm_ffa/driver.c
> @@ -703,19 +703,26 @@ ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
>  	struct ffa_composite_mem_region *composite;
>  	struct ffa_mem_region_addr_range *constituents;
>  	struct ffa_mem_region_attributes *ep_mem_access;
> -	u32 idx, frag_len, length, buf_sz = 0, num_entries = sg_nents(args->sg);
> +	u32 idx, frag_len, length, buf_sz = 0, num_entries = sg_nents(args->sg), ep_offset;
> +	u32 emad_size = ffa_emad_size_get(drv_info->version);
>  
>  	mem_region->tag = args->tag;
>  	mem_region->flags = args->flags;
>  	mem_region->sender_id = drv_info->vm_id;
>  	mem_region->attributes = ffa_memory_attributes_get(func_id);
> +
> +	ffa_mem_region_additional_setup(drv_info->version, mem_region);
>  	composite_offset = ffa_mem_desc_offset(buffer, args->nattrs,
>  					       drv_info->version);
> +	if (composite_offset + sizeof(*composite) > max_fragsize)
> +		return -ENXIO;
>  
>  	for (idx = 0; idx < args->nattrs; idx++) {
> -		ep_mem_access = buffer +
> -			ffa_mem_desc_offset(buffer, idx, drv_info->version);
> -		memset(ep_mem_access, 0, ffa_emad_size_get(drv_info->version));
> +		ep_offset = ffa_mem_desc_offset(buffer, idx, drv_info->version);
> +		if (ep_offset + emad_size > max_fragsize)
> +			return -ENXIO;

Looking between v3 (the version that I sent) and this version, you
account correctly for the emad_size which depends on the FF-A version
(thus the introduced call to ffa_emad_size_get()).

I think the only remaining bit here is making sure that we don't
overflow in `ep_offset + emad_size`.

> +		ep_mem_access = buffer + ep_offset;
> +		memset(ep_mem_access, 0, emad_size);
>  		ep_mem_access->receiver = args->attrs[idx].receiver;
>  		ep_mem_access->attrs = args->attrs[idx].attrs;
>  		ep_mem_access->composite_off = composite_offset;
> @@ -725,7 +732,6 @@ ffa_setup_and_transmit(u32 func_id, void *buffer, u32 max_fragsize,
>  	}
>  	mem_region->handle = 0;
>  	mem_region->ep_count = args->nattrs;
> -	ffa_mem_region_additional_setup(drv_info->version, mem_region);
>  
>  	composite = buffer + composite_offset;
>  	composite->total_pg_cnt = ffa_get_num_pages_sg(args->sg);
> diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
> index 81e603839c4a..62d67dae8b70 100644
> --- a/include/linux/arm_ffa.h
> +++ b/include/linux/arm_ffa.h
> @@ -445,7 +445,7 @@ ffa_mem_desc_offset(struct ffa_mem_region *buf, int count, u32 ffa_version)
>  	if (!FFA_MEM_REGION_HAS_EP_MEM_OFFSET(ffa_version))
>  		offset += offsetof(struct ffa_mem_region, ep_mem_offset);
>  	else
> -		offset += sizeof(struct ffa_mem_region);
> +		offset += buf->ep_mem_offset;
>  
>  	return offset;
>  }
> -- 
> 2.54.0.746.g67dd491aae-goog
>

Thanks,
Sebastian
