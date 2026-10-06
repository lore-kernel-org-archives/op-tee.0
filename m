Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC512CA5FED
	for <op-tee@archiver.kernel.org>; Tue,  6 Oct 2026 13:49:02 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B758B44F8A
	for <op-tee@archiver.kernel.org>; Tue,  6 Oct 2026 13:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791294541;
	bh=/euIR1cA+vBSmeEG+EUCqPkBFFlpJ6Pj+42dkemZzGA=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=EQFdotoG/fRRii1MRZ8L9kn3fOiBjsEbSGA5wWZbC61/I7sC5j9q3m+846H6Xpb3e
	 jUI1wEm8v1Se0T/hWPybvqFVGyy0f5fBp7i1UEcZRNAecilTaH87BalCR+CRmaE3xH
	 0k+hR32qvwNCo/KRF3wC/BXGP7PvFRzV1OewImyg+LbI0p72yXzxHrrh/oYALyfPBi
	 1Vgp8gW2SAE8Z6yEQKJC/H2kqPZFL/XaXWCk2Oz/v/s3ILb4o7vqRGORbUHKfp0263
	 XxV5qID5ZCSLvCL5kyQb+5aLTBnjQNzuD/bUpWf4QvSwxOKYgrabQf6IJ1PJjYth7P
	 lZS3lpTu7/XYw==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E81C743AC9
	for <op-tee@lists.trustedfirmware.org>; Tue,  6 Oct 2026 13:48:52 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AdVqPmzj;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dTj1ZQfZ;
	dkim-atps=neutral
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696DUVR6987849
	for <op-tee@lists.trustedfirmware.org>; Tue, 6 Oct 2026 13:48:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ZsxHYpIVIY0DGWejGQhctU73
	xidBjR73UUkk+4RV14w=; b=AdVqPmzjL0Ap05ch/R1lSXawO/Ve1ilvZS9reygR
	2u3hrmHhxElQTFx72msr8OAgB4CTy4NcnZ3NOWpiGTW5bGZjgEMbqO1N6fkWlGmR
	Z/X1xCwJT05/kEoX7dlMG2kdgs9oH7XYV5kAwQigTqoI+rpSXegprod/bJQtx1sk
	JfUtyIVtEKP2iX1OKZZ7iSi08ndsuRGPbvvAwjVQP/U60xD0zf9mshpsYZbMbKX9
	beke3b99E0O+m6w8FZb8hbl+QK8gymYhL3chYv++4ZwhKcvG+TXb6rNo9rhxuzHo
	JYVp1KPquHdo19U70/AAzAY/1ySE8M7fzjNjSXPCcUXj0w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4gr3ktuq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 06 Oct 2026 13:48:51 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93dd3c3badbso566358685a.2
        for <op-tee@lists.trustedfirmware.org>; Tue, 06 Oct 2026 06:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791294527; x=1791899327; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZsxHYpIVIY0DGWejGQhctU73xidBjR73UUkk+4RV14w=;
        b=dTj1ZQfZYcps8ZI27wA05r5edMjeYetaHU9drnn5+wKRl628RGW0pvbegTocwPKOYL
         N7x5E1AGLg9uazeQO4DeeKt6sIywL84scpX9qnzcsnui2iya3ksNrtKmlTf7vbfPGA6u
         SNI3AHtrwQB5XVyqILx82LihZUJJMGyPxmYX2Lrvul3bId8W0+mAPbrVGlx3/ejSpDR+
         yjXSNr61txA5QoQ1NPvFX8plPKlWFmfg9QvZuVcWw3eLXmqytoT+nRlozhYBJqfFlxty
         QfW6AojE7PVK7PWVQitoizog3n/CquU/hnHx+pyMYIzdZYnsx2TC4tboi5EbdRTorHO2
         49Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791294527; x=1791899327;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZsxHYpIVIY0DGWejGQhctU73xidBjR73UUkk+4RV14w=;
        b=kWYZ0bFiOO2F7lKaHlz2BeU2YKkq3O4Y8q+2+SwU5RUa7ufhz6es9XLAIHGDVbnqy/
         C6sicPziFoiFo7nP6VPd6QnHND3jl3WTd7Df2EGosJXuhu9S1Hf9BBod8N2UJ3O7xjL6
         tLFLK5t1+a+cASKqrvH7pbWKpel3ASbGS5w21Ip0tSGR2uVvIp725fOlYu/IJ12sVIVJ
         ctbufw9FIwlEiaI5h0uHijHK9vHblxEJVdvNGA0Kcvd3e6NLgX0c3J/Laimh8tysQamz
         v5s2zmCnD+KlJ2cfpqumtrTLW32UVfVVN/IRBaPoyMB6+6Mnt8uHmDk41JKi5wIR3DjQ
         nfrg==
