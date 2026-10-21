Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A3B606A31B
	for <op-tee@archiver.kernel.org>; Wed, 21 Oct 2026 05:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=c5laJ/jx;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AYwbCZUx;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YltZX/mM
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 971E4451AE
	for <op-tee@archiver.kernel.org>; Wed, 21 Oct 2026 05:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1792561919;
	bh=HECAW79HYxjeWvw0fM/B4F3eRIOy6zxyexzqynm0vsE=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=c5laJ/jxbXQ49ZXCsKDZ1BAN1rRyxUv63zct7OfrHZrGGYnBhO57RefMuKeNJIFwE
	 oJw7H1e+9y30CFsqUiUEEZn9L6OCXmtEMJ11D6TxCXg229lFa19Rx+AcZVndm7ahIg
	 lexlhLU2sZVR2aCHqLdZxFXq6iI5jtYDjCmYqHdK/reaFkrnfKbHidQDxHSt9VxLMx
	 /kvHorkX6T1nQ8XgIm5XhXk81K9cxcWKBg6ya9S8HckE86Jqc/RvTVseHcyLK2d0j+
	 0fBYqgJpOIdpYdVDlw25J0NDrmiUoMZX5S3YVsuctDQdFShvJNpYBwtxw3rHCJf43S
	 BhuE7brlXJwZA==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0FB3C44A8C
	for <op-tee@lists.trustedfirmware.org>; Wed, 21 Oct 2026 05:51:40 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AYwbCZUx;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YltZX/mM;
	dkim-atps=neutral
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69L5j2333355908
	for <op-tee@lists.trustedfirmware.org>; Wed, 21 Oct 2026 05:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	P86U4g4HatT60Cwqp5YLLNb1rgi90YTXNNoTgRjZESQ=; b=AYwbCZUx5ANMu15a
	n5Va1u/CwFM7vsswae82r7jxn5B+VXbvm8EHB9CcpU63AGNu5rCFyXHBDHkC67HE
	JbJN/YORUCvxlGnLTHIUA5GO8wMIHfh5dw9ZMh7iBHiQwuHSf7GGa1FzP0k893/F
	rl/jjGT8a96Dovyx72/nJzKg/JHZesB9zNccEjbOoMFP8rpYgwhmFSkJna0RUAxm
	JvkSZ1I7Qipimj1p/ePYzofvvkvptJFrGdjyDdm4X376tF6KVKDtGvAe0gv+RcsL
	WT8sgad1vvwRILmIRTthsVPqhRQ1rKZF7a53Z4Y8NNbsA8oFaTqS2tmiQws+jpym
	csXxYA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heda0j5yy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 21 Oct 2026 05:51:39 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e9995cea88so4165055ad.0
        for <op-tee@lists.trustedfirmware.org>; Tue, 20 Oct 2026 22:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792561899; x=1793166699; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P86U4g4HatT60Cwqp5YLLNb1rgi90YTXNNoTgRjZESQ=;
        b=YltZX/mMlGp7T3nw6WpRRVcyjImKgVFotverD8pUysveJwaG6+hPG3dCaF/zjz44u2
         L4O2u4A3EZYbRMOowG45UZ/opY9U4u0TCwjzt9urM0Gg+5Pis9+sTWs9oYtajaU0UrU5
         OmANB+bqZkA4hL8+zwmyDHfTRbrpFmF93/9dtq4dL6TjvKNq05lz6u35gKc74AbrKl85
         y6SUBVRdeon/3UMuOCS/AMzgRam1pLfee5qCuC+aDQzUjmW+GFsvbIAvYTRGBKao8Uo7
         LkFsa4fysng9k+Ttkwmo+/b09noKdXUv8mWjKdbOIjU/+WaJuRwrj6LO/cX9OInXrdWG
         lJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792561899; x=1793166699;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P86U4g4HatT60Cwqp5YLLNb1rgi90YTXNNoTgRjZESQ=;
        b=cFYArX/lnZ9yrLamapJSh0FOpz2toLY+Y/9ooVrULri5CG9EbsyA2nSjLAesNXpWSC
         W0swzKk6b9iguP6ZwaZthk0De16EM6HDdNxN/vXvbXc3KjnykTb0+UNyFnVb5EwJxdy9
         IFIYzkpckWfdtPSfj8X1s2lwON+9q5/rTFbS5f+5nJgLXmsZePqkkTetlHkJlJ9j4vl3
         p4cxG9afXa/foF7SfrzoZ49woiPIc8UVVQGtappFZFRNtruAWeZJugr4oWN/HpJwADCr
         ZbYT3DdS5wJjtC0y+uuRRgMvq97oIiG2GA2Ivp0ZWbAT90xhf1Rv4m+go/NRGRQenkSU
         17mQ==
