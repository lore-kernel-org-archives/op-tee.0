Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296B2CA6018
	for <op-tee@archiver.kernel.org>; Fri,  9 Oct 2026 01:23:33 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 455D34537F
	for <op-tee@archiver.kernel.org>; Fri,  9 Oct 2026 01:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791509012;
	bh=Otc1eClTskN36WW/+Q+gSjpPOm/VJC+6FVmSxXljFXM=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=OAdT9AXYy5TfPk1gOYL63VRxKi25gOm0VwNIcxqJkysUVfhie1PcvQa5vHbQdDRru
	 wxx+hTl5ggMH9e0e/FsxQE6Z1fGBDYdzt1fJzPzn8JDIDU+Mkv4JXiN2omWML/oTps
	 rPY1KwDmmEaULZc5AUzFyeYxajTSLz2ubr/NyCRpn6IT+UpNnKv7CiP7JA8aRldVQW
	 z5+cCgqf9Ym45uU6wOt8nLRh/GGnPa31JMqts59XdNlnwq1AToQIh7/blzhtWwuI4h
	 ODd8hNlojMDmO6KK9QMu1vcZjI8vg/AFz2360kmnlwRERiK5XJkdJeqlX/5QJKQ6O6
	 3rCHEpcFV0jKA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 235B045081
	for <op-tee@lists.trustedfirmware.org>; Fri,  9 Oct 2026 01:23:25 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aPVnLAYT;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QDQcyOWt;
	dkim-atps=neutral
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6990QD5l724950
	for <op-tee@lists.trustedfirmware.org>; Fri, 9 Oct 2026 01:23:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h98iV6Q0aG7lfgYBEOhhB5ZnqHQoTZTm4bLQPavOiIo=; b=aPVnLAYTl0QnqGYi
	8x0b3Fo4zopqvPs0jw4eJPoKv+wqUGMCc1kBpwTEz2gPENIatPiCUGUO+9OMNcG9
	kFhJvbzYa08ID5lSvdX16QIEoTQnx/QLmqtVKo4SRWTJiS9QCJSGiZ+96hYp5j6C
	xCzXtY2RFOxK3JifDGz4muoR+8VcaAPbEZE7p4ALld7rHBq2wbnHEAunxMgxWs1E
	yIPxHASAbVj0+A3O0pHpmq+Hhe7ltZTGot8MWSsfBSBq2ZVHygotohKYMAqhJaij
	A3tRQQHlu/U/lu80Lg9YhcOVfB4P+A0XqIu2q9fW98fg3Se8Le3I3gZi2EHxJLYi
	9dPvwA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6ekv9mdv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 09 Oct 2026 01:23:24 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cd3e7a65fa8so187410a12.2
        for <op-tee@lists.trustedfirmware.org>; Thu, 08 Oct 2026 18:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791509003; x=1792113803; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h98iV6Q0aG7lfgYBEOhhB5ZnqHQoTZTm4bLQPavOiIo=;
        b=QDQcyOWtcve9qn6dcwpVaI6FmIvixeYUWS5fdc3q54Xey5dXCFEMvdIUSIq2IprjXS
         tspy79aeLd9DpT+JzSY772YYfn4waByR2TbInl6fVyrQvCw6sia4N6D3y4LnX0aWtfpU
         06vJqpFHbwzZwWA7dplfII3PwNaMB09DSO63+Z6GqGm/4jSWMLBqfYhuoaThY0ip+QGg
         oAP0oN7IEBxIuqVkAnfH1kEBXlZITM0I97kDqyQUcihEhTVFl6rZLsHJnnw+E+8WzgAC
         02QIWkNH8j0FImljRfzaL+2o1F/0mbcSd3psT+EwDePVJYd4dzi68Z2EcBLnk4NvN+0u
         v3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791509003; x=1792113803;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h98iV6Q0aG7lfgYBEOhhB5ZnqHQoTZTm4bLQPavOiIo=;
        b=NIklXnBsMKMJmigfXnC17q+uF9GW+KceNAnG3IeZB6rHPoGdAxNRXyIE6GjJ2OHDlG
         gRYEnpOxMOkydm/RkmFQvBVLjehfYi+1dpp2Ig7ve9Jy5IRBU45xwllF5Qbf8Q87B02J
         325SWu1nDTcyPlRG2zmIO8fgRrhnk9UPYDwi/5TrTF5mOVOlaoUs9E0LpakQI1AubuoC
         rURxjlY5RMoJHcIH3JOww3vmnPKYZ+74uo0BY4zMAu0X+tuWXk9xupapX7gSwkLp2NZT
         aQT33es+HWntYxyreKxiyYPgxl8RLSvtNneaJIA0l5NNtE71rtKOWexC8JNp9BUga8Y4
         VxNw==
