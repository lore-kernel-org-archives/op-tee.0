Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD215606A31F
	for <op-tee@archiver.kernel.org>; Thu, 29 Oct 2026 08:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=xFYX0p/Q;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D8F2Lqr9
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1D58745352
	for <op-tee@archiver.kernel.org>; Thu, 29 Oct 2026 08:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1793262178;
	bh=FKOZvmmjZUvuA6XR3/C6Il+XIkOXA8OBuXfRhkNBj6w=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=xFYX0p/QAXeE031smq2LUEdi6BeQxXvw0auDzoZYn5jTvVsnSQ7r1sVlKqe6j4U8M
	 fdiy8XxvNmHGMIWekOCevbd9E1GAzXcUXaJFNbeo6soy6+xERF64eczU3J4/Az9EyR
	 NKOkNOZtjLg1W7I/6jSTg6ncOufpUzBgZFaKaR4b5vO3CXqUBFyWtSQrCw5FD7gIsk
	 yL8iz562VWt227uzfVBe/Th64W5cuKWWC9rnavMWUTDy8nMXsgkMp8af8DHpnR+MEX
	 MnXiYwtQT973fBtTGzeEi9nuguqQ6m48n0JnOMvUiuaKA+i3SHHZn0nJwCjZI/mj2C
	 WacrsJVf51wWg==
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 28BDA444C0
	for <op-tee@lists.trustedfirmware.org>; Thu, 29 Oct 2026 08:22:39 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D8F2Lqr9;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793262158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=94uB/DHgfg1qZqyJ7zAIFQRDjTgpiQBipF8LX3G5vmw=;
	b=D8F2Lqr94iFaFMQhKbDaKj66BtjrQYy5KEPcX7WZfBGnko6VlgTWGZ225w7NJO4DrFUMrj
	0s9ft3cARF1LkXfqiK8Ebyhr+a9638A0XKECjLBNxF4PjQfnmPRa5nftd45GDDBGA4gcTV
	iaYTVo1CCv664sD9j85dEVG4PDTGNWM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-Hi1L5LKTM5mlEMuo6EUh-w-1; Thu, 29 Oct 2026 04:22:36 -0400
X-MC-Unique: Hi1L5LKTM5mlEMuo6EUh-w-1
X-Mimecast-MFC-AGG-ID: Hi1L5LKTM5mlEMuo6EUh-w_1793262156
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a70b42bab0so5054365e9.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 29 Oct 2026 01:22:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793262155; x=1793866955;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=94uB/DHgfg1qZqyJ7zAIFQRDjTgpiQBipF8LX3G5vmw=;
        b=FwE7Oi01d8R3Kx74Aybm9Ljarf6ea8ExSeKyCztwZWwCmGEMV8YFSTLV4oHqYMTx3x
         We93oXqbfBVSx32/hN1q57XVAqa4ojgdaPejC5iimM927jxV8LWP96+ASgj1c7JPFl7X
         Vqya4NEjC8LR1P09oD0iK+9Oz23OuSV0ka/47LcG+Kv20GmmalkrxcOzSStthnY1ljMW
         zCjlOlQA+7tIxtYQ7PrOC4JaLv20krZ0hHID9anrNqlu24pyrrJtYLSqT0MfOjMODyO3
         aaQJ0sZurMB168V3+tyl4MCs+0xBaA0Ni3e+Zb0DnaQPEQBTGv6LNkkScKpGACcB0KfN
         bz3Q==
X-Forwarded-Encrypted: i=1; AKwUvBxGa1cgSjfxPvfxq8q0JTsa3PG0NlCB2nZpcUy63IlJ4OB7jMschtWzw3yP03Z3adRCYZ6ojh0=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYJYMRV0e5+lTiBl8OKjGhi7hNdSR4zqYJz+7zU6zVi3jMCZ5VkN
	itd/+cdTRfuZR9FUDctWzH+Kqh+9Ps7bcfFYe4i47kfnlpLyNB7C+XXeqQMBkL2tGWl2th/rpFg
	QOu4yXV0BJRLaLUN1buKGqim5Fqm/VOURaWHiUFZj+ZxREWxCRyVr7J2RczDpn4/YPADOWJQ=
