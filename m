Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F6CCCF2D3
	for <op-tee@archiver.kernel.org>; Mon, 19 Oct 2026 06:18:19 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 59A2F44FD6
	for <op-tee@archiver.kernel.org>; Mon, 19 Oct 2026 06:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1792390698;
	bh=hT3kconPAO71ZAgCnNBq9KkOENtVYYhR4KqdJA6cfk0=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=ecrWEOWY5O26ivmczKOH++KsNM77Mp8MX7cKrxiZJuwF1eUTtTI3kZyJn86S68SoV
	 VFIOrowQWnMRr9qdCsM9my3uD3j3nWQQ83J07NYdu2s7CfgS7TYnkW7Rqum2SpwMb2
	 cXrcMwGIPEpiBvC9HzfY6c1XhS58CEWS8OeO5WBES99bpdgbqY0SMxTbY3+yZQ0yfI
	 bJMMe7cYYeY9p8CzCFtgT0f5NctRmX2mlf3mjM8JBc3P7cxsugF09vIk0qVkJhB/HV
	 PMZIVFI/8xgsBcOdFOWVSjr7BWwjZlQvZR69arAb6AGH2VKi8UwyuuBwiqDZcxpkSf
	 SmvxCWoqMrtWw==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 59A1B44A8C
	for <op-tee@lists.trustedfirmware.org>; Mon, 19 Oct 2026 06:18:00 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CiLn2vQu;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HHbpbIlo;
	dkim-atps=neutral
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J4j7h1239122
	for <op-tee@lists.trustedfirmware.org>; Mon, 19 Oct 2026 06:17:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	06159emas6EFWdKcDMqYp+aj70RJ3dHGp+7F881lMJ0=; b=CiLn2vQuMcLzGow0
	xpNe9dDGBIItBH+h7uzFCA1iQKtfahmc3/In2zjq7GhKXTRfzEGSauz/Z78BPQVk
	xskwMPfTcmOIblFHnjMnvWyIXs4fVo1tGPrHgQy6mX1fkZO38GJS5qVfMlbYMn/U
	p9I9sajflr3RWPxJfCsDcHfaQyog/f6a0lDFe3Gd95fs187trY/sT9dcnBCr5+lk
	5ln43iHtYpBeeFK6MZN3Yjfcb/ScRur4d+wLpbYnUbkuy8WP7JQnevsLtwy/TQJx
	CoHe2N3MnrV+dD+NmWmuyefVEjlHo96h5KqzW5n3Bx4FUJb9sETFXdFJidjRY6Ws
	rgzYJg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc26k51a0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 19 Oct 2026 06:17:59 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-35d4538fd74so6548850eec.1
        for <op-tee@lists.trustedfirmware.org>; Sun, 18 Oct 2026 23:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792390678; x=1792995478; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=06159emas6EFWdKcDMqYp+aj70RJ3dHGp+7F881lMJ0=;
        b=HHbpbIlo9y5Oj08qZeD1rHXIBdHbSPNrPIv5Dg4OmqCyBocf0LfjcB6AYIoI21yyYZ
         0VRbB1WIvR57Zfzd8DTz57Rd49PKiMEbtMI2oEvbz35jh++JqlHEIrlOn1STFFy9L8YK
         AuBj5KAC5lNruKgeOIKY5eTuJygvFgxqU+5BrsPqiyS9kmiazbTsp5iFKXf9EZJv9qyw
         z54ldDBpDzTDtdDl3I24NKOHalmu8uT5NvL278pjeFzx00pWhKjKz34VPfUzeYRtVHRo
         kIU2nNGsFX0vblIUj65ryEKrDnzWQvLIsb2U49ao8L9gS0kXahLftMfIwblhCHOf9RDp
         mclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792390678; x=1792995478;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=06159emas6EFWdKcDMqYp+aj70RJ3dHGp+7F881lMJ0=;
        b=Xi1PqupnsZK2vcHyDp3bIXtIVshhWZiAsusIF/zh5Vv/SIOGtiZKyOfY0FORbZqSeE
         6TeQoAFSH7IjNVPtNvgILkYVSNz6SUmkcTLEuN9Qt/aOzKy6lOFV2r+oIh+PwPAwuRzS
         rYA7bMA/KHoGPyiY3gJvS42nmD6hWloVPanHAsZJ3aFRNUKyBSWfsZLNlV2q56fMMhdK
         TJiwjIJnn4Oh/YOJykMg8I0sytC0UUdUOig9sgIYMAaGiUZhZ6Do78lxBSQhi5GQ1IK0
         FtbYT/xdt59p17H+JAhK+fOnq7OlPqqx9dW+SV8olmPqGGp0w2IpyMV5pXGl9Q1kYxx7
         fyNA==
X-Forwarded-Encrypted: i=1; AKwUvBymDEqA5o3zvWQoCn0hMBpr8AylYowJC+ULk/HjhAZX/BD3P0GEu0n2zDGlkoPmIz6LQWy5P7E=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYLZP/8cTg1M11oPrkzDw2nSaTI7AxwJn9jJcfYiPe1z1PyaIr1i
	xCjyoRq89wXoFqothQNU286XGUTsJf1RVP3fqoHRgVmKglGZaUVZZiq0Xcx2hl3FU+OGU7PCWRi
	QHUZBK1jIJE3944UJT1T2UOK2o/G5hZzVQCfD7N0KkhwC/68fiHDshp+82LFOzcXIW+llrW6g
