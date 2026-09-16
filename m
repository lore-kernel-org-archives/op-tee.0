Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E3F7C88E77
	for <op-tee@archiver.kernel.org>; Wed, 16 Sep 2026 09:15:44 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 55B514529D
	for <op-tee@archiver.kernel.org>; Wed, 16 Sep 2026 09:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1789550143;
	bh=eUKhNcWpU2ARzdkZDtwBSmH3wpzbtiCR0j9k5GGyr8o=;
	h=References:In-Reply-To:Date:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=EqkNVnFKwVNpta922Zj9pyRNzypDFaqr7LkySyWTl5krNyucliaPxDo2dpJD+x61z
	 ZPVyxcw5ueDJUF623CPclfvrb8Nn1dDDDw99gs5Pp+3Rh1brFk6tiOv3urMFuED0y0
	 9BKoHk+T+/sLjUrcuobmMPMhq6QxO8h2PfZTIP0wNZun/9UkqlBvWWEXcG++6RIWQt
	 e4R2OHOqip9+Fpmv9EKQCafuvRREALyhnFSKMSOtkAjREJvGCsWeCaGz0KKlW84RAs
	 xIoBpBOwcefOlsdYayIU5C//hw8DEW7H4ENukL5WGODHvwbzsvxj1sSpXZAM8qR1vX
	 wiXfsK/NmBkDg==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 495C844403
	for <op-tee@lists.trustedfirmware.org>; Wed, 16 Sep 2026 09:15:36 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Zvc8Bs5i;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aWhmSEOc;
	dkim-atps=neutral
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68G9335q2226489
	for <op-tee@lists.trustedfirmware.org>; Wed, 16 Sep 2026 09:15:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	USktFg+8SniSggZb7tvnYYwJ4/8bjyzpvcoyUOBNeTY=; b=Zvc8Bs5ipRjbNbxZ
	GXqUEMb4SfYTUx56DvNHUA2kzqVDMtdmZ0CrBI0Rz1gYI4yKPPDv+77dYySl4Svb
	LipDZpsaI4jTBVMdF/j+M4R/USG8O0yvN6/nIhUjJeabRdeMtPO5F0IKUc4Lv4lm
	QJ2q2uGXOiY/e08ax/VH/cc4+b3Fwmqj7+f/dNuVYIQm2ewF2zS9UGN+S+ZsQTZP
	7xPa7wuEyEXY6cRGnvfFY2bji9Ct3b/qv+S9kUIV/fkymi8sGjVaJ3VGocZ5UesJ
	8KydK1JPZNM7FV8+8GnIJHh4jTUit1CWkqFRuG2UN/9hsqhqfoGAExitP44mIVj3
	486qLQ==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqah9uf6u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 16 Sep 2026 09:15:35 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-8823e022390so67771967b3.2
        for <op-tee@lists.trustedfirmware.org>; Wed, 16 Sep 2026 02:15:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789550135; cv=none;
        d=google.com; s=arc-20260327;
        b=QDVHAxQC3v92/QT0neWEFNwQ/pgZu4MQr14OQEJGUVH8Qk/ocTXF11pGvFgZsITVuv
         D7nyZyqBLXmf6g7ap26mw9ie438RSkW80r3YDivJ05PspgPQsswMltXAkaeZB0uwIbBJ
         xBKq83cX4qhp10CLQ9TZazDgJtrnJwaF1Jkxy8AzDE3kcXdHS64U+bsDaQ6iHk4SnzAC
         dARrrQvo5kqg9rhPeDcVvzHDZfAlflgoQWYoIRgJnlWUWNECPMBVkOZk7Slf6VouN8ks
         yWeuN7FGzPLXVJivqNiVlOZg+oTV0/4NNVY/tFvg77oq3Y07LVH7vHm/Gs3nnY5iuHrh
         j/pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=USktFg+8SniSggZb7tvnYYwJ4/8bjyzpvcoyUOBNeTY=;
        fh=0eFvRStJZANuFAM+BISiQDLoGCvlQ9exIyWypXx3rAg=;
        b=T/sKn1Rq8fjCbojXe66aGjTM4dLaf+kVIzsfR63Og0JzOKtudOOLzOW6MF/s/mR4Dn
         CyjYTAcnzB6drQCXq0vfOkaiV2/X9nsDx0PQknZrg8fFUR6lvo+sL4rA0YhjWKA4iynx
         lNJA0IXcwEhh/fqOowmelg7Lgygfx/5jkKnXMxckpeqy7YHMB4mj8Hm6RPJYFvOzJLIU
         1w5kqK4ktYkxRCijqSSTB140KgASQp/aSsHwdr9Y+lYbrSjGSYymxsu6KVvLmNRuPpqx
         f3yxLmjSBQcJc87eqvxWJFBwaw4RzkSAjHfohgSfjzgdaQ+wvTCE75s1xZPoI2QI7YiP
         ToFQ==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789550135; x=1790154935; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=USktFg+8SniSggZb7tvnYYwJ4/8bjyzpvcoyUOBNeTY=;
        b=aWhmSEOcHc6AROWKq3HEAEukCDRNxHhbglwkSAV4R9wPVSW8HNu+abtrTYSpuvSH73
         aUNWRR6ZyZKnCe0qaa4IgAnq+OuA83TT/UOcVgBNvJXTeLli/cfmYK+eH3YNtTsm7p1d
         1aNIX6a03Hr0mWl3QNfujq+O7dH1aYqAMlVv/FVV21O3vu/j8GUcYxubkjCIAmE5oq01
         dLhnCRhkaMyLC86he5xfnMdZbK4+PBEIF/txuey9Mf+VIa0WqGtTEKj9B2s6dQYYtkaa
         /UPxdjaRxgsQbX7LKwqojq00TDQHhht4djQdXRskBSdHJLsLBLn1nwZ+egm5lwid2UwY
         oN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789550135; x=1790154935;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=USktFg+8SniSggZb7tvnYYwJ4/8bjyzpvcoyUOBNeTY=;
        b=ngZ/0dhrdi0Rgjqzkkjx8sfrHcCvfKKbYTJR8vSVgcfRNUE756XHdUH1FELhqmwf/9
         BMm7EGQRtrVRiODi4F5vhLVs0p3ndMGowK5DVa0qIfnjTuWrrsq6x6cIhL/w9vNw0nEz
         wqmirR2zKO+bZWcVH4mT3a+z1xWRv00s2a2bT1ivqHgsQyqGMC695UF/yumzNtsBqwW1
         37YfPs1yptZuFThUiRPKUzU5Mnpx/U0LNXUZv9VDtWFBkebJj59lvmDrki6Ms8Xpw4TH
         c3RgPVU0ntRiY/IMBHMy+dKCs+VLCmLnLIX8XccJ0U4Sphi31tnW3xzJ6lsSLPqrLWXd
         1rTA==
