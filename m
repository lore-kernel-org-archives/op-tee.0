Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED0F606A33C
	for <op-tee@archiver.kernel.org>; Tue, 27 Oct 2026 15:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=cS6I2ax8;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YHC0zh1B
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 981BB45375
	for <op-tee@archiver.kernel.org>; Tue, 27 Oct 2026 15:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1793113428;
	bh=2INKrBcOfk3oNBFp49V9DjJR7xc1P6UmTYJV6U5wa6c=;
	h=Subject:Date:To:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=cS6I2ax8Pv0s+oT6tpCnothFMcDvs1g1tjqDGpB/sCLpXuGTWGhIZ7B8r/UqjDVwi
	 6eRE5ihnTFc06Gxo1pNUCh2NhoTfyWIHrQ1qVuVlUAMphH5PCuQVbmaUumWG1sH3a0
	 w3RwBJzoY3SgyGmm5Khj0yAWmKqdFcCxKMirQSp7Bqw9o3ltUU+X149svWS/j/jUOV
	 VYxC/fTYq1+Mv1Ast6J5L35YbtVIhFcdBkNEGvkYh+eSifXUVW47/tSjlkpwr/vxQT
	 TbUKGKTzAP+iofHFt2vThqf/eYNLXZw7hYWsuNcNDY2Hc1e3m9rcG6TBI+rv6GCmt2
	 SC+RcC4kWVXFw==
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 23C6B44E49
	for <op-tee@lists.trustedfirmware.org>; Tue, 27 Oct 2026 15:03:22 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YHC0zh1B;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793113401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aOf0mUhnEWGXt/wT5adZbPR4knhMHoXNhBntHVrI1Yw=;
	b=YHC0zh1Ba2BDbsKlalJ+/SDkR3Bwn64L21GWwRRqZzWUhVCUac5EbNeOfAfmeGzzDrg6CP
	Lm+kHQhVXBw14fqvrGF93ah8TBGZSr4n1HhXRX/1gcQXhV2aQ1oYcn0YhwclcN5jyFim+S
	q06X7yQJyx8AkyBEeS9tMlEuLDREw+0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-UjIdhJ72O6-uXk9AZAUySw-1; Tue,
 27 Oct 2026 11:03:16 -0400
X-MC-Unique: UjIdhJ72O6-uXk9AZAUySw-1
X-Mimecast-MFC-AGG-ID: UjIdhJ72O6-uXk9AZAUySw_1793113392
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DFCFA18009F0;
	Tue, 27 Oct 2026 15:03:09 +0000 (UTC)
Received: from aesteve-thinkpadp1gen8.rmtes.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D01D018002B1;
	Tue, 27 Oct 2026 15:02:59 +0000 (UTC)
Subject: [PATCH v3 0/8] memcg: dma-buf cgroup accounting and charge
 transfer
Date: Tue, 27 Oct 2026 16:02:43 +0100
Message-Id: <20261027-v2_20230123_tjmercier_google_com-v3-0-78d2c4cb8647@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NQQrCMBAF0KuUrI1kJm2srryHSKnppI3YRpISl
 NK7mxYRXOlu/nx4f2KBvKXADtnEPEUbrBtSkJuM6a4eWuK2SZmhQCUKUfKIVbqlAJTVeO3Ja0u
 +ap1rb1Rp13OT50abC6hCCpaYuydjH+vE6ZxyZ8Po/HNdjLB83zjgbzwCF1xJVDsBWqo9HD01X
 T1uU8kWPeJHBIHwh4hJJKOIsGlKXegvcZ7nF8pnAWwjAQAA
