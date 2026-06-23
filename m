Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A17CDB46F
	for <op-tee@archiver.kernel.org>; Tue, 23 Jun 2026 16:32:07 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9BFEF43AC0
	for <op-tee@archiver.kernel.org>; Tue, 23 Jun 2026 16:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1782232326;
	bh=zYwRlwa37Rk2TVjMNmDVdga+Wy3uYUUgKg2SsmHDRN4=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=AxLgrrxe1DDReAfYDAv3PI7LbSiayu3++Cmzx9ZrlS5wQCDoK5ojOJzLOtzr/pnZ8
	 naAaBR3lNe0ZbK21tCiuZVrHdvmTd6XplLLpuZwEgz89juCG9sGKvUhf3aR3WMHVfu
	 mIgmbjdsfN9ASumhgbAA7xUXRpwV93aZl9sXmNVdh+k3xiigbn6K4y3dLUuy0+hwJk
	 yza6M57829qYiXSK7I5CttSACJtLxDggm9ONT4jU/JkWlU88+CjFFPtKfa5M4xv5Ym
	 Qh7+6Kwu0utRWKLyiB1Bu58fbu5XD/slGYiuZ9nYj0twYY4rq/Y5VuuO8Np6l8c9K7
	 LOWTXlSGkpODw==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 653F543AC0
	for <op-tee@lists.trustedfirmware.org>; Tue, 23 Jun 2026 16:31:58 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ESUWwHoB;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KlcD/0nd;
	dkim-atps=neutral
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBXnK03668829
	for <op-tee@lists.trustedfirmware.org>; Tue, 23 Jun 2026 16:31:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=bpZit0nzAD1TX3LmUuhtrO8w
	q8/DhirAmsH9yXDIezk=; b=ESUWwHoB/PYrdnzgspHK50aVHFG9HG0SsYqEfjcK
	zy3aoaNgH/czKeAZ0dhYEzvc8zj5J+CgxxbnedXTsuYRgPWHLPc2PFl5NVhl71B5
	RzAZ1QTHSeWoAg0DmOfZuqmnTFoJ98qSXI13pKXGoBq6v22b7zOvt8Tp8WiqEJju
	p9oePXq6Oj8Um594mC8b1BhgZVi78fg1jRXMfsxb3w1ShooV4RrqzM57YviXD7BM
	J8FvAdOBL4AMuiWP0Dh9PCHX85HUP9B4Te7sj9/puAK1R6J42yxzqKsFGGXnfzfV
	5f8fJ05IbJCt/q4yfE+sukmirsLHgEPcUWhEzCioqzK8Zw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyppyj1wx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 23 Jun 2026 16:31:56 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c894c1c4aa9so10071a12.0
        for <op-tee@lists.trustedfirmware.org>; Tue, 23 Jun 2026 09:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782232316; x=1782837116; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bpZit0nzAD1TX3LmUuhtrO8wq8/DhirAmsH9yXDIezk=;
        b=KlcD/0ndOEAOmvanMZ28c6IYztpmUxGNlE5zvyZ1QbfCFzAhMqTYvZdS8bd8KzvjZu
         i640yX8k9Xt506299DZVImW0dPBYezKrFwi6pfsMk8mjdL3fV8BmCC6SgEFmA4rQTreV
         W1avDDMDOhgYdiaz7v74BZQXlHAZfhATVh8udbEFc529sK62UgVnR2wMf2UMB3NzMP+Q
         E4krfAXKpXCml4SRVWYtEsnK6QC1GTyOustIL6O3UXXeP9ow26ktKjv5A0JoQR8bREYe
         t9IOa/OZECt3QlWgWEeKGrsBW8Mt5WQRC9AKlPUnS6E9O1TjDyJoyVNDTUwZxZD2aATC
         DUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782232316; x=1782837116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpZit0nzAD1TX3LmUuhtrO8wq8/DhirAmsH9yXDIezk=;
        b=TsTYMiWVHyhBgJkjr0fM9jKPmNKgTekjtQc28Iw+TpfC96hybYmn8NQYuMborkD3KU
         Y4EAWWTa9eMpLLsSUbHtgAJa2MdDeHce2n2vJlV3BO5CiCWRz176QtaGUfKa07974dFV
         lrPrTh6kDX69ajIS1vxF9YWWQ/0LGI/MeS9s+nFnAuiB+kjmIneikIs8bAOEuzii9NCx
         jVcbj6KabC7HGKEZ64WgknB15/3ulTCUkKX4gakZ5CIjDy3XhiYxOi8rvmCre/0QX/NW
         1sC/W8Z0P+AIto9/TAJ1plplz/v5g4uZkiJAg5ODK2pCC6mEELaNaupi/8xQ8okYswe3
         f1zg==
X-Forwarded-Encrypted: i=1; AFNElJ9u/pxNOh6WCqOrI1pTKJD2tKT89BeXVdw6zRZLSbNSf8T8EkoDbNonJvhRqBiaGipeoiuAUFQ=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxfqS+OKZlRwH2U2T/JZ3ZkNhXPeXV2ls826biWExiIJJgWXXBi
	Rn0rDGhXOMANSmRzT5P4+pFWZnV4BlDsV98YePFnGBaf7S6mlDm5qHJTn1GNrkzQCCA5MFTx29l
	xx/I6uS5Rl6KzufJTOBVjBfSarCQmSmxczQEZ2DUL7fkcT4+nliP0gWtxWomlZqu9iNCBqOwh