X-Gm-Gg: AYBFou380jcQyy6ZlSvEzlIPasSZO6NgTJHy2k5ZdIYOKqSDPTdmFFKLFj2lGQLvldf
	0aas5t7kn0D+M3x0lHhHH6f1RKmAcn8teZLPCDmx+bjdhZuSFoMQv2rhuTgRtdh3HHpM8X7oYyd
	BwITrBCIIBfCYLX33lA4rM4fXCGcXHItfYRl2qe2rU8Wl4DRbe3WdLvj1BtpvepOc6gLknAbfrL
	ZapmVH3szwtklNoMEcBlgtSxCwaJ+BaXExCVTdEqoFU7VQHTzj5B6pR+OF0knnnC6jTqMMmJpcx
	yJBhyAEuzPwRt4gIUusgvDpcByHWkpKKx8gp13S6EJnVO21ZFq7g4PlHHC1uke143D3SvtVSqbh
	xlIUAPpBmX2uL9yuaUb/ovCP50b8iceSpaVcTCJMAd5o=
X-Received: by 2002:a05:600c:e48b:b0:4a1:d291:d863 with SMTP id 5b1f17b1804b1-4aa8a1e90demr32611405e9.4.1793262155537;
        Thu, 29 Oct 2026 01:22:35 -0700 (PDT)
X-Received: by 2002:a05:600c:e48b:b0:4a1:d291:d863 with SMTP id 5b1f17b1804b1-4aa8a1e90demr32610685e9.4.1793262154992;
        Thu, 29 Oct 2026 01:22:34 -0700 (PDT)
