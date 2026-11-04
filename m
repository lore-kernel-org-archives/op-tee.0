Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C055606A338
	for <op-tee@archiver.kernel.org>; Wed,  4 Nov 2026 11:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=58iYGzzb;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J+1TyLd0
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7C27245476
	for <op-tee@archiver.kernel.org>; Wed,  4 Nov 2026 11:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1793790594;
	bh=BQDvypCM3mFVh05qA+v+JyLGjOrRxICJT4+YqzQf5M4=;
	h=Subject:Date:To:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=58iYGzzbLZpll5Rrcldra1uR9/xvn7saWLkXX5xFzFgoZnJeH/fAzyE8/rxPc/MsO
	 mAW+gjzqlLrjopPuBe4zXNV3tWTT4fp+VxYiXWErfHK8KrkCGeSGYOngp9Fm2t2sdK
	 M/nbdlWJoYZlqxHJAosbXbjOyFHdilXpuFmpAcHo9UTnEdkIaZ/eiTQkGioUYYn6MC
	 cGBcidXtORpTm8T66mCBi9QxTvOpYYCfQFusTcxa3JJrlBRmJ6UNHjrP9qsGA6DTpK
	 KLCp/8n+e0NSRNjYGjRV5QDYKGfq3Uhj1rpbLAd5sYjKkvVanvRrjhpkd+OJ+Cadrs
	 Jt8vWVAzIGA1g==
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C87EA44E1D
	for <op-tee@lists.trustedfirmware.org>; Wed,  4 Nov 2026 11:09:34 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J+1TyLd0;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793790574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y/j5QPLW6jpzCD3GV5JpZq3Ngo4fRQoXZZ90Dm8OkWQ=;
	b=J+1TyLd0n/3/zsoZ1vMBQ2U5MogItZjcmP3030m35xSwcOyTG/5mueGWbRlNqk999EUoIY
	vxJAY6gxDvDQriK3hU3EP+ScV80XbMVETOv5irWu6nB1Y0gbfyErX2Tfg7TQ6nW8oFhdTY
	6VIV3uWNSzNusV3AUtZe4Don45UUwq0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-95zgtnEUO52YN059qEpIoQ-1; Wed,
 04 Nov 2026 06:09:30 -0500
X-MC-Unique: 95zgtnEUO52YN059qEpIoQ-1
X-Mimecast-MFC-AGG-ID: 95zgtnEUO52YN059qEpIoQ_1793790566
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E1CA1956088;
	Wed,  4 Nov 2026 11:09:24 +0000 (UTC)
Received: from aesteve-thinkpadp1gen8.rmtes.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 27CE0195608D;
	Wed,  4 Nov 2026 11:09:14 +0000 (UTC)
Subject: [PATCH v4 0/8] memcg: dma-buf cgroup accounting and charge
 transfer
