Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 016CFC61DD3
	for <op-tee@archiver.kernel.org>; Mon, 31 Aug 2026 08:26:46 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1EBB944F5D
	for <op-tee@archiver.kernel.org>; Mon, 31 Aug 2026 08:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788164806;
	bh=i7Pvgb3oiy1hq0LGOiit/djv7hiLdC62LcWzykGTNDg=;
	h=References:In-Reply-To:Date:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=0YxYfiuvzxrcEHvlUeyJWv1SmRiZX3BtZBx0w66qept1M6OXnTSfGLcGiHnzeMcrZ
	 iOxsgHKeO76aLe2YUO+lMdJSn+0zmS00tXRC/v/ZObc+TPnPSnEPFUG4LBI9DVLW0x
	 QTPTsjMSH/hA7NwhjFBZamzK1b07E5QkuVtlWXsExhcNWwVBdWNPfuEWO9c07E6onk
	 bFEvgRd/EXjSkFAxtJ4G+jrgUo9hvd047vjGgBOLCZDKa9O3xYP6jGiMIwmXLuudEq
	 g+DTArocS9teBdxQxqv1l5032qVJSEf6hjJto/fYbBcW7LZjPBsPE01r0hMBQKPeKO
	 ytlg2/uAWlzqw==
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E3596451A1
	for <op-tee@lists.trustedfirmware.org>; Mon, 31 Aug 2026 08:26:20 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=SJJq6TVt;
	dkim-atps=neutral
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c10e86e52so311881cf.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 31 Aug 2026 01:26:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788164780; cv=none;
        d=google.com; s=arc-20260327;
        b=OqSYLD3UGLBlOdZmMpIs8gRAF8QFWTk9XzIntAk25ozQa/elh8wlTXO5s3jRYSiOfk
         qtZ4/zsgqwdjxM9XB3TKBt9p8IpSwJUNzVyrfqP6i3UBytWg8ivW9dTrlzXbJJWA3j8W
         SeV/EirZsP6vBf3VedRROIyy5liTQOyxXEw/toyilq41SICCoW0QYohDSfARouNksuV4
         OOwhK5yYF5rtTs6cWqpvtczBTqjd726c0s8HQ1Wv3LzMwpf5aX+zFvKHXDFvIk2q6z5m
         CNIkRbVCRB1G3Tq5L932oLShBAqcyWz2ppnbb8JpmLoqyWwSQnhNIMwTTPTMlhFeorqS
         oRew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=i7Pvgb3oiy1hq0LGOiit/djv7hiLdC62LcWzykGTNDg=;
        fh=BLTPus30KRsNBqTvqydSTX1GznJldk9c81xt5pMLszA=;
        b=EiqkSORmS3MRx6BzHTtD+suPxQffyUd7sNSSW/v12PNZIeJ9vDbqq4XdZOSTx1i7eB
         pD+GHh+jpimoP8pJa5JVkb8xQlLSVmIn3fnjPFghHR1iGf9SOF6kt/XMS5l2pMQF3PQN
         WunKZ8tZwNAG5aJQCTT18l0FZHveHzGR9c2hGseAGIAq/FOyEiaN2igSujO1NVUyxtRs
         Fb/qSIxZ8a0pGPiW5wjA8E5O5dY09ydWDFOtx7Z9X2lacs92VhZuMkYOK+rVpS1uFtBd
         LfPUWK3dN7MRrTPfKIOrTJOKCC35n+ewUxX0nK/yLMpSlKc36/E9Rpj/MLVmuMTUCiVg
         pNZw==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788164780; x=1788769580; darn=lists.trustedfirmware.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i7Pvgb3oiy1hq0LGOiit/djv7hiLdC62LcWzykGTNDg=;
        b=SJJq6TVtER8o9dv2lEWAKVtD27usQYPHSiS2QKqYpKln+qlhNzgtZsRT8aASRS4BWb
         ki9Nzt14q63m51x5sI+/9zqJUv/kWk6kRZuDPaEXIfE/kpWxkpu1smdWD2eE7SWIWYA9
         8buZRBD6lZuy618PlJfW6kIPuP0XQs6WAIDd3mJVBlOW81oGAIralHyOY8pDFa/q69ZB
         JUYfkd+ZVCL2Nqb+VqC9O94Bkbhkur0XierWK+9zYS+imPQAZwV1Nrvxbz4yszy4FbNX
         veU4TY/GWrhf5/2UTJfBjwkypl5CLQjLf1U/KH/V/+QenFht85U22HTSqVblOl3ZaMQY
         b9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788164780; x=1788769580;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=i7Pvgb3oiy1hq0LGOiit/djv7hiLdC62LcWzykGTNDg=;
        b=UKRlCZ7xXWnuRP9bMFbmlLJrn6FQFCvWSeIgDKMk0kZLTNbGudwalhTvg/VlQumycG
         60PUPalB3EW4FaZul+DmhlGi772CeFyoqMLgwrmw/5fnKQMst8UxMRsJG9kXogjjlWQe
         dOM478pVqrP7Xv0X5RjIPeqxCO/05SZ9ChGKaFbGBS1c1otHGABfyCfp6Pd+amkowcte
         ed0iNDrMDN0WqPc4dHa8tkU7ZnOm4WRHEFtIbrKCCn8kA86TgB3IOcMQp9Nv7lxcjMX0
         jKmx0UNpgA2ntsN2Yu9RcVXS9NCVPh/V9v2uZmPsV32HooQQoewek1uNS7ihVBRK6TQ0
         R1yw==
