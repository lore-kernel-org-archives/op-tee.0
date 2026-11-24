Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0E3606A31E
	for <op-tee@archiver.kernel.org>; Tue, 24 Nov 2026 13:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=ULDyXIuy;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=pZz6ZTps
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 74B3F45509
	for <op-tee@archiver.kernel.org>; Tue, 24 Nov 2026 13:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1795528663;
	bh=8eiWIElRuMA8mX/pS9oYBItgRhxDb5aDKJ8dJoSy/BM=;
	h=References:In-Reply-To:Date:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=ULDyXIuyHiMUlkBLFQdbVQrNHsYcgvOxka0NOcihudNXXjGRzHneey0gDZp5ZVF6P
	 j1HVQEvQEYDDjDCFJVq92bJXDAQoP2p3Co/stS6azDymyB0WaU/EDW5K++Q2Uz2A68
	 WtQ9Vc8vTYCs+cCGnGgbUCbuvwD/PZJshBqqFkGZCZ+VUCayPupCizR8ocEcFyCkKj
	 eyKWtLhR5WWss/HPwtdmCvF8dYC/a2wlSgRqUQ+08PsnlQBp0OI+RY+wkkMctnQZJO
	 mKg3otAAIBkeD/OrqGaJgC3Enp5sqLYLyyCmnHLSfpUq/WScgOKyWUrRPLK6lowTIt
	 jw1HCZQOF0WYg==
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 13B4044A3B
	for <op-tee@lists.trustedfirmware.org>; Tue, 24 Nov 2026 13:50:12 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=pZz6ZTps;
	dkim-atps=neutral
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4a3e706b5dfso2913237f8f.2
        for <op-tee@lists.trustedfirmware.org>; Tue, 24 Nov 2026 05:50:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795528211; cv=none;
        d=google.com; s=arc-20260327;
        b=RpuI/Gpg7gLprGE861ARfoMcHGwhCGOKKt3nezTBweYXhe+UyXtL7xic0JrN0gVV61
         TZW0HfroevjCl9MYeTeRHN6n4T/DmEZue77OlVYzl7fmMCTpNW1W8m3xAdQLmxZK2sAb
         sfgK+yWcdHpeyJTIhLKP1VCB6fGiEUwPaOimrB7vzACOuUSF0mcZbgvlSxJNIKo9vZMU
         Y3NpwujwabTGq5rckPDdljnxoRQQnfuS/xxZfmS8xt5sUYXrLIiynmJlrK/IRPFBO8SV
         3lBh9jcjUOjRmHJL1iMCJAaAguFKJB2qGaNoKXBPOlpVG9Hgh9p4exQEqo1ug0Gyw/fK
         zNEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XTPCHg4unEN6vtUDvCIgxfYMZVabwQIC4dv3+3CL15w=;
        fh=lGhaIO29XOEgi6+ec4jI2+08LC1mRFzHJyWL+YC3hdM=;
        b=B5lywLKybxNI4iaTnBMAxjpeVpq94i21Zd23ZAZmPT3jM9W+n2Bt5sM1yEhAKcNTJ0
         rVQh4NTbUsuWgowTm1ZTf1WH7Krj1UvmB+zv+zTNlcxYsLYot5hj4sBE5Wy6r08bLVsG
         5wwEEm4UqhehshSqkmWDxFCtlLDLgF/ED9lRSzNSiLKNbnm+p4qqaRmkiFOwfv6vNTK2
         7Ou3GjgfQLvhhAn0+nQfEMkmkXcjPhfNziw3bx6mg7gih2Zb2lkBBkAWRgHBhEKk89yb
         HPBXfUkn0vFECToy7s1+Q6Zq63xpaCDJtDCHusGPq2pofQq9ZFPncPY8Ik83T1QNrpL2
         MXfA==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1795528211; x=1796133011; darn=lists.trustedfirmware.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XTPCHg4unEN6vtUDvCIgxfYMZVabwQIC4dv3+3CL15w=;
        b=pZz6ZTps6KT0Ih5c/hJKAcQGq6RDWsVQae22kkSSTaKgcNZM8s6kbuwdmeQybIOLeU
         zK6S+/k0rXndrtcBUM5dUgx6FJCAuMfNnp+0pBXZVrNr8RbNM2lZxuxQG8Nc/VQEGOiN
         sOH2jVtNB/0/oOQKLnBZZQYuz5vFZwbaobUwst2LxqdFHbLNZAbRgq2I2aMS04bg92sW
         qTT6sEXsK7pc/npPqdg+0sToDDQn0DTEJKbukF4C8uhfqPZMavD9DFy2LIyz8hUsO8z3
         gJcQPFItn1YdYNG44NnscXKdeHrKGPYHdHJT6nmXh4V3mPqrokbXgEUaXEjuuyFBFnXh
         ZEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795528211; x=1796133011;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XTPCHg4unEN6vtUDvCIgxfYMZVabwQIC4dv3+3CL15w=;
        b=SnoXbbSaaNpilE5U4+px9On/VH/L1Tee7Ip2kMW0yz7IjrxrZeN0Ynk0L8VdOkgidH
         SM2rb00OtJNN+j8lCL1xoxmKNB2FtVaTShhPcR4fw6rO69JaTtsO2mikPpdNGbAC14Ye
         CCmlgwgfc/m0NwbsYYgsCOrpIQdHRZLZ55UyysVKX5nnOmafEYTrsw70H0xrv5NlDRht
         sFkQ0oRvGmnUOA86ELlc8Vxw4lZcKWLpu6gBUN3GtYDK6hsFEHaB240fmfEACbyra5Yj
         XvFIACaES0rgs7/m2lWKxpeiRhqEHh75ACt58FmYO1bMywI6mm27wYBSD3dKtGN0WEn7
         Kz7g==