X-Gm-Gg: AfdE7cmY2gGVV4ESCb0GRqRPn4ARytp1KQx2vzKOsg3O1SOYqQrs7R+KacKZ+kA1oyf
	ObVYRNyDQ7TWmwWXIamCksDDqSaEHdy7x7jaxziAejZXn9x4bkN4xshzSz1CT0sqDMxrCpm4HGq
	4E1arsWWq5M5MIZBkg+f0hQHndf07fECt/JewUgbvO0V9VcHXHI0A9Evz9DKxN1vYiuhj23agyI
	WMxt/ZUxpt9VRmSfP3I/fzm4iFR4gsF7hYWFLoYq+sllUYoGcX8WJRB81kCscS5SMqf+m9CGQqr
	/N3ITVg7hnHKfyUVH9uHMQAy29ow8qxa7LHybmdtOyHq/n/mMjxiC5ukHquSehc5XvI/rNmZ+bO
	4yyAnYQIzbXtQwjBFKLBz5v6wPFU3eztKilSPaw==
X-Received: by 2002:a05:6300:68c8:10b0:3b4:870e:6f44 with SMTP id adf61e73a8af0-3bd151fd460mr2827988637.35.1782232316116;
        Tue, 23 Jun 2026 09:31:56 -0700 (PDT)
X-Received: by 2002:a05:6300:68c8:10b0:3b4:870e:6f44 with SMTP id adf61e73a8af0-3bd151fd460mr2827936637.35.1782232315599;
        Tue, 23 Jun 2026 09:31:55 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8bc5a1dd9csm9850337a12.22.2026.06.23.09.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 09:31:55 -0700 (PDT)
Date: Tue, 23 Jun 2026 22:01:40 +0530
To: Sumit Garg <sumit.garg@kernel.org>
Subject: Re: [PATCH v7 01/15] arm64: dts: qcom: kodiak: Add EL2 overlay
Message-ID: <20260623163140.l7dvkqa5szqkej36@hu-mojha-hyd.qualcomm.com>
References: <20260522115936.201208-1-sumit.garg@kernel.org>
 <20260522115936.201208-2-sumit.garg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522115936.201208-2-sumit.garg@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEzNSBTYWx0ZWRfX0PhkCqhM/u/w
 O0CSYq1G7+9t/cowPxVLGpf1GfN113fhUIZsBl3LnFKGDQ9agvUOIeVSfvVWfITVlKIvylud7ep
 Z+me2RgLePt/6TUJ9QFYitx/m3ToVHYUUzjDZkyPJf++mRL6XzPNQlTforWzieDmsdNdq61IAe+
 1wwtep0EKWy4TaKLDnmNGcPb+cAV9Y0lpScG493cs4vvNkdxYfBdovSTFX65ac9P29O3iL4izKv
 wbM2tXhL/IGd29dGPEq9qFmayBDFe1l5IzCL3DdBuqVZD3bG9pIgMLObzFckf01nvTjWvrcyZVp
 R5k6jIaqO1CUgfbHq08CTlNP2A2trEZR3U5f/YtsOU5DbewvfzJieoQMeMVPKOlumqL5FxpLNTX
 S2i54ipIMKjXWuwWGN9YIZnFaPRIct83AGibanjc5AX8LHpVUCS9sqqxyYeqJushOhLSfKl+Xrk
 UJ64t6aPpX+m8aeVH1g==
X-Proofpoint-GUID: j-ReAHfIOW2sPPgJ_whhKTS74yXhNifw
X-Authority-Analysis: v=2.4 cv=dvfrzVg4 c=1 sm=1 tr=0 ts=6a3ab4fc cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=scVuWRnFyv5x-Sid9UUA:9 a=CjuIK1q_8ugA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEzNSBTYWx0ZWRfX+XARm/hl9OPu
 45UGrAYUgh+mu6zQtXoN1ONwSLFvjszv4XyLC6vv3h0a3CdqPwNNcUC0dP5cjN/iw6kPSbhWdfw
 V4cTicJPU6McrVAhCZUE+qaw4/kD7EY=
X-Proofpoint-ORIG-GUID: j-ReAHfIOW2sPPgJ_whhKTS74yXhNifw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230135
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[49];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dt,netdev];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[205.220.168.131:from];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.197:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 653F543AC0
X-Spamd-Bar: ---
Message-ID-Hash: E55YEBZMJCSB4HABCC6OXBALR4Y634RO
X-Message-ID-Hash: E55YEBZMJCSB4HABCC6OXBALR4Y634RO
X-MailFrom: mukesh.ojha@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: andersson@kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanat
 han@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/E55YEBZMJCSB4HABCC6OXBALR4Y634RO/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Mukesh Ojha via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

On Fri, May 22, 2026 at 05:29:22PM +0530, Sumit Garg wrote:
> From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> 
> All the existing variants Kodiak boards are using Gunyah hypervisor
> which means that, so far, Linux-based OS could only boot in EL1 on those
> devices.  However, it is possible for us to boot Linux at EL2 on these
> devices [1].
> 
> When running under Gunyah, the remote processor firmware IOMMU
> streams are controlled by Gunyah. However, without Gunyah, the IOMMU is
> managed by the consumer of this DeviceTree. Therefore, describe the
> firmware streams for each remote processor.
> 
> Add a EL2-specific DT overlay and apply it to Kodiak IOT variant
> devices to create -el2.dtb for each of them alongside "normal" dtb.
> 
> Note that modem and media subsystems haven't been supported yet due
> to missing dependencies. For GPU to work, zap shader is disabled and
> in EL2 mode the kernel owns hardware watchdog which is enabled here.
> 
> [1]
> https://docs.qualcomm.com/bundle/publicresource/topics/80-70020-4/boot-developer-touchpoints.html#uefi
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> [SG: watchdog and modem fixup]
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

As discussed internally, I will be taking this patch separately and you
can drop this from series.

-- 
-Mukesh Ojha
