Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973D4606A31A
	for <op-tee@archiver.kernel.org>; Wed, 28 Oct 2026 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=zSMLs00M;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FGUhQnEI
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E4A5A453D5
	for <op-tee@archiver.kernel.org>; Wed, 28 Oct 2026 15:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1793199925;
	bh=IOOrP3qVB6f6bBfwpu/ZqW4pMLOAmKzIq5PRU2rFLMI=;
	h=Subject:To:In-Reply-To:References:Date:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=zSMLs00MpZuZp+1HSB05FI+UVo558+vLblM3QbLmBg73YacehiXyeywHpfBrwDwll
	 CxPpffaWrkfTwIwJGwRyzOgTLqfUblp1zdiWf6FXeWZlGJrnDAF1SDS/xOShWPDy4V
	 YWy9S70Q0mJqjKR5nSS6pPoPTIfBFYMunscLsSvr+DTOXOkXYJD3z590rfXFoLM1hD
	 f6c5ulDnW+fm3tJgK1lkWfPYkxRXSXlyd5XhitbvlAf2h2yyrVb9tzTijRdiWCB8Vm
	 O/T93fd117E4ozyc53M6nMZPeUByEF0KFOBIYcSKxG0JWCwqF9a4DPTZbsgyH5i9gT
	 ew8IC2Hd2n1Ng==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id BAAF4451E7
	for <op-tee@lists.trustedfirmware.org>; Wed, 28 Oct 2026 15:04:36 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FGUhQnEI;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0BD55413AA;
	Wed, 28 Oct 2026 15:04:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412E71F01828;
	Wed, 28 Oct 2026 15:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793199875;
	bh=C7gQDIGtka4M6gFdPtyAUJTEmbG7HdtUcr2lveZNTbo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FGUhQnEI+RbAgshoSt9xu8P3vWredhcl377LgGwqtfoX3wn5xpg3pFBp+vxuSigfm
	 ZayPAsFGhzsDUdUEZHH3n/ZhwRISu8XF1pC0ItBWCTnESEGavXhgpgzipXn+EHWzvQ
	 Akuj0EKJEF9R83wVj8+keQjFL+c1V0vGNwZ/SI7OJ3yi5fEcgHKlzbAm/dgigrMGLw
	 1oRjmNabb4Bn0U6x1KMQbbSfx9YiCqrKV3gap5VEtC9UrJDcQnX7IYDzDDpo5VqXDQ
	 /gY6sk0QmG7CG5UwE26nMddVlxPpf3Xr3adyn8dxs46aPGhX8nqIGj7nsC4V+pmzhc
	 3fC+wcXctU+gg==
Message-ID: <sashiko-outbox-188028@kernel.org>
Subject: Re: [PATCH v3 3/8] security: dma-buf: Add dma_buf_charge_task LSM
 hook
To: "Albert Esteve" <aesteve@redhat.com>, "Tejun Heo" <tj@kernel.org>, "Johannes
 Weiner" <hannes@cmpxchg.org>, =?utf-8?b?TWljaGFsIEtvdXRuw70=?= <mkoutny@suse.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "Sumit
 Semwal" <sumit.semwal@linaro.org>, =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, "Michal
 Hocko" <mhocko@kernel.org>, "Roman Gushchin" <roman.gushchin@linux.dev>, "Shakeel
 Butt" <shakeel.butt@linux.dev>, "Muchun Song" <muchun.song@linux.dev>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Benjamin Gaignard" <benjamin.gaignard@collabora.com>, "Brian
 Starkey" <Brian.Starkey@arm.com>, "John Stultz" <jstultz@google.com>, "T.J.
 Mercier" <tjmercier@google.com>, "Christian Brauner" <brauner@kernel.org>, "Paul
 Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "Stephen Smalley" <stephen.smalley.work@gmail.com>, "Shuah
 Khan" <shuah@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>,
 =?utf-8?b?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, "Jens Wiklander" <jenswi@kernel.org>, "Sumit
 Garg" <sumit.garg@kernel.org>
In-Reply-To: <20261027-v2_20230123_tjmercier_google_com-v3-3-78d2c4cb8647@redhat.com>
References: <20261027-v2_20230123_tjmercier_google_com-v3-0-78d2c4cb8647@redhat.com>
 <20261027-v2_20230123_tjmercier_google_com-v3-3-78d2c4cb8647@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 15:04:33 +0000
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.20 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.99%];
	MISSING_MIME_VERSION(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	RCVD_IN_DNSWL_MED(-0.20)[172.234.252.31:from];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31:c];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,amd.com,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com,infradead.org];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DNSWL_BLOCKED(0.00)[100.103.45.18:received];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: BAAF4451E7
