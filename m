Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3857A606A31C
	for <op-tee@archiver.kernel.org>; Thu, 12 Nov 2026 09:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AHCKhbfc;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dHeiddSN
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8261744F1B
	for <op-tee@archiver.kernel.org>; Thu, 12 Nov 2026 09:39:58 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AHCKhbfc;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dHeiddSN;
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 07FDD44DC8
	for <op-tee@lists.trustedfirmware.org>; Thu, 12 Nov 2026 09:39:38 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC9CXVB4092381
	for <op-tee@lists.trustedfirmware.org>; Thu, 12 Nov 2026 09:39:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BK/ZnEcuLjdw49CN59om4khY9WBfb0Arfn9F00Ole6A=; b=AHCKhbfcyL1cC0Dh
	u8QJLwloAUVu7iPz9m3lpO96RgeDR/3NDx3Qp3hE7LTacerJQ99pY3V//uf/u7R/
	ySJqviGkjEl5Ft8l/npxEytdbiI/jJ8DGWKNuEA5mLfH42Ieh4Ba6F3LdaMlypbj
	qTVbAn3FCtap8nk0ZNExqNUatFKFizIpYJu+tio1X1SFNWDI0Qu6tICJYk3xYBwg
	cKNLOHihkfnQd41Py4P7Oy+pyB2LmjibMNt2DKMJ6OIvV8ru1tyLvjPg1tP47Olj
	t0vvQbLvGH8GUiWvU4JkN7tSJ+mhn8Le+XYRk0tbJHonl0mASgewsgWGEXne4IAA
	Q9V4Xw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw0m8j7eg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 12 Nov 2026 09:39:37 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b1755b2f26so1985201a91.2
        for <op-tee@lists.trustedfirmware.org>; Thu, 12 Nov 2026 01:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794476377; x=1795081177; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BK/ZnEcuLjdw49CN59om4khY9WBfb0Arfn9F00Ole6A=;
        b=dHeiddSNwjAy6ukg7K33dZyPIamsezK05jX13C4joxGhfyH0ue8f2Tg/bZ2vixslMR
         kX5gSy4CyVyP0Q5Qjz3l/FNbVfzk37TFFOlY5MWCfKpZuYSEhqPm+hMbDX4HqKv15j3i
         6EglUAzyB13j9V2I6lmM1gtATLxRWWQGSMoldNnrJdLw89NjiTfhoAB7aasHAGsHCQua
         KiSmbuNtfizR8o7T0rmspmh+AeqLZNmitq2YudkLDMXmq95vX7LPZDetL+E1akC8ny/9
         0+kmWffGE6lkJria82AYBJofWgFKqcxkE/o9jEPw5UVD+M6+3MvRjohNY7Z9HNzwM5x0
         uHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794476377; x=1795081177;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BK/ZnEcuLjdw49CN59om4khY9WBfb0Arfn9F00Ole6A=;
        b=gVDqosGVTqrc202GkRq56EHuEgi5WS2f3BaSXogfo1n4sD6p8Y+tbR2J0P3DqJqKQn
         44ZHDRtubf1k/aiqburdf4o07wetZjwtxjFTgfqj3i2vEUk9lw48jsoDReV3fnG7Qh1m
         9wi0L5h6zLqP64Aj7ohEyR2rx39mVyYCoTNn8frJFvuqKVyXVu81uzm+eLOsIhVVo1z6
         7HdhyoUTMWI42r7nV/BWrIks5uO40klth9/L81oeQE41C0O/XqpNB67X8foKBYZdjVkB
         O9WRHOobYGnvTiUG4XO8bzlf+Ma8basEyoFu1o7UxQLs0kxgLpt5diqT3Vyp5528n/8A
         ROJg==
X-Forwarded-Encrypted: i=1; AL+hErGjIbkaMA2USPHC4HcrNYyCqzq6Dp+db+NLCcitYcKPCZOCgVA2SU3XrRehiArR2WnikjrLMI4=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z/uRStwPYbUvhV8sMajIuwM1eJC/vdrnNoXAKTEG4vLM9dR+5YG
	ie2wYnvdo91CFg33aR5sxlxYlVawMZmVRQzl7PMnGcQoTohiOZ++aRAQPHheawa/ju9lBmXkELL
	vlSRNSzWiVhKPggrsg6+QWk2cj2sMtW/fLrOhmzRY3TQsUT3S8T8yjloTRtYEEbTDob2ciJUm
