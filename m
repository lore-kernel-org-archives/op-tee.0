Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C487CCF64B1
	for <op-tee@archiver.kernel.org>; Sat, 22 Nov 2025 07:36:30 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E1F7150049
	for <op-tee@archiver.kernel.org>; Sat, 22 Nov 2025 07:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1763796990;
	bh=NjfENa1FrLwX1H8CRzUQmrrEDFdgdcTHfjYAF52TBv8=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=5QDMBU4tuoic977Myjq+lb5gWpBieBcBbji/mPZa3oKWf1Z1gPPlugMtvNKSNZpbq
	 nuv2MByOsxJWFRZtwrLgk9touTiv5wVJHZSRiAKjMXy3Iifvx6F9SJcwb5GSnPMXbK
	 eC35bDgicMDy2MNWca4Ctb91zPRWWvlopKbSHKBtqlgBesMJdLeLnBbVoLiGOyoO0D
	 UOhj+qs6W+xLSeFpCbAZImk6T/var1CSSczYuTDSLPouiTwXnfvKKnmEMAtbdu7qpu
	 iEenpDcrBXxifLNwLVF2QaxvhMH9agceS8ygkCiyNBnr5PCDeRRVrEsYcyg1PzHFP4
	 iZkIevYX+4mRA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5CCB643209
	for <op-tee@lists.trustedfirmware.org>; Sat, 22 Nov 2025 07:36:19 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FayXtBby;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jziBvi9B;
	dkim-atps=neutral
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AM5HSxM2063938
	for <op-tee@lists.trustedfirmware.org>; Sat, 22 Nov 2025 07:36:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jqPmH2E5g3Oum7EG9ICeoiYXWxo+ajqE4bwyyao38Nk=; b=FayXtBbykfRtPwiq
	586K2zD9KouB6vQy2cWHOHH+w/MylqYV5rju3wn2JDo8DAO4gWyFIm2YwCjbfU96
	4zE1/w8BD6FiiSiZ5u/3ZS4i6fwfsOp907J23xPPgL8TyVn12KvS9HAUu7EjlTVu
	0JKbTgKVhPrZwfjbXh64othHNogYlY9i3jt31D9y5iS4yk2PVXHIGQzEnTD5nD8w
	WyUMVoj9a4BK4feDaLjph+r5i1M40rz+ln/mdS0wM5p6ELXJI7elSlROHUGDJjNM
	8qLF9oNYlNoDHLfCT1o0astSX4XjkkbKFeDI8wR0xuKYwilvL51w+g51oOpsRcqk
	XlIkpA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ak69sg8ck-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Sat, 22 Nov 2025 07:36:18 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7b895b520a2so2911321b3a.0
        for <op-tee@lists.trustedfirmware.org>; Fri, 21 Nov 2025 23:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763796978; x=1764401778; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jqPmH2E5g3Oum7EG9ICeoiYXWxo+ajqE4bwyyao38Nk=;
        b=jziBvi9BfLzTQjcMBFbkXPXwKJIAhtxIRZLmitk2+/+JPhZJUSusqqObCc8FRTZE+s
         JkZBVN777Q74amRitBrVCmVwE9O1ibbd6JxGLrLtW7t11Ty7y2+G0FYxPKPoQaX9w6nb
         ykx48I7X5xBKxV1mj2dcypXD9BxqUWpDZT11Ihzkt3AHlfdbnBUEWCf8MpLokPJPlWIw
         gS8CqCX50Txx3s69IH9p6xAW0CuofBRH4dqGV9gn1Wmip4fpabPAzKHG/yk6E4Wr2DOK
         FwN881WHI1kvA5X4whkuIKkeh9lzOgrj3W9ovjnvVC0I16to+cFNtzFdkMOaEUJfqC3b
         5/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763796978; x=1764401778;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jqPmH2E5g3Oum7EG9ICeoiYXWxo+ajqE4bwyyao38Nk=;
        b=Ny9R2khEA9ufUKOOrz6zygLfEZKWgtwD5cUjdxibKss16m4ZNM/O3Uyr/xQDEiHHCQ
         3eiciLZMb+9JmPAiqMs5j05QOq6/BaakBayyznbaAVfpizU5dcNoy8Pc/YbsVv+XeKRD
         OEDb4xkTPYMOk1nfYgK2g/TuaSGjplq8L+H3RAdCHwAgUY18cLxF+4tTpVV/SZkzxqBs
         ZOTcs/1YKKVlJPgJBDxdGtyMOKC8zXpB63Ephp+gT59jhiWTwtjPYoz20bvoG7H2a1ql
         uBR10tr80wxBsglu1rmjDIy+6/Wfr+oUfve8Zb+HeuKKeIpocw0Dp7Md1GZUAZYYX5PW
         8Qiw==
