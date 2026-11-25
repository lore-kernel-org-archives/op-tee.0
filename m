Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6A4606A33C
	for <op-tee@archiver.kernel.org>; Wed, 25 Nov 2026 16:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=lPyIzYoG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ED6SXkz2
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5A39750358
	for <op-tee@archiver.kernel.org>; Wed, 25 Nov 2026 16:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1795623320;
	bh=DPD3ckMwipOEvzHdL0Yf9XadLzvKMexhmsBNHvnmJ+o=;
	h=References:In-Reply-To:Date:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=lPyIzYoGEyP2MuYiljWULrbzwyN8SxMcXLHK73y2aq+UmFRjgRRlymJ/7wCs9tFZZ
	 aPR4/7P52hsMjdupnqtHL96Y/UoXaWlo8Y6MdmiNnFzGz/3PLuuj/xUXyzPKYphMAI
	 nbLTOPmuUfh7s1pidZMoRL0en2hLTj2vhlTyGf5OAmV6ek1fUWc0KF44N+me6VEHdA
	 W1XmI1jXlqVOxWp1bLuD+UZWLzivCY5qyhv17XhUm/lAFK/Lg4GZWvy9/nuCAzofOv
	 Th6zAOKucJYPhrPndwOy+6iPVPhrh5yERS3HFVk7x0elDntMCe8xf+Z04Krf3+LJQv
	 6iEiDSamc3CjA==
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6F1B8452B4
	for <op-tee@lists.trustedfirmware.org>; Wed, 25 Nov 2026 16:15:16 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ED6SXkz2;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795623316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ikIAQDWUd4oIdUiwPTrXqLa3Yct6IL/NQnfK5N4xiCQ=;
	b=ED6SXkz2CQUbgx+ir14PqIvoVo6ejnZpFqevL21sd9FC3PWTIafF2J5+T/gk5cNZwTVadf
	8oYSnj/Q7glfuxbO/LolZyn2Cr0c8WzydhB28MjDvblNC/kWUKScwnvuf2CSplIgW5G+HH
	LL2/r+PtHh/wOz7Z7l0buh3CTvG466E=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-ls8vFp0rMe6syfjWFUoQxw-1; Wed, 25 Nov 2026 16:15:08 +0000
X-MC-Unique: ls8vFp0rMe6syfjWFUoQxw-1
X-Mimecast-MFC-AGG-ID: ls8vFp0rMe6syfjWFUoQxw_1795623308
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4cbf700ddccso4379042b6e.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 25 Nov 2026 08:15:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795623308; x=1796228108;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ikIAQDWUd4oIdUiwPTrXqLa3Yct6IL/NQnfK5N4xiCQ=;
        b=S8W4N9OfC3tDXdyrZOEOCyJ7vONOj+2WARwI0W2TGlq7wNxMVnA87eJJ2KLx+tTHnK
         atmr+PYE6liAe6EKszojN3gxSYHrSZwaCyif1pGJuFKBe5HlgmzT470YdYTSOFrnXSmt
         JkkzzUQ2k6+KHu1+3ouZOCSchxka4+jkrAtAhX6jFAAWQGiz60gg+HrGnIhViOj67hmK
         7hYkTHuJBJwDzg8CHOlu0zcXXOmWeGqfjkH7VXR/mhPTU+bW/Rgv9pHh313eD7hI2Qsh
         NyQ4q/HyDw409pDYwYnFfGoGpRqoFiZrMLJHm1EyYp2b/nWSmAaM9icdyqx637oZXrWX
         Eb4Q==
X-Forwarded-Encrypted: i=1; AL+hErFwz7y2rw7lwspYxoF1Bm2epDR2BV4s4dM/2kT5lMHs7F/6G2+JbD84CnNNdXyCy4Adjr7+pzA=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z8JeK/icmTpscqJBNVItaTdV1jga9/Ht/APa9nyznjMGLylhZPD
	0R9kaCVzZlJnfIougdBqka2nANNJYkIAV1NF180FdjgYS9cimPqEQUSNm2AyVASDlBfP3vvPIuF
	8KI3LfLJTGwHhkQijyuoFrmmdbUNfHA0jeTSX7EB48QqZGT2+NUlTS9Bb9RFSKzN/HwjaleT7gH
	N0oj6+4u6lsRdS1FR5rS4OlVc/hzYXROvAGsFawNT4O00Cug==