X-Gm-Gg: AYBFou3Zsm8iEpzdh+ReqDe3+sWLBFfBHZizIlL3fj9vhj0/kFcYQlNxvGqdRcmnefv
	B7zaKkHOX1LucYJ3vGjimUM0PnWgRp4N6zUb2N45P2xWEscsFGUbzogcAmIKI14QoJk9PGndQKF
	cbruLLSZuCOcr0dW2+sV2lSyywk62197OECR0LUrehhYza9ebhBa+QeTRvLGERba7VQvzPP5nRY
	9N4M03C6U57mlJ6CkOAfq38C71YS5zkd2wV17tQTiwChNQCGVG+zXxG4ZeMs2BVsrdDcAumu5Mo
	4AjBYqbniLLuHS1BwZ+F72w21ksV23ZzezpvwpxPOESUdfE0YlT38y33GgWD/R5pDdRDauGAusW
	neP89EgtBkxAun1MJmWvNivRgA4gB08G6BmxA93njGkZMwSnWpZ9QAGVdrE2w2aeD7NOnGPPsaC
	vRRuU=
X-Received: by 2002:a17:90b:4d8c:b0:3b0:9f53:e8a8 with SMTP id 98e67ed59e1d1-3b182f413fdmr4807313a91.52.1794476376709;
        Thu, 12 Nov 2026 01:39:36 -0800 (PST)
X-Received: by 2002:a17:90b:4d8c:b0:3b0:9f53:e8a8 with SMTP id 98e67ed59e1d1-3b182f413fdmr4807299a91.52.1794476376061;
        Thu, 12 Nov 2026 01:39:36 -0800 (PST)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdd8d7bdd57sm2580615a12.24.2026.11.12.01.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 01:39:35 -0800 (PST)
Message-ID: <c52cfd06-ac5f-4a43-8988-bc3c4a027473@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 15:09:30 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] tpm: Introduce Qualcomm TPM driver
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20261019-tpm_qcom_driver-v4-0-6889b9804ba7@oss.qualcomm.com>
 <20261019-tpm_qcom_driver-v4-2-6889b9804ba7@oss.qualcomm.com>
 <672d7be2-072d-424a-80f7-025c70440b08@oss.qualcomm.com>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <672d7be2-072d-424a-80f7-025c70440b08@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAzOCBTYWx0ZWRfX9YTXt+k9JVU6
 pdNuMhN4ZPZDBrrizRJiedxQwq4EK7mHitEFIA9mavQHj20XSawNXGnsYer1dbvQpyLnHystAbL
 BS6H6THG5sahBuvBc/LXa5GZHx0x9JQ=
X-Proofpoint-GUID: AaNwl47viEtyuhaXwn9kKsmmhQZxokF6
X-Proofpoint-ORIG-GUID: AaNwl47viEtyuhaXwn9kKsmmhQZxokF6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAzOCBTYWx0ZWRfX9LE8kKMiDYLp
 PUo3RLygRsLXH75fSNzfkhO0E620P0pYhWW7l8K3xkGYJ42g47FrPDPeZLaeR6+q+X4wolFuYgy
 AfQ4YHVOJFFt1w8+Rl5rwgsEsjOpeEV6MGsQb+1wNsHoi6iXtPLIrRX6jY4WMQN1KxnkeuGR6BM
 LjeD2OHbTP2NNooAp+kXVNDgeO9FZcOhALl/ZPkpaERnNIyi5JdAKsgVI5f/8bP83w7c1clXz97
 JqJ0kSeMzMynnrlSnQ3aTYM+omn5hqlV95yh5R024NUQwVO2nTvm8ISz/R0X9rPck9CSEpPr8sZ
 5Jsctye8mAwG3fnlDC5XHB4P03nUmqhEi1/W3iLKjgGctQUoBvewO2xkld4tybLkowinDPjMLV1
 zOeaIZauROieqoxiEQbkGS8jTj8oS3IkH7iZ4PIxvNxjD2TDtFk+H1DjZGu0jKvbHQuOrOOlpOY
 DE8sawXMxndOjEyg1UQ==