X-Gm-Gg: AYBFou1UvQgImJXmqeF6oLAUuSCi43VR4SdyACnKaeeay0hNeYeZFRAjtbqn2BJKmz7
	CB2ME5qpNKfVjktt78yO2FiHTiR6dev1hKSUl8dVE3gelBIMOU/E3bDMQdeZh5J5IPrcHk7wbi9
	2F6Nl14zh1m42/OC9k7ueF64f4LA25iCALwWUklhqYwNJBe7dRrv6Z8VXJx6c+IGJhgjeHLauVU
	ODJqU20QPVoazZu4z3X/tj2V7+nU0hGvOeN0KnaySAZ0CBFzlPJZjjKAASLWUWhmB3jXI3T/Pk1
	JFDncS1xx41U5n/GmPCEQUPGQqjPiw3T7Gjh8SN2hIwQnpbq4SwAt7JJiXXvXm+RolM8MVikpMG
	y+Lsz61E/6AKXEedyMPV8N5WkmlE5xw==
X-Received: by 2002:a05:7300:ea8e:b0:35c:8abb:b4ae with SMTP id 5a478bee46e88-361a1f505eamr9695572eec.25.1792390678214;
        Sun, 18 Oct 2026 23:17:58 -0700 (PDT)
X-Received: by 2002:a05:7300:ea8e:b0:35c:8abb:b4ae with SMTP id 5a478bee46e88-361a1f505eamr9695458eec.25.1792390676169;
        Sun, 18 Oct 2026 23:17:56 -0700 (PDT)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607ee0cc23sm34095658eec.2.2026.10.18.23.17.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2026 23:17:55 -0700 (PDT)
Message-ID: <fca1f5e8-2b11-4912-98b0-42ea2e9a3d1b@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 11:47:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] tpm: Introduce Qualcomm TPM driver
To: Jarkko Sakkinen <jarkko@kernel.org>
References: <20261015-tpm_qcom_driver-v3-0-247c8e50250e@qti.qualcomm.com>
 <20261015-tpm_qcom_driver-v3-2-247c8e50250e@qti.qualcomm.com>
 <atKpjLYdUuugwAUQ@kernel.org>
Content-Language: en-US
In-Reply-To: <atKpjLYdUuugwAUQ@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAyNCBTYWx0ZWRfX6QrYMz8AEouy
 /G69/mORg0EztvfSBWSj/IisRfC07gCK+mFf+wG3EGcSm6Yciegl6xA4bYJJTwWtVEQuRJV+nSU
 VkqsFo84tRB2WZ4Rf8wkZhAHGvkjFWcB7LE0s1jWuge9N7fFCsZ7XGhSEZErGaxIWBE/8AHVfQ8
 PcsJ4SbzWRcR+wYJPCQt4byCgPByjE2pCcoblpBMnnzTNwoG2g52efN86AeJjVJq2ghD2W58AEF
 u5+qNp9SUkyH+vcFPVRYCUf+NE5xkE0EmikLQPhRrOtnRWRUOYr3DOm8ICXAphkOKGV/CkvVCcM
 BT8Xb7UigSbSE/YYz+OKFAvcWS1QyrOM+dwHminT9RNGRZ1ukP8iF6zpDvbHiJnp8pGjO4mg23i
 P4mzRde3Ci1hjXJTe7UEvri8JCU1e5pTr260JyTFYjmXkUO0jQswQ6ESdGrvVV34PEQgPPTgIzr
 v+yXrRqZ60ynESBw7Ww==
X-Proofpoint-GUID: DvDWzE3AEjStRXxa-aZ3ewC6R9ROZUqO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAyNCBTYWx0ZWRfX0iJ4v9dribyG
 STuaC5RVbBGkd5QAIY1rFPRx1YIPoqiCqaf8DYE2mI4YWzVgtoaBeC1cNZqM9tG+PkWdKY14BVd
 wVeEdj77EnC8FUj8wAHjq5hpy5Jj1bg=
X-Proofpoint-ORIG-GUID: DvDWzE3AEjStRXxa-aZ3ewC6R9ROZUqO
X-Authority-Analysis: v=2.4 cv=Cowq4X4D c=1 sm=1 tr=0 ts=6ad5b617 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=Ebq4Ce3iuLL-fAZv0N0A:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190024
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.14 / 15.00];
	BAYES_HAM(-2.14)[95.84%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	RCPT_COUNT_SEVEN(0.00)[10];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,gmx.de,ziepe.ca,vger.kernel.org,lists.trustedfirmware.org];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.198:received];
	FROM_EQ_ENVFROM(0.00)[];
	DNSWL_BLOCKED(0.00)[202.46.22.19:received,205.220.168.131:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 59A1B44A8C
X-Spamd-Bar: -----
Message-ID-Hash: GTVLLEND3D7FOVW6HR5CXL6ZBZ3AF74N
X-Message-ID-Hash: GTVLLEND3D7FOVW6HR5CXL6ZBZ3AF74N
X-MailFrom: kuldeep.singh@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/GTVLLEND3D7FOVW6HR5CXL6ZBZ3AF74N/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Kuldeep Singh via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

>> +	err = tpm_chip_register(pvt_data->chip);
>> +	if (err) {
>> +		dev_err(dev, "tpm_chip_register failed with rc=%d\n", err);
>> +		goto out_svc_obj;
>> +	}
>> +
>> +	return 0;
>> +
>> +out_svc_obj:
>> +	tpm_qcom_release_object(pvt_data->ctx, tpm_svc_obj);
> 
> This is very cleanly laid out driver. This goes perhaps unhealthy
> levels of nitpicking but we usually tend to have newline before
> the next label.

No worries!!
I'll add new line before out_ctx and post next version.
Let me check any other goto usage and update that one too.

-- 
Regards
Kuldeep