X-Forwarded-Encrypted: i=1; AL+hErGJWmRk6S/JHXwG0/hRAptFDLgh4xHkX5B0NKRcuRHPlKfBw8xoMoOMOVVZLQsvVWfVLV3Yleg=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z+8w9hWgR4Cnaf88RAc7nbStVIpQ4LBO5nBiL9KBUr0hjDKsLpm
	WJyfEtK3b/1ru6waqF9NaglztNXl5HT71rpAV0UvkNSKLSSpS+qIGoUiCJcoLWaiRy/F2/lkErl
	JHEXVq/EGG9bq8QnCkLUGmhxgoVvb31o=
X-Gm-Gg: AZFdTZfsBs6RtRQdzHrDbtuqlU7RLwa9CMAw27IllVza8Ofy6hPuTbGv2hwfTxhENaw
	GvwyX/4PNbGiZrhqTeWSwrK5tkDJMWOY7HkkJchKOcijzpUA7ztIa+JhCUVZbBRvOSFHoGOifPM
	4KpgZT2BBVlNEDuIe9+8NNVcjF3m3CX9oahNjiLacrZi2qQRaPEqCXqHRBBwZJe2eJiXS4sUe7x
	2GbS5eaD7vnZy5YpKeZxAeRcC9BgfbltN+RdnsVVNRCCWgshLsTm+Dvk62ESrJjHLetMc8wX8o6
	MmKPpm3FrhPX3UP1sKZ+vA91YXNBeh1AOYKSI7UgTC8v0Az3J0asoYELFB1JQH4yGo0m+VLeJof
	zY9XroxnFIemkrmtD95wiQotVr02FdewaJEhNcgC/6WWJALsZ0wWm
X-Received: by 2002:a05:600c:800e:b0:4bb:7757:fe58 with SMTP id
 5b1f17b1804b1-4bb8881b9d7mr305306125e9.19.1795528210579; Tue, 24 Nov 2026
 05:50:10 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261124-v2_20230123_tjmercier_google_com-v6-0-dce12fa03ad6@redhat.com>
 <20261124-v2_20230123_tjmercier_google_com-v6-6-dce12fa03ad6@redhat.com>
In-Reply-To: <20261124-v2_20230123_tjmercier_google_com-v6-6-dce12fa03ad6@redhat.com>
Date: Tue, 24 Nov 2026 14:49:55 +0100
X-Gm-Features: Aa3M54qkPJ8C4GRzLQzCC_QtBShd4rpGnT89RPbtOkkrzzkAiMVQPjTTZfQmmls
Message-ID: <CAJ2a_DeDF+9pbLKS9pcX4Tot4xZZ-K7HydKnDjW6TWC5bvREzQ@mail.gmail.com>
Subject: Re: [PATCH v6 6/7] selinux: Restrict cross-cgroup memcg charging
To: Albert Esteve <aesteve@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20260707];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_FROM(0.00)[googlemail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,amd.com,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com,infradead.org,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,kvack.org,lists.trustedfirmware.org,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[42];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[googlemail.com:+];
	MISSING_XM_UA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.221.47:from];
	ALIAS_RESOLVED(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.221.47:from];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	DWL_DNSWL_NONE(0.00)[googlemail.com:dkim]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 13B4044A3B
