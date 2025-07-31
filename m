Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A73AC87FCC
	for <op-tee@archiver.kernel.org>; Thu, 31 Jul 2025 10:28:06 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 51A174309B
	for <op-tee@archiver.kernel.org>; Thu, 31 Jul 2025 10:28:05 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hwEG31Qz;
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 400DF42DDD
	for <op-tee@lists.trustedfirmware.org>; Thu, 31 Jul 2025 10:27:43 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56V9fIcT005256
	for <op-tee@lists.trustedfirmware.org>; Thu, 31 Jul 2025 10:27:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	86uBZjOz3XTDZ9vXiSQ6KI9NLQ8uWn/Exc3xzSd61AY=; b=hwEG31Qzx7jPvr4D
	4fA9Wu/Ryr0VJbCvNWX7RtlGOhtkEZU+YPvYRC+cp9swBWQfJnd1pzX+8oc0zEQm
	TmoV3EFwj2FejNWWrq1ADQlsL/NCKcxLLlw9JeB1HaMCHGrParmGsLUJzLGC8evH
	ghBnVdOMDl3k9FO5QYNjkifAvjJF4iAdo7bqU65JM9m/u+R5pNWTIVmgh1KGDNVM
	xaWvCkoOpeXx0aaZJx6hFG5HZLT86exnPAmxkcrzErPwQOG3FHy6Kmnf/Xot/oTF
	a8erm3/WcWu9NEVv2FDiwtuQaubiAnuWo670FWzwUl3jCMc+1AQ8yH2EhlcsrQ8X
	hM1AVg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4860ep4qfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 31 Jul 2025 10:27:42 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56VARfYg015710
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 31 Jul 2025 10:27:41 GMT
Received: from [10.217.222.172] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 31 Jul
 2025 03:27:40 -0700
Message-ID: <a2c6ac88-99b7-4a2b-9c9a-208396df158c@quicinc.com>
Date: Thu, 31 Jul 2025 15:57:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 3/6] remoteproc: Introduce optional release_fw
 operation
To: <op-tee@lists.trustedfirmware.org>
References: <20250625094028.758016-1-arnaud.pouliquen@foss.st.com>
 <20250625094028.758016-4-arnaud.pouliquen@foss.st.com>
Content-Language: en-US
From: Harshal Dev <quic_hdev@quicinc.com>
In-Reply-To: <20250625094028.758016-4-arnaud.pouliquen@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IQ0SI72ZvK__ZTdVRP6ypgdSe-zH1Sxf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDA3MSBTYWx0ZWRfX2A4yMztdJeEd
 o6d46Ph7ipbwS8uD12Btaq9HsFkDPc4SSrXCU0c5dqm3zXFijNVUq4D40W+owjRlE4eBF9eX3wI
 Pc+I+5SP6BPj9qf2NNghHmk8bC2rLW0v4cT3PthqcNvp5VRKJWveJxZJn+iZAX8r77CJDSpBD4E
 0xrSZ0LrBF0InAcNgEyQErzy7kOoGgDNn05yz1MU7olA3UGkYE9SoVH9IhjhAzCkvfrA1duj6r6
 L5mdgBSit27tbrjp3XRMR8LXIXDlkna3F3kpsJrTZ5u6B0rlfpTzTQmbO+0JKBb377rYiCAuSCM
 eEbilGJhGqad3Q6ud8wnyUahpVDgNxHngj1wHSXmqxpoAAxFhBhygO8HG7DLOaoXQnNawPJ9Wxe
 YZPzmqBL0H+7GcsgYzVLKEL4zEM2AJbDfJtQGtSNlby3af6nwrb4dmJOYR2oPu5GqXfBVLND
X-Authority-Analysis: v=2.4 cv=DIWP4zNb c=1 sm=1 tr=0 ts=688b451e cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=8b9GpE9nAAAA:8
 a=Lp_IPU8fAio0KzJ0578A:9 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-ORIG-GUID: IQ0SI72ZvK__ZTdVRP6ypgdSe-zH1Sxf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_01,2025-07-31_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507310071
