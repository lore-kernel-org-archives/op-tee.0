Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416E1606A326
	for <op-tee@archiver.kernel.org>; Fri,  6 Nov 2026 07:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=GsbOfc7i
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 97A6C454CD
	for <op-tee@archiver.kernel.org>; Fri,  6 Nov 2026 07:14:12 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=GsbOfc7i;
	dkim-atps=neutral
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 89468454C9
	for <op-tee@lists.trustedfirmware.org>; Thu,  5 Nov 2026 23:14:17 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc758830601so23320a12.2
        for <op-tee@lists.trustedfirmware.org>; Thu, 05 Nov 2026 15:14:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793920456; cv=none;
        d=google.com; s=arc-20260327;
        b=lkJtsssZBHPr0ahkdLiKGxxKQ68fc9kyObW0zoiN/uBTWE7rZZqy+JJLZHOAAPczDQ
         awocvc9QuAJUak6VpytIAdpgdEaIzt4iUvD1OQlUm73hHQRR6iJgcfypArkRmDBIgcGw
         DlTrjPgdxpJceCxhPFHRe1gA4GhrK2W/ZNkSnvABpY1VR/kK3JneSJqhCgCRs1E0qF1b
         ysw18h/PM2QXwY0fRvt1pytSC+WokW6owDCJPeMxs1yAT55aZlxegy1/ACnX5d6/wQgc
         +GQaiSODNBIE/WFCBYOJCU8pUaRj6DZPUlucC/EANiE3XqMdTFcenWpF28pZXSPPtdSS
         +eyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mGiD8zQqMuzCkGXAZBtgumh8HlT9rNPiWNa35MXqkeQ=;
        fh=KD9V8BPZog/CrdKMHwGapfGvpgrOMoFc3uWxaHHdhRE=;
        b=TTp/sz/UoQIzQKVLBtwiaI3MxmPye6FYtnIswNpbu4RUhIieHUSAMbWwIPSHhiw4XH
         5KMthaVS/eK3I7BjdJi4cvUFmfj2DBEZMXtxdX+XPNdl8EaCR2i0rpk1NkdgIJ6uZqYU
         6YoG0BqseuH30dVTSfrxxOGzV1xEK6s5+1G7L80JHKTTD3OlvFC73dVh7BQJg73XPGcA
         85/OYAJT8sSTuHOolvGSgS+3pYRH+Gr/ZM2Ww++nYBEE/JUNBUVzcfGchqsfMEdswqQ8
         qz9Ynkwrw2ymZcnriEoY0Ln5TXj6NR6BbKTkVjqYLw0FQf763DtWvaRYn4PsLD+DB3Ui
         lHCA==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793920456; x=1794525256; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mGiD8zQqMuzCkGXAZBtgumh8HlT9rNPiWNa35MXqkeQ=;
        b=GsbOfc7iGNJj4ujJs0bmu17VHBJlcEeRhisqx3Sih5gscq6bhFcCmHuurtBkw7v3J0
         UzQNIJCgoqmaaHJzpQEB9ICpVuIUYt2QwDYm9lghZn4KPtBvpt8uptnoOZ3I/VegZgMn
         tHmIsSClfQe7de8yhnc/KoSHlMjEKPcWjrQDwEPNzgRPuIFnrD3IqMK0EdQ5JrrObmXm
         3lsSGRuvme6Wx9qnlUpAG/dL6qXiqH0wyZ7AYh0MTjT+jgM3BI9q6dGSPFK4e81NPMJJ
         HDB4jMOwwZ40KpnLtSR7fuN2mqCRPtiR63ZDQPT93P3dUX+SqBzkkAcpKXuwPrhu2ktj
         XPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793920456; x=1794525256;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mGiD8zQqMuzCkGXAZBtgumh8HlT9rNPiWNa35MXqkeQ=;
        b=Tdn8eeyyu0DmUC2/FvKO5uxEkBUr1+S0WeNPd2sngvaz1fhgznRiLkoJOdYiq7F816
         CcjO2Smc+gaqUIB6Q4/leooJkBetSTEp5BQVGS/3yq912wh9R8MP4uEfEVmLLek4vjRh
         TqEBvNfZS5RZP3aEDap1XT7/0i4DElKbmUL6/pKcXq+vCI56b6bwG0w7kvO2Zc3K8TsY
         nHqxpvcHxslcPKNIA1hTf6LUBPft/jNqDFoOuBePJhwn0N7ZiWI4Agvhaz7N1Yeh5X6E
         HrU2udSxLo/xlGT2tZG0iSyadSScbRgE+ea8/XuYVbjF4VXHLU+H9dHtq0XPIHWPYV+d
         2xDw==
