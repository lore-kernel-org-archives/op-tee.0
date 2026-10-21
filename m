Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF550606A31A
	for <op-tee@archiver.kernel.org>; Wed, 21 Oct 2026 21:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=BvyWa72C;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=e8p3urDB;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=co5WpzRP
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4D69D45178
	for <op-tee@archiver.kernel.org>; Wed, 21 Oct 2026 21:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1792617392;
	bh=tIG/ppToIttyZkO5vXi/KG4KgqNaKSYm0pxA//JFyGg=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=BvyWa72Clrs69FxALIKSNPKPlN4Z8Oq9WWXCG5qCBJlhDR6yX5eqT8QVzxb+ZURsW
	 eP5tPs7i/s750gg3SInHi/krrkDB+OuyV1NeufH24cN02Zf0eUpxT9SGJZoiA+Feh/
	 igkJQpvOugOJJK8C908IWfLpjYsQnVEVPROTkdyYNm13PHpIfJpDWJEiATn5heFJNC
	 xWk9PZwXR1l7X3UleysTuvOjDWGSltPyyDWVLAxm2Zpk/NZwpkFumm61wT1/PloJ8q
	 XShqNF6iZZh0kT+2U2ox9AoTG3ukxfBH+7K7ZzoWr8+l8P5KnMDjHfb0bYpY9/Fcmv
	 WJUdDq+Cy1KAg==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 341E844A25
	for <op-tee@lists.trustedfirmware.org>; Wed, 21 Oct 2026 21:16:14 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=e8p3urDB;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=co5WpzRP;
	dkim-atps=neutral
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LKeKTW2237412
	for <op-tee@lists.trustedfirmware.org>; Wed, 21 Oct 2026 21:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	In7UWKZFYC3zSnJsQr1KWQoGjjGRCbWkVCXiuO48ynQ=; b=e8p3urDBkNn0Qwxu
	QgKsj7vg5qiGp0woOOXU26cWe3QNGql/aNqfrqHIOYv4AoFUS2cFMeU6a6PxqbsU
	eEfhqd47h2mv+C+1zrsxOhkeL+FpAfEJBJPTPoq3XAuIul13mp2JlR2EkrAZvxyq
	jsz2l4Cxav82YO1G3bRILzFlGijsWe66daleEr3yPviFTOGTGkOrmXao03HfbwAD
	pmS3YQeGcytTBSAWfO1PIT1w6PQadUVV71mmZT9yel9zEqNgTxU1z0UHnrS1TnHB
	Z1/1Or3rwbCKS/dyP2ljOhY1i+FBPnaazXxlGkGubngc8LKr0QKtBYZYSjDAeDqs
	QvJdRg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0v892hu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 21 Oct 2026 21:16:13 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-341eff9e381so2937797eec.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 21 Oct 2026 14:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792617373; x=1793222173; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=In7UWKZFYC3zSnJsQr1KWQoGjjGRCbWkVCXiuO48ynQ=;
        b=co5WpzRP3hCw8cHlCGo0JquXoz+sTbMAgPTuxjD21Zlf3D0nfRHPuukD911F6miL0K
         IOaD230pd9lQJ2gmpNpu72S0vRx0mO/ny2DZwJRF8fE52B3uHPozZ51AHubjJ2JS53cn
         14+9IumOyJxBEPnCTpKFNanxTu6l66TPx3rZ5Irpdm++PYpi6qCqleAKX0jZjLxj2eol
         0RfCWSv1+eP7iFr/wvct968wqlQTyeqWTFhFVnX7CFX9tfIiMo4UDjle5FjTOCaVpdJ7
         e/42NrelT7JxEMDyDdGIT3n+t2A1VWG6mAbMgCyHFlib2Gp28oqBM066yVikJ4lu8ic8
         GQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792617373; x=1793222173;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=In7UWKZFYC3zSnJsQr1KWQoGjjGRCbWkVCXiuO48ynQ=;
        b=Pm3IKCqyHLPTI5v2OQSi1AWvIebiiZz/Jmp7KOPKfnIDei1Sd7A2bsffQJEm585w7N
         MnQPUJPdS84fNDQVsJYopqUUnvo1FrA0wMDUxe/CA2JklI0CcJGB6K62YfvN2wr0RkaR
         WbzAmFGw4p1LdW/0WMDsbtOliiwFm7cjOU4b/pLuEbbXTZv2iJU+L+90zCzaBpHge776
         FmuYNeuxJ68NUJcS+RACeW/WHdPnLbWeKP9Tl37IuGZTFp9lk1bFGxeNzcR/ZdZLx5Nz
         3t+u2tOBhRk0XuSpaHLGwITyjlgW9Vp9wQm9/mlfr8VPrHGkYOqwzq7gUH7LED60Dlb+
         sVBg==
