Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E61606A31B
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 11:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=DmMXSh8S;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WAbXpW5G
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id DFDF745477
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 11:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1793877280;
	bh=XskcVFVajMJ3lCtnLA33HB++4MDmGwkBHRS6+TTKIX8=;
	h=Subject:To:In-Reply-To:References:Date:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=DmMXSh8SDc5vS7X+OU6DSwm6DDsbcHgQgPVDMjwAOAWMh8MktcwhzAw55BGfS93Xo
	 z7ZEstHh0wZadi+sp9Ri5oBpVIH08d8abOs/Ox8h+U3yaA6WyvcZ2dN0Ucp/SYgBuX
	 1u7GkkcARB5E3i8A3oMhYQBhBKsHeVcq/wHBjrdqKL+bLUDtr3/eXkKorNvR8ACkyj
	 O1QOU+YodP3V66UdWi1/bYkXyzxU+vcVTvE0xV0caRkKs/gYMbtjuZkaYTaWGpWDtG
	 U0qUR7PRTrr4W1wjPCIDlJFNfQzMfgyBB/1UVbHrTlCw7sguly0MHcKHp4HwVCrgsU
	 vju1NSkvN0JQA==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id CB3E84549F
	for <op-tee@lists.trustedfirmware.org>; Thu,  5 Nov 2026 11:12:05 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WAbXpW5G;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4F51D41FFD;
	Thu,  5 Nov 2026 11:12:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B671F000C1;
	Thu,  5 Nov 2026 11:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793877125;
	bh=A6Btm3+v+dnXqWTR2GX+hsLiVMvVrLHj5mxZiRv+uQA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WAbXpW5G+J81zpga2YkofDFAJr37p7VW0gGXFRU1+QCgzM/A2pZgHgznNZ2nCalqE
	 Ia3JyUZPh6L8Rg/y+uDgpDdpHVkNXyzDJVU61C50bKdJpxk3QmFsmifPi+WacjV/XA
	 QcdaQ2JwYWDZM/S9fBxO98d3uu84tMP2L3LX4JZ6BhPLw+JPH/18HgMzAJJzcMfDF3
	 tw4HNNjQMzFdjFhehxPRAgVYMCdqVn+EzZzkd0u3g2A/L89+VMUZrPX21d6cbm+Hxu
	 OFZ2xzICDiinoYKDYRJ6cNwQKSRtQb9bUblJfArFReo7oJfCXLWSKUy3cXW4MihmdO
	 KKFQUwanA6LGA==
Message-ID: <sashiko-outbox-198922@kernel.org>
Subject: Re: [PATCH v4 7/8] selinux: Restrict dma-buf direct cgroup charging
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
In-Reply-To: <20261104-v2_20230123_tjmercier_google_com-v4-7-1819a017000b@redhat.com>
References: <20261104-v2_20230123_tjmercier_google_com-v4-0-1819a017000b@redhat.com>
 <20261104-v2_20230123_tjmercier_google_com-v4-7-1819a017000b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 11:12:03 +0000
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
X-Rspamd-Queue-Id: CB3E84549F
X-Spamd-Bar: -----
Message-ID-Hash: QPYET2LPA5VQCXU6T5XPVNYKLOK2ICIG
X-Message-ID-Hash: QPYET2LPA5VQCXU6T5XPVNYKLOK2ICIG
X-MailFrom: sashiko-bot@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: dri-devel@lists.freedesktop.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, op-tee@lists.trustedfirmware.org, media-ci@linuxtv.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/QPYET2LPA5VQCXU6T5XPVNYKLOK2ICIG/>
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
- [High] selinux: selinux_dma_buf_charge_cgroup() bypasses check on genfsco=
n cgroups
- [Medium] selinux: one-off dma_buf charge_cgroup lacks broader cgroup cont=
rol design
--

commit d0dd0ed1dd84ec5c8f4de9a298a749d83668b53e
Author: Albert Esteve <aesteve@redhat.com>

selinux: Restrict dma-buf direct cgroup charging

This commit implements the selinux_dma_buf_charge_cgroup() hook and adds the
charge_cgroup permission to the dma_buf security class to restrict which
processes can charge dma-buf memory to a target cgroup.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 8f39d91eabc97..2f99eaa910af4 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2210,6 +2210,40 @@ static int selinux_dma_buf_charge_task(const struc=
t cred *from, const struct cre
>  			    SECCLASS_DMA_BUF, DMA_BUF__CHARGE_TASK, NULL);
>  }
> =20
> +#ifdef CONFIG_CGROUPS
> +static int selinux_dma_buf_charge_cgroup(const struct cred *cred, struct=
 cgroup *cgrp)
