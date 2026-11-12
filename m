Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EB1606A321
	for <op-tee@archiver.kernel.org>; Thu, 12 Nov 2026 10:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=sotjjd0L;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hmcRIDKB
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E623D45331
	for <op-tee@archiver.kernel.org>; Thu, 12 Nov 2026 10:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1794477761;
	bh=e7IEv2G7emYEug7Jqpblbud2ArEy5mxjSSITehsHnVE=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=sotjjd0LMWzAnvoEWzznYxQx886Ppd4VsWWa6lYP8Z6+m3/5Jw/vrlwmnk9AhLW+2
	 LJday79GfCDJqja1WcYYMRwtwhf8EdY9/KrusjlY3i/N+RYvOv3tBnb1JK486nSFRr
	 LyZ4hamoGHNn1QxTIRMzZOcux2q6lt+YzlF3i3CSzXJqLnxS2aXv6kekKrXWgUppYr
	 2NhFYmb5qapBOMhzqXSLt6zLEw8p51UVNYcT4qhX2XWMRnVREgx5z7jVj3tXQ+BTpd
	 gp9hcMG+v2lwhBISWTzZ+8IF09Z7zPDZ0NeQLVn0GA8FS7QR2J0VKi2z9meEhMJ3sr
	 F99IXpEWJJR+Q==
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 985A4409EA
	for <op-tee@lists.trustedfirmware.org>; Thu, 12 Nov 2026 10:02:22 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hmcRIDKB;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794477742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ku69CJLRXzwwOsA6G2xqy4VdyNyzfbNSiJBSoeXd84w=;
	b=hmcRIDKBllgHwonOe6vk8YCFpRXw4D6YjOVIzVlb1EgfdwTPtU8JPYejtx5DSltEFfA1vz
	yGh0861/6D9KT/pY60gw3bDvD+g9wpsWULSTrsnaWrKcRSASUFo1VJICm/mVNGWVLI0xMZ
	AfBKLqEmg+mT3bki9V8nBfgmzldoHIM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-cB79Y0ysMVqgBJfGvj-3Xg-1; Thu, 12 Nov 2026 05:02:20 -0500
X-MC-Unique: cB79Y0ysMVqgBJfGvj-3Xg-1
X-Mimecast-MFC-AGG-ID: cB79Y0ysMVqgBJfGvj-3Xg_1794477739
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4b764ffc014so37579215e9.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 12 Nov 2026 02:02:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794477739; x=1795082539;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ku69CJLRXzwwOsA6G2xqy4VdyNyzfbNSiJBSoeXd84w=;
        b=SsZ6QZTSYNO3WmZWJYXmFG8hAhDq0MWHHu/zFtfnaZKEKDC3PoqHMZaRbSZYeFWD74
         a2dgkANbak/QxqEzF/o9IzoGlA7g62aOh8xGNPv2zKBS1BB/ktr9jMz7+DfVKddNGbtC
         KC5tzlvI5jWdy9h9QbbzkL90Dhuq1s55/P+XxYFHtphWMqek1DsKwd3Mpc0ranhARRkO
         Kf3mEcq+0ngU+kkOsXttt+1sXYhNCpX9PQ6Sm7jgtozi4F3yYMhc8O5V87y7sr7WQejN
         fVqD3vaJcaGM1yZ7nQyzZBFA5M2/8F/zlPNzohEyNdcZj0hfpn+RjnkpNB3TQBfsgAiu
         HiHw==
X-Forwarded-Encrypted: i=1; AL+hErFROTi6DM20nSJ+S/VGmSBObIkBvj8GxlZ3UW/GO1vGjup18bUtTLI5VNONPR/kOtBDxwoXfZw=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z8kl/XZYL73IHloldzfWSi9RFqyIeNOFA6jD2KaXwTSvAMvj8dO
	W557DVUF7Kl2vz+3efIdjQei2i0Ong7jWfwOBRljC/tyI97ZIn4wmAt4C109+opR3H0iLo+MmcC
	oA8HDzcaEnI0AZN2kDWgS5P0gYFBlJQ+N08Wqozvuh5xE1bp4nHD7/BeRw87k8j5WLKtqLec=
