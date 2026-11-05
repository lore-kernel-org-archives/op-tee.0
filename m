Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F45606A326
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 11:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=zeAyuW5M;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c2uN/Ng5
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3DC3245484
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 11:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1793877251;
	bh=tLfGNjtAGI6tjtVrMiWHKyNw7WXJ0KQG0dGF2XnHCNQ=;
	h=Subject:To:In-Reply-To:References:Date:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=zeAyuW5MzB03WHdcXIyhhWK3raGL2Ws2dzDRlZT7MBqalTVXu3LiDZWjU4kVYXpfP
	 lY0fp75D1U1LMkB33DwHd30+E0lEcX63qjxPhSJZ7FdBplSOH1+zVp5g0O6fCLOg+G
	 gZCLlrILnXV77cmmUtyqxPNnjTq7dST4wYtdCPyKZsHJh5bCD7dzSR4aIvSOYZAlDq
	 3J5wDiFKiErhi9yMYFswJS+dzEfUPK9cmM6jDTo25FT96g11oAS/IlRhukpqa7QMav
	 AJ6ss3hVTnQafxbchECYTZY/ewI5TcLvwTZqQUXQ1TdnbGJVDmNVSYCif0TlWxM1L0
	 B1TOilxnsmS1Q==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 28ACB4548F
	for <op-tee@lists.trustedfirmware.org>; Thu,  5 Nov 2026 11:12:04 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c2uN/Ng5;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7CE3B42E3F;
	Thu,  5 Nov 2026 11:12:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FBF1F00A18;
	Thu,  5 Nov 2026 11:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793877123;
	bh=u4OwYANC6wqKDyPgO6eDc7wNQ6edH7rpigotQa7/OCk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c2uN/Ng5l1zRBU1f6aKBEfZtQoOnizQ0rrFd9kCVSSHUE4EkaG4YPu0DVrXFd/sYf
	 WQRytoL/bcOM1tMwGTUhoxMGZjd7nrw9Op3dgk7LlqQMSjRvDJDTBSXagtU5aDYa4F
	 iloIC0z1XqsAvA+wuzjNVVxTNcK1vJS2YM72nD09YWg7Y+1F+DhJmXRU8T8Gy/xhN6
	 KiQgtSFJ6rsFJt5ladVLcE0huTLON36jq97Rw9RRIPx/9cUI0YxCWADXC+FyRY98yA
	 EIszDEoo4+ImNGcD/JzSRE7yMABOCWcp+srnamdEnAnuamz3kghzyKLk86XsIYtlff
	 pshldAJJUYr3g==
Message-ID: <sashiko-outbox-198921@kernel.org>
Subject: Re: [PATCH v4 6/8] selinux: Restrict cross-cgroup dma-buf charging
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
In-Reply-To: <20261104-v2_20230123_tjmercier_google_com-v4-6-1819a017000b@redhat.com>
References: <20261104-v2_20230123_tjmercier_google_com-v4-0-1819a017000b@redhat.com>
 <20261104-v2_20230123_tjmercier_google_com-v4-6-1819a017000b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 11:12:01 +0000
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
X-Rspamd-Queue-Id: 28ACB4548F
X-Spamd-Bar: -----
Message-ID-Hash: 6F2TSDA4H4BSIOMTRFMEHA2P7ULTCPNP
X-Message-ID-Hash: 6F2TSDA4H4BSIOMTRFMEHA2P7ULTCPNP
X-MailFrom: sashiko-bot@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: dri-devel@lists.freedesktop.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, op-tee@lists.trustedfirmware.org, media-ci@linuxtv.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/6F2TSDA4H4BSIOMTRFMEHA2P7ULTCPNP/>
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
- [Medium] selinux: one-off dma_buf class instead of general cgroup access =
control model
--

commit 675e985fff50ea6716b8c00023a75c07ff345a6f
Author: Albert Esteve <aesteve@redhat.com>

selinux: Restrict cross-cgroup dma-buf charging

This commit implements the selinux_dma_buf_charge_task() hook and adds a
new dma_buf object class with a charge_task permission in SELinux to
restrict cross-cgroup dma-buf memory charging.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 30776b0107f29..8f39d91eabc97 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2204,6 +2204,12 @@ static int selinux_capable(const struct cred *cred=
, struct user_namespace *ns,
>  	return cred_has_capability(cred, cap, opts, ns =3D=3D &init_user_ns);
>  }
> =20
> +static int selinux_dma_buf_charge_task(const struct cred *from, const st=
ruct cred *to)
> +{
> +	return avc_has_perm(cred_sid(from), cred_sid(to),
> +			    SECCLASS_DMA_BUF, DMA_BUF__CHARGE_TASK, NULL);
> +}
> +
>  static int selinux_quotactl(int cmds, int type, int id, const struct sup=
er_block *sb)
>  {
>  	const struct cred *cred =3D current_cred();

[ ... ]

> diff --git a/security/selinux/include/classmap.h b/security/selinux/inclu=
de/classmap.h
> index 90cb61b164256..b4ebedc6e4240 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -181,6 +181,7 @@ const struct security_class_mapping secclass_map[] =
=3D {
>  	{ "user_namespace", { "create", NULL } },
>  	{ "memfd_file",
>  	  { COMMON_FILE_PERMS, "execute_no_trans", "entrypoint", NULL } },
> +	{ "dma_buf", { "charge_task", NULL } },

[Severity: Medium]
As reported by Paul Moore on RFC [1], adding a one-off SELinux object class
and permission for a specific subsystem's cgroup charging (previously
dma_heap with charge_to, now dma_buf with charge_task in secclass_map[]
and selinux_dma_buf_charge_task(), along with charge_cgroup in a later
patch in this series) introduces a narrow, subsystem-specific policy class
rather than a general cgroup and resource access control model for SELinux.

Although resolving the target memcg from charge_fd moved into generic
memcontrol code in mem_cgroup_get_from_fd(), the SELinux hook in
selinux_dma_buf_charge_task() and class definition in secclass_map[] still
define a dma-buf-specific class instead of a broader cgroup access control
abstraction.

Should this permission check be designed around a general cgroup or resource
SELinux object class rather than a one-off dma_buf class?

[1] https://lore.kernel.org/r/16093a0278a6d7d1a0a8bc055c228bed@paul-moore.c=
om

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-v2_2023012=
3_tjmercier_google_com-v4-0-1819a017000b@redhat.com?part=3D6
