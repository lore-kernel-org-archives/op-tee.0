Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FE3606A33F
	for <op-tee@archiver.kernel.org>; Wed, 11 Nov 2026 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bDnvUKAi;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=j6oBAZIY
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 2CAED454D7
	for <op-tee@archiver.kernel.org>; Wed, 11 Nov 2026 14:21:54 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bDnvUKAi;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=j6oBAZIY;
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4E53244EC4
	for <op-tee@lists.trustedfirmware.org>; Wed, 11 Nov 2026 14:21:35 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABEHmHJ1471224
	for <op-tee@lists.trustedfirmware.org>; Wed, 11 Nov 2026 14:21:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GxGFMPSMc+iqvGRdJCvh10NMXRvdL+St7g3NmqPw0tU=; b=bDnvUKAi0u0WIELi
	draB9OUqEYVnUuQVfou+DFxxeu0h04896EDTGc2+QSKfACr7BF5yIp5dF9F1hjO5
	2F0CPXhVsE3Y9TjSNMvsPFbQb8ePkPxKg94sgEBS1meZxX0MHq0MDvTjJBZMaJex
	BDOxdmQiwAfEXWZ0kq7ucrJlZUeS4bOsHZcvVUtsF7SSraXrBNKkkXS4/ytn3F1O
	Gu7076wSgbpXQ746r8ZhHdYxl2ZX7RBQyrvMr5fZ7aNdaAWO43ScYfV6GSocZUWM
	GF0Cp9+4oSGU5EfWv5O/t1A9Y6jOX/RJ7zxNP3E2UkI92QnDtjqvrp8xrvzwm9ji
	CuzzFQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvs4m08rx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 11 Nov 2026 14:21:34 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3763bd79663so1381622eec.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 11 Nov 2026 06:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794406894; x=1795011694; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GxGFMPSMc+iqvGRdJCvh10NMXRvdL+St7g3NmqPw0tU=;
        b=j6oBAZIYlIeILl6K45s9+jTVfuXCzqmit3MGDfg/Miq0iBw4xfrVwi1qzP0uSgTVrJ
         chiRbkC3b/INf0PHinWzpVbF3MLNVdGzbr5GOnAH4npSr1/ZAndFFAFwQ97/0MDbml7V
         0XUt8HkF9f/g6vXf7jtTCPE9WFPcIhW2QM74/gd1suHOAJqTQi04Hsx/S+6pEhZz/JXM
         cKzncuHV4p1G87sKy5hOxB1nWPkOvJrkpMMRVYsL6gWsohq0QbnQFr7eMvjuDgaS3sl4
         LpehPIb0E3MbTss50jcSzZfP/ee8fmfJ9/X3gtyDXmARkLsySvYwdASXQS+ZvmCMBSxI
         2kVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794406894; x=1795011694;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GxGFMPSMc+iqvGRdJCvh10NMXRvdL+St7g3NmqPw0tU=;
        b=qg8oqxnsI/kMLX9kTx1JXhbEqOYpoG9cUtHu2Lbe3Zgy1wkvYETGzxM5ovtcJWmEO+
         5tu0Q+ga6u/O6UFlFB/5pbtdZBtnG+31W7zKvNaK/5opncjC6gUJ9Ze1BQYG0GOeNUPP
         Ztb5L5GdsqTGQetcFQiTlXeFt9wet65f7k2vO9IMt/me6Td7UqLhTy5++I+0Zu6jSl5o
         Avcbyj/ZZuoPsVC/SSnR66I2kB3+8NAuWXNwDI551H5/+tZtispnqgki0pYVV1fKIw8R
         xAGa5uqR7AsO9c7Pm2HQmU1WYt8+CJeSEeMPTfBSqXnzBeYwT5DcdwDqQMNAekgwm8+3
         TADA==
