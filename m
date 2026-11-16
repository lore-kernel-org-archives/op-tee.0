Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43FC606A329
	for <op-tee@archiver.kernel.org>; Mon, 16 Nov 2026 11:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mYu6QDao;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JarXprNp
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 35E1145483
	for <op-tee@archiver.kernel.org>; Mon, 16 Nov 2026 11:39:10 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mYu6QDao;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JarXprNp;
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 534D944E47
	for <op-tee@lists.trustedfirmware.org>; Mon, 16 Nov 2026 11:39:05 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGBLRLW1397360
	for <op-tee@lists.trustedfirmware.org>; Mon, 16 Nov 2026 11:39:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ajrBayh+hf9TzW6sC/OulW/Cwr8R6pJ38qBUt0Xogo4=; b=mYu6QDao5NgEwxmp
	kQ895IHZ4WAirpwoQZRtpAlEV363O3v8ydCIrYrkRvtPejSH85A2wDKYPOE6ulRl
	jYkkrbsddVvpBo2sgKZWD4s6Ppz1tug3BT9GPInX63LcavJI736NmEGw+vDTfTx4
	zbDobSygfNsdcRW5yaYMfugREWxwp0P/GX4HmFqPKHTqljgXn6mNVl1tdtagdCe9
	3OCPikboIAUzdMLio9ZZ7eerFvFNq4P6xJ3aV6LlzSNblvCJabBSFhrBneJz1A5Q
	L/h7B+D9WLSoUMuGHl2O9OK8vnZn7JN2Yk9JOuQB6E4MqxKmX8kVChC0yO7uVlPs
	wTi94g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyyrqgafw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 16 Nov 2026 11:39:04 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b18165dc53so4861830a91.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 16 Nov 2026 03:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794829143; x=1795433943; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ajrBayh+hf9TzW6sC/OulW/Cwr8R6pJ38qBUt0Xogo4=;
        b=JarXprNpd0iL56cyxi9hycxUPGSxLDnUVQUcF2sT5yc9yrawKa3ZLsMJS7PcmRjlrg
         3OR4glqycgBkP7FalM8RMYXIBJGHEAekw1xtpwyxdd6gpfYMWqKJwZUw5yiSa7yD+aHs
         a/aIBZmbrYMgVGoDUrqUKfAfyEU7pFQAsE4w/DeXajpMTen/zBjK2rkO84g2QEh+udUE
         zPH9uIcgpu4pVPScluhfhldw3qXJ08UTfF0ITR33BDIQEOfh66SN3zWSHds+NYs70fMM
         U7Mo8cb2Z6T/ZGDL/q1LSlsPAfko7gQDKE8eQ1P6FRgGP1Ik0ITPWgS+s2oCDH/vwFFN
         Z9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794829143; x=1795433943;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ajrBayh+hf9TzW6sC/OulW/Cwr8R6pJ38qBUt0Xogo4=;
        b=sL/g8RiiqMubHGoqJ+2E4Klz0xl2gqxsA45l0NU0WQp40ZHmE9DzlsZflEk/NEJbzQ
         mvUk0fgRaIi7q+NedRpya4yGeX+z3W3bS3TZxOtiS22RPEZ6ms1bpcI9f8wsY3WzCTQe
         zbfKvo1I0tYJaWGK4ThSetXIAJtZPVL2EvTRZP6dcDEkG3gAuTTG0SfzE2NGHX1PFFXm
         /42ba/TR/XU+lcj1Z36RUP6R0cOj/EBuX+yrh3beeAtgHpKXQsck2qXwPGyEPH62LcXl
         1WzdvG/IlX1o8EzlWi4YTOXQefHk72EMmGONy9tm6wVYk8LbMoDpdqLC7IcLbrkbFOTH
         movg==
