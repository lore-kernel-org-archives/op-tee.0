Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB52B606A31E
	for <op-tee@archiver.kernel.org>; Tue, 24 Nov 2026 18:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=Ns0ocBa9;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=VyCHGOD7
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 14E9A4D9C0
	for <op-tee@archiver.kernel.org>; Tue, 24 Nov 2026 18:54:23 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=Ns0ocBa9;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=VyCHGOD7;
	dkim-atps=neutral
Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C26C744DC9
	for <op-tee@lists.trustedfirmware.org>; Tue, 24 Nov 2026 18:54:17 +0000 (UTC)
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailflow.phl.internal (Postfix) with ESMTP id 311661380320
	for <op-tee@lists.trustedfirmware.org>; Tue, 24 Nov 2026 13:54:17 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Tue, 24 Nov 2026 13:54:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795546436;
	 x=1795553636; bh=iJ0bZtF+M32WhmItWYj3FSa2ZiQSpvoOogcaFVHVH5I=; b=
	Ns0ocBa9uuJQNTtG3QfiU8sUxKT2BVab79oK6XioPic07HNY7BbGUro4492vDSKa
	taWSB3j0rahIlRO5r8ZoxMAmIeofQrkEd2O7X1OMQEOOEmHkNvuaEYSDts/UAM8w
	fED4InNTr0trVvSv57ETj3yHni+DAOQy8IgrUckr5I1xjqbrfGUxOwoJi0smwrAp
	nxVmvZkiOxgeZLtuxZuUgSTF8HOJ38Mrh+Szpuf5yDk9lzFD74nKhq2IZnhfVZN/
	vyB/Gl1S/ltyMKRNSc+WiurJ6LH/MJ4UcyvYBvhtsIXVP/k06hqmaXkoDI11XeA7
	wlXBDaQ5dfB4kxGI+OVvoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795546436; x=
	1795553636; bh=iJ0bZtF+M32WhmItWYj3FSa2ZiQSpvoOogcaFVHVH5I=; b=V
	yCHGOD7HZXf+kTkcfTRyN6yTdKP309423KicUoIMqFh/OtFm+5uIv1vysvBFedjV
	XJFPWePPRM0CnxRFksiKelXDd4qxik7aQ3mMcyBCJjLxhyAF1/B4D21N2RNJubIz
	u5cBy+nZv7B/NkDxHFeW1hHCDPsd2Yncp7NFyXICp+R3pT0Y5ellhwQTcSjOD4Is
	qcejxkzW8ihZzqAnjwKGNkFDJQStwnjJ8vVNe8gpcx5sVF8NLwPxyCUUnJOe3iXr
	77Djsuz/1kfq3wwkXcMCZm5S41gIGVWAkWq3DEPG3YLiO4EDE4ry1FhRdzsZiw+Q
	+pL5WKOI4leoxTvwkIf/g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795546436; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PG9wLXRlZUBsaXN0cy50cnVzdGVkZmlybXdhcmUub3JnPg==;
	s=fm2:rsa-sha256:f+efUh7ClNUD6Eb9UaLKbE9ef0vPxnAv2MclUQLngz/O8VU
	edriPpcIfcD1ghwnVqpxFhWVNDTHpthJ0GzH+YACoo6yIXsLfOlse1c2pc/O6pOy
	B0C7ui8YXNgnZ6G4V5ACWjQD429Hfr+DDguI5FWUJ0kGxFYlBTRz3zQvvP1GJ/7d
	6NVR9eJozDGlTfyKRnrF3R7tJYat40FlhPx+PpbxDyJNYKwvZ5FyqmVxm8hnnl0j
	CTuxVg2GeepJ0+H2K31peeGIN5K3ZTJvNvbvf5TCAgq7xYlvrPw7pdL0QnCIPpgt
	G+ehBhj4w3S1RTsaZ2n2XVzTS8ZuhcEJW1lZfSg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:JE9Pf+dIuvBMDyw467eQ/Tr4tyY4SBvJ9vbnWlDmBbU=:iJ0bZtF+M32WhmItWYj3FSa2ZiQSpvoOogcaFVHVH5I=;
X-ME-Sender: <xms:NN0Fa_Dh16pBjRQMtmAQtpYpz28UEZAAlNWef9QDlR230iNPWwpgaA>
    <xme:NN0FawWnt_cU2zPqxwlF3kn6lXR865LwUWDq-4TBjsqjqIqfahALCgQWW-0jyO7G3
    I2uTFidD6Jk0Jt_ZRZrrybQhsZmf0PkwLrG07cX5Ey9rp4FNHu-UqM>
X-ME-Proxy-Cause: dmFkZTFsQKpYLoHX3KE6zope7Xly27EYv6AQYyIF3Qau4aRC0vSHzWA0jMBeGZ/9+uCniy
    PTkF5Fmn4ClSCnUsMdxXtnQhtPNPNvOPsMvdctlUYyw6p+0jhYlfcnMwYC+ka8/fLSpuKw
    3YLhivPgri0MvBEeHeehNeV5wiFAsJv2bcNaHD7UboTSW+RjgcB42VuUlh1hahI0iQExPr
    +XuV8lAvetVw7YfrG+rkJKl9bl6k1+Pc6YG1mdIQsn8HBaASQD8dGrUNem4yjy4NNXFr2o
    l0vAJfxG5EW/9uTEMy9av1oYJYPAqHBvhuaThuRz9ZxrEhJBnZZaNefPyOfbd5a857jzji
    xS3AH0yNi27nlGbP2enOJqlf9wVeoOUs7OcWrHRUnaD4wGX3BucglKw1DWVVHUPxhfMt+c
    yYMsv9QYzlu0IncPWVnqsNMz+WiqY0HZprQifxi/zsPZ8ChkJiSCAB7jX698jdmSQw7t0Q
    wldIOTkPNxc4rzT0CMfulFrj4Rm5L/cie4t1IvZQrqsjE2CBRn8iUu7yiZ0dS2UrGJdlIv
    HMXP1d1uGpGRgLQ/rxCRTkol4EEsKGIX1Iz0tWkHIV/hA4OOaUelQC0/ml5S6Hx7O/VRRR
    HHsnZozZEW2a8iAqfQuYUL98uV7rqteWCN+bZ4WQQO+0dMzPuH8W8HlVGiTA
