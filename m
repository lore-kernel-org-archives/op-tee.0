Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4410960A2628
	for <op-tee@archiver.kernel.org>; Thu, 12 Nov 2026 08:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=KJ//XFKn;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C+q8E5O4
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 83F9A4550F
	for <op-tee@archiver.kernel.org>; Thu, 12 Nov 2026 08:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1794473858;
	bh=wCAAKnWd5R6G/eyHlrVeT+qTNeLUKhT52N/73xBBAGo=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=KJ//XFKnHQV1aqgtLst/Ml0Lkk7kJg1ac5YKpor/b57UvLUSk1QJqIQVzb6cBNd6W
	 wmGJquJTPTgUCVTpoCrvfNb/C566trqh66Cb5LmS4rg1nsyNhMdKOplQplM840tL25
	 Iec9twFfOMSJmMjxje9UEOQfuI/kqIg0xsqkKOyj+cmmtun+iaZHKoN2hAEnLcbWAr
	 P50VzKwRiJEdIoLAF1LhTcXjjX8yK/CFFAP6cWe6GfFqcksSb3+uyN5YzGBR/r+Ltk
	 OPAEpWQggxu2tfjMZtvyfnq9LHi6dGm+A+CBxj1CO9NBMhdMGn9P5SwMOwhRA+X236
	 DVhd2LhAlvSUg==
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 124C544F86
	for <op-tee@lists.trustedfirmware.org>; Thu, 12 Nov 2026 08:57:19 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C+q8E5O4;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794473838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+IM6c9SQzhSiNLCPJKNescY2jVpZ6DadiC6JkBUJ1jI=;
	b=C+q8E5O4lQJFv4qkiux7KyKKUTozpyGAehRl10GDR8JLSmRBVEmVmnowmsx29TwyDyZWDN
	fziidfkQ3GXxXGBRFmKwTfwwlAeCJfChorWeTjOu3YqUprll5VSjK3TpNmBOdBfLy7KOmV
	Q+ZE5KptEiNYmquB/U8cm8jowqoqCLo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-GZuw4zr4NguFepk4LQANhw-1; Thu, 12 Nov 2026 03:57:17 -0500
X-MC-Unique: GZuw4zr4NguFepk4LQANhw-1
X-Mimecast-MFC-AGG-ID: GZuw4zr4NguFepk4LQANhw_1794473836
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a17741243eso24684775e9.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 12 Nov 2026 00:57:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794473836; x=1795078636;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+IM6c9SQzhSiNLCPJKNescY2jVpZ6DadiC6JkBUJ1jI=;
        b=KkNxJnHrzQo6JMXtQ+LINoabSmf1hm5mmKSaIetfAyO/irRcCIbjjt6Os0YUcJm1E5
         gI1HMn5E8ORGa37JhwH1asiVuS5AQgPBeFI+7m4335fDgCrw2Lw6fcnPcnveYmwTRW6R
         3G+ASbUqsXozP5ZfLJ36FQtRk11YVDUH9+UbfS9z+/9Yj+2GQTHqtGPcat0JoLQKoEVp
         EeP7bVZa3F192tO6UU5iAwAyIeAbjKhKIoInb/tJzq9D0BDrAl/RqucBmQAu0G/Fck0t
         kdXQhG4v0B16C3XaFTSnWzzxhuK/ikhlIAJWjMbcGiqW/e2YUOOF+dPzUn6pqNQy+DHZ
         Rf+A==
X-Forwarded-Encrypted: i=1; AL+hErHiHFePZI9Wy5Y/t0y4Wi1gXEMWjeFRLcO9cyZI2oOGR5AZhCysl/7ZCg9g+0KJZasToZp7jJY=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z/MxmjM4QR9DGLzpKCcx4o5MwtfNPcnDqFyHgA0rlMPCgJ7bzfp
	VXJh5D22z/ELgeY7hTxMB2Jl09YbEH5HR+U2oAg+7+ApXCW4mS7aMCc9neXyBn4/liCa56fbUOh
	UxX5Ozx4qtAkwDAMbycFdHuZYu5Dl0pTU37p4/RlH8sriShs/B5+xvL787f5YFuG9orrWfjA=
