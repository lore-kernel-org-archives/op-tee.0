Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449CA606A32A
	for <op-tee@archiver.kernel.org>; Mon,  9 Nov 2026 06:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=egf84Gcq
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8EAAD45507
	for <op-tee@archiver.kernel.org>; Mon,  9 Nov 2026 06:56:22 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=egf84Gcq;
	dkim-atps=neutral
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2EA04451B1
	for <op-tee@lists.trustedfirmware.org>; Mon,  9 Nov 2026 05:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1794201519;
	bh=inbRv9rqETpvmrvWY+hsNFNboYN1tmYS0qnuK2Kr/gs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=egf84Gcqai+t2RbzRcp/hsSqUjhQHhjh3vyzhBpm8hV2KWxqDFJxnPUahIU113EcT
	 BgLm6wqU/Euo4rhk1oHtIX3Z9zvOL05mtWbK6K/L7+70zAOa6b9LxPeqiMFkTfAyXR
	 sJ6r+I/RKBuOwB8hQ4kh0KzVB0J735kCbnMQRQlA7QvM+MYWUHFrMnQcdvVsUlq4qL
	 OrhgI7yGlCRf9GdwPQCvkWPbpW6LqMolW9oQ7mrzBne/qL9+nOjj/aqp3F164dsqk2
	 7rLero/HB4L0DSs1r+ug01+7VgG2RcG87tSeq7M4AqhpAUCMcl+W2qQMRVuMpXb4J2
	 kfa7LW520ih5Q==
Received: from [192.168.68.117] (unknown [180.150.112.139])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 083566E9E9;
	Mon,  9 Nov 2026 13:18:31 +0800 (AWST)
Message-ID: <4848c58f3152233477c4fa4786de2a49c9261c9c.camel@codeconstruct.com.au>
Subject: Re: [PATCH 09/14] soc: aspeed: convert LPC and P2A control mmap
 hooks to mmap_prepare
From: Andrew Jeffery <andrew@codeconstruct.com.au>
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
 <joel@jms.id.au>, Ryan Chen	 <ryan_chen@aspeedtech.com>, Billy Tsai
 <billy_tsai@aspeedtech.com>, Bjorn Andersson <andersson@kernel.org>, Konrad
 Dybcio <konradybcio@kernel.org>, Abel Vesa	 <abelvesa@kernel.org>, Jens
 Wiklander <jenswi@kernel.org>, Sumit Garg	 <sumit.garg@kernel.org>, Scott
 Branden <scott.branden@broadcom.com>,  Broadcom internal kernel review list
	 <bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Richard Cochran
 <richardcochran@gmail.com>, David Woodhouse	 <dwmw2@infradead.org>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller"	 <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski	 <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Date: Mon, 09 Nov 2026 15:48:30 +1030
In-Reply-To: <20261105-late-2026-mmap_prepare-v1-9-c56aadfbab8a@kernel.org>
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org>
	 <20261105-late-2026-mmap_prepare-v1-9-c56aadfbab8a@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.33 / 15.00];
	BAYES_HAM(-2.03)[95.20%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	R_SPF_ALLOW(-0.20)[+mx];
	ONCE_RECEIVED(0.20)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:133159, ipnet:203.29.240.0/22, country:AU];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,suse.com,epam.com,linux.ibm.com,gmail.com,ellerman.id.au,microsoft.com,redhat.com,linux.alibaba.com,linux.intel.com,alien8.de,zytor.com,paul-moore.com,jms.id.au,aspeedtech.com,broadcom.com,arndb.de,linuxfoundation.org,infradead.org,lunn.ch,davemloft.net];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[60];
	DNSWL_BLOCKED(0.00)[180.150.112.139:received,203.29.241.158:from];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 2EA04451B1
X-Spamd-Bar: -
X-MailFrom: andrew@codeconstruct.com.au
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: V65G7AEVPFSYUQ57FSKQZZOBSX2QSSG3
X-Message-ID-Hash: V65G7AEVPFSYUQ57FSKQZZOBSX2QSSG3
X-Mailman-Approved-At: Mon, 09 Nov 2026 06:56:05 +0000
CC: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, linux-sgx@vger.kernel.org, selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/V65G7AEVPFSYUQ57FSKQZZOBSX2QSSG3/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 2026-11-05 at 21:05 +0000, Lorenzo Stoakes (ARM) wrote:
> Move from the deprecated mmap hook to the new mmap_prepare hook for both
> the LPC control and P2A control drivers.
>=20
> Both remap a range of their reserved memory region, so use the PFN remap
> mmap action to do so, retaining the -EAGAIN error on failure via the acti=
on
> error override.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>
