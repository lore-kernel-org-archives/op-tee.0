Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247FB606A321
	for <op-tee@archiver.kernel.org>; Mon, 23 Nov 2026 09:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Xg1unES9;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=heGvA1Yr
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7A4D3454B8
	for <op-tee@archiver.kernel.org>; Mon, 23 Nov 2026 09:18:43 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Xg1unES9;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=heGvA1Yr;
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8EBEB44EAD
	for <op-tee@lists.trustedfirmware.org>; Mon, 23 Nov 2026 09:18:38 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN9IaxJ3490974
	for <op-tee@lists.trustedfirmware.org>; Mon, 23 Nov 2026 09:18:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mSzMQRsg+yqrEBzUwipXKM/+0J/rVsVGfEXY3Vx7ICc=; b=Xg1unES9jsmRSZyK
	HTGRTKLWVi8KzqJYZAb0udLqpQqOHo101z4Zb/hMrylrs4gj1UJyLPqVKcJZW2L5
	VHmFZvw0g9iEJRrddx4zxpqE0xU0BFzwHj5ic48N09PqyT9UNfGFJy4lkA8ni9DR
	mTLW9qgjJr7YoolBgiNEziKbgmS1Nt+5GVHxyxZiiHmBKCmrIIPZWrCn3WFNwSI6
	c3Flfq3SgAaGlMNyXZaCb24wZ69W7Qw1pOEMLRtxLXaZqB6fE1KWciK77m5kcvKX
	KT8KoeYt3QtTGPeykiAMNcoibkzoHlVLFcFWXom+FDmk0BSjfOPnPkTlFjsZWCKr
	9lHkHQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4evsgv9m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 23 Nov 2026 09:18:35 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b4232374d6so4264167a91.2
        for <op-tee@lists.trustedfirmware.org>; Mon, 23 Nov 2026 01:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795425503; x=1796030303; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mSzMQRsg+yqrEBzUwipXKM/+0J/rVsVGfEXY3Vx7ICc=;
        b=heGvA1YrPxnbyb+x9SVB3qG+Y1qLbtd9/6Z2S9eL3rXVxztAdR5Bvq5pWVr4vYXA81
         BJVfu0K6MA1KIcg3DVi0+UnuQLoKgNE9KQCim2+fzTCr1CZLcY7D4ZbXnJAM7pi8h8FT
         PUtmzOeXRx7fYl/HNE1fRFE9PlODuvjModvaLA7dDoaWdE1sfftpJmDw75GjY7ytfbp4
         G0vUDBL/22OaZZ8p9+j4wxOeMlCkRzmDkqwSm5DSUu1Yqgu/n+k3KDZEbNNnFDzfU+4N
         xGs9ab2cMDaHIsAQMg8xqVI8Apv4heOsShdxRQce62ncZKzFSML8lk6ChtdFH1OUBkzy
         foNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795425503; x=1796030303;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mSzMQRsg+yqrEBzUwipXKM/+0J/rVsVGfEXY3Vx7ICc=;
        b=RvFLRI/VuOK8NTxh6DFtzxqLJIqqM2VqHaCuRRkXHPkD6paXxjYz+jQQq+fWVI/eHQ
         M3aC/W3AH3wOgDArifL5eXyCT2b5mBlaNL5qgFUDWX9PLdULL224L2nBuLix2QS5DcOe
         FlodvDtmJYAOPZfytLGSdwBb1m8Y2YNtleR58WDVZLv3deDvJVrNpHx7/yV1+ktMArrl
         4g09V97162BMMS5gsh4lEDZLXNT3jFXNzolWS/yWSKic5BKqBPoFqqjcqO14kZMyJ7vI
         koB+ns49HvJTGYWkQ1mxjAyESukwxEew52zLyAS3SuLHLAyDji+zXrJuG7QqQ8iT3sor
         G/Zg==
X-Forwarded-Encrypted: i=1; AL+hErEgb3um2gTn4nseCRNt6zppKI03UUNLWYKh0kJqBKLr5Z2PlogQqk9fFL1teLJfreFmURNt4gc=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z+ybBJO9RYnxz1oejFE4KNj29aAV1DsSMQrTp35pumRA3jEtrxb
	A+4xK/8TQF5qwfkCzK0f7bbOKTn4tA66FVxnZ44chwSVJgGNWyl5ewniGyhK5jHek15BZxfH6sV
	3ehlq323IjauvjoAMocFZ5UtkKjK6DkmuhwtrCXTYgGcagGIzmvnq/+1ZQyNvTNkIyIOfU2q2
X-Gm-Gg: AZFdTZd/uMBeSN340SZL4nnnmpLm3TzFZSbAfruAbRxvutW0MmCVgFYeYmLs+TLMARO
	Re8Qyg9EoKIwLk9+eewUXOD3woz3157nvPypku0gXe+vWhEQzlBvZRXmb2wK6yqoFej+LxrocBv
	uyeiGBigR/EFroF+2RBM58x9tPBU46+q+/iJGa0JodZpXYwZYLxwdYE5u/3GRqgDBgpaoUxYfn6
	SWJjTrBGjqrRdRSKkmdxPG338X3gSDgGfHJQRe/6Otm+xVyaZmLJrJt25H4QuzEAVhyOq49Ou5r
	rTFgenPWIzlVmAPFCM9zwnGmaMfgb3IDX9c+lCWnCwVKr5IYftIEk0MoZNxYYckJzOohC84RBYg
	z9Q/2xNU+TEy0v9jHMili6Y0Sg1OspoFhvI1SA/xt+vyYv0oz2zaZEGRa2GDC3aJ65pzMI44D3D
	kONWwH
