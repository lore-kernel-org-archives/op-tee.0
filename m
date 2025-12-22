Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7196BE6748D
	for <op-tee@archiver.kernel.org>; Mon, 22 Dec 2025 10:07:53 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A53CB44905
	for <op-tee@archiver.kernel.org>; Mon, 22 Dec 2025 10:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1766398072;
	bh=Op3C8Dp26A+zsgPtQ7V+RaS6HBCIZ7wOC/G4Q6bOLcw=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=O4ckD+hE0c6ZTOCItkJuvwP113VdpMMGtU5MUpcsDKAMJwNMXbdsk9347M9dqABcy
	 aqvoo0NvnHNAybvcPT/aO05apmCy9Q61LMSn3fRpGooCFqDwCdwG4ThUgJ0oZkAbPH
	 nkLc4VjiHDIrgvB0SruyDfLZWvbTJdI8mKGdlfOPlKyAuWYsLIvyVuA0zhYLqm7tOG
	 pJ9dW7c78Sxt6S1aEUrzbp1Qt+8g6lnVWMkgyI62kmAd04zjLrnoTlregxIp1+DLHE
	 qdg3zqvuuxLJ1UduCBuSMlSxeisq2DBA+oYXoltjmm/CzbW7/obppL8Bokr8o8Ef0i
	 UWo23crJNDFoA==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7356341B5A
	for <op-tee@lists.trustedfirmware.org>; Mon, 22 Dec 2025 10:07:32 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pSSyG/4+;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 02B056001D;
	Mon, 22 Dec 2025 10:07:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D504C4CEF1;
	Mon, 22 Dec 2025 10:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766398051;
	bh=vR7MvzdDeRVQZr2cC/AFaerrmSj5XSjNB3xtBV9n+QE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pSSyG/4+mke5tzNmdczpYaIJ62ODcF1HypyjcYtqd9jOE93taqoiJn58xXhF75YC9
	 QQghy295tiNIRhclKCznU4uAm9kLhwhUU/Ig6KFtvIUzLVPwPBVxNVnhJ0bGFKMnnZ
	 DJSmjXxRrxhORLU95iCOmZjjSM94Mq1KOlS+/0PrkbbF6JRuVubuOEtSQBf+XRvS2w
	 peTcH3z60ewBQPf3tkrdR7vhBllqAFV0K+uxUDSBgdd2gsJoh9Z2GGNMx2ivh078fN
	 NqpTmIcLE5Hvs+xSOD8fy/1VjEq4LXahqrNDsG4l0q+74OHKwA9yfbV55amAfoefF6
	 Oa+rorh6ocsTg==
Date: Mon, 22 Dec 2025 15:37:24 +0530
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH v2 1/1] tee: optee: expose OS revision via sysfs
Message-ID: <aUkYXBz3XfVGrmjD@sumit-xelite>
References: <aSVgctqRSy5_vvkN@sumit-X1>
 <aSVhBn0LR2CwM9p3@sumit-X1>
 <CAJwFiGKuSuiq5LhMS+wVcnhjfiBEDiSCOG9FwhEic+cxmnKJhQ@mail.gmail.com>
 <CAHUa44HUFPy24wZrA03z0KHZqUmbT+dSP+7zOT-zrrFq_-h8mg@mail.gmail.com>
 <CAJwFiGLRVZyr7Hb3PtGyA319hCYEJh9t8XY_amyjhUgqnrZycQ@mail.gmail.com>
 <CAHUa44GPuP+qdw2HPBgtrQNXovA7e5+yskrPRgh4D4OMutEJTA@mail.gmail.com>
 <CAJwFiGLNh-qu9ezQOmTBh3Dujf=mPRyzKBVXLV-A=GxhwcH-0w@mail.gmail.com>
 <CAHUa44Eq=P5G4vKSq5TyJx5qF9E5q=+pHexMg41X85NCX4SpHA@mail.gmail.com>
 <CAJwFiGKw8+T3v3H+=bBtWzV1kuXKBq9gRTWGpS4iS4ictWOAtA@mail.gmail.com>
 <CAHUa44ELXMv+e8dkZ=NwYjg=YoH=1=4JGze89BK+Db8ERozPLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
