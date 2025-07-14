Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FD2C83F17
	for <op-tee@archiver.kernel.org>; Mon, 14 Jul 2025 18:50:33 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4D66D45B08
	for <op-tee@archiver.kernel.org>; Mon, 14 Jul 2025 18:50:32 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Qyu7Fvom;
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 43F3842DFF
	for <op-tee@lists.trustedfirmware.org>; Mon, 14 Jul 2025 18:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752519001; x=1784055001;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g/hdVwW4OrDEpaJ2jeOYNUGdpDfpOP3FpqeHfrFX5Q4=;
  b=Qyu7FvomqSBeaQc4dV6s/XpHySGK/WmhngPKChdZIiyzTemp/mHHxUQ+
   wkUT1zRxuQOKWgJCeK80t6lJiUIreM8+T5JWn7zymnULEGtL+GoMKPYr0
   3CqmBSR5DTzhVd7QgK+90ybNOQv4pHatS+yVpHACHiWFDXQkXDv/0oMMK
   K8Kbs9EsFFNY32IQ+5PBcEjgCQ8Kv0JZ2Y/UYY6/yt4xurj9wpw9GCuro
   9B6tiLWAtdmNdOI0CzGppga0ZVaVlnIRjjd7fvaCyaIiFaKQsmXhTTEB8
   8TyR3yuCDTQ80rNQUbuKhpYD2F+SpgDF5nwxT7zHdtRDtnsYKH0Zx9I+L
   Q==;
X-CSE-ConnectionGUID: iP8XbWbBS3eKRxEHQxwhvg==
X-CSE-MsgGUID: rrBYtLvFQIeVKhI4L2figw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="66171357"
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600";
   d="scan'208";a="66171357"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 11:50:00 -0700
X-CSE-ConnectionGUID: n6iP6M2LTgWMCXmgik1TTw==
X-CSE-MsgGUID: LOJAA0uFQLidXjoFjsHfaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600";
   d="scan'208";a="156651276"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 14 Jul 2025 11:49:54 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubOFM-0009EJ-1n;
	Mon, 14 Jul 2025 18:49:52 +0000
Date: Tue, 15 Jul 2025 02:49:15 +0800
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
Subject: Re: [PATCH v6 09/12] tee: add Qualcomm TEE driver
Message-ID: <202507150221.oWiaX1I9-lkp@intel.com>
References: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-9-697fb7d41c36@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-9-697fb7d41c36@oss.qualcomm.com>
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 43F3842DFF
X-Spamd-Bar: ------
X-Spamd-Result: default: False [-6.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,intel.com:s:+];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:198.175.65.0/26];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:4983, ipnet:198.175.64.0/23, country:US];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RBL_SENDERSCORE_REPUT_BLOCKED(0.00)[198.175.65.12:from];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[intel.com:dkim];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[198.175.65.12:from];
	DKIM_TRACE(0.00)[intel.com:+]
X-Rspamd-Action: no action
Message-ID-Hash: CGGHSIIVOWK64H5PJM3GUZBYJLFEBOIA
X-Message-ID-Hash: CGGHSIIVOWK64H5PJM3GUZBYJLFEBOIA
X-MailFrom: lkp@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: oe-kbuild-all@lists.linux.dev, Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/CGGHSIIVOWK64H5PJM3GUZBYJLFEBOIA/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Amirreza,

kernel test robot noticed the following build errors:

[auto build test ERROR on 835244aba90de290b4b0b1fa92b6734f3ee7b3d9]

url:    https://github.com/intel-lab-lkp/linux/commits/Amirreza-Zarrabi/tee-allow-a-driver-to-allocate-a-tee_device-without-a-pool/20250714-085215
base:   835244aba90de290b4b0b1fa92b6734f3ee7b3d9
patch link:    https://lore.kernel.org/r/20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-9-697fb7d41c36%40oss.qualcomm.com
patch subject: [PATCH v6 09/12] tee: add Qualcomm TEE driver
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20250715/202507150221.oWiaX1I9-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250715/202507150221.oWiaX1I9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507150221.oWiaX1I9-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/tee/qcomtee/qcomtee.h:12,
                    from drivers/tee/qcomtee/async.c:8:
   drivers/tee/qcomtee/qcomtee_msg.h: In function 'qcomtee_msg_num_ib':
