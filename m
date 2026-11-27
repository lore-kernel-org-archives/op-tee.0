Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4AF606A31F
	for <op-tee@archiver.kernel.org>; Fri, 27 Nov 2026 11:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CESoDuWm;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q9yt1GTu
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8CABE5035F
	for <op-tee@archiver.kernel.org>; Fri, 27 Nov 2026 11:23:46 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CESoDuWm;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q9yt1GTu;
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4959B44F32
	for <op-tee@lists.trustedfirmware.org>; Fri, 27 Nov 2026 11:23:41 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARAq9DE054488
	for <op-tee@lists.trustedfirmware.org>; Fri, 27 Nov 2026 11:23:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=oyVIHwUXpz396ww9F8tPBI9FmpRAp1M+eoT3A1GyqyU=; b=CE
	SoDuWmuat23oe0dRvY1isOww1tPGxyTPRtmwQoJLYRvXTaW8T5/rUzU5yaqQE+m/
	B07WDfw9ogcSAfzdvjE21c/0WTJhGjDeqq4F4709YLTdVarNLbV641zj/dxIR9Dl
	NTL8ZNK31mirP/MsE9aAPwwA1BQ9ADdBO1Z/DojicveBrDcv/k5HYbMXPwz1/nAp
	O65nQUj8tFkW59sWDBwELn4fwsZnEohdAMa+28p1IquzHep5OB4YknCJxcL+5QRF
	l1tkGTuBZBuTxBGX6/bpulj47Q0eHRrMrHlKkLToW+G9AypjwdOGVXlIqgL4A/lz
	Teh+BWz2NtNDzXr3IX0Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j74g6s5rt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 27 Nov 2026 11:23:40 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f3969a2a7so1119565485a.2
        for <op-tee@lists.trustedfirmware.org>; Fri, 27 Nov 2026 03:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795778620; x=1796383420; darn=lists.trustedfirmware.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oyVIHwUXpz396ww9F8tPBI9FmpRAp1M+eoT3A1GyqyU=;
        b=Q9yt1GTuifpQAokAJYMXrcOHcfEct4hO9zicP/ZZFAayjyZLdugnTCD8MMTuIgwlqc
         3BHlTtwCvg/+sldSJ5E+tGidKV/CuojJ1ao9VMXX+oLV/XRTPUXKYCZhmbhGUf9nhA42
         DwT3YdHBk3munuIC/p+FkOFqTNhreO8+ZdgScvuzu4vNyNcdeY4vRuFvq1tpAf619S/E
         pJugJxysKi6vlGOl8p0WTlknVOR6Hg3v1Cys8YrcbTugikyV8e3o5CK6UQO4rnB90Qsn
         2dwr434ezmOtXCaMMxLnF0KA31DsDhObDxFMpTSqCGmVbYgxpRC24crxQrU4s9CpOdTc
         i5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795778620; x=1796383420;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oyVIHwUXpz396ww9F8tPBI9FmpRAp1M+eoT3A1GyqyU=;
        b=pDK6zthnJh8qZtTvoBhlQ+MdNPma6q2R9AtsrqvySmrjyNvhrKG/62LDWch1Jw7Kzk
         M+PI3b3i3ailpfJslZojpXlYu9ahG8TOSwafgCgagmjmAQmBNlOFYlyqWAJndDfSt/V8
         M4qkpPbNndlQu/e/wj10Nt6TYS3ATEfmG3gX/7TcASAbjcX8oqS1t362EgCYtMQ+tcld
         opEeXZ7bS2BxtiK4mAtk+bZMmzk24MzVHZweMfe63Ld2/njnG/mTIgV5mnmIPYya4sY0
         O5waqmIEXvGWcvrLRpWcAfjplrswBLDV2AuxmJQfqbZjeFa5IkT7tU24Blk8Xu2ls7XY
         lH9A==
X-Forwarded-Encrypted: i=1; AL+hErG0q5vbiuaxS4q/cFglhWaBIjrw0zoCcakL20bVXKXDp8chNg0SXGEDUZrbkLg8dgQ8zcIHzvI=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z/FdeTxamKbpEdMXQWRb1oMnrpLACeSDGxN0T18QBYcuo97UV0O
	UuDZeNPaXJyspWajSYCwP+eevYvKmIUDI7n0/ORI5AbkGvNCnMMkABpk782gswUrVVab9VgojeE
	E9uw1nva8TMsoIMqlqyxkL+XwqfsGIC1XOxdZMpGiON3Cbn7jGXNnDfXB9oHqBCGc8hcLxEfZmN
	RYXRorTQI=
