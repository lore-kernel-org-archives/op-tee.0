Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94671CCA462
	for <op-tee@archiver.kernel.org>; Fri, 16 Oct 2026 12:54:25 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B212B45363
	for <op-tee@archiver.kernel.org>; Fri, 16 Oct 2026 12:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1792155264;
	bh=agnKGDj9D/11ohWIAcMyJ9cAJeGIGPxxPTv4jH0y31U=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=icouCPDFSQNvYPJFn84qfmNaIO0KRhZMjnCmHYONAsT4AuwkEAdlXiFuczaqTMW6X
	 MjnatE9E4uWA+hv7mGWWiYKS+7ejvk9UjyVCilbCceRu7gWWHzMmwBEdHjYdwS/HIU
	 72jrOgRz0zFt4bBcLNbO8KsM8jDW5nt6nRQ8uZrE6y2xEAg/neJ+Mg4qCmAOtLyoXK
	 LZAlKr3EZs6HJEK8cSAMELr318V7Qj5OpphW/T2eOEz8FEknGWwiqz8616GgN1+YoE
	 XBS2TsiAC8GIKSIebxp+Lvo46VDtZsnMAzp2tsuzQHx1O137f9lIsEiknsOz+XwnSc
	 V/sytkiwt5O6w==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2F14543A5F
	for <op-tee@lists.trustedfirmware.org>; Fri, 16 Oct 2026 12:54:06 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TKazVqn7;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LXuXwytG;
	dkim-atps=neutral
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GAAEwa2403152
	for <op-tee@lists.trustedfirmware.org>; Fri, 16 Oct 2026 12:54:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SbaygPj1foUfq7XQq4qIhZBp1hiwUcPnKN9f7a+bhbk=; b=TKazVqn7RnIjs6ou
	NMs6ieCixC3sPlkI05ujT0rlEnWQ61HzgmlN7hMoldxL2xmKdHjdUF5tOnrGiu20
	PsXpOAFbpIunQFMYrmQnn/wI24YCXXnhXwffUvwU1GriB3pl+YCC+f+rU0ZtWlvr
	Naz9C2uKdkBOCWIgt4hbgVYCtVBgaVnJV3RS7HOVhHBFGb2CHeFBhh5LDsdToc4A
	Qb2tPKrvfHxfVsfoYiMEwF0EJz+OJio0eAU3xoXDNQRpS8/1WNMmXpk72qDv1Sg6
	E9+Yt2bT4XKXZiTsvDY6MfyYsdrWrIj1Wl/WTnhztUQUEC9E1jtS8K0f3HnzEway
	C4RA7w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb19m4g08-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 16 Oct 2026 12:54:05 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-359b81ad4e8so4537887eec.0
        for <op-tee@lists.trustedfirmware.org>; Fri, 16 Oct 2026 05:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792155244; x=1792760044; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SbaygPj1foUfq7XQq4qIhZBp1hiwUcPnKN9f7a+bhbk=;
        b=LXuXwytG9uWEz5PONbaacvZN4NeUSyVjFDlGG3A5xjkYXPJfcUHeF8N8Z3fao+BmcQ
         cLqnDB6MOYGi8Du/ZyyB4qOM5WfFZVBAWqgfubmR2F68MXCrEs4eJapQ/8DbZl2eWoD7
         xw9PKkop5mDnEiTGOH1Ef83JWAIQHHWtdfTFib/4uMKwtQL51szwOF16KgA1YrNQnE/T
         IvlDouHU/rHG15C/9BT4O0c1w0UgV3h0Njxp3lOZViJYRgNid4uBA5Zf/HHrpeVJK0rf
         wQCWSGQU3ucT2fzQkWMwoRjsnO/TQysCCVogeDHTu5DYLd509juSncJL4992Raor8czR
         40xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792155244; x=1792760044;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SbaygPj1foUfq7XQq4qIhZBp1hiwUcPnKN9f7a+bhbk=;
        b=D/oU6sDZFa7NwRVTqeqK+rbjuxnNSfehXrUBhygs/izulgqKtdq5fQd4z16r/6q3cZ
         0XaFCJ3lub5sNRSXv6hqd8RKrhOzTSOxr+m9zz9BYy2I+Bh3yjqfyEOyV1I/jdcYTgK4
         WZO+HBBSH3DdhXup6p3/LkGkD91jmZ4Xt+gRgeFcDrKibt0/lBAYOaOVrzw9ZqewwF28
         RkiuHmbWRwCnZ7qU/zSZLZV30hoU+yZ0MeZmAcjR+5/Y5U6pqI9ci/D5J5f2tp4FNdTS
         gvj+bjtBQSWaI+P4mmRjgfNqV7IIDoHECrPxi7SWQfHNgF4cwwXHY0eiTAq0uzi2AGmx
         9TXw==
X-Forwarded-Encrypted: i=1; AKwUvBw3iXkhh+fmYpLyra1V77tTMeQDhWPvMH7/m15yjsx4AvITaI7jw5n5vuEPbsoGaWbksIXh72I=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYLHpDjayBOnw3gBuHaxI+O0LzhcinvTuuhavbPlM+0jISrs+YBW
	alAfzonVJYz1nSaXih9L8CnabubQnb6vdBVvoM7TamJtkP/nXU+RUXomDFVFdsbBo2wKOdqgym3
	T4CAY9mjylpKQOsAooxevZ7MTyalqa/pr8scnPr9OuzXtRRiRH6XDK+GmpPgvjEM/LWzhEBP0
