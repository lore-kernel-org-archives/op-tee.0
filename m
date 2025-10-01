Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80181CCA470
	for <op-tee@archiver.kernel.org>; Wed,  1 Oct 2025 08:23:29 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C1A134306B
	for <op-tee@archiver.kernel.org>; Wed,  1 Oct 2025 08:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1759307008;
	bh=6qX378YfIp9QrbNMz0Pxbr6TFYT3iKxK+48OaAx5WCg=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=uo9/NHXpguABHuqOTqE3zw/URXd/3PJInvIF4P7kv9+YE0RBmLxanC+sVEx2TO3jY
	 HFUVNNlmhYeR52VfxcLKD9iz25BaPEhABFiJeiclAbYu5+oQBnw1j+rAY1EqnhpX4g
	 JmonM61yRR85NL+dCxXitAvQr0bPYcBZ5uuihGQZ46kuSnW7fWhX/DHXW5NqP1HstB
	 J7H5JaqexfbMOYgZ2lS2wqOrOTNyRf3DuZlfvGFlXQQbSEGDqSVQlgFgUEzUKEDtbR
	 u0RaxCXdpXc0RrR1dbXGV6Gwa9MAtCW2Qur2TqE/bSk6kJUDEAHKlRvOp2W4Zll8EW
	 JL9OT40DOtWJA==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 303484185E
	for <op-tee@lists.trustedfirmware.org>; Wed,  1 Oct 2025 08:23:13 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d43vyIYE;
	dkim-atps=neutral
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ULFGQj028127
	for <op-tee@lists.trustedfirmware.org>; Wed, 1 Oct 2025 08:23:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BfqDjr2vHvMLSpelJZSSDQAyOp1sqU85uHcOi6EeR9M=; b=d43vyIYE8peS22gl
	RaiBsLJGpH0xAWW/ubA1bNyiMc+R28AAo7E7Lw5wJZTAnbLA5W92hEmKRjMDBapS
	VoxIURn73FGmZbNhpM/jHtpp7XBPRyomW+SGdRxs+BPAfrNThN3JHP70B/gm8lsw
	/kVOoR+ZYbXgSpfBh9YmP5IgEG+tB31cdu1//8v4F3NrU40udh97dTuSFzt6sy9e
	pZMIistL2DRplvNwZEDDUn8kZ6IGqQFhPtlRJWXq7oe+9zz5W1JVKPEHa/Bq2cPL
	GStqNNbIHldPYNI13CTSV8dgRrxolzW/CJBfFoUfUGmgwnOLosYC9jL/B9Ycbo46
	6D9K+g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e851kud6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 01 Oct 2025 08:23:12 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e8707701f2so218500785a.3
        for <op-tee@lists.trustedfirmware.org>; Wed, 01 Oct 2025 01:23:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759306991; x=1759911791;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BfqDjr2vHvMLSpelJZSSDQAyOp1sqU85uHcOi6EeR9M=;
        b=t7HMjLFHr/Mnv2o/Ghc07ix9nI+JTh9gnOT/HJQQ8jE13ds6HqX19gvcVeCf3BEvZ8
         HmwVVC8Oh/Otc2Btkkt7h0MKGOQaLFDOq933kIeP7Pc342YIUwN26TkmiAHeJJstq791
         7+0qpcBT4Zy1ZZ5kblJsiCZ5gFli0FtUj28rxWjga2PKQy4MHEmG/xAsMzDqjwf2kEnU
         sB8Ntdq4Odmbw/tzh3N69V31Lxn7XUfv0DEaOhc1KZGxdrSKVO3U8PdK8PjAc+Jd5crP
         av5UYAucJRfzCJuWNFs2TVk74NC0PlrlnktgQJqb5QIcjoda/e054HJYIMaPfE1/txk4
         FMdw==
X-Forwarded-Encrypted: i=1; AJvYcCXcq375BGE/knazRDsqF91FpLXgED7FoBDab6U43qWRnX9aXSr4WiwQ8VEWP3inNomGAAuCPYU=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yy4Usv+viiO5DlLE4u0CM0LzHT0EFnXKJKpT/Ki/8SRWSRyy04+
	mhJrN6nVYcw30cfU5okeD2zs5asyUhiZfbUU/hWIhckRsPk8oUFUGWldciPVqTwbjkcUYTLw7HT
	eRKRGMf+O22+cvmQstZjesNpfD/fcMPtDnh19qlccFjTdlIMd2Ey5csBZFYvVXswkDiSG1vsk