X-Gm-Gg: AYBFou2iRXN8anp2cczYgj157BnaIDCZnU9zM6BayUyT5NhYMQV4fb/HvddVe8RO+pO
	76Cyw1GUpSJcpUyq9m1YUp4FW+iYSeQo/IHArYjsuawQQrO7NKM8Lvno1QuXotw8pnN371uMRqL
	OhdjKrKi9Z5yUkktEHJT/O13hPbLX3YCsruG8+ujK9JvWG2V1iJHZQ+G4IZpq/y1QCuC6sdMYqe
	HFo/kIGyTTruc8JYcaW5+GfkW14hNDK/6otaR/3L1kgwBtVngGdMdjdIll/3ngUSAy3o0pMKfdR
	xgm4j8flTduxopJRRMdGlQENuTdnWtJqEYtBNck2PO7K3zdM2sj3XrB8rJSYe99PiMDKlDzXJOP
	QHKaIza9DwFykRI2MzxaBKQYULKpFv/7UR2smrbFfTlY=
X-Received: by 2002:a05:600c:1c0d:b0:4a2:1e1:d55 with SMTP id 5b1f17b1804b1-4ba093a3cf9mr102100825e9.28.1794473835958;
        Thu, 12 Nov 2026 00:57:15 -0800 (PST)
X-Received: by 2002:a05:600c:1c0d:b0:4a2:1e1:d55 with SMTP id 5b1f17b1804b1-4ba093a3cf9mr102100215e9.28.1794473835545;
        Thu, 12 Nov 2026 00:57:15 -0800 (PST)
