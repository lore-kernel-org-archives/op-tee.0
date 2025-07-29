Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42FB0C83F26
	for <op-tee@archiver.kernel.org>; Tue, 29 Jul 2025 09:25:05 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 719B742E01
	for <op-tee@archiver.kernel.org>; Tue, 29 Jul 2025 09:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1753781104;
	bh=NfmoRL5vOFPtWo+IZ5Ea7PCg7mu0e/0Soot/YyO332k=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=v2fbW2g1Sy4XhaMbMo5+voMxkCmjXeQjubXzXVesmuSnc3TpU35IG+z3weHaeJNVI
	 1oxHKKSyg2xqrcaCHuAnPahxDuTFU5kSD85dlZum744cBkq89TwMEqgsy0ItvafEwv
	 stzGEmUHo+Q98rAmrG84eSSwvLiMy4oWCkV7uWtW2sUWNymlGElyZbj7zEC/3XN8Zd
	 KC00yNMqAPU9g4nmRPPCga2eGz+tltVdyM4HeQFEbqIuszLRtDUubuXsjrK7BruOHe
	 U6vSTz7RvWYmJrD2Q9vEMhFUTKB4buAz8tVCzqHknbsYVahMizVkApglSnlPTQ3UrJ
	 uxVa+hWi7w3nA==
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0329E3F6DD
	for <op-tee@lists.trustedfirmware.org>; Tue, 29 Jul 2025 09:24:44 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Q/poAGPm;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id B8D2BA54BAA;
	Tue, 29 Jul 2025 09:24:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B17C4CEEF;
	Tue, 29 Jul 2025 09:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753781083;
	bh=NfmoRL5vOFPtWo+IZ5Ea7PCg7mu0e/0Soot/YyO332k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q/poAGPmaOf25zQvClduhiOBFWoLhNeepuPofbBc/VrC9Hox8cSXGwoHYywZ4K1oz
	 QHEMALeA7NI9K9FU9yWjiaqyMGQAywk7jhgS4Z5XH9PbIrdGnHmgxzwiOxoCd6Lkma
	 juxgzoW3ung/PmLsTFkB4KhyZ9D1xihFmDj29HcsWnHHN5oVf/f7o4jbvzeVKAYfiC
	 9X00YKIWOmAdZcYSWeAs1U2Ec/bMIf9dCJMD4OxLZffz5UacTkm2qg71pyqnT3r6CS
	 FsBrB38SICqvOlD1PN96zY/g0toDtBbVLQ18lSXTX0cCa4BZklsGzcOj2ZLZNgLxvQ
	 3pTQq+fpefZwg==