X-Gm-Gg: AYBFou0MG8pb0KnCA9sI1sesIL1or7uDqDW+o+P3/fVZynS1y3yVuc3JCXf3hJmxRNd
	OF/H/CPM4aZ01x/E/e4jaVk78u4yBpk08+lTGp5b1aRIyJ0bLG/Xqv1fSoXa4QJkf88ADVgK3gI
	MU8svWNt95a+SBFjCJ5wNeHEd6zz0927fOOeySGkqXibFYcP9JjccSmW/xzuAESmBnq3CHHHVXp
	0k6R/Eh9Jr/K9epjlcCsmrUy4UOqribEzzjhw61lqVYxu17Ruz1C5fPtdm0Dwk/wJzyIEYlTzie
	wMCFQprN1jijASpFZ6/xtGidjtsOeRawR9+SZa01eS7NCGF8F0eEBZEQRwVJxbglkT+TLXsYshM
	Kx+WPi302/xwNIYkBnv0mDX8CfmZMFjl0cR00mF9oBdk=
X-Received: by 2002:a05:600c:4f84:b0:4a1:e92b:ae4a with SMTP id 5b1f17b1804b1-4ba093b9a3cmr86690665e9.21.1794477739190;
        Thu, 12 Nov 2026 02:02:19 -0800 (PST)
X-Received: by 2002:a05:600c:4f84:b0:4a1:e92b:ae4a with SMTP id 5b1f17b1804b1-4ba093b9a3cmr86689595e9.21.1794477738330;
        Thu, 12 Nov 2026 02:02:18 -0800 (PST)