Received: from localhost ([139.47.30.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ece14a1sm34322198f8f.57.2026.10.29.01.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 01:22:34 -0700 (PDT)
Date: Thu, 29 Oct 2026 09:22:33 +0100
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	"T.J. Mercier" <tjmercier@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
	Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>,
	Jens Wiklander <jenswi@kernel.org>,
	Sumit Garg <sumit.garg@kernel.org>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org, op-tee@lists.trustedfirmware.org,
	echanude@redhat.com, mripard@kernel.org
Subject: Re: [PATCH v3 7/8] dma-buf: transfer memcg charges via
 DMA_BUF_IOCTL_XFER_CHARGE
Message-ID: <auMCSb-punIgJOmA@aesteve-thinkpadp1gen8.rmtes.csb>
References: <20261027-v2_20230123_tjmercier_google_com-v3-0-78d2c4cb8647@redhat.com>
 <20261027-v2_20230123_tjmercier_google_com-v3-7-78d2c4cb8647@redhat.com>
 <d76d8bfe-e955-4e90-9f5f-e3e914c0869c@amd.com>
 <auIeQU0nAnOLdKUB@aesteve-thinkpadp1gen8.rmtes.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <auIeQU0nAnOLdKUB@aesteve-thinkpadp1gen8.rmtes.csb>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IgoLbW4Zzxf0g1K3nBUsM3XIK5lXRLmxglPfL6U7ve4_1793262156
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.70 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:170.10.133.0/24];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[170.10.133.124:from];
	RCVD_IN_DNSWL_LOW(-0.10)[170.10.133.124:from];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[amd.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com,infradead.org,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,kvack.org,lists.trustedfirmware.org,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[39];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	DNSWL_BLOCKED(0.00)[139.47.30.142:received];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[redhat.com:dkim];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:30031, ipnet:170.10.132.0/23, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.70:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 28BDA444C0
X-Spamd-Bar: --
Message-ID-Hash: U3WMFVG56J76EXNUJ4GFWQ3CZI2QUX6H
X-Message-ID-Hash: U3WMFVG56J76EXNUJ4GFWQ3CZI2QUX6H
X-MailFrom: aesteve@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/U3WMFVG56J76EXNUJ4GFWQ3CZI2QUX6H/>
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

On Wed, Oct 28, 2026 at 05:09:37PM +0100, Albert Esteve via OP-TEE wrote:
> On Wed, Oct 28, 2026 at 10:08:19AM +0100, Christian K=F6nig wrote:
> > On 10/27/26 16:02, Albert Esteve wrote:
> > > dma-heap already supports charging a specific cgroup at allocation
> > > time via charge_fd in DMA_HEAP_IOCTL_ALLOC. However, dma-bufs can
> > > originate from any exporter (DRM, V4L2, etc.), and the allocator may
> > > not know the final owner at allocation time.
> > >=20
> > > Add DMA_BUF_IOCTL_XFER_CHARGE to transfer a dma-buf's memcg charge
> > > to a different cgroup after allocation. The target is identified by
> > > charge_fd, which may be a cgroupfd or a pidfd.
> > >=20
> > > The transfer charges the new cgroup before uncharging the old one,
> > > preserving the original charge on failure. An atomic cmpxchg on
> > > dmabuf->memcg prevents races with concurrent transfers.
> > >=20
> > > Not all dma-buf exporters back their buffers with reclaimable system
> > > memory. Some represent device registers, VRAM, or carved-out pools
> > > where size is not a meaningful memory cost. Add a memcg_account flag
> > > to dma_buf_export_info that exporters set when their buffers should
> > > participate in memcg accounting. The xfer ioctl returns -EOPNOTSUPP
> > > for buffers that do not set the flag. Currently only the system heap
> > > sets it, other exporters can opt in as needed.
> > >=20
> > > Usage example:
> > >   int cg_fd =3D open("/sys/fs/cgroup/clients/app1", O_RDONLY | O_DIRE=
CTORY);
> > >=20
> > >   struct dma_buf_transfer_charge xfer =3D {
> > >       .charge_fd =3D cg_fd,
> > >   };
> > >   ioctl(dmabuf_fd, DMA_BUF_IOCTL_XFER_CHARGE, &xfer);
> > >   /* charge now on app1's cgroup */
> > >   close(cg_fd);
> > >=20
> > > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > > ---
> > >  drivers/dma-buf/dma-buf.c           | 43 +++++++++++++++++++++++++++=
++++++++++
> > >  drivers/dma-buf/heaps/system_heap.c |  1 +
> > >  include/linux/dma-buf.h             |  5 +++++
> > >  include/linux/memcontrol.h          |  9 ++++++++
> > >  include/uapi/linux/dma-buf.h        | 26 ++++++++++++++++++++++
> > >  mm/memcontrol.c                     | 41 +++++++++++++++++++++++++++=
++++++++
> > >  6 files changed, 125 insertions(+)
> > >=20
> > > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > > index f31f49ebd0af..07513ecedc10 100644
> > > --- a/drivers/dma-buf/dma-buf.c
> > > +++ b/drivers/dma-buf/dma-buf.c
> > > @@ -540,6 +540,45 @@ static long dma_buf_import_sync_file(struct dma_=
buf *dmabuf,
> > >  }
> > >  #endif
> > > =20
> > > +/* Transfer a dma-buf's memcg charge; see struct dma_buf_transfer_ch=
arge */
> > > +static long dma_buf_xfer_charge(struct dma_buf *dmabuf,
> > > +				const void __user *user_data)
> > > +{
> > > +	struct dma_buf_transfer_charge arg;
> > > +	struct mem_cgroup *memcg;
> > > +	int ret =3D 0;
> > > +
> > > +	if (copy_from_user(&arg, user_data, sizeof(arg)))
> > > +		return -EFAULT;
> > > +
> > > +	if (!IS_ENABLED(CONFIG_MEMCG))
> > > +		return 0;
> > > +
> > > +	if (arg.flags !=3D 0)
> > > +		return -EINVAL;
> > > +
> > > +	if (!dmabuf->memcg_account)
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	memcg =3D mem_cgroup_get_from_fd(arg.charge_fd);
> > > +	if (IS_ERR(memcg))
> > > +		return PTR_ERR(memcg);
> > > +
> > > +	if (dmabuf->memcg =3D=3D memcg)
> > > +		goto skip_transfer;
> > > +
> > > +	if (!mem_cgroup_transfer_dmabuf_charge(dmabuf, memcg)) {
> > > +		ret =3D -ENOMEM;
> > > +		goto skip_transfer;
> > > +	}
> > > +
> > > +	return 0;
> > > +
> > > +skip_transfer:
> > > +	mem_cgroup_put(memcg);
> > > +	return ret;
> > > +}
> > > +
> > >  static long dma_buf_ioctl(struct file *file,
> > >  			  unsigned int cmd, unsigned long arg)
> > >  {
> > > @@ -590,6 +629,9 @@ static long dma_buf_ioctl(struct file *file,
> > >  		return dma_buf_import_sync_file(dmabuf, (const void __user *)arg);
> > >  #endif
> > > =20
> > > +	case DMA_BUF_IOCTL_XFER_CHARGE:
> > > +		return dma_buf_xfer_charge(dmabuf, (const void __user *)arg);
> > > +
> > >  	default:
> > >  		return -ENOTTY;
> > >  	}
> > > @@ -750,6 +792,7 @@ struct dma_buf *dma_buf_export(const struct dma_b=
uf_export_info *exp_info)
> > >  	dmabuf->size =3D exp_info->size;
> > >  	dmabuf->exp_name =3D exp_info->exp_name;
> > >  	dmabuf->owner =3D exp_info->owner;
> > > +	dmabuf->memcg_account =3D exp_info->memcg_account;
> >=20
> > The initial charging should probably be done here as well.
> >=20
> > This way DMA-buf heaps only needs to pass in the charge_fd and we can r=
e-use the functionality for other DMA-buf exporters as well.
>=20
> The problem with doing the charge here is that it happens too late.
> That is the reasoning for this proposal to move all the charging logic
> into heap allocators before pages are allocated.
>=20
> What we could do is fill the dmabuf->memcg field when the flag is set
> (i.e., committing into the dmabuf in the patch semantics). But for that
> we'd need adding the memcg we want to charge it to into exp_info in
> order to support charging to cgroups other than the allocator's (for
> the common case would be simpler as we can just look at current).
> Maybe that's what you meant?

Actually if I do this we can remove the memcg_account flag and just
uses exp_info->memcg as both the memcg to set *and* the flag when
it is !=3D NULL. Exporters that set the memcg info are implicitly
flagging the dmabuf as chargeable (and transfereable).

The only thing is that mod_memcg_state() still needs nr_pages
and we cannot use size as that varies from one exporter to another as
you explained before. So that can be left for the exporter to call. WDYT?

>=20
> >=20
> > >  	spin_lock_init(&dmabuf->name_lock);
> > >  	init_waitqueue_head(&dmabuf->poll);
> > >  	dmabuf->cb_in.poll =3D dmabuf->cb_out.poll =3D &dmabuf->poll;
> > > diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/he=
aps/system_heap.c
> > > index adeea8cd328b..a764167167ba 100644
> > > --- a/drivers/dma-buf/heaps/system_heap.c
> > > +++ b/drivers/dma-buf/heaps/system_heap.c
> > > @@ -479,6 +479,7 @@ static struct dma_buf *system_heap_allocate(struc=
t dma_heap *heap,
> > >  	exp_info.size =3D buffer->len;
> > >  	exp_info.flags =3D fd_flags;
> > >  	exp_info.priv =3D buffer;
> > > +	exp_info.memcg_account =3D true;
> > >  	dmabuf =3D dma_buf_export(&exp_info);
> > >  	if (IS_ERR(dmabuf)) {
> > >  		ret =3D PTR_ERR(dmabuf);
> > > diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> > > index 23ec0ff23fba..ac0ec88cab93 100644
> > > --- a/include/linux/dma-buf.h
> > > +++ b/include/linux/dma-buf.h
> > > @@ -433,6 +433,9 @@ struct dma_buf {
> > > =20
> > >  	/** @memcg: the cgroup to which this buffer is currently attributed=
 */
> > >  	struct mem_cgroup *memcg;
> > > +
> > > +	/** @memcg_account: account buffer memory to cgroup */
> > > +	bool memcg_account;
> > >  };
> > > =20
> > >  /**
> > > @@ -505,6 +508,7 @@ struct dma_buf_attachment {
> > >   * @flags:	mode flags for the file
> > >   * @resv:	reservation-object, NULL to allocate default one
> > >   * @priv:	Attach private data of allocator to this buffer
> > > + * @memcg_account:	account buffer memory to cgroup
> > >   *
> > >   * This structure holds the information required to export the buffe=
r. Used
> > >   * with dma_buf_export() only.
> > > @@ -517,6 +521,7 @@ struct dma_buf_export_info {
> > >  	int flags;
> > >  	struct dma_resv *resv;
> > >  	void *priv;
> > > +	bool memcg_account;
> > >  };
> > > =20
> > >  /**
> > > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > > index 6b30baa79fa9..36fddafbef4e 100644
> > > --- a/include/linux/memcontrol.h
> > > +++ b/include/linux/memcontrol.h
> > > @@ -679,6 +679,9 @@ bool mem_cgroup_reserve_dmabuf(struct mem_cgroup =
*memcg, gfp_t gfp,
> > >  void mem_cgroup_commit_dmabuf(struct dma_buf *dmabuf, struct mem_cgr=
oup *memcg,
> > >  			      unsigned int nr_pages);
> > > =20
> > > +bool mem_cgroup_transfer_dmabuf_charge(struct dma_buf *dmabuf,
> > > +				       struct mem_cgroup *new_memcg);
> > > +
> > >  void __mem_cgroup_uncharge(struct folio *folio);
> > > =20
> > >  /**
> > > @@ -1206,6 +1209,12 @@ static inline void mem_cgroup_cancel_dmabuf(st=
ruct mem_cgroup *memcg,
> > >  {
> > >  }
> > > =20
> > > +static inline bool mem_cgroup_transfer_dmabuf_charge(struct dma_buf =
*dmabuf,
> > > +						     struct mem_cgroup *new_memcg)
> > > +{
> > > +	return true;
> > > +}
> > > +
> > >  static inline void mem_cgroup_uncharge(struct folio *folio)
> > >  {
> > >  }
> > > diff --git a/include/uapi/linux/dma-buf.h b/include/uapi/linux/dma-bu=
f.h
> > > index e827c9d20c5d..ea957f4b1d38 100644
> > > --- a/include/uapi/linux/dma-buf.h
> > > +++ b/include/uapi/linux/dma-buf.h
> > > @@ -168,6 +168,31 @@ struct dma_buf_import_sync_file {
> > >  	__s32 fd;
> > >  };
> > > =20
> > > +/**
> > > + * struct dma_buf_transfer_charge - Transfer a dma-buf's memcg charge
> > > + *
> > > + * Any holder of a dma-buf file descriptor can perform a
> > > + * DMA_BUF_IOCTL_XFER_CHARGE to attribute the buffer's memory
> > > + * cost to a specific cgroup, or move it from one cgroup to
> > > + * another.  The ioctl charges the new cgroup before uncharging
> > > + * the old one atomically.  On failure the original charge is
> > > + * preserved.  If the buffer has no existing charge, a new
> > > + * charge is established.
> > > + */
> > > +struct dma_buf_transfer_charge {
> > > +	/** @flags: Reserved, must be zero */
> > > +	__u32 flags; /* unused for now */
> > > +	/**
> > > +	 * @charge_fd: File descriptor identifying the target cgroup.
> > > +	 *
> > > +	 * May be either a pidfd, in which case the charge moves to the
> > > +	 * memory cgroup of the referenced process, or a cgroupfd obtained
> > > +	 * by opening a cgroup v2 directory, in which case the charge moves
> > > +	 * directly to that cgroup's memory controller.
> > > +	 */
> > > +	__u32 charge_fd;
> > > +};
> > > +
> > >  #define DMA_BUF_BASE		'b'
> > >  #define DMA_BUF_IOCTL_SYNC	_IOW(DMA_BUF_BASE, 0, struct dma_buf_sync)
> > > =20
> > > @@ -179,5 +204,6 @@ struct dma_buf_import_sync_file {
> > >  #define DMA_BUF_SET_NAME_B	_IOW(DMA_BUF_BASE, 1, __u64)
> > >  #define DMA_BUF_IOCTL_EXPORT_SYNC_FILE	_IOWR(DMA_BUF_BASE, 2, struct=
 dma_buf_export_sync_file)
> > >  #define DMA_BUF_IOCTL_IMPORT_SYNC_FILE	_IOW(DMA_BUF_BASE, 3, struct =
dma_buf_import_sync_file)
> > > +#define DMA_BUF_IOCTL_XFER_CHARGE	_IOW(DMA_BUF_BASE, 4, struct dma_b=
uf_transfer_charge)
> > > =20
> > >  #endif
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index 7b841b905759..3adc84fe6668 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -5786,6 +5786,47 @@ void mem_cgroup_cancel_dmabuf(struct mem_cgrou=
p *memcg, unsigned int nr_pages)
> > >  		refill_stock(memcg, nr_pages);
> > >  }
> > > =20
> > > +/**
> > > + * mem_cgroup_transfer_dmabuf_charge - move a dma-buf charge
> > > + * @dmabuf: buffer to transfer charge
> > > + * @new_memcg: target memcg; caller must hold a reference
> > > + *
> > > + * Transfers the charge for @dmabuf to @new_memcg and, on
> > > + * success, stores @new_memcg in @dmabuf->memcg.
> > > + * Returns %true on success, %false if the charge against @new_memcg
> > > + * failed or a concurrent transfer raced on @dmabuf->memcg.
> > > + * On failure the caller retains its reference to @new_memcg.
> > > + */
> > > +bool mem_cgroup_transfer_dmabuf_charge(struct dma_buf *dmabuf,
> > > +				       struct mem_cgroup *new_memcg)
> >=20
> > I would make that more generic instead of dmabuf specific. E.g. somethi=
ng like this:
> >=20
> > bool mem_cgroup_transfer_charge(struct struct mem_cgroup **ptr_memcg, s=
truct mem_cgroup *new_memcg, enum memcg_stat_item item, unsigned int nr_pag=
es)
>=20
> Ah yes, I like this generalization. And the implementation remains
> mostly the same. Thanks!
>=20
> >=20
> > > +{
> > > +	struct mem_cgroup *old_memcg =3D READ_ONCE(dmabuf->memcg);
> >=20
> > > +	unsigned int nr_pages =3D PAGE_ALIGN(dmabuf->size) >> PAGE_SHIFT;
> >=20
> > This way we can also document in the DMA-buf caller that this conversat=
ion must be ok when memcg_account is true.
> >=20
> > Regards,
> > Christian.
> >=20
> > > +
> > > +	if (mem_cgroup_disabled())
> > > +		return true;
> > > +
> > > +	if (!mem_cgroup_reserve_dmabuf(new_memcg, GFP_KERNEL, nr_pages))
> > > +		return false;
> > > +
> > > +	mod_memcg_state(new_memcg, MEMCG_DMABUF, nr_pages);
> > > +
> > > +	if (cmpxchg(&dmabuf->memcg, old_memcg, new_memcg) !=3D old_memcg) {
> > > +		mod_memcg_state(new_memcg, MEMCG_DMABUF, -nr_pages);
> > > +		mem_cgroup_cancel_dmabuf(new_memcg, nr_pages);
> > > +		return false;
> > > +	}
> > > +
> > > +	if (old_memcg) {
> > > +		/* Uncharge old cgroup */
> > > +		mod_memcg_state(old_memcg, MEMCG_DMABUF, -nr_pages);
> > > +		mem_cgroup_cancel_dmabuf(old_memcg, nr_pages);
> > > +		mem_cgroup_put(old_memcg);
> > > +	}
> > > +
> > > +	return true;
> > > +}
> > > +
> > >  /**
> > >   * mem_cgroup_uncharge_dmabuf - uncharge a dma-buf from its memcg
> > >   * @dmabuf: buffer to uncharge
> > >=20
> >=20
>=20

