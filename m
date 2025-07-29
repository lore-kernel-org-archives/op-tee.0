Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13004C83F26
	for <op-tee@archiver.kernel.org>; Tue, 29 Jul 2025 16:54:43 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3A6944FC6E
	for <op-tee@archiver.kernel.org>; Tue, 29 Jul 2025 16:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1753808082;
	bh=inGoQI+jlKm0Co+aY7zk5G2hEN40oz7ZZCbFKqxests=;
	h=Date:To:References:Subject:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=KPZEkC6I64e/wECX9NkYiK3O8ld4/XKALxv4IYIzumt7aYGFbpJDJ4Vg6hyS3D5I4
	 Yjm96uQPjNNeWSA+HXog6paUNOFoJaYihcsmbHH/jbhZIdLcDmFSDeGSH3x5w4d1qZ
	 y9rw+swpIyjqytgL3AuxQR6wYHYn5u6UADVBKhVmQb+FdVq3gIok6xFYHY8fhCADn1
	 m3D5nMj7kLBBDSuaZQ9IGubMLhppyyLNbwRUlt8eEmvPSeMZDLntoICp/zVVjerZiP
	 N7rwDiPuast7TxD5PL6l+ej9ei0EGm4S3gTMjeeh6feCiyFosSIrlEJ2eN0Jqa8GNE
	 WV2eWN9GjEFRQ==
Received: from mout.web.de (mout.web.de [217.72.192.78])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id DB6454302D
	for <op-tee@lists.trustedfirmware.org>; Tue, 29 Jul 2025 16:54:19 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=WsTQF9iz;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753808058; x=1754412858; i=markus.elfring@web.de;
	bh=inGoQI+jlKm0Co+aY7zk5G2hEN40oz7ZZCbFKqxests=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WsTQF9izZGYSsBCZfbSHdquOBEyRXNsUSgPEcxgEIxYYQrzdJzAdKvnR02xmQZVS
	 MPnnEugpvQGklWoGftws8P3MpE52IprrijgFWa5A7eT9T0HRaLRFI/gGbM3T3l6t0
	 3NWiX+1xPQw3pEIcQNjPE0KRa3+G93Q+rndQ8pGLq4rNLxBFB7+GP7wolPkCzehu/
	 lsGFIjMtczyS5m/Uki7gJZIMq9+u3+Ip4t4D24nryEtDDSDHVvrS7dC0LbKDvTps8
	 ajwz3HDGpuEGBMCHm9fBP9Bk7L8w2VzEDJJlEj8+MowOkqYgwv1dxbGe0o+YAsq6T
	 gZBy0+eHFz9/8VZKbA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.201]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MMp8Y-1uzQPG00DU-00RlRG; Tue, 29
 Jul 2025 18:54:18 +0200
Message-ID: <c36fe8e0-332d-4453-817b-89fee2525fad@web.de>
Date: Tue, 29 Jul 2025 18:54:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Pei Xiao <xiaopei01@kylinos.cn>, op-tee@lists.trustedfirmware.org
References: <ae66122a86295f0ca5f2ff385ac2850360a805c1.1753251689.git.xiaopei01@kylinos.cn>
Subject: Re: [PATCH] tee: fix memory leak in tee_dyn_shm_alloc_helper
Content-Language: en-GB, de-DE
In-Reply-To: <ae66122a86295f0ca5f2ff385ac2850360a805c1.1753251689.git.xiaopei01@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ukuw785zlRpcHAZNQe983kdqr0vrMa2ucPuxnjyNRiLmvxF/Py6
 trA/lAiSy5XMWTmf2WtFAogyGyXxRhy1JJhUp67OLBTp2hOYzSHdFfNWax/mH6Lr/zeT/Qg
 p3u74fAZ1BtwFu6xbhsl9tfycZ+rqKmYDhs1f5WwxewUWdyFp3QQMsUJk6ybCRo+c+RqHMW
 /AnZsDBmO17KY58f3qknA==
