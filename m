Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7174BC9830D
	for <op-tee@archiver.kernel.org>; Fri, 25 Sep 2026 11:41:00 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 72F01454D3
	for <op-tee@archiver.kernel.org>; Fri, 25 Sep 2026 11:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790336459;
	bh=2D3uL89/JQPQtiHFVdcupeNgMI7DOotuUFB6nC37h1A=;
	h=References:In-Reply-To:Date:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=NtBW8Pe0u3i2t8G/vXArEAmdDShMZr5zgNEXC6b9g1u3R8TnGRf8Jq6pinWnggnQ4
	 MpX55m40CoaxMCsnNYcAfR5cEP5I2yjepgyIopLLgnv82AvvK1W5ieRainS3MlshyF
	 LZWRObtpdBP0DqP4qTzoCzD5/gMA5rkExPYj2ArZVsTxHyz2fvWbk+/n9/QooRAAZr
	 nLgaCzJtMhf3cmiK88HcZwdngenLtBSIJN3kCBvSdMLqO0F9JygZMW7nwUg1IbkK9k
	 ZEIkEo3iyBX46L0GA4eDwFum56O5l5xyI+zlC+YZWVstJC3an/VSY39yT6prPVuf2Q
	 1xIhKv26Px7MA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id D516044471
	for <op-tee@lists.trustedfirmware.org>; Fri, 25 Sep 2026 11:40:51 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mJj1QL4N;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gdLZHSt/;
	dkim-atps=neutral
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P5J2rY756680
	for <op-tee@lists.trustedfirmware.org>; Fri, 25 Sep 2026 11:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rsNrOzwbCifpU6R6cJ/a5dsMB4faQfYqNwJbgN8GX/4=; b=mJj1QL4NL1LcI3Sf
	9kX2QOperICOQlPFMtnh7bHpFLC0junUGc/gBIo98esg2yuTqko1yUe9u0v/QuQl
	qrYi1caRlRO4Xnsm7CCya5O3d5QeUpE/UQexh0fcUTjT/4CLqfrVvmXi0MD7B9Gl
	i0nZa68+qYiJcLoaHXBSX8qHavv2xqM9r2nKbk5GZiHofhWV3Qw7qXyURbd94Hj/
	3GoOD/+i1qVTuyBFSMTgwJTT1ywRvMstVcY7JKGzURSfLr5ZC5S/Thah0QgzhYK3
	3EM8TJTEJ7Mq1GtfU0y89yww4q4TdBCriqKP1bfVokaN4SnCACs1LKW13ZH8ZTE1
	1gWcMA==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com [74.125.224.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwjq095kg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 25 Sep 2026 11:40:51 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-6741a0f791eso146042d50.2
        for <op-tee@lists.trustedfirmware.org>; Fri, 25 Sep 2026 04:40:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790336451; cv=none;
        d=google.com; s=arc-20260327;
        b=W/0RcWm3jwpjMTUavdQcOtAVNIlivgxgQlLXKRNYcMrONf2gAMbGYlXHHniHM6/K6+
         b3RNBAye4rpHOej2HLXkQuU8B5vobCnuOGh//KqG/TWhshhl495NSNAC8Ao9abzjY+ST
         AeOpsj37jQPX41e5cw744ngSz9z9N2mhObsDUR0VVajti6aHu/ZWJzPzn+PPmdzfrtHZ
         HljKPYo0hS8bXGk3CRXbvF68sZ8g6HwjUjqV4hoIN/PUQN9gd4cX4oYkbfUtaIf0FO3q
         FkyzPjd9imhPbQ8xtCdrJfwaKeOKarXeBHLFbsq8Y89qaIRx5fit7JjY8KPKH27W0MZT
         hZ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rsNrOzwbCifpU6R6cJ/a5dsMB4faQfYqNwJbgN8GX/4=;
        fh=QoZ+7fvhxfuvpPlFTt3TPDh2P3jxptLaKODY6m6i4lc=;
        b=SE2BZkx7hFmdCOIq/br1Qsm+pBoGSXksxmG1lJNxrqr2PZNWTFuMG7QKMXM0fWSgDk
         uesuDXiQsCSMDtq4NwRvomEdFpodEo9S7Z5CFO72UbFSHjZz74udjN7AMtw5Osxptbt8
         KG+k/cuhYAJRDHjxhBlSuEaeqEMDLVclDsCvmQD600RBFuGOPVMZIh0EN/JACfn0mUqG
         qCE9rXvoCrU45pzrCM+vN+t50vkxwQqB/9vyJzgT6NmvybWLzjV0kOk/ZHYu4Y5eQdfj
         rB1FaxT2olFCWpiD5xjBOPzf3WiEKOD+KkaYLCc1Vo42FCU19dhbFWEL6z5BZwWYxuWf
         jdiw==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790336451; x=1790941251; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rsNrOzwbCifpU6R6cJ/a5dsMB4faQfYqNwJbgN8GX/4=;
        b=gdLZHSt//zdV2E0dWb2LuI0Crl51AsEV5MU2C+CtK/ZY2i41ZglXo/Oum1H28dVLhf
         GTcjH3iINcecVMV9H4dxvB/5II3Rt/QaJWy6jwwKDfRHVPJwGAEoSB6wJk/C37HEvSKm
         jLktiAaXPXV9DQVu+J3QlVUXzgGE4GowAJbs2xUuJnkS7aHV4xCbXvso8XMHtqkXunkI
         0UeERbQ3vY5KdCdEJC5OFb+PRasheoi/gSO7ilsgsQKMLkp95m2HPHCByrKLtaIaYIu+
         Se+vRro02Gey7yHIcSGsMpDw/sR/rDq3Sm891dscrD6adCOMu+wwBAJKEEj0tANMdjEt
         qrTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790336451; x=1790941251;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rsNrOzwbCifpU6R6cJ/a5dsMB4faQfYqNwJbgN8GX/4=;
        b=aRr9yY9do15zxBotpRHflR+8OjOEDW1umSCz7sC4icMkDoZ0+mw1ml4bUb156gNvbY
         l1epEQY+ekN+q4y2XT/z6c6leOZDubYdfN/oteYX2E5V6IzjTcoI7hkKqoMH53rl1Vok
         S8T2hxLKmSoNDf2nO8ZUP/8bGcDDwLQiD5TRMp7HBLmURKy3kUkVGl0hs3d+bw38rgy8
         JORbsrvE2mfSS/0V56nCNS5sMVUSZ29nfIJ+1VX+4SKLIXSjZLfnOCxErC8XuhJWs5LK
         1qyA65zzWDs12csaGgnZhthQ9cyZxPH7l4cs3udlXE62Gnl7Ef0C6eklB95O9sJhBZgz
         xk9w==
X-Forwarded-Encrypted: i=1; AKwUvBy+M71JYzHTkyuh6fQ3/IazWpDdj9xYNjaiIrx1zwb2/DYIQq9HSS128qzRYavG9Uk8fn44y8s=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++kQ26+dzhNCg1p6lSRe417LiHY0sUw/6NK3axsNv3D5nHt4QQWZ
	EiCUmL7JjyLlijmIbgEGDOr8fwTWN23sndO/t2efYSLrvdwfh7Z/6NJOUMdZh9yIRMYPDQIWgS2
	um15FjkfN0iTect51Y9lt50q/z7beiaxanWYxyiC7dFoGJaCuIyxrrT/+3vCTRHvJz7USKdZax4
	DV8DeUYu2uH3K6HiuufZ9TFZKtD94/oFthUfV9fXRSKeWGc2U=
X-Gm-Gg: AYBFou0RWjg2eujvxe1A8gqhHoKBVjsc3XQKv62HsnO5Aey2Hl9DD5CILhz3w4AupF9
	18sfUkhQWL6DTyYKBL0ZD7jVbbTTgY2MngLhspVPo2ZdOCUgMHIksGq3dzcSC1izqODequYxrmn
	MzE9WGKmLvJSMa3lDxTVngDriBSB65/ZJk96j2FXMcjRGgPPpBdwzE24E=
X-Received: by 2002:a05:690e:4386:b0:671:5206:72f5 with SMTP id 956f58d0204a3-672ed447526mr2076044d50.64.1790336450677;
        Fri, 25 Sep 2026 04:40:50 -0700 (PDT)
X-Received: by 2002:a05:690e:4386:b0:671:5206:72f5 with SMTP id
 956f58d0204a3-672ed447526mr2076032d50.64.1790336450169; Fri, 25 Sep 2026
 04:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260924105145.532787-1-marouene.boubakri@oss.nxp.com>
In-Reply-To: <20260924105145.532787-1-marouene.boubakri@oss.nxp.com>
Date: Fri, 25 Sep 2026 13:40:38 +0200
X-Gm-Features: AclHuK8-NKfHmECD0DVtOmk_e4klBoqgwKqOwd5x4NG4wazlnEDTkkCFkHyTAAw
Message-ID: <CAGgiveV=MvRpgQxsfxxh9Hq2CFm3HDxOn3V1i7X2d9wYAvzXrw@mail.gmail.com>
Subject: Re: [PATCH v4] tee: optee: build the Arm-specific code only on Arm
To: marouene.boubakri@oss.nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA0NiBTYWx0ZWRfXzGEo9LI9+oVy
 g3qoi2PUHA01Tdn7dIGWyjNMM0Gc6V5Sxf0wTqn/bEbk5hqSCPVEEpkFRH+aXuGSYpwTvsnuXlf
 1UYzKF33aiD8VxxQveTK/YlJo6n25lY=
X-Proofpoint-GUID: MrZ4xv0bhRrudAaUij268hkKmcqawojs
X-Proofpoint-ORIG-GUID: MrZ4xv0bhRrudAaUij268hkKmcqawojs
X-Authority-Analysis: v=2.4 cv=LNPz05W9 c=1 sm=1 tr=0 ts=6ab65dc3 cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8 a=8AirrxEcAAAA:8
 a=iiJROjN2hu4f1MACNQ8A:9 a=QEXdDO2ut3YA:10 a=uujmmnXaIg8lM0-o0HFK:22
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA0NiBTYWx0ZWRfX66oGYdqhbVdu
 JCoQz5NobAQlhH9yHjU41zI298vKZMVhkjDneNZQqUpraXuoBkNvqzs4s1y0ZqQ78Ae8n6kJQIM
 OAB4cg2tBNUEoeZ53dUDB0eFoVYjNAmlX1J6M7IYctb03eYScvGohrPmR83+dKqD8dy8tUE/sVg
 SAaMzPrl5DbCiOFMzdK0Hax1YktFr6JKFdRGcFPzJuYm4FTNgH7TAo5pkBxt45gf2dH37+dUU4X
 VwYHaczUYLGyMmeHUzMKF6c7bC0gQQ4RNp0ogEdR/3YYSggQIIl+tc9aweHE30bztOa8OkAJO42
 nthOV+J7aqizFV3RADlxzjSG+N+ikgwVTgO2GZag43kRrkWjEpxfkTexnRpP5jI24hhg7CF8yYB
 CSzpbbcuSL7tj8atCVilQ+wpE0LUHRD49BIAg3nVZnxgnO7sCDg/cJJv4LGFpK1Bt3TpSbIWmnF
 Yv85L4yR0BcaLN2TtUA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250046
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: D516044471
X-Spamd-Bar: -------
Message-ID-Hash: CWX2ESDI6HVCEL5JHABXQ5V7CAHB7POX
X-Message-ID-Hash: CWX2ESDI6HVCEL5JHABXQ5V7CAHB7POX
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: jenswi@kernel.org, sumit.garg@kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, amirreza.zarrabi@oss.qualcomm.com, peter.lin@sifive.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/CWX2ESDI6HVCEL5JHABXQ5V7CAHB7POX/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jens Wiklander via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>

Hi,

On Thu, Sep 24, 2026 at 12:37=E2=80=AFPM <marouene.boubakri@oss.nxp.com> wr=
ote:
>
> From: Marouene Boubakri <marouene.boubakri@oss.nxp.com>
>
> The OP-TEE driver reaches OP-TEE through the SMC ABI or the FF-A ABI,
> both specific to Arm, yet builds both unconditionally together with the
> SMC Calling Convention definitions they rely on: ffa_abi.c is always
> compiled and only its registration is conditioned on
> IS_REACHABLE(CONFIG_ARM_FFA_TRANSPORT), and optee_private.h includes
> <linux/arm-smccc.h> and defines the SMC and FF-A specific types for
> every file of the driver. This is fine as long as the driver depends on
> HAVE_ARM_SMCCC, but it keeps the driver from being built for an
> architecture without SMCCC, such as RISC-V.
>
> Build smc_abi.c only when HAVE_ARM_SMCCC is set and ffa_abi.c only when
> the FF-A transport is enabled, and provide stubs for their registration
> otherwise, so that it fails with -EOPNOTSUPP as the FF-A ABI already
> does when the FF-A transport is not reachable. Keep the SMCCC header,
> the SMC invoke function type, the SMC and FF-A specific structures and
> the SMC RPC register parameters in optee_private.h under the same
> conditions, and drop the unused <linux/arm-smccc.h> include from
> notif.c.
>
> Make OPTEE depend on ARM_FFA_TRANSPORT || !ARM_FFA_TRANSPORT, as it
> already does for RPMB, so that the driver is limited to a module when
> the FF-A transport is one, rather than built in without FF-A support.
> ffa_abi.c is thus built exactly when the FF-A transport is reachable
> from the driver, and the IS_REACHABLE() checks in
> optee_ffa_abi_register() and optee_ffa_abi_unregister() are always
> true, so drop them.
>
> OPTEE still depends on HAVE_ARM_SMCCC, so smc_abi.c is still always
> built. The only visible change is that OPTEE=3Dy can no longer be
> combined with ARM_FFA_TRANSPORT=3Dm: such a configuration now resolves to
> OPTEE=3Dm, with the FF-A ABI available.
>
> Signed-off-by: Marouene Boubakri <marouene.boubakri@oss.nxp.com>
> ---
> Changes in v4:
> - Make OPTEE depend on ARM_FFA_TRANSPORT || !ARM_FFA_TRANSPORT so that
>   the driver is limited to =3Dm when the FF-A transport is =3Dm (Jens).
> - Update the commit message accordingly.
> v3: https://lore.kernel.org/all/20260922131735.524635-1-marouene.boubakri=
@oss.nxp.com/
>
> Changes in v3:
> - Dropped the RPMI ABI placeholder and the RISC-V enablement patches,
>   this is now a single patch (Jens).
> - Key the FF-A parts of optee_private.h on IS_REACHABLE() instead of
>   IS_ENABLED(): with OPTEE=3Dy and ARM_FFA_TRANSPORT=3Dm kbuild drops
>   ffa_abi.o from the built-in optee.o while optee_ffa_abi_register()
>   was still declared, which does not link.
> - Drop the now always true IS_REACHABLE() checks in
>   optee_ffa_abi_register() and optee_ffa_abi_unregister().
> - Describe the current FF-A conditional compilation accurately in the
>   commit message.
> - Posted as a new thread with a proper subject prefix.
> v2: https://lore.kernel.org/op-tee/20260915020235.507302-2-marouene.bouba=
kri@oss.nxp.com/
>
> Changes in v2:
> - No code change, the testing section of the cover letter was completed.
> v1: https://lore.kernel.org/op-tee/20260914175435.118303-2-marouene.bouba=
kri@oss.nxp.com/
>  drivers/tee/optee/Kconfig         |  1 +
>  drivers/tee/optee/Makefile        |  4 ++--
>  drivers/tee/optee/ffa_abi.c       |  8 ++-----
>  drivers/tee/optee/notif.c         |  1 -
>  drivers/tee/optee/optee_private.h | 39 ++++++++++++++++++++++++++++++-
>  5 files changed, 43 insertions(+), 10 deletions(-)

Looks good, I'm picking this up.

Cheers,
Jens
