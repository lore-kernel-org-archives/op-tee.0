Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAC7606A31A
	for <op-tee@archiver.kernel.org>; Mon, 26 Oct 2026 06:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=gRUFzBjL;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=GR8qO+AU
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1876A4529D
	for <op-tee@archiver.kernel.org>; Mon, 26 Oct 2026 06:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1792997621;
	bh=y06xg5cCfTmk1IEvLPOy/8gN/kdfbNmJoq5FjSrqhWw=;
	h=To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=gRUFzBjLygfOOlpZXnsuaxDL0SMu3nExwm02xp2BJw7IOpfPe48CafvDNMLrWV7ob
	 0d9CcLdp9I+/xs4mvzErKppSD3Q0o7iaN/IhPwBaiHkL5RCYtaI2V3jExhYf59GgQN
	 B0GWpybAAlO0JikfylAssU8gBp0D4qkL84EpKwYqMolyhwznVi2tvKSn0RwpIlIylT
	 RR3pQWGMQDauq+TeSbsieT1bhVqldVhZDuz3zS0qe3G/mXY3ci9x+9bEJ9R0B6+tsh
	 F4VN6pb8Y7AiLU37RtI07FuB5k1HxIJiL535Ns8WyKJHGXagskmux0AOSJVHlwB0pV
	 aoTB9ijz0koQA==
Received: from smtp.uibk.ac.at (smtp.uibk.ac.at [138.232.1.140])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 953A643EF9
	for <op-tee@lists.trustedfirmware.org>; Sun, 25 Oct 2026 19:26:05 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=GR8qO+AU;
	dkim-atps=neutral
Received: from surface-pro-5 (178.115.151.51.wireless.dyn.drei.com [178.115.151.51])
	(authenticated bits=0)
	by smtp.uibk.ac.at (8.15.2/8.15.2/F1) with ESMTPSA id 69PJPwic520208
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 25 Oct 2026 20:26:01 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.uibk.ac.at 69PJPwic520208
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=student.uibk.ac.at;
	s=prod24a; t=1792956361;
	bh=h9gazqxE5FWyhT9+DyTbOS+snk0x4WNikPAuLwcSx/A=;
	h=From:To:Cc:Subject:Date;
	b=GR8qO+AUY5DqKh9DsMSLGddcQloXn8I+VEUjRqCN8uAhPXjvKrHAd+7Fn2xo4sExX
	 Q1RvutLNfDY12OlkQKtN3qMeFgSoORv1+ByyC3/OdUopWsj35tyDODVMOPuJyw0LFN
	 sWvayxKiep+XAz3NN6yFQY/6mzUmN2xBxcAnnR6Y=