X-Forwarded-Encrypted: i=1; AKwUvBw3q/UHVSuzH/LcCIvHPSXgWp+MHt90UDibs0NFACh44ZaVq1C8UchLMuhWV040lpMoBDb8ySo=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYLputIRD7uaqs5xkDl3+bj3z+WvQOtcBHCbVxch1TXnnKoEj3h8
	zGVoqe467IJWj93A2y5iZEF2URY4fSmVhHwEa/8wbwc5xGkxzqjOxb8FJWgazEE2sjSTuHgCWmf
	ZLe5mm4F2MAEA9DJ6gIWNUIvyFtP4VU61N8Ri6diCwAid67fy6BQByrsVf5i4nKdUVXe1tqHO
X-Gm-Gg: AYBFou0STqHm0N/JM3U24kGAVttQ9SOVsSzJCLjAsM/JA9Q21IzgAs8q8IYMlr7U+Ld
	3/mp7WwJMDz41ibl0YrB0yaSqPe/Qaz0fkr20Ec+Nwjl8lAwotheRhqb0pWGij8VQfCq+PjpmS5
	rN9zRtKl0qQfpeEwHvc+RuRFxRmi5hCzsCLIrGVJwZ++v3ne3pKp/zoUXTp7JIPCu0tBgFgDSgF
	nrEDs1aZuEOgOde9dgvDbOI4hYsDkWqgpMGKAK2fR07+LiRHj/ARUEtXqdPXFx2BZ8c5rXDFRiu
	741HkWRo8cVQzd2i8iDq7zLV5WpJwmNjn0gu7EjlJ86Lp3HiovRGi3ctQN+8qQzQCZ4RrrMLh4E
	6QlzSwnEqJpis1VpdmKvusy3MmIVDSQ==
X-Received: by 2002:a17:902:da83:b0:2e9:734c:5027 with SMTP id d9443c01a7336-2ea43d3a1abmr8645355ad.15.1792561898975;
        Tue, 20 Oct 2026 22:51:38 -0700 (PDT)
X-Received: by 2002:a17:902:da83:b0:2e9:734c:5027 with SMTP id d9443c01a7336-2ea43d3a1abmr8645205ad.15.1792561898506;
        Tue, 20 Oct 2026 22:51:38 -0700 (PDT)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b49caa7sm6217035ad.69.2026.10.20.22.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 22:51:38 -0700 (PDT)
Message-ID: <8896d867-dfba-4d63-a0f0-5686c572b262@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 11:21:33 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] Add TPM support via Qualcomm TEE TPM TA
To: Jarkko Sakkinen <jarkko@kernel.org>, Jens Wiklander <jenswi@kernel.org>,
        Jens Wiklander <jens.wiklander@oss.qualcomm.com>
References: <20261019-tpm_qcom_driver-v4-0-6889b9804ba7@oss.qualcomm.com>
 <atYZXRLf3YPZhiNB@kernel.org>
