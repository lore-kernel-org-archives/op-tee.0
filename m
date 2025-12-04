Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E17D1F9A9
	for <op-tee@archiver.kernel.org>; Thu,  4 Dec 2025 10:17:48 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E47C75002C
	for <op-tee@archiver.kernel.org>; Thu,  4 Dec 2025 10:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1764843468;
	bh=v52SFDURowFRdMULRhG8kjrdaOCOeP9fHkUhxwRA804=;
	h=To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=hDAoRHPvdMOWzC8Hz8vHl/jznbuCGn97xrguxlm9XGi9n6IKnpeGOWL/XvJubGDaE
	 ToQhiz2YplRerhkVVmEPgIOjtDRwSmPmx9iN8lLQPpAatKjRy1PhfqGyBkUJMIPN21
	 +6Z3waMBKvnrx0gXm3Cw13BHsffdNsEY4dLnAZT/qEkFNxGYfe6ymb+EK/YQ+GMeU/
	 8FrV4PbiWdRgV57UhkLpjdsdfdijvk/FPmvVQT+nY0hY60C64b6ph/HGx22Qh6i5DW
	 U9R+eZBKEKbzqDmCOXRtOouRXlHHzcz0JlLRSt3uTTf5YtLoXW1Np13V9CkFUMaCVP
	 cNOeKCy9RFAzg==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E3A5F42CD5
	for <op-tee@lists.trustedfirmware.org>; Thu,  4 Dec 2025 10:17:36 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IHZfTd85;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8A126601B0;
	Thu,  4 Dec 2025 10:17:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E64C4CEFB;
	Thu,  4 Dec 2025 10:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764843456;
	bh=v52SFDURowFRdMULRhG8kjrdaOCOeP9fHkUhxwRA804=;
	h=From:To:Cc:Subject:Date:From;
	b=IHZfTd85ChaInOyNphBu+x+Ie9l0i63IWSsB8NINZT8i901DNyfDn1fPw7Ykfn+VA
	 sHai/AQaHrGAlMpTzFhmG0B3n8e1kmbXWPx1LdQp/d0JnL8hspJ6KhwcWCr/eX6O9K
	 bOCNJuuOWdGo5TgQJO2FduEBR18CgIDmgbFm0t9VQqhTfUfRFe2kJkqSfAfXkdhqgW
	 YVapBWjRPJviIQPdZ9xykW/r99F6hC4OBX5jtyiHnv1sWhvxxYqdJaBI2KSAD5CT23
	 52N1rP+MCLFoD48keb0UB31Cy8Bv3vWqpOb/k2eJV9JTKk2ZTg5TTzkEZMLAf8r8KF
	 WWdMkF2GYysrg==
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH] tee: fix tee_ioctl_object_invoke_arg padding
Date: Thu,  4 Dec 2025 11:17:23 +0100
Message-Id: <20251204101730.1036671-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ----
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E3A5F42CD5
X-Spamd-Result: default: False [-4.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	URIBL_BLOCKED(0.00)[tor.source.kernel.org:helo,tor.source.kernel.org:rdns];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DNSWL_BLOCKED(0.00)[100.75.92.58:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
Message-ID-Hash: DHBRGK5VBBEMLKCZJYBTTSXN7STM53UM
X-Message-ID-Hash: DHBRGK5VBBEMLKCZJYBTTSXN7STM53UM
X-MailFrom: arnd@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Arnd Bergmann <arnd@arndb.de>, Sumit Garg <sumit.garg@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>, Etienne Carriere <etienne.carriere@foss.st.com>, Randy Dunlap <rdunlap@infradead.org>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/DHBRGK5VBBEMLKCZJYBTTSXN7STM53UM/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Arnd Bergmann via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Arnd Bergmann <arnd@kernel.org>

From: Arnd Bergmann <arnd@arndb.de>

The tee_ioctl_object_invoke_arg structure has padding on some
architectures but not on x86-32 and a few others:

include/linux/tee.h:474:32: error: padding struct to align 'params' [-Werror=padded]

I expect that all current users of this are on architectures that do
have implicit padding here (arm64, arm, x86, riscv), so make the padding
explicit in order to avoid surprises if this later gets used elsewhere.

Fixes: d5b8b0fa1775 ("tee: add TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
The new interface showed up in 6.18, but I only came across this after
that was released. Changing it now is technically an ABI change on
architectures with unusual padding rules, so please consider carefully
whether we want to do it this way or not.

Working around the ABI differences without an ABI change is possible,
but adds a lot of complexity for compat handling.
---
 include/uapi/linux/tee.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
index cab5cadca8ef..5203977ed35d 100644
--- a/include/uapi/linux/tee.h
+++ b/include/uapi/linux/tee.h
@@ -470,6 +470,7 @@ struct tee_ioctl_object_invoke_arg {
 	__u32 op;
 	__u32 ret;
 	__u32 num_params;
+	__u32 :32;
 	/* num_params tells the actual number of element in params */
 	struct tee_ioctl_param params[];
 };
-- 
2.39.5