X-Forwarded-Encrypted: i=1; AL+hErHcoA+4dnXGeiRwpwpn9AXNTjp7AmBFVCM39gGy82/T1WlZJxUkpdiplUIRDbppoyRlj3lBxz0=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z+tIgjqHS3zvZn+sdLi46lKjNVMbq7TlifB9HhJorLqVAemjZKx
	iQmG1Aabyr5zjuuHccsNkzfv7umxEMLjb+n1tdE2NqtmdZf1zLUjn2IAtJp842xGgQWSS5buRiE
	CJ5cLM1wvU5FR2s1pJP8SznDBOg+F4Gj9axYSUaZF8cd+yNUNW+6uWmoJJNG4yyYYx/YJx2wY
X-Gm-Gg: AYBFou2Z6AsV9ZWzoOdJU1KCMcV6MQY7/1E1+y4+JV8SX3FMZJ85zFHpohlvFMiqULQ
	t7XDsfCjUpKOVYzKypCgd1BmJofxRdecA6Hvp1TuqQv43HW163u+EkCNs0mmYnub5gQIdU4aCOO
	gcK9tOmXpCjb7wRASsqNlFuM/IVVX2xuLhAqEX6wHtB+MA9AOfmoJwWobmAya2gYSBl2Bkgn20O
	tzn8fQr7fBoUfeI/xm9EIQtKgVnuqCUWdWJSVjbX9eyhAC8S2Nix15EtWRSKHJXjmqEUGpTSliP
	QSW01I97egFZMIG3WFQOM3AOJ3yNexthyKb1x4CzJkTL6i3NiFxb3HgzO1L+ANVUDoR6AHvuMi7
	H40E4c0LzvD4Pn7Rmy2igfUg+7NtsE+HRsyQgChCPwpg+N+LUD5XhUEzocbxMJmQESyGZj81olI
	8=
X-Received: by 2002:a05:7301:796:b0:36e:a321:5353 with SMTP id 5a478bee46e88-3768385f3ecmr3014214eec.2.1794406893029;
        Wed, 11 Nov 2026 06:21:33 -0800 (PST)
X-Received: by 2002:a05:7301:796:b0:36e:a321:5353 with SMTP id 5a478bee46e88-3768385f3ecmr3014167eec.2.1794406891704;
        Wed, 11 Nov 2026 06:21:31 -0800 (PST)
Received: from [10.218.26.96] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520bf3e18sm32989258eec.16.2026.11.11.06.21.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 06:21:31 -0800 (PST)
Message-ID: <224eb5ee-e250-4cc0-8695-5b573757e802@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 19:51:23 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Add support for a TEE agnostic Inline Crypto
 Engine service
To: Eric Biggers <ebiggers@kernel.org>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@oss.qualcomm.com>,
        Selvam Sathappan Periakaruppan <selvam.periakaruppan@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@oss.qualcomm.com>
References: <20261111-ice-migrate-tee-svc-v2-0-29d19f6c92ab@oss.qualcomm.com>
Content-Language: en-US
From: Harshal Dev <harshal.dev@oss.qualcomm.com>
Organization: Qualcomm
In-Reply-To: <20261111-ice-migrate-tee-svc-v2-0-29d19f6c92ab@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: oODc2Wv0QWJcre-UvTuDtgnJbpufJNw4
X-Authority-Analysis: v=2.4 cv=OYANnRTY c=1 sm=1 tr=0 ts=6af479ee cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=_EMmJvYMAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=b45o4kL6AAAA:8 a=FUZdniSIsCVK2WyB57YA:9 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=emCv1hD2LFd8cNRmW21v:22
 a=dhdsR-PFWuPJUldTnwXm:22