X-Forwarded-Encrypted: i=1; AKwUvBzTlh01UKQbyOWmI46Bn6JWm4eig8jC9t6KLoP4S3eK1zP56tcZMBJq2IqBGCkibCo5HQawrGY=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++mrx2eocQv77InhCdPV8nq/WmcFzjZkZkE3fxCLkOLMUrcWpx4V
	MzrJwuxnJsiwZf53JhjjThFnzmoyRSm90UUkcTw7iWRZSi0NXtaQk64T+VJXfiH5ck2sU4m9p7r
	3TvBJb2EpLiZVDEJOPpYa+uL+Fd3jMheeyozAMDrf0dnVFixlmVawwLuHIO1Q7Ml+p3+rRJ3SW7
	GMifzQ7x0KGjH6JqlnElbMBBSRsfFVfvSmNJwnEfXnPAzYCJ0=
X-Gm-Gg: AYBFou217mxdFvqoTx6XsJMfWwMW5X1q4Baz3TkwF8ftZB/lxtr8zj6KclOVlMMso85
	/bw3jHeawejjvf5nQlmh48nUibOCvelUSqy5xWCCjYBNDDIy4dPOkWFhMTBL84WDKPgfDZD43ym
	5z5umRukCI/wqBk8HcpvBW95RV72FHtS/87cHojGBIQso0tHq/fxBEYWU=
X-Received: by 2002:a05:690c:385:b0:873:5bb2:6c1a with SMTP id 00721157ae682-89226db1a37mr4902897b3.68.1789550135194;
        Wed, 16 Sep 2026 02:15:35 -0700 (PDT)
X-Received: by 2002:a05:690c:385:b0:873:5bb2:6c1a with SMTP id
 00721157ae682-89226db1a37mr4902807b3.68.1789550134775; Wed, 16 Sep 2026
 02:15:34 -0700 (PDT)
MIME-Version: 1.0
References: <c21803b3f2ea1522bb930dc1dcab79c2627f2234.1781620559.git.u.kleine-koenig@baylibre.com>
 <6971c4b5-d091-4fe2-b843-60da8b32d48b@oss.qualcomm.com>
