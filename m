Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF66C9830E
	for <op-tee@archiver.kernel.org>; Fri, 25 Sep 2026 12:20:24 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E352144445
	for <op-tee@archiver.kernel.org>; Fri, 25 Sep 2026 12:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790338824;
	bh=OYWgPUZC+U2Ej7pzOKkXR9bXGaI0HZOKpE5sGDIciUg=;
	h=References:In-Reply-To:Date:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=K7e9HST6OyH61HsHWLtAYlPR1/h2rJK9WXrrugWTL+lZHFXURK94K48tLr2QNzBPU
	 mxDFv5yrT2pz5VxV67rbRxQjO5ZggvRU6JN+xBbuuYGpFAZehPKyAWuHK+7OnoI+Dl
	 ZoLhXIJ2I2N1Q+rmh78pXw+nZTlIZTjyqW2Onz3yGmYZES/hNuBjBoBJYt2Mf5SbO8
	 Gn68LsRqX6S0I40GHAfMXx/r5QghxYllPe3SEG1UisURfll94OMBp8oyAR6z4edtdA
	 EO42rtGRS6ynBElOCj2ryBiFpaJlXH6w3zYNse0tNBcTXzxeG7mTEfEpnVeablFdWW
	 ud2hvql/5SweQ==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A3EED443A3
	for <op-tee@lists.trustedfirmware.org>; Fri, 25 Sep 2026 12:20:16 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b+EXR7Dj;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=G4ZeIk6G;
	dkim-atps=neutral
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4YNKw1055388
	for <op-tee@lists.trustedfirmware.org>; Fri, 25 Sep 2026 12:20:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	voQ2O/Dzz6AWd22TDESfkLRIvWXyYSS44IiGTAccKHQ=; b=b+EXR7DjyDoIih8/
	HSzKykaJj5kLdewcfE5ub/xLBS6N6uqWV639I5n1FU7h3hq4l/YPrsx5JDAm1EiP
	DEOfPIOUVaNtDRle8f9tTyHGIh9caGOwqh4qKvMzFFHwZTu0gTJ9JbMKNd9QRLeh
	24hD5tTLgi9bLxQPNQkvyx3MLuPupxmEQ+IO0/Zs3FkNHRhV514ThJrRK9sdIBAe
	Lsn8ziA3yoRH51UnqRPubv7wNPdnHnexJxTwp/3rPENqzCRmEkTHw4Nb5iMvGtDP
	zl9xEmXub6aeHCKAD+4xT6O88uAW1QVNJPWsZh6PUaYFlxfUM1vp5T20swzcMz52
	NaOlpg==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwce7abf9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 25 Sep 2026 12:20:15 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-895241d7405so12161777b3.2
        for <op-tee@lists.trustedfirmware.org>; Fri, 25 Sep 2026 05:20:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790338814; cv=none;
        d=google.com; s=arc-20260327;
        b=kbbxmhrXrFcK22LQgVwEHhTjEZ5dceDqbjKy8eo4gqGmk02QSumNg24XWKKEpceXJj
         lU4NALuT3VcjKJwb/1u/SY9U5bm9f+3VkKO+C+o5i2yBITrZgMYitXCjb5cLgJ+fzoNd
         ZGNcWp9Rc96LSzPsQgtD5XTMfSCruVEBrGLPS+nMVNYw2tCs+4LKOYFiJcLcKF96/rjO
         p1GN7rSJAMQj3LPhz+GADgDrQ2By9Ls8nBSeoOOQRgjBpkwjisntkDVsOTcNoCtlVgaL
         CiaK7QpfhNh11l9A+ZioBx9XFZB17hMcbA4MKaWh7atUiyUWr9o9htkjSDARUL64AIRX
         ybYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=voQ2O/Dzz6AWd22TDESfkLRIvWXyYSS44IiGTAccKHQ=;
        fh=zRQCF5s7K1ACXzlDddkLq6orVkXdUoObovxtlh4Cw9o=;
        b=SV+geVMvgj71KxBeKRkavsyK5zYTnmHonU27IvY7BmFcJVVY97fn/tbQBoYSYtsSnJ
         I26rc2ssqvYq7p4BtIlz9SFkDSWrOozBB9gMiopwZbhnD3koh2Gwoq/iOkBJGTh1OI6y
         7e/M8bRyeyK2qk21ibc0ZgB/1vo7aKhfRujy5lYB7mHhStAKYcMVjVALc5Tbn05+aa/q
         JM7SYWyEK38fjpHTRn/4186ytk7J7z5IdlGNdwHegw5obk7bpo9xIakTovtKMl/zmgBb
         wfc+yoCzE4JcfMUrtjSsFqaiGjL6RHkjhAs+CwYdUUWYCo3tVnmkFMPRsC3fwIl57kkg
         5l/Q==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790338814; x=1790943614; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=voQ2O/Dzz6AWd22TDESfkLRIvWXyYSS44IiGTAccKHQ=;
        b=G4ZeIk6GwYcWMVBofeaxQ3LH3rHA6juXDUzbBoxXm8krwToQQqvhHSuRWsplErFNTM
         ZMiLrDoHuaFPu1G2BvpyFtT6utd97RZJUS0Xi71WIzJxm3iE8D697NCTBPbeiIkbSe87
         v8hoM5QW6lOLVs5RQa0OqPiYUWLEZlmZLrnCdIamhGC9B4fK++EZgyVKixDXy7y5157q
         ObhJI0xxHbx+LWBRIFg+gsSq3ax/Slux2oLmfZRkanMCpCam23tm2Fmh+olDjE6eHyD7
         FYyIGcau6kqsVXfkq4cKFoUCaArBgjxOxJsVKpPmV5wm3qPlQ47V9YiBtSGGYfTsTh49
         vLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790338814; x=1790943614;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=voQ2O/Dzz6AWd22TDESfkLRIvWXyYSS44IiGTAccKHQ=;
        b=AucevSSsQ3PF4OVirNEJVLq++CvUIvFxXSMWPB7E7q0Mudbw68epoFQVymLM9b3m8/
         byBqIbYzG33ocs9Ic/wYUAIu4vDRai/Y7T1qPbAvnTV1JpD0G1aGFIJ/lZ+GEJuIPw0+
         D2rVh+Lqjle2QWs8aKP7iXVBzxKdHj8ZGaXPEJqkzkWIMEQ0LWXGkh981mORS5rsrcMQ
         Af03o9SuWSpt7Jt78qZlt5OYdfozro+wVE9n+rZbKzhkDS09X3i1y1r1qk1fTS3wf/f6
         Py08ijSl2aPDzaLeF4p7vZ40zfIXnAPBpsb96PR8/pLuKR4x4zUHO+GGEO3BbMI2cFK0
         1saQ==
