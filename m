Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4DF4D2F7EE
	for <op-tee@archiver.kernel.org>; Fri,  5 Dec 2025 13:56:53 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 227644FEAC
	for <op-tee@archiver.kernel.org>; Fri,  5 Dec 2025 13:56:53 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm3 header.b=F4xxuDGc;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=MTztJQnm;
	dkim-atps=neutral
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5FC884496A
	for <op-tee@lists.trustedfirmware.org>; Fri,  5 Dec 2025 13:56:43 +0000 (UTC)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id CFC23EC059A;
	Fri,  5 Dec 2025 08:56:42 -0500 (EST)
Received: from phl-imap-17 ([10.202.2.105])
  by phl-compute-04.internal (MEProxy); Fri, 05 Dec 2025 08:56:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1764943002;
	 x=1765029402; bh=6jIDgDQomoK9NQlUOGMcADl/DSu11Lk9z8Cy7t1RvbY=; b=
	F4xxuDGc0gtaakPjCiWR79J4MlpS0Orv/CX+jp/pcae0eZCVsUG9bJJpNU16r9WC
	Q97J0yMJhPcWHUPSJ3y7AsCKikdIcivHm5Jre7waVdfZgmlk3b5iyNWk0TUqWiH+
	b+G6/knQa0YlX4RkBheoIqPEj12LT6mOc/fX+rAs4hyImiCdcWQ70JJZm/31Gjap
	OxsYCr3wSN0Vd83d1+sI4ZHLKjOG2IPw3OuEDhhXJB0+SgmZ28PBcpVXyBLvCIW8
	fM322kBRxvJv0N+pFVFuTjtlqZ1Er7X8X0N7IrEg72aWxzD/PRYsrszkIH8AAPte
	7x6Ay4Vir6CQzwb1zWl6Fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764943002; x=
	1765029402; bh=6jIDgDQomoK9NQlUOGMcADl/DSu11Lk9z8Cy7t1RvbY=; b=M
	TztJQnmfFCAOlzNO3QmXE2FxoP9qsTsJoYtxjRbN4pB6Yj4XdrEuCfkifspBcRtz
	SkjJjSUE4C4arq2LrkQZIJQcZHeVWw2rmIUj2/arM2tqTqq/NQOBuFz6hdZjsnpW
	8i0fSPuYlYCbBLSdvEm3ckJieUvAsUt2mUIMPtU2n9nd3WfhhbDQU8mkLw8EWjm1
	f7ea/FLYK8kpjgJCiS5s8y5qMSewCS/STDCnnN5OWMCSzmJFblW8cmv+x3nsQmRh
	Khf5eK6XDigO3F/SL2ApH3nIU9uZw5DmlhCSnjWSwYq8aVf++Bgnowt7Jqm2jkAQ
	YG7xTBprYQ+pyGjlk0X5Q==
X-ME-Sender: <xms:meQyaQGKYQddJGduzqqBQnUiHc5aV_6Gkd3IFBE-tBJAP0uP64tR-w>
    <xme:meQyaUJ8_7jMdbQX35mjwgAysyMdiMDn7znV7li1NrVThARFTCQq7cN_UVno1Ca6k
    om64IJek5eneduraTsMjBcosUn6b2rHawykJ92pwHLbFAdZZdAUOlY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhguuceu
    vghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvghrnh
    epteefudehvedutdeugfeuveffleduheehfeehffeujeduledvheeivdffleffjedtnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphht
    thhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgrlhhmvghrsegurg
    gssggvlhhtrdgtohhmpdhrtghpthhtoheprghouhesvggvtghsrdgsvghrkhgvlhgvhidr
    vgguuhdprhgtphhtthhopegvthhivghnnhgvrdgtrghrrhhivghrvgesfhhoshhsrdhsth
    drtghomhdprhgtphhtthhopegrlhgvgiesghhhihhtihdrfhhrpdhrtghpthhtoheprhgu
    uhhnlhgrphesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegrrhhnugeskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepphhjfieskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepshhumhhithdrghgrrhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjvghnsh
    drfihikhhlrghnuggvrheslhhinhgrrhhordhorhhg
