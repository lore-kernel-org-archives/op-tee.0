Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD8EC61DD3
	for <op-tee@archiver.kernel.org>; Mon, 31 Aug 2026 11:15:33 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id EDC7B45396
	for <op-tee@archiver.kernel.org>; Mon, 31 Aug 2026 11:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788174933;
	bh=8ULGEUNNJjvyNdM22e7Tq+wJQwAaiE78urMxW652MuQ=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=FZ1KJIPni5+lqIEYIhe9c0Jcbzetu3V3bW8zHFs1z3B7cWAAyCO8o87w9bxDExCGh
	 RUdmimQKXvxy4NRX71t65pfOyM36ZjJeYBwP4KNVzZJr4QBloJ4pMIfnVRBFyMOoy9
	 l4FBzjyhuO1bE0VuiqDjC8iFt86SpDnqFrSAAjIdENXbk2/vMW5uA+uRA5GQY9Kb2Z
	 y6orreOFgpm0uaQHDExMsx/qp9a1fcvaVtAv46LZj7oXcWsqhOpeOm9DUaExfUzF7d
	 GlS0uRn8IyJb6L/EenAThPXBNxV4bZ12zCtsk0yOaluW3Vka1wJMTb7+s6HRf1RROF
	 q75FR5OvI9Ekg==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 571744440E
	for <op-tee@lists.trustedfirmware.org>; Mon, 31 Aug 2026 11:15:26 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=i/ixE2zj;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NcgH3XoN;
	dkim-atps=neutral
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VBA0uP320555
	for <op-tee@lists.trustedfirmware.org>; Mon, 31 Aug 2026 11:15:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YunmAvG2pE66QhekMLMzUPWMf7nH38ggy6Vr0EmXp94=; b=i/ixE2zjgLMAs+zL
	bcCx3btOx/4Ux2/TNwtwOUaRperJRA9AxSnZPvAg0e1ds4JtnacejfPRsY1lCtW7
	R7xYUn+vxZZq2b4iYWTTO2DiNkCeKFcv0dQR75texHXYCRWilBbZmbBlfYWJEckX
	Q9qM95p10/VnqFlw11AsZeTLExTapTqNriqqJu+bmwOxZ0FEULlOIHRSHMq1JLKb
	7k6qiB4ylYmtzpj5/hNOTj4LxEk6r7bVksPrwg7qHlXruSDoJ9zwH3s/vUEzw6NE
	SZwb8dsQDo83WU/olEoagz8EUeafeYTK3tBj7dX3yBWRNFdj4WvOqniFs75AsmHC
	TBCcOw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd8cvr1fh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 31 Aug 2026 11:15:25 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c21be5bb4so7422131cf.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 31 Aug 2026 04:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788174924; x=1788779724; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YunmAvG2pE66QhekMLMzUPWMf7nH38ggy6Vr0EmXp94=;
        b=NcgH3XoNPwRF2iobmAK0W7rZYvkFY+F3x21esjMRG6VgX3kuPvXg7J1GB7zJjqRc1O
         On6TtHgVT1Bqp5zAKUm5d6yw/rtucLUStwancoGabKvyjKyrTnLjukJVtlZywjPeR274
         xcbCvsqg1irZN32modnNUolh2CACXVICB0HkCCPpn+BJUBZVGKikOB/raIZ0u5PBAII5
         Dl9ec9FA4BUzbr3uOAle42AOtdxmoMxUND9qh3MRZoZbhVFJlzSvsPtmkP2d1KoeZ597
         tGr0SzPuA10gID0mqmtyMn1MkTeCcyIAJLWKhGtFp8FUS+ULPQIweUe06+opRnRYchtw
         TcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788174924; x=1788779724;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YunmAvG2pE66QhekMLMzUPWMf7nH38ggy6Vr0EmXp94=;
        b=pNdhvcmFckOMTy6jW8EONBfflOsSBZ3sqJ7e41A5ts2P2myRK+iE+2RCLkLnIoQCMf
         fWKZDk6EUhs5GaglvubnqSo+3Bqf+tuMfj0nduELXmYDDpfDctbsVqCliGmz576hKT2p
         qf9+RrosrYSjjrSrxRAYkitEHEF+JvmQkCxbsJDJLt9W1bXaJeS8nHSVL/dsIi8r/Oeg
         d3QXv6NhT4XG6Vox3n/uRBvAA+N2wgEff2aFidnPLAosWBsES9A0UC0lZU/9Fn9ljEv0
         CQxfBGxmMmHW/YsSSj/RuI2EoQDxtaN9J2VcVrg1bobLXy0N65bfrb0zP1jDhQfNh27O
         GteQ==
