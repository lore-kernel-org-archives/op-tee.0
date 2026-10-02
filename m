Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A512CA5FDD
	for <op-tee@archiver.kernel.org>; Fri,  2 Oct 2026 14:24:57 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5C1794522F
	for <op-tee@archiver.kernel.org>; Fri,  2 Oct 2026 14:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790951096;
	bh=g7FcE7gRQ5DvcafTEcDaKR+a2nLAMCLq+x2SfKEYHTk=;
	h=Date:To:Subject:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=K/UUbgWBXHsZdupCbyNuJD6nKYFEOFSh7q9Q6wLQME5/9BLQ+Fx3Q3Bi6GPq400yg
	 th0+kumjZcJP/UeJ9JYgzQrKQfVUoSB6+TaJtNZs5jq+67qV/TCi3blaqZtvNuJsp1
	 jdz4xNAjwTvuxkzphhknVSsu59jHDEy1YBzJXn9sRQrTgVV80fkcoIbl4iHnYA8yL+
	 Eom2gqTQroKBmfQBdqSWBa8sj9ZsB09Ufed8+ynrC0iaGyIULMlcylVWTXGNJNE/tx
	 3Bi9FOQ6l94qFnXINpBx3VzNA9Xq+GoCjl7eyV0wv+3z/SCxFvuP2QePSKX7j0qpXl
	 lQPdehJhPzmJw==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id D0E7D444A3
	for <op-tee@lists.trustedfirmware.org>; Fri,  2 Oct 2026 14:24:49 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=e6XSXM45;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DC/iTbol;
	dkim-atps=neutral
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692DA3YA1850252
	for <op-tee@lists.trustedfirmware.org>; Fri, 2 Oct 2026 14:24:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=j92JAvCjEE7IzGby2lySO9Ys3n40MTdxIMDeI4JZkMo=; b=e6
	XSXM45GKfzstKyQHZvb4ezVUfM6Jp8RUFRQoj5e3FFZro6bZl2vrN5OWY0mp2cze
	CBRQqWf9wWRm2IjguKrZHtOsmPocE0LxMmZUTLMeQ4XB2PK7F7mqHlXyieifDfFt
	PxrwmyTLmBwNe76YioL5ClLSU603mbOhMMeu2qPV6oRPfOnRxA/9ALnNkInNkywg
	F3enl/54ZYpEiOAd/OqM7mlu/6YmV1seqgzGwRBEcIGfes97VIC30h6SGUd2sKPB
	ZLLJt01XvR8fu1Kr5ttjJTSQe0tzvaNO4/R9oE0ZaaOA71FGf7vEe3iQ3ttZ5bgV
	tZcmufXBSKR2XVNQs3sw==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h20sh2ny7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 02 Oct 2026 14:24:49 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5c7c0d2b0aaso2470496e0c.1
        for <op-tee@lists.trustedfirmware.org>; Fri, 02 Oct 2026 07:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790951088; x=1791555888; darn=lists.trustedfirmware.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j92JAvCjEE7IzGby2lySO9Ys3n40MTdxIMDeI4JZkMo=;
        b=DC/iTbolU4FhW6XlzEkmwVxCwZqSNxV5IPEHPhMc8qC+hKhHo70isEOeaN46YqCKfE
         rXWPpR61KpPMuuegG/IJZo9BzvisIYkp6w/2DWVWHJ8xBJBNiQkT2GOIE6qCgLlhj6cC
         NRPIlch6e1/EMnFrEmOwaI8KRZ2GD2NY+BJ3K9ikvBi7A797YqDMerMUUA2NpLuE+Ffh
         pqWgRPDt7HO0clwiSp/47sF0hZJZZodxeIaTqozSA84TrKIIyiv6ABgSqDMXZu+08y3v
         OBGXrcmpr75xPd0v/LHK5gBXsO7UCIxuAYSnh3IxjOhCHSBPZ9Uwrt/IryXfQSJhh93v
         GbWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790951088; x=1791555888;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j92JAvCjEE7IzGby2lySO9Ys3n40MTdxIMDeI4JZkMo=;
        b=Hav6FKZIlHhBhtOhdRFONWm4HxM6d4GBowvdwxtqor4mvSmQcOzkyYh2Ef6BcNtwVF
         iLP36ABNvorYUsZgyW0DyxDR0IGpXqQNfFpTQ7yjQl6bFV68UtZdpGduSlc9NDKWqV2+
         EOWw6uinhoQOT++v/G725gT8JsuBZXfI57w3Vy/7KKk9Cj4sn1579hBJKurzJJBqawPo
         bFyH/aivYegy7kOFQkBfFjW7Tw6xpN4uaRow/4L+6WVz0+6HrXIYbmJG5urkWVfFDI4x
         5n1jjKb+7GdtvJyRH1cwtKiF1ePTo7zf7mj/0v/Bpnoy4Fd3gEEjNdm55ImONrAm6Tac
         kXGg==
X-Forwarded-Encrypted: i=1; AKwUvBzgq0EODoGjj7+OipxUFN08ez+IJlfZ2KkZ/UDFFHe/EpJ60meVbpC8Hbdlcjj+HBRP3rjogs8=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYJom4y64UlN2erpq6id8vkFPdqyKIQXrItoPCd1QRxT7f+AA7h4
	4KHn/MUdfgXVgGiWBHge/hlpPPX8e3GZO7iHMorEbpkxAQsM8hGXBGpMzu9FkMkXUp9rpI+1tq7
	gvj5uK1Gc3bP0dA9JpAYidOLSSvBVIF6Smj5MyJDNbZqfmqr19AG4ADajo3G0M3iS+f5S7mdQ