Date: Tue, 29 Jul 2025 14:54:37 +0530
To: Pei Xiao <xiaopei01@kylinos.cn>
Subject: Re: [PATCH] tee: fix NULL pointer dereference in tee_shm_put
Message-ID: <aIiTVdJib4DLgYnC@sumit-X1>
References: <fabd3d7560119e52dd83f4a19ad1f8087862993f.1753236468.git.xiaopei01@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fabd3d7560119e52dd83f4a19ad1f8087862993f.1753236468.git.xiaopei01@kylinos.cn>
X-Rspamd-Queue-Id: 0329E3F6DD
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:147.75.193.91];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[147.75.193.91:from];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:15830, ipnet:147.75.193.0/24, country:NL];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: PUIDGWVUCKBIG2ZKDKEWXQJMULK6LZRI
X-Message-ID-Hash: PUIDGWVUCKBIG2ZKDKEWXQJMULK6LZRI
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/PUIDGWVUCKBIG2ZKDKEWXQJMULK6LZRI/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Wed, Jul 23, 2025 at 10:09:07AM +0800, Pei Xiao wrote:
> tee_shm_put have NULL pointer dereference:
> 
> __optee_disable_shm_cache -->
> 	shm = reg_pair_to_ptr(...);//shm maybe return NULL
>         tee_shm_free(shm); -->
> 		tee_shm_put(shm);//crash
> 
> Add check in tee_shm_put to fix it.
> 
> panic log:
> Unable to handle kernel paging request at virtual address 0000000000100cca
> Mem abort info:
> ESR = 0x0000000096000004
> EC = 0x25: DABT (current EL), IL = 32 bits
> SET = 0, FnV = 0
> EA = 0, S1PTW = 0
> FSC = 0x04: level 0 translation fault
> Data abort info:
> ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> user pgtable: 4k pages, 48-bit VAs, pgdp=0000002049d07000
> [0000000000100cca] pgd=0000000000000000, p4d=0000000000000000
> Internal error: Oops: 0000000096000004 [#1] SMP
> CPU: 2 PID: 14442 Comm: systemd-sleep Tainted: P OE ------- ----
> 6.6.0-39-generic #38
> Source Version: 938b255f6cb8817c95b0dd5c8c2944acfce94b07
> Hardware name: greatwall GW-001Y1A-FTH, BIOS Great Wall BIOS V3.0
> 10/26/2022
> pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : tee_shm_put+0x24/0x188
> lr : tee_shm_free+0x14/0x28
> sp : ffff001f98f9faf0
> x29: ffff001f98f9faf0 x28: ffff0020df543cc0 x27: 0000000000000000
> x26: ffff001f811344a0 x25: ffff8000818dac00 x24: ffff800082d8d048
> x23: ffff001f850fcd18 x22: 0000000000000001 x21: ffff001f98f9fb88
> x20: ffff001f83e76218 x19: ffff001f83e761e0 x18: 000000000000ffff
> x17: 303a30303a303030 x16: 0000000000000000 x15: 0000000000000003
> x14: 0000000000000001 x13: 0000000000000000 x12: 0101010101010101
> x11: 0000000000000001 x10: 0000000000000001 x9 : ffff800080e08d0c
> x8 : ffff001f98f9fb88 x7 : 0000000000000000 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
> x2 : ffff001f83e761e0 x1 : 00000000ffff001f x0 : 0000000000100cca
> Call trace:
> tee_shm_put+0x24/0x188
> tee_shm_free+0x14/0x28
> __optee_disable_shm_cache+0xa8/0x108
> optee_shutdown+0x28/0x38
> platform_shutdown+0x28/0x40
> device_shutdown+0x144/0x2b0
> kernel_power_off+0x3c/0x80
> hibernate+0x35c/0x388
> state_store+0x64/0x80
> kobj_attr_store+0x14/0x28
> sysfs_kf_write+0x48/0x60
> kernfs_fop_write_iter+0x128/0x1c0
> vfs_write+0x270/0x370
> ksys_write+0x6c/0x100
> __arm64_sys_write+0x20/0x30
> invoke_syscall+0x4c/0x120
> el0_svc_common.constprop.0+0x44/0xf0
> do_el0_svc+0x24/0x38
> el0_svc+0x24/0x88
> el0t_64_sync_handler+0x134/0x150
> el0t_64_sync+0x14c/0x15
> 
> Fixes: dfd0743f1d9e ("tee: handle lookup of shm with reference count 0")
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>  drivers/tee/tee_shm.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index daf6e5cfd59a..915239b033f5 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -560,9 +560,13 @@ EXPORT_SYMBOL_GPL(tee_shm_get_from_id);
>   */
>  void tee_shm_put(struct tee_shm *shm)
>  {
> -	struct tee_device *teedev = shm->ctx->teedev;
> +	struct tee_device *teedev;
>  	bool do_release = false;
>  
> +	if (!shm || !shm->ctx || !shm->ctx->teedev)
> +		return;
> +
> +	teedev = shm->ctx->teedev;
>  	mutex_lock(&teedev->mutex);
>  	if (refcount_dec_and_test(&shm->refcount)) {
>  		/*
> -- 
> 2.25.1
> 