X-Forwarded-Encrypted: i=1; AHgh+RoUx1Ol4fTIMS9mqeNekAUxTUUtkbadekzDMOhApWYW+FwyR1q/St9d3nkkOgO06P25hRo6WK4=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++mzw2W1ZvsFHuFJLWTPhEZyQgyRpeNcPr6TX7KIMKDVjSRRZal+
	GLn2fAoFzDp99hRdS+Lr4v21GZyP+pP+qHbFvKUzGxZG5biEPBl00othOipJBT8NmNMZBE1K5JG
	UortegclX0U1nsJtBoARtwfEm8ljmmPyHnNgdAStPztGspLtj0K/vxmjNOQeKfGiwdIRB4d+a
X-Gm-Gg: AR+sD13ULyAsDcaauA8cRYvM9dKBch8Rfo9mn6uGV17Nc7LrLYRtSImoX66/WS08im9
	qa4monyntwtdFsgFj06bdm9pxr9m42Kn3rDgQBXp6oCQ11deqxQ108HIMW7hXMdgBWH3rRx6mFz
	s8glUm2f03KalmTJ8FdBw0/Pukpt1EGB1qFTcRQAA52B12Ux+JUky+c0JljVddyEwT5hPLBW/8Y
	wpTdmBm15U0IgvHCWqjhgg0qdMShG8frAkntwRMXp/s0RTlZJaq8IqnVtLN7FoqISOzeVzYably
	Z8OZ0n2CLTuFJIpN2kGmaztHBI/s858h6kkuPo+xXV48tS/85yEOtISw5Sn1Ubk2MP14B/BlbsM
	MfyatC1NkyiOmIHILlDPNMA==
X-Received: by 2002:a05:620a:45ab:b0:939:74c:f122 with SMTP id af79cd13be357-939286884f8mr854320585a.1.1788174922734;
        Mon, 31 Aug 2026 04:15:22 -0700 (PDT)
X-Received: by 2002:a05:620a:45ab:b0:939:74c:f122 with SMTP id af79cd13be357-939286884f8mr854275885a.1.1788174918130;
        Mon, 31 Aug 2026 04:15:18 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25895beeb8sm212026866b.31.2026.08.31.04.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 04:15:17 -0700 (PDT)
Message-ID: <e7f7f0ea-cb63-41f2-93c6-5d47fe4cca3b@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 13:15:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] firmware: tpm: Introduce tpm-qcom driver
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20260831-tpm_qcom_driver-v1-0-6f16fa6924fa@oss.qualcomm.com>
 <20260831-tpm_qcom_driver-v1-2-6f16fa6924fa@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260831-tpm_qcom_driver-v1-2-6f16fa6924fa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA5NiBTYWx0ZWRfX9u9JmNVQsKz9
 lcfCsZtNfZnPFXzbYpYv3o/gvwC1m8Ba0+VgRkXr3v7jGP7ZbcIz4svJ6z56fz9R4UDgYIs7aVN
 aS+TrN2ijb/dWg4LLxKRAdnhsbGNFls=
