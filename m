Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8B1FF886F
	for <op-tee@archiver.kernel.org>; Mon,  4 May 2026 11:53:20 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7AE6944D33
	for <op-tee@archiver.kernel.org>; Mon,  4 May 2026 11:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1777895599;
	bh=h+f4WvNTMiPEVbnZUsHfPHPq+L80RhcaNVi5YLbSxL8=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=S5M8WU6R39lSUPwjmhjO68S3nyHVj9EAAwmZAaqdai3r8gZLDoNHOARuWTs5VcUCk
	 GrFLHKCSxkhTJp3ujjrlptI/eXJdnhggC05M/YTGhMmxnJvqKuzara43n3YYduQ+Xe
	 CC4VB/4dgobJuQVo1zODx3XNR57Avfq+sf9wq8vMdRSO71CpQ7VPBMRSk25lGebWNV
	 /kZRDmyqmucvf0gdbqS54eJESFKXvRVBEE2icfkvexyFLef96ULfKRwCUhXQPl+wTp
	 3T7sankoceM4h0eV0LgN/PyWtA71uojTgV35NfbZxFHoExB5Ob55Hi2Xagdoh1Lsab
	 o4QKs+ekwd2NQ==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9EA6142F1B
	for <op-tee@lists.trustedfirmware.org>; Mon,  4 May 2026 11:53:12 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NWLzZfQs;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UZwP6URs;
	dkim-atps=neutral
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644B4Yg6798438
	for <op-tee@lists.trustedfirmware.org>; Mon, 4 May 2026 11:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BuofvOz/5FZrPdq3bPa3pWgfvPCVCJgpGjMM0k7A5g4=; b=NWLzZfQs1QlELHxn
	Y1ouGGR/3tqN8ojHkqnjfLgF1IK/OIqHS5RHdcpzFyKtdwoP5X5r/DCZUZc7krRo
	TrF6mHKpb+/bJSBB9lQ75B6mueu3BTq7z5yc+c0NwZz++6Pg9yjDbFLpXpQ6Lyqf
	r3Kw9FxVBslB7ggKcIkMB5xb+WUTynpy2x7FvKofWwRAWl3/GRlbBxbZe+GgePjT
	Mbt09jiAlfiu3vQQoWVZl7M6t0MRbDk++4xk6Ve2bL7nSUXvzNszozWKA76jxQLc
	4dWBFjc97K98NkzUZTIsO2Gr4ad7xNfm6OJuVZfCAGgLHQ4pp/lKwlVCHumQ9jp0
	40+4dw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dw8uxnhnj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 04 May 2026 11:53:12 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-362eb03240bso4926233a91.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 04 May 2026 04:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777895591; x=1778500391; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BuofvOz/5FZrPdq3bPa3pWgfvPCVCJgpGjMM0k7A5g4=;
        b=UZwP6URszj71bBlM3nmi5oNoH5ES5q0TCbV4UxxKaRaysQbyp0P3WTU26ef7DvWXql
         +V+xbpnDRDsP2QCsPNyyyg9KR162rcbzP2pMC8eJvL++jYN4ZtLw0JhDpJHVRBEBIYIT
         X+1nAtF0VmsiAmJkFpatlp7b9joL9BLdQsosM+AA66RSEevKqLnmIBQrYHDL9rn3ispi
         gMGYe0uCuSiDCyQgTh2UOnF4iplnqg+OqFWtigX1PN7d+YSsHX2lyGygblqE0gp80bIB
         JkT2VMV/+RXwDzaSTg1lVJU7yNqNAtktm0jBKPzL0n85hMCpOsoyM+LKsr7rLKmORO6l
         TUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777895591; x=1778500391;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BuofvOz/5FZrPdq3bPa3pWgfvPCVCJgpGjMM0k7A5g4=;
        b=F3RRJJc5ZlhzRgon8ZU+vriO/Jn0tLSsI1bz8/mukq5Qv4d00yWOU+d/G/hEuRvg4x
         Mbit7kSd5C4ViN9YbKXMmjXuFk35oxpg6PqtmNsud9r028iRRak+MitTOzOWXKpywvHb
         rBRVATJjSQaEUwM8WGt9KB/Y8hXWIvWoiOFxZvYTcvYdYRuBjeaS89qtTkiY3Jzqpdhm
         BL/DnTKFJGrRoDBI0pZckfXBs44sebyYoUO5VBPHGD5HFxAsDRXnePL+uAGymTsqjLHK
         orv+D7aQQOAWobztfnJQWzeKqsaGCIhKefli3tLhFgy7O4x0IgzB5tj0/+WkH3Lnfzw4
         Fepg==
