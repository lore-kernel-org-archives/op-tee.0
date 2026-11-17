Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DA7606A325
	for <op-tee@archiver.kernel.org>; Wed, 18 Nov 2026 12:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=Eczq2aCR
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3FB73454FC
	for <op-tee@archiver.kernel.org>; Wed, 18 Nov 2026 12:13:24 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=Eczq2aCR;
	dkim-atps=neutral
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6E3984547F
	for <op-tee@lists.trustedfirmware.org>; Tue, 17 Nov 2026 22:54:51 +0000 (UTC)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-55d3563e50eso4401361cf.0
        for <op-tee@lists.trustedfirmware.org>; Tue, 17 Nov 2026 14:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794956091; x=1795560891; darn=lists.trustedfirmware.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x7mnzARqVOnOj+KyQYPdVsGKtz9mrESSr8dwZPCPrb4=;
        b=Eczq2aCRWC7iPmeIbPqZyhKcs+jIOewURtkttVHto318Tw9KIQl3VvbeYACsN61cR+
         8u7fD3mXxx/44N14d5cJZMyxOjl9J1KS2A009AMZHLJu05GiGrfjBPrKZfd9q02i9mdI
         ePT5HGg4GKGXTNC0TT2TNFbJuO+epqhpaMq+eg4HSQUhQcDAAR65CiJ+/MAJEU1sQx6h
         o27TntCiUgY2BEdOk3oGN4kBdFCIvCcBUc3Uf6Isjk7Ljf9T61BtkNB0ezkNaroloEjo
         /reYJv6tYrm3F0gzFj7hC7sTfTc2DeCV2w0hfnVGQjz3Y9v1KjPMdGy1LRKJ9uB8eesT
         dl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794956091; x=1795560891;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x7mnzARqVOnOj+KyQYPdVsGKtz9mrESSr8dwZPCPrb4=;
        b=C1h0Cy2P8pREW/tCmxhnJkLRXxbT6ql7CA3UiEJVV4yhJXrvSkZWPYytE28rxTFyog
         XfRzTPiY/0vyuJdvGZuEaWU4Rjl8GCEH0cVNTf55fbHsaaJM76wfHGOwNYnyBhS3pR1m
         xNMGE+LSuc5MSOb2A2S+NRW5bKNDDSuHcOLG98ax4EFmBx3nHAnelBA2EciuFG1uGMr+
         fyB33Zj0mJhT6XZwuXNkeEvL9uTuW2Eus0OQaM8QyovlitxqmICjNqYuAKGfrFR4QOnG
         UwH6FoFtzWcSX/0Ml/nSPgsXGrJylIzM4FS/jHRrugX4eyDDMWVw05P7UrWAIuXJiwS1
         Xwvg==
X-Forwarded-Encrypted: i=1; AL+hErE4vPQdkBAlowmu54cyakhj4tDpxlstFAj5Kfnn3kV3rqYAUhiVif+KrYQgMrFBwVUmymyfZog=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z+dtesPttOK426jVrvlMSp24OcKlkcwZL/AjBGaz/+Bkqhvg2te
	roQGchOBgtEz03iIBOXo+FxNWY6C0Fo/9ETA7dLJ18t7sghiLB3e1ilp5ZqvX9ZZJw==
X-Gm-Gg: AYBFou2nx8SHuIPJAvkZoMZ69G0s/d+UMpGrig6bYiDNCq4lXOUnKHU9/TnbU1sD68Y
	tZb4txp50l7OIn/ASLtoL5sn3XWLL7oWQOKNfeWq7fh28r2BUazlXLEwKvY/cqDajdNmOUsqUoK
	ecxxb0ALTLm08WTqcKh8xFCFK4vY/IZOhmEOikyexT+PYIzmtykLed8cQ5pzagb/jERS7H+gS1m
	iOWdT6ic5ZYbzS7HQpjGc2BCXPzX8tC1A6l+7ClG/wfKD9UNTTkTRmk4pS6nD+gz3BQIRQ2gVdm
	lLYvTsI2N9yegLW9QDJne1pEhKHSY5hDWlkOB8z1dpkSFQjTL4CJCVYWeLN77xNSUSjPEb+smnW
	tYOpKmJdn3HvSrhtIFSbCHERjuwcW53CBe5pKC8Q+wb3YxaGTrvVziiLmO6CuAxGeGmkeQYmrPA
	glhKCRr2NKYzJiws4ljSr8JAlNeTSZ/OhreBSKmFwp5spjQY4+606dmH6GHzJP6LKvMDXQPgQYT
	610FSdE0JBZgeMvqYp4Irszwyv/9OazYfLTPZc8RvyKX2DWx6zj/CS1ZMmC2H15T1E9gw2ZOleJ
	RdvQpHyYap7Z3CB1SF4CezowEtNTKoILXYLgBXMRK4caBa2snzSAlBAqblG346ken9LkHWP1CI+
	TEFHRnNYvxKkLA05dxpzNo1kLUXItoMlZiS9f4OAgI5kY155+GiY=