X-Authority-Analysis: v=2.4 cv=Q9dHcI2a c=1 sm=1 tr=0 ts=6af58959 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=LlorywCyHCjHwqFkWEEA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120038
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[oss.qualcomm.com,none];
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
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.71:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 07FDD44DC8
X-Spamd-Bar: ------
Message-ID-Hash: X6OKPPDXCG3EZ2L33N5UYQ47DAE67SBX
X-Message-ID-Hash: X6OKPPDXCG3EZ2L33N5UYQ47DAE67SBX
X-MailFrom: kuldeep.singh@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/X6OKPPDXCG3EZ2L33N5UYQ47DAE67SBX/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> On 10/19/2026 8:21 PM, Kuldeep Singh wrote:
>> Add a TPM chip driver for platforms where a TPM 2.0 instance is
>> implemented by a Trusted Application (TA) running in Qualcomm's Trusted
>> Execution Environment (QTEE), reachable over the QCOMTEE object-IPC
>> transport.
>>
>> The driver discovers the qcom.tz.tpm TEE-bus device, opens a session
>> with the TPM TA, and register with tpm interface. This exposes the TA
>> through the standard /dev/tpm interface and the existing tpm2 command
>> layer. OS need not be aware underlying TPM instance is dTPM or fTPM.
>>
>> Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

Hi Amir,

Sorry for delayed response as I was away on vacation for more than
2weeks and hence couldn't catchup on the thread.

[..]

>> +/* Max buffer size supported by TPM TA */
>> +#define TPM_QCOM_MAX_COMMAND_SIZE	SZ_4K
>> +#define TPM_QCOM_MAX_RESPONSE_SIZE	SZ_4K
>> +
> 
> I also mentioned it in V2, why using different naming convention across different macros.
> Why not QCOMTEE_TPM_MAX_COMMAND_SIZE?
> 