X-Gm-Gg: AYBFou1lL6Ff3g47VNH387oqHzNaPmMtqHhHrLJiFR1FHyHDO4CvuRsQEBAkc5SjkXU
	U2NqB93x2aJC1aNvpMpQsx+ojGLeWTxG6cyK50fE1rt4pImlD5D8X2sUXLbz03WXIgtRwWICtwB
	61SVem0yTFJhr6lNLgF95zULqTVrlTkIpH0n0D3KR0QjI65YZnuF3jhw18Brz/zmyp2Sq8lD04r
	d5VX68cmgH87Y2391BEOLJ447PW7OMwD1qtFBGLa0QUxNDj7q91HbJaw99iYSQYvu4fd9xXxwEp
	hFARl8PL7IeKBjQ91HrOcp+0ir3LZGNVexkIsu5/tsyR1ZP9envtwKv4Yj9P6sxJU7aKyTPwZrb
	OjpZ+DQo7KcwaHzTaWeL8C9HiOz3zVKovDm8hbl49IggwIw==
X-Received: by 2002:a05:6102:508a:b0:7a6:d11b:16ea with SMTP id ada2fe7eead31-7c0f4061990mr582685137.6.1790951088427;
        Fri, 02 Oct 2026 07:24:48 -0700 (PDT)
X-Received: by 2002:a05:6102:508a:b0:7a6:d11b:16ea with SMTP id ada2fe7eead31-7c0f4061990mr582673137.6.1790951087574;
        Fri, 02 Oct 2026 07:24:47 -0700 (PDT)
Received: from rayden (h-79-136-84-34.A175.priv.bahnhof.se. [79.136.84.34])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6af9d873682sm919852a12.10.2026.10.02.07.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 07:24:46 -0700 (PDT)
Date: Fri, 2 Oct 2026 16:24:43 +0200
To: arm@kernel.org, soc@kernel.org
Subject: [GIT PULL] OP-TEE fixes for v7.3
Message-ID: <20261002142443.GA778834@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA1NyBTYWx0ZWRfX9gPv8JomqHY7
 /wsbwNP1P/LCSKq2fkr8n4U+8WyhmHq05tCSSR7/Nbd+FCrhaS9VttUKYMbCwo2Hw00/9U2gl8h
 FN4aMBLWxLUSi2aJVqxwOeM0QeuuUAU=
X-Authority-Analysis: v=2.4 cv=IpmL47/g c=1 sm=1 tr=0 ts=6abfbeb1 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=dMv3lA6PLLkT9/uWe4YCGw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=pat6Al7auJUlNe7RvHoA:9 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA1NyBTYWx0ZWRfX9CcBYYNgr8UR
 o8Tfr480STw36jJDG6usYhaeokXpbrENpL+4wFKF8voNX/jrOANrFVPXTVnTi4+Fkeco6dot03k
 VcGGY1Cqly8NXJzBkxOaVo1p3MxHLPw0aHjx9/JitazPw/zbZZ6nGTTfy4WRr7W7uvs2YrWlTjW
 tLOPWm/RqrFgfIcSRjHHNWnqVHuNYUEMY2mcHRUhgvrjqIadlneBAK0dAZZsb5+Ip3N9lA0AvzS
 z/x9bV7Y5t9GbtBbvGqLQaBM/LzsjEVrFD7KZSoBfayf+MzViqB+b+i05JHtEUm09Ijl67d/4gc
 rTeUq29IsV+cN14gcktK9OYdbhYAfDTG3zW53lqonnrFZWDlnHqp/qKYpV5oaDNXZIAurRPFTnp
 fZXe9K8m9InQtea+RL5B2KVvp7/sT/HWXA0DE9YiKrzzl7Iln9GHQoWw7DxLn625k0C4+vMxND1
 yfAtnRCIZUzMv8otrPw==
X-Proofpoint-GUID: Rsz0SzqMyKrFNEOU39-6USA-EYgl69vx
X-Proofpoint-ORIG-GUID: Rsz0SzqMyKrFNEOU39-6USA-EYgl69vx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020057
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.221.197:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: D0E7D444A3
X-Spamd-Bar: -----
Message-ID-Hash: VMXMATNRMK6FMCMBOZNDU4OYYBWMKXD5
X-Message-ID-Hash: VMXMATNRMK6FMCMBOZNDU4OYYBWMKXD5
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/VMXMATNRMK6FMCMBOZNDU4OYYBWMKXD5/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jens Wiklander via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>

Hello soc maintainers,

Please pull these fixes for the OP-TEE driver in the TEE subsystem.

Thanks,
Jens

The following changes since commit 8d3ae59288f1e7d58d76558a6ee96d533bc5019f:

  Linux 7.2 (2026-08-16 14:32:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git tags/optee-fixes-for-v7.3

for you to fetch changes up to 3c0d2f1f431c51a11253f28763be723ac782fd7a:

  tee: optee: ffa: support shared memory offsets on large-page kernels (2026-10-02 16:08:05 +0200)

----------------------------------------------------------------
OP-TEE fixes for v7.3

- Register the TEE devices only once fully initialized
- Support FF-A shared memory offsets on large-page kernels

----------------------------------------------------------------
Mahantesh Salimath (1):
      tee: optee: ffa: support shared memory offsets on large-page kernels

Shao-Fu Chen (1):
      optee: register TEE devices only once fully initialized

 drivers/tee/optee/ffa_abi.c   | 38 ++++++++++++++++++++++++++------------
 drivers/tee/optee/optee_msg.h |  4 ++--
 drivers/tee/optee/smc_abi.c   | 17 ++++++++---------
 3 files changed, 36 insertions(+), 23 deletions(-)
