Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20C4606A326
	for <op-tee@archiver.kernel.org>; Fri,  6 Nov 2026 10:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=GuYAljA2;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2m6k6Gq
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3B3F643E4A
	for <op-tee@archiver.kernel.org>; Fri,  6 Nov 2026 10:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1793960320;
	bh=9o4Jdr2FSWanvgS8egHHalc/SAABTU224Ld5B1ETUzg=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=GuYAljA2omNiHj/NcuWMRJo3EEJ2liyK7W/emoXkOEtZMAxRJp0qZKLy+FsgSvCOE
	 aOZfvjzPsNM83Ax0H8n2gZ+0dOu5sOl3nm0zG/agSsGvQ8Jz1hBVvrphTBf27H4M0B
	 h0XkeSwhVA8wg/yCaZ40eSF27wmAaMd0+TFgFAEKdB9w+PvXkBf3O0ZF1F4r1gfmVE
	 5/OHIvPnxsvhEWKe8G4xemqQMWn5tWOIYSeF19QJ6piDPacJTeABCngUbs1OD2/af6
	 llXUw8l0+UgHIIZ8AE+W0o0I7BQEGqxVb8H9hjSz8G+ZBVLTMORJarYW5OuNuFxBNW
	 i2i+02NJ66gGQ==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2C24F43E4A
	for <op-tee@lists.trustedfirmware.org>; Fri,  6 Nov 2026 10:18:21 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2m6k6Gq;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8C69A601BF;
	Fri,  6 Nov 2026 10:18:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CFC01F0089F;
	Fri,  6 Nov 2026 10:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793960300;
	bh=WRJXIR3G73/bAoeCrNJcFgak4mvp+3ngQ+qpnIKUqWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l2m6k6GqXZKAI6ai2Tun1aF46awXpI/z2hhpm9C9mWFFrwb28EgYdeM12++TFdXHC
	 tZPDcNtqorI1JgQeh4d/V0oUoA8wTmUuwUWJnczsn3SnNHjwPhjBcdo7A1YGDV2mTG
	 KcYpC48NxWmRQWs88tJMsCh3bVG0uv6meLjHSwr1ICrXX3Vw/iw6HMzgoNOlCZ+Cr/
	 4yqxl3LXfTuCElZyaokutxEyEknbHWSUP2DCjtT8OlSb46KYExKXDg1tVpuuXc3j/i
	 oBl8kAvxU+cGtuwjokkyklXwgQ5yXoGFuePAoE1OqzN7B+weZmt4UCKvb6LGDNbMBE
	 27H/f4pFzu1cw==
Date: Fri, 6 Nov 2026 10:18:06 +0000
To: Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH 00/14] mm: convert further simple mmap hooks to
 mmap_prepare
Message-ID: <au2odtvEhpLJY4eD@gremlin>
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org>
 <CAHC9VhQvpFeEJaEyPDaqj8_S752puSaNe0Rn-hxjh=ugCoFsxA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <CAHC9VhQvpFeEJaEyPDaqj8_S752puSaNe0Rn-hxjh=ugCoFsxA@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.68 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-2.98)[99.93%];
	SUSPICIOUS_RECIPS(1.50)[];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	RCVD_IN_DNSWL_MED(-0.20)[172.105.4.254:from];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,kernel.org,epam.com,linux.ibm.com,gmail.com,ellerman.id.au,microsoft.com,redhat.com,linux.alibaba.com,linux.intel.com,alien8.de,zytor.com,jms.id.au,codeconstruct.com.au,aspeedtech.com,broadcom.com,arndb.de,linuxfoundation.org,infradead.org,lunn.ch,davemloft.net,lists.xenproject.org,vger.kernel.org,lists.ozlabs.org,lists.linux.dev,lists.infradead.org,lists.trustedfirmware.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[60];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 2C24F43E4A
X-Spamd-Bar: -----
Message-ID-Hash: GD5ZBKTCOYFA6D2SRXVKRHP2QEMEW7N6
X-Message-ID-Hash: GD5ZBKTCOYFA6D2SRXVKRHP2QEMEW7N6
X-MailFrom: ljs@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej =?utf-8?B?TW9zbsOhxI
 1law==?= <omosnacek@gmail.com>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Scott Branden <scott.branden@broadcom.com>, Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Richard Cochran <richardcochran@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, virtualization@
 lists.linux.dev, linux-sgx@vger.kernel.org, selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/GD5ZBKTCOYFA6D2SRXVKRHP2QEMEW7N6/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: "Lorenzo Stoakes (ARM) via OP-TEE" <op-tee@lists.trustedfirmware.org>
Reply-To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAD_ENC_HEADER,BAYES_00,
	DKIM_INVALID,DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVGh1LCBOb3YgMDUsIDIwMjYgYXQgMDY6MTI6MDlQTSAtMDUwMCwgUGF1bCBNb29yZSB3cm90
