Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA87DCA0EEB
	for <op-tee@archiver.kernel.org>; Thu, 21 Aug 2025 20:34:39 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0AFF446645
	for <op-tee@archiver.kernel.org>; Thu, 21 Aug 2025 20:34:39 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=e16NItCk;
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5B11442F0C
	for <op-tee@lists.trustedfirmware.org>; Thu, 21 Aug 2025 20:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755808464; x=1787344464;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U0Zv9xWVRHMVUW3bwnQ1taT/AfB91xGbJzGBFeVtNdY=;
  b=e16NItCkMHUSPU/pmZ9UimZTVJIpZFu5e0j9eGVj7eGSnCJHqob211NX
   t2RTjbSxdSvFkIIl1WlZsrAvXxGsd1kqfJ/KPTc1yMNNUveCua8kDz+qv
   zr2PAoiOAw4Xwjo5YDixD/Tz/7magTE6CLwz5fJqflGXcMh0TEr57U1ON
   A5wNaDdfNOvbA6nwFdxx3Fsda+42LWTZw2EG9sBIlgU4JEIxhD8hm9oZU
   DmBGoKXpFez54iLL9uU8ljbTZ+7RSNPtscujrwlFP3TxMGd0K/QPxPG3r
   75JZaqQOK44WFySCYApLVmazJbvC0U9AShWiLaIEx5kG7swhxN/SZtxac
   A==;
X-CSE-ConnectionGUID: 2QO8tiRNRb609b1X8oa9eg==
X-CSE-MsgGUID: qHLUtNDNTJS6onSRLfzUNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="58060801"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400";
   d="scan'208";a="58060801"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 13:34:23 -0700
X-CSE-ConnectionGUID: 5Zh/bL79Q4qiEpcW6oo8Qw==
X-CSE-MsgGUID: vVhSmUzmS+WslFhCOD7wpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400";
   d="scan'208";a="169323007"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 21 Aug 2025 13:34:17 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upBzC-000Kdt-2j;
	Thu, 21 Aug 2025 20:34:14 +0000
Date: Fri, 22 Aug 2025 04:34:03 +0800
From: kernel test robot <lkp@intel.com>
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Sumit Garg <sumit.garg@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Apurupa Pattapu <quic_apurupa@quicinc.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v8 03/11] tee: add TEE_IOCTL_PARAM_ATTR_TYPE_UBUF
Message-ID: <202508220436.qjXO4p8r-lkp@intel.com>
References: <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-3-7066680f138a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-3-7066680f138a@oss.qualcomm.com>
X-Rspamd-Queue-Id: 5B11442F0C
X-Spamd-Bar: --------
X-Spamd-Result: default: False [-8.70 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,intel.com:s:+];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[intel.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:198.175.65.0/26];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	RCVD_IN_DNSWL_MED(-0.20)[198.175.65.17:from];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:4983, ipnet:198.175.64.0/23, country:US];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: U5NMC6VW753UG5EUHQEECXV35RVGO37K
X-Message-ID-Hash: U5NMC6VW753UG5EUHQEECXV35RVGO37K
X-MailFrom: lkp@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: oe-kbuild-all@lists.linux.dev, Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/U5NMC6VW753UG5EUHQEECXV35RVGO37K/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Amirreza,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 5303936d609e09665deda94eaedf26a0e5c3a087]

url:    https://github.com/intel-lab-lkp/linux/commits/Amirreza-Zarrabi/tee-allow-a-driver-to-allocate-a-tee_device-without-a-pool/20250821-074358
base:   5303936d609e09665deda94eaedf26a0e5c3a087
patch link:    https://lore.kernel.org/r/20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-3-7066680f138a%40oss.qualcomm.com
patch subject: [PATCH v8 03/11] tee: add TEE_IOCTL_PARAM_ATTR_TYPE_UBUF
config: arm-randconfig-r133-20250821 (https://download.01.org/0day-ci/archive/20250822/202508220436.qjXO4p8r-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 93d24b6b7b148c47a2fa228a4ef31524fa1d9f3f)
reproduce: (https://download.01.org/0day-ci/archive/20250822/202508220436.qjXO4p8r-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508220436.qjXO4p8r-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/tee/tee_core.c:640:33: sparse: sparse: cast removes address space '__user' of expression

vim +/__user +640 drivers/tee/tee_core.c

   618	
   619	static int params_to_supp(struct tee_context *ctx,
   620				  struct tee_ioctl_param __user *uparams,
   621				  size_t num_params, struct tee_param *params)
   622	{
   623		size_t n;
   624	
   625		for (n = 0; n < num_params; n++) {
   626			struct tee_ioctl_param ip;
   627			struct tee_param *p = params + n;
   628	
   629			ip.attr = p->attr;
   630			switch (p->attr & TEE_IOCTL_PARAM_ATTR_TYPE_MASK) {
   631			case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT:
   632			case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT:
   633				ip.a = p->u.value.a;
   634				ip.b = p->u.value.b;
   635				ip.c = p->u.value.c;
   636				break;
   637			case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT:
   638			case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT:
   639			case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INOUT:
 > 640				ip.a = (u64)p->u.ubuf.uaddr;
   641				ip.b = p->u.ubuf.size;
   642				ip.c = 0;
   643				break;
   644			case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
   645			case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
   646			case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
   647				ip.b = p->u.memref.size;
   648				if (!p->u.memref.shm) {
   649					ip.a = 0;
   650					ip.c = (u64)-1; /* invalid shm id */
   651					break;
   652				}
   653				ip.a = p->u.memref.shm_offs;
   654				ip.c = p->u.memref.shm->id;
   655				break;
   656			default:
   657				ip.a = 0;
   658				ip.b = 0;
   659				ip.c = 0;
   660				break;
   661			}
   662	
   663			if (copy_to_user(uparams + n, &ip, sizeof(ip)))
   664				return -EFAULT;
   665		}
   666	
   667		return 0;
   668	}
   669	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
