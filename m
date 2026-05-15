Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C93ACD4F3C
	for <op-tee@archiver.kernel.org>; Fri, 15 May 2026 03:11:04 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A094544DE1
	for <op-tee@archiver.kernel.org>; Fri, 15 May 2026 03:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1778814663;
	bh=ZG1J70kNdQWLMVU0WcNn+nE+WNdxPX2Sazj26shEv8E=;
	h=Date:To:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=ZyYJj3eTjNHKhetgWChKnwl+1WthiwoGkBTFi6wfRQn0uUHdzEcLpkpqVZjEKjx4Q
	 HWZ9jVm/AWHtbnlIPZRRZa9AznxKWUyecqgkgu0GmKRLVHOe5/1yy575ZVA08nc+3q
	 iWBfgvyT45jVmy/L31a7VDa1w705GCnVSk/tymfJ1jSzX/M2nterG/TqJm3MRU+DMc
	 pS+uEwOERThDqxMlyBYPMbNE4cvJEs8rEXwsMNmnIcB6Z2e+wS7cxlA/tk1kaFGGqm
	 dkk0NjsGnOrC3qGVdVVjObsy5/TibYvLK0ErVK0xfsf69gJvJ62jaFX2ViCiL2kmmY
	 CBxd+dLXz7wnA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E3DA34371B
	for <op-tee@lists.trustedfirmware.org>; Fri, 15 May 2026 03:10:56 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fBOpyYJH;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OVCeb/WD;
	dkim-atps=neutral
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EIpOYZ4008230
	for <op-tee@lists.trustedfirmware.org>; Fri, 15 May 2026 03:10:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ZG1J70kNdQWLMVU0WcNn+n
	E+WNdxPX2Sazj26shEv8E=; b=fBOpyYJHc72iqS2ZOKzT9dEf7k+QmVIplsEFEc
	0rJ2zZjN9dPpHEukETtBo61DUhEFz9RYoHN5sUYjIS2qx5SKUNZBmGTWuKWVMndL
	j7aO1tvvsBp69ayJwZiQL9qDCJQaGpZP/DUgBl9fhnpezPRYi4YPeGhG2+YBALtI
	jCWCwy3KrIgX0no/ui8FaAGGvHOIaYKDPUqi9quoRWTbxKPg+wKCh8wlMaDj2EwQ
	gQdukzeKkUlbPTnSG4+wp5aOuf7tOOM9eUNEI66i/R4incf0YKwTSHYra1JxSb9M
	HzAcjESLdCLP9qkquxiBDXS291rTYthNyLiVPjDnnK21kTqw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1ssan5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 15 May 2026 03:10:56 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8353df9bc7eso8267319b3a.2
        for <op-tee@lists.trustedfirmware.org>; Thu, 14 May 2026 20:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778814655; x=1779419455; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZG1J70kNdQWLMVU0WcNn+nE+WNdxPX2Sazj26shEv8E=;
        b=OVCeb/WD49y+QyJZC3yz+O54yAWLHtgjH5NFj3o81LI7W/dZQ0KbUl5pp/Br7T5df4
         2gRrBiuTYaeBWcEMMj35S9mZuAWTYzuggpsjqXAPHoijHFCzj+axgs24mbVwbqaTC0uI
         plhtq+Wwn5HBGo3EL5vy4Kyu57CajM2mdlAIrETvZ/FZ7XPWVzPZ4XKubVq/zvkNNpMl
         72WNdDh2ScxwYyg+Vugx6y9rWeEgf9JxPBDHFeVC2ik1d7GYcdjj6pCE3KoQgili796J
         a3blmQ4jxQPpMlDT+ZjShP/LhOPPKf4JCiDtoeVWpd7cxOxMq1PECkZ9CftzmzuxoZI/
         EZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778814655; x=1779419455;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZG1J70kNdQWLMVU0WcNn+nE+WNdxPX2Sazj26shEv8E=;
        b=NfIkxbx3mdXf0j58CPr3Ub+AGQciTS1FDHwrT5Kc08xwktxO/E3Nvj6FRmbj/sbkVr
         QlWSQz1bP580Dps6kOqoQf9/chlKnGB9jYbm6GheGp8QQqm2/c/ifZGDkGXchAj1AKL2
         YFsy+p0s5IrtRWIpD/HDU3EPBoGrZ9Ll4KfJGxI8pUtOnN7smXUiRIb14E82b1pKScQK
         Gu5X80JLjCoxWR9usuqjlhku3d6b9lC8uTuY6FBEhDEOelCxcb7lbkByi1OgkREunPyx
         VqaDOQUDH1eW2+2EBUQHjs7V0WMd+SiN3cLCtvTRA/0c9sxRKGKL3R055GdLLRWBThA7
         PSLw==
X-Forwarded-Encrypted: i=1; AFNElJ+DQKaQQLsVo5CbjCgux8SGpGG3MICtgi8Wo8owBSCCcYl+n5qyTfFtAuO9L5FcEvtEWxdH2tc=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzWjsNwxK5L7wADMMEsgweTNENNaX17pHo4z6TD3F+AWcycMXQF
	fUx7Moqr6nW173j3zcmkwzOOuf0PU174ETzy/VXThy9nBjlr/4XUk+U2Q3YkbmHER3ZH5mcHpUz
	k57gy5fxvvXCuM8MAW0EBq9dkihfXq9CgdaflIBPmPmIT3Agf6KeWX9yk3rx0oBgn5pbJAZDgBq
	Tx9YE=