X-Spamd-Bar: ---
X-MailFrom: cgzones@googlemail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: 7N4LGTYZB5PALWFLSFZE5DNARWUYVBJE
X-Message-ID-Hash: 7N4LGTYZB5PALWFLSFZE5DNARWUYVBJE
X-Mailman-Approved-At: Tue, 24 Nov 2026 13:57:40 +0000
CC: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, Jens Wiklander <j
 enswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Philipp Stanner <phasta@kernel.org>, airlied@gmail.com, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, op-tee@lists.trustedfirmware.org, echanude@redhat.com, mripard@kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/7N4LGTYZB5PALWFLSFZE5DNARWUYVBJE/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: =?utf-8?q?Christian_G=C3=B6ttsche_via_OP-TEE?= <op-tee@lists.trustedfirmware.org>
Reply-To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 24 Nov 2026 at 14:05, Albert Esteve <aesteve@redhat.com> wrote:
>
> The security_current_memcg_charge_task() and
> security_current_memcg_charge_cgroup() hooks allow security modules to
> control which processes may charge or transfer memcg memory to another
> process's cgroup, named by a pidfd, or to an arbitrary cgroup named by
> a cgroupfd, both passed in charge_fd. Without a policy implementation,
> either hook is a no-op and the restriction is not enforced.
>
> On SELinux-managed systems the only limit is CAP_SYS_RESOURCE. A
> domain that holds both dma-heap access (today's only exporter that
> opts-in) and that capability, can charge memory to any cgroup outside
> its own subtree. Since the capability is all-or-nothing, SELinux
> policy cannot express which targets such a domain may charge to.
>
> Implement both selinux_memcg_charge_task() and
> selinux_memcg_charge_cgroup() using avc_has_perm() with a new cgroup
> object class and a new charge_to permission. Both charge_fd flavours
> ultimately charge a cgroup, so one permission covers them and the
> target type keeps the distinction: for the pidfd path the target is
> the referred task's SID, as there is no cgroup object to take a label
> from; for the cgroupfd path it is the cgroup directory's inode SID,
> which comes from the genfscon entry for cgroupfs unless the directory
> is relabeled.
>
> The checks run when the charge target is resolved, before the
> CAP_SYS_RESOURCE baseline is evaluated, and apply to every explicit
> charge_fd target, including the caller's own subtree, so policy needs
> a rule even for self-charging. Policy authors can then grant
> cross-cgroup charging selectively, for example:
>
>   allow allocator_app_t client_app_t:cgroup charge_to;
>   allow allocator_app_t cgroup_t:cgroup charge_to;
>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  security/selinux/hooks.c            | 19 +++++++++++++++++++
>  security/selinux/include/classmap.h |  1 +
>  2 files changed, 20 insertions(+)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 6c4c64d6e904..76a714107ae4 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2204,6 +2204,23 @@ static int selinux_capable(const struct cred *cred, struct user_namespace *ns,
>         return cred_has_capability(cred, cap, opts, ns == &init_user_ns);
>  }
>
> +static int selinux_memcg_charge_task(const struct cred *to)
> +{
> +       const struct cred *cred = current_cred();
> +
> +       return avc_has_perm(cred_sid(cred), cred_sid(to),

Small nit:
`cred_sid(current_cred())` could be simplified using `current_sid()`

> +                           SECCLASS_CGROUP, CGROUP__CHARGE_TO, NULL);
> +}
> +
> +static int selinux_memcg_charge_cgroup(const struct file *file)
> +{
> +       const struct cred *cred = current_cred();
> +       struct inode_security_struct *isec = inode_security(file_inode(file));
> +
> +       return avc_has_perm(cred_sid(cred), isec->sid, SECCLASS_CGROUP,
> +                           CGROUP__CHARGE_TO, NULL);
> +}
> +
>  static int selinux_quotactl(int cmds, int type, int id, const struct super_block *sb)
>  {
>         const struct cred *cred = current_cred();
> @@ -7683,6 +7700,8 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
>         LSM_HOOK_INIT(capget, selinux_capget),
>         LSM_HOOK_INIT(capset, selinux_capset),
>         LSM_HOOK_INIT(capable, selinux_capable),
> +       LSM_HOOK_INIT(memcg_charge_task, selinux_memcg_charge_task),
> +       LSM_HOOK_INIT(memcg_charge_cgroup, selinux_memcg_charge_cgroup),
>         LSM_HOOK_INIT(quotactl, selinux_quotactl),
>         LSM_HOOK_INIT(quota_on, selinux_quota_on),
>         LSM_HOOK_INIT(syslog, selinux_syslog),
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index 90cb61b16425..1f1f2fc4d35d 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -181,6 +181,7 @@ const struct security_class_mapping secclass_map[] = {
>         { "user_namespace", { "create", NULL } },
>         { "memfd_file",
>           { COMMON_FILE_PERMS, "execute_no_trans", "entrypoint", NULL } },
> +       { "cgroup", { "charge_to", NULL } },
>         /* last one */ { NULL, {} }
>  };
>
>
> --
> 2.55.0
>
>