X-Proofpoint-GUID: oODc2Wv0QWJcre-UvTuDtgnJbpufJNw4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1NiBTYWx0ZWRfXzolLVbuJpthM
 ClNs9tvUQHqDGt/K5e6ZMC/OcZHQAcZ9A0O0SSjqPJaOF36bSl1B3Mqjk8MDLYeEXNa0yxKHSry
 kIPBifd0Kjm0J1isi9iIeELo6mSg6zINfDRJRx1nGpEzepjJik1RGFn2fbTTJhTBX+MzP/Cd1IF
 ZLd93mCNtb9wofF4/pmJ5pBE+3aBPE+idP56mwgzrvMiImyHbkH//mVgybFl/B+NK0cegIZ+y9n
 v683ibZiYzBKp2m4uWEQb7Vj0rznJ6Iq062rmfqoZC13vsgvY2B3+AemL+ofapWnF0rj1384wwM
 NLS2tBWG3pYyiNnRowW5PXi9lM0msvVv7pt2Bsb6qli2fsWq2Meof4H3xeo5Zt1o7ROn4GLMFon
 t9FCVZ24CvVv8ZeldXGfURnkXuq8uofFO96EPz3vM7X5uhqt3KZAbuxxQ53/sc1USsiJroDF3Lp
 telMKrtnmzXjim+jr6w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1NiBTYWx0ZWRfX2DIrAGP5h6cV
 rXasJw0zhFVQuHk3tO9BKIYAqoFAdJPgiaTGEhl2WtGdYOU3xxpvkkU/Mhy3/fMFSRsUNwX/tSP
 lQIFCcSuDtFZilCASB3QdzTkjjRV1PU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_03,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110056
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[oss.qualcomm.com,none];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	HAS_ORG_HEADER(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.200:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4E53244EC4
X-Spamd-Bar: ------
Message-ID-Hash: D34RKC6QFW5F5SMMGEIGRBUV2MH3ZFPQ
X-Message-ID-Hash: D34RKC6QFW5F5SMMGEIGRBUV2MH3ZFPQ
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Basant Kumar <basantk@qti.qualcomm.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/D34RKC6QFW5F5SMMGEIGRBUV2MH3ZFPQ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

+ op-tee@lists.trustedfirmware.org, Jens Wiklander <jens.wiklander@oss.qualcomm.com>

On 11-11-2026 07:47 pm, Harshal Dev wrote:
> Qualcomm platforms such as the IQ-9075 EVK now boot with both Qualcomm
> Trusted Execution Environment (QTEE) and OP-TEE [1]. However, the Qualcomm
> Inline Crypto Engine (ICE) driver currently only makes SCM calls into QTEE.
> With the arrival of ICE support on OPTEE [2,3] for Qualcomm platforms,
> there is a need for TrustZone (TZ) agnostic APIs which re-direct the call
> to the correct TZ at runtime to request programming of the secure interfaces
> on the ICE hardware block.
>     
> This patch series adds such TZ agnostic APIs to the ICE driver for
> requesting secure services from either QTEE or OP-TEE depending on whether
> an SCM driver back-end or a TEE client driver back-end is registered with
> it at runtime. This series is logically similar to the one introduced for
> Peripheral Authentication Service (PAS) [3] which was recently merged to
> provide a generic PAS service for both QTEE and OP-TEE.
> 
> Apart from introducing a TEE bus based client driver for ICE, this series
> also adds support for optionally registering a TEE device which represents
> a particular TEE (QTEE or OPTEE) on the platform bus to enable drivers such
> as ICE which poll on the availability of a TEE interface to be notified.
> 
> The ICE driver is an independent platform driver which polls on the
> availability of a TEE interface (SCM driver) before checking if the ICE
> secure service is supported by QTEE by querying qcom_scm_is_available().
> The TEE subsystem currently does not provide any mechanism to notify the
> availability of a TEE interface, i.e. whether QCOMTEE or OPTEE have probed.
> Without the introduction of such a notification mechanism the ICE driver
> would indefinitely defer probe until the OPTEE ICE Pseudo TA becomes available
> on the TEE bus implying that for OPTEE builds without the ICE PTA enabled,
> the dependent UFS/SDHC storage driver will fail to come online.
> 
> The TEE bus based client driver introduced in this series which registers
> with the ICE driver has an ABI with OP-TEE that is 1-1 identical with the
> SCM driver's ICE ABI with QTEE. This is because both TEEs implement logically
> similar drivers with the exception that OP-TEE currently does not have
> Hardware Key Manager v2 support and so the inline encryption functionality
> with OP-TEE is currently limited to Qualcomm platforms with only Hardware
> Key Manager v1.
> 
> Validation:
> This series has been validated on a LeMans IQ-9075 EVK device by attempting
> file system encryption via the fscrypt tool.
> 
> Merge Strategy:
> All patches in this series except one touch Qualcomm firmware and soc drivers.
> Hence, it should go via the QCOM-SoC tree. Request the TEE subsystem maintainers
> to provide an Acknowledgement for this.
> 
> [1] https://ldts.github.io/qcom-buildroot/index.html
> [2] https://github.com/OP-TEE/optee_os/pull/7906 (In review)
> [3] https://github.com/OP-TEE/optee_os/pull/8137 (Draft, depends on PR#7906)
> [4] https://lore.kernel.org/all/20260702115835.167602-1-sumit.garg@kernel.org/
> 
> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> ---
> Changes in v2:
> - Merged the furnctionality of the middleware ICE service into the ICE
>   driver as requested by Eric.
> - Introduced tee_platform_device_register() to fix the issue of indefinite
>   probe defer in the ICE driver when ICE PTA is not enabled in OPTEE as
>   pointed out by Eric.
> - Fixed type "Psuedo" in ICE TEE back-end commit.
> - Fixed space based indentation with tab in ICE back-end Kconfig.
> - Ensure tee_shm_get_va() failure is checked and ERR_PTR() returned.
> - Validate out_shm size everywhere in qcom_ice_tee.c
> - Zero the memory holding the key when TEE invoke call fails.
> - Check failure from qcom_ice_tz_ops_register() during probe.
> - Cross-check out_size and lt_key_size in qcom_ice_tee_generate_key().
> - Always return 0 when qcom_ice_tee_probe() is success.
> - Did not collect tags from Abel since significant rework undertaken.
> - Link to v1: https://lore.kernel.org/r/20261021-ice-migrate-tee-svc-v1-0-b035be7aab0a@oss.qualcomm.com
> 
> ---
> Harshal Dev (6):
>       soc: qcom: ice: Add TZ agnostic re-direction functions
>       firmware: qcom_scm: Transition to ICE TZ agnostic operations
>       firmware: qcom: Add a TEE bus based ICE back-end
>       tee: optee: Register TEE devices on the platform bus
>       soc: qcom: ice: Migrate to the TZ agnostic ICE APIs
>       firmware: qcom: scm: Drop exported ICE wrapper functions
> 
>  MAINTAINERS                                |   8 +
>  drivers/firmware/qcom/Kconfig              |   9 +
>  drivers/firmware/qcom/Makefile             |   1 +
>  drivers/firmware/qcom/qcom_ice_tee.c       | 443 +++++++++++++++++++++++++++++
>  drivers/firmware/qcom/qcom_scm.c           |  90 +++---
>  drivers/soc/qcom/Kconfig                   |   1 +
>  drivers/soc/qcom/ice.c                     | 173 +++++++++--
>  drivers/tee/optee/ffa_abi.c                |   8 +
>  drivers/tee/optee/smc_abi.c                |   8 +
>  drivers/tee/tee_core.c                     |  21 ++
>  include/linux/firmware/qcom/qcom_ice_tee.h |  10 +
>  include/linux/firmware/qcom/qcom_scm.h     |  20 --
>  include/linux/tee_core.h                   |   9 +
>  include/soc/qcom/ice.h                     |  56 ++++
>  14 files changed, 784 insertions(+), 73 deletions(-)
> ---
> base-commit: 8f7df005a7564bd7ffa75da9c3085d5b996f1e16
> change-id: 20261021-ice-migrate-tee-svc-a5cd6959ae36
> 
> Best regards,