X-Forwarded-Encrypted: i=1; AKwUvBwHoLXTHIdrFvGZhVpu6QF8hiHTcUaw1bKOfx50G8yXh+vyLp6qWhph/qR2iWHHXK2giX4yorA=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z8YORK2AcOLSUyVIVKXDflA3kEPPTPLjla1Ihm5mSybfVwqbVGN
	LPrlj2r3396iMdGHUBS49WVwp2iqiFqcGSoGztUXOyKmZdvOdAX2ZNue0hk6PP/aayQTwKwlbhF
	Ryx4S283p97+Y8ANeCdbVcCKA9nQcDyWdruwjft5N
X-Gm-Gg: AYBFou1Af23vpmkmKAwR99szFI8ELRHAkVC7HCXsKzbidRj0hMIqttsnPDmhKTc7VeR
	XrfCp/FTr5GszGrtSfrEyShWZ4qKVcJ/086taBWrYfsW72flIcR7fWfY+7kgTkxHbmMHUHbzaNN
	mdPWs7VWjaR6dduWlcNXeGHszStXjB+x8RJzIAimlgbBe7WFmmJSEvYc3psBpEH4GxvuxBdBreC
	HbShxFD9sFPEpnyTWLVhIISnCM104QczRqnEpeeccLYaIHRvrCnfmi8mzw+K1y1R02qr5rivVdK
	vIB9v8yJNiLJdH3EWl0OnX7B0OX2Fq7N6JOD70XDDP2ME6d/yB/ASVnX+dqBcVH6Row4K0oQZDN
	Qkg+1ZWquw2XE+/uhm5LbR4S5hCeyabHMqNsthKCe1oAehqEfkxhQDJ3uNuTSZLqOodW2
X-Received: by 2002:a17:90b:48cf:b0:3ad:a462:f07f with SMTP id
 98e67ed59e1d1-3b0db6e8ca3mr534231a91.45.1793920456567; Thu, 05 Nov 2026
 15:14:16 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org> <20261105-late-2026-mmap_prepare-v1-7-c56aadfbab8a@kernel.org>
In-Reply-To: <20261105-late-2026-mmap_prepare-v1-7-c56aadfbab8a@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Nov 2026 18:14:04 -0500
X-Gm-Features: AclHuK-Yq9Ya_gmjsTlhf760be1vg51BQVbAOtNinoyo6VpZvAmG2k73A1wV2Mc
Message-ID: <CAHC9VhQcmX09Do8BmY-HYJEWKiw7Tf-ZB=EEr9K6t5dBzk0SSQ@mail.gmail.com>
Subject: Re: [PATCH 07/14] selinuxfs: convert mmap hooks to mmap_prepare
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.53 / 15.00];
	BAYES_HAM(-2.93)[99.72%];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.215.170:from];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,kernel.org,epam.com,linux.ibm.com,gmail.com,ellerman.id.au,microsoft.com,redhat.com,linux.alibaba.com,linux.intel.com,alien8.de,zytor.com,jms.id.au,codeconstruct.com.au,aspeedtech.com,broadcom.com,arndb.de,linuxfoundation.org,infradead.org,lunn.ch,davemloft.net,lists.xenproject.org,vger.kernel.org,lists.ozlabs.org,lists.linux.dev,lists.infradead.org,lists.trustedfirmware.org];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.215.170:from];
	RCPT_COUNT_GT_50(0.00)[60];
	DKIM_TRACE(0.00)[paul-moore.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 89468454C9
X-Spamd-Bar: ---
X-MailFrom: paul@paul-moore.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: AYRW6PNKZ5XYCFGVN5IZCXMUEVCRCWKZ
X-Message-ID-Hash: AYRW6PNKZ5XYCFGVN5IZCXMUEVCRCWKZ
X-Mailman-Approved-At: Fri, 06 Nov 2026 07:13:25 +0000
CC: Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?B?T25kcmVqIE1vc27
 DocSNZWs=?= <omosnacek@gmail.com>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Scott Branden <scott.branden@broadcom.com>, Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Richard Cochran <richardcochran@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, virtualizati
 on@lists.linux.dev, linux-sgx@vger.kernel.org, selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/AYRW6PNKZ5XYCFGVN5IZCXMUEVCRCWKZ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAD_ENC_HEADER,BAYES_00,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 5, 2026 at 4:07=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Move from the deprecated mmap hook to the new mmap_prepare hook for the
> policy and status files.
>
> The policy file only sets VMA flags and operations. The status file remap=
s
> a single page, so use the PFN remap mmap action to do so.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  security/selinux/selinuxfs.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)

See my comment in the cover letter.  I'd prefer to take this via the
SELinux tree so it can be included in all of our SELinux testing for
v7.5, but if this has to go through a single tree with the rest of the
changes, here is my ACK.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