X-Forwarded-Encrypted: i=1; AFNElJ8F5FzYA+gyKYfAozx/W3qGg/ENTCfa+zlcYzZx2gDCAHYULygELlx3Yie1X1NRhug1u7QcGQg=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwLIZckWiFOuN8idb+Fr0JU4F/E3IDISZmykpg+kTFA27yPTjdd
	MoRXhMLq/oEUgZUJpqoiJ+BsjlKtpOeX3EiruiAyIR4U5YY9MiZ5gMYEpLXFo8xIBkrvJzZk9ea
	hCC4B/RFD/gxaLlhOb9CWRyyTldX5YcWmLMdlFLmpULAoWKmTl6mBa+loXxm7IRPvFjE937DY
X-Gm-Gg: AeBDieu2JkwgWvKTV2Mo8iuULs5PdZzkvBH1HOG/CiUSXoLgVS5CpUK5eO/i7WVrYM+
	J3OmBA6m8HCdHbetgNGYJJ5I1+1cRwRHXYdPS7j2cBf8e5hKph50zvic55opoAgJT4LVze+Yeei
	yQEKOb3eN6vugRexbMwx+Smy9k8c1Lhw0HIpzbpWjAnXyP+mVFshgO7aQAqHvm+nzIFfBnPNkgH
	7poIqbHRwSBveUo9o9kG9V0jyQ5Hqt7Vu0QrUQnlC/Zk/iasf695xWySbIRcD0JWCmoNXh5m5Wg
	z1VAuiPJFe0nLUZZgw+ul8mv/62n3pPgG3YS6oyg02EFpxqQQ8Cl1t+J7z9Ji4qFUkHUYBm5xRQ
	t8ql7ipAj9onmNq9gk7Y7u6HuWwBZb0XsgD9fdt+TAVQD9Q003yylnIghbv2EBgk=
X-Received: by 2002:a17:90b:4b90:b0:359:fd9a:c50c with SMTP id 98e67ed59e1d1-3650ce4793fmr9409756a91.22.1777895591032;
        Mon, 04 May 2026 04:53:11 -0700 (PDT)
X-Received: by 2002:a17:90b:4b90:b0:359:fd9a:c50c with SMTP id 98e67ed59e1d1-3650ce4793fmr9409732a91.22.1777895590521;
        Mon, 04 May 2026 04:53:10 -0700 (PDT)
Received: from [192.168.29.116] ([49.37.150.129])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ec02ab2fsm11431599a91.14.2026.05.04.04.52.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 04:53:10 -0700 (PDT)
Message-ID: <6515558f-99c5-43c4-9141-4bd4a2be6317@oss.qualcomm.com>
Date: Mon, 4 May 2026 17:22:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/15] firmware: qcom: Add a PAS TEE service
To: Sumit Garg <sumit.garg@kernel.org>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-5-sumit.garg@kernel.org>
 <ab4b5257-92df-4201-ab04-436ab77b2fd8@oss.qualcomm.com>
 <afiCrIYSm8AK9xn9@sumit-xelite>
