Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1098F606A333
	for <op-tee@archiver.kernel.org>; Fri, 13 Nov 2026 07:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=DGQsO/57;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tuxist.de header.i=@tuxist.de header.a=rsa-sha256 header.s=201705 header.b=QZBF7X6t
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6BFDB45532
	for <op-tee@archiver.kernel.org>; Fri, 13 Nov 2026 07:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1794554171;
	bh=mg0x5rDjyJHeegva2tK/1nH3N1jsByv7W4sRT6tEZZs=;
	h=To:Subject:Date:In-Reply-To:References:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=DGQsO/57j3sJ9QHVf0fYlfraSfF7ywu5pV01N8Ih8JPC1oHABLE7Uw5+cP2Y/09Ze
	 4055xyiRqAQHN5Bd0lvktIoEDTJzXW/HfysLs4zcJGvnq4uHXk+gDyleWU05keQzDv
	 v6hxqumhvaAgYt/E/RLMmwckKyTqUOZv2O1s/c7taff5jULejautabnXziKEqT4oc+
	 CqGGfVS9wbLHRTf1O/+3jqZYVfD4Qib6d5OjKL1z5Ap85X828lz+0M6nKNFuIje9FC
	 Sp3fGG2qH+PcRZmuWzWkzCqzqWxxndGOoOoIidCw462I4cAXagaOx2lx8/yuTdDmDI
	 qCTKfuTfgUeNg==
Received: from groupware.tuxist.de (groupware.tuxist.de [173.212.254.19])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 037F341BD6
	for <op-tee@lists.trustedfirmware.org>; Thu, 12 Nov 2026 15:39:30 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=tuxist.de header.i=@tuxist.de header.a=rsa-sha256 header.s=201705 header.b=QZBF7X6t;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxist.de; s=201705; h=from:to:subject:date:message-id; bh=8udlVznDmTmreQTpbodXPVihca5cSx/h/aNayesau9E=; b=QZBF7X6tXzDwTVM3svJQvgPvKkQordUMpL58pUIAAvmTUZzJalXlg48lrAl5y9JJ1FuLyMjTV+Ej0nKrSCfFH/d4vdhSSY1GTh9gduwsVmSj7Wz9GNMYa5+4BxXvTfCJyjhouy5m/LJz1L4X0SLn/uZtjYZt+XBzmKXdOLwhpsGuxN8WAqZZLjVGbwYQq6mpUiRf0QuIS9aGKLe3YYC7a9bK226sh9TFm6AunV7FxE8AH3jWWD2Rd66Hmxc9lzE4/IgZyApUy6jJpek6LhjSyfJrkgNJh/bBkqNRKtyfhUnbKmEfvzjvbs5ZCZuI/AkkP5UOGocZWykjA9226Qi/1Q==
X-Virus-Scanned: proxyplus-clamav builtin
Received: from dibsi-vdi.intranet.tuxist.de ([94.31.110.105]) by proxyplus-primary (ProxyPlus) with ESMTPSA; Thu, 12 Nov 2026 15:38:48 +0000
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/3] uid_r: convert tun, ivpu and tee
Date: Thu, 12 Nov 2026 16:38:37 +0100
Message-ID: <20261112153841.1661720-1-jan.koester@tuxist.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1792552161.git.jan.koester@tuxist.de>
References: <cover.1792552161.git.jan.koester@tuxist.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.69 / 15.00];
	BAYES_HAM(-2.89)[99.53%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[tuxist.de,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tuxist.de:s=201705];
	ONCE_RECEIVED(0.20)[];
	R_SPF_ALLOW(-0.20)[+ip4:173.212.254.19];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[173.212.254.19:from];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_RCPT(0.00)[netdev];
	ALIAS_RESOLVED(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ASN(0.00)[asn:51167, ipnet:173.212.254.0/24, country:DE];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,kernel.org,redhat.com,linux.intel.com,vger.kernel.org,lists.freedesktop.org,lists.trustedfirmware.org];
	RCVD_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[tuxist.de:+];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 037F341BD6
X-Spamd-Bar: /
X-MailFrom: jan.koester@tuxist.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: AGF3J3MLEQPXXZ4CI6I4AZ7F4V36PSMQ
X-Message-ID-Hash: AGF3J3MLEQPXXZ4CI6I4AZ7F4V36PSMQ
X-Mailman-Approved-At: Fri, 13 Nov 2026 07:15:53 +0000
CC: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowangio@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Karol Wachowski <karol.wachowski@linux.intel.com>, Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>, Oded Gabbay <ogabbay@kernel.org>, Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Christian Brauner <brauner@kernel.org>, netdev@vger.kernel.org, dri-devel@lists.freedesktop.org, op-tee@lists.trustedfirmware.org, linux-fsdevel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/AGF3J3MLEQPXXZ4CI6I4AZ7F4V36PSMQ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: Jan Koester via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jan Koester <jan.koester@tuxist.de>
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Building the UUID/GUID id RFC (uid_r v2,
<cover.1792552161.git.jan.koester@tuxist.de>) with a distribution
config instead of the one I had tested with turned up three users of
kuid_t/kgid_t it doesn't build with: kuid_t is a tagged union now and
has no .val, and it no longer fits READ_ONCE()/WRITE_ONCE().

1/3 tun: TUNSETOWNER/TUNSETGROUP write the owner and group under RTNL,
    tun_fill_info() may read them without it. Mark that read as
    data_race() instead of READ_ONCE(). Only classic ids from
    make_kuid()/make_kgid() are ever stored there.

2/3 accel/ivpu: the per-user context limits are keyed by
    __kuid_val(). UUID and GUID users share the (uid_t)-1 bucket, which
    only makes the limit stricter for them.

3/3 tee: the TEE_IOCTL_LOGIN_USER client UUID is derived from the
    classic uid. With __kuid_val() alone every UUID or GUID user would
    get the same one and could act as any other such user towards the
    TEE, so those logins are refused with -EPERM, like ublk refuses
    unprivileged devices to them in the series.

These belong into the series before the patch that lets kuid_t and
kgid_t hold a UUID or a GUID and will be folded in there in v3; I'm sending
them now so that the reviewers of these drivers see what uid_r means
for them.

Jan Koester (3):
  tun: read the owner and group without READ_ONCE()
  accel/ivpu: key user limits by __kuid_val()
  tee: refuse user logins of UUID and GUID users

 drivers/accel/ivpu/ivpu_drv.c |  2 +-
 drivers/net/tun.c             |  8 ++++----
 drivers/tee/tee_core.c        | 13 +++++++++++--
 3 files changed, 16 insertions(+), 7 deletions(-)

-- 
2.53.0