X-Gm-Gg: AZFdTZfZtJqirR03/0Y7Bj8dtbdaDcvI7y+BuB5CqPMrRw9tgkToz/iZvh4lvFAgPdF
	JSRmEmeUniKZ6pK4p5dTe5dRspax6fhsiuI1rHWeq6XJPqQ7HYUAYaB53Iwdgs7a7YvjrHWUtJm
	guFG6KhUzsIinIbwD0gm389gK0JiP9wmjfSYDmWe1Pf/smWLbAzJm/MQt7
X-Received: by 2002:a05:6808:1a10:b0:564:48f3:dfa8 with SMTP id 5614622812f47-57a0a111c93mr20349850b6e.11.1795623307637;
        Wed, 25 Nov 2026 08:15:07 -0800 (PST)
X-Received: by 2002:a05:6808:1a10:b0:564:48f3:dfa8 with SMTP id
 5614622812f47-57a0a111c93mr20349798b6e.11.1795623307221; Wed, 25 Nov 2026
 08:15:07 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261124-v2_20230123_tjmercier_google_com-v6-0-dce12fa03ad6@redhat.com>
 <20261124-v2_20230123_tjmercier_google_com-v6-6-dce12fa03ad6@redhat.com> <CAJ2a_DeDF+9pbLKS9pcX4Tot4xZZ-K7HydKnDjW6TWC5bvREzQ@mail.gmail.com>