X-Forwarded-Encrypted: i=1; AHgh+RpSkJNCe0pOrP+dinek9h6DPTi7X3846rI32hsgTEwGhsUJ+PAoCHzP/xjT0WRp86a1oRbxD7A=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++nM8YgIX5RDXQ7NsMFgtJ04hs2M/2nQdu4suhyoAPLVwOZ1fzDG
	78Z7P6ol/cV6eNa9k0wPdbV8g9UScHW9DoOng1X7SVcv9S7JiWgJQ8xl075+RXRCJcFdYplJwhi
	o2Qe/G0P+bXGi86Lmx2QtgGkx6uvOhnfp97BfxLe+
X-Gm-Gg: AR+sD12ahDegNOX3nO03fhbJGIemnDhMFu3ps1HRfS9uinfP4vhp8Anlwy5Vv7xxGPe
	F605WwWsTfR9my/lwblrERtsgCfd4wjAO8tEHfGhMDf/YF3HMHioqoRbBURhfWc4w6I0JAGpXv/
	ddiw5hXn9pQkF7plOUsMm1w/QzF2islLBAhJp9yr8PBu13LLGYdyd1HBrcuIstNBWWp3JbNI8ER
	EtzDa+welIfhd9MBLfq0fgGbZZKTHMVZvzBX31nKpiU7Ly4r7/S3ZBzF0KpF7mqU0LvLA5Nzeay
	buzk5Kb2GNzcmcJtPQH6kCmgPCca9ao1SOR4333VNE+rfdqRKSO3yiDcSFK+SiH4sYwjWMgL6pj
	7ew==
X-Received: by 2002:a05:622a:64c:b0:519:b655:235 with SMTP id
 d75a77b69052e-52ff711704cmr26458811cf.3.1788164779732; Mon, 31 Aug 2026
 01:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260827070345.2853821-1-jorge.ramirez@oss.qualcomm.com> <20260827070345.2853821-3-jorge.ramirez@oss.qualcomm.com>
In-Reply-To: <20260827070345.2853821-3-jorge.ramirez@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 16:25:42 +0800
X-Gm-Features: AcwNN1Wql6TjF2E32SMAe0niU5XIn-Fsgvx0mgJJYkagFD8DWijLMQS03XBChpU
Message-ID: <CAE14pdczcD5zsOm57pBaDqb04btPY8abOncDgFwF0_E4LP9sKA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] ufs: rpmb: use a fixed-length RPMB dev_id
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, beanhuo@iokpp.de,
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
	alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
	beanhuo@micron.com, can.guo@oss.qualcomm.com, sumit.garg@oss.qualcomm.com,
	jenswi@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.58 / 15.00];
	BAYES_HAM(-2.98)[99.89%];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.160.174:from];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.174:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: E3596451A1
X-Spamd-Bar: ---
Message-ID-Hash: 5LIOY3SFD7JGRTI67BJOYDNTAJATKHPX
X-Message-ID-Hash: 5LIOY3SFD7JGRTI67BJOYDNTAJATKHPX
X-MailFrom: stanleyjhu@google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/5LIOY3SFD7JGRTI67BJOYDNTAJATKHPX/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Stanley Jhu via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Stanley Jhu <stanleyjhu@google.com>

On Thu, 27 Aug 2026 09:03:36 +0200, Jorge Ramirez-Ortiz wrote:
> The RPMB authentication key is derived from the dev_id handed to the
> RPMB subsystem. OP-TEE implements the eMMC RPMB flow, where the dev_id
> is the eMMC CID: a fixed 16-byte value the key derivation depends on.
>
> The UFS RPMB id is "<device_id>-R<region>", which is variable length
> and longer than 16 bytes. Handing it to the RPMB subsystem as-is would
> tie the derived key to a length OP-TEE does not expect and diverge from
> the fixed-CID eMMC ABI, forcing OP-TEE to be taught about
> variable-length UFS ids.
>
> A fixed 16-byte dev_id is needed so the derived key stays stable and
> unique per region while matching the eMMC CID layout OP-TEE relies on,
> keeping the key-derivation ABI identical with no OP-TEE change. The
> reduction to a fixed 16 bytes must also be reproducible by the
> bootloaders (such as U-Boot) that derive the same dev_id.
>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>

Reviewed-by: Stanley Jhu <stanleyjhu@google.com>