X-Rspamd-Queue-Id: 400DF42DDD
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.80 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[quicinc.com,none];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[quicinc.com:s=qcppdkim1];
	RCVD_IN_DNSWL_MED(-0.20)[199.106.103.254:received];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[quicinc.com:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	HAS_XOIP(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[quicinc.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: QIDACNYZCVGB2OFI4TTM5V6A65IPNZAA
X-Message-ID-Hash: QIDACNYZCVGB2OFI4TTM5V6A65IPNZAA
X-MailFrom: quic_hdev@quicinc.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/QIDACNYZCVGB2OFI4TTM5V6A65IPNZAA/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Arnaud,

On 6/25/2025 3:10 PM, Arnaud Pouliquen wrote:
> The release_fw operation allows releasing remote processor resources
> configured during rproc_parse_fw() and rproc_load_segments().
> For example, it can release carveouts mapped during these operations.
> 
> This operation is invoked in the following cases:
>  - When an error occurs during remote processor boot.
>  - When an error occurs during remote processor recovery start.
>  - After stopping the remote processor.
> 
> This operation is required for the remoteproc_tee implementation following
> a stop or upon encountering an error. Since the remoteproc image is loaded
> during resource table parsing, multiple failure scenarios may occur prior
> to remote processor startup, including issues with resource handling and
> carveout allocation.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> 
> ---
> 
> Updates from version 18:
> - Rewrite rproc_ops::release_fw documentation
> - Improve commit message
> 
> Updates from version 16:
> - Removed the rproc:load_fw() ops introduced in previous version.
> - Removed duplicate calls to rproc_release_fw in rproc_fw_boot and rproc_boot.
> ---
>  drivers/remoteproc/remoteproc_core.c     | 6 ++++++
>  drivers/remoteproc/remoteproc_internal.h | 6 ++++++
>  include/linux/remoteproc.h               | 5 +++++
>  3 files changed, 17 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index d06eef1fa424..4c1a4bc9e7b7 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1857,6 +1857,8 @@ static int rproc_boot_recovery(struct rproc *rproc)
>  
>  	/* boot the remote processor up again */
>  	ret = rproc_start(rproc, firmware_p);
> +	if (ret)
> +		rproc_release_fw(rproc);
>  
>  	release_firmware(firmware_p);
>  
> @@ -1998,6 +2000,8 @@ int rproc_boot(struct rproc *rproc)
>  		}
>  
>  		ret = rproc_fw_boot(rproc, firmware_p);
> +		if (ret)
> +			rproc_release_fw(rproc);
>  
>  		release_firmware(firmware_p);
>  	}
> @@ -2067,6 +2071,8 @@ int rproc_shutdown(struct rproc *rproc)
>  
>  	rproc_disable_iommu(rproc);
>  
> +	rproc_release_fw(rproc);
> +
>  	/* Free the copy of the resource table */
>  	kfree(rproc->cached_table);
>  	rproc->cached_table = NULL;
> diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> index 0cd09e67ac14..c7fb908f8652 100644
> --- a/drivers/remoteproc/remoteproc_internal.h
> +++ b/drivers/remoteproc/remoteproc_internal.h
> @@ -221,4 +221,10 @@ bool rproc_u64_fit_in_size_t(u64 val)
>  	return (val <= (size_t) -1);
>  }
>  
> +static inline void rproc_release_fw(struct rproc *rproc)
> +{
> +	if (rproc->ops->release_fw)
> +		rproc->ops->release_fw(rproc);
> +}
> +
>  #endif /* REMOTEPROC_INTERNAL_H */
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 8fd0d7f63c8e..a2bb51a113b1 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -381,6 +381,10 @@ enum rsc_handling_status {
>   * @panic:	optional callback to react to system panic, core will delay
>   *		panic at least the returned number of milliseconds
>   * @coredump:	  collect firmware dump after the subsystem is shutdown
> + * @release_fw:	Optional function to release resources allocated during
> + *		parse_fw() or load() operations. This function is called after
> + *		stopping the remote processor or in case of an error during the
> + *		boot or recovery sequence.

Please check the white-space indentation here. :)

Thanks,
Harshal
>   */
>  struct rproc_ops {
>  	int (*prepare)(struct rproc *rproc);
> @@ -403,6 +407,7 @@ struct rproc_ops {
>  	u64 (*get_boot_addr)(struct rproc *rproc, const struct firmware *fw);
>  	unsigned long (*panic)(struct rproc *rproc);
>  	void (*coredump)(struct rproc *rproc);
> +	void (*release_fw)(struct rproc *rproc);
>  };
>  
>  /**

