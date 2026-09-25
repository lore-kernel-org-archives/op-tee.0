Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 654B5C9830D
	for <op-tee@archiver.kernel.org>; Fri, 25 Sep 2026 08:52:22 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8E39E452FB
	for <op-tee@archiver.kernel.org>; Fri, 25 Sep 2026 08:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790326341;
	bh=opTtenNCaXwogKEEQ9ij+bfaqJfLYpPzb8LXnpj79vA=;
	h=References:In-Reply-To:Date:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=xzLM0lIBQn0PInEmert5ApLNU0X0Eyqgwz6wi7L6YB2tCkjAtdDNBM9YUWUDoUjZK
	 xETw4Mr6nlt4YjE18PsSSEq7eEx/nYj78deyrCg6IhWJ/gg9v7PDb0SVwVBh9rq0TG
	 2flRsMmpGeonvVdSWWvr7Nfjr0nHagokbck8iMptKaYl7i9SWeAQ8lphS/L869jj0E
	 GI1HlpYiiqhdnu7zUGHY1xPHuM5tUTtUaSvHK2793K9nFW+B9P+2xw3qb/J18YAWdw
	 eXOya6rxkW7LZBUKBL0VlWES04IUl0GatDl9LNbEYnnlmSIrCKWjVd2xnCxLRkWUrs
	 7cjnsg1H0mBNw==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id EF366454CD
	for <op-tee@lists.trustedfirmware.org>; Fri, 25 Sep 2026 08:52:13 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FzITLKn9;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JUQH2O5I;
	dkim-atps=neutral
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4YaZN208432
	for <op-tee@lists.trustedfirmware.org>; Fri, 25 Sep 2026 08:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	opTtenNCaXwogKEEQ9ij+bfaqJfLYpPzb8LXnpj79vA=; b=FzITLKn9j+513a4u
	xcz+VLAxyXK4L6uMXdE5jVGFkgGhD2M9DXsbY/74YqpH6wWmaR+CrZSHAkF0Juks
	EfHoRB7KfXqQvQdKrSvVx+YT1VSXtIDV3FIZNoTiKmGrufCULMfnhpWmkVz58gm1
	otnPHFn2bT8nTLW+e+u5VjRhZodGLElu1+XN8ETO8X+Lp5Sw3J7FZ1lVTDiqjGz1
	FsU8LrQGb8RmyrFaB/V8Y9DOWMPFvATvsB4uScYMV+hltaNRUoJVyq2sH9A35uPc
	Fk+bdkdplmkFPLX/W3/tY/rnYnYzymRAOC01no3h3XLzpDHe34YTe/K0H9JU2MoP
	AWzM8g==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com [74.125.224.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw898tsaa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 25 Sep 2026 08:52:12 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-672a29ee420so1074177d50.1
        for <op-tee@lists.trustedfirmware.org>; Fri, 25 Sep 2026 01:52:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790326332; cv=none;
        d=google.com; s=arc-20260327;
        b=ZbqlVLHtmAa1l60aYAjv5lWzHrtPCkkqyvci3M5nGLLT5wH95DVtPbR/c9ZitI3auW
         sJRgLLJzzzlmFXhZ4go1wd7cfsA9DqbUJ2r4dpltV5yv9GMOsMZuKMXinK6GaI9g7dVq
         +2nej0Gdk7c8vSmCfnqwM/P8EcZinq3gDmuB8SbRMlpzx5oH43oTliZbnY2E5CyXke2+
         i4VSe9x9HBZ+7ZkUAyOSG4rSjAXI0yuslU94bd2bZfG0z1TrlrXMG+6IFPVht2C/4nPw
         zy2B1GugBx93FOH48h6PsG97Pdl2WOUPbrvr45WPoLAEcKxOk5ZukjeOICOn6zP24Vjg
         U3WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=opTtenNCaXwogKEEQ9ij+bfaqJfLYpPzb8LXnpj79vA=;
        fh=4d3Dxf9xaDNwK6MhYRfch2cY8lQFSk/XefcJ54YxAsE=;
        b=JCz4ZO3YwKz5RDa517QD6u+1OENT2hO8hjZ87K35ywxKJYzrhwtE2273BkPMi4J97w
         IPTcb3AdJG9QsL/wVBVaRuYfOF3MtDxZZ1RHN2Sn3eTCUpCNIZWJRD0/D2T9Xf5tLnET
         wa95grSB+VMMoio5tbcyFxx6i8ZVBcvrIBwLxiPuMAbxAtxoUQ7nLOA5+CBe9vWbZDoq
         yos5vqzeIWQtwGHrhRd0wyVa0JURKxGj+bp32oE+4TNMnxQbtY+/FTMt2u5EIG70yVeu
         6UIFRu4u/o9oaYUgFw2yXmGYscR4Lmo1g1gg4Pr2ZxNZNlWE6zYFZyt3aZbQH94Fgray
         2mUg==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790326332; x=1790931132; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=opTtenNCaXwogKEEQ9ij+bfaqJfLYpPzb8LXnpj79vA=;
        b=JUQH2O5I6ERoEjNXifD7vn2w1p+VZ8rzZSIqkT4/Mbq4n8yaem0aesqmzJvWx7cUSP
         wmUmAET+ZY6tiu3d+eMxRuyb9j36l86xK5Y3V+0t2K+9ryxmPj03dQuu2zhATPE8dIRr
         eZ6rDQTQn+I4uIAGEba5yvQkmh5Ec2R5n7icaTjKSMaj0QM+f5b6Z040/cWOBLuv78QI
         pcaRwaWSP/Q/N0kEsJ1Lj+X0RjrDwqhbeKjmui6Sz8hngxQoJFPQZaVN6Fpbx/8r55s3
         YKi/gM93vVIjIgitWCZOsvPeM/08liagSQ2rPqQVXYOZSnJ3zPGqoCJM15BYCFE+LY62
         uuxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790326332; x=1790931132;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=opTtenNCaXwogKEEQ9ij+bfaqJfLYpPzb8LXnpj79vA=;
        b=lQ4dqb5menWSyvpYoS0NfEr4iARzoUt10oAvSWAvok0f8SsDPGb0P7oMkMaoTkxflf
         EZEZvrjxN9zrLZtzz9MSarQjT1E21gKWisAbl5KxVOu0/fSxTAbjLP5cXYuZjfVMxLez
         Tc5UQFeC3BfBThOcUxrGpQaGGzBA9Hv029OyZNHs3c7ytmrnk0yG5dfu9z+itzUMacGg
         D7EH8uIxu6m256soAYJOihoj12cGEoDiMXdZqtUDyDLgu1WNaAHnkVURzkvVRvJpMOTn
         9T30BAqJpN9pgOWFg0nTXlwVoM7tVk4t9DiFiTWJB2LQHi27UguAJYBxMtEGb5ORmhwm
         yolA==
X-Forwarded-Encrypted: i=1; AKwUvBxaHjfhJhZMJ3Ahils8sE0FQSfNygI6g9rPPo7sZM9P7sh0Aw1h1i5kTut0Z2erOi2041wxLxw=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++n0tuxNEXaOp9nW0RgwDf9cZC1z09l9qM+xo2s9EJyywTo4PdqR
	KPwvwAgp2v1vyAHoswciWJPGml+Cm88yNbTy15IME6TymNyns6b2iqfNYQelznvh1dHPFKoqp8G
	YXDTcPeHrd9od0ug2Q43Mj/F0pFgPVz6kIPGG+ktKbLv2Q2I0dHYwpoXbBVtxJ7t+bqmnlX/Zbq
	iv7WJWcZzehpOgdaotXgH38p0/JguiGg8n1Vd0p/WSihYRwqU=
X-Gm-Gg: AYBFou212Cv5jrDvzjtZBFBVgi4m33D0BvpUMBP92dN0Xry0u6t2Fmgib0UrEhyso1F
	1h5+ZWUV1jCToOgZMBJOtOJixuTBvM1v+JHlYnUWsRANY9/G9xislKPaR6AQDbsKiyS2wTREbEO
	N+JOpbTI2WKWaHA8TOi+/dkJeKQ+UXRC623m4SPPN9CAIrUSv66gpxInU=
X-Received: by 2002:a05:690e:1916:b0:674:1968:4179 with SMTP id 956f58d0204a3-67419684d82mr52899d50.74.1790326331807;
        Fri, 25 Sep 2026 01:52:11 -0700 (PDT)
X-Received: by 2002:a05:690e:1916:b0:674:1968:4179 with SMTP id
 956f58d0204a3-67419684d82mr52889d50.74.1790326331440; Fri, 25 Sep 2026
 01:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260907-tpm_qcom_driver-v2-0-71a6b1752da8@oss.qualcomm.com>
 <20260907-tpm_qcom_driver-v2-1-71a6b1752da8@oss.qualcomm.com>
 <aqyX3lJ1eNBmzbSP@kernel.org> <a8047ec0-742f-47f8-b5bf-cb1b32f06bd9@oss.qualcomm.com>
In-Reply-To: <a8047ec0-742f-47f8-b5bf-cb1b32f06bd9@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 10:51:58 +0200
X-Gm-Features: AclHuK9gUY1vpR5SsZhMNs7YRGjFnTD3Zk58XCNLuI-MxS38RfhycehCFaCK3P0
Message-ID: <CAGgiveUA665UFwoojYBOB_rvCh=3NBug-B8xEBBVNPC=0jTCQg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] tee: qcomtee: Register qcom.tz.tpm service for discovery
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAzNSBTYWx0ZWRfX5p223lGPeUrh
 K85xPbCJnLwtbFt30X4gmMrtEcpMQIR2uI4PfRv0gKr0PJ4sf6NkpQdQU5Fa7yv8eY+H6coXI6d
 c637dVAiqlQSvTjyzgevUGLNaW5TSbCk+stVQukJSB1aLgAk7DQjhd8VFlMIbXdsvpKWAIve12w
 kJ70iQCa9uoe33VUD+w2LdOL56xtMr3iLb+wEbb6x3SaVCKN3IJCrdMyJpKhExsZyUGUipuFb2d
 l7zI3rdLdPUoiVg4ppdqzeFIlbB0ee15/2VKQ91LLTbjzbOCyusZPo3TAY2FVpu6jz1AcpLr30h
 1RwYbz5rCtyfFpXMsCkwvA6R2QwWuBq3MmPtKG7Th27Sb/xXGU3IMKGhOuSW11Odt+maRqAWAHo
 8X2xZt5QThQQJGn3epXPBW61Zo1NWELpLAXR27u8ej/ZJTN4Wmpxt5cL3SfNKDoDiRdHANU2sq9
 4V2TEu1plrDUuOn4grQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAzNSBTYWx0ZWRfX8wr891PeOELr
 GYwMgifGQaJI8TVKPAQbomz85qIL5d9k5TZt6glktmSry2FfhgBjRPwPLju2A+ncDHbbvFgLaAo
 egECqww+O5zu9WpiNdc2Lk+ewVljwrM=