X-Forwarded-Encrypted: i=1; AKwUvBx0A7uUB9MQmrAbmGNxAAUjLuFHvrTZ+oDokLuAttqvoD4QeD+CYBSdCNwljXl5ES70emrMb5c=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++nmMlZvYUBk+oUuMp1KvHHx3vTKF+67TEG7vpLO34XK1BPy4R1r
	yw8LKUeuf4d5Ba2vnzRSDjKb8FndhmZHxXXngZAZDD3NYaaab2zu0qE9lNAQ/L3qMBE8FKiUhg7
	OMR2UEAq8pPFyZCHXIK/JiDoE+KgdLpqv6G4qoTm6gSToXnwBPvUe0QT9yCJnl0kI7Od/cQsl
X-Gm-Gg: AYBFou1zJGSBO/dMdY1NFY1o5S1GV7ETAAJVZCqx97NeU29P62B4iJbwVGgtxtNUzLK
	AgXk7pOrw1/dh4lcZzXxpkeQ//ZbxSpI0eulRULtVt0VQrNnwRfyVw2R7wn1bfsyIE+nJWI4zKV
	AkmcurrjUOm5RjIXQECx8T+aIGYQaDepjUklFOUVSIp0qsrAns7e+JcXQ9bm+O+i2WxdsBmz9/5
	OeTOzTGegNEwaCVgawoFcOw8kkfZ9CSfgkZsX09ADWtEjvY3g8t5MxaWDWvm/X1XehQyJSdh2JY
	qMctZN8OaFWzb12TLJblUIvuinmVxEM0I3LDHp9eO45W1Lxl0jzGNt9hxobQ+00nLqqn/mhIIJB
	XGvSgw5Q0DM0Vcll3lWdSrgOUJx1kayVUrXj5vj+fWJOCkcree949yTgMa4Gm0ElGgyPeji2YtT
	HUsVjbK7dADR7c
X-Received: by 2002:a05:620a:459e:b0:937:11c9:37f1 with SMTP id af79cd13be357-93e50f80d64mr1812409585a.16.1791294526480;
        Tue, 06 Oct 2026 06:48:46 -0700 (PDT)
X-Received: by 2002:a05:620a:459e:b0:937:11c9:37f1 with SMTP id af79cd13be357-93e50f80d64mr1812402585a.16.1791294525870;
        Tue, 06 Oct 2026 06:48:45 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bb7c79dc77sm4084021e87.51.2026.10.06.06.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 06:48:44 -0700 (PDT)
Date: Tue, 6 Oct 2026 16:48:41 +0300
To: Harshal Dev <harshal.dev@oss.qualcomm.com>
Subject: Re: [PATCH v4 6/7] firmware: qcom: Add support for TEE based EFI-var
 client driver
Message-ID: <r7gtspju4cp5iwelv4zs4xoh4d7ambeceptmjtqaf5hcjzmc5n@4msc3ap4yfhz>
References: <20261006-qcom_uefisecapp_migrate_qcomtee-v4-0-bf1c8e2a64ab@oss.qualcomm.com>
 <20261006-qcom_uefisecapp_migrate_qcomtee-v4-6-bf1c8e2a64ab@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006-qcom_uefisecapp_migrate_qcomtee-v4-6-bf1c8e2a64ab@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: nFTegDb-L68-s6gHQI-pKMaFmYr9z7Ro
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA1NCBTYWx0ZWRfX2odTB0kGAuDN
 Eovz1Z7lkSPOy75uEvIi45pJLvDJv6t01QnrhgB6psheD/Rh55mZtOtUQK8aBCJ8gtawjRVwApr
 sTqr/sUNQ+poZjmJeXx5NL0um6jAhxE=
