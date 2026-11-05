Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C95606A31B
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 10:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iPGeVb7B;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GntvJDf8
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 74BDE45477
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 10:44:32 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iPGeVb7B;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GntvJDf8;
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id F3E0A44D8C
	for <op-tee@lists.trustedfirmware.org>; Thu,  5 Nov 2026 10:44:13 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A59tMCe4084489
	for <op-tee@lists.trustedfirmware.org>; Thu, 5 Nov 2026 10:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Xf5/vbep3X8hdJmcdG1lebyy2JgNR/ibl1SZ4lYtaMg=; b=iPGeVb7BdAkbKkml
	kucWy2KtJOwJtWPRILOKbGgMeGzqd7HZsNS7MqkLvb2XsSsEh5l6QFeHhUO1H2qo
	DCqD41pSkVqlIdMB/ugOpvmTaC73582Qlc+J8uDncjYQrFnlibWZ8vYtZAixYRGJ
	ckEr+dBbOO+R8H30dJr7socVsuVNfG/+C33m/+OapZ+5P9NWsFO1SXrb6zyWliQw
	iXPyFoJxtpL7TKgpSV5Cq1dG454acXFP/Or7Un3hgN169Gaez6j4gZmKmskQo2uC
	ZahDH46LOf7UtvzGMFfG8pwTr2Ib3qzv10GHAdm4dpocvfUSFoKyVE4bYGnVr5Bb
	WOAygA==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrqhkr6p4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 05 Nov 2026 10:44:12 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-8b155f4eb8eso26632627b3.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 05 Nov 2026 02:44:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793875452; cv=none;
        d=google.com; s=arc-20260327;
        b=Kgy/n8jhv4LuzGEthvz70rRWymOuxVGvPw2OoblZ9fY/oO8/hVulsCE5/W+GQmXiWd
         99M5hdg0Wgj295ZplDjh9WJml0u4qW6TKCrmzfUUfIo4j8gtnTvu5/kazSq3VNoSABag
         Bb5dc6xTBaR7RlQUL7Qx4m3y6T3dAs5dmXtiUgOuELx7t3Ub5gFBcvgnXkgP1iReSX4w
         vyQQHfSH/72S5bHs+xxd1VbxpIPc7ZJuDD3UFXwwq9/DZT7jPg6VJXT57bqeuBM7wOF6
         i2ISa8owYM2xzacQK3Sub65GmPMu3C3JARSZNJTmo/r0fsdHR4+Wyrp+wUF+2Y/qLQKW
         DnYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Xf5/vbep3X8hdJmcdG1lebyy2JgNR/ibl1SZ4lYtaMg=;
        fh=zTS9K1PnkBMqo/Q9XoAlwIISZeJutVtc2poAaYPjHHo=;
        b=eQz/LbYlzEbYeCgolzJdYVwEi6oXrcCbRicWT0RHmgYwHwxbNQxucolwiydjtUzU10
         resgotN+9TM61nuW8heMkLRDFU56wBhZCdpPFfUAJJ3ZeMDnPhgw4ZCRcYjZ92dUzwJC
         SK0PLdlIsrh7c0HahXkqWsGDvLhnk6Cw9tU6TXeu00U1hSg9jHlygP/SaC/yoRdsFypt
         QMjcpV5aw4LvbVeNJEhP+QmlfI2rLhMXV6rD5Vns4CRW2pVOK2/yWe0RfYeyDKk5BJ7E
         sXtO1ANwjzYD81OoF6TuSBrQkizmPlFScDYHYPziyhNRkjR/7BTsu/WiuDAc8lHyMyj/
         fSbg==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793875452; x=1794480252; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Xf5/vbep3X8hdJmcdG1lebyy2JgNR/ibl1SZ4lYtaMg=;
        b=GntvJDf8Lyuvw4BjOtH3TIqFV04v70uIR4rfR99h4mCMVJtqQGTe8xPhBdBEVHpdfl
         NlctvkAVeSyQPN+oTHiKqfhfXSEgK04cqLFjBf6MNHMPAsHJKGvQpMgihnNi6qvg2mPt
         eCIuSbr/ypgx6pd4rRBsOKnKTlWEajYJM11zc9z4o/MDDkZPEz8ZXqoVw8UuzE+Naaoq
         2MYc1fhf5inVSSPJuMwdtO5WJSrK+vr+qv5s8TXxqpJHtBGpwGN5NmiN8yLl7lin3lrd
         K/cyoYSD/teMmPPS2v4wFcIZKBVvgYpGu5rVe/wK10dDKSKe1IPK7tc2MiEQk96+LrYz
         hzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793875452; x=1794480252;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xf5/vbep3X8hdJmcdG1lebyy2JgNR/ibl1SZ4lYtaMg=;
        b=ya1EDgYC4xP0c6+s5Uj+KwXWJUbQxwvN+7Qbvs3vPJMJNTGIzDlZ2mckr9/RMCbpSH
         kSUTlm9I1QjrykVHLFLKe2Wqz8qZhXLdDrfidWubs4IE9mDGNFB+LaH5VKSNx5ifNWYj
         GnG7e34u7tcwsGVxhhwmi7Q8E5JhDX8BINZaJjUgXqCPk7RAD9z0sNP33BYgQShiJZJ6
         Mt16oX9pI1ouqE8Bp8W5iDjdZErjNs5xcfVCJH2i1ZDQZJBE9EhxMIeSoGAAHOfIWFiv
         Ydx3Y2kotb8Ex8SoycSgwHN4vuzWDLThDdI7fTLFi3zyXKeR58VPUnLM7Ixf7M+bML6S
         1tMg==
