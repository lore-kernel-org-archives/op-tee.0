Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22061606A331
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 15:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YpCZaSlC;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MAdaJlRN
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6F40A45493
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 15:31:36 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YpCZaSlC;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MAdaJlRN;
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C257C43A89
	for <op-tee@lists.trustedfirmware.org>; Thu,  5 Nov 2026 15:31:17 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EQ7N84134032
	for <op-tee@lists.trustedfirmware.org>; Thu, 5 Nov 2026 15:31:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UFkEAJQmmDemZrU/BtfBaBHBeF42rbbxl6o22oiQ2UU=; b=YpCZaSlC/SvbpXoj
	vaboNeLLY7SdEf4bOTRfvamRZuigFq3U+/Nxx1QeAIcAJThM2ZYkET5hrzc8pD1X
	oBfhAh28sQUJJ2LQOD6VpslRnfNbeGX6OojCu+RNYCyhd1EaFq40FG6NEfiVVgZ2
	I5C8epDQ31Mc4vFcAT2tPqpaiJIZoI8UO5mIR85e0Ww7BVILrWrQv4Kg/RXNrnTa
	iB+K7OEROkw9wzkZ+f2p2vhp/YObYBbP/5IQwpe8xqBIxbZjE/guDyGA3NfERPKc
	w72qhZ52W1j5muVx5ng9UqI6+qDwCOItEude4va0nyKepZ42K2Kht70wQUSWhpC5
	9YOWuA==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com [74.125.224.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrksqad71-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 05 Nov 2026 15:31:17 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-677c4ca22c5so2891194d50.3
        for <op-tee@lists.trustedfirmware.org>; Thu, 05 Nov 2026 07:31:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793892676; cv=none;
        d=google.com; s=arc-20260327;
        b=PtKwXR4GG75nVFw2guIIfWAiCqLaN+KixqjROFZWjEw73LFNA2VYu/jaYIpgCbEyH2
         uV+8zg/q6m2UCZGyWJkZcznm0gFTV5nGKswm9expmEL7BdEqGwC9jAVy26S5cdN12nkx
         UgnGtqShBSGf5TgkfgL4varjcoqcaqe/8U+Aq5hb4laguY8CyZz9V5hqcxXGSwMk+Rdf
         KpWVe9sy7FDUDvbVLEYlsf4FY1xhuZQDckPKh1hgaCAo9JvgZYYn3Xm8ZYSNTNiMW1Fe
         39MPN9sZhdEV9x8bKgk9ajl7dGLndS7+oaMXw+v/RPzPApijLX87BQKBLDe1WLPLIs8G
         sULQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UFkEAJQmmDemZrU/BtfBaBHBeF42rbbxl6o22oiQ2UU=;
        fh=1jZJlpsPK/pfjL7mN/DDuVl2ISLAGEdW4atTk1QUcSo=;
        b=InOfn6ueboERRUHh6FH6JBh92bJHkYhHmgOj8ZVTqW3hp/iOctiF+kgzsa/Y4NUpvk
         quhDtno+zHRijp4X1Aq5Rn/1p/1dL0n9H1D9DgPrM6En1g1SU0GqJZ+J/T3BWnrcgPj3
         RMexBY7Do5bTV7db2V1+wy4EVfFlvM3s0dkBCIh5dW5fonMzGwY4dLr0pWgjPaReVNU2
         8hes+cAD8FdacfncB6Vm23/Bkis288eDF9uEM2v754/Q1Smcrj+Nrb7mHdnhIKix1Hee
         fYtNduag7ToSrTpWl2XEIjZgxPcm4hvX8gonqDO1J41exwhymrOeaLgeUuBWWWfWi0ae
         fQgw==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793892676; x=1794497476; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UFkEAJQmmDemZrU/BtfBaBHBeF42rbbxl6o22oiQ2UU=;
        b=MAdaJlRNoM7uhar1a1JDpBTBY6ypQkVwNBGt4LYZyq+1socvkmYUfF2XR+RMgcr1sG
         8LI+Q24cEjtLttQUfpIw92Dm9U4OHHA3DfQb1laJpL+rWdQbcpaXTeCeKor8yjPDadWf
         U+OW9Yb1+tYb8m21nJ+qzI5/uKtZSWT83qfgGQVari4E4t5gwjRBhnR6xm5jGY50Fe/0
         sQBlbU6eqLFCzRrFAGmEgoJ+oHESRyjXoPY9udWf3+HW2C4bnhcPGGUVa6j9iUZ351gj
         BS1zglzzDdWWTqqwOwX0h2+XAB51Jf4e8cf4x8dMR79LCW5bchmkw62xb+sqHmM1CinT
         KH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892676; x=1794497476;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UFkEAJQmmDemZrU/BtfBaBHBeF42rbbxl6o22oiQ2UU=;
        b=o0jQ5CYyIC0c//thCU6FKa+wiAZYUMYMdli+7W596dwowl0VR6sdPr2P9cGklCqocy
         +i64AXLm1i2S2iwcO2BsouKcUHKIpFf+nTfSpaAVdxXrPXpMuUTquTbhiE8wlfdfhGtS
         zKAwdCxeYaG++wZJRGchm5SjFWyy21dfymnI9eX+qJkg37mI0vGdJuF/k3d/c85YtrbI
         RXG41xSlm1HvGktrqw1ZE+fjhf3Fy8FQQICZ/sG6SPl9ILWH1TSULV9A75FCtKy8BLhM
         i97Oufaoq2vZUKGaV4+q05UrS6BHkdsQvqWrhT9JA1fjFf28516P3oqvzfHxZjQq31mu
         8CTg==
X-Forwarded-Encrypted: i=1; AKwUvBwsKR/+lxo0oz7ipLyzzBkmwBtODOEEpKNisaqgJDWRSzX2nQlLUHNCaBZAlz2e1QGWXrtnDBY=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z/iocZ5Oeiea0sSM7nDIG2NFfjutXoFswPOuF1YuJhR2mCWmZox
	8uTnNyH6yiR5RF4cEDpgY9KdDgApATt3U4xbDewSTD3GVjFcxrOE5d3WtJK724HK1homeQRYRoJ
	iOVO0sqogRyv6u7ywF+Rzie0biTLU9TUSgYkX+fUxhtotBWKdfq+rInT5l/bRLorr5PDoTbq4RG
	t/qTJxPNnilPV0jLHPfz51B1OsORyDnAWSeCv7/Z2m88HLHeI=
X-Gm-Gg: AYBFou0CXlKOoyzg4EzSF82cw81a53Zw6z9OVA9I8d0jlqoPFEZMAJ9mCwnORUyuG16
	5URs2089KUzw4xNE3wIwAGnoliIwbr2/ZjoedGUJt6ZpyUDEvzdiVM7jRkMXVZJdTZs251I9K5G
	ppMwe0xv3JuWRe3jhovJvKNrQDbRPkTmWjT9v8UZxY51HG4ybjPWrAf3/YLWHU9sVwueL+682qQ
	axxUAjHRDmLELlK8ijdLLJ1FoSQPnsHxy5TEbP7
X-Received: by 2002:a05:690e:1207:b0:66d:112b:769 with SMTP id 956f58d0204a3-67ba4c87f73mr12304313d50.1.1793892671473;
        Thu, 05 Nov 2026 07:31:11 -0800 (PST)
X-Received: by 2002:a05:690e:1207:b0:66d:112b:769 with SMTP id
 956f58d0204a3-67ba4c87f73mr12304223d50.1.1793892667556; Thu, 05 Nov 2026
 07:31:07 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260730062219.2836938-1-sammiee5311@gmail.com>
 <CAGgiveUc+TkGyGDxuuCLpHO=i22-4fn1CqjqnnmWLdWWYOZfPA@mail.gmail.com> <6f2f8357-59ef-491b-95f2-d58feb362ba7@oss.qualcomm.com>
In-Reply-To: <6f2f8357-59ef-491b-95f2-d58feb362ba7@oss.qualcomm.com>
From: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 16:30:55 +0100
X-Gm-Features: AclHuK9ffumAB6FDO6iM-oNWXrLUTKEfi4aPTOqEms-G-2LHrNHJadYMbOC2DNQ
Message-ID: <CAGgiveXBc55WKnKiZwPvxZqFe1uHh6dFwSPwMRbFhG9yEFHwbg@mail.gmail.com>
Subject: Re: [PATCH] tee: qcomtee: user: check the parameter count from the supplicant
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA2MSBTYWx0ZWRfXxWUYM1vbzdOy
 IKODQaaUHeJ1tmpdHqJfkjKTozYnIlahNtgfc2tnfFPDtk1YlvKJq3YMLkZp/j5i4waZtay9+a3
 94UZuHD6BOL1iTuM0T6GuAgOQbBqcaNfKCLKwpp43idHWUaCRTu7jb3RoGbr8mf5FbkpzisklCW
 YEW6Vaz8jYSljrKPmnLMAyuD+36OlLm+0wwoHI67YW/J+CHLaZnQgqVb9u2JsMJ4IeTcCgvzUUZ
 CshpV/tq0EcSmulkYAqlap9Vfz7V1yK0b+4BIMQhjO4P/cViVV0MhKSrpySgfEBdnLmcO1UddbM
 1ak4UToixVtlIJpmKHDLjuyrwI6jH3K728/swaxB8swBEJReosjwqoA7vV8Ihm8SzM8P091uGi0
 sIfH+R/pmuoFc7cXwBCI8s7ZCnQ+FTT1G2q1Lsncok4JtzGMXhU5N7TuI/XFoink9GmMcuUDDxv
 Hk/RNxnISzwJAJ0bHKw==
X-Proofpoint-ORIG-GUID: 2r6lZJyKSfKwBmGFYgTurXNkWUNsEBr-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA2MSBTYWx0ZWRfXyFCobrBA0U5K
 aeUyHxoa9aiOeJeKUGAVD0qMU3mAcctUlfk0FloPK8jo5zbpm2J+oML6DvjZNL7QEuSHSeYWJhR
 IPKrGHTaCLb+HmR4FYl/BEVVh1FBQlY=
X-Authority-Analysis: v=2.4 cv=CIe/zhrD c=1 sm=1 tr=0 ts=6aeca145 cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=RNNYRmto68J4RoQH_uQA:9 a=QEXdDO2ut3YA:10 a=nd2WpGr1bMy9NW-iytEl:22
X-Proofpoint-GUID: 2r6lZJyKSfKwBmGFYgTurXNkWUNsEBr-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_04,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050061
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[oss.qualcomm.com,none];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linaro.org,kernel.org,vger.kernel.org,lists.trustedfirmware.org];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.224.70:received];
	FROM_EQ_ENVFROM(0.00)[];
	DNSWL_BLOCKED(0.00)[205.220.180.131:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C257C43A89
X-Spamd-Bar: ------
Message-ID-Hash: 6Q7AIBXSGAP2C3T4R5KMIPCV36KCCUQF
X-Message-ID-Hash: 6Q7AIBXSGAP2C3T4R5KMIPCV36KCCUQF
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: HyeongJun An <sammiee5311@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/6Q7AIBXSGAP2C3T4R5KMIPCV36KCCUQF/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 4, 2026 at 8:37=E2=80=AFPM Amirreza Zarrabi
<amirreza.zarrabi@oss.qualcomm.com> wrote:
>
> Hi Jens,
>
> On 11/4/2026 4:58 AM, Jens Wiklander wrote:
> > Hi,
> >
> > On Wed, Aug 5, 2026 at 11:23=E2=80=AFAM HyeongJun An <sammiee5311@gmail=
.com> wrote:
> >>
> >> The qcomtee_cb_params_to_args() walks the argument array QTEE asked fo=
r and
> >> indexes the parameter array the supplicant supplied, but it never look=
s at
> >> num_params. A supplicant that answers TEE_IOC_SUPPL_SEND with fewer
> >> parameters than the request needs makes that walk read past the end of=
 the
> >> allocation.
> >>
> >> To fix this, reject a response that is too short, the way ureq_select(=
)
> >> already does for the receive direction.
> >>
> >> Fixes: d6e290837e50 ("tee: add Qualcomm TEE driver")
> >> Assisted-by: Claude:claude-opus-5
> >> Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
> >> ---
> >>  drivers/tee/qcomtee/user_obj.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/drivers/tee/qcomtee/user_obj.c b/drivers/tee/qcomtee/user=
_obj.c
> >> index 10452fcc7ccb..2a594ae299da 100644
> >> --- a/drivers/tee/qcomtee/user_obj.c
> >> +++ b/drivers/tee/qcomtee/user_obj.c
> >> @@ -507,6 +507,10 @@ static int qcomtee_cb_params_to_args(struct qcomt=
ee_arg *u,
> >>  {
> >>         int i;
> >>
> >> +       /* Supplicant can not send fewer parameters than requested. */
> >> +       if (num_params < qcomtee_args_len(u))
> >> +               return -EINVAL;
> >> +
> >>         qcomtee_arg_for_each(i, u) {
> >>                 switch (u[i].type) {
> >>                 case QCOMTEE_ARG_TYPE_IB:
> >> --
> >> 2.43.0
> >>
> >
> > Looks good. Amir, do you agree?
>
> Yes. It's correct. The check is missing.
>
> Reviewed-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

I'm picking this up and dropping the Assisted-by tag since we don't
use that anymore.

Cheers,
Jens