In-Reply-To: <CAJ2a_DeDF+9pbLKS9pcX4Tot4xZZ-K7HydKnDjW6TWC5bvREzQ@mail.gmail.com>
Date: Wed, 25 Nov 2026 17:14:55 +0100
X-Gm-Features: Aa3M54qg8B1tVY9MI_hj21-3fP47U-BOsj1Lrj8qIxJDIaifgpgCHqLTs9bOP0k
Message-ID: <CADSE00JMSXm4Vi5aH=k3VgLL__EsdEZgg_PqkSkK0LQumj1SUQ@mail.gmail.com>
Subject: Re: [PATCH v6 6/7] selinux: Restrict cross-cgroup memcg charging
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UY6NfHDNmJwyNnivG05H6MOsI7igjnoNw8Um6lC3DsM_1795623308
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[redhat.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	RWL_MAILSPIKE_EXCELLENT(-0.40)[170.10.129.124:from];
	R_SPF_ALLOW(-0.20)[+ip4:170.10.129.0/24];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[170.10.129.124:from];
	RCPT_COUNT_TWELVE(0.00)[42];
	FREEMAIL_TO(0.00)[googlemail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,amd.com,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com,infradead.org,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,kvack.org,lists.trustedfirmware.org,redhat.com];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ASN(0.00)[asn:30031, ipnet:170.10.128.0/23, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.167.198:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 6F1B8452B4
X-Spamd-Bar: ----
Message-ID-Hash: AWPRYML4HTX43QL72AL4JOHQLWTCOF3Q
X-Message-ID-Hash: AWPRYML4HTX43QL72AL4JOHQLWTCOF3Q
X-MailFrom: aesteve@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, Jens Wiklander <j
 enswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Philipp Stanner <phasta@kernel.org>, airlied@gmail.com, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, op-tee@lists.trustedfirmware.org, echanude@redhat.com, mripard@kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/AWPRYML4HTX43QL72AL4JOHQLWTCOF3Q/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: Albert Esteve via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Albert Esteve <aesteve@redhat.com>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 2:50=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Tue, 24 Nov 2026 at 14:05, Albert Esteve <aesteve@redhat.com> wrote:
> >
> > The security_current_memcg_charge_task() and
> > security_current_memcg_charge_cgroup() hooks allow security modules to
> > control which processes may charge or transfer memcg memory to another
> > process's cgroup, named by a pidfd, or to an arbitrary cgroup named by
> > a cgroupfd, both passed in charge_fd. Without a policy implementation,
> > either hook is a no-op and the restriction is not enforced.
> >
> > On SELinux-managed systems the only limit is CAP_SYS_RESOURCE. A
> > domain that holds both dma-heap access (today's only exporter that
> > opts-in) and that capability, can charge memory to any cgroup outside
> > its own subtree. Since the capability is all-or-nothing, SELinux
> > policy cannot express which targets such a domain may charge to.
> >
> > Implement both selinux_memcg_charge_task() and
> > selinux_memcg_charge_cgroup() using avc_has_perm() with a new cgroup
> > object class and a new charge_to permission. Both charge_fd flavours
> > ultimately charge a cgroup, so one permission covers them and the
> > target type keeps the distinction: for the pidfd path the target is
> > the referred task's SID, as there is no cgroup object to take a label
> > from; for the cgroupfd path it is the cgroup directory's inode SID,
> > which comes from the genfscon entry for cgroupfs unless the directory
> > is relabeled.
> >
> > The checks run when the charge target is resolved, before the
> > CAP_SYS_RESOURCE baseline is evaluated, and apply to every explicit
> > charge_fd target, including the caller's own subtree, so policy needs
> > a rule even for self-charging. Policy authors can then grant
> > cross-cgroup charging selectively, for example:
> >
> >   allow allocator_app_t client_app_t:cgroup charge_to;
> >   allow allocator_app_t cgroup_t:cgroup charge_to;
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  security/selinux/hooks.c            | 19 +++++++++++++++++++
> >  security/selinux/include/classmap.h |  1 +
> >  2 files changed, 20 insertions(+)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 6c4c64d6e904..76a714107ae4 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2204,6 +2204,23 @@ static int selinux_capable(const struct cred *cr=
ed, struct user_namespace *ns,
> >         return cred_has_capability(cred, cap, opts, ns =3D=3D &init_use=
r_ns);
> >  }
> >
> > +static int selinux_memcg_charge_task(const struct cred *to)
> > +{
> > +       const struct cred *cred =3D current_cred();
> > +
> > +       return avc_has_perm(cred_sid(cred), cred_sid(to),
>
> Small nit:
> `cred_sid(current_cred())` could be simplified using `current_sid()`

Nice, thanks! I will apply that for the next version.

>
> > +                           SECCLASS_CGROUP, CGROUP__CHARGE_TO, NULL);
> > +}
> > +
> > +static int selinux_memcg_charge_cgroup(const struct file *file)
> > +{
> > +       const struct cred *cred =3D current_cred();
> > +       struct inode_security_struct *isec =3D inode_security(file_inod=
e(file));
> > +
> > +       return avc_has_perm(cred_sid(cred), isec->sid, SECCLASS_CGROUP,
> > +                           CGROUP__CHARGE_TO, NULL);
> > +}
> > +
> >  static int selinux_quotactl(int cmds, int type, int id, const struct s=
uper_block *sb)
> >  {
> >         const struct cred *cred =3D current_cred();
> > @@ -7683,6 +7700,8 @@ static struct security_hook_list selinux_hooks[] =
__ro_after_init =3D {
> >         LSM_HOOK_INIT(capget, selinux_capget),
> >         LSM_HOOK_INIT(capset, selinux_capset),
> >         LSM_HOOK_INIT(capable, selinux_capable),
> > +       LSM_HOOK_INIT(memcg_charge_task, selinux_memcg_charge_task),
> > +       LSM_HOOK_INIT(memcg_charge_cgroup, selinux_memcg_charge_cgroup)=
,
> >         LSM_HOOK_INIT(quotactl, selinux_quotactl),
> >         LSM_HOOK_INIT(quota_on, selinux_quota_on),
> >         LSM_HOOK_INIT(syslog, selinux_syslog),
> > diff --git a/security/selinux/include/classmap.h b/security/selinux/inc=
lude/classmap.h
> > index 90cb61b16425..1f1f2fc4d35d 100644
> > --- a/security/selinux/include/classmap.h
> > +++ b/security/selinux/include/classmap.h
> > @@ -181,6 +181,7 @@ const struct security_class_mapping secclass_map[] =
=3D {
> >         { "user_namespace", { "create", NULL } },
> >         { "memfd_file",
> >           { COMMON_FILE_PERMS, "execute_no_trans", "entrypoint", NULL }=
 },
> > +       { "cgroup", { "charge_to", NULL } },
> >         /* last one */ { NULL, {} }
> >  };
> >
> >
> > --
> > 2.55.0
> >
> >
>