X-Authority-Analysis: v=2.4 cv=JtnBas4C c=1 sm=1 tr=0 ts=6a95624d cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=1TzI99NNmMpykW__4ucA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA5NiBTYWx0ZWRfX43RWKMnLtfx9
 a1tE+kvMkijtMlwExJwRnLbSBz0QlE+DBfyrh151J+vOLKZMHcBSLoaBwJXbuOslMdA2w8onhso
 4TUUd/jos7ACmeOQbFopUUBCHB9B3UIldzQ1irhrzHGAWy28tlzmHhZw55iHpCHrb7Z2ZWvZKMo
 uI05eyiEG1PETLEsHVyjJUz/ThAfeBSjqBWt6FpnnqwnzhHTBqXpBd1T6FLjAK1Mj5Htut8J4EB
 BoS6cD0JmuczmMR1xpGFpTsS+pt8D0XzpuLTadz+nc4qxY8z29Xtnu3vTXBXZJ0UNqsfItaEqyz
 tcrlAIWf5FF8nTblYrkgSrXC2ulIX48/WPqFzizdzWP2HmOe1yUWRRiApVUwMI8LZFsLGGuc3Za
 usKYXRRPHD/m03z0+PWNGyGPBdBPQJc66UHW5V52XKXO4hmTKpaWouI75GKD/E1xtcilWyJF+jj
 IhqA2GcBzhzFTgZWYAw==
X-Proofpoint-GUID: ZL-nY9voSDSsyBc8HtNDZFGPJPCinYIC
X-Proofpoint-ORIG-GUID: ZL-nY9voSDSsyBc8HtNDZFGPJPCinYIC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310096
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.08 / 15.00];
	BAYES_HAM(-2.98)[99.90%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmx.de,ziepe.ca];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.197:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 571744440E
X-Spamd-Bar: ------
Message-ID-Hash: Z7O7POGDN3GGTHUA5XKTPH7IJ7GI4S47
X-Message-ID-Hash: Z7O7POGDN3GGTHUA5XKTPH7IJ7GI4S47
X-MailFrom: konrad.dybcio@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/Z7O7POGDN3GGTHUA5XKTPH7IJ7GI4S47/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Konrad Dybcio via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

On 8/31/26 11:43 AM, Kuldeep Singh wrote:
> Add a TPM chip driver for platforms where a TPM 2.0 instance is
> implemented by a Trusted Application (TA) running in Qualcomm's Trusted
> Execution Environment (QTEE), reachable over the QCOMTEE object-IPC
> transport.

[...]

> +static int tpm_qcom_get_client_env_obj(struct tee_context *ctx,
> +				       struct tee_param_objref *client_env_obj)
> +{
> +	int ret;
> +	struct tee_ioctl_object_invoke_arg inv_arg;
> +	struct tee_param param[2];

nit: Reverse-Christmas-tree would be preferred

> +
> +	memset(&inv_arg, 0, sizeof(inv_arg));
> +	memset(&param, 0, sizeof(param));

You can zero-initialize local struct variables like this:

struct foo bar = { };

[...]

> +static int tpm_qcom_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
> +			 size_t cmd_len)
> +{
> +	struct tpm_qcom_private *pvt_data = dev_get_drvdata(chip->dev.parent);
> +	size_t rsp_len = PAGE_ALIGN(MAX_RESPONSE_SIZE);
> +	size_t copy_len;
> +	int ret;
> +
> +	if (cmd_len > MAX_COMMAND_SIZE) {
> +		dev_err(&chip->dev,
> +			"%s: len=%zd exceeds MAX_COMMAND_SIZE\n",
> +			__func__, cmd_len);

The name of the function isn't helpful here, this is the only time this
message appears, so it's easy to grep

[...]


> +	err = tpm_chip_register(pvt_data->chip);
> +	if (err) {
> +		dev_err(dev, "%s: tpm_chip_register failed with rc=%d\n",
> +			__func__, err);

Likewise

[...]

> +#define QCOMTEE_TPM_GET_TA_VERSION_ID		0x0001000
> +#define QCOMTEE_TPM_TA_VERSION_GET_MAJOR(ver)	((u32)(ver) >> 16)
> +#define QCOMTEE_TPM_TA_VERSION_GET_MINOR(ver)	((u32)(ver) & 0x0000ffffU)

That's FIELD_GET(mask, x)

Konrad