X-Authority-Analysis: v=2.4 cv=PNWaavqC c=1 sm=1 tr=0 ts=6ac4fc43 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=UKPZmZIt5rrgs1V1fpcA:9
 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA1NCBTYWx0ZWRfXyefkkKzeqyWB
 0qoxI4Ceqi2PVpmAe0tH2i8rjzEzrPVQOARURZuAqoCuWloJW2PDF8IVTctPNk7BKARCGTvOaUY
 1Bi3RELncnDpVbVksLTG6biH/wapiahoy475/Q9rGAgHvpMZrV5S5CQtSISwd0UqA+GvtNek7xA
 Lvdn1ZSaj2+nH2wwww+zrGXROQ/T1vBGRoEAJxl3cMXDXchuaRir2oZr0J6LT9EUeTTTlm7Rtm/
 WfO9seAD94GURgpP+tCNiF8Jisxi+PI4hJCqZ4It8lh8EFd5rbQxp9dehbIaBRhYlN7rJ6Y/S6A
 iJzmLfBDwPSy0Um8teNaB8inmU57XAFKpOh3gFRwWV0sy3KpMzQnn6ctfs7+Nkfmf7DnGcmIZb0
 PVq9WkMBbdCllHsBuYWj9BeVKJpaHbooeDd4qJjQLBTsJpa9+LHmkvFCTuCCDKFQe3VSZbCqTHY
 BO6sWRPgzDlXWAAKG0Q==