X-ME-Proxy: <xmx:meQyaRO0x8kH-Lzr-tmupzBO5Za-nVg5DkNRm5olew-Ro8cvrDzWGQ>
    <xmx:meQyaU48jQ1nPaWb9U9yNp6BhVA3jjQo1Rc4y9PesZcT1QB4IQuLGg>
    <xmx:meQyaQnH5cNH1hkIuv7_rbKtBaXvYE1F_NT7EQKI8v9cZ5IIohMh8A>
    <xmx:meQyacKeddFIhE7PGDAcC9tHdaTrp9luufxxWCAuQ1RMqAhzGTQJvA>
    <xmx:muQyaQ7yxHPvJzgTkYP1Tv-IGADrMBKVmfrJMJ7wiPryQy8Cr6vvy9Rk>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 51D8AC40054; Fri,  5 Dec 2025 08:56:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: A173SAdB9O0B
Date: Fri, 05 Dec 2025 14:56:21 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Harshal Dev" <harshal.dev@oss.qualcomm.com>,
 "Jens Wiklander" <jens.wiklander@linaro.org>,
 "Arnd Bergmann" <arnd@kernel.org>
Message-Id: <9e44024d-a649-49d6-825f-97f2a11e1691@app.fastmail.com>
In-Reply-To: <45b5f14b-3746-4b05-a4b4-dc9f88e89e52@oss.qualcomm.com>
References: <20251204101730.1036671-1-arnd@kernel.org>
 <CAHUa44H1Ejbbuzr1hF1HrT69JGgnvfkkDkh+9KvEvBT+eWBDhw@mail.gmail.com>
 <45b5f14b-3746-4b05-a4b4-dc9f88e89e52@oss.qualcomm.com>
Subject: Re: [PATCH] tee: fix tee_ioctl_object_invoke_arg padding
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: ----
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5FC884496A
X-Spamd-Result: default: False [-4.09 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:103.168.172.128/27];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[103.168.172.148:from];
	XM_UA_NO_VERSION(0.01)[];
	ASN(0.00)[asn:151847, ipnet:103.168.172.0/24, country:AU];
	RCPT_COUNT_TWELVE(0.00)[15];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	DWL_DNSWL_NONE(0.00)[messagingengine.com:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	URIBL_BLOCKED(0.00)[arndb.de:dkim,fout-a5-smtp.messagingengine.com:helo,fout-a5-smtp.messagingengine.com:rdns];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+]
Message-ID-Hash: SEMGBCBJESEX6JW7B6C5NJIJWO3XTDVK
X-Message-ID-Hash: SEMGBCBJESEX6JW7B6C5NJIJWO3XTDVK
X-MailFrom: arnd@arndb.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>, Etienne Carriere <etienne.carriere@foss.st.com>, Randy Dunlap <rdunlap@infradead.org>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/SEMGBCBJESEX6JW7B6C5NJIJWO3XTDVK/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Fri, Dec 5, 2025, at 14:45, Harshal Dev wrote:
> On 12/4/2025 6:57 PM, Jens Wiklander wrote:
>> On Thu, Dec 4, 2025 at 11:17=E2=80=AFAM Arnd Bergmann <arnd@kernel.or=
g> wrote:
>>=20
> The only user-space client which is currently using this ABI (as per=20
> our knowledge)
> is the libqcomtee library:=20
> https://github.com/quic/quic-teec/blob/main/libqcomtee/src/linux/tee.h=
#L432
>
> If I understand Arnd's concern correctly, if a compiler used to build=20
> the user-space
> client skips the padding for tee_ioctl_object_invoke_arg, it could lea=
d=20
> to issues.
>
> Let's wait for Amir's view here as well, however I do think the=20
> explicit padding would
> benefit here.
>

The problem is much narrower: as the amount of padding is determined
by the architecture specific ABI, kernel and userspace on the same
architecture always agree, and specifically 32-bit Arm userspace
and 64-bit Arm userspace (aarch64) also have the same rules, so there
is no problem on Qualcomm's platforms even with compat 32-bit userspace.

The only actual ABI problem would happen on 32-bit x86 (i386)
userspace running on a 64-bit x86 kernel, since i386-linux compilers
have different alignment rules from most other architectures.

        Arnd
