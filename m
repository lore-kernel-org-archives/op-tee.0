Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2592CCA5FDD
	for <op-tee@archiver.kernel.org>; Fri,  2 Oct 2026 18:51:18 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1F21F45520
	for <op-tee@archiver.kernel.org>; Fri,  2 Oct 2026 18:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790967078;
	bh=+psLUNDmbPUzEdWhqV587uxM2dcbBbUsRZP0vBbX++U=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=GLxtACM8i6Enx9BI9FjsDr+EE74c+xXTfh1/k6BeivQBOpRdm5ol/ifatumumz20q
	 aTenmB+1KfBgR6rF1NbuKrCdG2GsRCD2u976x5/hSI+KX+zLbxXFtpEf6QTKr8JL8n
	 Ph4weG4LxXCzYp0MJWodgxR/OJlE1pUl/m9avRohkMlsJsmpQHsSwsyUu9nmbQH9mf
	 iPfyTZfNZEPxdO7oD8csNhHmH3uPicKT9tvMwnbscvUa24VIgka3ZXPF6ubbQN/LQY
	 +NHC9N5ZfePkfAM5cVoiEZqJdEmWhDDiyfs6wJS6EUmbwTkIrAi3LpUnUSm8wbYsTW
	 r72JWePF4jlzQ==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A911B44A45
	for <op-tee@lists.trustedfirmware.org>; Fri,  2 Oct 2026 18:51:08 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Vri2bCPH;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ezP4DQee;
	dkim-atps=neutral
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692H6AVa1675388
	for <op-tee@lists.trustedfirmware.org>; Fri, 2 Oct 2026 18:51:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=PL8CS+71pdmJhXGantGtoOxr
	+y40gnwfY9oW8NDJQbc=; b=Vri2bCPHpMV/MPGxV1flQtHmV/Q+gKqND7lGKJKb
	TNE1gvAV8Rbj/H2Pk1tyYER/dj7vW4N1RkEn6O5V7mK10f7BO+bOjD/pvgf4HBXh
	b/3slhyLMfte/iLfJDJ3bVv3zivWn9bNm8HU88rAn7ev578MnWEvJ2Y/3HB1ZFVv
	v865wKdeRKN6d8Un5uAZHw8crvfHUZW6gORfi7MVsivDHKKRXjAUsqhMoKMat177
	P7rnrWGquIy562bdhMi89+ByYF4dAqP2miWiz6Rm6X91OBcf8WzX8LzVEcEE8Et+
	h38B9zRDyf4wndKWgkRvOYLvGVbI4OrFxuECwtkQCXMqWw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2ft8rppc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 02 Oct 2026 18:51:07 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93ca4a2b9c4so638955985a.0
        for <op-tee@lists.trustedfirmware.org>; Fri, 02 Oct 2026 11:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790967067; x=1791571867; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PL8CS+71pdmJhXGantGtoOxr+y40gnwfY9oW8NDJQbc=;
        b=ezP4DQeeZDHLuBqRNyu8/NctdcYyT1Ds+HwDBwhbzWYW3j4C47trubCytKETIMpZav
         CX8pW1cjBZ49nt89+v4UDFH2jyEpck5tUGHt43cbh2PqsjoajC1A5auDa6kLrvdhm/3I
         jQ1jdLNQan4PhARNP/VU1qdNQ/fVR1m7mLFxwJ/8Ow7ABwDmwQf793LuZUZjFRNpCWnh
         1/HrUAOgAU0Jv8fWdyAu4t6yuY5JaioWC6+eiWTGN6UQJ8qTumojeSMYCOzNF8oMx9sD
         WIVJk9NYvEYYzHOFvHxFCglwwiTJ9Zo7ds+HustM9N/+zFg6nJQSaBiP/N4KL3qLCIXm
         3VRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790967067; x=1791571867;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PL8CS+71pdmJhXGantGtoOxr+y40gnwfY9oW8NDJQbc=;
        b=jQehU/H4JTCyzpiZvWA9BLLPZ3ZH5oXljZF/AX9Q2ekl9373o91p2ypGphiEPrpr09
         9MedMD74W16mpxXlh6upTAx6mAXo1hwF2BwMV1JlD1V0P5L5kzLVRt5uGHyVEzooZ0Jb
         rk/PvWws0djy05w920Plw0B53qy5Zzy9NC8Nu3eWNXUBLB/k1IOcGG8Ry1+xVYcad5Sq
         crbPURqF4NjEyGO6EK75DdrX4Swxbcp6379mlKpoi9Vd1bnx9oa9G7oejO0+U7F2dMTt
         t4cmhRqRnwPdNI550UXWL2dwqkYaVK+Y61fD3nyvQjrBbAwSTibNAg66q6z2Yul84CGg
         zefw==
X-Gm-Message-State: AFuF++niVXze/OkkGn6YQ4kPL1jDApXRtfek7lhCMdjn0dhUYj3BxIHC
	XBgw4GAxEUENCkaJhBQfo6CM0Whv0Qdur+kCRR6f8webMAMUw3XkQ8UHEg2BXoHUHcQ0ius7XKc
	Z5+6rq4Ki3nROq5veKcC1qf3kPeRLy3PMPi7zBSQ3et2jOx/1SEjmz4CVnymGUbXp/39SGvVZB0
	O3OYiNKmvNMw==
