Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB1BC982FA
	for <op-tee@archiver.kernel.org>; Tue, 22 Sep 2026 07:53:21 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B3AED43AC9
	for <op-tee@archiver.kernel.org>; Tue, 22 Sep 2026 07:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790063600;
	bh=11b+lqzscsdK8Ta3S3pSJSA/n1DvvcVP456Pe6Yhyds=;
	h=References:In-Reply-To:Date:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=XIS3JyNDqOni1xn08lsLITNJkWx8O14JGg4PnWuUcPH8bbWjYkYISPON98CosPBwo
	 JAIe/0MeG2cRoiDggd7/eFcJCJyG7qaPImSAka5sVxWsQ/xluW1LVlpPKPR7yJndsK
	 HH3R7io9MfgP8WLyNoQsT1XIAZPS5y8gZu7idFVQDceEaxV5N87Ax1ofbhHTJRYcq6
	 LxEwlDKdBB3CVRJDuzHhWnXGYkr5cNIU5lYO2g7lKbJvzFhcWwjY8nRyWAOOaWtk/M
	 qxwot1syxA+ofsLeV4RnJRYpBfyhIxY1GDoM8mR7HQHITenpv5SlBEL4oxmYF+Yac1
	 kP9EECq4/jjDw==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B987343AC9
	for <op-tee@lists.trustedfirmware.org>; Tue, 22 Sep 2026 07:53:13 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HJM1jRTJ;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EvhiX2Kw;
	dkim-atps=neutral
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M7Fqkv3044233
	for <op-tee@lists.trustedfirmware.org>; Tue, 22 Sep 2026 07:53:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eM4o3vQJG5YSqEOi7+3WJZVTDqM9mwXMz1W8oS+gJdw=; b=HJM1jRTJWzZcVx+p
	mWV08rpifDcLwRU4dEETmvvT3bgJAlIPB4g3kaqx6I9Re+H5w3ftTAXJJSef9bff
	oVhbHiK7C9XnMMZLHuTU45pO+uplMp/JFmBhXKk9/vifIvm0buSM0gc/U5ZpN2UH
	7ENVnTgHl8wUHxxL/TJ0HKk/V4O9OWkyvkxLztXncllM6rlDdHEYEwdIR9Vh+Snj
	530fUHFUzMEoKxvWYt9w84s1r8r0beYVGR/3/7xPE2e73ZCWVDrgG7+REhBMLsJl
	n6KSRZju/Zhcuxn0Dwf00a0z8yL8ykyRJ7ueyn8/TGTEc6sUecKVZ3XrSq/c9PJ4
	6rrMJA==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gufbasexv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 22 Sep 2026 07:53:13 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-88e06764219so44844327b3.1
        for <op-tee@lists.trustedfirmware.org>; Tue, 22 Sep 2026 00:53:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790063593; cv=none;
        d=google.com; s=arc-20260327;
        b=U4S6zxrj0sqLxFgwMrNYm3oXG0wH4DTqa/Zch2qIY85qJk99Ou2POiyYvOMt/2PQql
         dLHch9q2Vqr6tkrO1aQWoi55G5hKMCYnN1H2+hQ2oKQfSQjwB5k8MelZN7uF0dKssykU
         i6ILBFMi850T72O+55ionGzwR2/Di+hkFA5zLqsERUFSGV5HoYu5tLQx0a88AgewoOS8
         mtOhmUIe4ybAAiKv8Tdy4eFLFK6wn9oHehhkHu3UEHyT9OhlSHlAcP5MYuims7SqJWCg
         9/E22xmfohJZP0nwlWhspESOlXK5kRKE6D0kuN8acJqJWER1zdXPcHY4W1dpgyZAY04p
         Zhbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eM4o3vQJG5YSqEOi7+3WJZVTDqM9mwXMz1W8oS+gJdw=;
        fh=YwoLHg1WGWsfMwliVWaGQcH9X+aSN/e+poAIP25aVrY=;
        b=NqsTZYVWQp/d+Kj2VXHobKex9z59eAf0QlY7QiJ1Fm21poJ2OvBFE/USxBmyi7NIMf
         Y2w/0QbpvtvDs7IEt9my5Gx8O4QXyG6yAr0mmQYoL4X3RUlAkiAJSGjcaC3vEOy38vnA
         iJnKcOVDuUDhiTERFKvl3jO7PL1zQ3F0T4oIkiDw2vbGnUEmhvDaHkQ1etjbHwAMVY+e
         9KB52JURx3E0g+pWfhwOoVomqOe0ZNLQUNJfMWbmhRCO6/Etm3aECVpniIMUITGBfUih
         ttJyQEJUTsqE4bFv5msEQ9j/R8H5zt35jktYvDnqXPSza4s9obm/5u+eOaxg2+oX+YIp
         TMxQ==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790063593; x=1790668393; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eM4o3vQJG5YSqEOi7+3WJZVTDqM9mwXMz1W8oS+gJdw=;
        b=EvhiX2KwGhxVDPzPjIFFOD9SEDRdc5aD2gC4oWByMv1xUVcCvtMbW5g+T2au3zdOG4
         s8yLL59Q3uj2y9+GAicmmUXcueQ6Q54NUl62Iop7NQSdT9J8it9dwtAFjnAFofOyScT3
         aQL0CsVQcKAlkLGIp3flwt02/ALYCkTS8pDG8RZWVfOIBl4bTsEiiUxYqS8yUYod2JoS
         vfeqq3n4j6wl/fbKhFSesuCG/UtDvYaUIjNMB1Z5b96cCAdXQHZQ9R4eGz/8hGCGN5Lp
         xvcX/4Kgh2oqZWYutC0EJHuddKqESChgnk25hkEEXvL5EQPkc/gyxvDJR3ZKupGcM8mZ
         6o1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790063593; x=1790668393;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eM4o3vQJG5YSqEOi7+3WJZVTDqM9mwXMz1W8oS+gJdw=;
        b=jSVIw1Gx59fMRznFaLy0dZCuyDuYkK1ec2oQ/FZzAZNyqtxO4wTNLOFbVginl7aoJL
         waiQcWropVcTdhopc2Yf8cT2iNx87+oDPjpvocBgtRZqmnmCJ4RvU0iTbwRomZsmViU+
         1DDOf04jy8cnpB74x/FvD07Yl0AiBDAOSEmTYUiHn/CbzP3iOHpKAGeouD4qAu2fCKK8
         lV3vFCRynFRr5pXWzTtRf0Vpn2bktRPDxmOJg6L1P2WNocIfgeiPs3CUFyIwH4bZ3L9F
         24zy1jLZS4yqhT2rh6rWjWKg/15YCDrIjewcRBTXKfi9PQqbj3foX/5MVrMEN+yiXkjg
         b+oA==