Received: from localhost ([139.47.30.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e251686sm54810695e9.3.2026.11.12.00.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 00:57:15 -0800 (PST)
Date: Thu, 12 Nov 2026 09:57:14 +0100
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [Linaro-mm-sig] [PATCH v4 1/8] memcg: Add MEMCG_DMABUF
 accounting infrastructure
Message-ID: <avV_asMMt16Q5S7S@aesteve-thinkpadp1gen8.rmtes.csb>
References: <20261104-v2_20230123_tjmercier_google_com-v4-0-1819a017000b@redhat.com>
 <20261104-v2_20230123_tjmercier_google_com-v4-1-1819a017000b@redhat.com>
 <96d6a6e828310738c0cb4550752a0b5808a81ef9.camel@linux.intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <96d6a6e828310738c0cb4550752a0b5808a81ef9.camel@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zzYuijFvjy3hX0hlrYdG67_qMfpwO6XeqiVu04WBvKw_1794473836
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[redhat.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	RWL_MAILSPIKE_EXCELLENT(-0.40)[170.10.129.124:from];
	R_SPF_ALLOW(-0.20)[+ip4:170.10.129.0/24];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[170.10.129.124:from];
	RCPT_COUNT_TWELVE(0.00)[38];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,amd.com,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com,infradead.org,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,kvack.org,lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:30031, ipnet:170.10.128.0/23, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.72:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 124C544F86
X-Spamd-Bar: -----
Message-ID-Hash: CDPGVPJIIEM3GZ2KWAPRX5IF45W3D64U
X-Message-ID-Hash: CDPGVPJIIEM3GZ2KWAPRX5IF45W3D64U
X-MailFrom: aesteve@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Sumit Semwal <sumit.semwal@linaro.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>, Jens Wiklander
  <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/CDPGVPJIIEM3GZ2KWAPRX5IF45W3D64U/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: Albert Esteve via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Albert Esteve <aesteve@redhat.com>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 08:26:35AM +0100, Thomas Hellstr=F6m wrote:
> On Wed, 2026-11-04 at 12:09 +0100, Albert Esteve wrote:
> > From: "T.J. Mercier" <tjmercier@google.com>
> >=20
> > Introduce a MEMCG_DMABUF stat counter and helpers for charging,
> > cancelling, and uncharging dma-buf memory against a memory cgroup.
> >=20
> > The charge is tracked on struct dma_buf via a new memcg pointer.
> > The memcg reference is stored into (or cleared from) dmabuf->memcg
> > by the helpers, removing the need for callers to manage those
> > details. The release path in dma_buf_release() is reduced to a
> > single mem_cgroup_uncharge_dmabuf() call.
> >=20
> > Rather than charging at the page level via __GFP_ACCOUNT, which
> > would require exporters to expose their backing pages for
> > cross-cgroup transfer via new dma_buf_ops, charges are tracked
> > externally on struct dma_buf through a single accounting path.
> >=20
> > The next patch wires up the charging policy in the dma-heap ioctl.
> >=20
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> > =A0Documentation/admin-guide/cgroup-v2.rst |=A0 4 ++
> > =A0drivers/dma-buf/dma-buf.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
|=A0 3 ++
> > =A0include/linux/dma-buf.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 |=A0 4 ++
> > =A0include/linux/memcontrol.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | =
27 +++++++++++++
> > =A0mm/memcontrol.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 | 70
> > +++++++++++++++++++++++++++++++++
> > =A05 files changed, 108 insertions(+)
> >=20
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst
> > b/Documentation/admin-guide/cgroup-v2.rst
> > index 86a2a0099178..a3265a4a953e 100644
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -1662,6 +1662,10 @@ The following nested keys are defined.
> > =A0		Amount of memory used for storing in-kernel data
> > =A0		structures.
> > =A0
> > +	=A0 dmabuf (npn)
> > +		Amount of memory used for exported DMA buffers
> > allocated by the cgroup.
> > +		Stays with the allocating cgroup regardless of how
> > the buffer is shared.
> > +
> > =A0	=A0 workingset_refault_anon
> > =A0		Number of refaults of previously evicted anonymous
> > pages.
> > =A0
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index 4c9add51f9ef..1c6b9cee7ac2 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -14,6 +14,7 @@
> > =A0#include <linux/fs.h>
> > =A0#include <linux/slab.h>
> > =A0#include <linux/dma-buf.h>
> > +#include <linux/memcontrol.h>
> > =A0#include <linux/dma-fence.h>
> > =A0#include <linux/dma-fence-unwrap.h>
> > =A0#include <linux/anon_inodes.h>
> > @@ -182,6 +183,8 @@ static void dma_buf_release(struct dentry
> > *dentry)
> > =A0
> > =A0	dmabuf->ops->release(dmabuf);
> > =A0
> > +	mem_cgroup_uncharge_dmabuf(dmabuf);
> > +
> > =A0	if (dmabuf->resv =3D=3D (struct dma_resv *)&dmabuf[1])
> > =A0		dma_resv_fini(dmabuf->resv);
> > =A0
> > diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> > index d15b2b31d3c9..23ec0ff23fba 100644
> > --- a/include/linux/dma-buf.h
> > +++ b/include/linux/dma-buf.h
> > @@ -27,6 +27,7 @@
> > =A0struct device;
> > =A0struct dma_buf;
> > =A0struct dma_buf_attachment;
> > +struct mem_cgroup;
> > =A0
> > =A0/**
> > =A0 * struct dma_buf_ops - operations possible on struct dma_buf
> > @@ -429,6 +430,9 @@ struct dma_buf {
> > =A0
> > =A0		__poll_t active;
> > =A0	} cb_in, cb_out;
> > +
> > +	/** @memcg: the cgroup to which this buffer is currently
> > attributed */
> > +	struct mem_cgroup *memcg;
> > =A0};
> > =A0
> > =A0/**
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 7d1c0ce189a8..4d1e82cf0833 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -10,6 +10,9 @@
> > =A0
> > =A0#ifndef _LINUX_MEMCONTROL_H
> > =A0#define _LINUX_MEMCONTROL_H
> > +
> > +struct dma_buf;
> > +
> > =A0#include <linux/cgroup.h>
> > =A0#include <linux/vm_event_item.h>
> > =A0#include <linux/hardirq.h>
> > @@ -40,6 +43,7 @@ enum memcg_stat_item {
> > =A0	MEMCG_ZSWAP_B,
> > =A0	MEMCG_ZSWAPPED,
> > =A0	MEMCG_ZSWAP_INCOMP,
> > +	MEMCG_DMABUF,
> > =A0	MEMCG_NR_STAT,
> > =A0};
> > =A0
> > @@ -667,6 +671,9 @@ int mem_cgroup_charge_hugetlb(struct folio*
> > folio, gfp_t gfp);
> > =A0int mem_cgroup_swapin_charge_folio(struct folio *folio, unsigned
> > short id,
> > =A0				=A0=A0 struct mm_struct *mm, gfp_t gfp);
> > =A0
> > +bool mem_cgroup_reserve_dmabuf(struct mem_cgroup *memcg, gfp_t gfp,
> > +			=A0=A0=A0=A0=A0=A0 unsigned int nr_pages);
> > +
> > =A0void __mem_cgroup_uncharge(struct folio *folio);
> > =A0
> > =A0/**
> > @@ -682,6 +689,10 @@ static inline void mem_cgroup_uncharge(struct
> > folio *folio)
> > =A0	__mem_cgroup_uncharge(folio);
> > =A0}
> > =A0
> > +void mem_cgroup_cancel_dmabuf(struct mem_cgroup *memcg, unsigned int
> > nr_pages);
> > +
> > +void mem_cgroup_uncharge_dmabuf(struct dma_buf *dmabuf);
> > +
> > =A0void __mem_cgroup_uncharge_folios(struct folio_batch *folios);
> > =A0static inline void mem_cgroup_uncharge_folios(struct folio_batch
> > *folios)
> > =A0{
> > @@ -1167,10 +1178,26 @@ static inline int
> > mem_cgroup_swapin_charge_folio(struct folio *folio,
> > =A0	return 0;
> > =A0}
> > =A0
> > +static inline bool mem_cgroup_reserve_dmabuf(struct mem_cgroup
> > *memcg,
> > +					=A0=A0=A0=A0 gfp_t gfp,
> > +					=A0=A0=A0=A0 unsigned int nr_pages)
> > +{
> > +	return true;
> > +}
> > +
> > +static inline void mem_cgroup_cancel_dmabuf(struct mem_cgroup
> > *memcg,
> > +					=A0=A0=A0 unsigned int nr_pages)
> > +{
> > +}
> > +
> > =A0static inline void mem_cgroup_uncharge(struct folio *folio)
> > =A0{
> > =A0}
> > =A0
> > +static inline void mem_cgroup_uncharge_dmabuf(struct dma_buf
> > *dmabuf)
> > +{
> > +}
> > +
> > =A0static inline void mem_cgroup_uncharge_folios(struct folio_batch
> > *folios)
> > =A0{
> > =A0}
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 856a7d07586c..e53dd7eebc3b 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -69,6 +69,7 @@
> > =A0#include <net/ip.h>
> > =A0#include "slab.h"
> > =A0#include "memcontrol-v1.h"
> > +#include <linux/dma-buf.h>
> > =A0
> > =A0#include <linux/uaccess.h>
> > =A0
> > @@ -442,6 +443,7 @@ static const unsigned int memcg_stat_items[] =3D {
> > =A0	MEMCG_ZSWAP_B,
> > =A0	MEMCG_ZSWAPPED,
> > =A0	MEMCG_ZSWAP_INCOMP,
> > +	MEMCG_DMABUF,
> > =A0};
> > =A0
> > =A0#define NR_MEMCG_NODE_STAT_ITEMS ARRAY_SIZE(memcg_node_stat_items)
> > @@ -1625,6 +1627,7 @@ static const struct memory_stat memory_stats[]
> > =3D {
> > =A0#ifdef CONFIG_HUGETLB_PAGE
> > =A0	{
> > "hugetlb",			NR_HUGETLB			},
> > =A0#endif
> > +	{
> > "dmabuf",			MEMCG_DMABUF			},
> > =A0
> > =A0	/* The memory events */
> > =A0	{
> > "workingset_refault_anon",	WORKINGSET_REFAULT_ANON		},
> > @@ -5658,6 +5661,73 @@ void mem_cgroup_flush_workqueue(void)
> > =A0	flush_workqueue(memcg_wq);
> > =A0}
> > =A0
> > +/**
> > + * mem_cgroup_reserve_dmabuf - charge a memcg for a dma-buf
> > allocation
> > + * @memcg: memcg to charge (may be %NULL)
> > + * @gfp_mask: reclaim mode
> > + * @nr_pages: number of pages to charge
> > + *
> > + * Charges @nr_pages against @memcg. Call this before allocating
> > pages so
> > + * the cgroup limit is enforced up front. On success the caller must
> > + * finalize the charge with the MEMCG_DMABUF stat update, or call
> > + * mem_cgroup_cancel_dmabuf() to undo it.
> > + *
> > + * Returns %true on success, %false if the charge would exceed the
> > limit.
> > + */
> > +bool mem_cgroup_reserve_dmabuf(struct mem_cgroup *memcg, gfp_t
> > gfp_mask,
> > +			=A0=A0=A0=A0=A0=A0 unsigned int nr_pages)
> > +{
> > +	if (!memcg || mem_cgroup_disabled())
> > +		return true;
> > +
> > +	if (try_charge(memcg, gfp_mask, nr_pages))
> > +		return false;
> > +
> > +	return true;
> > +}
> > +EXPORT_SYMBOL_GPL(mem_cgroup_reserve_dmabuf);
> > +
> > +/**
> > + * mem_cgroup_cancel_dmabuf - undo a dma-buf charge
> > + * @memcg: memcg to uncharge (may be %NULL)
> > + * @nr_pages: same value passed to mem_cgroup_reserve_dmabuf()
> > + *
> > + * Returns @nr_pages of charge to @memcg. Use when the allocation
> > fails
> > + * after mem_cgroup_reserve_dmabuf().
> > + */
> > +void mem_cgroup_cancel_dmabuf(struct mem_cgroup *memcg, unsigned int
> > nr_pages)
> > +{
> > +	if (!memcg)
> > +		return;
> > +
> > +	if (!mem_cgroup_is_root(memcg))
> > +		refill_stock(memcg, nr_pages);
> > +}
> > +EXPORT_SYMBOL_GPL(mem_cgroup_cancel_dmabuf);
> > +
> > +/**
> > + * mem_cgroup_uncharge_dmabuf - uncharge a dma-buf from its memcg
> > + * @dmabuf: buffer to uncharge
> > + *
> > + * Reverses a finalized dma-buf charge. Drops the memcg
> > + * reference stored in @dmabuf->memcg and clears the pointer.
> > + * Safe to call when @dmabuf->memcg is %NULL.
> > + */
> > +void mem_cgroup_uncharge_dmabuf(struct dma_buf *dmabuf)
> > +{
> > +	unsigned int nr_pages;
> > +	struct mem_cgroup *memcg =3D dmabuf->memcg;
> > +
> > +	if (!memcg)
> > +		return;
> > +
> > +	nr_pages =3D PAGE_ALIGN(dmabuf->size) >> PAGE_SHIFT;
> > +	mod_memcg_state(memcg, MEMCG_DMABUF, -nr_pages);
> > +	mem_cgroup_cancel_dmabuf(memcg, nr_pages);
> > +	mem_cgroup_put(memcg);
> > +	dmabuf->memcg =3D NULL;
> > +}
>=20
> Instead of keeping a reference on the memcg for the buffer's whole
> lifetime, shouldn't an obj_cgroup be used, which is reparented when the
> memcg goes offline?

Good point. I did not think of it, but after a brief check I think it'd
be the right object to use. I'll switch for the next version.

> Like in Dave's series here:
>=20
> https://lore.kernel.org/all/20260706052330.1110909-1-airlied@gmail.com/

Thanks for the link! I'll use it as reference. I should mention it in the
cover letter too probably, as that series is related (should be safe as
far as it does not opt-in for dma-buf-level charging).

BR,
Albert

>=20
> Thanks,
> Thomas
>=20
>=20
>=20
>=20
> > +
> > =A0static int __init cgroup_memory(char *s)
> > =A0{
> > =A0	char *token;