X-Gm-Gg: AYBFou2k3Df4LUvoRMXaKy27kt1SEEta5dQlao3OX0vJknAreATP7OikEAbMoS4FgNk
	8dl6kp3lCh8xmpeQfBGkST5/Mcx486HfOMexxjIJIRSs5AIvXy7kTxc5MDVW+5mNoEvs4fPyXyH
	fAygyvZ6oRtxWanYijxMmmoTrvzvoLQNKiv016F9wrbf+RuAGqZBlqhqPcdNzHN/muCUlKpjq0m
	dsmheZsdJGIserCUM6XvKFNhUT83bk7o8VJQzKInWPrNbjU6sWWv69rCpeLCYbUFwPz1HN/+6eF
	JBgT1E0PpnvNs12u5yS5PaQLdEW8mNPsKabxbpvOX65wFMfSCZNfHaLHAGxlA97dYSda3823z4Q
	rKNsqDNa9u9BEewhrJV0edaRYS92aGkQOjLccXdRyE58sNg==
X-Received: by 2002:a05:620a:3948:b0:93c:c2c2:40eb with SMTP id af79cd13be357-93e510eed5emr49092785a.66.1790967067015;
        Fri, 02 Oct 2026 11:51:07 -0700 (PDT)
X-Received: by 2002:a05:620a:3948:b0:93c:c2c2:40eb with SMTP id af79cd13be357-93e510eed5emr49081685a.66.1790967066261;
        Fri, 02 Oct 2026 11:51:06 -0700 (PDT)
Received: from rayden (h-79-136-84-34.A175.priv.bahnhof.se. [79.136.84.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e4cf63349sm121350066b.50.2026.10.02.11.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 11:51:05 -0700 (PDT)
Date: Fri, 2 Oct 2026 20:51:01 +0200
To: op-tee@lists.trustedfirmware.org
Subject: Re: Preparing for OP-TEE 4.11.0
Message-ID: <20261002185101.GA828754@rayden>
References: <20260925111321.GA3247540@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260925111321.GA3247540@rayden>
X-Proofpoint-ORIG-GUID: pEkIgvXaMM71q0R_wVcNp6iuWO6XvwhA
X-Proofpoint-GUID: pEkIgvXaMM71q0R_wVcNp6iuWO6XvwhA
X-Authority-Analysis: v=2.4 cv=c8M+0h9l c=1 sm=1 tr=0 ts=6abffd1b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=dMv3lA6PLLkT9/uWe4YCGw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=NEAV23lmAAAA:8 a=UXIAUNObAAAA:8 a=f1Brr1RbUJsseVxrjuEA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=a1s67YnXd6TbAZZNj1wK:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA3NSBTYWx0ZWRfX1p+gSZck1WQm
 TKv4JL+or8B/PQmiZA3BxneEx2U++0wwnyKFA+UoqXOSeHh6D7nQh6JUmcbjHwngoZxXNsc8MB1
 lACz36hajW9yY7QOm4fysm0qL3uWTI8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA3NSBTYWx0ZWRfX5zk5D1HZhj6B
 rSL0IFWRTdHI25fgsMgkLmEM6l1YDddgr3ToKBcbjTv9obJmtL2aL8o3tJoQpRvfuTcs1vpCO6F
 TgjnXzCv0G9fKBxi/e8dodRui094/DLgr1jojcgACrqDyUMHmPPJRmvKy6LeBkQD9OSVERmV3cO
 khLtPAmW/cNe6f21XzdSXq2J5iJC9XJuBM4n7xO7No1+JvK9EPMTd/hMy4y2FljkARLSRgsjDtN
 e0EyO+MhtwxPYQdO7JYdNRn79NJQxO6Jhaoz48WZfBmP+baWHqRu5YFQYmKcpUsxrmBa42kHwIG
 1LW8MFXZXDcxUwldNoLzDZmt6ayWWLlfDRAASYhvOiFKL1WuZSUTpuvvMxssknAWb9Oz/DdDnJa
 M0yv0B4ktbpjlNSbJrP1VuH/g25pzJyMsFvAACWlpipAXcGNL46Blp3W8PlaeMNKtKbPPkUaQXz
 Is44BLRoUZePm9eriNQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_05,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020075
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DNSWL_BLOCKED(0.00)[79.136.84.34:received,209.85.222.200:received];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A911B44A45
X-Spamd-Bar: -----
Message-ID-Hash: AAB5ROSXJHG6I7RYCSG4HKA4CF43JQ7K
X-Message-ID-Hash: AAB5ROSXJHG6I7RYCSG4HKA4CF43JQ7K
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/AAB5ROSXJHG6I7RYCSG4HKA4CF43JQ7K/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jens Wiklander via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>

Hi,

On Fri, Sep 25, 2026 at 01:13:21PM +0200, Jens Wiklander wrote:
> [BCC all OP-TEE maintainers]
> 
> Hi OP-TEE maintainers & contributors,
> 
> OP-TEE version 4.11.0 is now scheduled for release on 2026-10-16. So,
> now is a good time to start testing the master branch across various
> platforms and report or fix any bugs.
> 
> The GitHub pull request for collecting Tested-by tags or any other
> comments is https://github.com/OP-TEE/optee_os/pull/8054.
> 
> We will create the release candidate tag 4.11.0-rc1 next Friday, October 2.
> 
> You can find more information related to releases here:
> https://optee.readthedocs.io/en/latest/general/releases.html

I have now created the 4.11.0-rc1 tags in the following OP-TEE gits:
build optee_client optee_docs optee_examples optee_ftpm optee_os optee_test

Please proceed with the testing.

Thanks,
Jens