X-Received: by 2002:a17:90b:2648:b0:3ac:da41:ef7e with SMTP id 98e67ed59e1d1-3b41c95b67fmr9471001a91.52.1795425503034;
        Mon, 23 Nov 2026 01:18:23 -0800 (PST)
X-Received: by 2002:a17:90b:2648:b0:3ac:da41:ef7e with SMTP id 98e67ed59e1d1-3b41c95b67fmr9470981a91.52.1795425502450;
        Mon, 23 Nov 2026 01:18:22 -0800 (PST)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0b2c4sm16839831a91.4.2026.11.23.01.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 01:18:22 -0800 (PST)
Message-ID: <8aed0815-685d-41b3-af2e-0055bc6ad920@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 14:48:17 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] tpm: Introduce Qualcomm TPM driver
To: Jarkko Sakkinen <jarkko@kernel.org>
References: <20261120-tpm_qcom_driver-v5-0-3d9321ace107@oss.qualcomm.com>
 <20261120-tpm_qcom_driver-v5-2-3d9321ace107@oss.qualcomm.com>
 <awGtGoxtker8a9kG@kernel.org>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <awGtGoxtker8a9kG@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AL9GXjHq c=1 sm=1 tr=0 ts=6b0404ec cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=V7dZqg2nRoFFyRf2opcA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: kfOKS3gRTIjNOVFONAr3QDreZUg-pzBD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAzNiBTYWx0ZWRfX6YIXDlPQMsrU
 TSp84ahNCfAFTeoIC8rNL4l1J1RRDe5gyA26gNUaxRPwNhLDHRPNCedx+s2k9Jc3rYvDm8pldt6
 c5Dq80SMwbHL3nTO8C78KQ1p8fYvhT8ec3d+Pg/ZJlhP5Tc6djc+RwLQ2hzi41qVaTj3l4FXUrS
 p57enZ06R5INQwQkksuLSYdALEB9ULmEU85yRDIwyxpmxwMwgNQkXES9BkCfENQgeTgtu+MpC9J
 uzmeOeChtGxL9+CoX6+N82AnOF1OgKf6Oisc/tvwKfjRnB8RBzPxpyBsLXNB7URVLSJv3txKn00
 fTcroShkpWG4I5m6/hVh9r/S2EMZmGA287ZE5xHpMevwnHgIbKXZrzdxz0aEWW64H/TkACehTqH
 G81xBsNEH+pJUw5Ess0lBhrWYziR6osc7ZozxtTya5Bxff+PR/ELlp0S12g+0erhm4EilkZuXuX
 AsqeLhMhuBkG7hkUcEw==
X-Proofpoint-GUID: kfOKS3gRTIjNOVFONAr3QDreZUg-pzBD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAzNiBTYWx0ZWRfX24wfBHofgCZv
 K4gwO4CRfXXs7agjqJ9FgHnS84fx5QlU7NimVAK4X8klq7nmiUbwOWg7p+zidk5kWtexA+pW6gE
 ErSzEK96sd3QUazjLWv0H1jV4lI9Sqw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230036
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.10 / 15.00];
	DMARC_POLICY_ALLOW(-0.50)[oss.qualcomm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.10)[65.22%];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,gmx.de,ziepe.ca,vger.kernel.org,lists.trustedfirmware.org];
	RCPT_COUNT_SEVEN(0.00)[10];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.72:received];
	DNSWL_BLOCKED(0.00)[202.46.22.19:received,205.220.180.131:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 8EBEB44EAD
X-Spamd-Bar: -
Message-ID-Hash: 4AHMU4LYFNWBSIV4AYROWGJB5VGXJS4Q
X-Message-ID-Hash: 4AHMU4LYFNWBSIV4AYROWGJB5VGXJS4Q
X-MailFrom: kuldeep.singh@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/4AHMU4LYFNWBSIV4AYROWGJB5VGXJS4Q/>
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

>> +module_tee_client_driver(tpm_qcom_driver);
>> +
>> +MODULE_DESCRIPTION("TPM driver for Qualcomm TPM TA");
>> +MODULE_AUTHOR("Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>");
> 
> MODULE_AUTHOR() field is not that useful and nobody keeps it up to
> date, so you never can rely on it. Not NAK, but just underlining
> how litte it is worth :-)
> 
> Copyright and authorship is anyhow recorded by Git and
> MAINTAINERS document.

Ahh, I noticed couple of other drivers doing it so took it as reference
and adapted here. Seems MAINTAINERS is updated correctly so folks can
rightly reach out to me for any dsicussion/issues later on.

Btw thanks for mentioning. Will keep a note for the next time!!

> 
>> +MODULE_LICENSE("GPL");
>>
>> -- 
>> 2.34.1
> 
> 
>>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Thanks!!

-- 
Regards
Kuldeep