X-Forwarded-Encrypted: i=1; AKwUvBxDnIk5ou1VYhizAyc3qeWYcmyXMQh6wOC7qF6AGv4lx0Pr/UbAuKIZtEAbu97Nido8drxpYTQ=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++mUSSOTxLEHfQYAAe48JBsthIjYtgyAAbZHJrf3srOB5Hn7xfkl
	DIm6/sgO8XIx+amEupjUx+xvcXjeOx2bIY3YomDF3Vt5lifgbWUNbltcuvZh7ANlWwsjWMtRtQF
	A63cUKP/QjX5yjCV5HuonORa7x1FOTd8gJcyjAjHx2ZnOZmEiy5TPcZii+hbyp1UGXTJul4k=
X-Gm-Gg: AYBFou2Ma+ofdpb9ZVfS87JS3z26/wj6fRJI0wCukJmxjEaTy1BucU23EMbaMNZ6T5Q
	EII2AU2tAFxgerEAd8uu4CyAOVhtP1X2DGUKiox0o+Y1RadmFp8lNEv1OEk1c3mM3KJHO/zQfM6
	1f0GJ0T5F85ZTtWlyaiRh080ci6LfQj/TTZKdD2TkIlwjB2JFsJMbwO+q4+Uiae8p6y1NfDVNjU
	rOIgRPPB0+2Agv9ds8m/gmGJqP3z5tT+LSuih4cV5whIkmgbaBUvynHiuvvimBss4oSx1Wkyk2F
	PnvEdGo2Eg2CuaIJ1JRFI0h6eBonAOK0bdaH01sU1U/XVvTeh/meS2kZCimpLyDx/bm7KcqetRL
	PkqM85J8AWLWaG2TIh0nwvN3mPyppgVQ8
X-Received: by 2002:a05:6a20:94c7:b0:3dd:e2e3:30fc with SMTP id adf61e73a8af0-3e16beb6c8bmr220448637.49.1791509003356;
        Thu, 08 Oct 2026 18:23:23 -0700 (PDT)
X-Received: by 2002:a05:6a20:94c7:b0:3dd:e2e3:30fc with SMTP id adf61e73a8af0-3e16beb6c8bmr220416637.49.1791509002735;
        Thu, 08 Oct 2026 18:23:22 -0700 (PDT)