X-Forwarded-Encrypted: i=1; AKwUvBwpMM5BlOpiw5nNcFWFJdwRWy1aZPBpbnG7jOkXa/JEAvqrnOsScpNYoafvkfL9O9pn4SMbcJU=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z/sSKNgSPIE8PFw/gExnXUeLw1DzOv0Qc9RhLZpP2a4Pofpy7o+
	v5gk8oT8xXFNT54SMzwIO5C7RasC+KJCU80gFXhTENXIoVK5lXGZlrRFu17WUoY64O1J27uM0XD
	eOrnrwLtzMAWExhMFVrgT3Bp5Whndhn4dottKjvqrVSg47713A20P51o5FvPkIb3U9rkBaLNK0R
	MVwR28X2hufsIhDi3bHGw3qDptM8YmVm2ZXpX3lLn7EeFNhHY=
X-Gm-Gg: AYBFou1TmnbqiWruhglEGWzEVPPo4/czesPOaYo/B0qi5ZHT5OFEUlSqEkPwk9xoL5A
	ZBEZ6pj+5j4qvvPIfx3T/I9BuzOWZvE5PESlWkJVIlf50K8iVK6qqy6tUvLRL8NdZnBfPKF98yI
	DIcfuTA8AigKFmCCHbooihbIs6Plqi2DT7YU/UQStBqUWUnKU9Zx30GJaL2PnLtpNyu+QKUghJ8
	JzIyy63VpVZBhNnTRmbIxgJgDWDX/b9KBbeFdzw
X-Received: by 2002:a05:690e:4145:b0:67c:a2c:8240 with SMTP id 956f58d0204a3-67c0a2c8545mr466487d50.78.1793875451492;
        Thu, 05 Nov 2026 02:44:11 -0800 (PST)
X-Received: by 2002:a05:690e:4145:b0:67c:a2c:8240 with SMTP id
 956f58d0204a3-67c0a2c8545mr466481d50.78.1793875451076; Thu, 05 Nov 2026
 02:44:11 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261009-fix-tee-max-keys-v1-1-1462d96bf438@oss.qualcomm.com> <atYDodGDc3z6Qv4f@sumit-xelite>