X-Forwarded-Encrypted: i=1; AKwUvBwqO95fCmqL1+gevcNrg9ap52pnY4L3wf6+uvc41Vz6VyQE+D+FV1SL8FDU754mUYbBzY0FvPQ=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYKjlRa2gEBQNbwtOBhv3FhvnnYtYzRVP5DOi3NqORIbBd37KLSW
	SJAHbuq6hFryZecLZqqdjX4kq0qpts/wiD5QKiYrKq0YBX4Qa32F4vjQStzq6jRD3r8qCt//R6s
	hZ4GztZTYxLgzQLkwFTCcxpVNaPCkNx0qHS4+lFOaTkHDT2KXQbXuyocT4CsZMKswG1gArKo=
X-Gm-Gg: AYBFou2+R/9K71xZD4RRbnYQxKnUId+DOV4Z+CJYtS0bWYd9QI58Dx+KBVcoUTfKErJ
	WEVoj0u/XYAbM+fDvcKv38f4sVySR8koo/PtOiAWqhGUtx57LUKRpsRkW9hiT0HwzvehbmR5afh
	ILCyUyFfTjFD8peDYnn/oc/lsfgG7W0mqtbxNQ6E4v/pxzsyqMb1g/L5P4h01HRsqrHCwm/iN9r
	jQ9u0RJGMEcs1qrKAZO0e3pXjOlEwu41Ee0mDN5xvIgvWV8jWxQY0vfgLnY7cCzLrTfaiICwKsO
	GXSxThvzAmRM4FQcjbGl/EcJpcOU1I0uozyijvU145GixeCyPdDbU00qMVDKIRUBjuZJ5Q/6KTd
	yIszi+9cGrTVPCeIHXxynjQj1x0T1yF8=
X-Received: by 2002:a05:7300:828a:b0:367:185e:867a with SMTP id 5a478bee46e88-3674f21c1f2mr4409479eec.38.1792617372475;
        Wed, 21 Oct 2026 14:16:12 -0700 (PDT)
X-Received: by 2002:a05:7300:828a:b0:367:185e:867a with SMTP id 5a478bee46e88-3674f21c1f2mr4409446eec.38.1792617371755;
        Wed, 21 Oct 2026 14:16:11 -0700 (PDT)
Received: from [192.168.1.86] ([65.181.13.88])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36741f753f7sm9947297eec.27.2026.10.21.14.16.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 14:16:11 -0700 (PDT)
Message-ID: <ef93b833-68d0-46e1-a777-d7451e50da4c@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 08:16:05 +1100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] tee: qcomtee: Register qcom.tz.tpm service for
 discovery
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20261019-tpm_qcom_driver-v4-0-6889b9804ba7@oss.qualcomm.com>
 <20261019-tpm_qcom_driver-v4-1-6889b9804ba7@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261019-tpm_qcom_driver-v4-1-6889b9804ba7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=C9Z8WgP+ c=1 sm=1 tr=0 ts=6ad92b9d cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=DFNpOA17G2bluAzxCnbuxw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=TZTEVhZfE5fPnIgvEYgA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA4NCBTYWx0ZWRfX1Vq9+f1TWiz8
 NMZJ/p69w0Drw3J4aGW3BQa+wVIaH/WYjl90BEbXcjfnmi4b5IrN+RsB7Txyu7nZieCPbUZn04N
 9qFrkzJVCX8JMZg07/Cz32H7RMRcbUg=