X-Forwarded-Encrypted: i=1; AL+hErEPR+ObZ9ieA6KCC3+86zdgWdy1OPAWvfcMveXLrAUJgrA0aghMo+oUJrs5x6kF3wfGwqllZqw=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z+9bU8Qup4dULwWYIxazKGRaotVh0R6k/vCN1mOBwhTjEvOTAaN
	CUqlYMOcfRLcIaw4eb35B142wQFAUUPd3evB2P0ZoMsVphtRf3fLFjeUWd80oZqC0VTifUQIm7W
	/veRC/LRbVuyL2rQ5Mx1ElzQkuEXe7EjsxWVT1AnI55cB+bM5eBBwcYucTKlQozpZfT8eU+PV
X-Gm-Gg: AZFdTZfpuwa4Y6T3M0ncxHgulKotpk5o7YaKT9ROqku3jf7QZHJ953SJp65VIwii6hR
	B9FhEzakZMfEu2P3fTXcxsGyqTThtOa5exZ5AhD2EEk6Whxmea0fhy8oEtE9OBCyBI19yFRtxL1
	kTeFVDTWejT0ex4hZQW0pPXL5se+Pau8BM8xVotIa3ZC8K6UkEffumUoS/LYz2mI5R95fEIbin7
	QA0a/j/BQKYnrX4M6Q0d19RynEu/cZWtZB2bKKoaZN8DCKs+6QSM+IimTYcZDC6FTPRuboQ7R50
	aLownMAd/Xm6nTztT9t8q2qpEHvLlZJSlpw8jnQYiuOLFDc8iEnCZvZB3qoHCRP7e/mfs81sePS
	mPN2mg2hFxqoW9XAXpvMvv8eXD8iehTkMxnPgSA9pXC5Jn8/MWQtEqSFWyLVkg3H9GdUzd6VgOK
	M=
X-Received: by 2002:a17:90b:3d87:b0:3ab:2737:3395 with SMTP id 98e67ed59e1d1-3b1b0a3a2f9mr9515851a91.42.1794829143144;
        Mon, 16 Nov 2026 03:39:03 -0800 (PST)
X-Received: by 2002:a17:90b:3d87:b0:3ab:2737:3395 with SMTP id 98e67ed59e1d1-3b1b0a3a2f9mr9515833a91.42.1794829142718;
        Mon, 16 Nov 2026 03:39:02 -0800 (PST)
Received: from [10.218.26.96] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aeb17042sm16407771a91.6.2026.11.16.03.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 03:39:02 -0800 (PST)
Message-ID: <41eb56c7-b1c4-4077-9778-a31a91002511@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 17:08:56 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] tee: optee: Register TEE devices on the platform
 bus
To: Eric Biggers <ebiggers@kernel.org>
References: <20261111-ice-migrate-tee-svc-v2-0-29d19f6c92ab@oss.qualcomm.com>
 <20261111-ice-migrate-tee-svc-v2-4-29d19f6c92ab@oss.qualcomm.com>
 <20261113215646.GB35210@quark>
Content-Language: en-US
From: Harshal Dev <harshal.dev@oss.qualcomm.com>
Organization: Qualcomm
In-Reply-To: <20261113215646.GB35210@quark>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VcJir1p9 c=1 sm=1 tr=0 ts=6afaeb58 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=yq9iaoSgN4BPWgwdfiYA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: 7GTVMpcZhySC5iy9bh_crvSkwsRZufBI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA0NiBTYWx0ZWRfXxnkGwofvd+Lo
 do+dytPkhfU8dl11pIsIn3naMQVgFQWLZGQJ4DsnfNuW2mk1mbuSN23I0pYn1bus2PZFUfu5o4R
 5nbpEEH9FEqWYux5da/8TeQYmgutg1Z8ebsRVx3t/uf5BWlMXq/D5rSJ5nICS/LozWGHafqq4B8
 s8hn8WlZxVMSqMEif9YTCKuVVv3b8qeIYx1LvLhPNs8QHF/nq2CWRTG7VzIRqlYIuTmrcUgutH4
 bzntSxE7MLig8hKTd5vFliEfbig+ADgwv35e3gMSQ+EK2aO0X+olrEvVEWOs+p5nPLo5Fl0zXxf
 Tac7/SCk7bbiqWS6B18NKi0kU0L0DueSLbhmi4OAPhCg7Jo0hSzr1SO0QQOCs+g0ruhaN97R51M
 mqI5TTwRLg0lK2eelB3PNc2qRdouyjRvx6cE9yCR3nTZVJx+VTUYnvPKx+duAQh9r7jUOsr1pbd
 B+00eZ8TjtjAmHdWKXw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA0NiBTYWx0ZWRfX72tIsBJUw09Z
 FVHuPEyyLfO6KD5ymN3EX3gSIPm4NV2luQrv7C+nISsjgpCr5Sk8dgH6UeF9c08V/uOh305ieLW
 xgXHGjfEpS01JJjAgBM6GvTPrWkAWUo=