Content-Language: en-US
In-Reply-To: <atYZXRLf3YPZhiNB@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAyMiBTYWx0ZWRfX1Q3DljTs960U
 oqUme4HMHfUkUvg3+I1TU/j3D4W8CjNqQvcziSY5PAmg32No+k4cSaQ5HIFPE+vlXtcqClZRrCp
 4pppGv1Oh5qlR4Hn5T6GVvdF4Bty68yXuMx5eReX43EhD5l2QOvics8rjDV3tM7g+p946D8oERV
 qfejEIfWP4hLfRf/KSgOkObYmx41DcZL6wct+uV2EEw8otvm+yBC+qpL8kr20g/F0F6ogY3j1zq
 DFi/6hjBgff/omkXmLnntjAQ1l9RCG3TwjvgPbbuewR3FJKWeHr9tNCR++a/8L0HUUj6fOLTM5R
 bnEaXd6JdEoJeiLSNXAbht7WzuXk26eBj7wnWpRRRf4uUPdqWQwYzrVecH62eII8Z2DJw02ZwYV
 NQxBMjmPhfgPRxZpWsPDU+JoS/GkpfYgkfRG03Ndf670iNu8Aml/1Q0XpQJLNJD5XgdBGDY4gdI
 wae85omdT5KkoWgRCwQ==
X-Proofpoint-ORIG-GUID: qJnS1kQnhNAG4sxfjnqz6IqudW7XSugP
X-Proofpoint-GUID: qJnS1kQnhNAG4sxfjnqz6IqudW7XSugP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAyMiBTYWx0ZWRfX7UfsOLHKAVxz
 AsOH45xpKLre26FdYHpTh+3R7SvaF39eZ3Opc5FIqgyRK0065kV0GwCfcziSzN41iqTqu0CUdLd
 21gFK4EbeqEiS3/Vu+eKAZaHZxAl2MM=
X-Authority-Analysis: v=2.4 cv=HL5WhYtv c=1 sm=1 tr=0 ts=6ad852eb cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=JNtoCX4LS8KcKRon3YoA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210022
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.09 / 15.00];
	BAYES_HAM(-2.99)[99.97%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.200:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,gmx.de,ziepe.ca,vger.kernel.org,lists.trustedfirmware.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 0FB3C44A8C
X-Spamd-Bar: ------
Message-ID-Hash: BBP54ICJCL3QTMGEAQCHMXU5PZHKNFL3
X-Message-ID-Hash: BBP54ICJCL3QTMGEAQCHMXU5PZHKNFL3
X-MailFrom: kuldeep.singh@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/BBP54ICJCL3QTMGEAQCHMXU5PZHKNFL3/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: Kuldeep Singh via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Applying this pulls tons of TEE patches:
> 
> Applying: tee: qcomtee: Track the object invocation context
> Applying: tee: Add kernel client object invoke helper
> Applying: tee: qcomtee: Allow object invokes from kernel clients
> Applying: tee: Export uuidv5 generation for TEE backends
> Applying: tee: qcomtee: Add support for registering QTEE services on TEE bus
> Applying: firmware: qcom: Add support for TEE based EFI-var client driver
> Applying: arm64: defconfig: Enable UefiSecApp TEE client driver for Qualcomm SoCs
> Applying: tee: qcomtee: Register qcom.tz.tpm service for discovery
> Applying: tpm: Introduce Qualcomm TPM driver
> Applying: MAINTAINERS: Add Qualcomm TPM driver entry

Yes, first 5 are tee patches prerequisite for tpm series as mentioned in
cover letter too and this series can only be merged once Jens can pick
dependent series[1] in linux-next.

Since, v7.4 merge window going to start soon so i doubt Jens can pick
for v7.4.

Jens, Any plan/timeline you are aiming to pick series[1]?
I see it's mostly reviewed with no other relevant feedback to be addressed.

[1]
https://lore.kernel.org/lkml/20261015-qcom_uefisecapp_migrate_qcomtee-v5-0-1460691b35d3@oss.qualcomm.com/

-- 
Regards
Kuldeep