X-Spamd-Bar: ----
Message-ID-Hash: PAOQ3YDVCJP7XAFYGM2IBJAHYDXLCQ5P
X-Message-ID-Hash: PAOQ3YDVCJP7XAFYGM2IBJAHYDXLCQ5P
X-MailFrom: sashiko-bot@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: dri-devel@lists.freedesktop.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, op-tee@lists.trustedfirmware.org, echanude@redhat.com, mripard@kernel.org, media-ci@linuxtv.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/PAOQ3YDVCJP7XAFYGM2IBJAHYDXLCQ5P/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: sashiko-bot--- via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: sashiko-reviews@lists.linux.dev, sashiko-bot@kernel.org
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] memcg: task cred and mm->owner mismatch in mem_cgroup_get_from_fd()
--

commit 6c6031732d7f42644e3d99679d750fcc12907447
Author: Albert Esteve <aesteve@redhat.com>

security: dma-buf: Add dma_buf_charge_task LSM hook

This commit adds the security_dma_buf_charge_task() LSM hook and calls it
in mem_cgroup_get_from_fd() when resolving a pidfd, allowing security
modules to mediate cross-process dma-buf cgroup charging.

> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index f66254f52b999..ad195cfd1b5f6 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
[ ... ]
> @@ -5698,6 +5701,14 @@ struct mem_cgroup *mem_cgroup_get_from_fd(int fd)
>  	if (IS_ERR(task))
>  		return ERR_CAST(task);
> =20
> +	tcred =3D get_task_cred(task);
> +	ret =3D security_dma_buf_charge_task(current_cred(), tcred);
> +	put_cred(tcred);
> +	if (ret) {
> +		put_task_struct(task);
> +		return ERR_PTR(ret);
> +	}
> +
>  	mm =3D get_task_mm(task);
>  	put_task_struct(task);
>  	if (!mm)

[Severity: High]
Can the cgroup returned by mem_cgroup_get_from_fd() diverge from the task
credentials checked by security_dma_buf_charge_task()?

Here security_dma_buf_charge_task() validates get_task_cred(task), and then
mem_cgroup_get_from_fd() resolves the target mem_cgroup via get_task_mm(tas=
k)
and get_mem_cgroup_from_mm(mm):

mm/memcontrol.c:mem_cgroup_get_from_fd() {
	...
	mm =3D get_task_mm(task);
	put_task_struct(task);
	if (!mm)
		return ERR_PTR(-ESRCH);

	memcg =3D get_mem_cgroup_from_mm(mm);
	mmput(mm);
	return memcg;
}

However, get_mem_cgroup_from_mm() resolves the mem_cgroup from mm->owner
rather than from task, and falls back to root_mem_cgroup when mm->owner is
NULL:

mm/memcontrol.c:get_mem_cgroup_from_mm() {
	...
	rcu_read_lock();
	do {
		memcg =3D mem_cgroup_from_task(rcu_dereference(mm->owner));
		if (unlikely(!memcg))
			memcg =3D root_mem_cgroup;
	} while (!css_tryget(&memcg->css));
	rcu_read_unlock();
	return memcg;
}

If task exits after get_task_mm(task) increments mm->mm_users but before
get_mem_cgroup_from_mm(mm) runs, exit_mm() -> mm_update_next_owner() finds
no live owner with mm_users > 1 and clears mm->owner:

kernel/exit.c:mm_update_next_owner() {
	...
	/*
	 * We found no owner yet mm_users > 1: this implies that we are
	 * most likely racing with swapoff (try_to_unuse()) or /proc or
	 * ptrace or page migration (get_task_mm()).  Mark owner as NULL.
	 */
	WRITE_ONCE(mm->owner, NULL);
	...
}

In that case, get_mem_cgroup_from_mm(mm) returns root_mem_cgroup, where
try_charge() skips charging via mem_cgroup_is_root(memcg). A confined
caller in DMA_HEAP_IOCTL_ALLOC or DMA_BUF_IOCTL_XFER_CHARGE could fork a
short-lived helper child with matching credentials to pass
security_dma_buf_charge_task() and race its exit to charge allocations to
root_mem_cgroup, escaping its own cgroup memory limit.

Similarly, if task shares an mm_struct with another task via clone(CLONE_VM)
that has different credentials or cgroup membership, mm->owner can refer to
that other task while security_dma_buf_charge_task() only checks task's
credentials.

Would it make sense to resolve the task and its credentials from mm->owner
(or look up the mem_cgroup directly from task) so that the LSM check and the
mem_cgroup lookup operate on the same task and cannot fall back to
root_mem_cgroup when mm->owner is cleared?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-v2_2023012=
3_tjmercier_google_com-v3-0-78d2c4cb8647@redhat.com?part=3D3