X-Gm-Gg: AZFdTZeu9mpulzCo0exUT5E46U2cS/gQ99Q76TOJk+OvmTLrzYg06yDNlU8i3LK6jaM
	QUpTeekrCMAQMXfFJMSCcykhM0IClf8W+19mSPNDarTTZvSl1C5x1nxGJjBzMLMa8KuTKGGjGNX
	Lda+jeV1pS9WASi5RWyjUGoRc+MUkpcr0fOvlrJVJtm5HeLiBbXUyBWzwH5YMemKkAnCEFs9t2q
	ySfqPwklXP+HuVbJdgeHNN7Q9kevKW6Qv1/+aDDVc1woZlxiqsSP7IOiDaDkH6nU+2NE7vwUQIB
	b4i9kwaLTI6EdPLQT7ZcaNHUT8HjPjtKzYCW8hiJhYxUlj7c+YN7ZQLKrUPmH97theUC+dDlfjP
	krl8X/Vkv0/nHxpkcx4VL0Y1tC8z2adEej9uJOAID+C18l1+hzZR3pgcJ23iwhoDD2IislqSvho
	fRhDWvtTuaWjqrJDFfuuG2PkthNtsLvk3KP1kAtsuuk3e3zJyZu9jIAHtr3++VpRjvBCQ5OsNvW
	4gn
X-Received: by 2002:a05:620a:28d5:b0:949:6d4d:2396 with SMTP id af79cd13be357-949ba9c6ac4mr4095406485a.27.1795778619974;
        Fri, 27 Nov 2026 03:23:39 -0800 (PST)
X-Received: by 2002:a05:620a:28d5:b0:949:6d4d:2396 with SMTP id af79cd13be357-949ba9c6ac4mr4095403085a.27.1795778619548;
        Fri, 27 Nov 2026 03:23:39 -0800 (PST)
Received: from rayden (h-79-136-84-34.A175.priv.bahnhof.se. [79.136.84.34])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370cb764sm11193958a12.12.2026.11.27.03.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 03:23:38 -0800 (PST)
Date: Fri, 27 Nov 2026 12:23:36 +0100
From: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
To: arm@kernel.org, soc@kernel.org
Subject: [GIT PULL] TEE fix for v7.4
Message-ID: <20261127112336.GA2749856@rayden>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Proofpoint-ORIG-GUID: Z86P-GHoCzi49TjXruVIMRMacw3Y1X5a
X-Authority-Analysis: v=2.4 cv=U5kHnuru c=1 sm=1 tr=0 ts=6b09683c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=dMv3lA6PLLkT9/uWe4YCGw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=KyRjHmHKXXPnJxnbqygA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA0NSBTYWx0ZWRfX6ZGtmEkmqWiR
 s1sYXBx5XI5jKScGGMF46tlmbTfxH2B8hqrq+FQ1pPxtazJQYuY/X0HnqWJFJCVIwiuzOwVYS8B
 pZ6fDLBaRNrpFfdjH7ox4qanvlr/b3A=
X-Proofpoint-GUID: Z86P-GHoCzi49TjXruVIMRMacw3Y1X5a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA0NSBTYWx0ZWRfX+RVS/f+7K9TX
 bWLxWv0Ey6ZwYNWIuSAjiAXUuYNpe9nrYUAiGvLz3e2jkpIlUf+nv6ICpqtLYyOmc7mcvuIPfmS
 6qR3HY6nwbmsahDkOeduxQgTjP3EGtbUohSsw3Mvw5ZtITu7OP/iMF44IHLk/XJcC7Mlg08SOoI
 S/UPaW8OaoV32/vNksv5c/rCnjeccnF42VJHcfzE7yFqWVsV7u2w3t4QGNt0T1ozlbJ425TZdhF
 fyZc4t60fHBY7ZfAJ6q2i2EDuy2u5rGAhNO5n0wS7Ny+JG5dcMiRhTvB2BLdcAFEFXHKC2bX9qh
 RrdqzXX2D9LXzwsLy7vI99SzgwBDIvx2qGALgqJPA20VrUowz2EaketOiPztYJNHzOCyUdFHTB/
 sQKCwTQyRb2kS6I4A3n4o0j+RlnPeczrcP16rCtmNPyx3MPeDuCGFjaF6Q16BVpIoqUdQGs+0e2
 Qfslk26Y9fvv0R5ZXMA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270045
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[oss.qualcomm.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.222.197:received];
	NEURAL_HAM(-0.00)[-1.000];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	RCPT_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[79.136.84.34:received];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4959B44F32
X-Spamd-Bar: ---
Message-ID-Hash: CRSXLDLEKYPZZWN37OWKH6K5CIW73BRP
X-Message-ID-Hash: CRSXLDLEKYPZZWN37OWKH6K5CIW73BRP
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/CRSXLDLEKYPZZWN37OWKH6K5CIW73BRP/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello soc maintainers,

Please pull this small fix for the TEE subsystem.

Thanks,
Jens

The following changes since commit 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4:

  Linux 7.4-rc1 (2026-11-01 13:26:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git tags/tee-fix-for-v7.4

for you to fetch changes up to 76313284b6a34ae7fde7ce18f815d25bdb1f5e62:

  tee: avoid accessing dma-buf shared memory after put (2026-11-09 17:10:38 +0100)

----------------------------------------------------------------
Avoid accessing dma-buf shared memory after put

----------------------------------------------------------------
Hongyan Xu (1):
      tee: avoid accessing dma-buf shared memory after put

 drivers/tee/tee_core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)