>> drivers/tee/qcomtee/qcomtee_msg.h:172:16: error: implicit declaration of function 'FIELD_GET' [-Wimplicit-function-declaration]
     172 |         return FIELD_GET(QCOMTEE_MASK_IB, counts);
         |                ^~~~~~~~~
--
   In file included from drivers/tee/qcomtee/qcomtee.h:12,
                    from drivers/tee/qcomtee/core.c:14:
   drivers/tee/qcomtee/qcomtee_msg.h: In function 'qcomtee_msg_num_ib':
>> drivers/tee/qcomtee/qcomtee_msg.h:172:16: error: implicit declaration of function 'FIELD_GET' [-Wimplicit-function-declaration]
     172 |         return FIELD_GET(QCOMTEE_MASK_IB, counts);
         |                ^~~~~~~~~
   drivers/tee/qcomtee/core.c: In function 'qcomtee_object_user_init':
   drivers/tee/qcomtee/core.c:303:17: warning: function 'qcomtee_object_user_init' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     303 |                 object->name = kvasprintf_const(GFP_KERNEL, fmt, ap);
         |                 ^~~~~~
   drivers/tee/qcomtee/core.c: In function 'qcomtee_prepare_msg':
   drivers/tee/qcomtee/core.c:417:26: error: implicit declaration of function 'copy_from_user' [-Wimplicit-function-declaration]
     417 |                 else if (copy_from_user(ptr, u[i].b.uaddr, u[i].b.size))
         |                          ^~~~~~~~~~~~~~
   drivers/tee/qcomtee/core.c: In function 'qcomtee_update_args':
   drivers/tee/qcomtee/core.c:496:26: error: implicit declaration of function 'copy_to_user' [-Wimplicit-function-declaration]
     496 |                 else if (copy_to_user(u[i].b.uaddr, ptr, u[i].b.size))
         |                          ^~~~~~~~~~~~
--
   In file included from drivers/tee/qcomtee/qcomtee.h:12,
                    from drivers/tee/qcomtee/user_obj.c:10:
   drivers/tee/qcomtee/qcomtee_msg.h: In function 'qcomtee_msg_num_ib':
>> drivers/tee/qcomtee/qcomtee_msg.h:172:16: error: implicit declaration of function 'FIELD_GET' [-Wimplicit-function-declaration]
     172 |         return FIELD_GET(QCOMTEE_MASK_IB, counts);
         |                ^~~~~~~~~
   drivers/tee/qcomtee/user_obj.c: In function 'qcomtee_cb_params_from_args':
   drivers/tee/qcomtee/user_obj.c:449:29: error: implicit declaration of function 'copy_to_user' [-Wimplicit-function-declaration]
     449 |                         if (copy_to_user(params[i].u.ubuf.uaddr, u[i].b.addr,
         |                             ^~~~~~~~~~~~
   drivers/tee/qcomtee/user_obj.c: In function 'qcomtee_cb_params_to_args':
   drivers/tee/qcomtee/user_obj.c:526:29: error: implicit declaration of function 'copy_from_user' [-Wimplicit-function-declaration]
     526 |                         if (copy_from_user(u[i].b.addr, params[i].u.ubuf.uaddr,
         |                             ^~~~~~~~~~~~~~


vim +/FIELD_GET +172 drivers/tee/qcomtee/qcomtee_msg.h

   169	
   170	static inline unsigned int qcomtee_msg_num_ib(u32 counts)
   171	{
 > 172		return FIELD_GET(QCOMTEE_MASK_IB, counts);
   173	}
   174	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