X-Gm-Gg: ASbGncvX9NXU3GnYbV8rThjJPvjPt/twiL91pVTDX0QwoZZOHBTcNCwNUwKr1+GbtgD
	2884y3AGK8uhUDg9k4aU+1uUGSYyYeWZHe+Db+jYrIThRlmFZhfVVSr8t1mMT3mOHbxfHo+RsYo
	/5FZNN3Wy3I5FgnODCJCOP1rW1adyLORgbMCuIVnOBhlOlkr9MoZ2DFXYfmHXVfGypdIIpKVVl5
	SowUCZ1PO05OOqakQ0HXHrtl1Cen4dhtYw+iq51NO8aeoWETOubrOswnG404Rb61Du1Sl1hotMT
	4Ed0FAFydyv+Rnq9i4j3FjIeMF0cG86LrFqBo8h68UzMkMdmGALqCeRhPamdqBGXMbHdcTXTsex
	CuLCh7vUIcTyQBDZI2Tc5mZbHN6I=
X-Received: by 2002:a05:620a:1a90:b0:86a:79f0:6b30 with SMTP id af79cd13be357-87375f08125mr218916585a.10.1759306990799;
        Wed, 01 Oct 2025 01:23:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGnFUTD4TkfM05gLH1wKBu6EI4TJguWDNzVTARV3sTq77NHeGIczqd8JoSF98aSUiX1VzeMw==
X-Received: by 2002:a05:620a:1a90:b0:86a:79f0:6b30 with SMTP id af79cd13be357-87375f08125mr218915785a.10.1759306990262;
        Wed, 01 Oct 2025 01:23:10 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3a79fdbcb4sm894030066b.85.2025.10.01.01.23.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 01:23:09 -0700 (PDT)
Message-ID: <a5907537-cecc-4564-bae5-981d3ad85d7c@oss.qualcomm.com>
Date: Wed, 1 Oct 2025 10:23:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tee: QCOMTEE should depend on ARCH_QCOM
To: Geert Uytterhoeven <geert+renesas@glider.be>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>
References: <d0b14c3d51245f9eda2341504c05bd0f5b0828b7.1759243439.git.geert+renesas@glider.be>
Content-Language: en-US
In-Reply-To: <d0b14c3d51245f9eda2341504c05bd0f5b0828b7.1759243439.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OJoqHCaB c=1 sm=1 tr=0 ts=68dce4f0 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=yXkz1KN_3VbnnYl-rMQA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMiBTYWx0ZWRfX+HWU9ayFdHUt
 gsf4kWydYDrs1wEYVhwUuaSBDk3gszaQnB4SAftYgSQFRpOKMaT1Og1LuN3xzjbsHrhM8JuD6//
 SotWBdp0chdjMTaAQwet4ekkL1PltAFyr+A89fKwKMNWwHAiGFsNs4NkhmSr43AqyY1PsgKOuE8
 0WedCjcSLl52xm6L/th/A5qyUH4K1hk3pYiagYwK+l4nrP5QOWNkPgSTwBJ9nvnp+C1NrRBnGi4
 0+FKaz4e2XIhUw+yax5m85p3mO4Z1htTuG5GCLUVpznCpZWpkyqacPhrLY2Nu1a2lJlE9heJy0e
 aVfEhcdDPtuDlDj6DYnUxtt/C86e973FEyAiQSxj/YcLniiBYO6YGAzFGnyhn6HcMXCf1q5tpV/
 psKLeIoCa3sYV7kmLf1/9umYno9jXw==
X-Proofpoint-ORIG-GUID: 18TCsqsxcJDSgSvpLQLmeTDGlrJSbflX
X-Proofpoint-GUID: 18TCsqsxcJDSgSvpLQLmeTDGlrJSbflX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270032
X-Rspamd-Queue-Id: 303484185E
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.49 / 15.00];
	BAYES_HAM(-2.89)[99.54%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.222.200:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: BY44MU7AR2AULNOZSIG7DJT7HQR3VCEL
X-Message-ID-Hash: BY44MU7AR2AULNOZSIG7DJT7HQR3VCEL
X-MailFrom: konrad.dybcio@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/BY44MU7AR2AULNOZSIG7DJT7HQR3VCEL/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Konrad Dybcio via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

On 9/30/25 4:44 PM, Geert Uytterhoeven wrote:
> The Qualcomm Trusted Execution Environment (QTEE) is only available on
> Qualcomm SoCs.  Hence add a dependency on ARCH_QCOM, to prevent asking
> the user about this driver when configuring a kernel without Qualcomm
> platform support.
> 
> Fixes: d6e290837e50f73f ("tee: add Qualcomm TEE driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