X-Forwarded-Encrypted: i=1; AKwUvBzhDDoMFOU5ZuPA0g6nSSA5Hv2JhWxgkCExmLGw2Kwf9RCeSEA1Up+r3p4Q/a9kCVCGec2p/ic=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++kdDX9iSUlrpbay7MpNKi5fh7vPhBZQTW7RYMKeJiY+mwso3arP
	5bZ8CRbpbq6JDACZb1432DUUN629H62b+xCEZiucQT4j4zxq+jfkZN5wsv0VmJTqLJQMenr/mSq
	qg/bLTVm7G53tp5/cMHyk6jY4iqQjoZCxif8HYZMN7ijZKHZj2mdV4Os771TnOjhyJviSjUKroR
	QvVL2wBTFbzUeJJzmaHseGXNmwu6cde3aZssq87wUltgeSapk=
X-Gm-Gg: AYBFou3WjaigSnYovwQphipAwiJ7MZzLh+1DcpCeSXi8LAam5cMWHexZs6g3jjloFDP
	3Urp1Zt/dhfF66myFyQNwHJZKMPh3dh7ajW+M78nR5l0wQmg+5xFMZaQyJnNVvO4VXh5+C9wM6G
	IIeeIxDi7aKPZpkRjCW/eems8bna/CMlFi+Ue3ZmoiCgkMgRPZ5B/MBpg=
