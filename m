Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10608CA5FC4
	for <op-tee@archiver.kernel.org>; Fri,  2 Oct 2026 14:51:54 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4663E44E81
	for <op-tee@archiver.kernel.org>; Fri,  2 Oct 2026 14:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790952713;
	bh=bgnSLKi4/b9B9GDXumkdyb1pPNDSP+iHt4xwPeofyUg=;
	h=Date:To:Subject:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=ifvM/qLBMM9xq84AIfcn0oK0/53K4UNRC0cNouc5tQw22TpofS8B19oeZ/27aZOBf
	 Bzeg/oyn3fw0GcvP5AXSdPKXrhCkGV57faEzBXyfUhSGXBMqxNRAlDRqS6SyrmVI35
	 KaGZC1bgFlOJ6M0vSUOdmknRUWrP6wsCx8BiweiUF/YPKjrkfsYQs0ViHrD0Eujx6H
	 B9/egETkfgsOdbB0D+cqC0XrFzTWdPdgQfTl+BSQxMA+YzszkWsBSRoC8KsAJl2ZAU
	 UG7TJpEIb2HGTZbPxQsXnrPZkY9zio1YnHFHn1352Dhn+JFXkvwnzsCFi+b3C9aQYf
	 my4peTZKP//hw==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2627F444A3
	for <op-tee@lists.trustedfirmware.org>; Fri,  2 Oct 2026 14:51:46 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dhBVF+tx;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OL1nTpAy;
	dkim-atps=neutral
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692DuEba858590
	for <op-tee@lists.trustedfirmware.org>; Fri, 2 Oct 2026 14:51:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=FLt8/b5szxrO1yE3A4MoAlY9U9dMLfGLJMgXRz2x3bo=; b=dh
	BVF+txcnXqM5jDElFBtSzi3UALKPvG/vqcmvNptixtXuyhF+hAW62m/f1vJJm4md
	R3Og/HyjORcj4rZP5TKm8BljR8g6JHRg6mGo2Os0mcq/32A8W1VcKoovdyaUmfV8
	zb+M8NcHdwhWv4/VvGdHw0VATcUmUAjY3JZz66l3b1DhfLcv0XZNN0pbUUzC1zOi
	o3mIDjIsNea8nx/tl3DtlHQFr/mOmU9bwNkTo7IqCHdiG2qnPFhClYjgGcSLfUxl
	e9HzxMMqaQfC+jmM/yBZGsmWHso1sqNCmWrlh5yF24/J6MzWqYOltB5unAUoF87A
	EBq8dt0Mfbt5KJVSD4bQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2dxdg7g6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 02 Oct 2026 14:51:44 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7bf3a6cf1c8so1764514137.3
        for <op-tee@lists.trustedfirmware.org>; Fri, 02 Oct 2026 07:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790952704; x=1791557504; darn=lists.trustedfirmware.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FLt8/b5szxrO1yE3A4MoAlY9U9dMLfGLJMgXRz2x3bo=;
        b=OL1nTpAysLs25HWoDJnInnxM0ULUCtEnAUg9ThoSBBc7Gkcv9Oq2qmaRoX6lq6cTCN
         46JSfi8YqJYK0xQ8i+TrOONNL928YHTrQl74OE8FJ/EvWkb1u2Zqyycp+inNad4wvE3f
         oMdlNgi/xFe1U+9OYpjQgoRWJ8euA7tPiwITSfMaQCzO76g5IwErgG/wGAgvkY8DUdkc
         MgBzLoMeboWtFREKF4pXXJM0NV+HnMgT55oSZ8Rv7MAmc6J9zGLFgc+JUJJIfiNYGVAN
         9LFBx+3JRWxpgitC/Pizh3/CIj0x4FA9zijoMzoyoTPtPpTM/55G8XgWbTSGSbnCQzaJ
         PavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790952704; x=1791557504;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FLt8/b5szxrO1yE3A4MoAlY9U9dMLfGLJMgXRz2x3bo=;
        b=njAx6PvY6FTAJulHCspwq2e1nXe0WIEahQFdrh55SN6QJQcNC/g1gu7yWUt0F98Zck
         1go4rkF0oL6nbx1iStYi4jGnR5uYCaqWr+fi9OxLa/esQhC0f2JNoXeF2POBQVSZCgbB
         rXuOQuJUReocslfCjRniqGpLUK6vjUR8LDBcBdvDi+yUB8bY8FWSL8yUGJ99TE+R2axH
         22pfCLgdsDFkCKOBhZjSoUDSkaJrBNvNpuVeJ/aODJIy8asfgKdXouhocHB/MuK2Enoi
         m2ZOSGe1InFZGw+i9mqzSUx5eGdiLZpt582CoBX2J/MhK5gDELc9Y/hd6fV3ui0r75tF
         Z01g==
X-Forwarded-Encrypted: i=1; AKwUvBwBya221K6cKoUX1H36p45VeoORzoUErw0A0jDYPzg93wVKUgsjvl13Dw2JJ7vFCVaPi8WKs3A=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYLEJTcbf6t6YZ0+7SS7Ae9sdZ9TFH0C7cwMI+wzKHlYyGDydqoQ
	diTF7a4BMBYdB7Xl0j71pzB842fihKwz6FydNdU83TsqvfSmEtG10zLhNKOMeoPK+D4gjUaGPsF
	goWN0VbyJ3OK62p7nS6tDwEg/IsVtaCXPtyULrEOJvW/WM134QEZjJIZH0hJqK9V5ye/O0EDj
