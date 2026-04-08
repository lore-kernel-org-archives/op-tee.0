Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25787FD5F85
	for <op-tee@archiver.kernel.org>; Wed,  8 Apr 2026 07:32:52 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 2191243EAA
	for <op-tee@archiver.kernel.org>; Wed,  8 Apr 2026 07:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1775633572;
	bh=OveXBMU2Rs8ereI1m9UptjRMaYvkzfBMcmK+hgcieTk=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=R+Ag8wAy/+vBJgNhdjXsWpgoP9H+tNPjPxGyCQq2PDtlmluiLMnYfSkSXgnGNaHG0
	 hudeFLAPamfXaLqvK5LvMzVjUqH9wroQ4qmkQW5pzucuzzQoPmx39lthXIc9HNKgBu
	 e+m789SYLJuCLWP0Z7ahTDmArqKJn27WY/DW5hE1TblZ1S2WPGY6TugtaF8jy863Ig
	 hZiSlzrOo4wm6k4Bah6MGfuAwRoTS4I64JkIHtcjQZVx4YEYAgL2So44NkbGPmtvj3
	 SmleCtcAF/Tqdfp2r1rYlcQ7V3XrJJ6kRMMNqJutQu23GkifYbeqOAghe1drSW0zCZ
	 3NWX8P2cEnFDQ==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 831AE409FE
	for <op-tee@lists.trustedfirmware.org>; Wed,  8 Apr 2026 07:32:45 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nW+T356e;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ud08Wz6z;
	dkim-atps=neutral
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6387Edw12860735
	for <op-tee@lists.trustedfirmware.org>; Wed, 8 Apr 2026 07:32:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=xckB8PPJx6+/vCorN26HvLDM
	xAJX+r/dYxdwC1AmZgc=; b=nW+T356eFEiWlNV25OIPnYucbssv+TRN/QY2qRAf
	QPRvHVVopBSmj/fSXs0NgBVDsJ9QE8h2ok+x0hvLsG6TiUlkCg3wObmLBv3a7kyl
	m2nzw3uI4iNng+JA9e6cvv2Wr9/bVrWoP9AgCaOtYp8dKr0uxx8E/hlWlK1ZeVQ3
	WEMSL+o4zXWOunDSRMY8navjM9E6q9a8BQsXTSnLcqh6IrTx2LaLgYKULpd1TeUY
	/UDWZ7IRiI7V0ojXtEFPxFq2jCCBms5mBavoeF2GzEXNoWRAmbYzsK4rZpqtAOP2
	9hwyvyzYAsDYq9cz/CCF+9umhTFAznHxI/Lr5T7DlLXzWQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddad8sjvc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 08 Apr 2026 07:32:44 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50d831e8083so70745501cf.3
        for <op-tee@lists.trustedfirmware.org>; Wed, 08 Apr 2026 00:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775633564; x=1776238364; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xckB8PPJx6+/vCorN26HvLDMxAJX+r/dYxdwC1AmZgc=;
        b=Ud08Wz6zVcRxTdC+/4kWPFC6mnQn2mZ/678j0BjNQo0zTb9xKBe1VpuhSF5GZzmIq3
         tuTDRlmyfV+WAvooNSp7VOLT/w64qSY9SPE247kEDy3aGhgtnXyZzJTztcdiyI4shArv
         l8E7+JgG7zEXOWeocddTR9dIO6gOBbDKteojsXTezBikqIXr615bLuY2/lIKmQvNWSm0
         tH2tit/hG/8csUV7Q1QTh4Jsent3W6jYMAW2XW9ci6HI/XevHkDqXHlfFbBPF/K5H/eD
         yrsDJyL8G6uPhqZytKpxxMRRynT/Hnk1fR6t9Elu8dzBn0EVg5QgdVp6npq/7t4dVmpI
         QJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775633564; x=1776238364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xckB8PPJx6+/vCorN26HvLDMxAJX+r/dYxdwC1AmZgc=;
        b=lE7sa61BZTPvZkZLEGQPDjojQdMuLFl33g95PlpFGq1qisYUmqFxgJq1QrRRIYMaMH
         8Ln7hU/CmMDsloDNnYaLAWLpYYUAWaB4JSya1QlgiFBq6xZbDvQWk1iqZNsfLtcl+kAY
         rDdCJuX5t9SwLKXsa+Jh17RQyRuUNdC1LiunA2aQqiSpXllP3bOY+u1rKd/x6zT619kh
         o9oB7di7JkfF2xkpuSuDOcuhybdxN+FdPKVwvaoqCcfSccblPyEKsA4/euHaSAeZtkZj
         x/VujbR36wIHWJTNUtSz89WF9ljjKUjU9VQP1CUIF6ZSbb2mTyfM1cVLMfH4eayx8Hkh
         96+w==