X-Received: by 2002:a05:690c:34c9:b0:8a2:2993:5237 with SMTP id 00721157ae682-8a22993528dmr6368427b3.26.1790063592659;
        Tue, 22 Sep 2026 00:53:12 -0700 (PDT)
X-Received: by 2002:a05:690c:34c9:b0:8a2:2993:5237 with SMTP id
 00721157ae682-8a22993528dmr6368287b3.26.1790063592222; Tue, 22 Sep 2026
 00:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260914175435.118303-4-marouene.boubakri@oss.nxp.com> <20260915020235.507302-1-marouene.boubakri@oss.nxp.com>
In-Reply-To: <20260915020235.507302-1-marouene.boubakri@oss.nxp.com>
Date: Tue, 22 Sep 2026 09:53:01 +0200
X-Gm-Features: AcwNN1XNGpI1PX37tg0BbLtLSRsjIrFGw8p2FV8jkmKL1NiS6WMD2T0eaz1XIwE
Message-ID: <CAGgiveUEFL+UWzydBGxVveadffpO3BWbKjQ1UbJ_dOPgLu2m4A@mail.gmail.com>
Subject: Re: [PATCH v2] tee: optee: prepare the driver for RISC-V
To: marouene.boubakri@oss.nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDExMSBTYWx0ZWRfX+jbf+CmQQR5f
 EZQz1ZIuTUyORIhIqW/E3pl04HabeI26ZJ4Jqc1vpOc0v/sGp9Y3DbOAigenxwEBLlcsSheXgfF
 1BBYuk4tuaIxZo/q5u1F6CMq+82ktDqaoX68MoS77oMCXyA8YJ/MNAvsL/mDIMw2nAkTgm+pOwS
 N+m4nhDnWLaoeOzsnEaF4U0a6qb01/IlC3Vet/Ar1XWUrN96cdoupgf8wgbevGp9bd1PWQUcy0u
 tNQO9x9VLRXuGT7CNvluN30kijpu9laKSEb7aKf9MsSXfqrSc5SyC+/+QlFo34GD8Y8vMzjR8QM
 QSKV2NcrLxO9B4A2NpsB6UGZbuMyqnWiS9foCvqDpcWuoPzOapIVHlxVbXaWMQV1R59RlN8C3xd
 HTqFZELFEK+mDZJLo0G79KG1mNUKAzMJPQMnoGuy/Z0fh5CWnPqcgxOE8XCkp7riQcYTVglO2BO
 gSxBzAGY1bfV1TUu1uw==
X-Authority-Analysis: v=2.4 cv=IYYSymqa c=1 sm=1 tr=0 ts=6ab233e9 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8 a=8AirrxEcAAAA:8
 a=zEqzrABc4qne4u8U3FwA:9 a=QEXdDO2ut3YA:10 a=kLokIza1BN8a-hAJ3hfR:22
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDExMSBTYWx0ZWRfX998eMqVXjDuj
 Pf9+svXwP47+EAt8S5bAivB3PDC983bZK0HBB4oLyUmELCOsW+y6zq+1FanAzkuy3/Dk41PTHmV
 edvq4zs2BROnHnsRNRnJISk35nwRH+4=
X-Proofpoint-ORIG-GUID: S-VerH3QNGW4vQv984xMRoQGzuYAFpSB
X-Proofpoint-GUID: S-VerH3QNGW4vQv984xMRoQGzuYAFpSB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220111
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.128.200:received];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B987343AC9
X-Spamd-Bar: -------
Message-ID-Hash: HIGNGLW6MVIRCAPMJKUABCWO4EQMA6CO
X-Message-ID-Hash: HIGNGLW6MVIRCAPMJKUABCWO4EQMA6CO
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-riscv@lists.infradead.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/HIGNGLW6MVIRCAPMJKUABCWO4EQMA6CO/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jens Wiklander via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>

Hi,

