Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A44CCCA5FDD
	for <op-tee@archiver.kernel.org>; Sat,  3 Oct 2026 14:33:52 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id CA9634546D
	for <op-tee@archiver.kernel.org>; Sat,  3 Oct 2026 14:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791038031;
	bh=NNuJZ22mA6zExssbWs2MLuIZS0TFSBHvc7ThcVwtvn4=;
	h=Date:To:Subject:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=15ghzn+jFbFsY7G/4o+OwaUi50L5bBk4kywLSEPJtOmLMc0xR6jrxf+boy7B0mAqS
	 4r6+Yswgd2OtnUHqcwDiT0zRZLG8sb8exZ3/D7RaauEUhgxDfE+nVZbidd/CXZ3qxa
	 RZ1R7i+AqwuQTXTLeAJOWZBW01G1s6zH8D5NHPEBQtbcvwKvAEGqZsR7VxAOxeH0xH
	 0k9dh2mjsMKClqocTH10yQB9zkRFUXrdPgr2jeDLyNk5WT/ejJxKZdlmzUkugXotEj
	 bZYEiI6VK92d3kPndkFOx0PFB6fOYqCLj4R6W2vWUoUg7S7zcu23OqCzGk1M40TDLr
	 nOAJ513Ur+heA==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 11A9B445AC
	for <op-tee@lists.trustedfirmware.org>; Sat,  3 Oct 2026 14:33:43 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AA5/QHby;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PALns8wt;
	dkim-atps=neutral
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 693E605s3845599
	for <op-tee@lists.trustedfirmware.org>; Sat, 3 Oct 2026 14:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=4I+HsFBWbk0PWJr2nHS6W3gE0JKJCyDL9/K2F33AB4I=; b=AA
	5/QHby7PdhLXGqSUGRfUdtuyf6DVwOKmUAvav3QvRSXiszqyuXSTdDMDS+5zpDJU
	QBADu/YRiUhi8MRSjtHbumWd6ZKRjuYkuntTdV54e0tSlXF5VrWoNjQZ53gmLq/D
	aTy2gYCfApfGjHpwW7d00ow+0nsA84hud8KO1n8vPrx2hfc7sHukmOEUyQSwmdz3
	vgjV/ZIZQ+Wn8cjXY4MrDjuKEHSdQdvtOc1mLs5F7uqwkRwLyP7GzvSR93bptPVl
	PkAT8mZu7ZLgOdmeJ1CABASAhbEPDIvBeyom0briSPi23BpAkw0l/DXJEIEv1ssB
	oREnLQzXkmMwcqIxyujw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2u08h23c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Sat, 03 Oct 2026 14:33:42 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93ae8e7e546so53001385a.1
        for <op-tee@lists.trustedfirmware.org>; Sat, 03 Oct 2026 07:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791038022; x=1791642822; darn=lists.trustedfirmware.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4I+HsFBWbk0PWJr2nHS6W3gE0JKJCyDL9/K2F33AB4I=;
        b=PALns8wtrwI5gyIwEwmPTS4BvN9A8McnXhneW6ryunmDRe3fuJ/zBQSq5o8HoIL8Le
         4BQCfDARYHMkKSgEt8Vl9uowp62PEfZZe5sG4jRHatfpywiydkqvVE5P5+6EJ2pD6TTS
         kgk6dVeY4gwAIdUuhnhXQlo9lcdNrjdgTtrLDFeZJaC1DADI4Fm6klFYO3wPQozSspk4
         ItSsBx7gEC0uxm3V5CRm/zDVfltBEs10lmnu6ad9k1mSlxb5lZlv+cDvQDe0r7/aq39Y
         zwXwjiD5tE4zgB0r3tA5PvJDghDs8NRcOra0Fpinkoy0JooehmMEiHQGxLdWKWqd3kJ0
         e6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791038022; x=1791642822;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4I+HsFBWbk0PWJr2nHS6W3gE0JKJCyDL9/K2F33AB4I=;
        b=qYmmElB+aDJXh+EVYdtaWnepopxp1xchh6fNnvrEDLrq69V69F4FxS9Ke6vJpYTEI1
         kTiWLqlefy1O6W03gmfr64wjsx9tqSn11a0Q0Kajpv9Q5+MsKFsgB/SSilIr+lXW41Gb
         pOo+3ZiFI7Klp1CzG2jy+MA/+etpa5rkBK6/jM7aFdnBuIWX5oGSQNXIOB4vADx2Hkfa
         wXOdkuGQbTeF+wy7vQ5aSBcWZL3QCcDUCEkxlZfF2iK5jrLo7vEysA6CrVZR/kdaN715
         GRfTFK/M5/oFDSIseQ6ePASVxnn9jAph8r6LbUd2vejMN1BVddURl7xguvF2G1qIJ1qv
         PN6Q==
X-Forwarded-Encrypted: i=1; AKwUvBxTmhF6Ozt26KURhBfOk/90R4VaUKPS855bKvGHHdCYROe0iPczhs6q7NJacybXndgi8EuT35I=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++lqmBZODpZ/S/zsjDEHCKATRBGNy74zSdCvT4BMpGFBo9qn3EU5
	rz2D/1qzKoSmJsaa7xh8+j+EfmSWTxy303rozmkAreEgoTHcAnBXTKrWl1t6x1bkUN2VmaSuUKw
	oBbRlAf5U9Iu800QuDuwiISM23IgUxXWa22tv+aNVlK5yy11tjKbeQqVTT94ZCmsnWnm+2A/W