Seems last time you recommended to prefix TPM_QCOM_* as it's TPM
specific macros. :P
From
v2(https://lore.kernel.org/linux-arm-msm/6e2034eb-0192-4286-beb2-ba7f1186344c@oss.qualcomm.com/):

> +/* Max buffer size supported by TPM TA */
> +#define MAX_COMMAND_SIZE		SZ_4K
> +#define MAX_RESPONSE_SIZE		SZ_4K

These names are confusing, rename to something like
`QCOM_TPM_MAX_COMMAND_SIZE` and `QCOM_TPM_MAX_RESPONSE_SIZE`.

Since both macros are 4K I am thinking to keep just single macro
TPM_QCOM_REQ_RESP_SIZE instead.

>> +#define QCOMTEE_TPM_GET_TA_VERSION_ID	0x0001000
> 
> nipik: For constant either use 0x00001000 or 0x1000. not 28-bit.
> Why not U like others just for consistency.

Seems I leveraged constants directly from QTEE.
This I'll update to 'U' format.
> 
>> +#define QCOMTEE_TPM_TA_VERSION_MAJOR	GENMASK(31, 16)
>> +#define QCOMTEE_TPM_TA_VERSION_MINOR	GENMASK(15, 0)
>> +
>> +struct tpm_qcom_ta_version_req {
>> +	u32 command_id;
>> +} __packed;
>> +
>> +struct tpm_qcom_ta_version_resp {
>> +	u32 status;
>> +	u32 command_id;
>> +	u32 version_num;
>> +} __packed;
>> +
>> +#define QCOMTEE_TPM_TYPE_ID		0x0080000
>> +#define QCOMTEE_TPM_TYPE_DTPM		0x6454504dU
>> +#define QCOMTEE_TPM_TYPE_FTPM		0x6654504dU
>> +#define QCOMTEE_TPM_TYPE_NONE		0x4e6f6e65U
> 
> This is an unused macro.

Ack.
We support only ftpm/dtpm and in case of any other value, returning
probe failure so we can drop this.

> 
>> +
>> +struct tpm_qcom_type_req {
>> +	u32 command_id;
>> +} __packed;
>> +
>> +struct tpm_qcom_type_resp {
>> +	u32 command_id;
>> +	u32 status;
>> +	u32 tpm_type;
>> +} __packed;
>> +
>> +/*
>> + * dTPM SPI transfer optimization:
>> + * TRANSFER_START before a burst of commands, TRANSFER_END once done.
>> + */
>> +#define QCOMTEE_TPM_TRANSFER_ID		0x0000002
>> +#define QCOMTEE_TPM_TRANSFER_END	0
>> +#define QCOMTEE_TPM_TRANSFER_START	1
>> +
>> +struct tpm_qcom_transfer_req {
>> +	u32 command_id;
>> +	u32 transfer_state;
>> +} __packed;
>> +
>> +struct tpm_qcom_transfer_resp {
>> +	u32 command_id;
>> +	u32 status;
>> +} __packed;
>> +
>> +struct tpm_qcom_private {
>> +	struct tpm_chip *chip;
>> +	struct device *dev;
>> +	struct tee_context *ctx;
>> +	struct tee_param_objref tpm_svc_obj;
>> +	bool is_dtpm;
>> +};
>> +
>> +/* UUID of the QTEE-bus device representing the TPM TA. */
>> +static const uuid_t tpm_qcom_uuid =
>> +	UUID_INIT(0xaabcb593, 0x7083, 0x5536,
>> +		  0xac, 0x27, 0x3d, 0x2d, 0x89, 0x41, 0x9d, 0xdb);
>> +
>> +static void tpm_qcom_release_object(struct tee_context *ctx,
>> +				    struct tee_param_objref object)
>> +{
>> +	struct tee_ioctl_object_invoke_arg inv_arg = {};
>> +
>> +	inv_arg.id = object.id;
>> +	inv_arg.op = QCOMTEE_MSG_OBJECT_OP_RELEASE;
>> +	inv_arg.num_params = 0;
>> +
>> +	tee_client_object_invoke_func(ctx, &inv_arg, NULL);
>> +}
>> +
>> +static int tpm_qcom_get_client_env_obj(struct device *dev,
>> +				       struct tee_context *ctx,
>> +				       struct tee_param_objref *client_env_obj)
>> +{
>> +	struct tee_ioctl_object_invoke_arg inv_arg = {};
>> +	struct tee_param param[2] = {};
>> +	int ret;
>> +
>> +	inv_arg.id = TEE_OBJREF_NULL;
>> +	inv_arg.op = QCOMTEE_ROOT_OP_REG_WITH_CREDENTIALS;
>> +	inv_arg.num_params = 2;
>> +
>> +	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT;
>> +	param[0].u.objref.id = TEE_OBJREF_NULL;
>> +	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT;
>> +
>> +	ret = tee_client_object_invoke_func(ctx, &inv_arg, param);
>> +	if (ret < 0 || inv_arg.ret != 0) {
>> +		dev_err(dev, "get client env obj failed: ret=%d, invoke_ret=0x%x\n",
>> +			ret, inv_arg.ret);
>> +		return -EINVAL;
>> +	}
>> +
>> +	*client_env_obj = param[1].u.objref;
>> +	return 0;
>> +}
>> +
>> +static int tpm_qcom_get_svc_obj(struct device *dev,
>> +				struct tee_context *ctx,
>> +				struct tee_param_objref client_env_obj,
>> +				struct tee_param_objref *tpm_svc_obj)
>> +{
>> +	struct tee_ioctl_object_invoke_arg inv_arg = {};
>> +	struct tee_param param[2] = {};
>> +	u32 tpm_uid = QCOMTEE_TPM_UID;
>> +	int ret;
>> +
>> +	inv_arg.id = client_env_obj.id;
>> +	inv_arg.op = QCOMTEE_OP_CLIENT_ENV_OPEN;
>> +	inv_arg.num_params = 2;
>> +
>> +	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT;
>> +	param[0].u.ubuf = (struct tee_param_ubuf){ .addr = &tpm_uid,
>> +						    .size = sizeof(tpm_uid) };
>> +	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT;
>> +
>> +	ret = tee_client_object_invoke_func(ctx, &inv_arg, param);
>> +	if (ret < 0 || inv_arg.ret != 0) {
>> +		dev_err(dev, "get TPM service obj failed: ret=%d, invoke_ret=0x%x\n",
>> +			ret, inv_arg.ret);
>> +		return -EINVAL;
>> +	}
>> +
>> +	*tpm_svc_obj = param[1].u.objref;
>> +	return 0;
>> +}
>> +
>> +static int tpm_qcom_send_command(struct tpm_qcom_private *pvt_data,
>> +				 void *req, size_t req_len, void *resp,
>> +				 size_t *resp_len)
>> +{
>> +	struct tee_ioctl_object_invoke_arg inv_arg = {};
>> +	struct tee_param param[3] = {};
>> +	u8 locality_arg = 0;
>> +	int ret;
>> +
>> +	inv_arg.id = pvt_data->tpm_svc_obj.id;
>> +	inv_arg.op = QCOMTEE_TPM_OP_SEND_COMMAND;
>> +	inv_arg.num_params = 3;
>> +
>> +	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT;
>> +	param[0].u.ubuf = (struct tee_param_ubuf){ .addr = &locality_arg,
>> +						   .size = sizeof(locality_arg) };
>> +	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT;
>> +	param[1].u.ubuf = (struct tee_param_ubuf){ .addr = req, .size = req_len };
>> +	param[2].attr = TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT;
>> +	param[2].u.ubuf = (struct tee_param_ubuf){ .addr = resp, .size = *resp_len };
>> +
>> +	ret = tee_client_object_invoke_func(pvt_data->ctx, &inv_arg, param);
>> +	if (ret < 0 || inv_arg.ret != 0) {
>> +		dev_err(pvt_data->dev,
>> +			"send_command invoke ret: %d, err: 0x%x\n",
>> +			ret, inv_arg.ret);
>> +		return ret ?: -EINVAL;
>> +	}
>> +
>> +	*resp_len = param[2].u.ubuf.size;
>> +
>> +	return 0;
>> +}
>> +
>> +static int tpm_qcom_get_ta_details(struct tpm_qcom_private *pvt_data)
>> +{
>> +	struct tpm_qcom_ta_version_req ver_req = {
>> +		.command_id = QCOMTEE_TPM_GET_TA_VERSION_ID,
>> +	};
>> +	struct tpm_qcom_ta_version_resp ver_resp;
>> +	size_t resp_len = sizeof(ver_resp);
>> +	struct tpm_qcom_type_req type_req = {
>> +		.command_id = QCOMTEE_TPM_TYPE_ID,
>> +	};
>> +	struct tpm_qcom_type_resp type_resp;
>> +	int ret;
>> +
>> +	ret = tpm_qcom_send_command(pvt_data, &ver_req, sizeof(ver_req),
>> +				    &ver_resp, &resp_len);
>> +	if (ret < 0 || resp_len < sizeof(ver_resp) || ver_resp.status != 0)
>> +		return ret ?: -EIO;
>> +
>> +	dev_info(pvt_data->dev, "TPM TA version %u.%u\n",
>> +		 FIELD_GET(QCOMTEE_TPM_TA_VERSION_MAJOR, ver_resp.version_num),
>> +		 FIELD_GET(QCOMTEE_TPM_TA_VERSION_MINOR, ver_resp.version_num));
>> +
> 
> Just to confirm, Are you sure this does not produce compile time warning. Check it.
> I belive GENMASK generate "unsigned long" and %u is not correct?

version_num is u32 and VERSION_MAJOR/MINOR is also within 32bit range so
that's why kept %u.
Warning will be triggered but output value will not be stripped as it's
within 32 bit range.
Let me fix it.
> 
>> +	resp_len = sizeof(type_resp);
>> +	ret = tpm_qcom_send_command(pvt_data, &type_req, sizeof(type_req),
>> +				    &type_resp, &resp_len);
>> +	if (ret < 0 || resp_len < sizeof(type_resp) || type_resp.status != 0)
>> +		return ret ?: -EIO;
>> +
>> +	switch (type_resp.tpm_type) {
>> +	case QCOMTEE_TPM_TYPE_FTPM:
>> +		dev_info(pvt_data->dev, "TPM type: fTPM\n");
>> +		pvt_data->is_dtpm = false;
>> +		break;
>> +	case QCOMTEE_TPM_TYPE_DTPM:
>> +		dev_info(pvt_data->dev, "TPM type: dTPM\n");
>> +		pvt_data->is_dtpm = true;
>> +		break;
>> +	default:
>> +		dev_err(pvt_data->dev, "unsupported TPM type: 0x%08x\n",
>> +			type_resp.tpm_type);
>> +		return -EIO;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/* fTPM does not implement this command and to be invoked via dtpm only. */
>> +static void tpm_qcom_transfer(struct tpm_qcom_private *pvt_data,
>> +			      u32 transfer_state)
>> +{
>> +	struct tpm_qcom_transfer_req req = {
>> +		.command_id = QCOMTEE_TPM_TRANSFER_ID,
>> +		.transfer_state = transfer_state,
>> +	};
>> +	struct tpm_qcom_transfer_resp resp;
>> +	size_t resp_len = sizeof(resp);
>> +
>> +	tpm_qcom_send_command(pvt_data, &req, sizeof(req), &resp, &resp_len);
>> +}
>> +
>> +static int tpm_qcom_cmd_ready(struct tpm_chip *chip)
>> +{
>> +	struct tpm_qcom_private *pvt_data = dev_get_drvdata(chip->dev.parent);
>> +
>> +	if (pvt_data->is_dtpm)
>> +		tpm_qcom_transfer(pvt_data, QCOMTEE_TPM_TRANSFER_START);
>> +
>> +	return 0;
>> +}
>> +
>> +static int tpm_qcom_go_idle(struct tpm_chip *chip)
>> +{
>> +	struct tpm_qcom_private *pvt_data = dev_get_drvdata(chip->dev.parent);
>> +
>> +	if (pvt_data->is_dtpm)
>> +		tpm_qcom_transfer(pvt_data, QCOMTEE_TPM_TRANSFER_END);
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * The raw TPM2 command in @buf is sent directly as send_command's UBUF-in
>> + * param and the raw TPM2 response is read back from its UBUF-out param.
>> + */
>> +static int tpm_qcom_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
>> +			 size_t cmd_len)
>> +{
>> +	struct tpm_qcom_private *pvt_data = dev_get_drvdata(chip->dev.parent);
>> +	struct tpm_header *header = (struct tpm_header *)buf;
>> +	size_t resp_len = PAGE_ALIGN(TPM_QCOM_MAX_RESPONSE_SIZE);
> 
> Why PAGE_ALIGN? Why not using TPM_QCOM_MAX_RESPONSE_SIZE directly?
> In 16K page, it increases the size to 16K, is it what you want?

Thanks for spotting!
Need 4K only. Need to drop PAGE_ALIGN from here.
> 
> 
>> +	size_t copy_len;
>> +	int ret;
>> +
>> +	if (cmd_len > TPM_QCOM_MAX_COMMAND_SIZE) {
>> +		dev_err(&chip->dev, "len=%zd exceeds TPM_QCOM_MAX_COMMAND_SIZE\n",
>> +			cmd_len);
>> +		return -EIO;
>> +	}
>> +
>> +	u8 *response __free(kfree) = kzalloc(resp_len, GFP_KERNEL);
>> +	if (!response)
>> +		return -ENOMEM;
>> +
>> +	ret = tpm_qcom_send_command(pvt_data, buf, cmd_len, response, &resp_len);
>> +	if (ret < 0) {
>> +		dev_err(&chip->dev, "TPM command failed: cmd_len=%zu, tpm_cc=0x%08x, ret:%d\n",
>> +			cmd_len, be32_to_cpu(header->ordinal), ret);
>> +		return ret;
>> +	}
>> +
>> +	copy_len = min_t(size_t, bufsiz, resp_len);
> 
> Does this min_t means the result turncation and discarding is acceptable!?
> Should not we do the min_t at the allocation time:
> 
> size_t resp_len = min_t(TPM_QCOM_MAX_RESPONSE_SIZE, bufsiz);

I checked return values from QTEE for ftpm/dtpm and seems max is 4K only
i.e response size.
TA implementation has check where resp_len < 4K is rejected with error
and tpm data output < 4K always.
So, cannot add min_t in beginning but definitely above code should be
updated. I'll dig more on best implementation and fix in next rev.

> 
> 
>> +	memcpy(buf, response, copy_len);
>> +
>> +	return copy_len;
>> +}
>> +
>> +static const struct tpm_class_ops tpm_qcom_ops = {
>> +	.flags = TPM_OPS_AUTO_STARTUP,
>> +	.send = tpm_qcom_send,
>> +	.cmd_ready = tpm_qcom_cmd_ready,
>> +	.go_idle = tpm_qcom_go_idle,
>> +};
>> +
>> +static int tpm_qcom_ctx_match(struct tee_ioctl_version_data *ver,
>> +			      const void *data)
>> +{
>> +	return (ver->impl_id == TEE_IMPL_ID_QTEE);
>> +}
>> +
>> +static int tpm_qcom_probe(struct tee_client_device *tee_dev)
>> +{
>> +	struct device *dev = &tee_dev->dev;
>> +	struct tpm_qcom_private *pvt_data;
>> +	struct tee_param_objref client_env_obj;
>> +	struct tee_param_objref tpm_svc_obj;
>> +	struct tpm_chip *chip;
>> +	int err;
>> +
>> +	pvt_data = devm_kzalloc(dev, sizeof(*pvt_data), GFP_KERNEL);
>> +	if (!pvt_data)
>> +		return -ENOMEM;
>> +
>> +	dev_set_drvdata(dev, pvt_data);
> 
> This line is duplicated!? It is also bellow.

My bad! Will drop other one.

-- 
Regards
Kuldeep