X-Forwarded-Encrypted: i=1; AJvYcCVPVpWgqQxZaKh1YWBA6+WDyTvHayYrzoXzTEYq9ufPIcI4Npw6WxkLAKzAwl0xXgADB1Ck4qo=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyqsCMaR7cMasujUYHahf23bNQR86Z9pTp/xlvEMpPuRpOwZyJM
	+ETMcSk4DqieMXtM+E9saFHQj+xyT5/4c4lHvdnlLJrfJNOU4oSLYGUOaqo8K2/z+6io3UHSGSf
	ZbtUiw0t/xS8nRyxevTasjuSUJ40eAcp+EZOUb8EPE21NCFEa5eaWenX/Aq1oK6cdYyRC4smB
X-Gm-Gg: AeBDiesf/nbTPyAQT5h9ctlhO3sJ33MsLP0BsggYxeynJvRt4CdWLNyEs6vUjPJwSRx
	oYztBtwusX4UtJWxFS8LK6x9t0zPQJtx4hou3jAutVNTw3L0A4X3vS/ymk9aKX8yD1eN/tQ0Zyw
	RAJOLcKYeEcKv+2LlbA+SwQXw8iqK5FebVtLMn4mJwgMREkzCdBRYJDihlrkg095ygO8FcHZLcl
	o2+tkoZEmltiuigxoqahOaKLnI5WU0VlYfMLISDvG5AI3OhGRSVFjR/Dg503UW5QtJ2G0dbxcnB
	xeQoapaShYdzWBrhrSRtsM0Fqpsc2c0I/jiE12NVf0zPf4Gnpt4cZeAFZYtcp1ztFaNt+IxDem/
	g1j9R9XBu4baFiUhrnZPG5/kO0cZByt6So/f7Gk/kFFugynrCoTnKrC9J
X-Received: by 2002:a05:622a:124b:b0:50d:83de:4933 with SMTP id d75a77b69052e-50d83de50cfmr202934401cf.20.1775633564134;
        Wed, 08 Apr 2026 00:32:44 -0700 (PDT)
X-Received: by 2002:a05:622a:124b:b0:50d:83de:4933 with SMTP id d75a77b69052e-50d83de50cfmr202933731cf.20.1775633563612;
        Wed, 08 Apr 2026 00:32:43 -0700 (PDT)
Received: from trex (187.red-79-144-197.dynamicip.rima-tde.net. [79.144.197.187])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4889cb46adcsm383692655e9.4.2026.04.08.00.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 00:32:42 -0700 (PDT)
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Wed, 8 Apr 2026 09:32:39 +0200
To: Trilok Soni <trilokkumar.soni@oss.qualcomm.com>
Subject: Re: [PATCH v3 11/15] media: qcom: Switch to generic PAS TZ APIs
Message-ID: <adYElwM6eT5T8hZM@trex>
References: <20260327131043.627120-1-sumit.garg@kernel.org>
 <20260327131043.627120-12-sumit.garg@kernel.org>
 <ac-KQ7e8-syph1Zl@trex>
 <adOcMsk8a_Clb4WZ@sumit-xelite>
 <439f9bbf-1ba1-465f-b5af-01ba0ebb86d4@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439f9bbf-1ba1-465f-b5af-01ba0ebb86d4@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 2J-iXqTz8R1ecrtayBsG3MDzkzs7G1n9
