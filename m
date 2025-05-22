Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAFE3C54E90
	for <op-tee@archiver.kernel.org>; Thu, 22 May 2025 16:50:36 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E3F23430E1
	for <op-tee@archiver.kernel.org>; Thu, 22 May 2025 16:50:35 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NDMhW3rA;
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 76ADE43096
	for <op-tee@lists.trustedfirmware.org>; Thu, 22 May 2025 16:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747932615; x=1779468615;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WAQaKse2ihBxfu0TJ9aEs4/TLMUkglE0FPdyzXEACyg=;
  b=NDMhW3rAbFiuePF43ilafJA4YtWevh8/3hfTA/q0jyR9Br5ERanu+jeg
   bb+T40cDLpB2CNLUB3aMz+Qfu/AgRJizyZZ29SlAHgvuR9VOaKnqnkiMs
   HAK38Rqbq/Vj5yIF94k+35Bx6eke3c6Jp/GpafkMk6hurKz8klNimoedM
   dWpJDpvZVQTaqlu/PwworLUCXibbKmRGb7GHCAWqyRJ+BzulZw9DBjWWL
   sKGZF2W2jd2wwgSERNweRrrTBjDKkbisVMullrhxOIM9MR95qkoS+XaHx
   OaK1x5gl3fIT8KCS3u/tI7YKDKoyepsBDrAcNLCverkf3zpy/o1rCv7RG
   g==;
X-CSE-ConnectionGUID: NuqxbpwvQz+eu6KZHvdK1A==
X-CSE-MsgGUID: MZ3I2Pm6TS+HSZbcP9eygw==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="53783833"
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600";
   d="scan'208";a="53783833"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 09:50:14 -0700
X-CSE-ConnectionGUID: k2um+OxgQP2XgqQbU3n+og==
X-CSE-MsgGUID: BSIuWrpQQNafNT2SQQcBPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600";
   d="scan'208";a="145550047"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 22 May 2025 09:50:05 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uI97L-000PWq-2Q;
	Thu, 22 May 2025 16:50:03 +0000
Date: Fri, 23 May 2025 00:49:07 +0800
From: kernel test robot <lkp@intel.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	op-tee@lists.trustedfirmware.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 6/9] tee: add tee_shm_alloc_dma_mem()
Message-ID: <202505230242.8jtn9m5R-lkp@intel.com>
References: <20250520152436.474778-7-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520152436.474778-7-jens.wiklander@linaro.org>
X-Spamd-Bar: -------
X-Spamd-Result: default: False [-7.50 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,intel.com:s:+];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[intel.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	RBL_SENDERSCORE_REPUT_9(-1.00)[198.175.65.14:from];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:198.175.65.0/26];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[lists.linux.dev,nxp.com,gmail.com,mediatek.com,linaro.org,collabora.com,arm.com,google.com,amd.com,kernel.org,qti.qualcomm.com,ffwll.ch,fooishbar.org];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:4983, ipnet:198.175.64.0/23, country:US];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DNSWL_BLOCKED(0.00)[198.175.65.14:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 76ADE43096
Message-ID-Hash: SPLWMNLUDBHPEZCUIKVKNO5GEMWR5ZJY
X-Message-ID-Hash: SPLWMNLUDBHPEZCUIKVKNO5GEMWR5ZJY
X-MailFrom: lkp@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: oe-kbuild-all@lists.linux.dev, Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Sumit Garg <sumit.garg@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/SPLWMNLUDBHPEZCUIKVKNO5GEMWR5ZJY/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Jens,

kernel test robot noticed the following build errors:

[auto build test ERROR on b4432656b36e5cc1d50a1f2dc15357543add530e]

url:    https://github.com/intel-lab-lkp/linux/commits/Jens-Wiklander/optee-sync-secure-world-ABI-headers/20250520-232546
base:   b4432656b36e5cc1d50a1f2dc15357543add530e
patch link:    https://lore.kernel.org/r/20250520152436.474778-7-jens.wiklander%40linaro.org
patch subject: [PATCH v9 6/9] tee: add tee_shm_alloc_dma_mem()
config: um-randconfig-r123-20250522 (https://download.01.org/0day-ci/archive/20250523/202505230242.8jtn9m5R-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250523/202505230242.8jtn9m5R-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505230242.8jtn9m5R-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: "memremap" [drivers/tee/tee.ko] undefined!
ERROR: modpost: "memunmap" [drivers/tee/tee.ko] undefined!
>> ERROR: modpost: "dma_alloc_pages" [drivers/tee/tee.ko] undefined!
>> ERROR: modpost: "dma_free_pages" [drivers/tee/tee.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
