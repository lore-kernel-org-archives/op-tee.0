Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CB9EF48C4
	for <op-tee@archiver.kernel.org>; Sat, 14 Feb 2026 12:33:50 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B6E8343838
	for <op-tee@archiver.kernel.org>; Sat, 14 Feb 2026 12:33:49 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YvIrwvzQ;
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 76C754323E
	for <op-tee@lists.trustedfirmware.org>; Sat, 14 Feb 2026 12:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771072411; x=1802608411;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YCR560SceZMWoFT+hZOGG3Q841yflpLrAjRNtMTNlqM=;
  b=YvIrwvzQxRMYcE9mR/i+n9DnH2FbEKyhbycxsaGs0nBTzfD/hzWnh/qE
   HUtXJRPV2JIp4vJWId5ZG7gtWcaMnBtzof8nHI7xUar6WRUyrcFJzo+mo
   QUKjrbNJV+9kFFrhkrERV3mv7mKHw4xEJZ1zUjKqmSReoI133mBHLEdxF
   epaAx7GDymSuI6KiCl8uxVoGi3MqbCcpVGfq/eCBJFmTTrob0XzEF42tJ
   MdjEhWbN66T6a2T5gB0mbIWZNdYnOO/7WGLwZ2DsGDhAACmQbQHx1cUkh
   xfTLHCInOThk0gVyr8AAmlbOcGtJjSSPp/nJ1P19TPZOcXTMs+eGbqzYg
   Q==;
X-CSE-ConnectionGUID: GCeJHD3ZQrmfzbElR1juNw==
X-CSE-MsgGUID: NcxqPAEDTFCELQEBippu8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="82565165"
X-IronPort-AV: E=Sophos;i="6.21,290,1763452800";
   d="scan'208";a="82565165"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2026 04:33:30 -0800
X-CSE-ConnectionGUID: avkfkb8ZTimdIY18Uz98kA==
X-CSE-MsgGUID: MweAp2/NQHGZTQH2fPfrMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,290,1763452800";
   d="scan'208";a="213269477"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 14 Feb 2026 04:33:27 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vrEpw-00000000wWS-0fal;
	Sat, 14 Feb 2026 12:33:24 +0000