Date: Wed, 04 Nov 2026 12:09:09 +0100
Message-Id: <20261104-v2_20230123_tjmercier_google_com-v4-0-1819a017000b@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43N0YrCMBAF0F+RPBvJTNK0+uR/iJQ6mbRZViNpC
 buU/rtRlkXZh/Vt7lw4dxYjp8Cj2K1mkTiHMcRLCWa9EjR0l55lcCULVGhVpRqZsS23VoC6nT7
 OnChwavsY+09uKZ6lN8aTP4GttBKFuSb24esxcTiWPIRxiun7sZjh/v3BAf/HM0glrUZbKyBtt
 7BP7IZu2pRS3PWMvyIohDdELCJ7y4zONVTRH1E/i/Uboi5i3TgkQ6fGmvpFXJblBjmZGH11AQA
 A
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793790554; l=7204;
 i=aesteve@redhat.com; s=20260827; h=from:subject:message-id;
 bh=X4BZFXAHZjeZ5G+n6xJuzSu1l1U0TCSBOdNO5egLRKM=;
 b=Km+AqlhWRTv/KXXv4GRbT2llTohKS+mIBYai0uvK0MKieulAtBqFdb+ot4kS5rHtLOoLqnwgW
 ykX9usEkQGUD0PWls5MHmfgY0UQayrDXDRMYunnztg3zl598W8CS8z6
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=zI2RBeZgocwYm3AkJW4CtjoJnKoDZrfBl1xe5Ed6h+U=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: Zri5GTByaznUPZXv_BJAsYePyS7tG_f354JZj0jZ0Dg_1793790566
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.90 / 15.00];
	BAYES_HAM(-3.00)[99.98%];
	DWL_DNSWL_MED(-2.00)[redhat.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	RWL_MAILSPIKE_EXCELLENT(-0.40)[170.10.129.124:from];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:170.10.129.0/24];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:30031, ipnet:170.10.128.0/23, country:US];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[39];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,amd.com,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com,infradead.org];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DNSWL_BLOCKED(0.00)[170.10.129.124:from];
	ALIAS_RESOLVED(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[redhat.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C87EA44E1D
X-Spamd-Bar: ----
Message-ID-Hash: VFNYHWII5XZRC3LT7EJLQ3KWLO5M7EWB
X-Message-ID-Hash: VFNYHWII5XZRC3LT7EJLQ3KWLO5M7EWB
X-MailFrom: aesteve@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, op-tee@lists.trustedfirmware.org, Albert Esteve <aesteve@redhat.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/VFNYHWII5XZRC3LT7EJLQ3KWLO5M7EWB/>
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
IGludHJvZHVjZXMgdGhlIE1FTUNHX0RNQUJVRiBzdGF0IGFuZCByZXNlcnZlL2NhbmNlbA0KYW5k
IHVuY2hhcmdlIGhlbHBlcnMgaW4gbW0vbWVtY29udHJvbC5jDQoNClBhdGNoIDIgd2lyZXMgdXAg
dGhlIGNoYXJnaW5nIHBvbGljeTogZG1hX2J1Zl9leHBvcnQoKSBzdG9yZXMNCmV4cF9pbmZvLm1l
bWNnIGFuZCB1cGRhdGVzIHRoZSBzdGF0LCBhIG5ldyBjaGFyZ2VfZmQgZmllbGQgaW4NCkRNQV9I
RUFQX0lPQ1RMX0FMTE9DIGFjY2VwdHMgYSBwaWRmZCBvciBjZ3JvdXBmZCB0byBpZGVudGlmeQ0K
dGhlIHRhcmdldCBjZ3JvdXAsIGFuZCBfX0dGUF9BQ0NPVU5UIGlzIHJlbW92ZWQgZnJvbSBzeXN0
ZW0taGVhcA0KYWxsb2NhdGlvbnMgdG8gYXZvaWQgZG91YmxlIGNvdW50aW5nLg0KDQpQYXRjaCAz
IGFkZHMgRE1BX0JVRl9JT0NUTF9YRkVSX0NIQVJHRSwgYSBnZW5lcmFsIGlvY3RsIG9uIGFueQ0K
ZG1hLWJ1ZiBmZCB0byB0cmFuc2ZlciBjaGFyZ2VzIHBvc3QtYWxsb2NhdGlvbi4gVGhpcyBjb3Zl
cnMgdGhlDQpkb3VibGUtaG9wIGFsbG9jYXRvciBjYXNlIChTdXJmYWNlRmxpbmdlciAtPiBncmFs
bG9jIC0+IGtlcm5lbCkNCmFuZCB3b3JrcyBmb3IgYnVmZmVycyBmcm9tIGFueSBleHBvcnRlciAo
RFJNLCBWNEwyLCBldGMuKS4gQ2hhcmdpbmcNCmlzIGdhdGVkIGJ5IGRtYWJ1Zi0+bWVtY2cgYmVp
bmcgc2V0IGF0IGV4cG9ydCB0aW1lLCBlbnN1cmluZyB0aGF0DQp0cmFuc2ZlciBpcyBvbmx5IGFw
cGxpZWQgZm9yIGJ1ZmZlcnMgYmFja2VkIGJ5IHN5c3RlbSBtZW1vcnkgd2hlcmUNCnNpemUgcmVm
bGVjdHMgYWN0dWFsIGJ5dGVzLiBJZiB0aGUgcmVjZWl2aW5nIGNncm91cCBsYWNrcyBjYXBhY2l0
eQ0KZm9yIHRoZSBjaGFyZ2UsIHRoZSBpb2N0bCByZXR1cm5zIC1FTk9NRU0gYW5kIHRoZSBvcmln
aW5hbCBjaGFyZ2UNCmlzIHByZXNlcnZlZC4NCg0KUGF0Y2hlcyA0LTcgYWRkIGFjY2VzcyBjb250
cm9sIGZvciBjcm9zcy1jZ3JvdXAgY2hhcmdpbmcuIExldHRpbmcNCnVzZXJzcGFjZSBkZWNpZGUg
d2hvIHRvIGNoYXJnZSBuZWVkcyB0byBiZSBhIHByaXZpbGVnZWQgb3BlcmF0aW9uDQpiZWNhdXNl
IGl0IGhhcyBtYXRlcmlhbCBpbXBhY3Qgb24gT09NIGRlY2lzc2lvbiBhbmQgcmVzb3VyY2UgbGlt
aXRzLg0KV2UgZ2F0ZSBpdCB2aWEgTFNNIGhvb2tzIGZvciB0aGUgdHdvIGNoYXJnZV9mZCBmbGF2
b3VyczoNCnNlY3VyaXR5X2RtYV9idWZfY2hhcmdlX3Rhc2soKSBnYXRlcyB0aGUgcGlkZmQgcGF0
aCAodGFyZ2V0DQppZGVudGlmaWVkIGJ5IHRhc2sgY3JlZGVudGlhbHMpIGFuZCBzZWN1cml0eV9k
bWFfYnVmX2NoYXJnZV9jZ3JvdXAoKQ0KZ2F0ZXMgdGhlIGNncm91cGZkIHBhdGggKHRhcmdldCBp
ZGVudGlmaWVkIGJ5IGNncm91cCBkaXJlY3RvcnkgbGFiZWwpLA0Kd2l0aCBTRUxpbnV4IGltcGxl
bWVudGF0aW9ucyB1bmRlciBhIGRtYV9idWYgb2JqZWN0IGNsYXNzLg0KDQpQYXRjaCA4IGFkZHMg
c2VsZnRlc3RzLg0KDQpLbm93biBsaW1pdGF0aW9uczoNCg0KLSBTaW5nbGUtb3duZXIgbW9kZWw6
IGEgZG1hLWJ1ZiBjYXJyaWVzIG9uZSBtZW1jZyBjaGFyZ2UgcmVnYXJkbGVzcw0KICBvZiBob3cg
bWFueSBwcm9jZXNzZXMgc2hhcmUgaXQuDQotIE9ubHkgbWVtY2cgYWNjb3VudGluZy4gQ01BIGhl
YXBzIHdvdWxkIGFkZGl0aW9uYWxseSBuZWVkIGRtZW0NCiAgY29udHJvbGxlciBpbnRlZ3JhdGlv
bi4NCi0gSWYgYSB0cmFuc2ZlciBvZiBhbiB1bmNoYXJnZWQgYnVmZmVyIGZhaWxzLCB0aGUgYnVm
ZmVyIHJlbWFpbnMNCiAgY2hhcmdlZCB0byB0aGUgb3JpZ2luYWwgY2dyb3VwLiBUaGUgYWxsb2Nh
dG9yICh1c2Vyc3BhY2UpIGlzDQogIGV4cGVjdGVkIHRvIGhhbmRsZSB0aGlzIChyZXRyeSwgZnJl
ZSwgLi4uKS4NCi0gVGhlIExTTSBob29rcyBhcmUgaW50ZW50aW9uYWxseSBuYXJyb3cuIEJyb2Fk
ZXIgY2dyb3VwIGFjY2VzcyBjb250cm9scw0KICAoZS5nLiBmb3IgdGhlIG1lbWZkL2tleGVjIGhh
bmRvdmVyIGNhc2UgWzJdKSBjb3VsZCBiZSBhIHNlcGFyYXRlIGVmZm9ydA0KICByZXVzaW5nIHRo
ZSBzYW1lIHBhdHRlcm4uDQotIE9ubHkgc3lzdGVtIGhlYXAgc2V0cyBleHBfaW5mby5tZW1jZyB0
b2RheS4gT3RoZXIgZXhwb3J0ZXJzDQogIChEUk0sIFY0TDIsIGV0Yy4pIGNhbiBvcHQgaW4gYnkg
c2V0dGluZyBpdCwgYnV0IGFyZSBub3QNCiAgY292ZXJlZCBieSB0aGlzIHNlcmllcy4NCi0gUmVs
YXRlZCB0byB0aGUgYWJvdmU6IGxhenkgYmFja2luZy1zdG9yZSBhbGxvY2F0aW9uIGlzIG5vdCBz
dXBwb3J0ZWQuDQogIFRoaXMgY2FuIGJlIGV4dGVuZGVkIGxhdGVyLCBlLmcuLCBieSBhZGRpbmcg
YSBmbGFnIG9uIHRoZSBkbWEtYnVmDQogIHN0cnVjdCBmb3IgZXhwbGljaXRseSBtYXJraW5nIHdo
ZW4gbWVtb3J5IGlzIGNvbW1pdHRlZC4NCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2Nn
cm91cHMvMjAyMzAxMDkyMTM4MDkuNDE4MTM1LTEtdGptZXJjaWVyQGdvb2dsZS5jb20vDQpbMl0g
aHR0cHM6Ly9scGMuZXZlbnRzL2V2ZW50LzIwL2NvbnRyaWJ1dGlvbnMvMjQxNi8NCg0KU2lnbmVk
LW9mZi1ieTogQWxiZXJ0IEVzdGV2ZSA8YWVzdGV2ZUByZWRoYXQuY29tPg0KLS0tDQpDaGFuZ2Vz
IGluIHY0Og0KLSBSZW1vdmUgbWVtY2dfYWNjb3VudCBmbGFnOyBleHBfaW5mby5tZW1jZyAhPSBO
VUxMIGlzIHRoZSBvcHQtaW4NCi0gQ2VudHJhbGl6ZSBtZW1jZyBib29ra2VlcGluZyBpbiBkbWFf
YnVmX2V4cG9ydCgpDQotIERyb3AgbWVtX2Nncm91cF9jb21taXRfZG1hYnVmKCkNCi0gTWFrZSBt
ZW1fY2dyb3VwX3RyYW5zZmVyX2NoYXJnZSgpIGdlbmVyaWMgKG5vdCBkbWEtYnVmIHNwZWNpZmlj
KQ0KLSBBZGQgRVhQT1JUX1NZTUJPTF9HUEwgZm9yIHJlc2VydmUvY2FuY2VsIChzeXN0ZW1faGVh
cCBpcyB0cmlzdGF0ZSkNCi0gUmVvcmRlcjogbW92ZSB4ZmVyIGlvY3RsIGJlZm9yZSBMU00gcGF0
Y2hlcw0KLSBTZXJpYWxpemUgZG1hYnVmLT5tZW1jZyB1cGRhdGVzIHdpdGggdGhlIGRtYS1idWYg
cmVzdiBsb2NrIGluc3RlYWQgb2YgY21weGNoZw0KLSBMaW5rIHRvIHYzOiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9yLzIwMjYxMDI3LXYyXzIwMjMwMTIzX3RqbWVyY2llcl9nb29nbGVfY29tLXYz
LTAtNzhkMmM0Y2I4NjQ3QHJlZGhhdC5jb20NCg0KQ2hhbmdlcyBpbiB2MzoNCi0gU3BsaXQgbWVt
X2Nncm91cF9jaGFyZ2VfZG1hYnVmKCkgaW50byByZXNlcnZlL2NvbW1pdC9jYW5jZWwgdGhyZWUt
cGhhc2UgQVBJDQotIEV4dHJhY3QgbWVtX2Nncm91cF9nZXRfZnJvbV9mZCgpIGhlbHBlciBzaGFy
ZWQgYnkgYWxsb2NhdGUgYW5kIHhmZXIgcGF0aHMNCi0gUmVuYW1lIF9fcGFkZGluZyB0byBmbGFn
cyBpbiBzdHJ1Y3QgZG1hX2J1Zl90cmFuc2Zlcl9jaGFyZ2UNCi0gRml4IFVBRiByYWNlOiBtb3Zl
IG1vZF9tZW1jZ19zdGF0ZSgpIGJlZm9yZSBjbXB4Y2hnIGluIHRyYW5zZmVyDQotIEFkZCBtZW1j
Z19hY2NvdW50IG9wdC1pbiBmbGFnOyB4ZmVyIHJldHVybnMgLUVPUE5PVFNVUFAgaWYgdW5zZXQN
Ci0gV3JhcCBkbWFfYnVmX2NoYXJnZV9jZ3JvdXAgaG9vayBpbiAjaWZkZWYgQ09ORklHX0NHUk9V
UFMNCi0gRml4IFRPQ1RPVSBpbiBTRUxpbnV4IGNoYXJnZV9jZ3JvdXAgeGF0dHIgbGVuZ3RoIGhh
bmRsaW5nDQotIExpbmsgdG8gdjI6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNjEwMjEt
djJfMjAyMzAxMjNfdGptZXJjaWVyX2dvb2dsZV9jb20tdjItMC1lZjZlZTJkZDhjNWNAcmVkaGF0
LmNvbQ0KDQpDaGFuZ2VzIGluIHYyOg0KLSBNb3ZlIGNoYXJnZV9waWRfZmQgdG8gY2hhcmdlX2Zk
LCBhY2NlcHRpbmcgY2dyb3VwZmQgaW4gYWRkaXRpb24NCiAgdG8gcGlkZmQgcGVyIENocmlzdGlh
biBLw7ZuaWcuDQotIE5ldyBETUFfQlVGX0lPQ1RMX1hGRVJfQ0hBUkdFIGlvY3RsIGZvciBwb3N0
LWFsbG9jYXRpb24gY2hhcmdlDQogIHRyYW5zZmVyIG9uIGFueSBkbWEtYnVmLCBub3QganVzdCBk
bWEtaGVhcCBidWZmZXJzIHBlciBDaHJpc3RpYW4gS8O2bmlnDQogIGFuZCBULkouIE1lcmNpZXIu
DQotIE1vdmVkIF9fR0ZQX0FDQ09VTlQgcmVtb3ZhbCB0byBwYXRjaCAxIHBlciBCYXJyeSBTb25n
Lg0KLSBkbWEtYnVmIGNoYXJnZS91bmNoYXJnZSBoZWxwZXJzIHRha2Ugc3RydWN0IGRtYV9idWYg
KiBkaXJlY3RseQ0KICB0byBhdm9pZCB0aGUgbmVlZCBmb3IgY2FsbGVyIHRvIG1hbmFnZSBzaXpl
IGNhbGN1bGF0aW9ucy4NCi0gQWRkZWQgdGVzdF94ZmVyX2NoYXJnZV9jZ3JvdXBmZF9zZWxmIHRv
IGRtYWJ1Zi1oZWFwIHNlbGZ0ZXN0cy4NCi0gQWRkZWQgTFNNIGFuZCBTRUxpbnV4IGhvb2tzIGZv
ciBjZ3JvdXBmZC1iYXNlZCBjaGFyZ2luZy4NCi0gUmViYXNlZCB0byB2Ny4zLXJjNy4NCi0gTGlu
ayB0byB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI2MDUxMi12Ml8yMDIzMDEyM190
am1lcmNpZXJfZ29vZ2xlX2NvbS12MS0wLTYzMjY3MDFjMzY5MUByZWRoYXQuY29tDQoNCi0tLQ0K
QWxiZXJ0IEVzdGV2ZSAoNyk6DQogICAgICBkbWEtaGVhcDogY2hhcmdlIGRtYS1idWYgbWVtb3J5
IHZpYSBleHBsaWNpdCBtZW1jZw0KICAgICAgZG1hLWJ1ZjogdHJhbnNmZXIgbWVtY2cgY2hhcmdl
cyB2aWEgRE1BX0JVRl9JT0NUTF9YRkVSX0NIQVJHRQ0KICAgICAgc2VjdXJpdHk6IGRtYS1idWY6
IEFkZCBkbWFfYnVmX2NoYXJnZV90YXNrIExTTSBob29rDQogICAgICBzZWN1cml0eTogZG1hLWJ1
ZjogQWRkIGRtYV9idWZfY2hhcmdlX2Nncm91cCBMU00gaG9vaw0KICAgICAgc2VsaW51eDogUmVz
dHJpY3QgY3Jvc3MtY2dyb3VwIGRtYS1idWYgY2hhcmdpbmcNCiAgICAgIHNlbGludXg6IFJlc3Ry
aWN0IGRtYS1idWYgZGlyZWN0IGNncm91cCBjaGFyZ2luZw0KICAgICAgc2VsZnRlc3RzL2RtYWJ1
Zi1oZWFwczogQWRkIGRtYS1idWYgbWVtY2cgYWNjb3VudGluZyB0ZXN0cw0KDQpULkouIE1lcmNp
ZXIgKDEpOg0KICAgICAgbWVtY2c6IEFkZCBNRU1DR19ETUFCVUYgYWNjb3VudGluZyBpbmZyYXN0
cnVjdHVyZQ0KDQogRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9jZ3JvdXAtdjIucnN0ICAgICAg
ICAgICAgfCAgIDUgKw0KIGRyaXZlcnMvZG1hLWJ1Zi9kbWEtYnVmLmMgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgIDUwICsrKysNCiBkcml2ZXJzL2RtYS1idWYvZG1hLWhlYXAuYyAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAyOCArLQ0KIGRyaXZlcnMvZG1hLWJ1Zi9oZWFwcy9jbWFfaGVh
cC5jICAgICAgICAgICAgICAgICAgIHwgICAzICstDQogZHJpdmVycy9kbWEtYnVmL2hlYXBzL3N5
c3RlbV9oZWFwLmMgICAgICAgICAgICAgICAgfCAgMjEgKy0NCiBkcml2ZXJzL3RlZS90ZWVfaGVh
cC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMyArLQ0KIGluY2x1ZGUvbGludXgv
ZG1hLWJ1Zi5oICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA5ICsNCiBpbmNsdWRlL2xp
bnV4L2RtYS1oZWFwLmggICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMyArLQ0KIGluY2x1
ZGUvbGludXgvbHNtX2hvb2tfZGVmcy5oICAgICAgICAgICAgICAgICAgICAgIHwgICA0ICsNCiBp
bmNsdWRlL2xpbnV4L21lbWNvbnRyb2wuaCAgICAgICAgICAgICAgICAgICAgICAgICB8ICA0NyAr
KysrDQogaW5jbHVkZS9saW51eC9zZWN1cml0eS5oICAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAgMTggKysNCiBpbmNsdWRlL3VhcGkvbGludXgvZG1hLWJ1Zi5oICAgICAgICAgICAgICAgICAg
ICAgICB8ICAyNiArKw0KIGluY2x1ZGUvdWFwaS9saW51eC9kbWEtaGVhcC5oICAgICAgICAgICAg
ICAgICAgICAgIHwgICA3ICsNCiBtbS9tZW1jb250cm9sLmMgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8IDE3NiArKysrKysrKysrKysrDQogc2VjdXJpdHkvc2VjdXJpdHkuYyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMzQgKysrDQogc2VjdXJpdHkvc2VsaW51
eC9ob29rcy5jICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNDQgKysrKw0KIHNlY3VyaXR5
L3NlbGludXgvaW5jbHVkZS9jbGFzc21hcC5oICAgICAgICAgICAgICAgIHwgICAxICsNCiB0b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9jZ3JvdXAvTWFrZWZpbGUgICAgICAgICAgICB8ICAgMiArLQ0K
IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Nncm91cC90ZXN0X21lbWNvbnRyb2wuYyAgIHwgMjkw
ICsrKysrKysrKysrKysrKysrKysrLQ0KIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2RtYWJ1Zi1o
ZWFwcy9jb25maWcgICAgICAgIHwgICAxICsNCiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9kbWFi
dWYtaGVhcHMvZG1hYnVmLWhlYXAuYyB8IDIyNyArKysrKysrKysrKysrKystDQogdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvZG1hYnVmLWhlYXBzL3ZtdGVzdC5zaCAgICAgfCAyMjYgKysrKysrKysr
KysrKysrKw0KIDIyIGZpbGVzIGNoYW5nZWQsIDEyMTAgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRp
b25zKC0pDQotLS0NCmJhc2UtY29tbWl0OiAyNGExOWI5NTNlMmEzZDBlYTVhOGM0OTUxYTBhYjhm
MzI3MjBjOTA3DQpjaGFuZ2UtaWQ6IDIwMjYwNTA4LXYyXzIwMjMwMTIzX3RqbWVyY2llcl9nb29n
bGVfY29tLWY0NGZjZmIxNjUzMA0KDQpCZXN0IHJlZ2FyZHMsDQotLSANCkFsYmVydCBFc3RldmUg
PGFlc3RldmVAcmVkaGF0LmNvbT4NCg0K