UI-OutboundReport: notjunk:1;M01:P0:mCC/UdzyTC8=;Y1j3B71erkza1Eb5BBgRtzhfYZD
 8+9OJorHX55NKV1RMzYpVsB6NjWmMRfnvVIbiZ+XBhoZENkAwFlj8KRpfa77M1uVLWcbxmNS4
 zNGnQcg+v9Yd0G04Ryo3wachu98dJGhoRoBuILrh6jJG9HUs9sd3SsULuie/U9KPd6K5AU87v
 4peaszM43NLPyukSOzueOFnj/YeIQmCMI6GJdjvzUuUy6G0yQhNfPot5MJBdOIRFDcHFSPsDq
 3FUqIEirq3eNXIIy8QKjSLMejMWiUAI+RZcD5+Mb9fCzQ3BUpa47KIKPMCjUCJMTEkCHPHlAu
 oHsNBXu7wB5On15RRqn38TkrjKf4P7HddkQX/F8vOqFXFH50F/ckT6Vtz3Tr1WeCIN/BBx11U
 FcSvg5E4lIzXjfnQIEYfKHZx5YPJ0I+cCVlKEb68887JVknsJo4yx49pIOaqoDRhxtoOltNZ7
 H9xqDdpV+yuCYHULxyu7YMx2+tt1AKFVMoce1E9e5s/vsjznk8a64T4hhSbZUqvXO5+P/gxxG
 OsEUh8Bjvy+rof84Win/kCTaAzTvgWPhFgHjYwJ9D8gLOHmOYmiej5SG6FCsD+raReDkOv/bx
 NvKwMRyky5mm15ykl89iOapa15XGGle7Ntm8U7SRsYKcoxAoqHnKImd/uHJvd6Ck/MwXntHIT
 OT9kPqabeN0RwJuNncPevB8ac1zKbvZr5EQZGAwFqLBEo5dE5kPn5iikqDjtyr6pH6Hc79krs
 o2VkNo7OjDUq7obUvh/smFbAVD7lZofKNrK7Yd119eUPj/SC57iqjjog/ErS6y6asuLy9gskf
 pU6OzoIzwhLAt4lx07i/boMC3oa0Jgn/Hao+3iTkNQK9ucmiSCgK9/fC+ELjAr4BlM+o4sjGE
 BRlgHnQt58Dh6ilzXbk3SqcJP0dJBGx5gThUGssDXSriPGKF3XjTxIn8GaN5pxssyhVIYzE15
 Xs+qUTGlfpDKenjg24dVzMlDDVqxq/8oX5GmWMfBN76Jreyad6RkEWXTw7NodGztehVQnXWRE
 wd6Pliv0hvWsY0GwdjVxXTO6hn+B7GImndjAaqHz+zTGzS7jjV7oZGGTOeCkmC0NI4VblrCWy
 RaBpIvQCj7o8o329KZcL+UAmIa2F7tb8o2g27JAFYLf7kcetLctrrN8DvQwR2U7Rqik7t18A/
 z6e5F6NdUgXns5KqXdV5jiBK6UqtHz/6SNBplj/nY2gDG4Qozklz6/qiV3j5iYypwgIza0l6C
 +cNEeA0+gyqzoiu0wOh9oCMjqAEOuryc46TQ6qqA7mxZsOCtX0fQounEyYE7IJ+u0q4NLzVp6
 TxcSVHoV7JlsLX+UMUe//g0rQAPGYF0jTmqxh/MW81KNu4WrwmCgOJ0dmPAbXk/Ark9wvQaOP
 wmLCex/+44b7QTYIgR/OA0/cY4plBPqDNittGa/6MiUM032VGbdHKCEcp/KoARl5pKQ4BxRSg
 12Rs9ySS9NPaV2lH4/uHAIlnS7sYQ+/K3h5/MUR0Dhm+n81Jt/P0zMtkY0VOPpkmtnzg5+HCO
 TeFb4/bOkrDBe0gfijW2Pp3Eul1nnMDP1KstS/X3efRzGbabmz3vGDCuAY0FOQ26oddS5BfG+
 DlTJHMbEZK/i6FZ0u7ZcrDy/p1lRROCLo2VRbc1LgRXQH4eLeXye47IY+2ZAgxne359IHttsz
 d8n8qhAJJ/OLLXfG55mZolFIbIAjHEh3u47yLT8bZ+UPTQB9mS7GirBzAuYpO/sbUsh7syW3V
 I2Bp+VR874ixchGzkRxv8dIAq0jZsGiuKXdonfCaNN/cYNsUL2FvsetxaBkoE2gJev+niqYnf
 KNSpmBz+N+QmIbf09Sxk5mDtg24RX8GbYlHvIE0nk1qYLYdNvj22VU9hAJCXMpKOxK/Y07vLT
 LovhylXD0qrK/lIVAhRONknPQcbtoMxq0OWGfvrGkBL3Hta5BPwVqbRFeHLK2pssFdDLNDJK+
 akbFMrINl6krcEblP/FJtCn4EbAEKpO4iBXdnkB0ecnb89dAm51g2TP/+9kGlfF2Wen/u6gmU
 xJ/4KAyMRzOn4MktRv6yeyXs0jRAMwn74EnAhcJmpQjLPZlVT3p8h7pFriftNNEYfh1qAGadB
 kQpdG5I2tycqvkxWxAQ28i/CXw8NpZ7yZknl9bg3ZKv1hqspR6W/g8XmapkQSmdUpjElnikWZ
 LK6nXBpQ2cArFfNcuCwOyGLNyrkLD+NahBCou2oh/FELL5YQVnNWjq2ki49acqAJWDxuLpFCc
 t56KESJb0G6Sjnva8R4BTbUsFbL0F5VQLBxrH1YWAMT05r0U5pBjVlFZMK7oNjlRYMJ31xuJx
 que6DVnDaEmSLJc5RQGIoR8gMKpEhdEOZTHiPOr48d5mkz2FlBSAQwYHxVoZJ+dRQNTwYVY38
 GBTaklgT+DUR8ksaOxJZIx+m1N04qs8XciMxBJYGjM05Tt9R3uRsiY0Q1+i7zntqc2jk4f0Gq
 KEQFXb+Mrwgz8zUNOm+rkwM1ISGRcMhWWzI4f8MMavbcMkdlZEiBCPc802tZ6in4RVSqFZxm0
 TatJmRX1SXzl9bhsIumM/jS3trFOxDvmpJJ8ymyT+elHlEnckQpmS/NF054fb+BIcyblZoigY
 lqui5Pg7QQ2hUU7SIYPpc6/4NIeOGXT9e4Sk/7qmxoU5WkTlaqNO9qhELC+QFz7GmQXRActsm
 yF1lcVvvTR0S/Q7aJyyaLZo1sc7gSBCsXntOraNVkq8p/N2/HnngAvvd6V99uVxfYjfGmxBbY
 qnLORT31fCagJADMxavbGHDpAPz7+yfoOd7wd6gT6WU2BH8+6YhqjYXCH1SxEi4ruTmF3ypef
 4p5O5/M5jb48NRrFNq4oDUw6WN0AAz8OhyyonaUwafWEzu5kR+luaRhg8TzCpdPeH+0n+rS26
 PkOnRFmtM2I8lKsSmdGo3G+IqeUMrnA9ZmvVdB3cwvfL/vQgqYwkdXzOSm3DUeFsHi2cMCuGH
 4WzXfc688/BUecXqT2K2SfSChBCT4td5T8tDHP89RQRawZnL+q8KMMnZ4hxDT+7CM075jIjA/
 Vru/RQxHf5qfH7GXNLGdWgEGBHXUgp5wSeAPj6g/dkBH8q1sUz4OFt/AZgCIYl4UKqsU8TGzz
 UuvEsvSncfyElxRdJPC/24YSQs8q8UQVatRYswOqvOiU43QXSCJ9X+YvgksMQQFA2IIQt0NpV
 4vU96fmGyU4Gyp9zxkisSEoBDdkQHVPzhBXF0tTBy6hNMV9BZAOn4KqnU2n/bTHPkLuh9PqQS
 VcGvhW2MRL0ZBnRcAFWECrbyMFoQokqIUWbk0/4q5J4aU12SFuKsJxcsHe4D2SPFoJodkVFw+
 U9fxgsJnecC2i+W/5f3kjU2CjKSD2Hx2UzoWumgLtVkw0jArcMaq30NXwhkKCSTfpsw5H3jg4
 Ue7vbOLydES52HNBnGMDoaF//ey8IcDX9Oc01l48AA/ATNqygqBIxMv8ZGoL3fbeHHwZMsTqX
 ie7nqfRaMQeVChNNJ6Gn8rfNJ1Jb/D+n9z+7bMW9+90/kavke+nEs
