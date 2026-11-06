Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDB0606A31B
	for <op-tee@archiver.kernel.org>; Fri,  6 Nov 2026 00:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=eQdN9M2/
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7316A454D0
	for <op-tee@archiver.kernel.org>; Fri,  6 Nov 2026 00:35:32 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=eQdN9M2/;
	dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C7A5543E4A
	for <op-tee@lists.trustedfirmware.org>; Fri,  6 Nov 2026 00:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6TNCgRmL/23mHPVturwpYhS1/L+Zqx8rGxIrqrETX5o=; b=eQdN9M2/rNw+BU8m/E6O/8OYF7
	rQynrR5VfrTx3nqBv28uIvCr8lMXtstjEbOSk/dIaASeICHfcsUZhmw8GWxh3LA6/bkABBx2GraMj
	TUgkUT38MkwKFrW7+iKSat5ykUYDKgKeWxpZUkHwC87GsuvKH/SC2Hq4PhcYkeX4DrTHpHnszfGRf
	3pKIDXdt8bsXYPp71p1RiQCYDhljxFSnULrnZUh8DySiUJoi/nLn/88PQELGj9rE6h7rzqo9zFjGp
	XAlUiHrkjXx2SD8PhEQikpLsOGg5os6f5T8udNzGtIP18yCcCYB8hHFcSqYsX6O5LnphTLi/AqZWy
	qLQpwhsA==;
Received: from [205.251.233.52] (helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP7ue-0000000EEk3-0BZ5;
	Fri, 06 Nov 2026 00:34:36 +0000
Message-ID: <b63e75987464d669779b1a861d4a073c9caf85f4.camel@infradead.org>
Subject: Re: [PATCH 13/14] ptp: vmclock: convert mmap hook to mmap_prepare
From: David Woodhouse <dwmw2@infradead.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Juergen Gross
 <jgross@suse.com>,  Stefano Stabellini <sstabellini@kernel.org>, Oleksandr
 Tyshchenko <oleksandr_tyshchenko@epam.com>, Madhavan Srinivasan	
 <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Michael
 Ellerman	 <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>,  "Ritesh Harjani (IBM)"	 <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Haiyang Zhang	
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui	
 <decui@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang	
 <jasowangio@gmail.com>, Eugenio =?ISO-8859-1?Q?P=E9rez?=
 <eperezma@redhat.com>,  Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jarkko
 Sakkinen <jarkko@kernel.org>, Dave Hansen	 <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar	 <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Jan Kara <jack@suse.com>, Paul Moore
 <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej =?UTF-8?Q?Mosn=C3=A1=C4=8Dek?=	 <omosnacek@gmail.com>, Joel Stanley
 <joel@jms.id.au>, Andrew Jeffery	 <andrew@codeconstruct.com.au>, Ryan Chen
 <ryan_chen@aspeedtech.com>, Billy Tsai	 <billy_tsai@aspeedtech.com>, Bjorn
 Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Jens Wiklander	 <jenswi@kernel.org>, Sumit
 Garg <sumit.garg@kernel.org>, Scott Branden	 <scott.branden@broadcom.com>,
 Broadcom internal kernel review list	
 <bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Richard Cochran
 <richardcochran@gmail.com>, Andrew Lunn	 <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet	 <edumazet@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni	 <pabeni@redhat.com>
Date: Thu, 05 Nov 2026 16:34:23 -0800
In-Reply-To: <20261105-late-2026-mmap_prepare-v1-13-c56aadfbab8a@kernel.org>
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org>
	 <20261105-late-2026-mmap_prepare-v1-13-c56aadfbab8a@kernel.org>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-RN0WgQiIue6jLyM+SxS4"
User-Agent: Evolution 3.62.0-0ubuntu1~ppa1~24.04 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.79 / 15.00];
	DWL_DNSWL_MED(-2.00)[infradead.org:dkim];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	FORGED_SENDER(0.30)[dwmw2@infradead.org,batv@casper.srs.infradead.org];
	ONCE_RECEIVED(0.20)[];
	RCVD_IN_DNSWL_MED(-0.20)[90.155.50.34:from];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	BAYES_HAM(-0.19)[70.60%];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[c76d67e00cf3f3534b79,8475,infradead.org,dwmw2];
	HAS_ATTACHMENT(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_TO(0.00)[kernel.org,suse.com,epam.com,linux.ibm.com,gmail.com,ellerman.id.au,microsoft.com,redhat.com,linux.alibaba.com,linux.intel.com,alien8.de,zytor.com,paul-moore.com,jms.id.au,codeconstruct.com.au,aspeedtech.com,broadcom.com,arndb.de,linuxfoundation.org,lunn.ch,davemloft.net];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:20712, ipnet:90.155.0.0/18, country:GB];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[60];
	FROM_NEQ_ENVFROM(0.00)[dwmw2@infradead.org,batv@casper.srs.infradead.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_SPF_NA(0.00)[no SPF record]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C7A5543E4A
X-Spamd-Bar: ---
Message-ID-Hash: YJITSWF5WH3ZSZIHGUOFX3RM2YQWMWJO
X-Message-ID-Hash: YJITSWF5WH3ZSZIHGUOFX3RM2YQWMWJO
X-MailFrom: BATV+c76d67e00cf3f3534b79+8475+infradead.org+dwmw2@casper.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Content-Filtered-By: Mailman/MimeDel 3.3.5
CC: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, linux-sgx@vger.kernel.org, selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/YJITSWF5WH3ZSZIHGUOFX3RM2YQWMWJO/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--=-RN0WgQiIue6jLyM+SxS4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-11-05 at 21:05 +0000, Lorenzo Stoakes (ARM) wrote:
> Move from the deprecated mmap hook to the new mmap_prepare hook, using th=
e
> I/O PFN remap mmap action to map the clock page and retaining the -EAGAIN
> error on failure via the action error override.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Acked-by: David Woodhouse <dwmw@amazon.co.uk>

--=-RN0WgQiIue6jLyM+SxS4--