X-Proofpoint-GUID: nFTegDb-L68-s6gHQI-pKMaFmYr9z7Ro
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_04,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 clxscore=1015 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060054
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[2001:14ba:a073:af00:264b:feff:fe8b:be8a:received,209.85.222.198:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: E81C743AC9
X-Spamd-Bar: -----
Message-ID-Hash: KU53QKO3A3RR6SR7IG4RBJPZDH6JQI6G
X-Message-ID-Hash: KU53QKO3A3RR6SR7IG4RBJPZDH6JQI6G
X-MailFrom: dmitry.baryshkov@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jens.wiklander@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/KU53QKO3A3RR6SR7IG4RBJPZDH6JQI6G/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Dmitry Baryshkov via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

On Tue, Oct 06, 2026 at 05:03:27PM +0530, Harshal Dev wrote:
> On Qualcomm SoC based platforms, UEFI stores EFI variables within the
> Replay Protected Memory Block (RPMB) located within either the UFS,
> eMMC or SPI-NOR storage. The RPMB key which is one-time programmed into
> the storage controller to allow authentication of the RPMB frames is
> generated by and only available to the Qualcomm Trusted Execution
> Environment (QTEE).
> 
> The legacy QSEECOM protocol used for communicating with the QTEE is
> deprecated and replaced with the use-case agnostic SMCInvoke protocol
> starting with the Qualcomm SM8x50 series. On platforms where the QSEECOM
> driver still probes, it does not support a listener interface with QTEE
> to enable writing of non-volatile EFI variables to the RPMB for UFS and
> eMMC storage.
> Therefore on such platforms, a TEE client driver which communicates with
> QTEE via the SMCInvoke protocol implemented by the QCOMTEE driver (and
> registered with the TEE subsystem) must be used to update such EFI
> variables.
> 
> Add support for a TEE based uefisecapp client driver which installs efivar
> operations after obtaining an object reference to the uefisecapp service.
> This enables the kernel/user-space to access or modify both volatile EFI
> variables stored by the Secure Application (in-memory) and non-volatile
> ones stored within RPMB.
> 
> +
> +static efi_status_t qcomtee_uefi_query_variable_info(u32 attr, u64 *storage_space,
> +						     u64 *remaining_space,
> +						     u64 *max_variable_size)
> +{
> +	int ret;
> +	u32 out_errno;
> +	u64 maximum_variable_storage_size;
> +	u64 remaining_variable_storage_size;
> +	u64 maximum_variable_size;
> +
> +	if (!storage_space || !remaining_space || !max_variable_size)
> +		return EFI_INVALID_PARAMETER;
> +
> +	ret = qcuefi_query_variable_info(attr,
> +					 &maximum_variable_storage_size,
> +					 &remaining_variable_storage_size,
> +					 &maximum_variable_size,
> +					 &out_errno);
> +
> +	if (ret)
> +		return EFI_DEVICE_ERROR;
> +
> +	if (!out_errno) {
> +		*storage_space = maximum_variable_storage_size;
> +		*remaining_space = remaining_variable_storage_size;
> +		*max_variable_size = maximum_variable_size;

Why do we need to copy data? Can we pass pointers directly to the
qcuefi_foo calls?

> +	}
> +
> +	return uefisecapp_err_to_efi_status(out_errno);
> +}
> +
> +/**
> + * qcomtee_release_object() - Release an object returned by QTEE.
> + *
> + * Each object returned by QTEE repesents a secure service exposed to the
> + * client. Whenever an secure service is opened, QTEE may allocate resources
> + * on the client's behalf. Therefore, once the client is done accessing the
> + * secure service, the object representing it should be explicitly released
> + * so that QTEE can release the associated resources as well.
> + *
> + * @ctx: TEE context.
> + * @object: The object to release.
> + */
> +static void qcomtee_release_object(struct tee_context *ctx,
> +				   struct tee_param_objref object)
> +{
> +	struct tee_ioctl_object_invoke_arg inv_arg;
> +
> +	memset(&inv_arg, 0, sizeof(inv_arg));
> +	SET_INVOKE_ARG(inv_arg, object.id, QCOMTEE_MSG_OBJECT_OP_RELEASE, 0);
> +	tee_client_object_invoke_func(ctx, &inv_arg, NULL);
> +}
> +
> +/**
> + * qcomtee_get_uefisec_svc_obj() - Get a UEFI Secure App service object to
> + * begin communication with the service.
> + * @ctx: TEE context.
> + * @client_env_obj: The client environment object returned earlier by QTEE.
> + * @uefisec_svc_obj: The UEFI Secure App service object.
> + *
> + * Returns 0 on success.
> + * Returns < 0 if client environment object invocation failed.
> + * Returns > 0 if client environment invocation was success but UEFI Secure App
> + * service object could not be returned for some other reason (represented by the
> + * returned value)
> + */
> +static int qcomtee_get_uefisec_svc_obj(struct tee_context *ctx,
> +				       struct tee_param_objref client_env_obj,
> +				       struct tee_param_objref *uefisec_svc_obj)
> +{
> +	int ret;
> +	struct tee_ioctl_object_invoke_arg inv_arg;
> +	u64 obj_id = client_env_obj.id;
> +	struct tee_param param[QCOMTEE_GET_UEFI_SVC_NPARAMS];
> +	u32 uefisec_uid = QCOMTEE_UEFI_SEC_UID;
> +
> +	memset(&inv_arg, 0, sizeof(inv_arg));
> +	memset(&param, 0, sizeof(param));
> +
> +	SET_INVOKE_ARG(inv_arg, obj_id,
> +		       QCOMTEE_OP_CLIENT_ENV_OPEN,
> +		       QCOMTEE_GET_UEFI_SVC_NPARAMS);
> +	SET_TEE_PARAM_UBUF(param[0], UBUF_INPUT, TEE_PARAM_UBUF(uefisec_uid));
> +	SET_TEE_PARAM_OBJREF(param[1], OBJREF_OUTPUT, 0, 0);
> +
> +	ret = tee_client_object_invoke_func(ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(uefisec_app.dev, "QCOMTEE_CLIENT_ENV_OPEN invoke ret: %d, err: 0x%x\n",
> +			ret, inv_arg.ret);
> +		return ret ?: inv_arg.ret;
> +	}
> +
> +	*uefisec_svc_obj = param[1].u.objref;
> +	return ret;
> +}
> +
> +/**
> + * qcomtee_get_client_env_obj() - Get a client environment object to begin
> + * object exchange with QTEE.
> + * @ctx: TEE context.
> + * @client_env_obj: The client environment object returned by QTEE.
> + *
> + * Returns 0 on success.
> + * Returns < 0 if root object invocation failed.
> + * Returns > 0 if root object invocation was success but client environment
> + * object could not be returned for some other reason (represented by the
> + * returned value)
> + */
> +static int qcomtee_get_client_env_obj(struct tee_context *ctx,
> +				      struct tee_param_objref *client_env_obj)
> +{
> +	int ret;
> +	struct tee_ioctl_object_invoke_arg inv_arg;
> +	struct tee_param param[QCOMTEE_GET_CLIENT_ENV_NPARAMS];
> +
> +	memset(&inv_arg, 0, sizeof(inv_arg));
> +	memset(&param, 0, sizeof(param));
> +
> +	SET_INVOKE_ARG(inv_arg, TEE_OBJREF_NULL,
> +		       QCOMTEE_ROOT_OP_REG_WITH_CREDENTIALS,
> +		       QCOMTEE_GET_CLIENT_ENV_NPARAMS);
> +	SET_TEE_PARAM_OBJREF(param[0], OBJREF_INPUT, TEE_OBJREF_NULL, 0);
> +	SET_TEE_PARAM_OBJREF(param[1], OBJREF_OUTPUT, 0, 0);
> +
> +	ret = tee_client_object_invoke_func(ctx, &inv_arg, param);
> +	if (ret < 0 || inv_arg.ret != 0) {
> +		dev_err(uefisec_app.dev, "QCOMTEE_ROOT_OP_REG_WITH_CREDENTIALS invoke ret: %d, err: 0x%x\n",
> +			ret, inv_arg.ret);
> +		return ret ?: inv_arg.ret;
> +	}
> +
> +	*client_env_obj = param[1].u.objref;
> +	return ret;
> +}
> +
> +static const struct efivar_operations qcom_efivar_ops = {
> +	.get_variable = qcomtee_uefi_get_variable,
> +	.set_variable = qcomtee_uefi_set_variable,
> +	.get_next_variable = qcomtee_uefi_get_next_variable,
> +	.query_variable_info = qcomtee_uefi_query_variable_info,
> +};
> +
> +static int qcomtee_ctx_match(struct tee_ioctl_version_data *ver,
> +			     const void *data)
> +{
> +	return (ver->impl_id == TEE_IMPL_ID_QTEE);
> +}
> +
> +static int qcomtee_uefisecapp_probe(struct tee_client_device *tee_dev)
> +{
> +	int ret, err;
> +	struct tee_param_objref client_env_obj;
> +	struct tee_param_objref uefisec_svc_obj;
> +
> +	uefisec_app.dev = &tee_dev->dev;
> +	/* Open context with QCOMTEE driver */
> +	uefisec_app.ctx = tee_client_open_context(NULL, qcomtee_ctx_match, NULL,
> +						  NULL);
> +	if (IS_ERR(uefisec_app.ctx))
> +		return -ENODEV;
> +
> +	/* Obtain a reference to client_env object to begin object exchange
> +	 * with QTEE

Nit: check out the preferred block comment format. also, I think these
comments echo the code which pretty obvious here.

> +	 */
> +	ret = qcomtee_get_client_env_obj(uefisec_app.ctx, &client_env_obj);
> +	if (ret) {
> +		err = -EINVAL;
> +		goto err_get_client_env;
> +	}
> +
> +	/* Obtain a reference to the uefisec_svc object which provides access to
> +	 * the EFI var storage.
> +	 */
> +	ret = qcomtee_get_uefisec_svc_obj(uefisec_app.ctx, client_env_obj,
> +					  &uefisec_svc_obj);
> +	if (ret) {
> +		err = -EINVAL;
> +		goto err_get_uefisec_svc;
> +	}
> +	uefisec_app.uefisec_svc_obj = uefisec_svc_obj;
> +
> +	ret = efivars_register(&uefisec_app.efivars, &qcom_efivar_ops);
> +	if (ret) {

If we have both QSEECOM and QTEE drivers enabled (which we hopefully
will in distro kernels) and if QSEECOM has already provided UEFI vars
implementation, this call will print a warning and a probe error in
kernel logs. Similarly, if this driver registers UEFI vars
implementation first, the QSEECOM one will print out the error.

We know that there is this kind of a clash. I think it makes sense to
handle it. Earlier you wrote that QTEE would be a better option if the
platform supports both. Would it be possible to implement this kind of
selection?

> +		err = ret;
> +		goto err_efi_vars_reg;
> +	}
> +

-- 
With best wishes
Dmitry