Received: from localhost ([139.47.30.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983284c99bsm15755230f8f.7.2026.11.12.02.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 02:02:17 -0800 (PST)
Date: Thu, 12 Nov 2026 11:02:16 +0100
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [Linaro-mm-sig] [PATCH v4 3/8] dma-buf: transfer memcg charges
 via DMA_BUF_IOCTL_XFER_CHARGE
Message-ID: <avWOqDLI1xmfBqn2@aesteve-thinkpadp1gen8.rmtes.csb>
References: <20261104-v2_20230123_tjmercier_google_com-v4-0-1819a017000b@redhat.com>
 <20261104-v2_20230123_tjmercier_google_com-v4-3-1819a017000b@redhat.com>
 <b77aecccce2dcf9bc42b1a6fccc62d06ccad4741.camel@linux.intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b77aecccce2dcf9bc42b1a6fccc62d06ccad4741.camel@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UGRp6SrbEedG7JRvm3b0fVzBiXPn7WFOZMooQ1oDr4U_1794477739
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.70 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[redhat.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:170.10.133.0/24];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	RWL_MAILSPIKE_GOOD(-0.10)[170.10.133.124:from];
	RCVD_IN_DNSWL_LOW(-0.10)[170.10.133.124:from];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[38];
	ARC_NA(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,amd.com,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com,infradead.org,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,kvack.org,lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:30031, ipnet:170.10.132.0/23, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.72:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 985A4409EA
X-Spamd-Bar: ----
Message-ID-Hash: ALFBYBOVR5MFV2TUEOWQ32MSV66OYDFH
X-Message-ID-Hash: ALFBYBOVR5MFV2TUEOWQ32MSV66OYDFH
X-MailFrom: aesteve@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Sumit Semwal <sumit.semwal@linaro.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>, Jens Wiklander
  <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ALFBYBOVR5MFV2TUEOWQ32MSV66OYDFH/>
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

On Thu, Nov 12, 2026 at 08:46:02AM +0100, Thomas Hellstr=F6m wrote:
> On Wed, 2026-11-04 at 12:09 +0100, Albert Esteve wrote:
> > dma-heap already supports charging a specific cgroup at allocation
> > time via charge_fd in DMA_HEAP_IOCTL_ALLOC. However, dma-bufs can
> > originate from any exporter (DRM, V4L2, etc.), and the allocator may
> > not know the final owner at allocation time.
> >=20
> > Add DMA_BUF_IOCTL_XFER_CHARGE to transfer a dma-buf's memcg charge
> > to a different cgroup after allocation. The target is identified by
> > charge_fd, which may be a cgroupfd or a pidfd.
> >=20
> > The transfer charges the new cgroup before uncharging the old one,
> > preserving the original charge on failure. Concurrent transfers are
> > serialized by the dma-buf reservation lock, so lockdep covers the
> > locking order of the charge path early. The transfer implementation
> > is generic (mem_cgroup_transfer_charge) and not dma-buf specific, so
> > it can be reused by other subsystems.
> >=20
> > Not all dma-buf exporters back their buffers with reclaimable system
> > memory. Some represent device registers, VRAM, or carved-out pools
> > where size is not a meaningful memory cost. The xfer ioctl returns
> > -EOPNOTSUPP for buffers whose memcg is not set. Exporters opt in by
> > passing a memcg through dma_buf_export_info at export time. Currently
> > only the system heap sets it, other exporters can opt in as needed.
> >=20
> > Usage example:
> > =A0 int cg_fd =3D open("/sys/fs/cgroup/clients/app1", O_RDONLY |
> > O_DIRECTORY);
> >=20
> > =A0 struct dma_buf_transfer_charge xfer =3D {
> > =A0=A0=A0=A0=A0 .charge_fd =3D cg_fd,
> > =A0 };
> > =A0 ioctl(dmabuf_fd, DMA_BUF_IOCTL_XFER_CHARGE, &xfer);
> > =A0 /* charge now on app1's cgroup */
> > =A0 close(cg_fd);
> >=20
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> > =A0drivers/dma-buf/dma-buf.c=A0=A0=A0 | 42
> > ++++++++++++++++++++++++++++++++++++++++++
> > =A0include/linux/dma-buf.h=A0=A0=A0=A0=A0 |=A0 3 ++-
> > =A0include/linux/memcontrol.h=A0=A0 | 13 +++++++++++++
> > =A0include/uapi/linux/dma-buf.h | 26 ++++++++++++++++++++++++++
> > =A0mm/memcontrol.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 42
> > ++++++++++++++++++++++++++++++++++++++++++
> > =A05 files changed, 125 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index 837666273550..3bd26fbb1109 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -540,6 +540,45 @@ static long dma_buf_import_sync_file(struct
> > dma_buf *dmabuf,
> > =A0}
> > =A0#endif
> > =A0
> > +/* Transfer a dma-buf's memcg charge; see struct
> > dma_buf_transfer_charge */
> > +static long dma_buf_xfer_charge(struct dma_buf *dmabuf,
> > +				const void __user *user_data)
> > +{
> > +	struct dma_buf_transfer_charge arg;
> > +	struct mem_cgroup *memcg;
> > +	unsigned int nr_pages =3D PAGE_ALIGN(dmabuf->size) >>
> > PAGE_SHIFT;
> > +	int ret =3D 0;
> > +
> > +	if (copy_from_user(&arg, user_data, sizeof(arg)))
> > +		return -EFAULT;
> > +
> > +	if (!IS_ENABLED(CONFIG_MEMCG))
> > +		return 0;
> > +
> > +	if (arg.flags !=3D 0)
> > +		return -EINVAL;
> > +
> > +	memcg =3D mem_cgroup_get_from_fd(arg.charge_fd);
> > +	if (IS_ERR(memcg))
> > +		return PTR_ERR(memcg);
> > +
> > +	dma_resv_lock(dmabuf->resv, NULL);
> > +
> > +	if (!dmabuf->memcg) {
> > +		ret =3D -EOPNOTSUPP;
> > +		goto out;
> > +	}
> > +
> > +	if (dmabuf->memcg !=3D memcg &&
> > +	=A0=A0=A0 !mem_cgroup_transfer_charge(&dmabuf->memcg, memcg,
> > MEMCG_DMABUF, nr_pages))
> > +		ret =3D -ENOMEM;
> > +
> > +out:
> > +	dma_resv_unlock(dmabuf->resv);
> > +	mem_cgroup_put(memcg);
> > +	return ret;
> > +}
> > +
> > =A0static long dma_buf_ioctl(struct file *file,
> > =A0			=A0 unsigned int cmd, unsigned long arg)
> > =A0{
> > @@ -590,6 +629,9 @@ static long dma_buf_ioctl(struct file *file,
> > =A0		return dma_buf_import_sync_file(dmabuf, (const void
> > __user *)arg);
> > =A0#endif
> > =A0
> > +	case DMA_BUF_IOCTL_XFER_CHARGE:
> > +		return dma_buf_xfer_charge(dmabuf, (const void
> > __user *)arg);
> > +
> > =A0	default:
> > =A0		return -ENOTTY;
> > =A0	}
> > diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> > index 85dd747c9b36..b01149d26b44 100644
> > --- a/include/linux/dma-buf.h
> > +++ b/include/linux/dma-buf.h
> > @@ -507,7 +507,8 @@ struct dma_buf_attachment {
> > =A0 * @priv:	Attach private data of allocator to this buffer
> > =A0 * @memcg:	memcg to charge for this buffer's memory. Set only
> > for
> > =A0 *		buffers backed by system memory where @size reflects
> > the
> > - *		actual allocation in bytes.
> > + *		actual allocation in bytes. Enables charge transfer
> > via
> > + *		DMA_BUF_IOCTL_XFER_CHARGE.
> > =A0 *
> > =A0 * This structure holds the information required to export the
> > buffer. Used
> > =A0 * with dma_buf_export() only.
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index f8ec751b7d7b..af02d9777fe9 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -676,6 +676,11 @@ struct mem_cgroup *mem_cgroup_get_from_fd(int
> > fd);
> > =A0bool mem_cgroup_reserve_dmabuf(struct mem_cgroup *memcg, gfp_t gfp,
> > =A0			=A0=A0=A0=A0=A0=A0 unsigned int nr_pages);
> > =A0
> > +bool mem_cgroup_transfer_charge(struct mem_cgroup **ptr_memcg,
> > +				struct mem_cgroup *new_memcg,
> > +				enum memcg_stat_item item,
> > +				unsigned int nr_pages);
> > +
> > =A0void __mem_cgroup_uncharge(struct folio *folio);
> > =A0
> > =A0/**
> > @@ -1197,6 +1202,14 @@ static inline void
> > mem_cgroup_cancel_dmabuf(struct mem_cgroup *memcg,
> > =A0{
> > =A0}
> > =A0
> > +static inline bool mem_cgroup_transfer_charge(struct mem_cgroup
> > **ptr_memcg,
> > +					=A0=A0=A0=A0=A0 struct mem_cgroup
> > *new_memcg,
> > +					=A0=A0=A0=A0=A0 enum memcg_stat_item
> > item,
> > +					=A0=A0=A0=A0=A0 unsigned int nr_pages)
> > +{
> > +	return true;
> > +}
> > +
> > =A0static inline void mem_cgroup_uncharge(struct folio *folio)
> > =A0{
> > =A0}
> > diff --git a/include/uapi/linux/dma-buf.h b/include/uapi/linux/dma-
> > buf.h
> > index e827c9d20c5d..0aaf2e7d593b 100644
> > --- a/include/uapi/linux/dma-buf.h
> > +++ b/include/uapi/linux/dma-buf.h
> > @@ -168,6 +168,31 @@ struct dma_buf_import_sync_file {
> > =A0	__s32 fd;
> > =A0};
> > =A0
> > +/**
> > + * struct dma_buf_transfer_charge - Transfer a dma-buf's memcg
> > charge
> > + *
> > + * Any holder of a dma-buf file descriptor can perform a
> > + * DMA_BUF_IOCTL_XFER_CHARGE to attribute the buffer's memory
> > + * cost to a specific cgroup, or move it from one cgroup to
> > + * another.=A0 The ioctl charges the new cgroup before uncharging
> > + * the old one atomically.=A0 On failure the original charge is
> > + * preserved.=A0 If the buffer has no existing memcg charge, the
> > + * ioctl returns -EOPNOTSUPP.
> > + */
> > +struct dma_buf_transfer_charge {
> > +	/** @flags: Reserved, must be zero */
> > +	__u32 flags; /* unused for now */
> > +	/**
> > +	 * @charge_fd: File descriptor identifying the target
> > cgroup.
> > +	 *
> > +	 * May be either a pidfd, in which case the charge moves to
> > the
> > +	 * memory cgroup of the referenced process, or a cgroupfd
> > obtained
> > +	 * by opening a cgroup v2 directory, in which case the
> > charge moves
> > +	 * directly to that cgroup's memory controller.
> > +	 */
> > +	__u32 charge_fd;
> > +};
> > +
> > =A0#define DMA_BUF_BASE		'b'
> > =A0#define DMA_BUF_IOCTL_SYNC	_IOW(DMA_BUF_BASE, 0, struct
> > dma_buf_sync)
> > =A0
> > @@ -179,5 +204,6 @@ struct dma_buf_import_sync_file {
> > =A0#define DMA_BUF_SET_NAME_B	_IOW(DMA_BUF_BASE, 1, __u64)
> > =A0#define DMA_BUF_IOCTL_EXPORT_SYNC_FILE	_IOWR(DMA_BUF_BASE, 2,
> > struct dma_buf_export_sync_file)
> > =A0#define DMA_BUF_IOCTL_IMPORT_SYNC_FILE	_IOW(DMA_BUF_BASE, 3, struct
> > dma_buf_import_sync_file)
> > +#define DMA_BUF_IOCTL_XFER_CHARGE	_IOW(DMA_BUF_BASE, 4, struct
> > dma_buf_transfer_charge)
> > =A0
> > =A0#endif
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 17fdefc56b97..3e717b5663c8 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -5752,6 +5752,48 @@ void mem_cgroup_cancel_dmabuf(struct
> > mem_cgroup *memcg, unsigned int nr_pages)
> > =A0}
> > =A0EXPORT_SYMBOL_GPL(mem_cgroup_cancel_dmabuf);
> > =A0
> > +/**
> > + * mem_cgroup_transfer_charge - move a charge between memcgs
> > + * @ptr_memcg: pointer to the memcg to transfer from
> > + * @new_memcg: target memcg; caller must hold a reference
> > + * @item: stat counter to adjust
> > + * @nr_pages: number of pages to transfer
> > + *
> > + * Transfers @nr_pages of charge from *@ptr_memcg to @new_memcg and,
> > on
> > + * success, stores @new_memcg in *@ptr_memcg.
> > + *
> > + * Updates to *@ptr_memcg must be serialized by the caller.
> > + * Returns %true on success, %false if the charge against @new_memcg
> > + * failed.
> > + */
> > +bool mem_cgroup_transfer_charge(struct mem_cgroup **ptr_memcg,
> > +				struct mem_cgroup *new_memcg,
> > +				enum memcg_stat_item item,
> > +				unsigned int nr_pages)
> > +{
> > +	struct mem_cgroup *old_memcg =3D *ptr_memcg;
> > +
> > +	if (!new_memcg || mem_cgroup_disabled())
> > +		return true;
> > +
> > +	if (try_charge(new_memcg, GFP_KERNEL, nr_pages))
> > +		return false;
> > +
> > +	mod_memcg_state(new_memcg, item, nr_pages);
> > +	css_get(&new_memcg->css);
> > +	*ptr_memcg =3D new_memcg;
> > +
> > +	if (old_memcg) {
> > +		/* Uncharge old cgroup */
> > +		mod_memcg_state(old_memcg, item, -nr_pages);
> > +		if (!mem_cgroup_is_root(old_memcg))
> > +			refill_stock(old_memcg, nr_pages);
> > +		mem_cgroup_put(old_memcg);
> > +	}
> > +
> > +	return true;
> > +}
>=20
> =20
> This has the same lifetime issue as patch 1. After a transfer, the
> buffer pins new_memcg until it is released, and with cross-process
> transfers the target may be removed before the
> buffer is. Since this helper is meant to be reused by other subsystems,
> would it be better to have it take and store an obj_cgroup from the
> start?

Agreed. I will switch to obj_cgroup through the series.

>=20
> Thanks,
> Thomas
>=20
>=20
> > +
> > =A0/**
> > =A0 * mem_cgroup_uncharge_dmabuf - uncharge a dma-buf from its memcg
> > =A0 * @dmabuf: buffer to uncharge

