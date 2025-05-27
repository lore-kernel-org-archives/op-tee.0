Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24EDDC5B542
	for <op-tee@archiver.kernel.org>; Tue, 27 May 2025 21:29:00 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4499B45205
	for <op-tee@archiver.kernel.org>; Tue, 27 May 2025 21:28:59 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=D5ufoaLL;
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 411F33F832
	for <op-tee@lists.trustedfirmware.org>; Tue, 27 May 2025 21:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748381320; x=1779917320;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pvfxwe5X86PEZiMzFXgJ3ebwhN+gbHIPHFzJHUdFvdU=;
  b=D5ufoaLLHg9hmUyvAnbuB4FQpQWyNGiD7me4dSracejk1VV4ichAskyr
   lSy9zt1NNs/RbAIHBs/06bvJaIgTG1DlsH4+ViBGIfKvQIh4ZqvW6fjC/
   EEh0rYfVm2GDKJl83d80ZUbjDRWJaV2/Ifq8fpPEL8y5Rnu4YZiJAU+O0
   LbdcyM2syqVT9krybUy5W9QnP07jURtObODhzQwGoFDdXGSsStL5YDZzZ
   fJJD5aMRx05EFK7RwSyOt5BJ466aAHSDUcP19tx3pNozT6ZCKaiqYyZEQ
   1mltbBVtqfLoVLpOpMKK0jLm2XBF939LdOwe18qCkPTdFZwR4ssapPRGR
   Q==;
X-CSE-ConnectionGUID: sY9JW61TSMyXTT6hxviEOA==
X-CSE-MsgGUID: LNjLprNWRECQCHxoybQ1LA==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="50390365"
X-IronPort-AV: E=Sophos;i="6.15,319,1739865600";
   d="scan'208";a="50390365"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 14:28:39 -0700
X-CSE-ConnectionGUID: hfdT22DnS6m7rAqHRMUh6Q==
X-CSE-MsgGUID: dv0lT3O0QW2I1eH/5eXZTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,319,1739865600";
   d="scan'208";a="143953217"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 27 May 2025 14:28:33 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uK1qZ-000V1c-1Y;
	Tue, 27 May 2025 21:28:31 +0000
Date: Wed, 28 May 2025 05:28:14 +0800
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
Subject: Re: [PATCH v5 09/12] tee: add Qualcomm TEE driver
Message-ID: <202505280538.DVSrdWK7-lkp@intel.com>
References: <20250526-qcom-tee-using-tee-ss-without-mem-obj-v5-9-024e3221b0b9@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526-qcom-tee-using-tee-ss-without-mem-obj-v5-9-024e3221b0b9@oss.qualcomm.com>
X-Spamd-Bar: ------------
X-Spamd-Result: default: False [-12.70 / 15.00];
	REPLY(-4.00)[];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,intel.com:s:+];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[intel.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	RCVD_IN_DNSWL_MED(-0.20)[198.175.65.17:from];
	R_SPF_ALLOW(-0.20)[+ip4:198.175.65.0/26];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:4983, ipnet:198.175.64.0/23, country:US];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 411F33F832
Message-ID-Hash: MCIVVIWX366WT4ZUE3RPPWUEVRRQOAH3
X-Message-ID-Hash: MCIVVIWX366WT4ZUE3RPPWUEVRRQOAH3
X-MailFrom: lkp@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: oe-kbuild-all@lists.linux.dev, Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/MCIVVIWX366WT4ZUE3RPPWUEVRRQOAH3/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Amirreza,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 3be1a7a31fbda82f3604b6c31e4f390110de1b46]

url:    https://github.com/intel-lab-lkp/linux/commits/Amirreza-Zarrabi/tee-allow-a-driver-to-allocate-a-tee_device-without-a-pool/20250527-151020
base:   3be1a7a31fbda82f3604b6c31e4f390110de1b46
patch link:    https://lore.kernel.org/r/20250526-qcom-tee-using-tee-ss-without-mem-obj-v5-9-024e3221b0b9%40oss.qualcomm.com
patch subject: [PATCH v5 09/12] tee: add Qualcomm TEE driver
config: i386-randconfig-062-20250528 (https://download.01.org/0day-ci/archive/20250528/202505280538.DVSrdWK7-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250528/202505280538.DVSrdWK7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505280538.DVSrdWK7-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/tee/qcomtee/call.c:227:38: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *uaddr @@     got void *[noderef] uaddr @@
   drivers/tee/qcomtee/call.c:227:38: sparse:     expected void [noderef] __user *uaddr
   drivers/tee/qcomtee/call.c:227:38: sparse:     got void *[noderef] uaddr

vim +227 drivers/tee/qcomtee/call.c

   203	
   204	/**
   205	 * qcomtee_params_to_args() - Convert TEE parameters to QTEE arguments.
   206	 * @u: QTEE arguments.
   207	 * @params: TEE parameters.
   208	 * @num_params: number of elements in the parameter array.
   209	 * @ctx: context in which the conversion should happen.
   210	 *
   211	 * It assumes @u has at least @num_params + 1 entries and has been initialized
   212	 * with %QCOMTEE_ARG_TYPE_INV as &struct qcomtee_arg.type.
   213	 *
   214	 * Return: On success, returns 0; on failure, returns < 0.
   215	 */
   216	static int qcomtee_params_to_args(struct qcomtee_arg *u,
   217					  struct tee_param *params, int num_params,
   218					  struct tee_context *ctx)
   219	{
   220		int i;
   221	
   222		for (i = 0; i < num_params; i++) {
   223			switch (params[i].attr) {
   224			case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT:
   225			case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT:
   226				u[i].flags = QCOMTEE_ARG_FLAGS_UADDR;
 > 227				u[i].b.uaddr = params[i].u.ubuf.uaddr;
   228				u[i].b.size = params[i].u.ubuf.size;
   229	
   230				if (params[i].attr ==
   231				    TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT)
   232					u[i].type = QCOMTEE_ARG_TYPE_IB;
   233				else /* TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT */
   234					u[i].type = QCOMTEE_ARG_TYPE_OB;
   235	
   236				break;
   237			case TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT:
   238				u[i].type = QCOMTEE_ARG_TYPE_IO;
   239				if (qcomtee_objref_to_arg(&u[i], &params[i], ctx))
   240					goto out_failed;
   241	
   242				break;
   243			case TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT:
   244				u[i].type = QCOMTEE_ARG_TYPE_OO;
   245				u[i].o = NULL_QCOMTEE_OBJECT;
   246				break;
   247			default:
   248				goto out_failed;
   249			}
   250		}
   251	
   252		return 0;
   253	
   254	out_failed:
   255		/* Undo qcomtee_objref_to_arg(). */
   256		for (i--; i >= 0; i--) {
   257			if (u[i].type != QCOMTEE_ARG_TYPE_IO)
   258				continue;
   259	
   260			qcomtee_user_object_set_notify(u[i].o, false);
   261			if (typeof_qcomtee_object(u[i].o) == QCOMTEE_OBJECT_TYPE_CB)
   262				qcomtee_object_put(u[i].o);
   263	
   264			qcomtee_object_put(u[i].o);
   265		}
   266	
   267		return -EINVAL;
   268	}
   269	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