In-Reply-To: <6971c4b5-d091-4fe2-b843-60da8b32d48b@oss.qualcomm.com>
Date: Wed, 16 Sep 2026 11:15:24 +0200
X-Gm-Features: AcwNN1V0NqIJsL73RdN3OTwvvhD8xwl5xJI8ynUXzUOj0tI1Mn5j1g_pzOzGjfw
Message-ID: <CAGgiveVKnWZCGMy4WrHn3szmC5HuYzf6kSb5-0wvOdVntBPJGw@mail.gmail.com>
Subject: Re: [PATCH v1] tee: qcomtee: Drop unused assignment of
 platform_device_id driver data
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=BtkIUoX5 c=1 sm=1 tr=0 ts=6aaa5e37 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=IpJZQVW2AAAA:8
 a=FvL8mTaZ2_32tAcSk_IA:9 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: _e75_Ty-YDQxFSHL0FxDi39RPNQfC-5C
X-Proofpoint-GUID: _e75_Ty-YDQxFSHL0FxDi39RPNQfC-5C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDExOSBTYWx0ZWRfXy868VNOfhBir
 eCeNmjJaSL9Wy5x9UnXC8Un3IzNNR2+SWjLeINafdc72jZNTedEvG2dQNGXr1nQQ7hi8u/7gJs5
 r9GgFV7+u4gX6+IjUQbNRxe6iCTqLt2uaOw89lALTGRNW1aT0YEgnCcD9yrEd0wi+GFx+TPJ1e6
 OHE1O4oAOF2ZqiL6n4dJtqUrKsQkpj87SRI68Mr91oYV/pZqJhgfzGnM40/6qK8Ak3y/yhqnMc4
 5QuVt63qjbyto34aZ4+uU0/miaH0ggZt97L2bE3bcTvenGTk5ZKk04FmBpc41VsvBTwGm23j8/i
 YRMaHUg/VMDX5WTUnEubb0to6DA2q1omryRyIHhhd2b+QWixWuvNAeT8NI3f8vzL/U9yMUOg/Br
 ll9npUTa+Pd9qBptzNTCRLPnS/NHXq0K5DFjKtPgm01BshyZ8r1x+7HDqHI/5JojhFZk62CL1Bz
 Mb3pmu9ndafmt0r6K0Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDExOSBTYWx0ZWRfX47bqjbWA3s+J
 t5dbNLWuhbkn6asSYkidux+AF53zEYWQdlBxh/9oXI1K5kGl4aDck9YmsWmsKy+Tc+eqTG54iG1
 KgnnkYrTS/x/ACP2UqYTi6xECN5ZQ5k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160119
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.128.197:received];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 495C844403
X-Spamd-Bar: -------
Message-ID-Hash: UQRLNLGYN4XPVQSO5PSA5NW6GKP2OY3X
X-Message-ID-Hash: UQRLNLGYN4XPVQSO5PSA5NW6GKP2OY3X
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/UQRLNLGYN4XPVQSO5PSA5NW6GKP2OY3X/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jens Wiklander via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>

Hi,

On Fri, Sep 11, 2026 at 9:36=E2=80=AFAM Amirreza Zarrabi
<amirreza.zarrabi@oss.qualcomm.com> wrote:
>
> Hi,
>
> On 6/17/2026 12:38 AM, Uwe Kleine-K=C3=B6nig (The Capable Hub) wrote:
> > The driver explicitly sets the .driver_data member of struct
> > platform_device_id to zero without relying on that value. Drop this
> > unused assignment.
> >
> > While touching this array unify spacing and usage of commas and use
> > a named initializer for .name for improved readability.
> >
> > Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig=
@baylibre.com>
> > ---
> > Hello,
> >
> > while this is a cleanup that can stand on its own, it is also a
> > preparation for a change to struct platform_device_id that requires tha=
t
> > .driver_data isn't assigned by a list initializer.
> >
> > Best regards
> > Uwe
> >
> >  drivers/tee/qcomtee/call.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
> > index 0efc5646242a..4a597eeaf174 100644
> > --- a/drivers/tee/qcomtee/call.c
> > +++ b/drivers/tee/qcomtee/call.c
> > @@ -798,7 +798,12 @@ static void qcomtee_remove(struct platform_device =
*pdev)
> >       kfree(qcomtee);
> >  }
> >
> > -static const struct platform_device_id qcomtee_ids[] =3D { { "qcomtee"=
, 0 }, {} };
> > +static const struct platform_device_id qcomtee_ids[] =3D {
> > +     {
> > +             .name =3D "qcomtee",
> > +     },
> > +     { }
> > +};
> >  MODULE_DEVICE_TABLE(platform, qcomtee_ids);
> >
>
> Looks good to me, thanks.
>
> Reviewed-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

I'm picking this up.

Thanks,
Jens
