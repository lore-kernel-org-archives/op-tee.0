Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3512A606A324
	for <op-tee@archiver.kernel.org>; Mon,  2 Nov 2026 09:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=NEIWWp84;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gbmYtM79
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8904845416
	for <op-tee@archiver.kernel.org>; Mon,  2 Nov 2026 09:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1793612781;
	bh=UIlqZbK2UxB11BoFKWt5ua7995KHpPIIGWfupF+9jEM=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=NEIWWp84FFfwvuGVHb2CD4V8/5o2z12xO7DimvOmTGhZJkppdM1mq/wcuu9ptehZP
	 1Sx4ttyQD9FF+4wlKX3gQvjqPPP3SOKxatux5SOPBVkrIlNshmkHSPZFg2s7dmpGaD
	 X51hICEO63zS/ycS6XdzHChv2848Eh/QBNdqarzZAJXhwb2H7MpSGugmCmIDLITW8h
	 T64kjmawjWiUOctCFg1aTmA0ThBLtRipjYpuFDl2o6CPIXCnWGO1QNnq3xy/q2oLzV
	 ZmP0IjgIYkxdvQgz9dbOzTdZ45qZ8oq4F1Vd5XhL8JPeMcraKrjdAwde7X4CNVsxPe
	 aB5U+T42m4NNw==
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 585A544243
	for <op-tee@lists.trustedfirmware.org>; Mon,  2 Nov 2026 09:46:03 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gbmYtM79;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793612762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DGADPf1s/Hceud+YrgbPtgRU1aDRhCryTUpted2/1fo=;
	b=gbmYtM79mPDFuJvTzarxFVxPxf2Izdk4tCahWrpG8Vsb35N1WotJn9JxeWncZqol7sGqeb
	uKUfs9cjFdk+3YHkdTVCBtOzMPsSa6gfXRock446xP8dC21WaWxpsgynzfU13TrfWgL0Kg
	xs5dUjsiRnpt1TOocLMr+5Ic+BKKW4g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-Gj-GhVXbO8y4tQI_kqh9WA-1; Mon, 02 Nov 2026 04:46:01 -0500
X-MC-Unique: Gj-GhVXbO8y4tQI_kqh9WA-1
X-Mimecast-MFC-AGG-ID: Gj-GhVXbO8y4tQI_kqh9WA_1793612760
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a17741243eso21620865e9.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 02 Nov 2026 01:46:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793612760; x=1794217560;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DGADPf1s/Hceud+YrgbPtgRU1aDRhCryTUpted2/1fo=;
        b=E8V/Ka0spl3cJrEMV2dYeWBYxgO4CJfZL7F3ZgUJ115mNObwoo+PRrLbmAtIbeeJQl
         EK5UpWpZLlUiLDsVWwnNF3iAKsghm1IthjhIqYC7X8kw7py++hEHpyaruLOY6uyEk1P8
         ykOqdFWQfAXcqJJ/zqkTMZHgmNO1Af2FiDzlUvDgMNKcQJKA97RBd1i+vOt1j+s0OPtz
         cz69zfc+9M7xW1GyGxl4koECAV9DcxhBS2PUiOLRRvghCeBGjwe3PV5wfScFJcuEwvED
         +y/2SEo528wQFc+2wYmWgM4GHRJdfkpu6f0fJWNwug5p4U0+l6nMt+6QLPU551HAzPIq
         mP1g==
X-Forwarded-Encrypted: i=1; AKwUvBzMi2Omd/AhXbWQIaNMtRjLZWsgcfc+yC+GcBcZO666Qa9ZVXZ73MnMWe+h/1xJ2dd/NcNM6S8=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYJOiPl9Qb2MnPMV4KbKeuPXRkH1oS6Sa4byHrSSIQjp+sJRq2h2
	qEOddhMAqvWcOJiosPuxKO3vjz+hcDvPqhT+AkeRO1ylwsPZVtFGVlqNRr7BsfLs5eIOZOhdav0
	mSaZFjeVbhwDaptiuGnen2cDuTrW/Ky+bi6x08Z95qCiDKepwtURmCu5q6RPQBfy3wi/ulZ4=