In-Reply-To: <CAHUa44ELXMv+e8dkZ=NwYjg=YoH=1=4JGze89BK+Db8ERozPLg@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.trustedfirmware.org,oss.qualcomm.com,canonical.com,amd.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DNSWL_BLOCKED(0.00)[172.105.4.254:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 7356341B5A
X-Spamd-Bar: ----
Message-ID-Hash: KNQAIFZOZ7V73H2J2CZNRR5XVZ2KI6WE
X-Message-ID-Hash: KNQAIFZOZ7V73H2J2CZNRR5XVZ2KI6WE
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Aristo Chen <jj251510319013@gmail.com>, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, harshal.dev@oss.qualcomm.com, Aristo Chen <aristo.chen@canonical.com>, mario.limonciello@amd.com, Rijo Thomas <Rijo-john.Thomas@amd.com>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/KNQAIFZOZ7V73H2J2CZNRR5XVZ2KI6WE/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

T24gTW9uLCBEZWMgMjIsIDIwMjUgYXQgMDk6MzQ6MjRBTSArMDEwMCwgSmVucyBXaWtsYW5kZXIg
d3JvdGU6DQo+IEhpIEFyaXN0bywNCj4gDQo+IE9uIEZyaSwgRGVjIDE5LCAyMDI1IGF0IDQ6Mzni
gK9QTSBBcmlzdG8gQ2hlbiA8amoyNTE1MTAzMTkwMTNAZ21haWwuY29tPiB3cm90ZToNCj4gPg0K
PiA+IEhpIEplbnMNCj4gPg0KPiA+IEplbnMgV2lrbGFuZGVyIDxqZW5zLndpa2xhbmRlckBsaW5h
cm8ub3JnPiDmlrwgMjAyNeW5tDEy5pyIOeaXpemAseS6jCDkuIvljYg0OjMx5a+r6YGT77yaDQo+
ID4gPg0KPiA+ID4gSGkgQXJpc3RvLA0KPiA+ID4NCj4gPiA+IE9uIFN1biwgRGVjIDcsIDIwMjUg
YXQgMzowMeKAr1BNIEFyaXN0byBDaGVuIDxqajI1MTUxMDMxOTAxM0BnbWFpbC5jb20+IHdyb3Rl
Og0KPiA+ID4gPg0KPiA+ID4gPiBIaSBKZW5zLA0KPiA+ID4gPg0KPiA+ID4gPiBKZW5zIFdpa2xh
bmRlciA8amVucy53aWtsYW5kZXJAbGluYXJvLm9yZz4g5pa8IDIwMjXlubQxMuaciDPml6XpgLHk
uIkg5LiL5Y2IMzo1MeWvq+mBk++8mg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSGksDQo+ID4gPiA+
ID4NCj4gPiA+ID4gPiBPbiBUdWUsIERlYyAyLCAyMDI1IGF0IDEwOjU04oCvQU0gQXJpc3RvIENo
ZW4gPGpqMjUxNTEwMzE5MDEzQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4gPg0KPiA+ID4g
PiA+ID4gSGkgSmVucw0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEplbnMgV2lrbGFuZGVyIDxq
ZW5zLndpa2xhbmRlckBsaW5hcm8ub3JnPiDmlrwgMjAyNeW5tDEy5pyIMeaXpemAseS4gCDkuIvl
jYg5OjA25a+r6YGT77yaDQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IEhpLA0KPiA+ID4g
PiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBPbiBNb24sIERlYyAxLCAyMDI1IGF0IDEyOjQ44oCvUE0g
QXJpc3RvIENoZW4gPGpqMjUxNTEwMzE5MDEzQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4g
PiA+ID4NCj4gPiA+ID4gPiA+ID4gPiBIaSwNCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4g
PiA+IFN1bWl0IEdhcmcgPHN1bWl0LmdhcmdAa2VybmVsLm9yZz4g5pa8IDIwMjXlubQxMeaciDI1
5pel6YCx5LqMIOS4i+WNiDM6NTXlr6vpgZPvvJoNCj4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+
ID4gPiA+ID4gPiBPbiBUdWUsIE5vdiAyNSwgMjAyNSBhdCAwMToyMzoyMlBNICswNTMwLCBTdW1p
dCBHYXJnIHZpYSBPUC1URUUgd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4gPiA+IE9uIE1vbiwgTm92
IDI0LCAyMDI1IGF0IDA4OjE1OjA0QU0gKzAxMDAsIEplbnMgV2lrbGFuZGVyIHdyb3RlOg0KPiA+
ID4gPiA+ID4gPiA+ID4gPiA+IEhpLA0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gT24gU2F0LCBOb3YgMjIsIDIwMjUgYXQgNDowMOKAr1BNIFdlaSBNaW5nIENo
ZW4gPGpqMjUxNTEwMzE5MDEzQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gRnJvbTogQXJpc3RvIENoZW4gPGFyaXN0by5j
aGVuQGNhbm9uaWNhbC5jb20+DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gVG9kYXkgdGhlIG9ubHkgd2F5IHRvIHJlYWQgdGhlIE9QLVRFRSBPUyB2ZXJz
aW9uIGlzIGZyb20gZG1lc2cvam91cm5hbA0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gbG9ncywg
d2hpY2ggY2FuIGJlIGxvc3QgYXMgYnVmZmVycyByb2xsIG92ZXIuIENhcHR1cmUgdGhlIE9TIHJl
dmlzaW9uDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAobWFqb3IvbWlub3IvYnVpbGRfaWQpIGZy
b20gc2VjdXJlIHdvcmxkIGZvciBib3RoIFNNQyBhbmQgRkYtQSBBQklzLCBzdG9yZQ0KPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gaXQgaW4gdGhlIE9QLVRFRSBkcml2ZXIsIGFuZCBleHBvc2UgYSBz
dGFibGUgdXNlcnNwYWNlIHJlYWRvdXQgdmlhDQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAvc3lz
L2NsYXNzL3RlZS90ZWUqL29wdGVlX29zX3JldmlzaW9uLg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEFyaXN0byBDaGVuIDxh
cmlzdG8uY2hlbkBjYW5vbmljYWwuY29tPg0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gLS0tDQo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAgZHJpdmVycy90ZWUvb3B0ZWUvY29yZS5jICAgICAgICAg
IHwgMTkgKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gIGRyaXZl
cnMvdGVlL29wdGVlL2ZmYV9hYmkuYyAgICAgICB8IDEzICsrKysrKysrKysrLS0NCj4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ICBkcml2ZXJzL3RlZS9vcHRlZS9vcHRlZV9wcml2YXRlLmggfCAxNyAr
KysrKysrKysrKysrKysrKw0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gIGRyaXZlcnMvdGVlL29w
dGVlL3NtY19hYmkuYyAgICAgICB8IDEzICsrKysrKysrKysrLS0NCj4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDU4IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0p
DQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBUaGlzIGFwcGVh
cnMgdG8gYmUgYSBmZWF0dXJlIHRoYXQgY291bGQgYmUgdXNlZnVsIGZvciBhbGwgVEVFcy4NCj4g
PiA+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiA+ID4gVHJ1ZSwgaXQgaXMgc29tZXRo
aW5nIHRoYXQgVEVFIGNvcmUgc2hvdWxkIHN1cHBvcnQuIEFsdGhvdWdoIEkgd291bGQNCj4gPiA+
ID4gPiA+ID4gPiA+ID4gaGF2ZSBwcmVmZXJyZWQgdG8gZXh0ZW5kIFRFRV9JT0NfVkVSU0lPTiBz
aW5jZSB0aGF0J3MgdGhlIGNvbW1vbiB3YXkgdGhlDQo+ID4gPiA+ID4gPiA+ID4gPiA+IHVzZXIt
c3BhY2UgbGlicmFyeSBnZXQncyBURUUgaW1wbGVtZW50YXRpb24gc3BlY2lmaWMgaW5mb3JtYXRp
b24uIEJ1dA0KPiA+ID4gPiA+ID4gPiA+ID4gPiBzaW5jZSBpdCBiZWluZyBhbHJlYWR5IGEgdXNl
ci1zcGFjZSBBQkkgd2hpY2ggZG9lc24ndCBvZmZlciBleHRlbnNpb24uDQo+ID4gPiA+ID4gPiA+
ID4gPiA+IE1heWJlIHdlIGNhbiBjb25zaWRlciBhZGRpbmcgVEVFX0lPQ19SRVZFUlNJT04gaW5z
dGVhZCBvZiBzeXNmcy4NCj4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPiBBaCwg
dHlwbyBoZXJlOg0KPiA+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiA+IHMvVEVFX0lP
Q19SRVZFUlNJT04vVEVFX0lPQ19SRVZJU0lPTi8NCj4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+
ID4gPiA+ID4gPiAtU3VtaXQNCj4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiA+ID4gPiA+IEJ1dCBiZWZvcmUgZG9pbmcgdGhhdCB3ZSBuZWVkIHRvIGtu
b3cgd2hvIGlzIHRoZSBhY3R1YWwgY29uc3VtZXIgaGVyZQ0KPiA+ID4gPiA+ID4gPiA+ID4gPiBm
cm9tIHVzZXItc3BhY2UgcGVyc3BlY3RpdmU/IFdpbGwgdGhlIGNsaWVudCBhcHBsaWNhdGlvbnMg
YWxzbyBkZXBlbmQgb24NCj4gPiA+ID4gPiA+ID4gPiA+ID4gdGhlIFRFRSBpbXBsZW1lbnRhdGlv
biByZXZpc2lvbj8NCj4gPiA+ID4gPiA+ID4gPiBNeSBjdXJyZW50IHRoaW5raW5nIGlzIHRoYXQg
aWYgdGhlIFRFRSByZXZpc2lvbiBpcyBleHBvc2VkLCB1c2VycyBjYW4gd3JpdGUgYQ0KPiA+ID4g
PiA+ID4gPiA+IHNjcmlwdCB0byBjYXB0dXJlIHRoZSBwbGF0Zm9ybSBzdGF0ZSBhbmQgcmVjb3Jk
IHRoZSBleGFjdCBzZWN1cmUgT1MgcmV2aXNpb24NCj4gPiA+ID4gPiA+ID4gPiBldmVuIGFmdGVy
IHRoZSBkbWVzZy9qb3VybmFsY3RsIGxvZ3MgaGF2ZSByb2xsZWQgb3Zlci4gVGhpcyB3b3VsZCBz
aWduaWZpY2FudGx5DQo+ID4gPiA+ID4gPiA+ID4gaW1wcm92ZSBidWcgdHJpYWdlIGFuZCByZWdy
ZXNzaW9uIHRyYWNraW5nLg0KPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gSW4gbXkg
Y2FzZSwgSSBoYXZlIGEgcGFja2FnZSB3aXRoIHByZWNvbXBpbGVkIHh0ZXN0IGJpbmFyaWVzIGZv
ciBtdWx0aXBsZQ0KPiA+ID4gPiA+ID4gPiA+IHJlbGVhc2VzIChmcm9tIDMuMTQgdG8gNC42KSwg
YW5kIEkgd29yayB3aXRoIGRpZmZlcmVudCBwbGF0Zm9ybXMgdGhhdCBydW4NCj4gPiA+ID4gPiA+
ID4gPiBkaWZmZXJlbnQgT1AtVEVFIE9TIHZlcnNpb25zLiBIYXZpbmcgYSByZWxpYWJsZSB3YXkg
dG8gb2J0YWluIHRoZSBURUUNCj4gPiA+ID4gPiA+ID4gPiByZXZpc2lvbiB3b3VsZCBoZWxwIGEg
bG90LCBhcyBpdCB3b3VsZCBhbGxvdyBtZSB0byBzZWxlY3QgdGhlIGNvcnJlY3QgeHRlc3QNCj4g
PiA+ID4gPiA+ID4gPiB2ZXJzaW9uIHdoZW4gcnVubmluZyB0ZXN0cy4NCj4gPiA+ID4gPiA+ID4N
Cj4gPiA+ID4gPiA+ID4gSSdtIGNvbmNlcm5lZCB0aGF0IHRoZSBBQkkgbWlnaHQgYmUgbWlzdXNl
ZCB0byBiZSBwYXJ0IG9mIHdoYXQgdGhlDQo+ID4gPiA+ID4gPiA+IGNsaWVudCBleHBlY3RzIGZy
b20gdGhlIFRFRS4gWW91IGV2ZW4gZXhwcmVzcyB0aGF0IGFzIGEgdXNlIGNhc2UuIEknZA0KPiA+
ID4gPiA+ID4gPiByYXRoZXIgZml4IHRoZSBwcm9ibGVtIHdpdGggeHRlc3QuDQo+ID4gPiA+ID4g
Pg0KPiA+ID4gPiA+ID4gVGhhbmtzIGZvciB0aGUgZmVlZGJhY2shIFRvIGNsYXJpZnk6IGN1cnJl
bnRseSwgdGhlIE9QLVRFRSBPUyByZXZpc2lvbg0KPiA+ID4gPiA+ID4gSSBleHBvc2UgaW4NCj4g
PiA+ID4gPiA+IHN5c2ZzIGlzIHRoZSBzYW1lIHZhbHVlIGFscmVhZHkgcHJpbnRlZCBpbiBkbWVz
ZyBhdCBib290DQo+ID4gPiA+ID4gPiAgKGUuZy4sIOKAnG9wdGVlOiByZXZpc2lvbiA0LjggKFhY
WFhYWCnigJ0pLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEFyZSB5b3VyIGNvbmNlcm5zIHNw
ZWNpZmljYWxseSBhYm91dCBjbGllbnRzIGluZmVycmluZyBjYXBhYmlsaXRpZXMNCj4gPiA+ID4g
PiA+IGZyb20gYSByZXZpc2lvbg0KPiA+ID4gPiA+ID4gc3RyaW5nICjigJxyZXYgWC5ZIGltcGxp
ZXMgZmVhdHVyZSBa4oCdKT8gSWYgc28sIEkgYWdyZWUgdGhhdOKAmXMgZnJhZ2lsZQ0KPiA+ID4g
PiA+ID4gYW5kIG5vdCB0aGUgaW50ZW50Lg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gWWVzDQo+ID4g
PiA+DQo+ID4gPiA+IFRoYW5rcyBmb3IgY2xhcmlmeWluZyB0aGUgY29uY2VybiENCj4gPiA+ID4N
Cj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gSeKAmW0gaGFwcHkgdG8gYWRkIGEgc2hvcnQgbm90ZSBp
biB0aGUgZG9jIHRoYXQgdGhpcyBpcyBpbmZvcm1hdGlvbmFsDQo+ID4gPiA+ID4gPiBvbmx5IGFu
ZCB0aGF0DQo+ID4gPiA+ID4gPiBmZWF0dXJlIGRldGVjdGlvbiBtdXN0IHVzZSBwcm9wZXIgY2Fw
YWJpbGl0eSBxdWVyaWVzLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFBsZWFzZSBsZXQgbWUg
a25vdyBpZiB0aGF0IGFkZHJlc3NlcyB0aGUgd29ycnksIG9yIGlmIHRoZXJl4oCZcyBhbm90aGVy
DQo+ID4gPiA+ID4gPiBjb25jZXJuIEnigJltDQo+ID4gPiA+ID4gPiBtaXNzaW5nLg0KPiA+ID4g
PiA+DQo+ID4gPiA+ID4gQWRkaW5nIEFQSXMgdGhhdCBhcmVuJ3Qgc3VwcG9zZWQgdG8gYmUgdXNl
ZCBzZWVtcyBvZGQuIERvIHlvdSBrbm93IGlmDQo+ID4gPiA+ID4gdGhlcmUgYXJlIGV4YW1wbGVz
IGluIHRoZSBrZXJuZWwgZm9yIHRoaXMga2luZCBvZiB0aGluZz8NCj4gPiA+ID4gSeKAmXZlIGRv
bmUgc29tZSByZXNlYXJjaCBhbmQsIGFzIGZhciBhcyBJIGNhbiB0ZWxsLCB0aGUgVEVFIGNvcmUg
YWxyZWFkeQ0KPiA+ID4gPiBwcm92aWRlcyBhbiBpbmZvcm1hdGlvbmFsLW9ubHkgZmlsZSBhdCAv
c3lzL2NsYXNzL3RlZS90ZWUwL2ltcGxlbWVudGF0aW9uX2lkLg0KPiA+ID4gPiBNeSB1bmRlcnN0
YW5kaW5nIGlzIHRoYXQgaXQgd2FzIGludHJvZHVjZWQgcm91Z2hseSAxMCB5ZWFycyBhZ28uIEhv
d2V2ZXIsDQo+ID4gPiA+IEkgaGF2ZW7igJl0IGZvdW5kIGFueSBkb2N1bWVudGF0aW9uIGNsYXJp
ZnlpbmcgaXRzIGludGVuZGVkIHB1cnBvc2UsIHNvIEnigJltDQo+ID4gPiA+IGFzc3VtaW5nIHRo
aXMgbWF5IGJlIGEgc2ltaWxhciBzaXR1YXRpb24uIEnigJlkIGFwcHJlY2lhdGUgaXQgaWYgeW91
IGNvdWxkIGNvcnJlY3QNCj4gPiA+ID4gbWUgaWYgSeKAmW0gd3JvbmcuDQo+ID4gPg0KPiA+ID4g
VGhhdCBvbmUgaXMgZm9yIGEgcXVpY2sgd2F5IGZvciBhIGNsaWVudCB0byB0ZWxsIHRoZSBkaWZm
ZXJlbnQgVEVFDQo+ID4gPiBkZXZpY2UgaW1wbGVtZW50YXRpb25zIGFwYXJ0LiBZb3UncmUgcmln
aHQsIGl0IHJlc2VtYmxlcyB5b3VyIGNhc2UsDQo+ID4gPiBleGNlcHQgdGhhdCB0aGlzIGlzIHBh
cnQgb2YgYSB3ZWxsLWRlZmluZWQgQUJJLg0KPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gQWxzbywg
aGVyZSBhcmUgc29tZSBmaWxlcyB3aXRoIHNpbWlsaWFyIHB1cnBvc2VzOg0KPiA+ID4gPiAtIC9z
eXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdSovbWljcm9jb2RlL3ZlcnNpb24NCj4gPiA+ID4gLSAv
c3lzL2RldmljZXMvdmlydHVhbC9kbWkvaWQve2Jpb3NfZGF0ZSxiaW9zX3JlbGVhc2UsYmlvc192
ZW5kb3IsYmlvc192ZXJzaW9ufQ0KPiA+ID4gPiAtIC9zeXMva2VybmVsL3NlY3VyaXR5L2FwcGFy
bW9yL3JldmlzaW9uDQo+ID4gPg0KPiA+ID4gVGhhbmtzLCB0aGlzIGlzIGdvb2QgYmFja2dyb3Vu
ZCBpbmZvcm1hdGlvbi4NCj4gPiA+DQo+ID4gPiBXZSBoYXZlIGEgQm9GIHNlc3Npb24gb24gdGhl
IFRFRSBzdWJzeXN0ZW0gYXQgTFBDIG9uIEZyaWRheSBbMV0uIFdlJ2xsDQo+ID4gPiB0YWtlIHRo
ZSBvcHBvcnR1bml0eSB0byBkaXNjdXNzIGl0IHRoZXJlLg0KPiA+DQo+ID4gSnVzdCBhIHF1aWNr
IGZvbGxvdy11cCBvbiB0aGlzIHBhdGNoLCBoYXMgdGhlcmUgYmVlbiBhbnkgZGVjaXNpb24gb3IN
Cj4gPiBkaXJlY3Rpb24gZnJvbSB0aGF0IGRpc2N1c3Npb24/DQo+ID4gSeKAmW0gaGFwcHkgdG8g
cmV3b3JrIHRoZSBwYXRjaCBpbiB3aGF0ZXZlciBkaXJlY3Rpb24gdGhlIGdyb3VwIHByZWZlcnMu
DQo+IA0KPiBObyBvbmUgd2FzIGFnYWluc3QgaXQuIFdlIGRpZG4ndCBkaXNjdXNzIHRoZSBkZXRh
aWxzLCBidXQgaGVyZSdzIHdoYXQNCj4gSSdkIGxpa2UgdG8gc2VlOg0KPiAtIFRoZSBjYWxsYmFj
ayBuYW1lIHNob3VsZCBiZSBnZXRfdGVlX3JldmlzaW9uKCkgb3IgZ2V0X3RlZV9md192ZXJzaW9u
KCkNCj4gLSBUaGUgRlcgdmVyc2lvbiBpcyByZXR1cm5lZCBhcyBhIHN0cmluZyBmb3IgZmxleGli
aWxpdHkNCj4gLSBBIG5vdGUgdGhhdCB0aGUgRlcgdmVyc2lvbiBpcyBub3QgaW50ZW5kZWQgdG8g
YmUgdXNlZCB0byBkZXRlcm1pbmUNCj4gd2hhdCBmZWF0dXJlcywgZXRjLCBhcmUgYXZhaWxhYmxl
LCBURUVfSU9DX1ZFUlNJT04gc2hvdWxkIGNvdmVyIHRoYXQuDQo+IA0KPiBTdW1pdCwgd2hhdCBk
byB5b3UgdGhpbms/DQoNClRoYXQgc291bmRzIHJlYXNvbmFibGUgdG8gbWUuDQoNCi1TdW1pdA0K