X-Received: by 2002:a05:622a:1647:b0:535:92a6:22db with SMTP id d75a77b69052e-55d5a36e150mr14373911cf.1.1794956090990;
        Tue, 17 Nov 2026 14:54:50 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d58fea01dsm7818061cf.8.2026.11.17.14.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 14:54:49 -0800 (PST)
Date: Tue, 17 Nov 2026 17:54:48 -0500
Message-ID: <44c0c45c0e2f47ed77bc45be47ebb3fb@paul-moore.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20261117_1552/pstg-lib:20261117_1552/pstg-pwork:20261117_1552
From: Paul Moore <paul@paul-moore.com>
To: Albert Esteve <aesteve@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>,
	Christian Brauner <brauner@kernel.org>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>,
	Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
	=?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>,
	Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
	Philipp Stanner <phasta@kernel.org>
Subject: Re: [PATCH v5 4/8] lsm: Add memcg_charge_task LSM hook
References: <20261117-v2_20230123_tjmercier_google_com-v5-4-1ce975f2a9ad@redhat.com>
In-Reply-To: <20261117-v2_20230123_tjmercier_google_com-v5-4-1ce975f2a9ad@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.160.173:from];
	MIME_GOOD(-0.10)[text/plain];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[42];
	FREEMAIL_TO(0.00)[redhat.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,amd.com,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,namei.org,hallyn.com,gmail.com,infradead.org];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,kvack.org,lists.trustedfirmware.org,redhat.com,kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[71.126.255.178:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.173:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 6E3984547F
X-Spamd-Bar: --
X-MailFrom: paul@paul-moore.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: 7D3XUS3HA7G73LCWT6JRB3QR5VKOD7RY
X-Message-ID-Hash: 7D3XUS3HA7G73LCWT6JRB3QR5VKOD7RY
X-Mailman-Approved-At: Wed, 18 Nov 2026 12:12:47 +0000
CC: airlied@gmail.com, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, op-tee@lists.trustedfirmware.org, Albert Esteve <aesteve@redhat.com>, echanude@redhat.com, mripard@kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/7D3XUS3HA7G73LCWT6JRB3QR5VKOD7RY/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Nov 17, 2026 Albert Esteve <aesteve@redhat.com> wrote:
> 
> Both DMA_HEAP_IOCTL_ALLOC and the new DMA_BUF_IOCTL_XFER_CHARGE ioctl
> accept a charge_fd field that, when set, causes the allocation to be
> charged to an arbitrary process's cgroup rather than the caller's.
> 
> Charging is currently limited to the caller's own memcg subtree unless
> the caller holds CAP_SYS_RESOURCE. But the capability is all-or-nothing.
> A process holding it, along with a dma-heap device node or a dma-buf
> fd can charge unlimited memory to any other process's cgroup, potentially
> exhausting that cgroup's limit and triggering OOM kills independent of
> the victim's own activity or privileges.
> 
> Add security_memcg_charge_task(), called in get_obj_cgroup_from_fd()
> when charge_fd refers to another process. The hook receives
> the credentials of the allocating process (from) and the credentials
> of the process whose cgroup will be charged (to), giving security
> modules a controlled enforcement point for cross-cgroup objcg
> attribution policy.
> 
> When CONFIG_SECURITY is not set the hook compiles to an inline
> returning 0, adding no overhead to the fast path.
> 
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  7 +++++++
>  mm/memcontrol.c               | 11 +++++++++++
>  security/security.c           | 15 +++++++++++++++
>  4 files changed, 34 insertions(+)

...

> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 03cd90d5e623..2e6fcbe14d43 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -60,6 +60,7 @@
>  #include <linux/lockdep.h>
>  #include <linux/resume_user_mode.h>
>  #include <linux/psi.h>
> +#include <linux/security.h>
>  #include <linux/seq_buf.h>
>  #include <linux/sched/isolation.h>
>  #include <linux/kmemleak.h>
> @@ -3198,10 +3199,12 @@ static bool mem_cgroup_may_charge(struct mem_cgroup *memcg)
>  struct obj_cgroup *get_obj_cgroup_from_fd(int fd)
>  {
>  	struct cgroup_subsys_state *css;
> +	const struct cred *tcred;
>  	struct obj_cgroup *objcg;
>  	struct mem_cgroup *memcg;
>  	struct task_struct *task;
>  	unsigned int pidfd_flags;
> +	int ret;
>  
>  	if (mem_cgroup_disabled())
>  		return ERR_PTR(-EOPNOTSUPP);
> @@ -3226,6 +3229,14 @@ struct obj_cgroup *get_obj_cgroup_from_fd(int fd)
>  		if (IS_ERR(task))
>  			return ERR_CAST(task);
>  
> +		tcred = get_task_cred(task);
> +		ret = security_memcg_charge_task(current_cred(), tcred);

Do you ever envision this "from" cred being something other than
current_cred()?  If the answer is "no", we might want to consider changing
the LSM hook slightly to help prevent misuse in the future:

  int security_current_memcg_charge_task(const struct cred *tcred);

> +		put_cred(tcred);
> +		if (ret) {
> +			put_task_struct(task);
> +			return ERR_PTR(ret);
> +		}
> +
>  		rcu_read_lock();
>  		css = task_css(task, memory_cgrp_id);
>  		put_task_struct(task);

--
paul-moore.com
