Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D331DCC6B1A
	for <op-tee@archiver.kernel.org>; Wed, 14 Oct 2026 06:34:43 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id CB19B45292
	for <op-tee@archiver.kernel.org>; Wed, 14 Oct 2026 06:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791959682;
	bh=90oYzEcfAGhlmbIytB6ZBVErZRVadMV+TuB9PDBwSvI=;
	h=References:In-Reply-To:Date:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=i/3lCHcnsRIfwokXC1s0k6ynz1TbK02KyfyF6p9xsJvlBJZjSFikFsNeaSDfY4SW/
	 DoTo4iOCigZp6dP8AbkjMMmPn+Nl3Wd36vKbKAkslmqJhdzqfcfY2xJ08exZ0vO1k1
	 GnDjsw8TJcaeMaHCBZbeSE2w+VWqTEXcN35w4+hpLmGL6wxWLHPddWSQwatN5se0TA
	 K0yW7mrFLo7hiLELppY1o91r8n8p5usoXq1FHUwtAuSlk+p0g6NSqa+7N+HKxQfqcb
	 FXUij/Nx3XFBOD/IqVI1miOTg+XiAcVOg5+QUjpv9E1+GdbEgLh7bDzHVJSnWzT6et
	 kpZb2/AIdPYlA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 730AB44F09
	for <op-tee@lists.trustedfirmware.org>; Wed, 14 Oct 2026 06:34:24 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Tcv2LSmE;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CPKcl0E5;
	dkim-atps=neutral
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69E21sx21592401
	for <op-tee@lists.trustedfirmware.org>; Wed, 14 Oct 2026 06:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cdLX+P1EZX3dQUm08QoqVl1tumEZ+n3uHPlV6eFJgDg=; b=Tcv2LSmE+Uo4D/De
	cYTg7jlnL9VqM3B4x3nE49YQaxwbtXhAFy9Z5pkCtPgCmm0iOmdEogPUEgiuPBzh
	ulVVE7BaMLkYa8eh4tPciZAovtmhzNBjo9Y9r66cTbH1FQ/CibXYXA66mX09F3Zw
	s7Lo5KniZ2UFpLbKGKjZEnvYdVSHoBMtse22R0fiQVqOB7H6AMiX+2gJjTZeEVfg
	Qi6W1riHkLeKN92xbqCxZUUrGviqUzQ+/GTqSJaksLg69SOETvnqd2mbKtHdMIOz
	0Zr5KTMsGwuQbldSLRwazEJfmuIeyrGtkWJVfxE+Ao4NgmD78xGvHRGR6sCWfHwX
	rYyn9Q==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com [74.125.224.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9s1tjrjk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 14 Oct 2026 06:34:23 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-67901cb4b08so5861929d50.3
        for <op-tee@lists.trustedfirmware.org>; Tue, 13 Oct 2026 23:34:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791959658; cv=none;
        d=google.com; s=arc-20260327;
        b=Rr//qvMxQxy8bMTUOMtnMNcEM5nzjsAaojKNhD2Sx4uLV6KhbfvoqMd+Ad2xUkM8+R
         MOiPe0943HTsQnuTOClxLCD/ih7J7UaNe6rzeAS2/ORLMMQyOROgTJIyJgrYPaGiRnoh
         z29TGLQckj/czWU9EvCgkiLlx/MH5f0ZGeZok0cVK6p4u8vleLkjvqiY+QU6j4ba5pIf
         GLrIx6oZvQt96FJ01uqdny2G7Aa1sotYMKViGjhmVW6kBnRRPGC64zBpvzZDfu2Hz5gD
         uxDqCSV0+eqlqQDviMxPs5+vf4s+WiKv3x0+523HWxNXKVAURcMPD5rWO/NJWZSW5Qch
         J4SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cdLX+P1EZX3dQUm08QoqVl1tumEZ+n3uHPlV6eFJgDg=;
        fh=O8JXABaNtmTNOys0XAQtfaNRa+TabCdJHn2krWp7WBs=;
        b=U1skNKB9Wwhj8xBFBxmt8iV9bP6WeGAWXLo+uV7pXruCdYfV1dPuKykjc0aLSxrTRw
         tQVaR//PJt1Y0KsbFjJXH3tdrZzg+QEczkjsH3E5U0xQYK9HAs/F73iuupHBeercBNKm
         b4908q9DWSjhEbzl1L/aUhBb0kpCVZ85oMZP46RPY+r7UcJD6MbdjEBiuKgvk4ZHToSq
         VPzxgsmzBZax+LJ3I5duGpOqB5o8s8/hAciF5lKvRjlDUFKy360gCLw1Dc5JAwh8olGk
         zF+yQ+Ic7av980BnDbu+InM11Ffq0f4e1hSOy2fUSLr52jQ+YtDErAOXHutuvvr73UpE
         ZBaw==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791959658; x=1792564458; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cdLX+P1EZX3dQUm08QoqVl1tumEZ+n3uHPlV6eFJgDg=;
        b=CPKcl0E53daKFe0L8vyzDmm/+10/oy4YKrx/TU5D14Pbg4HqbTyT4wHi6sl0zkXfT1
         D06NYo3bESHO1DbKgtItnoTXe9+D/R3X1WkiZyL4V1FIo1qjhlGeZ3UC6cYZWJ6bAWwe
         AUCu1Ny0zBqE4OzCX63ZkPLqy9c/ob8T8Bpdck5Ob1ZEuOtNaANBhcJ8n6oA/gn+0ZWJ
         1Dm+dWDODChIBhEvzhnJ1bPdYRpj9qw2i9a5OGB0iTkqH3Dvol6XVSZiUCEUqFNXWqM5
         UQ7xvviO4tjf4ZzMKVdSH3O3gmes/r23oR4GUiVDMlch40RoYtGUnBdprIOhi55aIxAH
         Ym5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791959658; x=1792564458;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cdLX+P1EZX3dQUm08QoqVl1tumEZ+n3uHPlV6eFJgDg=;
        b=GP4BE7MXFpjEM8poLxHZDdJX3ZmCsY+CxZHZ5G/+fDeZGmpKJkmAONb5swMtNqtuDN
         BYBnwDbhKzNha5Cwr9677qpz4ragM8d2VfSRMeImvTBL2beo01dkq70Picj+w+SXEe3Q
         5bHAiVImtibDsFNqBbGENhh7gyxd7XThxVddhky8UxxRjDrCNmjPOZlo3OPqcQ9nwiAO
         sqpMjUAkxrZe3fHcUGlKl/UuZZiCxm7VOYiCVsmJHA3OFdKGdy5up9xzV2pkUDWrkIIT
         6qRtJp11IQhhIzfzoFsEuFActRHtRnfZeTGLD3VCcUtvP7wlqspCzZM+3O2kbtevgNGN
         aCoA==
X-Forwarded-Encrypted: i=1; AKwUvBycQHQ1qoLAuJoV3Ffr/t6zFRlyg6v+63Z4lZK0nJRU1CfcRNpGHtm/y0Ij0C4iOGsxo5zknW4=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYKZ1XEkhxUp8rA5oNOZaY/H/KmGExbPL7rV/8DykSQuOR9563AG
	4UBHlD797G0DpHeN2ubvL+1WNrWoJn02mYH+9dDI3rNNt1QpikGOWaf0RoDEIPKfs0+ZRUXuCcI
	kphGFCIHFSE7G4NR/fnLW/egsJp3yAe6qUaxIBCv2KPezbpV4nXvyKEbErkVeAYiYoj2rlcsV0p
	ZRHUc6kqbiyI6kAAtEdeFmYHnq7ZK6fbL2KCo9jLI8Oy+lHiE=
X-Gm-Gg: AYBFou0g1hM0TuUeks3Bz3EVBHKDNRjasLzxVsR0A8U375u1ruNTJ9cKwv+7hoENudx
	pMERiNhF8oApNirBsSo91u2aKvY0yiGdGcwZ1i8M9XEYetu691QZTeJVPn4/yElLd7Wht5ydlHG
	MDOcDfZCYUEdDUT94BTw6RYuqbjRHRWFZzsloZbquV3PefKaFPVAM1kyc=
X-Received: by 2002:a05:690e:4803:b0:672:ef08:585d with SMTP id 956f58d0204a3-679362ee333mr2258543d50.103.1791959658359;
        Tue, 13 Oct 2026 23:34:18 -0700 (PDT)
X-Received: by 2002:a05:690e:4803:b0:672:ef08:585d with SMTP id
 956f58d0204a3-679362ee333mr2258539d50.103.1791959657987; Tue, 13 Oct 2026
 23:34:17 -0700 (PDT)
MIME-Version: 1.0
References: <20261002145140.GA784348@rayden> <522a2d28-2ac9-4a56-8a61-477be3dfbbd9@app.fastmail.com>
In-Reply-To: <522a2d28-2ac9-4a56-8a61-477be3dfbbd9@app.fastmail.com>
Date: Wed, 14 Oct 2026 08:34:06 +0200
X-Gm-Features: AclHuK8XdmPpo9UIpob-_3ameuxmUseYqHMzPH8-H_6Hf9QmLj-76Kiarg5W4no
Message-ID: <CAGgiveUDQvqpJKo4XuboP_46t7DPSBT1jdaTafROvobk2V5mwQ@mail.gmail.com>
Subject: Re: [GIT PULL] OP-TEE update for v7.4
To: Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=IpOL47/g c=1 sm=1 tr=0 ts=6acf226f cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=SNq30pm9LGA7DVCV1CQA:9 a=QEXdDO2ut3YA:10
 a=yHXA93iunegOHmWoMUFd:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAyNSBTYWx0ZWRfX1BV2wKWF+9Bx
 3ifx8XjDEP7ZSUVAk5FJVykE3XRlNZtwsB4LqhMDKwQesv5wmYRJPyTuGIDUqsM/kxQmwhJolgp
 osfs3HQjNK/Gah0U692rzebJqC6H//qIqHiau0Q06uD/JsvYTOPenRK5ImQWH7ko9luvb+Pn32I
 w2b47SB/NQEofHZaF95ufa50IREf46EfHSWEAhDkAyQNeI+PnxQnCyRZmg9qoXRPk6+hGy8pDxf
 Sc3cl9P1haRfr+6nPvBZCIrXRW2jGSA26oZVmG6CInTD8a+PZYR2PjL+Sl7G77XcP1YzRpEkSJA
 3g4EMjVTVZkxJ4VpTQ4qDvd6aKtxGlkNupLq7akVsx75B2IJsvYmdrsbyktLx2Nbw05aln6UrUH
 Zc1Bv266XaunXwCUUXSoNd9SRnHOJ8cDenq7r0wLhY79h6HNrYNY626dVyapk5IVRlirdhjl4GP
 OpvZATRTisvSGivEm6g==
X-Proofpoint-ORIG-GUID: DW8zzB87BAd69ak98Z3vFXtRaoGke9Bf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAyNSBTYWx0ZWRfXwfIs719KjuNQ
 nvz73ZUDfPAZ1ZfdPoNWWk9DvNXXlDBBv7Rlx/ZESmTu2LxEVGiyZ7zRFf9xg+0iNd7u4XpWoL9
 k2fjqoyBFuuk7yK2uRMIiRSKyJjZ+mY=
X-Proofpoint-GUID: DW8zzB87BAd69ak98Z3vFXtRaoGke9Bf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140025
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[74.125.224.71:received];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 730AB44F09
X-Spamd-Bar: -----
Message-ID-Hash: IK2F34SOLLVXTA3XHX3LKMFX5ILZYOBA
X-Message-ID-Hash: IK2F34SOLLVXTA3XHX3LKMFX5ILZYOBA
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: arm <arm@kernel.org>, soc@kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, Marouene Boubakri <marouene.boubakri@oss.nxp.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/IK2F34SOLLVXTA3XHX3LKMFX5ILZYOBA/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jens Wiklander via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>

Hi Arnd,

On Tue, Oct 13, 2026 at 4:53=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Fri, Oct 2, 2026, at 16:51, Jens Wiklander wrote:
> > for you to fetch changes up to ccd4b23398acaf2139cf04f1ba0a66150cbf2663=
:
> >
> >   tee: optee: build the Arm-specific code only on Arm (2026-10-02
> > 16:28:41 +0200)
> >
> > ----------------------------------------------------------------
> > Build the OP-TEE driver's SMC and FF-A code only where supported
> >
> > ----------------------------------------------------------------
> > Marouene Boubakri (1):
> >       tee: optee: build the Arm-specific code only on Arm
>
> I had a look at the contents and saw that it keeps the
> IS_REACHABLE() checks that are notoriously error-prone.
> E.g. this part just looks broken:
>
> @@ -257,8 +266,12 @@ struct optee {
>         const struct optee_ops *ops;
>         struct tee_context *ctx;
>         union {
> +#ifdef CONFIG_HAVE_ARM_SMCCC
>                 struct optee_smc smc;
> +#endif
> +#if IS_REACHABLE(CONFIG_ARM_FFA_TRANSPORT)
>                 struct optee_ffa ffa;
> +#endif
>         };
>         struct optee_shm_arg_cache shm_arg_cache;
>         struct optee_call_queue call_queue;
>
> The presence of the 'ffa' member in the union is conditional
> on whether the driver that includes the header is a loadable
> module or built-in, and this changes the entire structure
> layout if both types of users are present.
>
> The intention of the patch does make a lot of sense,
> but as far as I can tell, only the Kconfig change is
> actually required, while the added preprocessor checks
> only make it harder to read and it should have been
> sufficient to change the existing IS_REACHABLE() to
> IS_ENABLED() for consistency.
>
> Sorry I did not notice this one earlier as I was travelling,
> but I think I can't pull this version, please respin.

Thanks for catching this. We'll repin.

Cheers,
Jens