X-Proofpoint-GUID: 7GTVMpcZhySC5iy9bh_crvSkwsRZufBI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160046
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.09 / 15.00];
	BAYES_HAM(-2.99)[99.97%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[oss.qualcomm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	RCPT_COUNT_TWELVE(0.00)[15];
	HAS_ORG_HEADER(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.69:received];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 534D944E47
X-Spamd-Bar: ------
Message-ID-Hash: 4I2MQYZJ7SJVTA3H5IXLPXITYO43RIFA
X-Message-ID-Hash: 4I2MQYZJ7SJVTA3H5IXLPXITYO43RIFA
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Neeraj Soni <neeraj.soni@oss.qualcomm.com>, Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, Selvam Sathappan Periakaruppan <selvam.periakaruppan@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org, op-tee@lists.trustedfirmware.org, Jens Wiklander <jens.wiklander@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/4I2MQYZJ7SJVTA3H5IXLPXITYO43RIFA/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Eric,

On 14-11-2026 03:26 am, Eric Biggers wrote:
> On Wed, Nov 11, 2026 at 07:47:04PM +0530, Harshal Dev wrote:
>>  module_tee_client_driver(qcom_ice_tee_driver);
> [...]
>> +module_platform_driver(qcom_ice_plat_driver);
> 
> So is this a tee_client_driver or is it a platform_driver?  It can't be
> both.
> 
> This patch feels like a workaround for issues that could be solved by
> folding this driver's functionality into the existing qcom_ice driver.
> Is there any reason why qcom_ice shouldn't just make the OP-TEE calls
> directly?
>

So this is an attempt at solving the problem I described in the commit
message of patch 4/6. Basically, if the ICE driver is built and probed, it
needs to know that:
1. A TZ is available on the Qualcomm platform. (qcom_scm_is_available)
2. Whether the TZ supports an ICE secure service. (qcom_scm_ice_is_available)

With OP-TEE, there is no way actively check via an API for 1 and 2. Instead
the TEE client driver model probes a driver only if the secure service is
supported by OP-TEE. Which means that you only get notified of the presence of
the secure service, not of its absence.

So currently if you boot with OP-TEE and register a back-end ICE TEE client
driver, and the OP-TEE build doesn't support a secure ICE service, the ICE
driver calling a corresponding qcom_tee_is_available() API on the back-end
driver would forever defer probe.

I suggested another approach for this on a reply on commit 4, where we register
the back-end OPTEE device on the TEE bus once it has registered all its secure
services on the TEE bus, and then the ICE TEE client driver can be probed
when that happens, and subsequently attempt a tee_client_open_session() call
to the ICE secure service, failing which it would have concrete knowledge
that the current OP-TEE build doesn't support the ICE service and so we
can continue storage initialization without inline encryption support.

At the core of it, we have two device-tree probed independent drivers, ICE
and OPTEE that need to talk to each other the way ICE and SCM drivers do.
The right approach here needs debate and alignment.

Regards,
Harshal
 
> - Eric