X-Change-ID: 20260508-v2_20230123_tjmercier_google_com-f44fcfb16530
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T.J. Mercier" <tjmercier@google.com>,
 Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 =?utf-8?q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>,
 Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
 =?utf-8?q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793113379; l=6757;
 i=aesteve@redhat.com; s=20260827; h=from:subject:message-id;
 bh=SbSaiBkIq+YUC6r+fSuC8xTCAnJdm8Vr2zNeXnNL3ao=;
 b=rMh42d3K7ZdvbxPJmt30LjOl76ZkQ62Z6Ul1YgWdi/7V4axPrJSy681qwSjEcG3Y17eHAsv1y
 +LmSEK2BvnsDaNYSlWiHuv0bXrBqtI3n02cWTu6Y6kXEFNbK6b8jRpu
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=zI2RBeZgocwYm3AkJW4CtjoJnKoDZrfBl1xe5Ed6h+U=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: tu2lbOIzH8wjo6DgM53Bay_jZHBLzCjhWlUdsh2Z0Zg_1793113392
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.69 / 15.00];
	BAYES_HAM(-2.99)[99.97%];
	DWL_DNSWL_MED(-2.00)[redhat.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:170.10.133.0/24];
	RWL_MAILSPIKE_GOOD(-0.10)[170.10.133.124:from];
	RCVD_IN_DNSWL_LOW(-0.10)[170.10.133.124:from];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:30031, ipnet:170.10.132.0/23, country:US];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[41];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,amd.com,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com,infradead.org];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[redhat.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 23C6B44E49
X-Spamd-Bar: ----
Message-ID-Hash: 4XXFD5PK5AEDCSVCKSA2DFKMUEQZEYEB
X-Message-ID-Hash: 4XXFD5PK5AEDCSVCKSA2DFKMUEQZEYEB
X-MailFrom: aesteve@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, op-tee@lists.trustedfirmware.org, Albert Esteve <aesteve@redhat.com>, echanude@redhat.com, mripard@kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/4XXFD5PK5AEDCSVCKSA2DFKMUEQZEYEB/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: Albert Esteve via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Albert Esteve <aesteve@redhat.com>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

U2hhcmVkLW1lbW9yeSBhbGxvY2F0b3Igc2VydmljZXMgKGUuZy4sIEFuZHJvaWQncyBncmFsbG9j
KQ0KYWxsb2NhdGUgZG1hLWJ1ZnMgb24gYmVoYWxmIG9mIGNsaWVudCBwcm9jZXNzZXMgaW4gZGlm
ZmVyZW50DQpjZ3JvdXBzLiBUb2RheSB0aG9zZSBhbGxvY2F0aW9ucyBhcmUgY2hhcmdlZCB0byB0
aGUgYWxsb2NhdG9yJ3MNCm93biBjZ3JvdXAsIGxlYXZpbmcgY2xpZW50IGNncm91cHMgd2l0aCBu
byB2aXNpYmlsaXR5IGludG8gdGhlaXINCmFjdHVhbCBtZW1vcnkgY29uc3VtcHRpb24gYW5kIGRl
ZmVhdGluZyByZXNvdXJjZSBsaW1pdHMuDQoNClRoaXMgc2VyaWVzIGFkZHMgbWVtb3J5IGNncm91
cCBhY2NvdW50aW5nIGZvciBkbWEtYnVmIGFsbG9jYXRpb25zLA0KYnVpbGRpbmcgb24gVC5KLiBN
ZXJjaWVyJ3MgZWFybGllciBzZXJpZXMgWzFdIGFuZCBpbmNvcnBvcmF0aW5nDQpmZWVkYmFjayBm
cm9tIHByZXZpb3VzIHZlcnNpb25zIGFuZCBMUEMgZGlzY3Vzc2lvbnMgWzJdLg0KDQpQYXRjaCAx
IGludHJvZHVjZXMgdGhlIE1FTUNHX0RNQUJVRiBzdGF0IGFuZCByZXNlcnZlL2NvbW1pdC9jYW5j
ZWwNCmFuZCB1bmNoYXJnZSBoZWxwZXJzLiBSYXRoZXIgdGhhbiBjaGFyZ2luZyBhdCB0aGUgcGFn
ZSBsZXZlbCB2aWENCl9fR0ZQX0FDQ09VTlQgKHdoaWNoIHdvdWxkIHJlcXVpcmUgZXZlcnkgZG1h
LWJ1ZiBleHBvcnRlciB0byBpbXBsZW1lbnQNCmNoYXJnaW5nLCBhbmQgbWFrZXMgY3Jvc3MtY2dy
b3VwIHRyYW5zZmVyIGltcHJhY3RpY2FsIHdpdGhvdXQgYWNjZXNzDQp0byBiYWNraW5nIHBhZ2Vz
KSwgd2UgdHJhY2sgY2hhcmdlcyBleHRlcm5hbGx5IG9uIHN0cnVjdCBkbWFfYnVmIHZpYQ0KYSBN
RU1DR19ETUFCVUYgc3RhdCBjb3VudGVyIGFuZCByb3V0ZSBhbGwgYWNjb3VudGluZyB0aHJvdWdo
IGEgc2luZ2xlDQpwYXRoLCByZW1vdmluZyB0aGUgX19HRlBfQUNDT1VOVCBmbGFnIGZyb20gc3lz
dGVtLWhlYXAgYWxsb2NhdGlvbnMNCnRvIGF2b2lkIGRvdWJsZSBjb3VudGluZy4NCg0KUGF0Y2gg
MiBhZGRzIGEgY2hhcmdlX2ZkIGZpZWxkIHRvIERNQV9IRUFQX0lPQ1RMX0FMTE9DLCBhY2NlcHRp
bmcNCmVpdGhlciBhIHBpZGZkIG9yIGEgY2dyb3VwZmQgdG8gaWRlbnRpZnkgdGhlIHRhcmdldCBj
Z3JvdXAgYXQNCmFsbG9jYXRpb24gdGltZS4gSWYgdGhlIHRhcmdldCBjZ3JvdXAgY2Fubm90IGFj
Y29tbW9kYXRlIHRoZSBjaGFyZ2UsDQp0aGUgYWxsb2NhdGlvbiByZXR1cm5zIC1FTk9NRU0uDQoN
ClBhdGNoZXMgMy02IGFkZCBhY2Nlc3MgY29udHJvbCBmb3IgY3Jvc3MtY2dyb3VwIGNoYXJnaW5n
LiBMZXR0aW5nDQp1c2Vyc3BhY2UgZGVjaWRlIHdobyB0byBjaGFyZ2UgbmVlZHMgdG8gYmUgYSBw
cml2aWxlZ2VkIG9wZXJhdGlvbg0KYmVjYXVzZSBpdCBoYXMgbWF0ZXJpYWwgaW1wYWN0IG9uIE9P
TSBkZWNpc3Npb24gYW5kIHJlc291cmNlIGxpbWl0cy4NCldlIGdhdGUgaXQgdmlhIExTTSBob29r
cyBmb3IgdGhlIHR3byBjaGFyZ2VfZmQgZmxhdm91cnM6DQpzZWN1cml0eV9kbWFfYnVmX2NoYXJn
ZV90YXNrKCkgZ2F0ZXMgdGhlIHBpZGZkIHBhdGggKHRhcmdldA0KaWRlbnRpZmllZCBieSB0YXNr
IGNyZWRlbnRpYWxzKSBhbmQgc2VjdXJpdHlfZG1hX2J1Zl9jaGFyZ2VfY2dyb3VwKCkNCmdhdGVz
IHRoZSBjZ3JvdXBmZCBwYXRoICh0YXJnZXQgaWRlbnRpZmllZCBieSBjZ3JvdXAgZGlyZWN0b3J5
IGxhYmVsKSwNCndpdGggU0VMaW51eCBpbXBsZW1lbnRhdGlvbnMgdW5kZXIgYSBkbWFfYnVmIG9i
amVjdCBjbGFzcy4NCg0KUGF0Y2ggNyBhZGRzIERNQV9CVUZfSU9DVExfWEZFUl9DSEFSR0UsIGEg
Z2VuZXJhbCBpb2N0bCBvbiBhbnkNCmRtYS1idWYgZmQgdG8gdHJhbnNmZXIgY2hhcmdlcyBwb3N0
LWFsbG9jYXRpb24uIFRoaXMgY292ZXJzIHRoZQ0KZG91YmxlLWhvcCBhbGxvY2F0b3IgY2FzZSAo
U3VyZmFjZUZsaW5nZXIgLT4gZ3JhbGxvYyAtPiBrZXJuZWwpDQphbmQgd29ya3MgZm9yIGJ1ZmZl
cnMgZnJvbSBhbnkgZXhwb3J0ZXIgKERSTSwgVjRMMiwgZXRjLikuIEEgbmV3DQptZW1jZ19hY2Nv
dW50IGZsYWcgaXMgYWRkZWQgZm9yIGRtYV9idWZfZXhwb3J0KCkgdG8gZW5zdXJlIHRoYXQNCnRy
YW5zZmVyL2NoYXJnZSBpcyBvbmx5IGFwcGxpZWQgZm9yIGJ1ZmZlcnMgYmFja2VkIGJ5IHJlY2xh
aW1hYmxlDQpzeXN0ZW0gbWVtb3J5LiBJZiB0aGUgcmVjZWl2aW5nIGNncm91cCBsYWNrcyBjYXBh
Y2l0eSBmb3IgdGhlIGNoYXJnZSwNCnRoZSBpb2N0bCByZXR1cm5zIC1FTk9NRU0gYW5kIHRoZSBv
cmlnaW5hbCBjaGFyZ2UgaXMgcHJlc2VydmVkLg0KDQpQYXRjaCA4IGFkZHMgc2VsZnRlc3RzLg0K
DQpLbm93biBsaW1pdGF0aW9uczoNCg0KLSBTaW5nbGUtb3duZXIgbW9kZWw6IGEgZG1hLWJ1ZiBj
YXJyaWVzIG9uZSBtZW1jZyBjaGFyZ2UgcmVnYXJkbGVzcw0KICBvZiBob3cgbWFueSBwcm9jZXNz
ZXMgc2hhcmUgaXQuDQotIE9ubHkgbWVtY2cgYWNjb3VudGluZy4gQ01BIGhlYXBzIHdvdWxkIGFk
ZGl0aW9uYWxseSBuZWVkIGRtZW0NCiAgY29udHJvbGxlciBpbnRlZ3JhdGlvbi4NCi0gSWYgYSB0
cmFuc2ZlciBvZiBhbiB1bmNoYXJnZWQgYnVmZmVyIGZhaWxzLCBpdCByZW1haW5zIHVuY2hhcmdl
ZC4NCiAgVGhlIGFsbG9jYXRvciAodXNlcnNwYWNlKSBpcyBleHBlY3RlZCB0byBoYW5kbGUgdGhp
cyAocmV0cnksIGZyZWUsIC4uLikuDQotIFRoZSBMU00gaG9va3MgYXJlIGludGVudGlvbmFsbHkg
bmFycm93LiBCcm9hZGVyIGNncm91cCBhY2Nlc3MgY29udHJvbHMNCiAgKGUuZy4gZm9yIHRoZSBt
ZW1mZC9rZXhlYyBoYW5kb3ZlciBjYXNlIFsyXSkgY291bGQgYmUgYSBzZXBhcmF0ZSBlZmZvcnQN
CiAgcmV1c2luZyB0aGUgc2FtZSBwYXR0ZXJuLg0KLSBPbmx5IHN5c3RlbSBoZWFwIHNldHMgbWVt
Y2dfYWNjb3VudCB0b2RheS4gT3RoZXIgZXhwb3J0ZXJzDQogIChEUk0sIFY0TDIsIGV0Yy4pIGNh
biBvcHQgaW4gYnkgc2V0dGluZyB0aGUgZmxhZywgYnV0IGFyZSBub3QNCiAgY292ZXJlZCBieSB0
aGlzIHNlcmllcy4NCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2Nncm91cHMvMjAyMzAx
MDkyMTM4MDkuNDE4MTM1LTEtdGptZXJjaWVyQGdvb2dsZS5jb20vDQpbMl0gaHR0cHM6Ly9scGMu
ZXZlbnRzL2V2ZW50LzIwL2NvbnRyaWJ1dGlvbnMvMjQxNi8NCg0KU2lnbmVkLW9mZi1ieTogQWxi
ZXJ0IEVzdGV2ZSA8YWVzdGV2ZUByZWRoYXQuY29tPg0KLS0tDQpDaGFuZ2VzIGluIHYzOg0KLSBT
cGxpdCBtZW1fY2dyb3VwX2NoYXJnZV9kbWFidWYoKSBpbnRvIHJlc2VydmUvY29tbWl0L2NhbmNl
bCB0aHJlZS1waGFzZSBBUEkNCi0gRXh0cmFjdCBtZW1fY2dyb3VwX2dldF9mcm9tX2ZkKCkgaGVs
cGVyIHNoYXJlZCBieSBhbGxvY2F0ZSBhbmQgeGZlciBwYXRocw0KLSBSZW5hbWUgX19wYWRkaW5n
IHRvIGZsYWdzIGluIHN0cnVjdCBkbWFfYnVmX3RyYW5zZmVyX2NoYXJnZQ0KLSBGaXggVUFGIHJh
Y2U6IG1vdmUgbW9kX21lbWNnX3N0YXRlKCkgYmVmb3JlIGNtcHhjaGcgaW4gdHJhbnNmZXINCi0g
QWRkIG1lbWNnX2FjY291bnQgb3B0LWluIGZsYWc7IHhmZXIgcmV0dXJucyAtRU9QTk9UU1VQUCBp
ZiB1bnNldA0KLSBXcmFwIGRtYV9idWZfY2hhcmdlX2Nncm91cCBob29rIGluICNpZmRlZiBDT05G
SUdfQ0dST1VQUw0KLSBGaXggVE9DVE9VIGluIFNFTGludXggY2hhcmdlX2Nncm91cCB4YXR0ciBs
ZW5ndGggaGFuZGxpbmcNCi0gTGluayB0byB2MjogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8y
MDI2MTAyMS12Ml8yMDIzMDEyM190am1lcmNpZXJfZ29vZ2xlX2NvbS12Mi0wLWVmNmVlMmRkOGM1
Y0ByZWRoYXQuY29tDQoNCkNoYW5nZXMgaW4gdjI6DQotIE1vdmUgY2hhcmdlX3BpZF9mZCB0byBj
aGFyZ2VfZmQsIGFjY2VwdGluZyBjZ3JvdXBmZCBpbiBhZGRpdGlvbg0KICB0byBwaWRmZCBwZXIg
Q2hyaXN0aWFuIEvDtm5pZy4NCi0gTmV3IERNQV9CVUZfSU9DVExfWEZFUl9DSEFSR0UgaW9jdGwg
Zm9yIHBvc3QtYWxsb2NhdGlvbiBjaGFyZ2UNCiAgdHJhbnNmZXIgb24gYW55IGRtYS1idWYsIG5v
dCBqdXN0IGRtYS1oZWFwIGJ1ZmZlcnMgcGVyIENocmlzdGlhbiBLw7ZuaWcNCiAgYW5kIFQuSi4g
TWVyY2llci4NCi0gTW92ZWQgX19HRlBfQUNDT1VOVCByZW1vdmFsIHRvIHBhdGNoIDEgcGVyIEJh
cnJ5IFNvbmcuDQotIGRtYS1idWYgY2hhcmdlL3VuY2hhcmdlIGhlbHBlcnMgdGFrZSBzdHJ1Y3Qg
ZG1hX2J1ZiAqIGRpcmVjdGx5DQogIHRvIGF2b2lkIHRoZSBuZWVkIGZvciBjYWxsZXIgdG8gbWFu
YWdlIHNpemUgY2FsY3VsYXRpb25zLg0KLSBBZGRlZCB0ZXN0X3hmZXJfY2hhcmdlX2Nncm91cGZk
X3NlbGYgdG8gZG1hYnVmLWhlYXAgc2VsZnRlc3RzLg0KLSBBZGRlZCBMU00gYW5kIFNFTGludXgg
aG9va3MgZm9yIGNncm91cGZkLWJhc2VkIGNoYXJnaW5nLg0KLSBSZWJhc2VkIHRvIHY3LjMtcmM3
Lg0KLSBMaW5rIHRvIHYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjYwNTEyLXYyXzIw
MjMwMTIzX3RqbWVyY2llcl9nb29nbGVfY29tLXYxLTAtNjMyNjcwMWMzNjkxQHJlZGhhdC5jb20N
Cg0KLS0tDQpBbGJlcnQgRXN0ZXZlICg3KToNCiAgICAgIGRtYS1oZWFwOiBjaGFyZ2UgZG1hLWJ1
ZiBtZW1vcnkgdmlhIGV4cGxpY2l0IG1lbWNnDQogICAgICBzZWN1cml0eTogZG1hLWJ1ZjogQWRk
IGRtYV9idWZfY2hhcmdlX3Rhc2sgTFNNIGhvb2sNCiAgICAgIHNlY3VyaXR5OiBkbWEtYnVmOiBB
ZGQgZG1hX2J1Zl9jaGFyZ2VfY2dyb3VwIExTTSBob29rDQogICAgICBzZWxpbnV4OiBSZXN0cmlj
dCBjcm9zcy1jZ3JvdXAgZG1hLWJ1ZiBjaGFyZ2luZw0KICAgICAgc2VsaW51eDogUmVzdHJpY3Qg
ZG1hLWJ1ZiBkaXJlY3QgY2dyb3VwIGNoYXJnaW5nDQogICAgICBkbWEtYnVmOiB0cmFuc2ZlciBt
ZW1jZyBjaGFyZ2VzIHZpYSBETUFfQlVGX0lPQ1RMX1hGRVJfQ0hBUkdFDQogICAgICBzZWxmdGVz
dHMvZG1hYnVmLWhlYXBzOiBBZGQgZG1hLWJ1ZiBtZW1jZyBhY2NvdW50aW5nIHRlc3RzDQoNClQu
Si4gTWVyY2llciAoMSk6DQogICAgICBtZW1jZzogQWRkIE1FTUNHX0RNQUJVRiBhY2NvdW50aW5n
IGluZnJhc3RydWN0dXJlDQoNCiBEb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2Nncm91cC12Mi5y
c3QgICAgICAgICAgICB8ICAgNSArDQogZHJpdmVycy9kbWEtYnVmL2RtYS1idWYuYyAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgNDYgKysrKw0KIGRyaXZlcnMvZG1hLWJ1Zi9kbWEtaGVhcC5j
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDI4ICstDQogZHJpdmVycy9kbWEtYnVmL2hlYXBz
L2NtYV9oZWFwLmMgICAgICAgICAgICAgICAgICAgfCAgIDMgKy0NCiBkcml2ZXJzL2RtYS1idWYv
aGVhcHMvc3lzdGVtX2hlYXAuYyAgICAgICAgICAgICAgICB8ICAyMiArLQ0KIGRyaXZlcnMvdGVl
L3RlZV9oZWFwLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAzICstDQogaW5jbHVk
ZS9saW51eC9kbWEtYnVmLmggICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDkgKw0KIGlu
Y2x1ZGUvbGludXgvZG1hLWhlYXAuaCAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAzICst
DQogaW5jbHVkZS9saW51eC9sc21faG9va19kZWZzLmggICAgICAgICAgICAgICAgICAgICAgfCAg
IDQgKw0KIGluY2x1ZGUvbGludXgvbWVtY29udHJvbC5oICAgICAgICAgICAgICAgICAgICAgICAg
IHwgIDUyICsrKysNCiBpbmNsdWRlL2xpbnV4L3NlY3VyaXR5LmggICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAxOCArKw0KIGluY2x1ZGUvdWFwaS9saW51eC9kbWEtYnVmLmggICAgICAgICAg
ICAgICAgICAgICAgIHwgIDI2ICsrDQogaW5jbHVkZS91YXBpL2xpbnV4L2RtYS1oZWFwLmggICAg
ICAgICAgICAgICAgICAgICAgfCAgIDcgKw0KIG1tL21lbWNvbnRyb2wuYyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgMTkyICsrKysrKysrKysrKysrDQogc2VjdXJpdHkvc2Vj
dXJpdHkuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMzQgKysrDQogc2VjdXJp
dHkvc2VsaW51eC9ob29rcy5jICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNDQgKysrKw0K
IHNlY3VyaXR5L3NlbGludXgvaW5jbHVkZS9jbGFzc21hcC5oICAgICAgICAgICAgICAgIHwgICAx
ICsNCiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9jZ3JvdXAvTWFrZWZpbGUgICAgICAgICAgICB8
ICAgMiArLQ0KIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nncm91cC90ZXN0X21lbWNvbnRyb2wu
YyAgIHwgMjkwICsrKysrKysrKysrKysrKysrKysrLQ0KIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2RtYWJ1Zi1oZWFwcy9jb25maWcgICAgICAgIHwgICAxICsNCiB0b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9kbWFidWYtaGVhcHMvZG1hYnVmLWhlYXAuYyB8IDIyNyArKysrKysrKysrKysrKystDQog
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZG1hYnVmLWhlYXBzL3ZtdGVzdC5zaCAgICAgfCAyMjYg
KysrKysrKysrKysrKysrKw0KIDIyIGZpbGVzIGNoYW5nZWQsIDEyMjggaW5zZXJ0aW9ucygrKSwg
MTUgZGVsZXRpb25zKC0pDQotLS0NCmJhc2UtY29tbWl0OiAyNGExOWI5NTNlMmEzZDBlYTVhOGM0
OTUxYTBhYjhmMzI3MjBjOTA3DQpjaGFuZ2UtaWQ6IDIwMjYwNTA4LXYyXzIwMjMwMTIzX3RqbWVy
Y2llcl9nb29nbGVfY29tLWY0NGZjZmIxNjUzMA0KDQpCZXN0IHJlZ2FyZHMsDQotLSANCkFsYmVy
dCBFc3RldmUgPGFlc3RldmVAcmVkaGF0LmNvbT4NCg0K
