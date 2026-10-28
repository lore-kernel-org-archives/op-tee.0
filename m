Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC77606A31C
	for <op-tee@archiver.kernel.org>; Wed, 28 Oct 2026 15:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=q9ini42I;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EIRs14Ak
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8A64045369
	for <op-tee@archiver.kernel.org>; Wed, 28 Oct 2026 15:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1793199954;
	bh=1HH6nQ/WWj2cpAQVNjwkrpy7pT9NtvipVTAwkLL4rx0=;
	h=Subject:To:In-Reply-To:References:Date:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=q9ini42IYTkfS5do2qSTOAoDp5d6EwUFttc2eY6u0fMNYJxLhU02ac5mnr7HwtOWM
	 2fN9oQA3ME5Q4zeHH/t5DHn3omuw31BTF06agxjEFXzlR28VzcMW9ydBGA25RhMF4+
	 fBZf91cOpv3MT/VhbBJpLCMLjcjSJeXYmM+VL7Xynr7wjETqAobcmScxhJR35HcfmF
	 MY174Mpj7B7+jqQiBtSWd+3Y/1mwddu1ul8l71eY761vYkN8mfISHylEdPlBMBfhgR
	 okJlCgmQj4dGEHeINeyEw2H30IdRiDqTl9HkVtX/7oqA7ZwQzUT40aT/9ACCp6WG+4
	 6aYu9zjerpPAA==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 07B32453A3
	for <op-tee@lists.trustedfirmware.org>; Wed, 28 Oct 2026 15:04:40 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EIRs14Ak;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 55BFD40938;
	Wed, 28 Oct 2026 15:04:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB0F1F01825;
	Wed, 28 Oct 2026 15:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793199879;
	bh=1TKqOP98FHIDcaJNoj3/GWwGDtZsh2WFMN9gl9UcQOs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EIRs14AkkJNqV4FP2ztjO7metvge3koWsF8rvc9H1eOkLYX/cgC+Pq+XLh/h7oAnj
	 MNEGn9M/5cbtIepg3E5EECqqap8BFEljXDT05wKvMgl+Apv61iiIqUYexNfJTjfmPs
	 AoRvFUnbC3JIf3GjxOS+wc+ep8hcuNWLd1w3y7jCZ6hnohvFWH1x2A80texn/ET9Kq
	 yEq4MfQLIx5q38dPZ7eq1EDKuY5cCnLKRotbFLGUKXR/tzKM6v7AlFttlp5sh19hjJ
	 UBMh1XXQFRZUVF7n1jMrjSfKEDoADfSjdgZdcB6KfU5RvH6Y0q7CasX9j84wOnfCZY
	 3UAJSV4V6VVAA==
Message-ID: <sashiko-outbox-188031@kernel.org>
Subject: Re: [PATCH v3 6/8] selinux: Restrict dma-buf direct cgroup charging
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
In-Reply-To: <20261027-v2_20230123_tjmercier_google_com-v3-6-78d2c4cb8647@redhat.com>
References: <20261027-v2_20230123_tjmercier_google_com-v3-0-78d2c4cb8647@redhat.com>
 <20261027-v2_20230123_tjmercier_google_com-v3-6-78d2c4cb8647@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 15:04:37 +0000
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
X-Rspamd-Queue-Id: 07B32453A3
X-Spamd-Bar: ----
Message-ID-Hash: EBF5NFSN5323UOPPLHFC2I2ZSXQU3MSK
X-Message-ID-Hash: EBF5NFSN5323UOPPLHFC2I2ZSXQU3MSK
X-MailFrom: sashiko-bot@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: dri-devel@lists.freedesktop.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, op-tee@lists.trustedfirmware.org, echanude@redhat.com, mripard@kernel.org, media-ci@linuxtv.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/EBF5NFSN5323UOPPLHFC2I2ZSXQU3MSK/>
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
- [High] selinux: selinux_dma_buf_charge_cgroup() bypasses check on genfsco=
n cgroups
--

commit 6b412783b17727c382f1a67078326c58c39264e7
Author: Albert Esteve <aesteve@redhat.com>

selinux: Restrict dma-buf direct cgroup charging

This commit implements the selinux_dma_buf_charge_cgroup() LSM hook and adds
the charge_cgroup permission to the dma_buf security class to control which
processes may charge dma-buf memory to a cgroup. It reads the target securi=
ty
context from the cgroup kernfs node's security.selinux extended attribute a=
nd
checks permission via avc_has_perm().

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
Does returning 0 on -ENODATA here bypass the permission check for all cgrou=
ps
that carry their default genfscon label (such as cgroup_t)?

In selinux_set_mnt_opts(), cgroup and cgroup2 filesystems are configured wi=
th
SE_SBGENFS | SE_SBGENFS_XATTR. When a cgroup VFS inode is initialized in
inode_doinit_with_dentry(), SELinux obtains the default SID from policy via
selinux_genfs_get_sid() and then checks for an optional xattr override via
inode_doinit_use_xattr():

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
inode_doinit_use_xattr() sees -ENODATA from the underlying kernfs node and
falls back to def_sid in memory without writing a security.selinux xattr to
cgrp->kn:

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

Likewise, selinux_kernfs_init_security() sees -ENODATA on the parent kernfs
node and returns 0 without storing an xattr on newly created child cgroups.

As a result, unless a cgroup directory has been explicitly relabeled with
setxattr(), kernfs_xattr_get(cgrp->kn, XATTR_NAME_SELINUX, NULL, 0) will
return -ENODATA even though the cgroup is labeled cgroup_t via genfscon.
When userspace passes a cgroup fd via DMA_HEAP_IOCTL_ALLOC or
DMA_BUF_IOCTL_XFER_CHARGE, mem_cgroup_get_from_fd() invokes
security_dma_buf_charge_cgroup() -> selinux_dma_buf_charge_cgroup(), which
will return 0 without calling avc_has_perm(), leaving default-labeled
cgroup_t cgroups unrestricted?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-v2_2023012=
3_tjmercier_google_com-v3-0-78d2c4cb8647@redhat.com?part=3D6