In-Reply-To: <atYDodGDc3z6Qv4f@sumit-xelite>
From: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 11:43:59 +0100
X-Gm-Features: AclHuK82I7GOQ461EBrvJUf4LJ_kffL5_IxDC54rT4pmONT0rZ70Os06qoD-B9o
Message-ID: <CAGgiveW5pqputgg6EcOCEGEVcBhyjrPUZ_8WKD656tWnw9sMcg@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: allocate a bitmap for all valid notification keys
To: Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0MiBTYWx0ZWRfX8T2Ijt0uCn0U
 VCFF5P9sX2l6BqVa/sk4MD7gtd/88XRzLGvDu/aH2/yR+nwB7W3dC5RxY6V4kyxiNLLPZKiy3fi
 xQOa5PFaOiFok2zMiJjUq9kcn5kX2aQ61Jm9Asp0qL5LDw5mYTORd44PRSZ37WXprEuNW5T1rZP
 caVgcONWrIKkiIegVO+Kdq+50yyrD+GtAsVAYRaFcM7290zUITf+NuJT/2AX1/25GoYyw40Hqef
 8xk9Awnj42I0tfb680meXTYJP/sCXITL+rrLQFkL5uOGJ5arbURXsoBN1TCsTT5E95OKZtNd0TW
 my+dpWLQeaNFMq3DHIfgCMJB+XNx+ymGO5lmvvMVbVVqVOzd3Fcuqu9VTdUez+lXQ1iqqRglV6o
 4DDrc+m0r4aH74wWH2yPxxxHmSqmnJMcPJazuPT+Mgl3W+0CazQ4I5FRBBeBi1+DiDi9mcb1XJ8
 uba7/S6fHstb/HR6AUQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0MiBTYWx0ZWRfX+EEHAQXauSJC
 wD2RCZ7C+cjoy0mFWP/hRm8Qe1eOuIjFq2hc5YQkDlB+ZM2JvDRw8nO/oLLVU+lBY1RQc/mJBqd
 O/anzfS+P+Ywe656SzLvb7rKFi3A4vQ=
X-Proofpoint-ORIG-GUID: bEpvveQWuR3ybuOx2x4eZ5w_aptRr-pc
X-Authority-Analysis: v=2.4 cv=a4+lZkSF c=1 sm=1 tr=0 ts=6aec5dfc cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=VaSOubSYdYwWsDXPSwkA:9 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-GUID: bEpvveQWuR3ybuOx2x4eZ5w_aptRr-pc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050042
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[oss.qualcomm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.197:received];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: F3E0A44D8C
X-Spamd-Bar: -------
Message-ID-Hash: SJB6KUZNPARH67Q4DJQWOQ6NYWT6TZGR
X-Message-ID-Hash: SJB6KUZNPARH67Q4DJQWOQ6NYWT6TZGR
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Jens Wiklander <jenswi@kernel.org>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/SJB6KUZNPARH67Q4DJQWOQ6NYWT6TZGR/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Mon, Oct 19, 2026 at 1:48=E2=80=AFPM Sumit Garg <sumit.garg@kernel.org> =
wrote:
>
> On Fri, 09 Oct 2026 at 20:19:48 -0700, Amirreza Zarrabi wrote:
> >Notification keys are checked against an inclusive maximum, but
> >optee_notif_init() passes that maximum to bitmap_zalloc() as the number =
of
> >bits. The bitmap is therefore one bit short. When the maximum key is a
> >multiple of BITS_PER_LONG, accessing that key reads or writes beyond the
> >allocated bitmap. Word rounding masks the problem.
> >
> >Allocate max_key + 1 bits so that the highest valid key has storage.
> >
> >Fixes: 787c80cc7b22 ("optee: separate notification functions")
> >Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> >---
> > drivers/tee/optee/notif.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

I'm picking this up.

Cheers,
Jens