> +{
> +	u32 cgrp_sid, clen;
> +	int rc;
> +	char *context;
> +
> +	rc =3D kernfs_xattr_get(cgrp->kn, XATTR_NAME_SELINUX, NULL, 0);
> +	if (rc =3D=3D -ENODATA)
> +		return 0;

[Severity: High]
As reported by Sashiko on v3 [1], in security/selinux/hooks.c, does returni=
ng
0 in selinux_dma_buf_charge_cgroup() when kernfs_xattr_get() returns -ENODA=
TA
bypass the permission check for all default-labeled cgroups?

When a process calls ioctl(DMA_HEAP_IOCTL_ALLOC) or
ioctl(DMA_BUF_IOCTL_XFER_CHARGE) with a charge_fd referencing a cgroup
directory, mem_cgroup_get_from_fd() invokes security_dma_buf_charge_cgroup()
-> selinux_dma_buf_charge_cgroup().

In SELinux, cgroup and cgroup2 filesystems are configured with
SE_SBGENFS | SE_SBGENFS_XATTR in selinux_set_mnt_opts() and obtain their
default label (such as cgroup_t) from policy genfscon rules. When a cgroupfs
VFS inode is initialized in inode_doinit_with_dentry(), SELinux computes the
default SID via selinux_genfs_get_sid() and only uses kernfs xattrs as an
optional override:

security/selinux/hooks.c:inode_doinit_with_dentry() {
    ...
			rc =3D selinux_genfs_get_sid(dentry, sclass,
						   sbsec->flags, &sid);
			if (rc) {
				dput(dentry);
				goto out;
			}

			if ((sbsec->flags & SE_SBGENFS_XATTR) &&
			    (inode->i_opflags & IOP_XATTR)) {
				rc =3D inode_doinit_use_xattr(inode, dentry,
							    sid, &sid);
    ...
}

When no explicit setxattr() has been performed on the cgroup directory,
inode_doinit_use_xattr() gets -ENODATA and falls back to def_sid in memory
without writing any security.selinux xattr to cgrp->kn:

security/selinux/hooks.c:inode_doinit_use_xattr() {
    ...
	if (rc < 0) {
		kfree(context);
		if (rc !=3D -ENODATA) {
			pr_warn("SELinux: %s:  getxattr returned %d for dev=3D%s ino=3D%llu\n",
				__func__, -rc, inode->i_sb->s_id, inode->i_ino);
			return rc;
		}
		*sid =3D def_sid;
		return 0;
	}
    ...
}

Similarly, selinux_kernfs_init_security() sees -ENODATA on the parent node
and returns 0 without setting an xattr on child cgroup nodes, and if the
cgroup_seclabel policy capability is not enabled, security.selinux xattrs
cannot be set on cgroup directories at all.

Because kernfs_xattr_get(cgrp->kn, XATTR_NAME_SELINUX, NULL, 0) returns
-ENODATA for every cgroup that has not been manually relabeled via
setxattr(), won't selinux_dma_buf_charge_cgroup() skip avc_has_perm() for a=
ll
default-labeled cgroup_t cgroups and render policy rules like
"allow allocator_app_t cgroup_t:dma_buf charge_cgroup;" ineffective?

[ ... ]

> diff --git a/security/selinux/include/classmap.h b/security/selinux/inclu=
de/classmap.h
> index b4ebedc6e4240..90d1e04c3d27c 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -181,7 +181,7 @@ const struct security_class_mapping secclass_map[] =
=3D {
>  	{ "user_namespace", { "create", NULL } },
>  	{ "memfd_file",
>  	  { COMMON_FILE_PERMS, "execute_no_trans", "entrypoint", NULL } },
> -	{ "dma_buf", { "charge_task", NULL } },
> +	{ "dma_buf", { "charge_task", "charge_cgroup", NULL } },

[Severity: Medium]
As reported by Paul Moore on RFC [2], in security/selinux/include/classmap.h
(secclass_map) and security/selinux/hooks.c (selinux_dma_buf_charge_cgroup(=
)),
this adds a narrow dma_buf class permission for cgroup charging invoked from
DMA_HEAP_IOCTL_ALLOC and DMA_BUF_IOCTL_XFER_CHARGE via
mem_cgroup_get_from_fd() -> security_dma_buf_charge_cgroup().

Rather than introducing a one-off dma_buf cgroup charging permission, should
this be part of a broader SELinux access control design covering existing
cgroup control points so that the object class and permission model is
consistent across cgroup operations?

[1] https://lore.kernel.org/r/20261027-v2_20230123_tjmercier_google_com-v3-=
6-78d2c4cb8647@redhat.com
[2] https://lore.kernel.org/r/16093a0278a6d7d1a0a8bc055c228bed@paul-moore.c=
om

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-v2_2023012=
3_tjmercier_google_com-v4-0-1819a017000b@redhat.com?part=3D7