X-Gm-Gg: AYBFou0O6lU/pgdE52LZyFIJ0KKZANrP/D9q89UOIJIH+lIAMVJJo6saR16fk7j9J+7
	gJzSeYWY6AYSvWgTMo/sC8M4yWVVQBR7qDvjRRVMBZdNEGk96j75Ohjk/arj0zPcF3i9kuMvmti
	BubRsJbybgdVXlJFRv/IWok1BW9fnQt0e55xs3fJ3/XzHYEGiM7Je2ye9fZtzpDqSo7HlAxEp2g
	helkuQyc+QPH4MrvJb6xnqHXqY+b/ata0beOuKjgs+ejlXEb9uftPZ0EUIgAh0/DHwye1t+F3zm
	up5d40GY4BTBZYWzd7LIGlwZ4WOrXBEMNdblppbV/BdJlVB3m1lFWaIPbr9IhdIIHKOPSS+h2PO
	iP6o8SOHV1dX2Jdyn70Z9A4mbmOJ2Krb27Vm2KaJm7g==
X-Received: by 2002:a05:600c:3b88:b0:4a1:cf60:dcc3 with SMTP id 5b1f17b1804b1-4ac187a6ffcmr228127005e9.29.1793612760246;
        Mon, 02 Nov 2026 01:46:00 -0800 (PST)
X-Received: by 2002:a05:600c:3b88:b0:4a1:cf60:dcc3 with SMTP id 5b1f17b1804b1-4ac187a6ffcmr228126125e9.29.1793612759656;
        Mon, 02 Nov 2026 01:45:59 -0800 (PST)