X-Proofpoint-GUID: odw2mwKNYgVnFxesZazHL35URjote1hY
X-Proofpoint-ORIG-GUID: odw2mwKNYgVnFxesZazHL35URjote1hY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA4NCBTYWx0ZWRfXyxpE4NxNRgcV
 Spz1+kCOPQC+Z/CyOVIteUxHcCkuC9dOP8x2MAC78a0A0oP3h2AKTtRrCElVjiuyiLQdYMlF/O9
 Q4JN6CifKgGSiX7usLS09VKghoLXuCBYhJLZH3vVNWb5a15bH+9ScyhpwXVVStbj1gElNanw1rj
 ULt0QYm9NxZy3Se+EjogwiGX3olv7iP6kfbQQmz/ki6WBpjWKz7tDSIxgavy2bIf0EdAbY+kK7r
 8fdxeyZzn81h7eUNwj6BJk+PhxJshwN+8oKHlwtkJa5R8MFVnMXVpkC52fwIXkIkgn+NxSL3qr6
 6wEyTgP0/pAgHn9uLpp/fHDCKxedDcW3QK6qrGtQduFAazoz0/gXWnoI4ndacDKsilSxIuLMjvu
 xnrXktE19O3XBD61zc413ItrH90zjp0bfqPwjiop+b0NMxzIQ7Hp15adAsxIsNQ6PgbJE9bJmQl
 zlFD5aFlFI4cbQf+W4w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210084
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmx.de,ziepe.ca];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.200:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DNSWL_BLOCKED(0.00)[205.220.180.131:from];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 341E844A25
X-Spamd-Bar: -----
Message-ID-Hash: MM7LTKKVKA3CJNPCWSXZPIOXSMQPL76U
X-Message-ID-Hash: MM7LTKKVKA3CJNPCWSXZPIOXSMQPL76U
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/MM7LTKKVKA3CJNPCWSXZPIOXSMQPL76U/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/19/2026 8:21 PM, Kuldeep Singh wrote:
> Add "qcom.tz.tpm" (QCOMTEE_TPM_UID) to qtee_services[] so the TPM TA
> is enumerated as a TEE-bus device, allowing a client driver to bind to
> it via its generated UUID.
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> ---

Looks fine to me.

Reviewed-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

- Amir

>  drivers/tee/qcomtee/call.c        | 4 +++-
>  drivers/tee/qcomtee/qcomtee_msg.h | 2 ++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
> index 47d8a4f9a159..1b887da83341 100644
> --- a/drivers/tee/qcomtee/call.c
> +++ b/drivers/tee/qcomtee/call.c
> @@ -747,7 +747,9 @@ static const uuid_t qtee_service_uuid_ns = UUID_INIT(0xe1b48857, 0x6154, 0x49f9,
>  
>  static const struct qtee_service qtee_services[] = {
>  	{ "qcom.tz.uefisecapp",
> -	   QCOMTEE_UEFI_SEC_UID }
> +	   QCOMTEE_UEFI_SEC_UID },
> +	{ "qcom.tz.tpm",
> +	   QCOMTEE_TPM_UID }
>  };
>  
>  static void qtee_release_service(struct device *dev)
> diff --git a/drivers/tee/qcomtee/qcomtee_msg.h b/drivers/tee/qcomtee/qcomtee_msg.h
> index 9278a361dc70..9fff9dc5fffb 100644
> --- a/drivers/tee/qcomtee/qcomtee_msg.h
> +++ b/drivers/tee/qcomtee/qcomtee_msg.h
> @@ -106,6 +106,8 @@ union qcomtee_msg_arg {
>  #define QTEE_VERSION_GET_PATCH(x) ((x) >> 0 & 0xfffU)
>  
>  #define QCOMTEE_UEFI_SEC_UID            413
> +#define QCOMTEE_TPM_UID			81
> +
>  /* Response types as returned from qcomtee_object_invoke_ctx_invoke(). */
>  
>  /* The message contains a callback request. */
> 

