Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207A8606A326
	for <op-tee@archiver.kernel.org>; Fri,  6 Nov 2026 07:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=b8nslzNO
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7C33A454DA
	for <op-tee@archiver.kernel.org>; Fri,  6 Nov 2026 07:13:43 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=b8nslzNO;
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 45E1D454BE
	for <op-tee@lists.trustedfirmware.org>; Thu,  5 Nov 2026 23:12:22 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cdb1199bfd8so15098a12.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 05 Nov 2026 15:12:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793920341; cv=none;
        d=google.com; s=arc-20260327;
        b=LwgvabzNISFelPWUUn7oFw6jCi5wfuLFYi0z5HB9Ww0ohOLahVhfwb1Q5vB8qzOHr4
         bNwRr/qq/x4Hjw0N7J0TnnX/1BL0njI87BohOd2HZicF7scfqRYKCYRTDnUK7wPckuXz
         hng7doTmXS66giuiP64q0CHGED6gsmbH5bop3K+IDJepIulN1JrctBGO95jhH9QYqdnD
         ZwUX/VS7NZuIr6zamWpwuoYAZEKAD2yRPfx5jQcWsTFVn1vPtCvJXsiFua6bBs4a0Q0r
         QxsS3equtmqcfHOfaHWEwCC23QS+QFhKK966a3uNl6FinWCNhJVF7B8Jes2ysVJobUZw
         sA7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w+g0xKR97zcXC//9XGcArRTzIRGbaLo0LA3je3jFgFY=;
        fh=mFdkApHDdahHv3uiWDFN73517XpR1GbJRtH1KkK3Psc=;
        b=LjfqqVFBOuxHDwc71KBCOZTjwEhehzPZyDam6oEBI3bWKaTdy8hppTNAOfgUsYKkql
         /peYkpaXVb5pWjCcIPYzt34I3IaKWqq4ZPsT2ykFZHrDlKDKZiNvRsM6ZpDrxiACw74n
         KsGdhsYFtS8MR5O2TGApNhMid5itqkyj6GmjZVABKGVAMgFkjZkv5G71VSg1VDyKdEXs
         BCsEcLKeR+ujxjKtMxQHbq+HjD71dsvcRiduWL78tf8xie4HzoP70BOZGylACHzbBMC4
         pgSKCWJeRS/HV0tJp+J9FvvPvKet5Cd4lrZpVnuK7dIS4D97oeo5yYnDvSq/pt/I2Sma
         XIbQ==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793920341; x=1794525141; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w+g0xKR97zcXC//9XGcArRTzIRGbaLo0LA3je3jFgFY=;
        b=b8nslzNOgn/bA7tyZiiRWKKLNWVg+ZKya5+SXYkyuHI31Ph41M9ZGBK0sGMesj0fDX
         CXjqL1VkxGCEzAFRNeB9WUI9r7Yo5Cp3sTXXW/Ahf7uMdGmjSYxEe/zoOorEZ871n0w+
         p0ZpLwVCvZkyLXXqDkQfKZ9LfLYNMe4GTfhLm9nrVOeO6Th8XdTCSzPeoPwPE4mSUFvz
         PEgvV5+cD8cycSwOeYn7zA+CWJlo9FXO51/KWx+eMavRdgOpqJ5p9jAKA3Yjl9T4TLfF
         Rb+UfjZ7OLMAZYRuvjxHnzxofm/aiC8e2OM5oR4EmRr7tk1nAi5zYuchbDt69OTWje1m
         4R+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793920341; x=1794525141;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w+g0xKR97zcXC//9XGcArRTzIRGbaLo0LA3je3jFgFY=;
        b=X18EH34JSmBHRz17dWy2soNxspgOu/d3pE3j45T2otfiXB3nQTeWbNSFk90+MYHqdf
         AHHlK9ouKqp2cUt0peDqtEw/BGyWxZHq5vl4LnJenQ7LW7Hzjs6kKz2CVCAGIUx22Kz0
         pii/UwCOSDOcfz0YJyy0YZNGPL7jdinY9BkRLg1nqwbnRrkbxbk1FbVHsLQ76PyMv/RT
         qk7em5TGWCHWjSizTGAOKv+xDfnwBq2Lr9qt5wHvc/ql4Aor+kIuA++7GOCAyjWQqykM
         dgVXoHypV8NhWXd3CuZCdkm+Bv7Z/KFffOBUjCzgzuyo1WOjqpSu3Xn8CzgRNNQ7APqJ
         rWjw==
X-Forwarded-Encrypted: i=1; AKwUvBxtNDC6AFl7L8PpfDLhCp7OOGmiTJztnYESf+qRwx6LsJK2luatmDuQEPkBc45TvuvqA9D2adI=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z+KwKGrKlFMWucBZcfijFDchHBSFuuQ+al4Giqj8r/YSoVHRlSh
	GXDLOkIf7c7OcdhYApCub5Uc7Yv66hxLBbP+nj53Y8B8ku+5iwUNnTrE/UtLamzNGIqLwnI8I8v
	5rHW1gjNalShJdDKmYubXY3hZ7XH1IXusAYM1p8bm
X-Gm-Gg: AYBFou38suf7wgURmegiqr1WB3gt30Batli8DPD0zSxPTaqs1kL936rLpBh6TAhuXhM
	fdBTmpXzhYWPlQG9dJ/SrNtuqEAmkWUU9G5r4rz/afw5/o/gHz+XYtiOgOo1/dlVMzC6DdHOGEP
	+5vHefBM4dxvQogQwGvpdubOpzaUod8drcfVf4KUaUI5fingFMNmw+Umxb/ghTzP4AitOwu/7nN
	bGvd05pAIOWhMpsKGgrwWgQk5/GMrVyIpzxdQR8oSM3eWRp4Cq7854MwFp4u4J+PJxeSgBKviJO
	xt8q97rMWsixcMLczlo1ZH6qbk80zSj7Ayvp5rFps0MU/8PHoexbMykdB0WD0+VXbbz2kL3TXRQ
	UVII+LC0V4fIVLppV7TGE5kq+Oz3nHF8+izzKcCKnT7RF5utZd/J/rejLCClt5FljP//e
