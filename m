Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188BDD3B7E2
	for <op-tee@archiver.kernel.org>; Mon,  8 Dec 2025 12:21:19 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5F5B545868
	for <op-tee@archiver.kernel.org>; Mon,  8 Dec 2025 12:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765196478;
	bh=SQ2Ltx1fX0tqMHPqETbN7r50RKAAZMfBVR1CjXlyZEs=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=5FXaaEH9OEL/cW4vNTlFi556Y99iuGxQUqZ36jdk1Wp3qzUbfMntEHMh0yIyV6LFk
	 P5cexelQFyGbiuE7xSrucipCjabAo9QEZxFA324A6qRNI4lvEF3vQ4WIZ8oNaGsibb
	 4Mc+1U0351NgOVcKu8xgpWUaHXb3GnR2DOylbgsdekwV1CRutdsd+b0N7ksGHhc5Wu
	 uE0uvwycCEgUwbHsdEfp0b+p9eyFNDNsIYjPovyiONY4VLl+y6JA9RXyKg2KrWhGSF
	 5Vu0h3pj+gqnk1rfYCLbUxuZz3cTdLuv6Q7Iheo6pNpYtABd/o0NDxtt54w6GLOZqn
	 XVVxViKTOwAfQ==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 54D3543156
	for <op-tee@lists.trustedfirmware.org>; Mon,  8 Dec 2025 12:21:06 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=I73R2iUT;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9E7F941927;
	Mon,  8 Dec 2025 12:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A17C4CEF1;
	Mon,  8 Dec 2025 12:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765196465;
	bh=MusA/V6Dt1xIa+tAeGx/rsU9JoqhBv1Pt0IFS+iUlt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I73R2iUTYqY+LLPDBJPugFCa+aeAt8i26sfs20t1x+Xv8tnpUQiGCiQ3Zf63BPR/b
	 dHoei1+iKxNo21SQAIGYg8cBzf9y7yC7XLSZo6v9CQYwvvlKyCko32nRs/bkmnK5fd
	 GdYGW+vpgnG3mIOV/VIHzJzk1BVO4QCKaCQ1u7Iw41nJZfFDI6R/Wwj3fw2rHPos4y
	 YD861NKUk6eU0wuuUjbVoa3YQX2U/ORUXDWPbVKqWRdPu5gOHP3lqzjX1iafWM5lrx
	 ulO+BFok/jYE7zvrQXAD7nQlotgjPfQLXMgpYgVohjs9GFM+WVgA7/o3kgwzvCevRZ
	 Up1IopKmhFzcA==
Date: Mon, 8 Dec 2025 17:50:59 +0530
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Subject: Re: [PATCH] tee: fix tee_ioctl_object_invoke_arg padding
Message-ID: <aTbCqyOuprPOyU4X@sumit-X1>
References: <20251204101730.1036671-1-arnd@kernel.org>
 <CAHUa44H1Ejbbuzr1hF1HrT69JGgnvfkkDkh+9KvEvBT+eWBDhw@mail.gmail.com>
 <0b061075-ab71-4ac1-93ec-438ddaaec903@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <0b061075-ab71-4ac1-93ec-438ddaaec903@oss.qualcomm.com>
X-Spamd-Bar: ---
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 54D3543156
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[99.98%];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
Message-ID-Hash: BLWEBVCAYKHXO32MYNZEFLOIA355NLUR
X-Message-ID-Hash: BLWEBVCAYKHXO32MYNZEFLOIA355NLUR
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Arnd Bergmann <arnd@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Sumit Garg <sumit.garg@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, Alexandre Ghiti <alex@ghiti.fr>, Etienne Carriere <etienne.carriere@foss.st.com>, Randy Dunlap <rdunlap@infradead.org>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/BLWEBVCAYKHXO32MYNZEFLOIA355NLUR/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