X-Forwarded-Encrypted: i=1; AKwUvBwfp/ibw8Q/Kgsff5YWwLrJ4s1ZSuuFI6gnAc7yNWIic8S8e3UtTTf+KzIJVlztjd7626iHK/I=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++nMEYv7qOF5wrIB3pxOyyGLPhc9AS1zkdsqwIUF8aoNYbFcX4KW
	ockDa4/3cUgaleLAa5wFsyfnA7XM5c0RPf5sgxLY75RB3f2GTpLJII3VojoNfHnVpdp05rfOwPJ
	bxmc2MEaJ6BfHp70/mkxY3XMh97EatLCWJYPSuV8bb3+6+XfpUEiVBVXpUughBGDFNdhWA9WAwd
	/sz8PiTsGGl/DGOkAxXKfucYThUs5vZhJBZTPbzPwy9Hwht5Q=
X-Gm-Gg: AYBFou3s94e1SD8yHHQOXu+iEwaTK8eSDuIpEEhJVmed4SBFwCL7DpxhZ2zMvJt8quV
	eu2vtACwFjzDp7k2xnNg6Nxpis3g++t/Mrgez1bsuJUcO4DqCE1EYcvQFKY+z0pwIrEDD5717GJ
	HFj9DHlzQ2SrfqwckcBVZL5YAg0SrNtu8CFDqQw/DunhDUMIvl0mhWUKc=
X-Received: by 2002:a05:690c:7011:b0:8a8:6fac:1525 with SMTP id 00721157ae682-8a86fac15dfmr9506887b3.46.1790338814057;
        Fri, 25 Sep 2026 05:20:14 -0700 (PDT)
X-Received: by 2002:a05:690c:7011:b0:8a8:6fac:1525 with SMTP id
 00721157ae682-8a86fac15dfmr9506707b3.46.1790338813586; Fri, 25 Sep 2026
 05:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260918101113.6699-1-shf.chen@mediatek.com>