X-Forwarded-Encrypted: i=1; AJvYcCUFQF773708S27S+9/WfI2UQLGV/dfKzp0H256MtYQYEqIDlAQPdLvHFf19LX35ZW7FohJP5pw=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YytRp7SnKMDqTpSOrJ35PV1nfDYe1oxAtoItxM5WrjETxqYB9E5
	s6RG6DDH7Ew1Cey2cQTxK2zP+76oRSSb52I0ODrqiEyWgDS0lx6FKFWb99MiyOyBArp9Wl2vifj
	vr6vOd5xqcGufPJ7Fw81dlv/vdd55MRB/q5Erezu4JL6veVtypQf/QY3uSDyT8vlMAl+GBwiX
X-Gm-Gg: ASbGnct3jMWqbWViwABsyf34ajvqQ8h20Emyp+39ue5w2k1v4qi+DN6xSfiWKSidFLz
	2PJtbgtFdI3qPtlok91YjYlKMfMosLpOyekBHJJZ9f7F+uaQMvwEg5lNHiM5n3FVcrNMhKX0cbN
	Y9eKs7/EP7iyS5WGgefkKfGmL/2+sVATCEvoknj8V8cyz29S1FHI62zbtlB23Pvb/ZePc2BLBO8
	049favtcABz+1FDl6snPHkZsgetGBNiX1QIB8kX1QhiURo+Ye4mrOKH07GpWTAaEOr9injFjVGq
	7SJzOa8SoosfafQzK7PQ//KdxhBVCNXcQVyB39A49O/W3rg2mtfO63b9mfB4s7DcCLgWOjYvw2n
	qjUcT4LMwqz/dEHGlJJET41iuX6XynrwYnEMwD00A
X-Received: by 2002:a05:6a00:a1d:b0:7ab:54ce:998d with SMTP id d2e1a72fcca58-7c58e606253mr4443319b3a.23.1763796977655;
        Fri, 21 Nov 2025 23:36:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBgKlpNhEjrKy6K6cML1N0QHg4O9Eyf247uGwqJTfejZyGR5nMoC2Pf0IZHb5GEViLuOaNEw==
X-Received: by 2002:a05:6a00:a1d:b0:7ab:54ce:998d with SMTP id d2e1a72fcca58-7c58e606253mr4443305b3a.23.1763796977198;
        Fri, 21 Nov 2025 23:36:17 -0800 (PST)