Received: from localhost ([139.47.30.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e77409821sm15084520f8f.0.2026.11.02.01.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 01:45:58 -0800 (PST)
Date: Mon, 2 Nov 2026 10:45:57 +0100
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v3 7/8] dma-buf: transfer memcg charges via
 DMA_BUF_IOCTL_XFER_CHARGE
Message-ID: <auhb1W6CRi0vo0Tq@aesteve-thinkpadp1gen8.rmtes.csb>
References: <20261027-v2_20230123_tjmercier_google_com-v3-0-78d2c4cb8647@redhat.com>
 <20261027-v2_20230123_tjmercier_google_com-v3-7-78d2c4cb8647@redhat.com>
 <d76d8bfe-e955-4e90-9f5f-e3e914c0869c@amd.com>
 <auIeQU0nAnOLdKUB@aesteve-thinkpadp1gen8.rmtes.csb>
 <9ebce3f2-f7a0-46a9-bad7-39059b99423f@amd.com>
 <auNzHjhT5xezyZ4I@aesteve-thinkpadp1gen8.rmtes.csb>
 <08705a7a-86aa-4b43-a22a-e80a572010f2@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <08705a7a-86aa-4b43-a22a-e80a572010f2@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: v2dk8iwDFqYIXyHIla0Ba9vbVyD4fLL8hMhYGGMx5gU_1793612760
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	RWL_MAILSPIKE_EXCELLENT(-0.40)[170.10.129.124:from];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:170.10.129.0/24];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[170.10.129.124:from];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[39];
	ALIAS_RESOLVED(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[139.47.30.142:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DWL_DNSWL_BLOCKED(0.00)[redhat.com:dkim];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com,infradead.org,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,kvack.org,lists.trustedfirmware.org,redhat.com];
	ASN(0.00)[asn:30031, ipnet:170.10.128.0/23, country:US];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.71:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 585A544243
X-Spamd-Bar: --
Message-ID-Hash: MEBUFJBTVH2DQDVJ2CM7OR7V3UDMFFBD
X-Message-ID-Hash: MEBUFJBTVH2DQDVJ2CM7OR7V3UDMFFBD
X-MailFrom: aesteve@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Sumit Semwal <sumit.semwal@linaro.org>, Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>, Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, cgrou
 ps@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, op-tee@lists.trustedfirmware.org, echanude@redhat.com, mripard@kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/MEBUFJBTVH2DQDVJ2CM7OR7V3UDMFFBD/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: Albert Esteve via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Albert Esteve <aesteve@redhat.com>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 11:14:50AM +0100, Christian K=F6nig wrote:
> On 10/29/26 17:23, Albert Esteve wrote:
> > On Thu, Oct 29, 2026 at 03:16:12PM +0100, Christian K=F6nig wrote:
> >> On 10/28/26 17:09, Albert Esteve wrote:
> >>> On Wed, Oct 28, 2026 at 10:08:19AM +0100, Christian K=F6nig wrote:
> >>>> On 10/27/26 16:02, Albert Esteve wrote:
> >>>>> dma-heap already supports charging a specific cgroup at allocation
> >>>>> time via charge_fd in DMA_HEAP_IOCTL_ALLOC. However, dma-bufs can
> >>>>> originate from any exporter (DRM, V4L2, etc.), and the allocator may
> >>>>> not know the final owner at allocation time.
> >>>>>
> >>>>> Add DMA_BUF_IOCTL_XFER_CHARGE to transfer a dma-buf's memcg charge
> >>>>> to a different cgroup after allocation. The target is identified by
> >>>>> charge_fd, which may be a cgroupfd or a pidfd.
> >>>>>
> >>>>> The transfer charges the new cgroup before uncharging the old one,
> >>>>> preserving the original charge on failure. An atomic cmpxchg on
> >>>>> dmabuf->memcg prevents races with concurrent transfers.
> >>>>>
> >>>>> Not all dma-buf exporters back their buffers with reclaimable system
> >>>>> memory. Some represent device registers, VRAM, or carved-out pools
> >>>>> where size is not a meaningful memory cost. Add a memcg_account flag
> >>>>> to dma_buf_export_info that exporters set when their buffers should
> >>>>> participate in memcg accounting. The xfer ioctl returns -EOPNOTSUPP
> >>>>> for buffers that do not set the flag. Currently only the system heap
> >>>>> sets it, other exporters can opt in as needed.
> >>>>>
> >>>>> Usage example:
> >>>>>   int cg_fd =3D open("/sys/fs/cgroup/clients/app1", O_RDONLY | O_DI=
RECTORY);
> >>>>>
> >>>>>   struct dma_buf_transfer_charge xfer =3D {
> >>>>>       .charge_fd =3D cg_fd,
> >>>>>   };
> >>>>>   ioctl(dmabuf_fd, DMA_BUF_IOCTL_XFER_CHARGE, &xfer);
> >>>>>   /* charge now on app1's cgroup */
> >>>>>   close(cg_fd);
> >>>>>
> >>>>> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> >>>>> ---
> >>>>>  drivers/dma-buf/dma-buf.c           | 43 +++++++++++++++++++++++++=
++++++++++++
> >>>>>  drivers/dma-buf/heaps/system_heap.c |  1 +
> >>>>>  include/linux/dma-buf.h             |  5 +++++
> >>>>>  include/linux/memcontrol.h          |  9 ++++++++
> >>>>>  include/uapi/linux/dma-buf.h        | 26 ++++++++++++++++++++++
> >>>>>  mm/memcontrol.c                     | 41 +++++++++++++++++++++++++=
++++++++++
> >>>>>  6 files changed, 125 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> >>>>> index f31f49ebd0af..07513ecedc10 100644
> >>>>> --- a/drivers/dma-buf/dma-buf.c
> >>>>> +++ b/drivers/dma-buf/dma-buf.c
> >>>>> @@ -540,6 +540,45 @@ static long dma_buf_import_sync_file(struct dm=
a_buf *dmabuf,
> >>>>>  }
> >>>>>  #endif
> >>>>> =20
> >>>>> +/* Transfer a dma-buf's memcg charge; see struct dma_buf_transfer_=
charge */
> >>>>> +static long dma_buf_xfer_charge(struct dma_buf *dmabuf,
> >>>>> +				const void __user *user_data)
> >>>>> +{
> >>>>> +	struct dma_buf_transfer_charge arg;
> >>>>> +	struct mem_cgroup *memcg;
> >>>>> +	int ret =3D 0;
> >>>>> +
> >>>>> +	if (copy_from_user(&arg, user_data, sizeof(arg)))
> >>>>> +		return -EFAULT;
> >>>>> +
> >>>>> +	if (!IS_ENABLED(CONFIG_MEMCG))
> >>>>> +		return 0;
> >>>>> +
> >>>>> +	if (arg.flags !=3D 0)
> >>>>> +		return -EINVAL;
> >>>>> +
> >>>>> +	if (!dmabuf->memcg_account)
> >>>>> +		return -EOPNOTSUPP;
> >>>>> +
> >>>>> +	memcg =3D mem_cgroup_get_from_fd(arg.charge_fd);
> >>>>> +	if (IS_ERR(memcg))
> >>>>> +		return PTR_ERR(memcg);
> >>>>> +
> >>>>> +	if (dmabuf->memcg =3D=3D memcg)
> >>>>> +		goto skip_transfer;
> >>>>> +
> >>>>> +	if (!mem_cgroup_transfer_dmabuf_charge(dmabuf, memcg)) {
> >>>>> +		ret =3D -ENOMEM;
> >>>>> +		goto skip_transfer;
> >>>>> +	}
> >>>>> +
> >>>>> +	return 0;
> >>>>> +
> >>>>> +skip_transfer:
> >>>>> +	mem_cgroup_put(memcg);
> >>>>> +	return ret;
> >>>>> +}
> >>>>> +
> >>>>>  static long dma_buf_ioctl(struct file *file,
> >>>>>  			  unsigned int cmd, unsigned long arg)
> >>>>>  {
> >>>>> @@ -590,6 +629,9 @@ static long dma_buf_ioctl(struct file *file,
> >>>>>  		return dma_buf_import_sync_file(dmabuf, (const void __user *)arg=
);
> >>>>>  #endif
> >>>>> =20
> >>>>> +	case DMA_BUF_IOCTL_XFER_CHARGE:
> >>>>> +		return dma_buf_xfer_charge(dmabuf, (const void __user *)arg);
> >>>>> +
> >>>>>  	default:
> >>>>>  		return -ENOTTY;
> >>>>>  	}
> >>>>> @@ -750,6 +792,7 @@ struct dma_buf *dma_buf_export(const struct dma=
_buf_export_info *exp_info)
> >>>>>  	dmabuf->size =3D exp_info->size;
> >>>>>  	dmabuf->exp_name =3D exp_info->exp_name;
> >>>>>  	dmabuf->owner =3D exp_info->owner;
> >>>>> +	dmabuf->memcg_account =3D exp_info->memcg_account;
> >>>>
> >>>> The initial charging should probably be done here as well.
> >>>>
> >>>> This way DMA-buf heaps only needs to pass in the charge_fd and we ca=
n re-use the functionality for other DMA-buf exporters as well.
> >>>
> >>> The problem with doing the charge here is that it happens too late.
> >>> That is the reasoning for this proposal to move all the charging logic
> >>> into heap allocators before pages are allocated.
> >>
> >> Oh, that is a really good point we need to talk about.
> >>
> >> DMA-buf heaps is actually a rather simple use case, but we have way mo=
re complex things.
> >>
> >> For example in some use cases the backing store of a DMA-buf is only a=
llocated on first use and only then it needs to be comitted to it's memcg o=
r dmem.
> >=20
> > Yes. The idea is focus on heaps for now. But the uAPI is actually
> > agnostic of the time when the charge happens. When we deal with
> > lazy-allocation in the future we can just call the reserve/cancel
> > helpers wherever is more appropiate. As long as the pages are not
> > allocated, exporters do not set dmabuf->memcg, and XFER does not
> > work (returns -EOPNOTSUPP).
>=20
> Yeah exactly that's the reason why I'm raising this topic. That approach =
won't work in all cases.
>=20
> See userspace is not aware that the kernel is delaying allocation or that=
 the kernel is allocating the backing store asynchroniously in a background=
 worker for example.
>=20
> So returning -EOPNOTSUPP when the backing store is not allocated yet and =
might be allocated later on is rather questionable uAPI because that is rac=
y by design.

Ah! I see what you meant now.

> >>
> >> I don't mind implementing it for DMA-buf heaps first, but we should ha=
ve the uAPI and it's handling so solid that it also works for future use ca=
ses.
> >=20
> > Agreed. I think we should cover all usecases with the current status.
> > Your feedback helped a lot in getting there!
>=20
> I mean we can postpone that until we finally need it, but essentially we =
need to be able to distinct between charging, e.g. making sure the cgroup h=
as enough free limit, and committing, e.g. allowing the resource to be recl=
aimed.
>=20
> And then it is possible that when the memcg of a DMA-buf changes that onl=
y the charging changes, but there isn't any comitted backing store yet...

Right. That would need adding a specific flag for committed pages or
a similar solution. When transfering an uncommited dmabuf only the
charge moves (limit reservation and dmabuf->memcg), the stat is
untouched. Once the backing store exists, the exporter commits, it
sets the flag and bumps MEMCG_DMABUF stat. For memory where its
backing store can go away (e.g., dynamic dma-buf sharing), it can
have a mirror function that drops the stat but keeps the charge.
That would resolve the -EOPNOTSUPP thingy, as transfer succeeds
when dmabuf->memcg is set even for uncommitted pages.

My question would be if all exporters know when memory is committed.
For those that only get, e.g., a firmware handle and cannot observe
the allocation, I guess the buffer can just remain reserved without
even being committed. Or in case of protected memory like OP-TEE
they would not even opt-in to begin with.

I do not mind adding that for next version, or leaving it for when
lazy exporters actually opt-in. It is not a big change either way.
Although, it may look weird while the system heap is the only user
and commits right away. But either way I can try to document the
flag / explain this discussion in the commit.

>=20
> >>> What we could do is fill the dmabuf->memcg field when the flag is set
> >>> (i.e., committing into the dmabuf in the patch semantics). But for th=
at
> >>> we'd need adding the memcg we want to charge it to into exp_info in
> >>> order to support charging to cgroups other than the allocator's (for
> >>> the common case would be simpler as we can just look at current).
> >>> Maybe that's what you meant?
> >>
> >> At least for the DMA-buf heaps use case that sounds reasonable for now.
> >=20
> > Thanks! Next version will have the flag removed and just use
> > dmabuf->memcg as indicator, set within dma_buf_export().
> > Also, `nr_pages` will be computed within dma_buf_export(), the
> > contract being that exporters setting exp_info.memcg assert that
> > size reflects actual system memory bytes.
>=20
> Thinking more about it I would also put changing dmabuf->memcg under the =
dmabuf->resv lock instead of doing it with cmpxchg.
>=20
> We don't need it currently, but the dmabuf->resv lock is used for all sta=
te changes of the DMA-buf object and this operation is not performance crit=
ical in any way possible.
>=20
> If there is a problem with locking order we at least get lockdep screamin=
g at us very early and not when we want to extend the functionality in the =
future.

Sure, will do.

BR,
Albert.

>=20
> Regards,
> Christian.
>=20
> >=20
> >>
> >> Regards,
> >> Christian.
> >>
> >>>
> >>>>
> >>>>>  	spin_lock_init(&dmabuf->name_lock);
> >>>>>  	init_waitqueue_head(&dmabuf->poll);
> >>>>>  	dmabuf->cb_in.poll =3D dmabuf->cb_out.poll =3D &dmabuf->poll;
> >>>>> diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/=
heaps/system_heap.c
> >>>>> index adeea8cd328b..a764167167ba 100644
> >>>>> --- a/drivers/dma-buf/heaps/system_heap.c
> >>>>> +++ b/drivers/dma-buf/heaps/system_heap.c
> >>>>> @@ -479,6 +479,7 @@ static struct dma_buf *system_heap_allocate(str=
uct dma_heap *heap,
> >>>>>  	exp_info.size =3D buffer->len;
> >>>>>  	exp_info.flags =3D fd_flags;
> >>>>>  	exp_info.priv =3D buffer;
> >>>>> +	exp_info.memcg_account =3D true;
> >>>>>  	dmabuf =3D dma_buf_export(&exp_info);
> >>>>>  	if (IS_ERR(dmabuf)) {
> >>>>>  		ret =3D PTR_ERR(dmabuf);
> >>>>> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> >>>>> index 23ec0ff23fba..ac0ec88cab93 100644
> >>>>> --- a/include/linux/dma-buf.h
> >>>>> +++ b/include/linux/dma-buf.h
> >>>>> @@ -433,6 +433,9 @@ struct dma_buf {
> >>>>> =20
> >>>>>  	/** @memcg: the cgroup to which this buffer is currently attribut=
ed */
> >>>>>  	struct mem_cgroup *memcg;
> >>>>> +
> >>>>> +	/** @memcg_account: account buffer memory to cgroup */
> >>>>> +	bool memcg_account;
> >>>>>  };
> >>>>> =20
> >>>>>  /**
> >>>>> @@ -505,6 +508,7 @@ struct dma_buf_attachment {
> >>>>>   * @flags:	mode flags for the file
> >>>>>   * @resv:	reservation-object, NULL to allocate default one
> >>>>>   * @priv:	Attach private data of allocator to this buffer
> >>>>> + * @memcg_account:	account buffer memory to cgroup
> >>>>>   *
> >>>>>   * This structure holds the information required to export the buf=
fer. Used
> >>>>>   * with dma_buf_export() only.
> >>>>> @@ -517,6 +521,7 @@ struct dma_buf_export_info {
> >>>>>  	int flags;
> >>>>>  	struct dma_resv *resv;
> >>>>>  	void *priv;
> >>>>> +	bool memcg_account;
> >>>>>  };
> >>>>> =20
> >>>>>  /**
> >>>>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> >>>>> index 6b30baa79fa9..36fddafbef4e 100644
> >>>>> --- a/include/linux/memcontrol.h
> >>>>> +++ b/include/linux/memcontrol.h
> >>>>> @@ -679,6 +679,9 @@ bool mem_cgroup_reserve_dmabuf(struct mem_cgrou=
p *memcg, gfp_t gfp,
> >>>>>  void mem_cgroup_commit_dmabuf(struct dma_buf *dmabuf, struct mem_c=
group *memcg,
> >>>>>  			      unsigned int nr_pages);
> >>>>> =20
> >>>>> +bool mem_cgroup_transfer_dmabuf_charge(struct dma_buf *dmabuf,
> >>>>> +				       struct mem_cgroup *new_memcg);
> >>>>> +
> >>>>>  void __mem_cgroup_uncharge(struct folio *folio);
> >>>>> =20
> >>>>>  /**
> >>>>> @@ -1206,6 +1209,12 @@ static inline void mem_cgroup_cancel_dmabuf(=
struct mem_cgroup *memcg,
> >>>>>  {
> >>>>>  }
> >>>>> =20
> >>>>> +static inline bool mem_cgroup_transfer_dmabuf_charge(struct dma_bu=
f *dmabuf,
> >>>>> +						     struct mem_cgroup *new_memcg)
> >>>>> +{
> >>>>> +	return true;
> >>>>> +}
> >>>>> +
> >>>>>  static inline void mem_cgroup_uncharge(struct folio *folio)
> >>>>>  {
> >>>>>  }
> >>>>> diff --git a/include/uapi/linux/dma-buf.h b/include/uapi/linux/dma-=
buf.h
> >>>>> index e827c9d20c5d..ea957f4b1d38 100644
> >>>>> --- a/include/uapi/linux/dma-buf.h
> >>>>> +++ b/include/uapi/linux/dma-buf.h
> >>>>> @@ -168,6 +168,31 @@ struct dma_buf_import_sync_file {
> >>>>>  	__s32 fd;
> >>>>>  };
> >>>>> =20
> >>>>> +/**
> >>>>> + * struct dma_buf_transfer_charge - Transfer a dma-buf's memcg cha=
rge
> >>>>> + *
> >>>>> + * Any holder of a dma-buf file descriptor can perform a
> >>>>> + * DMA_BUF_IOCTL_XFER_CHARGE to attribute the buffer's memory
> >>>>> + * cost to a specific cgroup, or move it from one cgroup to
> >>>>> + * another.  The ioctl charges the new cgroup before uncharging
> >>>>> + * the old one atomically.  On failure the original charge is
> >>>>> + * preserved.  If the buffer has no existing charge, a new
> >>>>> + * charge is established.
> >>>>> + */
> >>>>> +struct dma_buf_transfer_charge {
> >>>>> +	/** @flags: Reserved, must be zero */
> >>>>> +	__u32 flags; /* unused for now */
> >>>>> +	/**
> >>>>> +	 * @charge_fd: File descriptor identifying the target cgroup.
> >>>>> +	 *
> >>>>> +	 * May be either a pidfd, in which case the charge moves to the
> >>>>> +	 * memory cgroup of the referenced process, or a cgroupfd obtained
> >>>>> +	 * by opening a cgroup v2 directory, in which case the charge mov=
es
> >>>>> +	 * directly to that cgroup's memory controller.
> >>>>> +	 */
> >>>>> +	__u32 charge_fd;
> >>>>> +};
> >>>>> +
> >>>>>  #define DMA_BUF_BASE		'b'
> >>>>>  #define DMA_BUF_IOCTL_SYNC	_IOW(DMA_BUF_BASE, 0, struct dma_buf_sy=
nc)
> >>>>> =20
> >>>>> @@ -179,5 +204,6 @@ struct dma_buf_import_sync_file {
> >>>>>  #define DMA_BUF_SET_NAME_B	_IOW(DMA_BUF_BASE, 1, __u64)
> >>>>>  #define DMA_BUF_IOCTL_EXPORT_SYNC_FILE	_IOWR(DMA_BUF_BASE, 2, stru=
ct dma_buf_export_sync_file)
> >>>>>  #define DMA_BUF_IOCTL_IMPORT_SYNC_FILE	_IOW(DMA_BUF_BASE, 3, struc=
t dma_buf_import_sync_file)
> >>>>> +#define DMA_BUF_IOCTL_XFER_CHARGE	_IOW(DMA_BUF_BASE, 4, struct dma=
_buf_transfer_charge)
> >>>>> =20
> >>>>>  #endif
> >>>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> >>>>> index 7b841b905759..3adc84fe6668 100644
> >>>>> --- a/mm/memcontrol.c
> >>>>> +++ b/mm/memcontrol.c
> >>>>> @@ -5786,6 +5786,47 @@ void mem_cgroup_cancel_dmabuf(struct mem_cgr=
oup *memcg, unsigned int nr_pages)
> >>>>>  		refill_stock(memcg, nr_pages);
> >>>>>  }
> >>>>> =20
> >>>>> +/**
> >>>>> + * mem_cgroup_transfer_dmabuf_charge - move a dma-buf charge
> >>>>> + * @dmabuf: buffer to transfer charge
> >>>>> + * @new_memcg: target memcg; caller must hold a reference
> >>>>> + *
> >>>>> + * Transfers the charge for @dmabuf to @new_memcg and, on
> >>>>> + * success, stores @new_memcg in @dmabuf->memcg.
> >>>>> + * Returns %true on success, %false if the charge against @new_mem=
cg
> >>>>> + * failed or a concurrent transfer raced on @dmabuf->memcg.
> >>>>> + * On failure the caller retains its reference to @new_memcg.
> >>>>> + */
> >>>>> +bool mem_cgroup_transfer_dmabuf_charge(struct dma_buf *dmabuf,
> >>>>> +				       struct mem_cgroup *new_memcg)
> >>>>
> >>>> I would make that more generic instead of dmabuf specific. E.g. some=
thing like this:
> >>>>
> >>>> bool mem_cgroup_transfer_charge(struct struct mem_cgroup **ptr_memcg=
, struct mem_cgroup *new_memcg, enum memcg_stat_item item, unsigned int nr_=
pages)
> >>>
> >>> Ah yes, I like this generalization. And the implementation remains
> >>> mostly the same. Thanks!
> >>>
> >>>>
> >>>>> +{
> >>>>> +	struct mem_cgroup *old_memcg =3D READ_ONCE(dmabuf->memcg);
> >>>>
> >>>>> +	unsigned int nr_pages =3D PAGE_ALIGN(dmabuf->size) >> PAGE_SHIFT;
> >>>>
> >>>> This way we can also document in the DMA-buf caller that this conver=
sation must be ok when memcg_account is true.
> >>>>
> >>>> Regards,
> >>>> Christian.
> >>>>
> >>>>> +
> >>>>> +	if (mem_cgroup_disabled())
> >>>>> +		return true;
> >>>>> +
> >>>>> +	if (!mem_cgroup_reserve_dmabuf(new_memcg, GFP_KERNEL, nr_pages))
> >>>>> +		return false;
> >>>>> +
> >>>>> +	mod_memcg_state(new_memcg, MEMCG_DMABUF, nr_pages);
> >>>>> +
> >>>>> +	if (cmpxchg(&dmabuf->memcg, old_memcg, new_memcg) !=3D old_memcg)=
 {
> >>>>> +		mod_memcg_state(new_memcg, MEMCG_DMABUF, -nr_pages);
> >>>>> +		mem_cgroup_cancel_dmabuf(new_memcg, nr_pages);
> >>>>> +		return false;
> >>>>> +	}
> >>>>> +
> >>>>> +	if (old_memcg) {
> >>>>> +		/* Uncharge old cgroup */
> >>>>> +		mod_memcg_state(old_memcg, MEMCG_DMABUF, -nr_pages);
> >>>>> +		mem_cgroup_cancel_dmabuf(old_memcg, nr_pages);
> >>>>> +		mem_cgroup_put(old_memcg);
> >>>>> +	}
> >>>>> +
> >>>>> +	return true;
> >>>>> +}
> >>>>> +
> >>>>>  /**
> >>>>>   * mem_cgroup_uncharge_dmabuf - uncharge a dma-buf from its memcg
> >>>>>   * @dmabuf: buffer to uncharge
> >>>>>
> >>>>
> >>>
> >>
> >=20
>=20

