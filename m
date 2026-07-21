Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B20AC44529
	for <op-tee@archiver.kernel.org>; Tue, 21 Jul 2026 10:23:46 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 271F744F61
	for <op-tee@archiver.kernel.org>; Tue, 21 Jul 2026 10:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1784629425;
	bh=dAg65rfGUktkEyRGS6LHi1HlhBVqv2aq5WVTQI9cBnY=;
	h=References:In-Reply-To:Date:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=K+wQ+JLuN60c1NixaKDepaH5IIWcc5VR5TBcRHTMKB8tCskjSs0ZKqYBJZ3rlmIRT
	 8Gebwuv3gFwNp96T1Fh4FOIW/f2nPTJ/BIdgV989qj3vT77p/O+paRWZaKVSGZZ5jn
	 BEYQjh1zHI4+LTBGM31JNbbX/ezbGQhx1PPxQnnSw+Pu8ZqxN7N17rKe+1/OGBTgBy
	 DhLEDHCyOFrKLiSTz1TzLcOu6nzVTfy+DvWPYbwdM8iEWP4rkpf32Rlps1TiPfWxsw
	 d5d78BGb+8LaSmqHehZpL3CsnQoG4av234yHNoMhwNgfKz477QJl1Ippum5p4bXv3R
	 qMaZIg/FNOzsw==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id DFC8844268
	for <op-tee@lists.trustedfirmware.org>; Tue, 21 Jul 2026 10:23:38 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YkZU9qx6;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BwgpyhTb;
	dkim-atps=neutral
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66L9uJvP4107138
	for <op-tee@lists.trustedfirmware.org>; Tue, 21 Jul 2026 10:23:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FNVZLfwCsaGZu+dN7KdgMrqhUKre/8+4rzOhShj+rOc=; b=YkZU9qx6lnMX4N5K
	Do0b62EpRlotw+/e8mEbhWDllZ3QfTEvVcxyBwNAymMa+RQMcZQyFEuQy7fXxd9Z
	rWH4cWFfbPEGE74FlVO+pJA4iZDM+btPk9jltI5eWsv1UAL6mEo05qZHc0IR+y0z
	RJsUEtKoGNdiMaoLigiqBrxnJsAIW/jkcyEcEb2/Ff2hxrfXhIsfC3c5NR0SSa5G
	7y0HXEdC1VzjBR0o4gRORznyxuibrXiiQ2YD0U1oyc1mN4nSgSvfjlan7Iy2q5or
	tQ7kd/Y3Ni1XNudl9Rhgf4CDLVN9VCLP+AO3YviOI66wsozf3nEO/8J4yKJpE4ju
	0TPZmQ==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com [74.125.224.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhvqnaq75-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 21 Jul 2026 10:23:37 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-6651da40ecbso4142920d50.1
        for <op-tee@lists.trustedfirmware.org>; Tue, 21 Jul 2026 03:23:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784629417; cv=none;
        d=google.com; s=arc-20260327;
        b=hpsSU2RRMgz+VZheQ6a5gq9xCPka6jdnf6twFPQsT/QStvphaW2P0GWVz20DFHG7tE
         Do1F0HF6KS6osNhnALKZNAptOQzQdSD8al2OxCG2OZceAgPA+wE9O3PHnPpCOQRewGzO
         3b8R55TrgOT84B9sUhT04L5ER66+2e8+08+y0uiosyAdwki40ahYZC2/9Xw1KNYwkt1Y
         aWWv95RaZdBm/rCoSKUCL+EWw5v2qGWkszIymt96s0YbDN9wvKbpE0h9jNNW7BZP4/5o
         nrQylS5vGhbqZADhjwX9UTQ7tOQ8O1rFk1ax8k5D5jlFoVHKeBpcjhx/go9YY89T+NKZ
         eM/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FNVZLfwCsaGZu+dN7KdgMrqhUKre/8+4rzOhShj+rOc=;
        fh=iJlirkMPwmMAeVHBfWO0MB9lhYI1749MhCR/nqiwa2c=;
        b=RZTNeg0Q2zDjNFR00g/RfdB6zn1QMFOOQilDRHsG/g4X+FqLXBDH5C1rWFn8scb4df
         VNv4wPjLPICaKZvv4kgfjvLIVlO6yDOBFAxA5s7LjrG46ipNfQERa7ADK83jSJ/b4UP6
         41FuOT3yZrWx5I/xVd8v9oa5hy7jzkpj5dfZford6gRoeLhuAyHqAJER/APHckb3Gwss
         yXAOoZtLpNp0JGz6mBEbGyzRgx6sq2+qzCYInJmCHD99Y9XcHA5AwwdyIUNMA9DZu5Pd
         iIUjfX71OrBUw0FXstFqadyGoAlMHjX2fa0pUvTVl040KGc4cU7JqpqgnF+G5e/8B3ON
         bsZQ==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784629417; x=1785234217; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FNVZLfwCsaGZu+dN7KdgMrqhUKre/8+4rzOhShj+rOc=;
        b=BwgpyhTbnkcGBmZrR9n1SPx0PRGGFlI5xTW8krYP/LOvNnAMevcrAeJapf9IbtwlIs
         QQEAtEb/L+FlNzO7YvXTSD1gh4vWEcIAaLMGROrZwtbZqDEWVoBFniF6bsdzq9Cch/rb
         /z0/jQ+ZHH495WsIKEC184DU5Ok/euchFx0CG0GXSrQvKeHWQlIk/0YcniHzF1kCb0Tv
         SO4CdZQimVdU27YsDFODpsByC1u+hPRxYbLm8jqCWjrVNnmFBuwVva7FWudaZ89EJq+l
         /m1O+L7XQdLAhBr1Z1YPITLqJZst5visD5KVYxaaZXELstzZZRLZ5n7bMX+dzoLzjvQQ
         F9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784629417; x=1785234217;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FNVZLfwCsaGZu+dN7KdgMrqhUKre/8+4rzOhShj+rOc=;
        b=a1vbVmrIONhsSZwc0KdKAKRiT9Q8/fo07No23560lmySK3Gug3YhunyBQvm6olW4Nc
         1af9dG2ll0P2VqDQ60jeC4IXrHSL7tH3wAhRkBCYrUrej8pEcNNOkk49SwqiqfsJmomV
         ykx6c7r6vjnOqqmRTxeyuU0obwQj9CerM4QY7yjMmonJU5U1/lDUkSDBo9Z/9kJtmgL3
         A7Ow/jLW1X2wnsSrT03+t5da1sP131vl7zSJAkCz/5P45PvdXwpnPcRTgQAgb5bgwcKJ
         t/ufn2eaYiFSF5SwpC85YHMT6fEQnn5YrBkzTVKj7943t9b9Yr5CUH6ts1imrr75KOWi
         2NUQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqx/cqe2a8ofBZAEhtX08Pk5A/ELYMnHr+Q86E9tIRRFzMco084duycAjrSmcneLxetbgyE+ac=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwQFkJHTDwcqxiSR7VXbtVxuimsaV/jiXulZaHftILOaWraWtHB
	Tf+d+9zO9aBXnI4ICMz+wGNM359Bq+RWKXlg+VD6rapdjMkkQAJvETCKuzlOdbSOm/TRTIul9UH
	p2A+fOI6ZhZIRdmslVsrBhV6Hos6jqkG2UUz/i+QBtr3bPUEZlN20k4kSJOmRrqLzFJwTOY0rW7
	XgOvsUtjn7SOphOeqGxR4haPDSWR80EpkyhuBeKilPeevvL3I=
X-Gm-Gg: AR+sD13/NK7Kx/MUYLOYOb7tP8VCQnk8LewRwsuiY3etyjHJeAhjllonSnIxPsGHDDm
	CXPprfOhyfWOFIo0OVgpHq96tNJOkXOwmz4nmO/TDK59o+j2GGA5hODsd+C1YeNfqS3lyDGxwSA
	TJSEtzPQOwZKZBLgKz5ehW6bIlp8kILgFeG87EdgRkVdxWr0oTvLxacvNYfg==
X-Received: by 2002:a05:690e:148e:b0:668:85e8:7cb with SMTP id 956f58d0204a3-66885e80a8fmr310944d50.38.1784629416522;
        Tue, 21 Jul 2026 03:23:36 -0700 (PDT)
X-Received: by 2002:a05:690e:148e:b0:668:85e8:7cb with SMTP id
 956f58d0204a3-66885e80a8fmr310932d50.38.1784629416151; Tue, 21 Jul 2026
 03:23:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260702115835.167602-1-sumit.garg@kernel.org>
 <20260702115835.167602-10-sumit.garg@kernel.org> <alJpc3nFX9D7_8i1@baldur>
In-Reply-To: <alJpc3nFX9D7_8i1@baldur>
Date: Tue, 21 Jul 2026 15:53:25 +0530
X-Gm-Features: AUfX_my8FmFS_RPsD9P_wAO_xi3w3rSS9J18xqmBVD6VnuXnMyKuUdz39cXSwBQ
Message-ID: <CAGptzHP8EQyvx3tn-ZVWZPN6TwFec-ADvAuxEQhwQBE00Sg=Kw@mail.gmail.com>
Subject: Re: [PATCH v9 09/14] media: qcom: Switch to generic PAS TZ APIs
To: bod@kernel.org, mchehab@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDExMCBTYWx0ZWRfX+2RjOaeZNTZ/
 6VZtw+JoMWVxugArtS+gq4VSPSFRVnjoDd3MEmc5C4mMb0IjiUd4k5BJjQ99o1/OL2Mt9kXhM9z
 SOCLzCYdoFM0ziPFDRg0/deYG5QC+ucWjuEUSLP5gQHphP/CwewLw3FogkCgJCkldnL4u6pG4Xw
 LvrlSI8A1h+bWP9X6R9YqhmgpLLJJc/3lmXAqTxc8wS2uwaLTaZndQF5XqjdMBBgO8dtzzV6vb5
 TiBO2E6DohN/f0+ndis6OVZVo/kQMsrQKaGzLwk8eBCUjd7RlIs1CUAPRAEEUBBo8FAuVzvE8aW
 4gMnO2TysL0xdHvj9CAZondhhqbhGPpfCrjZVRj/PBkAx6gWKf3w+PoKobTWJZupMi4sGk84WHK
 0ekbgNKpzduvznO4UMnyDsGnRD6HRXaPYSjDD0ST4auxDt8KJs1F4GaOCFcsX1gauk05aoU820O
 dU01AXjSS6edPpRypaw==
X-Proofpoint-ORIG-GUID: kESXnIHddPCtyW7Wz_04o5EjbaCkgD3p
X-Proofpoint-GUID: kESXnIHddPCtyW7Wz_04o5EjbaCkgD3p
X-Authority-Analysis: v=2.4 cv=M5F97Sws c=1 sm=1 tr=0 ts=6a5f48a9 cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=lt5aTsHmsBbDyw7JONsA:9 a=QEXdDO2ut3YA:10 a=uujmmnXaIg8lM0-o0HFK:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDExMCBTYWx0ZWRfX2EJym7UsGRwp
 aiJRD3U9HSbJpdtxkyhEACSFvR3X/id6akHe1QK1RrLAcSJzyvRfBmiDITRqKsNwpi8V6JzhqLL
 MKoWThNPj5RSKWz7SuxXe5el2Lfyj+s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210110
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
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	RCPT_COUNT_TWELVE(0.00)[49];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	RCVD_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: DFC8844268
X-Spamd-Bar: -----
Message-ID-Hash: QOIN7INZTOSF2F5MZXJ6MUBTWSA3OM3T
X-Message-ID-Hash: QOIN7INZTOSF2F5MZXJ6MUBTWSA3OM3T
X-MailFrom: sumit.garg@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Bjorn Andersson <andersson@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, konradybcio@kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vig
 nesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, jenswi@kernel.org, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/QOIN7INZTOSF2F5MZXJ6MUBTWSA3OM3T/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@oss.qualcomm.com>

Hi Bryan, Mauro,

On Sat, Jul 11, 2026 at 9:36=E2=80=AFPM Bjorn Andersson <andersson@kernel.o=
rg> wrote:
>
> On Thu, Jul 02, 2026 at 05:28:25PM +0530, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> >
> > Switch qcom media client drivers over to generic PAS TZ APIs. Generic P=
AS
> > TZ service allows to support multiple TZ implementation backends like Q=
TEE
> > based SCM PAS service, OP-TEE based PAS service and any further future =
TZ
> > backend service.
> >
>
> Please find an immutable branch with the dependencies for this patch at:
>   https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git 20260702=
115835.167602-2-sumit.garg@kernel.org
>
> Alternatively, if you think there will be no conflicting patches in the
> time leading up to next merge window provide an Ack and I can pick this
> through the qcom tree.

Just a gentle reminder for this patch to be picked up as only the Qcom
media client is left in the next branch for migration to the generic
PAS layer.

If there aren't any conflicts then please allow Bjorn to pick this
patch since the cleanup patch dropping the old SCM APIs is blocked on
this.

-Sumit

>
> Thanks,
> Bjorn
>
> > Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > ---
