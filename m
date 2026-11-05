Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC236606EE80
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 11:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=FeUHgDzY;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BXqA4MTf
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0DF7945493
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 11:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1793877194;
	bh=hmtVLIuQpSTrMXtnR/xJUVI947QRdeRQ/euZdmvv6rs=;
	h=Subject:To:In-Reply-To:References:Date:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=FeUHgDzYh77V86h2B6gFk0xtVwCXsJ8/y+5lFmdkq35VIutGngme+9aH2lU84zQfj
	 BpicYBvvP6zCfvU3wA+OHCS9ZX7FoqnbathMqxheQxeQBfI1VZNsGBV9HPMiccS/g4
	 Hyo+MDgtKnSRtFjRT2A0wNsoP352bvrgt/iGwaKsuUEHXVv59vEjapHU1eSzpJ+vNu
	 hNT+ngBb5OZE8MQWTHsKpm9x2y1HYRuXukim91aR5UyBiDNNd7QRgWRoe5VKe4uNDp
	 amldCDkGxPmBL8QZJDAHcOWO4PPthEIOqZXvEOIc4IGT1Kw20FICD4Z6gc83vWq/WL
	 1dJfC6T5Uh00Q==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3C46C4548A
	for <op-tee@lists.trustedfirmware.org>; Thu,  5 Nov 2026 11:11:59 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BXqA4MTf;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7707841645;
	Thu,  5 Nov 2026 11:11:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA48B1F0093A;
	Thu,  5 Nov 2026 11:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793877118;
	bh=kdAP4TSBtkk0LlJ6Tv3G3s4GO7UCXFHztFqttbQ5P74=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BXqA4MTfn3WWtIB6LKp+GPSNAdE/GQUnCZC6vdCIzMBsM+c/6iRiaLFlGDTX2yk+u
	 P3KdKiwEGiRfqtSFyyXyMdrqPOAIdhRw+C1Gslyn1tyyn6v4YkGvTJw6KrG0FdnDCI
	 4AWCXwG4ZPNz5PjUXSrQiPXsuwfuazScNOE8MFuJS6wbM1K7lQv20j4poytFj/DCty
	 OXmdD1bm05abU4zWu/dG9XSxtW2AbIvLjwB5zFw+lyOxcM+YRVVyIdILWZa3qxu01F
	 hFYPKXlaMQE43TTHF1t0+ejPxz+9DqdIYpVqiAWwxVJsqnQWeZyt7DLayTuV2NivH5
	 kSFmURTEjK00w==
Message-ID: <sashiko-outbox-198918@kernel.org>
Subject: Re: [PATCH v4 3/8] dma-buf: transfer memcg charges via
 DMA_BUF_IOCTL_XFER_CHARGE
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
In-Reply-To: <20261104-v2_20230123_tjmercier_google_com-v4-3-1819a017000b@redhat.com>
References: <20261104-v2_20230123_tjmercier_google_com-v4-0-1819a017000b@redhat.com>
 <20261104-v2_20230123_tjmercier_google_com-v4-3-1819a017000b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 11:11:56 +0000
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.50 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	MISSING_MIME_VERSION(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.10)[text/plain];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[redhat.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,amd.com,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com,infradead.org];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DNSWL_BLOCKED(0.00)[172.234.252.31:from];
	ALIAS_RESOLVED(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 3C46C4548A
X-Spamd-Bar: -----
Message-ID-Hash: A5WSSIVYXRO436ZQM52LNVP4IWMW3KHQ
X-Message-ID-Hash: A5WSSIVYXRO436ZQM52LNVP4IWMW3KHQ
X-MailFrom: sashiko-bot@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: dri-devel@lists.freedesktop.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, op-tee@lists.trustedfirmware.org, media-ci@linuxtv.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/A5WSSIVYXRO436ZQM52LNVP4IWMW3KHQ/>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] dma-buf: unprivileged cgroup escape and OOM via dma_buf_xfer_charg=
e()
- [Medium] dma-buf: broken !CONFIG_MEMCG and disabled-memcg handling in dma=
_buf_xfer_charge()
--

commit 3f75f95a079fdfc2b4d2659ae4dbea6726be45ad
Author: Albert Esteve <aesteve@redhat.com>

dma-buf: transfer memcg charges via DMA_BUF_IOCTL_XFER_CHARGE

This commit adds the DMA_BUF_IOCTL_XFER_CHARGE ioctl and a generic
mem_cgroup_transfer_charge() helper to transfer a dma-buf's memory cgroup
charge to a target cgroup identified by a cgroupfd or pidfd.

> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 8376662735502..3bd26fbb11092 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -540,6 +540,45 @@ static long dma_buf_import_sync_file(struct dma_buf =
*dmabuf,
>  }
>  #endif
> =20
> +/* Transfer a dma-buf's memcg charge; see struct dma_buf_transfer_charge=
 */