Received: from [192.168.1.86] ([65.181.12.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c4a99b28sm247103b3a.59.2026.10.08.18.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 18:23:22 -0700 (PDT)
Message-ID: <4b5d8ee4-4927-4932-963c-19eb76a8f67d@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 12:23:14 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] tee: Export uuidv5 generation for TEE backends
To: Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20261006-qcom_uefisecapp_migrate_qcomtee-v4-0-bf1c8e2a64ab@oss.qualcomm.com>
 <20261006-qcom_uefisecapp_migrate_qcomtee-v4-4-bf1c8e2a64ab@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261006-qcom_uefisecapp_migrate_qcomtee-v4-4-bf1c8e2a64ab@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: SXAC_k7zefpIO06jv-UqhSaZhClPF_u9
X-Authority-Analysis: v=2.4 cv=csYOAF4i c=1 sm=1 tr=0 ts=6ac8420c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=9v5PfQ1E2GNzj2RibJmqVw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=_rK1-4A1YL53NBNV8coA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAwNSBTYWx0ZWRfXzAkU+Gb6uMuO
 Lqxwd1kj1gWLFnJ9JCQT/54ax2G9O4OlbyvkEhPdCdeKlwb7iqghnByaRBoY/3uU7yp9JKRtX5e
 bzzij3Z4MAV1zC5x7zK9dOKCl6H2vX8qs5whldxW4Ti4wuObk1g4odIHeRegTgz0rICW26uzKkr
 ntA4KhJYd2OE25ejGTEVzc6Z02P749E/4nhupjsauqBY2+/qJ98k4IJgyazjO5aAOxFAAUTu+Q7
 bhQAztQMJEZoSlHfN9vE8l4AsXBh0MTbo1yqeRVDaZy5FDLXXGp6BuCylpcTw2OGwGboCbFLOcs
 c/1cPz0kKmDNkYoCjExbQryAFO398JN6ewT5s2XKBIXzAXWt0QWLHt2POWyI/p0PQ4heCAsC5nh
 d1l5x2gWSdNK4ODiFAwTInrPxRJCkCCtX/pOUyv0jIVpNR43ql9nm+pbiUK8TpMMQU28WW9ejcU
 /7yl9hUZ38/W1X1ylkw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAwNSBTYWx0ZWRfXxDUz/eFyGMnv
 IzL1JXCngwlMO5wIY3FRNidL6cSeovrNeIXwpqTRh3dlkyw5sFXJKHAfx3uqlN39YcrmR1+dcxE
 Xl1JUqwkgIJ4HUL3txv0+GLC0Y8aVgE=
X-Proofpoint-GUID: SXAC_k7zefpIO06jv-UqhSaZhClPF_u9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_01,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090005
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.199:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 235B045081
X-Spamd-Bar: ------
Message-ID-Hash: JFPVVAOVVURUH7ILK3BSSRPPSELGBTLD
X-Message-ID-Hash: JFPVVAOVVURUH7ILK3BSSRPPSELGBTLD
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/JFPVVAOVVURUH7ILK3BSSRPPSELGBTLD/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>



On 10/6/2026 10:33 PM, Harshal Dev wrote:
> Export the uuidv5() function defined in the TEE core to all TEE backends.
> This enables the TEE backend drivers to generate a UUID for identifying
> and registering their secure services on the TEE bus.
> 
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> ---
>  drivers/tee/tee_core.c   |  9 +++++----
>  include/linux/tee_core.h | 15 +++++++++++++++
>  2 files changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index a03a3d645dd1..2cfd302d1393 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -135,7 +135,7 @@ static int tee_release(struct inode *inode, struct file *filp)
>  }
>  
>  /**
> - * uuid_v5() - Calculate UUIDv5
> + * tee_generate_uuid_v5() - Calculate UUIDv5
>   * @uuid: Resulting UUID
>   * @ns: Name space ID for UUIDv5 function
>   * @name: Name for UUIDv5 function
> @@ -146,8 +146,8 @@ static int tee_release(struct inode *inode, struct file *filp)
>   * This implements section (for SHA-1):
>   * 4.3.  Algorithm for Creating a Name-Based UUID
>   */
> -static void uuid_v5(uuid_t *uuid, const uuid_t *ns, const void *name,
> -		    size_t size)
> +void tee_generate_uuid_v5(uuid_t *uuid, const uuid_t *ns, const void *name,
> +			  size_t size)
>  {
>  	unsigned char hash[SHA1_DIGEST_SIZE];
>  	struct sha1_ctx ctx;
> @@ -163,6 +163,7 @@ static void uuid_v5(uuid_t *uuid, const uuid_t *ns, const void *name,
>  	uuid->b[6] = (hash[6] & 0x0F) | 0x50;
>  	uuid->b[8] = (hash[8] & 0x3F) | 0x80;
>  }
> +EXPORT_SYMBOL_GPL(tee_generate_uuid_v5);
>  
>  int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
>  				 const u8 connection_data[TEE_IOCTL_UUID_LEN])
> @@ -228,7 +229,7 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
>  		goto out_free_name;
>  	}
>  
> -	uuid_v5(uuid, &tee_client_uuid_ns, name, name_len);
> +	tee_generate_uuid_v5(uuid, &tee_client_uuid_ns, name, name_len);
>  out_free_name:
>  	kfree(name);
>  
> diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
> index bcb5418d6fdc..a3f4f88b8423 100644
> --- a/include/linux/tee_core.h
> +++ b/include/linux/tee_core.h
> @@ -272,6 +272,21 @@ void tee_device_set_dev_groups(struct tee_device *teedev,
>  int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
>  				 const u8 connection_data[TEE_IOCTL_UUID_LEN]);
>  
> +/**
> + * tee_generate_uuid_v5() - Calculate UUIDv5
> + * @uuid: Resulting UUID
> + * @ns: Name space ID for UUIDv5 function
> + * @name: Name for UUIDv5 function
> + * @size: Size of name
> + *
> + * UUIDv5 is specific in RFC 4122.
> + *
> + * This implements section (for SHA-1):
> + * 4.3.  Algorithm for Creating a Name-Based UUID
> + */

I think the functions in the header do not need to replicate the docs from c files.
If you want you can remove it. Otherwise,

Reviewed-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

- Amir

> +void tee_generate_uuid_v5(uuid_t *uuid, const uuid_t *ns, const void *name,
> +			  size_t size);
> +
>  /**
>   * struct tee_shm_pool - shared memory pool
>   * @ops:		operations
> 