X-Rspamd-Queue-Id: DB6454302D
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.48 / 15.00];
	BAYES_HAM(-1.18)[88.99%];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	RWL_MAILSPIKE_EXCELLENT(-0.40)[217.72.192.78:from];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	R_SPF_ALLOW(-0.20)[+a:mout.web.de];
	ONCE_RECEIVED(0.20)[];
	RCVD_IN_DNSWL_LOW(-0.10)[217.72.192.78:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:8560, ipnet:217.72.192.0/20, country:DE];
	FREEMAIL_ENVFROM(0.00)[web.de];
	FREEMAIL_FROM(0.00)[web.de];
	ARC_NA(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[web.de:dkim];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[web.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: 2RY7HBXQNNF5PAFDEI7GV2COZO633YZQ
X-Message-ID-Hash: 2RY7HBXQNNF5PAFDEI7GV2COZO633YZQ
X-MailFrom: Markus.Elfring@web.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: LKML <linux-kernel@vger.kernel.org>, Sumit Garg <sumit.garg@kernel.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/2RY7HBXQNNF5PAFDEI7GV2COZO633YZQ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Markus Elfring via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Markus Elfring <Markus.Elfring@web.de>

> When shm_register() fails in tee_dyn_shm_alloc_helper(), the pre-allocated
> pages array is not freed, resulting in a memory leak.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.16#n94

Regards,
Markus