> +static long dma_buf_xfer_charge(struct dma_buf *dmabuf,
> +				const void __user *user_data)
> +{
> +	struct dma_buf_transfer_charge arg;
> +	struct mem_cgroup *memcg;
> +	unsigned int nr_pages =3D PAGE_ALIGN(dmabuf->size) >> PAGE_SHIFT;
> +	int ret =3D 0;
> +
> +	if (copy_from_user(&arg, user_data, sizeof(arg)))
> +		return -EFAULT;
> +
> +	if (!IS_ENABLED(CONFIG_MEMCG))
> +		return 0;

[Severity: Medium]
As reported by Sashiko on v3 [1], when CONFIG_MEMCG is disabled,
dma_buf_xfer_charge() returns 0 before checking arg.flags,
mem_cgroup_get_from_fd(arg.charge_fd), or dmabuf->memcg.

On a CONFIG_MEMCG=3Dn kernel, won't this accept non-zero arg.flags instead =
of
returning -EINVAL, and return 0 instead of -EOPNOTSUPP on buffers that have
no existing memcg charge?

In include/uapi/linux/dma-buf.h, struct dma_buf_transfer_charge documents
that flags must be zero and that the ioctl returns -EOPNOTSUPP if the buffer
has no existing memcg charge. In include/linux/memcontrol.h, the
!CONFIG_MEMCG stub for mem_cgroup_get_from_fd() already returns
ERR_PTR(-EOPNOTSUPP):

include/linux/memcontrol.h:
static inline struct mem_cgroup *mem_cgroup_get_from_fd(int fd)
{
	return ERR_PTR(-EOPNOTSUPP);
}

Returning 0 early here bypasses that stub and leaves the !CONFIG_MEMCG stub
for mem_cgroup_transfer_charge() in include/linux/memcontrol.h unreachable.

In addition, in mm/memcontrol.c, mem_cgroup_transfer_charge() has:

	if (!new_memcg || mem_cgroup_disabled())
		return true;

which returns true without updating *ptr_memcg or uncharging and dropping t=
he
reference to old_memcg, even though the function comment states that on
success it stores new_memcg in *ptr_memcg. Should the early CONFIG_MEMCG
check in dma_buf_xfer_charge() be dropped so it falls through to
arg.flags validation and mem_cgroup_get_from_fd()?

> +
> +	if (arg.flags !=3D 0)
> +		return -EINVAL;
> +
> +	memcg =3D mem_cgroup_get_from_fd(arg.charge_fd);
> +	if (IS_ERR(memcg))
> +		return PTR_ERR(memcg);
> +
> +	dma_resv_lock(dmabuf->resv, NULL);
> +
> +	if (!dmabuf->memcg) {
> +		ret =3D -EOPNOTSUPP;
> +		goto out;
> +	}
> +
> +	if (dmabuf->memcg !=3D memcg &&
> +	    !mem_cgroup_transfer_charge(&dmabuf->memcg, memcg, MEMCG_DMABUF, nr=
_pages))
> +		ret =3D -ENOMEM;

[Severity: High]
As reported by Sashiko on v3 [2], can an unprivileged holder of a dma-buf
file descriptor use dma_buf_xfer_charge() to escape its own memory cgroup
limits or trigger reclaim and OOM kills in another cgroup?

In dma_buf_ioctl() -> dma_buf_xfer_charge() -> mem_cgroup_get_from_fd(),
neither dma_buf_xfer_charge() nor mem_cgroup_get_from_fd() checks DAC
permissions, capabilities (such as CAP_SYS_RESOURCE or CAP_SYS_ADMIN),
cgroup v2 write/delegation permissions (such as cgroup_procs_write_permissi=
on()
used by CLONE_INTO_CGROUP), or task access permissions (such as
ptrace_may_access()) on either the source cgroup (dmabuf->memcg) or the
target cgroup/task (memcg):

mm/memcontrol.c:mem_cgroup_get_from_fd() {
	cgrp =3D cgroup_get_from_fd(fd);
	if (!IS_ERR(cgrp)) {
		...
		return memcg;
	}

	task =3D pidfd_get_task(fd, &pidfd_flags);
	...
}

Because /sys/fs/cgroup directories are world-readable (0755) by default and
pidfd_open() requires no privileges for visible PIDs, any unprivileged
process can open /sys/fs/cgroup (root_mem_cgroup) or another cgroup's
directory or pidfd.

Even with the subsequent LSM and SELinux patches in this series:
1. On systems without SELinux (such as AppArmor, Smack, or CONFIG_SECURITY=
=3Dn),
   security_dma_buf_charge_cgroup() and security_dma_buf_charge_task() retu=
rn
   0 with no baseline DAC, cgroup permission, or capability checks.
2. On SELinux systems, selinux_dma_buf_charge_cgroup() checks
   kernfs_xattr_get(cgrp->kn, XATTR_NAME_SELINUX, NULL, 0) and returns 0 on
   -ENODATA whenever a cgroup directory lacks an explicit security.selinux
   xattr (including /sys/fs/cgroup and cgroups labeled via default genfscon
   policy rules).
3. Neither dma_buf_xfer_charge() nor the LSM hooks check whether the caller
   is authorized to uncharge the source cgroup (dmabuf->memcg).

When mem_cgroup_transfer_charge() runs:

mm/memcontrol.c:mem_cgroup_transfer_charge() {
	...
	if (try_charge(new_memcg, GFP_KERNEL, nr_pages))
		return false;
	...
	if (old_memcg) {
		/* Uncharge old cgroup */
		mod_memcg_state(old_memcg, item, -nr_pages);
		if (!mem_cgroup_is_root(old_memcg))
			refill_stock(old_memcg, nr_pages);
		mem_cgroup_put(old_memcg);
	}
}

A confined process can pass an fd for /sys/fs/cgroup (where try_charge() on
root_mem_cgroup is a no-op) to uncharge its own cgroup and bypass memory.ma=
x,
or pass an fd for another cgroup to trigger GFP_KERNEL direct reclaim and
mem_cgroup_oom() in that victim cgroup. Should dma_buf_xfer_charge() or
mem_cgroup_get_from_fd() enforce baseline cgroup write/task permissions and
authorization to uncharge dmabuf->memcg?

[1] https://lore.kernel.org/r/20261027-v2_20230123_tjmercier_google_com-v3-=
7-78d2c4cb8647@redhat.com
[2] https://lore.kernel.org/r/20261027-v2_20230123_tjmercier_google_com-v3-=
7-78d2c4cb8647@redhat.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-v2_2023012=
3_tjmercier_google_com-v4-0-1819a017000b@redhat.com?part=3D3