In-Reply-To: <20260918101113.6699-1-shf.chen@mediatek.com>
Date: Fri, 25 Sep 2026 14:20:02 +0200
X-Gm-Features: AclHuK-ouBDE3NP5KllgzizL8nzI00TGFeoDBfSmluIKyV7R7AT2q-LaOcyCY5Y
Message-ID: <CAGgiveUPixvTF9vJ2Xo4zTSL3OBND=FgWpNth7F6PuqcidLmVA@mail.gmail.com>
Subject: Re: [PATCH] optee: register TEE devices only once fully initialized
To: Shao-Fu Chen <shf.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 077Fs9Zn8G5dDcWyveBFD_rY99O44WOX
X-Proofpoint-ORIG-GUID: 077Fs9Zn8G5dDcWyveBFD_rY99O44WOX
X-Authority-Analysis: v=2.4 cv=NJFAaE6g c=1 sm=1 tr=0 ts=6ab666ff cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=mpaa-ttXAAAA:8 a=oFcAipZnX4TCZRIg_scA:9
 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA0OSBTYWx0ZWRfX+WOhjGLC55O1
 i1LP/RzYkOm/NK+wwBdlkVdtXuoLi0pUHUurdKpfT97aV+xBtSJGGj53a7MkZQ1wrVF2R7i4NhR
 bped8HSKweSvnUR40CoSwSDGAUIqkpcBk0Tu4kiyIxUuC2rcDEG6m+DANuO27Qh2cX5dvULxDFZ
 aYTFwb2rM7Cv3wTwpsAlLsNkOJLBbLesmeEqydrYT7YD3dvLWiPSfFgUM1A9i1Uyi69VGdzWIlj
 Pk72c1tENYxIZbiVqyhVHSZZRPOD/45qBE8MACZgOSWSE9N+9K8xROZkUNhHYSRxXaeQ1ivhLNG
 SW50u7ADgqOcQUichzIm6ZpZoQcrmHVhZrz37W3ejbcYZKfVpLn5SQWx/E3rluayaZqqcbhiqSs
 XENM+ksL6IoLfh2rpKTdAkedWwtIPsKrHZY3yNBUL5OgZ2MnMXuw6zJpvhYqbLg/AQ31yGKbZW5
 sV9ruPmSvxfSKQkXHPw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA0OSBTYWx0ZWRfXwDJT6QZtcpOy
 +Y8n9Ys6fJhxN++HB708D+ewxxe0JhEhv8Mvc5eD7m5L/uAXxfFf/3X31lrCefcyB1B7PDYaHvF
 2uxm3G9jt5hbOIsGIeRSgx9h/ac/eAM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250049
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	RCPT_COUNT_TWELVE(0.00)[14];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,collabora.com,lists.trustedfirmware.org,vger.kernel.org,lists.infradead.org,mediatek.com];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.197:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A3EED443A3
X-Spamd-Bar: -----
Message-ID-Hash: 2AOTQPL7ATCXHRW7AVAGAUA6Z2JOUF2V
X-Message-ID-Hash: 2AOTQPL7ATCXHRW7AVAGAUA6Z2JOUF2V
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, Project_Global_Chrome_Upstream_Group@mediatek.com, tadd.kao@mediatek.com, jarried.lin@mediatek.com, vince-wl.liu@mediatek.com, justin.yeh@mediatek.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/2AOTQPL7ATCXHRW7AVAGAUA6Z2JOUF2V/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jens Wiklander via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>

Hi,

On Fri, Sep 18, 2026 at 12:12=E2=80=AFPM Shao-Fu Chen <shf.chen@mediatek.co=
m> wrote:
>
> optee_probe() called tee_device_register() on both the client and the
> supplicant device before the rest of struct optee had been initialized.
>
> tee_device_register() calls cdev_device_add(), which does two things at
> once: it creates /dev/tee0 and /dev/teepriv0, and it links the device
> into the tee class so that class_find_device() can find it. From that
> moment on the device is reachable both from user space via tee_open()
> and from kernel space via tee_client_open_context(). The only gate in
> teedev_open() is tee_device_get(), which merely checks that
> teedev->desc is non-NULL, which was already set by tee_device_alloc().
> Therefore, there is effectively no gate at all.
>
> A context opened in that window can run against a struct optee where
>
>   - optee->call_queue.mutex is not initialized by optee_cq_init()
>   - optee->supp mutex and completions is not initialized by
>     optee_supp_init()
>   - optee->rpmb_dev_mutex is not initialized yet,
>   - the message argument cache is not initialized by
>     optee_shm_arg_cache_init()
>   - optee->ctx is still NULL
>
> Any open session or invoke during this window takes uninitialized
> mutexes and dereferences a NULL pointer.
>
> Fix it by moving both tee_device_register() calls down to the point
> where all of struct optee is set up.
>
> Signed-off-by: Shao-Fu Chen <shf.chen@mediatek.com>
> ---
>  drivers/tee/optee/ffa_abi.c | 16 ++++++++--------
>  drivers/tee/optee/smc_abi.c | 17 ++++++++---------
>  2 files changed, 16 insertions(+), 17 deletions(-)

Looks good, I'm picking this up.

Cheers,
Jens