ZToNCj4gT24gVGh1LCBOb3YgNSwgMjAyNiBhdCA0OjA24oCvUE0gTG9yZW56byBTdG9ha2VzIChB
Uk0pIDxsanNAa2VybmVsLm9yZz4gd3JvdGU6DQo+ID4NCj4gPiBDb250aW51ZSB0aGUgY29udmVy
c2lvbiBvZiB1c2VycyBvZiB0aGUgZGVwcmVjYXRlZCBmX29wLT5tbWFwIGNhbGxiYWNrIHRvDQo+
ID4gZl9vcC0+bW1hcF9wcmVwYXJlLiBLZWVwIHRoaW5ncyBnZW50bGUgdGhpcyBjeWNsZSBieSB0
YXJnZXRpbmcgc2ltcGxlDQo+ID4gY2FzZXMuDQo+ID4NCj4gPiBObyBmdW5jdGlvbmFsIGNoYW5n
ZSBpbnRlbmRlZC4NCj4gPg0KPiA+IEJ1aWxkIHRlc3RlZCBvbiB4ODYtNjQgKGFsbG1vZGNvbmZp
ZywgZWFjaCBwYXRjaCBpbmRpdmlkdWFsbHkpLCBpMzg2LA0KPiA+IGFybTY0IGFuZCBwcGM2NGxl
Lg0KPiA+DQo+ID4gPDw+Pg0KPiA+DQo+ID4gRGF2aWQsIEFuZHJldyAtIEkgd29uZGVyIHdoZXRo
ZXIgb25lIG9mIHlvdSBndXlzIGNvdWxkIHRha2UgdGhpcyBzZXJpZXMNCj4gPiB0aHJvdWdoIHlv
dXIgdHJlZT8gU2luY2UgaXQncyBrZXJuZWwtd2lkZSBpdCBzZWVtcyBzZW5zaWJsZSB0byB0YWtl
IGl0DQo+ID4gdGhyb3VnaCBhbiBtbSB0cmVlLg0KPg0KPiBHcmFudGVkIEkndmUgb25seSBwcm9w
ZXJseSBsb29rZWQgYXQgdGhlIFNFTGludXggcGF0Y2ggKDcvMTQpLCB0aGUNCj4gcmVzdCBJJ3Zl
IGp1c3Qgc2tpbW1lZCB0aHJvdWdoLCBidXQgdGhlc2UgYXJlIGFsbCBpbmRlcGVuZGVudCBwYXRj
aGVzLA0KPiByaWdodD8gIElzIHRoZXJlIGFueSByZWFzb24gd2h5IGluZGl2aWR1YWwgc3Vic3lz
dGVtIG1haW50YWluZXJzDQo+IHNob3VsZG4ndCBqdXN0IHBpY2sgdXAgdGhlaXIgYXNzb2NpYXRl
ZCBwYXRjaD8gIFllcywgcGVyaGFwcyBjaGFzaW5nDQo+IGRvd24gaW5kaXZpZHVhbCBtYWludGFp
bmVycyBpcyBhIGJpdCBtb3JlIHdvcmssIGJ1dCBpc24ndCB0aGF0IHRoZSB3YXkNCj4gdGhpcyBz
aG91bGQgd29yaz8NCg0KSSd2ZSBubyBvYmplY3Rpb24gdG8gcGVvcGxlIHRha2luZyBwYXRjaGVz
IGluZGVwZW5kZW50bHksIHRoZSBjb25jZXJuIGlzIHBlb3BsZQ0KbGFnZ2luZyBvbiB0aGF0IGFu
ZCBob2xkaW5nIHVwIGEga2V5IGNvbnZlcnNpb24gd2hpY2ggaXMgZW50aXJlbHkgbWVjaGFuaWNh
bCwgKw0KZ2VuZXJhbGx5IHRyZWUtd2lkZSBzdHVmZiBsaWtlIHRoaXMgaGFzIGJlZW4gdmlhIHRo
ZSBtbSB0cmVlLg0KDQpUaGUgbW1hcF9wcmVwYXJlIHN0dWZmIGlzIGFjdHVhbGx5IGltcG9ydGFu
dCBmb3Igc2VjdXJpdHkgKHBlcnRpbmVudCBnaXZlbg0KY3VycmVudCBBSSBmaXggc3Rvcm0pIGFz
IGl0J3MgYnkgZGVzaWduIHN1cGVyIGxvY2tlZCBkb3duIHZzLiBtbWFwIHdoaWNoIGhhcw0KY2F1
c2VkIHNldmVyYWwgZ2VudWluZSBpc3N1ZXMgaW5jbHVkaW5nIGEgbmFzdHkgMC1kYXkuDQoNClNv
IGFtIGtlZW4gdG8ga2VlcCB0aGF0IHJvbGxpbmchDQoNCkluIHRoaXMgY2FzZSBlYWNoIHBhdGNo
IGlzIG1lY2hhbmljYWwgYW5kIHNpbXBsZSwgc28gbGl0dGxlIHN1cmZhY2UgYXJlYSBmb3INCmlz
c3Vlcy4NCg0KLS0NCkNoZWVycywgTG9yZW56bw0K