Received: from [192.168.29.116] ([49.37.148.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f0d65682sm8257206b3a.56.2025.11.21.23.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 23:36:16 -0800 (PST)
Message-ID: <d4b86b19-0274-45e6-89e3-0ad927fe5cdd@oss.qualcomm.com>
Date: Sat, 22 Nov 2025 13:06:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] tee: optee: expose OS revision via sysfs
To: Wei Ming Chen <jj251510319013@gmail.com>, linux-kernel@vger.kernel.org
References: <20251121141230.489294-1-jj251510319013@gmail.com>
Content-Language: en-US
In-Reply-To: <20251121141230.489294-1-jj251510319013@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=PNMCOPqC c=1 sm=1 tr=0 ts=692167f2 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=v+kbWGyw1T97G6+vs1uYIQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=DfNHnWVPAAAA:8 a=iFz-G_-NId9Z4KFAPR0A:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=rjTVMONInIDnV1a_A2c_:22
X-Proofpoint-ORIG-GUID: n3TbfRre-UgCGLeTug4sgWLB5yf08goR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDA1OSBTYWx0ZWRfX1GgOBu16BAA1
 LiDjUEo9jU6EnuEsHdiR3aGyOHwBDGNhWho6QF1xVqJ3Ul9pxB0zSwQfeRoclMQ1b4wipP7hzvf
 6LhLCdGN6cHYCVTxuBueI4nBOqKvSualRnPycN9hOxNXW2IQYiigMu8wi0GoFv+P1Cx2XNn2ECe
 TCtX9xXZyUfbfaG45DkUsys8dl5wKmRMr5wuW69nA7aYq6UEyrF19KZMtP0D0YyRCD9e88lGY/u
 yaIY/U13n5oubW9wQCMQ6C33TcRPQtaHFqi37EaQmwk61lrGX0ASTrhXi33PwfvWxyPPn/oHspR
 HXWXAxvZFAwBsS+wYKaKtsSzrLE16Qj2gsFDFPpM4a2QzBEqFFcCpM4WvmXgcjhfsXumyzPzrKT
 HB84Mq3VrCVmIncz98RtdRd/ewJgTA==
X-Proofpoint-GUID: n3TbfRre-UgCGLeTug4sgWLB5yf08goR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-22_02,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 clxscore=1011 phishscore=0 suspectscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511220059
X-Spamd-Bar: ------
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5CCB643209
X-Spamd-Result: default: False [-6.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.210.197:received,205.220.180.131:from];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
Message-ID-Hash: ZDXFXORRUO6RLEEJCROO2JK4L2GFRDBG
X-Message-ID-Hash: ZDXFXORRUO6RLEEJCROO2JK4L2GFRDBG
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: sumit.garg@kernel.org, op-tee@lists.trustedfirmware.org, Aristo Chen <aristo.chen@canonical.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ZDXFXORRUO6RLEEJCROO2JK4L2GFRDBG/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

Hi Aristo,

On 11/21/2025 7:42 PM, Wei Ming Chen wrote:
> From: Aristo Chen <aristo.chen@canonical.com>
> 
> Today the only way to read the OP-TEE OS version is from dmesg/journal
> logs, which can be lost as buffers roll over. Add a minimal
> optee_version_info (major/minor/build) and get_optee_revision hook,
> collect the OS revision in both SMC and FF-A ABIs, and publish
> /sys/class/tee/tee*/optee_os_revision for a stable userspace readout.
> 
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> ---
>  drivers/tee/optee/ffa_abi.c       | 27 +++++++++++-
>  drivers/tee/optee/optee_private.h |  1 +
>  drivers/tee/optee/smc_abi.c       | 27 +++++++++++-
>  drivers/tee/tee_core.c            | 73 ++++++++++++++++++++++++++++++-
>  include/linux/tee_core.h          |  2 +
>  include/linux/tee_drv.h           | 12 +++++
>  6 files changed, 137 insertions(+), 5 deletions(-)

[..]

> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index d65d47cc154e..dc23058e7be6 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -1141,12 +1141,83 @@ static ssize_t implementation_id_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(implementation_id);
>  
> +static int tee_get_optee_revision(struct tee_device *teedev,
> +				  struct optee_version_info *ver_info)
> +{
> +	if (!teedev->desc->ops->get_optee_revision)
> +		return -ENODEV;
> +
> +	return teedev->desc->ops->get_optee_revision(teedev, ver_info);
> +}
> +

I don't think implementing functions with a TEE back-end driver specific name and implementation
is a good idea in TEE core.

> +static bool tee_is_optee(struct tee_device *teedev)
> +{
> +	struct tee_ioctl_version_data vers;
> +
> +	teedev->desc->ops->get_version(teedev, &vers);
> +
> +	return vers.impl_id == TEE_IMPL_ID_OPTEE;
> +}
> +
> +static ssize_t optee_os_revision_show(struct device *dev,
> +				      struct device_attribute *attr, char *buf)
> +{
> +	struct tee_device *teedev = container_of(dev, struct tee_device, dev);
> +	struct optee_version_info ver_info;
> +	int ret;
> +
> +	if (!tee_is_optee(teedev))
> +		return -ENODEV;
> +
> +	ret = tee_get_optee_revision(teedev, &ver_info);
> +	if (ret)
> +		return ret;
> +
> +	if (ver_info.os_build_id)
> +		return sysfs_emit(buf, "%u.%u (%08x)\n", ver_info.os_major,
> +				  ver_info.os_minor, ver_info.os_build_id);
> +
> +	return sysfs_emit(buf, "%u.%u\n", ver_info.os_major,
> +			  ver_info.os_minor);
> +}

[..]

> diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
> index 1f3e5dad6d0d..4bd9b6b191c9 100644
> --- a/include/linux/tee_core.h
> +++ b/include/linux/tee_core.h
> @@ -98,6 +98,8 @@ struct tee_device {
>  struct tee_driver_ops {
>  	void (*get_version)(struct tee_device *teedev,
>  			    struct tee_ioctl_version_data *vers);
> +	int (*get_optee_revision)(struct tee_device *teedev,
> +				  struct optee_version_info *vers);

I think it would be better if this patchset could be made OPTEE agnostic. After-all,
the callbacks defined in tee_driver_ops are supposed to be implemented by each TEE
back-end driver as per their implementation.

>  	int (*open)(struct tee_context *ctx);
>  	void (*close_context)(struct tee_context *ctx);
>  	void (*release)(struct tee_context *ctx);
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index 88a6f9697c89..64a2fea11cb9 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -20,6 +20,18 @@
>  
>  struct tee_device;
>  
> +/**
> + * struct optee_version_info - OP-TEE version information
> + * @os_major:		OS major version
> + * @os_minor:		OS minor version
> + * @os_build_id:	OS build identifier (0 if unspecified)
> + */
> +struct optee_version_info {
> +	u32 os_major;
> +	u32 os_minor;
> +	u32 os_build_id;
> +};
> +

It is not entirely clear from the structure what kind of version information for
OPTEE is being provided. I see from the implementation that when FFA is enabled,
this provides FFA version implemented by OPTEE but when FFA is not used, it provides
OPTEE OS version. This can be confusing for a user trying to report an OPTEE 'version'.

>  /**
>   * struct tee_context - driver specific context on file pointer data
>   * @teedev:	pointer to this drivers struct tee_device

Thanks
Harshal