X-Received: by 2002:a17:90a:d88f:b0:3ac:b867:81df with SMTP id
 98e67ed59e1d1-3b0db6fbe69mr555739a91.39.1793920341210; Thu, 05 Nov 2026
 15:12:21 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org>
In-Reply-To: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Nov 2026 18:12:09 -0500
X-Gm-Features: AclHuK9SAmQ1s59IzUj_GoyUW49QmobrDei9zDR78OY4d10Tcv8mWs8d-l1JUg8
Message-ID: <CAHC9VhQvpFeEJaEyPDaqj8_S752puSaNe0Rn-hxjh=ugCoFsxA@mail.gmail.com>
Subject: Re: [PATCH 00/14] mm: convert further simple mmap hooks to mmap_prepare
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.215.173:from];
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
	DNSWL_BLOCKED(0.00)[209.85.215.173:from];
	RCPT_COUNT_GT_50(0.00)[60];
	DKIM_TRACE(0.00)[paul-moore.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 45E1D454BE
X-Spamd-Bar: ---
X-MailFrom: paul@paul-moore.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: TUBTKEYPMDFAPSHPN3P3EZMNAUEE5ICZ
X-Message-ID-Hash: TUBTKEYPMDFAPSHPN3P3EZMNAUEE5ICZ
X-Mailman-Approved-At: Fri, 06 Nov 2026 07:13:25 +0000
CC: Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?B?T25kcmVqIE1vc27
 DocSNZWs=?= <omosnacek@gmail.com>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Scott Branden <scott.branden@broadcom.com>, Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Richard Cochran <richardcochran@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, virtualizati
 on@lists.linux.dev, linux-sgx@vger.kernel.org, selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TUBTKEYPMDFAPSHPN3P3EZMNAUEE5ICZ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAD_ENC_HEADER,BAYES_00,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 5, 2026 at 4:06=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Continue the conversion of users of the deprecated f_op->mmap callback to
> f_op->mmap_prepare. Keep things gentle this cycle by targeting simple
> cases.
>
> No functional change intended.
>
> Build tested on x86-64 (allmodconfig, each patch individually), i386,
> arm64 and ppc64le.
>
> <<>>
>
> David, Andrew - I wonder whether one of you guys could take this series
> through your tree? Since it's kernel-wide it seems sensible to take it
> through an mm tree.

Granted I've only properly looked at the SELinux patch (7/14), the
rest I've just skimmed through, but these are all independent patches,
right?  Is there any reason why individual subsystem maintainers
shouldn't just pick up their associated patch?  Yes, perhaps chasing
down individual maintainers is a bit more work, but isn't that the way
this should work?

> Lorenzo Stoakes (ARM) (14):
>       xen/privcmd: convert mmap hook to mmap_prepare
>       KVM: PPC: Book3S: convert spapr TCE mmap hook to mmap_prepare
>       mshv_vtl: convert mmap hooks to mmap_prepare
>       vduse: convert IOVA domain mmap hook to mmap_prepare
>       x86/sgx: convert vepc mmap hook to mmap_prepare
>       udf: convert mmap hook to mmap_prepare
>       selinuxfs: convert mmap hooks to mmap_prepare
>       xen: convert xenstore interface mmap hooks to mmap_prepare
>       soc: aspeed: convert LPC and P2A control mmap hooks to mmap_prepare
>       soc: qcom: rmtfs_mem: convert mmap hook to mmap_prepare
>       tee: convert shm mmap hook to mmap_prepare
>       misc: bcm-vk: convert mmap hook to mmap_prepare
>       ptp: vmclock: convert mmap hook to mmap_prepare
>       vhost-vdpa: convert mmap hook to mmap_prepare
>
>  arch/powerpc/kvm/book3s_64_vio.c        |  6 +++---
>  arch/x86/kernel/cpu/sgx/virt.c          | 15 ++++++++-------
>  drivers/hv/mshv_vtl_main.c              | 14 +++++++-------
>  drivers/misc/bcm-vk/bcm_vk_dev.c        | 20 ++++++++++----------
>  drivers/ptp/ptp_vmclock.c               | 19 +++++++++----------
>  drivers/soc/aspeed/aspeed-lpc-ctrl.c    | 20 +++++++++-----------
>  drivers/soc/aspeed/aspeed-p2a-ctrl.c    | 22 ++++++++--------------
>  drivers/soc/qcom/rmtfs_mem.c            | 22 ++++++++++------------
>  drivers/tee/tee_shm.c                   | 14 +++++++-------
>  drivers/vdpa/vdpa_user/iova_domain.c    | 12 ++++++------
>  drivers/vhost/vdpa.c                    | 23 ++++++++++++-----------
>  drivers/xen/privcmd.c                   | 11 +++++------
>  drivers/xen/xenbus/xenbus_dev_backend.c | 14 ++++++--------
>  drivers/xen/xenfs/xenstored.c           | 14 ++++++--------
>  fs/udf/file.c                           |  8 ++++----
>  security/selinux/selinuxfs.c            | 24 +++++++++++-------------
>  16 files changed, 121 insertions(+), 137 deletions(-)

--=20
paul-moore.com