X-Gm-Gg: AYBFou1V7HjZMtq1PAA6fQa10cv9ZwteBvqTVYlt9W4UTNCuCMr8vG2leNtXmAmGVvv
	c3gGlUYLfjhjZn9OJOnQGrsfgAvMgRSSdcA5Wozw9XU0R/Poiykn2vCv4dVKI6EO1E1wQSHBobC
	SQ5ku4BJrCE5qqURrhk7iZty+vLSyCFM/jDA2m2cG+Pc+lEyPf4gdrYyBsLCtm33HrhJLd5vl7o
	W0z8gbf/pxhDNRvNMRTWXYLiR8hDn/xrZ7xafF+cXtoXQdHiaxBqkW9nXnS381H7AqIIVqYDISs
	ZqlNIJcAXcJXgOTjLq2CE9C4LHph/m/A4d7IvPRKwB8H3pXmpxfEzHXWNUIXaCzkqZ6voUWQ5zj
	PC+8pj4IvyW6nUPLOI3MPhOXf9MI4sE9MoAjn3DD5qBeesA==
X-Received: by 2002:a05:620a:26a6:b0:93c:9c0b:3898 with SMTP id af79cd13be357-93cf18b370bmr1068488885a.59.1791038021684;
        Sat, 03 Oct 2026 07:33:41 -0700 (PDT)
X-Received: by 2002:a05:620a:26a6:b0:93c:9c0b:3898 with SMTP id af79cd13be357-93cf18b370bmr1068484285a.59.1791038021190;
        Sat, 03 Oct 2026 07:33:41 -0700 (PDT)
Received: from rayden (h-79-136-84-34.A175.priv.bahnhof.se. [79.136.84.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e4cd055c8sm199938866b.25.2026.10.03.07.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 07:33:40 -0700 (PDT)
Date: Sat, 3 Oct 2026 16:33:38 +0200
To: arm@kernel.org, soc@kernel.org
Subject: [GIT PULL] TEE QTEE fix for v7.3
Message-ID: <20261003143338.GA928803@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Proofpoint-ORIG-GUID: PWAdf_RhTtaWYmVc02algOiXBIa_k8yi
X-Proofpoint-GUID: PWAdf_RhTtaWYmVc02algOiXBIa_k8yi
X-Authority-Analysis: v=2.4 cv=JqlkP84C c=1 sm=1 tr=0 ts=6ac11246 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=dMv3lA6PLLkT9/uWe4YCGw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=DiaXWS5xduwjvWiepNMA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDA1NyBTYWx0ZWRfX5r+IiipVg9J1
 iWW9tLnHiM9w/tfdFh4l0QrD2EktjRsuj8Us4NM9BA9kP93yOtD6vCBJ8QvENrdPiUR1nES11wm
 /VOB7GVIO0XCb5sVQVAUXMpH7/IMHz0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDA1NyBTYWx0ZWRfX5S32WoE2we0Z
 35CT3ypnxmALk0S1Bo+2851d7Ia3JMEJuSXMrWiYB//JSGVHmqWqByYNHmK9gpDsqEOLkRR/XNI
 abXWr83bMScWILS7iIPvgJm61Jy4M81tMmKADfI3OTMy7PJgxnXEsHjRcgzbNfywfU4gJXlLaUK
 PM78lefHk1fjHpwZjSio9YPq95kyRyFgi5T+5W0Dapbx98p1IiLEQ94WI6xIe52bjvB/aXZceV5
 aQRH+i1qi6GJg8pkCwEwwdmIrJHnxrWBYms//NjzTx2muDX4TpM7AkB5w/6nIt8EdaSi/6VVgwc
 k/g6HiFUZYz1/hGFMLhS+swQxYR0vTYRfZJl/uH6Cxuckwz5D5Z4k9X8j3xGhKv3w8RNu1HB/vB
 msP5TCiveSur4WmVa+aaLm94TPDHnZFaQE0d92w8aQJW1FbIscyYb3qq0lWBMzRWANNGFB8v+sD
 NHOABhLJzvFs3JTz4cA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-03_02,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610030057
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.222.200:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 11A9B445AC
X-Spamd-Bar: -----
Message-ID-Hash: M34Z3PPKUY6IB7SHFVPHPYSZJXD62FFW
X-Message-ID-Hash: M34Z3PPKUY6IB7SHFVPHPYSZJXD62FFW
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/M34Z3PPKUY6IB7SHFVPHPYSZJXD62FFW/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jens Wiklander via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>

Hello soc maintainers,

Please pull this small kernel-doc fix for the QTEE driver in the TEE
subsystem.

Thanks,
Jens

The following changes since commit 8d3ae59288f1e7d58d76558a6ee96d533bc5019f:

  Linux 7.2 (2026-08-16 14:32:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git tags/qcomtee-fix-for-v7.3

for you to fetch changes up to 93847823b6761e1791a7db10f55bbd4f79fa0dbc:

  tee: qcomtee: fix kernel-doc warnings (2026-08-24 14:49:01 +0200)

----------------------------------------------------------------
Fix kernel-doc warnings

----------------------------------------------------------------
Babanpreet Singh (1):
      tee: qcomtee: fix kernel-doc warnings

 drivers/tee/qcomtee/async.c          | 4 ++--
 drivers/tee/qcomtee/qcomtee_msg.h    | 2 +-
 drivers/tee/qcomtee/qcomtee_object.h | 1 +
 3 files changed, 4 insertions(+), 3 deletions(-)