Date: Sat, 14 Feb 2026 20:32:36 +0800
From: kernel test robot <lkp@intel.com>
To: Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org
Subject: Re: [RFT PATCH] tee: shm: Remove refcounting of kernel pages
Message-ID: <202602142012.snNfstpn-lkp@intel.com>
References: <20260213113317.1728769-1-sumit.garg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213113317.1728769-1-sumit.garg@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.00 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,intel.com:s:+];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:198.175.65.0/26];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:4983, ipnet:198.175.64.0/23, country:US];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[intel.com:dkim];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[198.175.65.11:from];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[intel.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 76C754323E
X-Spamd-Bar: -----
Message-ID-Hash: JIQIXP3AS7MFGGCTBYOWLK4NJQ27G4OL
X-Message-ID-Hash: JIQIXP3AS7MFGGCTBYOWLK4NJQ27G4OL
X-MailFrom: lkp@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: oe-kbuild-all@lists.linux.dev, vbabka@suse.cz, akpm@linux-foundation.org, willy@infradead.org, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>, Marco Felsch <m.felsch@pengutronix.de>, Sven =?iso-8859-1?Q?P=FCschel?= <s.pueschel@pengutronix.de>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/JIQIXP3AS7MFGGCTBYOWLK4NJQ27G4OL/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Sumit,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.19 next-20260213]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sumit-Garg/tee-shm-Remove-refcounting-of-kernel-pages/20260213-193435
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20260213113317.1728769-1-sumit.garg%40kernel.org
patch subject: [RFT PATCH] tee: shm: Remove refcounting of kernel pages
config: x86_64-randconfig-r073-20260214 (https://download.01.org/0day-ci/archive/20260214/202602142012.snNfstpn-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
smatch version: v0.5.0-8994-gd50c5a4c
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260214/202602142012.snNfstpn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602142012.snNfstpn-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/tee/tee_shm.c: In function 'register_shm_helper':
>> drivers/tee/tee_shm.c:475:13: error: implicit declaration of function 'iter_is_uvec'; did you mean 'iter_is_iovec'? [-Wimplicit-function-declaration]
     475 |         if (iter_is_uvec(iter))
         |             ^~~~~~~~~~~~
         |             iter_is_iovec


vim +475 drivers/tee/tee_shm.c

   399	
   400	static struct tee_shm *
   401	register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 flags,
   402			    int id)
   403	{
   404		struct tee_device *teedev = ctx->teedev;
   405		struct tee_shm *shm;
   406		unsigned long start, addr;
   407		size_t num_pages, off;
   408		ssize_t len;
   409		void *ret;
   410		int rc;
   411	
   412		if (!tee_device_get(teedev))
   413			return ERR_PTR(-EINVAL);
   414	
   415		if (!teedev->desc->ops->shm_register ||
   416		    !teedev->desc->ops->shm_unregister) {
   417			ret = ERR_PTR(-ENOTSUPP);
   418			goto err_dev_put;
   419		}
   420	
   421		teedev_ctx_get(ctx);
   422	
   423		shm = kzalloc(sizeof(*shm), GFP_KERNEL);
   424		if (!shm) {
   425			ret = ERR_PTR(-ENOMEM);
   426			goto err_ctx_put;
   427		}
   428	
   429		refcount_set(&shm->refcount, 1);
   430		shm->flags = flags;
   431		shm->ctx = ctx;
   432		shm->id = id;
   433		addr = untagged_addr((unsigned long)iter_iov_addr(iter));
   434		start = rounddown(addr, PAGE_SIZE);
   435		num_pages = iov_iter_npages(iter, INT_MAX);
   436		if (!num_pages) {
   437			ret = ERR_PTR(-ENOMEM);
   438			goto err_ctx_put;
   439		}
   440	
   441		shm->pages = kcalloc(num_pages, sizeof(*shm->pages), GFP_KERNEL);
   442		if (!shm->pages) {
   443			ret = ERR_PTR(-ENOMEM);
   444			goto err_free_shm;
   445		}
   446	
   447		len = iov_iter_extract_pages(iter, &shm->pages, LONG_MAX, num_pages, 0,
   448					     &off);
   449		if (unlikely(len <= 0)) {
   450			ret = len ? ERR_PTR(len) : ERR_PTR(-ENOMEM);
   451			goto err_free_shm_pages;
   452		} else if (DIV_ROUND_UP(len + off, PAGE_SIZE) != num_pages) {
   453			/*
   454			 * If we only got a few pages, update to release the
   455			 * correct amount below.
   456			 */
   457			shm->num_pages = len / PAGE_SIZE;
   458			ret = ERR_PTR(-ENOMEM);
   459			goto err_put_shm_pages;
   460		}
   461	
   462		shm->offset = off;
   463		shm->size = len;
   464		shm->num_pages = num_pages;
   465	
   466		rc = teedev->desc->ops->shm_register(ctx, shm, shm->pages,
   467						     shm->num_pages, start);
   468		if (rc) {
   469			ret = ERR_PTR(rc);
   470			goto err_put_shm_pages;
   471		}
   472	
   473		return shm;
   474	err_put_shm_pages:
 > 475		if (iter_is_uvec(iter))
   476			unpin_user_pages(shm->pages, shm->num_pages);
   477	err_free_shm_pages:
   478		kfree(shm->pages);
   479	err_free_shm:
   480		kfree(shm);
   481	err_ctx_put:
   482		teedev_ctx_put(ctx);
   483	err_dev_put:
   484		tee_device_put(teedev);
   485		return ret;
   486	}
   487	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