X-Gm-Gg: Acq92OHixTHzaFLwY0im7QzXyNklSrFuSsDec/yHQBzqQjGyFMC7WS1THPJPnWDilv0
	7SvdYKpbXY0gDTJzU7ESCYyiEBKXhCPKHa4A1COSuSe0mqOIEChJc7NxZ/wRZlghcBeHURwXeJo
	CWD1Xwcopd5b5ZNsfxViRAhoDLqDrjsYLNhOhu15kdgxQcYvboSXbs/TDgkSFce/eatoPnFEdXy
	qYP6u4GyhJeVVlWfI65Ue7t44OfgMT8YTd7cqEFSdYtKPKsMzryPJgmRFNNClW/0BPQzumWHfXk
	+Iv9OYsmduhNwCy/8noMUIKEk2qE+I34NZNLTLVStcv1hMdqIpnLcvmdb5JO3S4yBhvxWafNxK5
	jX+HbPLyL5CehsOWr40+BfhRltEDjHlFqVanhQpv0ACBE1o/K/1OIIY5/kr/PkKHsOvFbhP7ovq
	pP8AVoBqK02HC7Lekq9nY=
X-Received: by 2002:a05:6a00:12cf:b0:83a:4846:90bf with SMTP id d2e1a72fcca58-83f33e0658bmr2152576b3a.43.1778814655145;
        Thu, 14 May 2026 20:10:55 -0700 (PDT)
X-Received: by 2002:a05:6a00:12cf:b0:83a:4846:90bf with SMTP id d2e1a72fcca58-83f33e0658bmr2152535b3a.43.1778814654617;
        Thu, 14 May 2026 20:10:54 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19664220sm3941688b3a.4.2026.05.14.20.10.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 20:10:54 -0700 (PDT)
Message-ID: <75d61a22-7c36-434a-a9f2-80533090e072@oss.qualcomm.com>
Date: Fri, 15 May 2026 13:10:50 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org
Subject: dma_heap and protected memory
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 4ie-0_LlfDofuQWkQm-8WfzsnVP3vQC_
X-Proofpoint-GUID: 4ie-0_LlfDofuQWkQm-8WfzsnVP3vQC_
X-Authority-Analysis: v=2.4 cv=cZPiaHDM c=1 sm=1 tr=0 ts=6a068ec0 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=npWEiaNfvXBn0Vu7ZMcA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDAyOSBTYWx0ZWRfX5LTvXB/Ah28u
 Qj3y086z1rGezk/i72O1t6maDbreuyzhH+mchr4hB22QCk5ldWYl0mzb6zI27/ZCJIS4aG9J9xq
 cjjv20iq+R6lq8YuNOVUTPMnR95EnWCXAmlhEi3NwCL0wVh4MzkphfVYLM3Suh4qgeEnFymbu33
 4irZgwzloH2BdBAHJaxHW9bykfJ8RkHb3F0DLI+CK1b8s4IYRk6xOr3NbEDJpIIG+YYT6xfvNrK
 jkYTc7U6JB53/q04gTryY5bfHg1d69PF9kOaxbROj2SlxCTpWQdubrkwZX10j6YUXIpEM5cGRaM
 KYPQfVtI4Uq8O5tM4GJOitoE/eouPNu2V66DdtLXuL1waMgttMDdYcu3dwZUX6QPtpp4Hn8gejR
 KPSEHO7gyfMOd57rIZyw8Epi5V4lbkodI5HOb3Q2rMlyronR3SYc6yOJpnL4z7sLpkCrd6CftgG
 toE2RzhEUT5OKyKtEmA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150029
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[99.98%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.198:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: E3DA34371B
X-Spamd-Bar: ------
Message-ID-Hash: MQLVWIQ2OP6B4L3DACRDAX4QIR65LUGU
X-Message-ID-Hash: MQLVWIQ2OP6B4L3DACRDAX4QIR65LUGU
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/MQLVWIQ2OP6B4L3DACRDAX4QIR65LUGU/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Hi Jens,

Recently protected heap support has been added for the TEE subsystem.
This allows dma-heaps to be managed by the TEE subsystem itself.

For standard, non-protected heaps such as the system heap or CMA heap,
I am trying to understand the expected usage model. One possible workaround
appears to be to mmap the dma-buf fd in userspace, then register the
resulting userspace VA with the TEE subsystem to obtain a TEE shared-memory
object, for example:

fd = dma_heap_alloc(...);
va = mmap(fd, ...);

shm_fd = tee_shm_register(va, size);
tee_invoke(shm_fd);

close(shm_fd);
munmap(va, size);
close(fd);

This seems reasonable when the lifetime of the registered shared memory
is limited to a single invocation or callback. However, I am concerned about
cases (multiple exits in qcomtee) where the TEE side needs to retain access
to the memory after the ioctl/invocation returns.

In that case, registering only the userspace VA does not appear
to keep the underlying dma-buf object alive. The TEE core pins the pages,
but it does not hold a dma-buf reference or attachment. If userspace later
closes the dma-buf fd and unmaps the VA, the dma-buf exporter may consider
the buffer released, while the TEE side may still have the memory registered.

Is there a recommended way to use standard heaps, such as the system or
CMA dma-buf heaps, when the sharing lifetime is longer than a single TEE call?

Would it make sense to extend tee_shm_register_fd() so that it can handle
dma-buf fds from regular dma-heaps as well, not only dma-bufs managed by
the TEE subsystem? That would allow the TEE core or backend driver to keep
the dma-buf reference for the lifetime of the TEE shared-memory object.

Best regards,
Amir