X-Gm-Gg: AYBFou2uvwc7RVGE+2sUPgcUN9GTc6DBcLBRZWji2OI/qgZlI9URdgXk5k2wloTn/bf
	xaesOTGKwVEnSW1t+djNuQkl6xy9COFmEwl+/OhcSWm6aDaODQsMlrMv5jX66B5aT+judrtOiUJ
	bsdyCmLWGWU99Q+HEWph6JLs1ryOHYJYL9jr5as5ZxTf1uMSiO738wD2AuInVDwnW9ZMcokGtCz
	IhMnkuXS+C0ZyuLp9KnyOuzEdL1PjcdvUkjzOlQIMLLf8BhNWLMy/q3UoPst94HOE8z7r9IVeHf
	oDWEcN5q21Sjj/Rx/lQPkWDE+wQCU5CLgBOKqxaBdFv4D9YpWA/zIHpI6nWfCqAEgslxt/i0QDM
	4UDUjiMX1TxvL91614G3Y2znfgPGdaW7cpfPbOWSqYYggbA==
X-Received: by 2002:a05:6102:4407:b0:7b9:fbff:6f9b with SMTP id ada2fe7eead31-7c0f5dab56amr815740137.28.1790952703769;
        Fri, 02 Oct 2026 07:51:43 -0700 (PDT)
X-Received: by 2002:a05:6102:4407:b0:7b9:fbff:6f9b with SMTP id ada2fe7eead31-7c0f5dab56amr815725137.28.1790952703291;
        Fri, 02 Oct 2026 07:51:43 -0700 (PDT)
Received: from rayden (h-79-136-84-34.A175.priv.bahnhof.se. [79.136.84.34])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bb7c79d725sm801547e87.46.2026.10.02.07.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 07:51:42 -0700 (PDT)
Date: Fri, 2 Oct 2026 16:51:40 +0200
To: arm@kernel.org, soc@kernel.org
Subject: [GIT PULL] OP-TEE update for v7.4
Message-ID: <20261002145140.GA784348@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA1OSBTYWx0ZWRfX+h9uyJWJ/hK2
 QDGT2bvExors17vH91i+IohAEtZf7hYmKjuCxowX35qpXv2DenfH382lTklHMmvUJzEDOsVguO1
 +4t4puaaUDBlqWML6oWKak3rTnJRCIE=
X-Authority-Analysis: v=2.4 cv=Ko/YSmWN c=1 sm=1 tr=0 ts=6abfc500 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=dMv3lA6PLLkT9/uWe4YCGw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=Uv-ToYxd9aUZ_shOWNkA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: qXVtyRRIH8z6KcYq_hgUlv4Zb6eK8NUY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA1OSBTYWx0ZWRfXwXPBTbEoz3YP
 HMjhmxOCRBJtLhH2eZwUMV262DBnEM4QB6VUbf8j7Dp5M+kjzZN8ZWok85v0Eaqgz0ya7deap+N
 lJjqWPp0HU93i5AocJnT6R4+HBoLjzUv6TYAD2iEH80A1+khYZYTN6tl3+L6P86lOdoTwlMWlZY
 amJQqHVXokxhzy2UNGSjCU+HVuCldkPxxsvRz14p2Tv+l8/ifse2T/OaC7ZHMRRVbUX2/8SUfiN
 6D01NVBiUNFybdOk9DhztZFe4EEz5cgBSF2NUDoeW+cQszIV+flw8EUZWc2ZQfrrvcrK5JCkCR4
 vlQY5JX5lyhWeP0pmeznJQBDkV/DqZLKtI94jDIo6izENU9zpzeHbBwx87pPpmivsh3fHxc7pxN
 jakgdmHFA4fLDQV35eCykp9K/1lsO6pIuBO1BZ4W/Sdf6T68YbfHX3BYdbBBTCu/mo6iTmZ3Ld9
 5J47fud3tI81K8rT4UA==
X-Proofpoint-GUID: qXVtyRRIH8z6KcYq_hgUlv4Zb6eK8NUY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020059
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.217.72:received];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
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
X-Rspamd-Queue-Id: 2627F444A3
X-Spamd-Bar: ---
Message-ID-Hash: CZBMNSLVTRJ7IAYKYZ7ZNWX4JQQFQP35
X-Message-ID-Hash: CZBMNSLVTRJ7IAYKYZ7ZNWX4JQQFQP35
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/CZBMNSLVTRJ7IAYKYZ7ZNWX4JQQFQP35/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jens Wiklander via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>

Hello soc maintainers,

Please pull this patch to only build the SMC and FF-A code where supported.
The OP-TEE driver is still only built for Arm, but that will change in a
not too distant future.

Thanks,
Jens

The following changes since commit 8d3ae59288f1e7d58d76558a6ee96d533bc5019f:

  Linux 7.2 (2026-08-16 14:32:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git tags/optee-for-v7.4

for you to fetch changes up to ccd4b23398acaf2139cf04f1ba0a66150cbf2663:

  tee: optee: build the Arm-specific code only on Arm (2026-10-02 16:28:41 +0200)

----------------------------------------------------------------
Build the OP-TEE driver's SMC and FF-A code only where supported

----------------------------------------------------------------
Marouene Boubakri (1):
      tee: optee: build the Arm-specific code only on Arm

 drivers/tee/optee/Kconfig         |  1 +
 drivers/tee/optee/Makefile        |  4 ++--
 drivers/tee/optee/ffa_abi.c       |  8 ++------
 drivers/tee/optee/notif.c         |  1 -
 drivers/tee/optee/optee_private.h | 39 ++++++++++++++++++++++++++++++++++++++-
 5 files changed, 43 insertions(+), 10 deletions(-)