X-Proofpoint-GUID: 2J-iXqTz8R1ecrtayBsG3MDzkzs7G1n9
X-Authority-Analysis: v=2.4 cv=EoDiaycA c=1 sm=1 tr=0 ts=69d6049c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=VPdg2FrOqWfiVCzsz0q0YA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=YTLieAA4xaQwPRX2avwA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA2NyBTYWx0ZWRfX6coXppz7ecAK
 sCzHxBb0Iw4ohRYk/nJ4VnyiyNjaubUIM3MaZUlrHQC2iW38Dhz8SjstbNYdsEXeBSb4EAldH3m
 xGOsaechOF1hqcVLAG+HfuO9nSFkLJumC2ZDvuPcEHS/y1ZlvtklYHQG5/Zkp3UXqIIU9+Hb3dz
 kG6JJyt0CmY3SBrxLoKYDKW9c/neX/THFPGAJHnrWJiohC+5p9AgrmkemhWzBlA4I+r8Uf4LA0l
 1bIPyYt3EqKfYLhR3rOR7GIlPdFRyP40+got5HCK88WXCZTEGvqMaJOxeFOYrAoG5kMAxGdSBQs
 M76vkiT4+pICTl7C7tZQMrdn//A4buNoWxGHqo1YyOJmA6oexM+uuy5DHaLaIfcIjgguTWKJUBp
 wYkF5DnoJn1uOes5BvbpV7qle9gfEfyRuWMiSzKHR3lU2BTFGhaxMnulHu26J1C/Y4qeh7DkR9W
 LhrA1AvKEZo8X2cCbHA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080067
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	DNSWL_BLOCKED(0.00)[209.85.160.200:received];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_GT_50(0.00)[51];
	TAGGED_RCPT(0.00)[dt,netdev];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 831AE409FE
X-Spamd-Bar: ----
Message-ID-Hash: 7XWZHKHXZEHV2UD47JNNQLCE7DTXF3OM
X-Message-ID-Hash: 7XWZHKHXZEHV2UD47JNNQLCE7DTXF3OM
X-MailFrom: jorge.ramirez@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>, vikash.garodia@oss.qualcomm.com, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcom
 m.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, harshal.dev@oss.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/7XWZHKHXZEHV2UD47JNNQLCE7DTXF3OM/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jorge Ramirez via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>

On 07/04/26 15:14:22, Trilok Soni wrote:
> On 4/6/2026 4:42 AM, Sumit Garg wrote:
> > Hi Jorge,
> > 
> > On Fri, Apr 03, 2026 at 11:37:07AM +0200, Jorge Ramirez wrote:
> >> On 27/03/26 18:40:39, Sumit Garg wrote:
> >>> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> >>>
> >>> Switch qcom media client drivers over to generic PAS TZ APIs. Generic PAS
> >>> TZ service allows to support multiple TZ implementation backends like QTEE
> >>> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> >>> backend service.
> >>
> >> OP-TEE based PAS service relies on the linux driver to configure the
> >> iommu (just as it is done on the no_tz case). This generic patch does
> >> not cover that requirement.
> > 
> > That's exactly the reason why the kodiak EL2 dtso disables venus by
> > default in patch #1 due to missing IOMMU configuration.
> > 
> >>
> >> Because of that, it is probably better if the commit message doesnt
> >> mention OP-TEE and instead maybe indicate that PAS wll support TEEs that
> >> implement the same restrictions that QTEE (ie, iommu configuration).
> > 
> > The scope for this patch is to just adopt the generic PAS layer without
> > affecting the client functionality.

the patchset cover letter + the commit message + the OP-TEE pull request
being referenced gives the ilusion to users that with the current set
they will get something functional (they will get a broken video
platform instead if they try to use OP-TEE).

That was the point I was making: IMO the commit message walks on a thin
line of "completeness"

QTEE and OP-TEE at this time implement different use cases (Venus with
QTEE runs with Linux on EL1 , OP-TEE runs with Linux on EL2). So maybe
worth mentioning this divergence.

> > 
> >>
> >> I can send an RFC for OP-TEE support based on the integration work being
> >> carried out here [1]
> > 
> > @Vikash may know better details about support for IOMMU configuration
> > for venus since it's a generic functionality missing when Linux runs in
> > EL2 whether it's with QTEE or OP-TEE.
> > 
> > However, feel free to propose your work to initiate discussions again.
> 
> Vikas and team depends on some of the IOMMU patches to get accepted 
> before they enable the EL2 venus support. Please reach out to him
> and Prakash Gupta at Qualcomm.

isn't Vikash in this thread, he can ping me too no :) ? but sure, we'll
synch later 