X-Proofpoint-GUID: hst1vGcty48SlUIg9JyTM9kvqpY7jPiq
X-Proofpoint-ORIG-GUID: hst1vGcty48SlUIg9JyTM9kvqpY7jPiq
X-Authority-Analysis: v=2.4 cv=EJWTQFZC c=1 sm=1 tr=0 ts=6ab6363c cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=HjU7GSAyVm1pYthcWuMA:9 a=QEXdDO2ut3YA:10 a=yHXA93iunegOHmWoMUFd:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250035
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.02 / 15.00];
	BAYES_HAM(-2.92)[99.68%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmx.de,ziepe.ca,vger.kernel.org,lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: EF366454CD
X-Spamd-Bar: -------
Message-ID-Hash: 6FJD25ZAQ67M5SKGOYOHU23WFPS4U34Y
X-Message-ID-Hash: 6FJD25ZAQ67M5SKGOYOHU23WFPS4U34Y
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jarkko Sakkinen <jarkko@kernel.org>, Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/6FJD25ZAQ67M5SKGOYOHU23WFPS4U34Y/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jens Wiklander via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>

Hi,

On Mon, Sep 21, 2026 at 10:10=E2=80=AFAM Kuldeep Singh
<kuldeep.singh@oss.qualcomm.com> wrote:
>
> On 18-09-2026 07:16, Jarkko Sakkinen wrote:
> > On Mon, Sep 07, 2026 at 02:58:41PM +0530, Kuldeep Singh wrote:
> >> Add "qcom.tz.tpm" (QCOMTEE_TPM_UID) to qtee_services[] so the TPM TA
> >> is enumerated as a TEE-bus device, allowing a client driver to bind to
> >> it via its generated UUID.
> >>
> >> Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> [...]
>
> >
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Thanks Jarkko for the review.
> Can TEE maintainers(Amirreza/Jens?) also review this change?

Amir, please review.

Cheers,
Jens

>
> --
> Regards
> Kuldeep
>