Content-Language: en-US
In-Reply-To: <afiCrIYSm8AK9xn9@sumit-xelite>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 1x8vCMMCBUphbjlJZJTAegLUwcAtLLwu
X-Authority-Analysis: v=2.4 cv=QqxuG1yd c=1 sm=1 tr=0 ts=69f888a8 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fKl8XJY0368M7tBUixYpxw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=w6fE4RYvq4DoGGcOsJAA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: 1x8vCMMCBUphbjlJZJTAegLUwcAtLLwu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDEyNiBTYWx0ZWRfX3UgoUxSXfd2T
 BsmK9m+YiJekzQRfxmEIkKsLFDb7FqBRKP9QpJOGiDkn8KBjh0Wa+3ib5VTieKPHBaxHgCmrLn3
 iU4fRZz0qXDGdI+YEJ+J93CX2rg01s5GB6+9tEcx72xq1zSW6XkHT+yi9J4tgRIWuTaaus1AO8F
 6zgHXc0asEj9uZ7fUup2YzUrQd4m/KCtkPMvfzVWgxo2dTjisU7VBd3nflaL25fmAWglIr79IB0
 TyELjwVwQP3TiHtP0xX+/nHYwZeBH8IwqWv7YwYfQOGHfLTWCDH6E59kjaEXg/qqQjvVDjl5XIs
 3lRA2ixCr+kO15pi7V1ZmkyC+8O73cFIDZSwzZT3oeJ0oD5O1bGzs/3g5NNzvW9QQMtlur/qH4b
 KpZNTwvK1G8QUoX/Pw5RnQ4ayNbQeFmzzseSVvCZVl26VJTHs/a6gw6pI3hcNW/Dt71/SkVw8u1
 L/ZPrUHHWoKebaZeDCg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040126
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	RCPT_COUNT_TWELVE(0.00)[49];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.70:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 9EA6142F1B
X-Spamd-Bar: ----
Message-ID-Hash: VGI7S7ZMG7N372QTXLGQITPHQ6BI6EBW
X-Message-ID-Hash: VGI7S7ZMG7N372QTXLGQITPHQ6BI6EBW
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm
 .com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/VGI7S7ZMG7N372QTXLGQITPHQ6BI6EBW/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>



On 5/4/2026 4:57 PM, Sumit Garg wrote:
> On Mon, May 04, 2026 at 03:33:06PM +0530, Harshal Dev wrote:
>> Hi Sumit,
>>
>> On 4/27/2026 3:25 PM, Sumit Garg via OP-TEE wrote:
>>> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>>
>>> Add support for Peripheral Authentication Service (PAS) driver based
>>> on TEE bus with OP-TEE providing the backend PAS service implementation.
>>>
>>> The TEE PAS service ABI is designed to be extensible with additional API
>>> as PTA_QCOM_PAS_CAPABILITIES. This allows to accommodate any future
>>> extensions of the PAS service needed while still maintaining backwards
>>> compatibility.
>>>
>>> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>>> ---
>>>  drivers/firmware/qcom/Kconfig        |  10 +
>>>  drivers/firmware/qcom/Makefile       |   1 +
>>>  drivers/firmware/qcom/qcom_pas_tee.c | 479 +++++++++++++++++++++++++++
>>>  3 files changed, 490 insertions(+)
>>>  create mode 100644 drivers/firmware/qcom/qcom_pas_tee.c
>>
>> [...]
>>
>>> diff --git a/drivers/firmware/qcom/qcom_pas_tee.c b/drivers/firmware/qcom/qcom_pas_tee.c
>>
>>> +static int qcom_pas_tee_mem_setup(struct device *dev, u32 pas_id,
>>> +				  phys_addr_t addr, phys_addr_t size)
>>> +{
>>
>> [...]
>>
>>> +
>>> +	ret = tee_client_invoke_func(data->ctx, &inv_arg, param);
>>> +	if (ret < 0 || inv_arg.ret != 0) {
>>> +		dev_err(dev, "PAS mem setup failed, pas_id: %d, ret: %d, err: 0x%x\n",
>>> +			pas_id, ret, inv_arg.ret);
>>> +		return ret ?: -EINVAL;
>>
>> Following the example from qcom_scm_pas_mem_setup() here:
>> https://elixir.bootlin.com/linux/v7.0.1/source/drivers/firmware/qcom/qcom_scm.c#L778
>>
>> I think it should be:
>> return ret ?: inv_arg.ret;
> 
> inv_arg.ret return a GP TEE error code which doesn't map 1:1 to kernel
> error codes. The client drivers won't benefit without having a way to
> decode those errors. So just printing here can help the user to debug
> any issues.
> 
>>
>> This way the client (say mdt_loader) knows what error OPTEE PAS service returned.
>> I can see that is tries to print this error:
>> https://elixir.bootlin.com/linux/v7.0.1/source/drivers/soc/qcom/mdt_loader.c#L286
>>
>> With that,
>> Reviewed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
>>
> 
> Thanks, I hope with above I can keep your tag.
> 

Alright sure, makes sense. Please keep the tag.

Regards,
Harshal

> -Sumit