X-ME-Proxy: <xmx:PN0Fa_OfkSf0I2gz53d1q87MSYiyija7o2MtMOioAI-ZeTkir1jV5A>
    <xmx:PN0Fa6p4AcKgvKj7Nxl2i9GHjEd2VbenjcJEjgY_FbTxdjTIKHGJeg>
    <xmx:PN0Fa5WDuMRF3QKr7uInN4TtUt9GYOr8jpLSEeuwpRljz5xEyg6WqA>
    <xmx:PN0Fazu29G7Wm_IQCdCnlJY6WRkfF9-85rVjBcVYL-WZQOkOQNyjOA>
    <xmx:RN0Fa7HuB9LonHDmNq2kLPdcfAnhX1Syf3plWTxAvus5eCvT9QG1bsct>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 4968232A0099; Tue, 24 Nov 2026 13:53:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ai76fMdDSoMo
Date: Tue, 24 Nov 2026 19:53:19 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Lorenzo Stoakes" <ljs@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Juergen Gross" <jgross@suse.com>,
 "Stefano Stabellini" <sstabellini@kernel.org>,
 "Oleksandr Tyshchenko" <oleksandr_tyshchenko@epam.com>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Christophe Leroy" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 "Shrikanth Hegde" <sshegde@linux.ibm.com>,
 "Haiyang Zhang" <haiyangz@microsoft.com>, "Wei Liu" <wei.liu@kernel.org>,
 "Dexuan Cui" <decui@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Jason Wang" <jasowangio@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "Xuan Zhuo" <xuanzhuo@linux.alibaba.com>,
 "Jarkko Sakkinen" <jarkko@kernel.org>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Jan Kara" <jack@suse.com>,
 "Paul Moore" <paul@paul-moore.com>,
 "Stephen Smalley" <stephen.smalley.work@gmail.com>,
 =?UTF-8?Q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>,
 "Joel Stanley" <joel@jms.id.au>,
 "Andrew Jeffery" <andrew@codeconstruct.com.au>,
 "Ryan Chen" <ryan_chen@aspeedtech.com>,
 "'billy_tsai@aspeedtech.com'" <billy_tsai@aspeedtech.com>,
 "Bjorn Andersson" <andersson@kernel.org>,
 "Konrad Dybcio" <konradybcio@kernel.org>, "Abel Vesa" <abelvesa@kernel.org>,
 "Jens Wiklander" <jenswi@kernel.org>, "Sumit Garg" <sumit.garg@kernel.org>,
 "Scott Branden" <scott.branden@broadcom.com>,
 "Broadcom internal kernel review list" <bcm-kernel-feedback-list@broadcom.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Richard Cochran" <richardcochran@gmail.com>,
 "David Woodhouse" <dwmw2@infradead.org>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>
Message-Id: <3208cde3-c5cf-4888-88f7-c77d7b0e5940@app.fastmail.com>
In-Reply-To: <20261124-late-2026-mmap_prepare-v2-8-0b0d99d655f9@kernel.org>
References: <20261124-late-2026-mmap_prepare-v2-0-0b0d99d655f9@kernel.org>
 <20261124-late-2026-mmap_prepare-v2-8-0b0d99d655f9@kernel.org>
Subject: Re: [PATCH v2 08/13] soc: aspeed: convert LPC and P2A control mmap hooks to
 mmap_prepare
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.48 / 15.00];
	BAYES_HAM(-2.99)[99.96%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:103.168.172.128/27];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm2,messagingengine.com:s=fm3];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	ASN(0.00)[asn:151847, ipnet:103.168.172.0/24, country:AU];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_NONE(0.00)[messagingengine.com:dkim];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_TO(0.00)[kernel.org,linux-foundation.org,suse.com,epam.com,linux.ibm.com,gmail.com,ellerman.id.au,microsoft.com,redhat.com,linux.alibaba.com,linux.intel.com,alien8.de,zytor.com,paul-moore.com,jms.id.au,codeconstruct.com.au,aspeedtech.com,broadcom.com,linuxfoundation.org,infradead.org,lunn.ch,davemloft.net];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_GT_50(0.00)[62];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_IN_DNSWL_NONE(0.00)[103.168.172.139:from];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C26C744DC9
X-Spamd-Bar: --
Message-ID-Hash: CVXKMAMB3YSSXZ24XFH7EQOM4JKHNQXF
X-Message-ID-Hash: CVXKMAMB3YSSXZ24XFH7EQOM4JKHNQXF
X-MailFrom: arnd@arndb.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, linux-sgx@vger.kernel.org, selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, Netdev <netdev@vger.kernel.org>, linux-mm@kvack.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/CVXKMAMB3YSSXZ24XFH7EQOM4JKHNQXF/>
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

On Tue, Nov 24, 2026, at 15:02, Lorenzo Stoakes (ARM) wrote:
> Move from the deprecated mmap hook to the new mmap_prepare hook for both
> the LPC control and P2A control drivers.
>
> Both remap a range of their reserved memory region, so use the PFN remap
> mmap action to do so, retaining the -EAGAIN error on failure via the action
> error override.
>
> Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