T24gTW9uLCBEZWMgMDgsIDIwMjUgYXQgMDQ6MjQ6MTdQTSArMTEwMCwgQW1pcnJlemEgWmFycmFi
aSB3cm90ZToNCj4gSGksDQo+IA0KPiBPbiAxMi81LzIwMjUgMTI6MjcgQU0sIEplbnMgV2lrbGFu
ZGVyIHdyb3RlOg0KPiA+IEhpLA0KPiA+IA0KPiA+IE9uIFRodSwgRGVjIDQsIDIwMjUgYXQgMTE6
MTfigK9BTSBBcm5kIEJlcmdtYW5uIDxhcm5kQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+Pg0KPiA+
PiBGcm9tOiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPg0KPiA+Pg0KPiA+PiBUaGUgdGVl
X2lvY3RsX29iamVjdF9pbnZva2VfYXJnIHN0cnVjdHVyZSBoYXMgcGFkZGluZyBvbiBzb21lDQo+
ID4+IGFyY2hpdGVjdHVyZXMgYnV0IG5vdCBvbiB4ODYtMzIgYW5kIGEgZmV3IG90aGVyczoNCj4g
Pj4NCj4gPj4gaW5jbHVkZS9saW51eC90ZWUuaDo0NzQ6MzI6IGVycm9yOiBwYWRkaW5nIHN0cnVj
dCB0byBhbGlnbiAncGFyYW1zJyBbLVdlcnJvcj1wYWRkZWRdDQo+ID4+DQo+ID4+IEkgZXhwZWN0
IHRoYXQgYWxsIGN1cnJlbnQgdXNlcnMgb2YgdGhpcyBhcmUgb24gYXJjaGl0ZWN0dXJlcyB0aGF0
IGRvDQo+ID4+IGhhdmUgaW1wbGljaXQgcGFkZGluZyBoZXJlIChhcm02NCwgYXJtLCB4ODYsIHJp
c2N2KSwgc28gbWFrZSB0aGUgcGFkZGluZw0KPiA+PiBleHBsaWNpdCBpbiBvcmRlciB0byBhdm9p
ZCBzdXJwcmlzZXMgaWYgdGhpcyBsYXRlciBnZXRzIHVzZWQgZWxzZXdoZXJlLg0KPiA+Pg0KPiA+
PiBGaXhlczogZDViOGIwZmExNzc1ICgidGVlOiBhZGQgVEVFX0lPQ1RMX1BBUkFNX0FUVFJfVFlQ
RV9PQkpSRUYiKQ0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRi
LmRlPg0KPiA+PiAtLS0NCj4gPj4gVGhlIG5ldyBpbnRlcmZhY2Ugc2hvd2VkIHVwIGluIDYuMTgs
IGJ1dCBJIG9ubHkgY2FtZSBhY3Jvc3MgdGhpcyBhZnRlcg0KPiA+PiB0aGF0IHdhcyByZWxlYXNl
ZC4gQ2hhbmdpbmcgaXQgbm93IGlzIHRlY2huaWNhbGx5IGFuIEFCSSBjaGFuZ2Ugb24NCj4gPj4g
YXJjaGl0ZWN0dXJlcyB3aXRoIHVudXN1YWwgcGFkZGluZyBydWxlcywgc28gcGxlYXNlIGNvbnNp
ZGVyIGNhcmVmdWxseQ0KPiA+PiB3aGV0aGVyIHdlIHdhbnQgdG8gZG8gaXQgdGhpcyB3YXkgb3Ig
bm90Lg0KPiA+Pg0KPiA+PiBXb3JraW5nIGFyb3VuZCB0aGUgQUJJIGRpZmZlcmVuY2VzIHdpdGhv
dXQgYW4gQUJJIGNoYW5nZSBpcyBwb3NzaWJsZSwNCj4gPj4gYnV0IGFkZHMgYSBsb3Qgb2YgY29t
cGxleGl0eSBmb3IgY29tcGF0IGhhbmRsaW5nLg0KPiA+IA0KPiA+IFRoaXMgaXMgY3VycmVudGx5
IG9ubHkgdXNlZCBieSB0aGUgcmVjZW50bHkgaW50cm9kdWNlZCBxY29tdGVlIGJhY2tlbmQNCj4g
PiBkcml2ZXIuIFNvIGl0J3Mgb25seSB1c2VkIG9uIGEgZmV3IGFybTY0IFF1YWxjb21tIHBsYXRm
b3JtcyByaWdodCBub3cuDQo+ID4gDQo+ID4gSSB0aGluayB3ZSBzaG91bGQgdGFrZSB0aGlzIHBh
dGNoLCBidXQgbGV0J3MgaGVhciB3aGF0IG90aGVycyB0aGluay4NCg0KWWVhaCBzaW5jZSBpdCdz
IG5vdCBhbiBBQkkgaXNzdWUgb24gYXJtNjQgcGxhdGZvcm1zIHdoZXJlIFFURUUgcnVucywgc286
DQoNClJldmlld2VkLWJ5OiBTdW1pdCBHYXJnIDxzdW1pdC5nYXJnQG9zcy5xdWFsY29tbS5jb20+
DQoNCj4gPiANCj4gPiBUaGFua3MsDQo+ID4gSmVucw0KPiA+IA0KPiANCj4gSSBhZ3JlZS4gV2Ug
c2hvdWxkIHRha2UgdGhpcyBwYXRjaC4gQXMgbm90ZWQsIHRoZXJlIGFyZSBub3QgbWFueQ0KPiBj
bGllbnRzIHJlbHlpbmcgb24gaXQgeWV0LCBzbyB1cGRhdGluZyB0aGUgdXNlcnNwYWNlIHNob3Vs
ZA0KPiBiZSBzdHJhaWdodGZvcndhcmQuDQoNCllvdSBzaG91bGQgcmF0aGVyIHRlc3Qgd2l0aG91
dCBhbnkgdXNlcnNwYWNlIGxpYnJhcnkgdXBkYXRlIHRvIHRlc3QgaXQncw0Kbm90IGFuIEFCSSBp
c3N1ZS4gSnVzdCBmb3IgY29ycmVjdG5lc3Mgc2FrZSwgeW91IGNhbiB1cGRhdGUgdGhlIGxpYnJh
cnkNCnRvby4NCg0KLVN1bWl0DQoNClsuLi5dDQo=