On Tue, Sep 15, 2026 at 3:48=E2=80=AFAM <marouene.boubakri@oss.nxp.com> wro=
te:
>
> From: Marouene Boubakri <marouene.boubakri@oss.nxp.com>
>
> The OP-TEE driver reaches OP-TEE through the SMC ABI or the FF-A ABI,
> both specific to Arm, and the TEE subsystem and the OP-TEE driver
> depend on HAVE_ARM_SMCCC. On RISC-V there is no SMC instruction: OP-TEE
> runs in a domain isolated by the M-mode firmware and is reached through
> the RISC-V Platform Management Interface (RPMI), carried on an SBI
> Message Proxy (MPXY) channel, for which Linux already has a mailbox
> driver.
>
> This series only puts the build plumbing in place for a third ABI next
> to the SMC and FF-A ones:
>
> - patch 1 builds the Arm-specific code of the driver only on Arm:
>   smc_abi.c when HAVE_ARM_SMCCC is set and ffa_abi.c when
>   ARM_FFA_TRANSPORT is enabled, with stubs for their registration
>   otherwise. The SMCCC header, the SMC and FF-A specific types and the
>   SMC RPC register parameters in optee_private.h are kept under the
>   same conditions, so that nothing Arm-specific is left in the common
>   part of the driver;

This makes sense. Thanks for the cleanup. I'm reviewing the patch.

>
> - patch 2 adds an RPMI ABI placeholder: an OPTEE_RPMI_ABI option built
>   when the MPXY mailbox driver is enabled, rpmi_abi.c and its
>   registration from the driver core. The transport is not implemented,
>   so the registration fails with -EOPNOTSUPP;
>
> - patch 3 lets the TEE subsystem and the OP-TEE driver be enabled on
>   RISC-V, and teaches the memory type check of the driver about the
>   RISC-V page attributes, without which the driver does not build
>   there. It is kept separate as it changes the dependencies of the
>   subsystem-wide TEE menu.

I don't think we need any empty shells. I'd rather wait until we have somet=
hing.
So please drop patches 2 and 3.

>
> There is no functional change. On Arm, OPTEE still depends on
> HAVE_ARM_SMCCC and the SMC and FF-A ABIs are built whenever they can be
> registered. On RISC-V the driver builds without any Arm-specific code
> but no ABI registers, so it does not load. The RPMI transport will be
> implemented on top of this in a separate series.
>
> Testing: Tested with the configurations below, riscv64 and arm64,
> built-in and as modules, and W=3D1 at every step of the series.
>
>   - riscv64, minimal config + CONFIG_TEE=3Dy CONFIG_OPTEE=3Dy
>   - riscv64, minimal config + CONFIG_TEE=3Dm CONFIG_OPTEE=3Dm
>   - arm64, minimal config + CONFIG_OPTEE=3Dy CONFIG_ARM_FFA_TRANSPORT=3Dy
>   - arm64, minimal config + CONFIG_OPTEE=3Dy CONFIG_ARM_FFA_TRANSPORT=3Dm
>   - arm64, minimal config + CONFIG_OPTEE=3Dy CONFIG_ARM_FFA_TRANSPORT=3Dn

Since this is a V2, I'm missing what has changed from the V1. The
patch subject prefix is also incorrect (the V1 was correct) and
confuses the b4 tool. When you post a new version of a patch set,
please don't add an explicit In-Reply-To header in the cover letter to
the previous patch set
https://www.kernel.org/doc/html/v4.19/process/submitting-patches.html#expli=
cit-in-reply-to-headers

Cheers,
Jens

>
> Marouene Boubakri (3):
>   tee: optee: build the Arm-specific code only on Arm
>   tee: optee: add an RPMI ABI placeholder
>   tee: optee: allow enabling the driver on RISC-V
>
>  drivers/tee/Kconfig               |  2 +-
>  drivers/tee/optee/Kconfig         | 10 +++++-
>  drivers/tee/optee/Makefile        |  5 +--
>  drivers/tee/optee/call.c          |  8 +++++
>  drivers/tee/optee/core.c          |  8 +++--
>  drivers/tee/optee/notif.c         |  1 -
>  drivers/tee/optee/optee_private.h | 52 ++++++++++++++++++++++++++++++-
>  drivers/tee/optee/rpmi_abi.c      | 23 ++++++++++++++
>  8 files changed, 101 insertions(+), 8 deletions(-)
>  create mode 100644 drivers/tee/optee/rpmi_abi.c
>
> --
> 2.34.1
>