X-Gm-Gg: AYBFou21f/x4hmjK6+lJeeS9agsr0TeNMByCV7IegsmMc2u/XCq9I9kJUAjNX0Pt9HF
	JdIi2/ejmhCTrlnG3LS/KEcybvcWRWbyndl6rwDsPUi0cCX9gzOGavfP5cZG9Kqh1Nks6u9xLPi
	CogiWdj35830pUcwJbh2KZ9zA4ju81TFf4ppxcYszfOWi7Bhxqc9wZrKtEDoM+4cSIMRK6yahFS
	BMmFIwdZjp5q23zL71Zfz1r+i5FYcGuFeOtbcOzs4jY5bfP2EIQu+a8TgwgOFm/4JLIlMEB1ieF
	nkuSWn5OR0XWuguEhHwdm/HfLIYlezK5ABeJuuxEx6xH8cPzVSUcpoArx2D2tS8H3VhEMxkYwcy
	DT8cYVbR06mAUHPhSkOJaam30Tu1pHw==
X-Received: by 2002:a05:701b:2914:b0:174:7d98:fe9b with SMTP id a92af1059eb24-1747d99019bmr18067807c88.22.1792155244164;
        Fri, 16 Oct 2026 05:54:04 -0700 (PDT)
X-Received: by 2002:a05:701b:2914:b0:174:7d98:fe9b with SMTP id a92af1059eb24-1747d99019bmr18067699c88.22.1792155242548;
        Fri, 16 Oct 2026 05:54:02 -0700 (PDT)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-183190aa3ebsm5344485c88.8.2026.10.16.05.53.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 05:54:02 -0700 (PDT)
Message-ID: <edaa8679-63a6-45b8-9e36-c04740f20332@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 18:23:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] tee: qcomtee: Track the object invocation context
To: Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20261015-qcom_uefisecapp_migrate_qcomtee-v5-0-1460691b35d3@oss.qualcomm.com>
 <20261015-qcom_uefisecapp_migrate_qcomtee-v5-1-1460691b35d3@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261015-qcom_uefisecapp_migrate_qcomtee-v5-1-1460691b35d3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=aLdlOr9m c=1 sm=1 tr=0 ts=6ad21e6d cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=wUKrATpdGnaYG2FsxpQA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: -pga_H-GnDbt6KlzX-MF0qHWKzRXAv6y
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1MSBTYWx0ZWRfX3FKC4Ri4NDi3
 QGqGagYuL7usIbMVAFDbu8Hj3qNqhb7fLspQ10xl+H2mSAjqODWPH6yPO4fHoeLtMMKZ6TJ6QOw
 hl/t9tJj+2giXcgAYXB6S1AQMpDgdFg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1MSBTYWx0ZWRfX5r4RqjcWD9B/
 wqpBbFtr/PDUpSTHWIzjj5bsoyyEFiIhSRM75hRlghjnWbtuy+8e5aSHeQO/HduVQxObVx65Uf6
 kJWsVJWrFTt4Juu0bQrJzTk9bxrgJTCLK9iw363pDOI4XkwJHryimS0KFvlTKLRAsux6RS446wG
 /OmeGvpxvW16P1FSySH1OXaBrDKHGZcBnUs0+kd9ylHQq192oXF2hNG/eo6hPOdYfq188ZFKqz2
 p+u9f9C9EnA/gJh2bsfid/VI+r1TOLXhYD5CLGmPRNVi1tj+al679KJzT8KtKghbyVNS1GVEbXV
 c+4c1Q+kJqlD1TmNdO9Pm4vpbwqfCh6riusplcDJdbq0fduAfDLB5vxQtp1TjEV6RqV8H3cW458
 eH5lwDw21ui9eBxdSJ3d3plTXAUuVvF55Ipwu2f5KAke2P7uf6HqUWRxt6m/CjlE/9GGE/8k+nc
 bCf8IvQFk3e8OBiRi5Q==
X-Proofpoint-GUID: -pga_H-GnDbt6KlzX-MF0qHWKzRXAv6y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160051
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.88 / 15.00];
	BAYES_HAM(-2.88)[99.50%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.199:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[202.46.22.19:received,205.220.180.131:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 2F14543A5F
X-Spamd-Bar: -----
Message-ID-Hash: KBMGEK3QCBGIVV355FSTQ7MCXIKAPURR
X-Message-ID-Hash: KBMGEK3QCBGIVV355FSTQ7MCXIKAPURR
X-MailFrom: kuldeep.singh@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/KBMGEK3QCBGIVV355FSTQ7MCXIKAPURR/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Kuldeep Singh via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

On 15-10-2026 17:09, Harshal Dev wrote:
> QCOMTEE needs to distinguish between object invocations arriving from
> kernel clients and user-space clients in order to correctly marshal
> UBUF parameters and decide whether certain operations should be permitted.
> 
> Introduce an enum tee_object_invoke_origin to allow clients to indicate
> the context of the TEE object invocation, and add a kernel_ctx flag to the
> QCOMTEE context so the TEE back-end can track it.
> 
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Reviewed-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>

Tested-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com> #on Glymur-crd

-- 
Regards
Kuldeep