To: jenswi@kernel.org, sumit.garg@kernel.org
Subject: [RFC PATCH] tee: optee: allow forcing the reserved shared memory pool
Date: Sun, 25 Oct 2026 20:25:55 +0100
Message-ID: <20261025192555.210257-1-christian.koever-draxl@student.uibk.ac.at>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Spam-Score: () -15.0 ALL_TRUSTED,RCV_SMTP_AUTH,RCV_SMTP_UIBK
X-Scanned-By: MIMEDefang_3.2_at_uibk.ac.at
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[uibk.ac.at:dkim];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[student.uibk.ac.at,quarantine];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	R_DKIM_ALLOW(-0.20)[student.uibk.ac.at:s=prod24a];
	ONCE_RECEIVED(0.20)[];
	RCVD_IN_DNSWL_MED(-0.20)[138.232.1.140:from];
	R_SPF_ALLOW(-0.20)[+ip4:138.232.1.140];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ONE(0.00)[1];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:1110, ipnet:138.232.0.0/16, country:AT];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[lists.trustedfirmware.org,vger.kernel.org,outlook.de];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[student.uibk.ac.at:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 953A643EF9
X-Spamd-Bar: -----
X-MailFrom: christian.koever-draxl@student.uibk.ac.at
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: ZT6SDQHVZDEOVKU67B6RPB3ZMHGD4JXX
X-Message-ID-Hash: ZT6SDQHVZDEOVKU67B6RPB3ZMHGD4JXX
X-Mailman-Approved-At: Mon, 26 Oct 2026 06:52:55 +0000
CC: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Christian=20Stefan=20K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ZT6SDQHVZDEOVKU67B6RPB3ZMHGD4JXX/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: "christian.koever-draxl--- via OP-TEE" <op-tee@lists.trustedfirmware.org>
Reply-To: christian.koever-draxl@student.uibk.ac.at
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

RnJvbTogQ2hyaXN0aWFuIFN0ZWZhbiBLw7Z2w6lyLURyYXhsIDxja29ldmVyQG91dGxvb2suZGU+
DQoNClRoZSBYOThRJ3MgdmVuZG9yIEJMMzIgcnVucyBPUC1URUUgMy44IGFuZCByZXBvcnRzIHNl
Y19jYXBzIDB4NSwgdGhhdCBpcw0KSEFWRV9SRVNFUlZFRF9TSE0gfCBEWU5BTUlDX1NITSwgd2l0
aCBuZWl0aGVyIFVOUkVHSVNURVJFRF9TSE0gbm9yDQpSUENfQVJHLg0KDQpGb3IgdGhhdCBjb21i
aW5hdGlvbiBvcHRlZV9wcm9iZSgpIHBpY2tzIHRoZSBkeW5hbWljIHBvb2wgYW5kIHNldHMNCk9Q
VEVFX1NITV9BUkdfQUxMT0NfUFJJViwgc28gZXZlcnkgbWVzc2FnZSBhcmd1bWVudCBpcyBhbiB1
bnJlZ2lzdGVyZWQNCnByaXZhdGUgcGFnZSBwYXNzZWQgdG8gc2VjdXJlIHdvcmxkIGJ5IHBoeXNp
Y2FsIGFkZHJlc3MgdmlhDQpPUFRFRV9TTUNfQ0FMTF9XSVRIX0FSRy4gVGhpcyBPUC1URUUgd2ls
bCBub3QgYWNjZXB0IHRoYXQ6IGV2ZXJ5IGNhbGwNCmNvbWVzIGJhY2sgT1BURUVfU01DX1JFVFVS
Tl9FQkFEQUREUiAoNCksIHdoaWNoIG9wdGVlX29wZW5fc2Vzc2lvbigpDQpjb252ZXJ0cyBpbnRv
IFRFRUNfRVJST1JfQ09NTVVOSUNBVElPTiAvIFRFRUNfT1JJR0lOX0NPTU1TLiBUaGUgcmVzdWx0
DQppcyB0aGF0IG5vIHNlc3Npb24gY2FuIGJlIG9wZW5lZCBhdCBhbGwgLSBub3QgdG8gdGhlIEFt
bG9naWMgZmlybXdhcmUNCmxvYWRpbmcgUFRBIHRoZSB2aWRlbyBkZWNvZGVyIG5lZWRzLCBhbmQg
bm90IHRvIGFueSBidWlsdC1pbiBQVEEgZWl0aGVyLg0KDQpSZWdpc3RlcmluZyBtZW1vcnkgd29y
a3MgZmluZSwgYW5kIEhBVkVfUkVTRVJWRURfU0hNIGlzIHNldCwgc28gdGhlDQpleGlzdGluZyBz
dGF0aWMgcG9vbCBwYXRoIGlzIHVzYWJsZS4gQWRkIG9wdGVlLm5vX2R5bl9zaG0gdG8gc2VsZWN0
IGl0Lg0KV2l0aCB0aGUgcmVzZXJ2ZWQgcG9vbCB0aGUgZGV2aWNlIGVudW1lcmF0aW9uIFBUQSBv
cGVucyBjbGVhbmx5IGFuZCB0aGUNCnN5c3RlbSBQVEEgYW5zd2VycyB3aXRoIGl0cyBvd24gQUND
RVNTX0RFTklFRCwgc28gdGhlIEFCSSBpcyBoZWFsdGh5Lg0KDQpUaGUgZHJpdmVyIGFyZ3VhYmx5
IHNob3VsZCBub3QgdXNlIHVucmVnaXN0ZXJlZCBhcmd1bWVudHMgdW5sZXNzIHNlY3VyZQ0Kd29y
bGQgYWR2ZXJ0aXNlZCBVTlJFR0lTVEVSRURfU0hNOyBhIHBhcmFtZXRlciBrZWVwcyB0aGUgY2hh
bmdlIGxvY2FsDQp1bnRpbCB0aGF0IGlzIGNvbmZpcm1lZCB1cHN0cmVhbS4NCg0KU2lnbmVkLW9m
Zi1ieTogQ2hyaXN0aWFuIFN0ZWZhbiBLw7Z2w6lyLURyYXhsIDxja29ldmVyQG91dGxvb2suZGU+
DQotLS0NClRvb2wgdXNlIChEb2N1bWVudGF0aW9uL3Byb2Nlc3MvZ2VuZXJhdGVkLWNvbnRlbnQu
cnN0KToNClRoaXMgd29yayB3YXMgZG9uZSB3aXRoIHRoZSBoZWxwIG9mIGFuIEFJIGNvZGluZyBh
c3Npc3RhbnQsIENsYXVkZQ0KKEFudGhyb3BpYyksIHVzZWQgdGhyb3VnaCBDbGF1ZGUgQ29kZSBv
dmVyIG1hbnkgc2Vzc2lvbnMuIEl0IGRpZCBhIGxhcmdlDQpwYXJ0IG9mIHRoZSBoYW5kcy1vbiB3
b3JrOiBpdCByZWFkIHRoZSB2ZW5kb3Iga2VybmVsIGFuZCB0aGUgZmlybXdhcmUNCmludGVyZmFj
ZXMsIHByb2JlZCByZWdpc3RlcnMgb24gdGhlIGJvYXJkLCBkcmFmdGVkIHRoZSBjb2RlIGFuZCB0
aGUNCmNoYW5nZWxvZ3MsIGFuZCByYW4gdGhlIGJ1aWxkcywgY2hlY2twYXRjaCwgZHRfYmluZGlu
Z19jaGVjayBhbmQgdGhlDQp0ZXN0cyBvbiB0aGUgaGFyZHdhcmUuIEkgZGlyZWN0ZWQgdGhlIHdv
cmssIHJldmlld2VkIGV2ZXJ5IGNoYW5nZSBhbmQNCnRoZSBmaW5hbCBwYXRjaGVzLCBhbmQgdGFr
ZSByZXNwb25zaWJpbGl0eSBmb3IgdGhlbS4gVGhlcmUgaXMgbm8gc2luZ2xlDQpwcm9tcHQgdG8g
cXVvdGU7IHRoZSBzZXNzaW9ucyB3ZXJlIG9mIHRoZSBmb3JtICJmaW5kIG91dCB3aHkgWCBmYWls
cyBvbg0KdGhpcyBib2FyZCwgZml4IGl0LCB0ZXN0IGl0IG9uIHRoZSBib3giLg0KDQpUZXN0ZWQg
b24gYW4gQW1lZGlhdGVjaCBYOThRIFRWIGJveCAoQW1sb2dpYyBTOTA1VzIsIFM0IGZhbWlseSwg
MiBHaUIpLA0KdmVuZG9yIFUtQm9vdCBhbmQgQkwzMS9PUC1URUUsIExpbnV4IDcuMyBwbHVzIHRo
aXMgd29yay4NCg0KIGRyaXZlcnMvdGVlL29wdGVlL3NtY19hYmkuYyB8IDcgKysrKysrLQ0KIDEg
ZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdGVlL29wdGVlL3NtY19hYmkuYyBiL2RyaXZlcnMvdGVlL29wdGVlL3NtY19h
YmkuYw0KaW5kZXggNTE2MjQ0NDMzNTliLi4xODI0YWVhZDc4YTYgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL3RlZS9vcHRlZS9zbWNfYWJpLmMNCisrKyBiL2RyaXZlcnMvdGVlL29wdGVlL3NtY19hYmku
Yw0KQEAgLTM0LDYgKzM0LDExIEBADQogI2RlZmluZSBDUkVBVEVfVFJBQ0VfUE9JTlRTDQogI2lu
Y2x1ZGUgIm9wdGVlX3RyYWNlLmgiDQogDQorc3RhdGljIGJvb2wgb3B0ZWVfbm9fZHluX3NobTsN
Cittb2R1bGVfcGFyYW1fbmFtZWQobm9fZHluX3NobSwgb3B0ZWVfbm9fZHluX3NobSwgYm9vbCwg
MDQ0NCk7DQorTU9EVUxFX1BBUk1fREVTQyhub19keW5fc2htLA0KKwkJICJJZ25vcmUgdGhlIHNl
Y3VyZSB3b3JsZCdzIGR5bmFtaWMgc2hhcmVkIG1lbW9yeSBjYXBhYmlsaXR5IGFuZCB1c2UgdGhl
IHJlc2VydmVkIHBvb2wgaW5zdGVhZCIpOw0KKw0KIC8qDQogICogVGhpcyBmaWxlIGltcGxlbWVu
dCB0aGUgU01DIEFCSSB1c2VkIHdoZW4gY29tbXVuaWNhdGluZyB3aXRoIHNlY3VyZSB3b3JsZA0K
ICAqIE9QLVRFRSBPUyB2aWEgcmF3IFNNQ3MuDQpAQCAtMTc3MCw3ICsxNzc1LDcgQEAgc3RhdGlj
IGludCBvcHRlZV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAkvKg0KIAkg
KiBUcnkgdG8gdXNlIGR5bmFtaWMgc2hhcmVkIG1lbW9yeSBpZiBwb3NzaWJsZQ0KIAkgKi8NCi0J
aWYgKHNlY19jYXBzICYgT1BURUVfU01DX1NFQ19DQVBfRFlOQU1JQ19TSE0pIHsNCisJaWYgKChz
ZWNfY2FwcyAmIE9QVEVFX1NNQ19TRUNfQ0FQX0RZTkFNSUNfU0hNKSAmJiAhb3B0ZWVfbm9fZHlu
X3NobSkgew0KIAkJLyoNCiAJCSAqIElmIHdlIGhhdmUgT1BURUVfU01DX1NFQ19DQVBfUlBDX0FS
RyB3ZSBjYW4gYXNrDQogCQkgKiBvcHRlZV9nZXRfbXNnX2FyZygpIHRvIHByZS1yZWdpc3RlciAo
YnkgaGF2aW5nDQoNCmJhc2UtY29tbWl0OiA3YmU0YmM1MmZkOWUwZTU1ZGM5YTJlMDIzMmI4OTQy
N2QyYzRiNjE0DQotLSANCjIuNTYuMA0KDQo=
