Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4A8CCA46C
	for <op-tee@archiver.kernel.org>; Fri, 16 Oct 2026 12:56:33 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 440CE4505C
	for <op-tee@archiver.kernel.org>; Fri, 16 Oct 2026 12:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1792155392;
	bh=Y6c9TJV5NBgC3Inpfz38sjLRG2sl6V1/vkLt/+r28F0=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=sgSHofoZVbbom6CxtRY70RePaQXqPnU8D/llu3uM17T7tQ8pmyJJVoyrf4wHZkVYf
	 a3MJQ4isGF+R1SlriAz6uKpWtkycPGZmKEJTF96y/VOg9atm0BsXxF2jufZU9OYkZv
	 cHwrvPMYF9MEHE2E/o2/wjBEqCY/wiXRKZlO4QiEEOI9rUfJ/zpHyDlPIuSUMLBVVk
	 Rk0IMmq+D0r8XVhASDfm1JHER7KHUvJg1Q5l6XDPF0SebzCw077Nq6/jkApbgnBLMl
	 uHvYA5bywYB5N5yVHZTbk5H9se2e5qcGRZV08JjnnFrwbJr7mYqW6ydwpt2T1mw6UM
	 wLtwJbBndg6Rw==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4DE0243A5F
	for <op-tee@lists.trustedfirmware.org>; Fri, 16 Oct 2026 12:56:13 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SPqgLoz0;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aDzC5+uW;
	dkim-atps=neutral
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GAvECl1503804
	for <op-tee@lists.trustedfirmware.org>; Fri, 16 Oct 2026 12:56:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5AeWBEFxL8OW2rqpw2rU9v/zxqIPkPc3rrlHLYBWX3I=; b=SPqgLoz0tGkjNBHk
	A1Fqggh0Av95qdVGg17CVDxSOU6/uo3GTcj4WopiE5y3VUcJZBMeOf0jEe9GWiEM
	pcyZTcZXeuWpBDiOtOfvO4xj95XJy0lizpSbd2aRPQFwwd88baJyWvhxNKATBGAP
	u//SW88UVOjx0PIZr46IVhO+kd0sxxEstIimZxMu4VY/ZX4mvZY+4M2dEFTcRWFd
	MfYiTToJoSsWWpMYwpv57QS62uHe6N3TFiSaCxnZsNpVcr74B4TZKTenLtG7KHY0
	LF/RbHYKGlW3R8vtUF18ckdDM0XnUQiXWT921xUHVTpHS/kriTxCY7ceiZLCzS7g
	VlGaNg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbjmf8cem-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 16 Oct 2026 12:56:12 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-35c5aef2a74so9157606eec.0
        for <op-tee@lists.trustedfirmware.org>; Fri, 16 Oct 2026 05:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792155371; x=1792760171; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5AeWBEFxL8OW2rqpw2rU9v/zxqIPkPc3rrlHLYBWX3I=;
        b=aDzC5+uWOEJcdOhEh5ujqkvsllmdg1AV0rUefR10J0IP/4nQr5igxThDuG50T/w/jH
         FjQwtG0faQQfhh8ylVqAlGmAI6dsLwe9rYTxmTXui0Y5eWw38h9NiRgj2DTGk4JX/YsG
         KuI4Wjm/amc8LuDq+E48tuC75LH4SiXybhCMu3O6IHfUBB7U11MDi9JbO7PfUunCbi7P
         4qJGfNuaFd37eClSfbn/HKVA01+QJLyXYzHQ45in5AAwf6a6is0GA651+eLbqczBHQ3t
         euW2dvMp4MqNkkAL4WG8AHuzruVS0BerO4TpwzkBY6UEk43GtYZ6ISfxBpjCBqWz83OF
         4pCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792155371; x=1792760171;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5AeWBEFxL8OW2rqpw2rU9v/zxqIPkPc3rrlHLYBWX3I=;
        b=nTCLNChemfvB9fT3HvhlrplVQJW1vfxg5iVBrYgyXubd9aRa6RMVGWPtnarIQ9BRVM
         UbQO9OWWCYcR50fDmK2naU5hr5AgBJYhq1TDQi9qA71ovxK2L433hkfhA3g6yYoTkoz5
         rklrRXx4thDzwC8VVUlEac8I7kvqgyQj06JmqhKv2vff5R0u5QBlc3fc/ma+yGeKP2s6
         YAmbVVu00RDNRZmFwL220OQdVztGK+7eQYkirWaOtTwGc1sKK2gL3SO1tbtRTmL3bBT/
         NXUiVjV/ROHbcqwOybaQFpKWqBc93WpPtqioBh0cqhrg3wpcdC13EwSg+dYXYjnwYA3q
         wJTQ==
X-Forwarded-Encrypted: i=1; AKwUvBzD6fqla39oKyE++7ZKEkc300/sM/Quw+G/sVhHmSTbYVNbR85BgWD80yoLWEwddP7CYmO0uF8=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYL38Y891l6pv5ioX4oO42XEnteE+Wniak85al0cvCxYX/DXP4h7
	bUYSjXSmbRtGqgmtv5Q/kBiayJu5VL167zdCGaJnhdcrdyuwrCje7t4pBoWNLcdrgvhnpgQZQF6
	3dkRzoOV1KTGUdFQwac+TLB7LeA9M6xiamOWOSpXJjyDQ1wu46/VG4G7AHuelhpXf0XdRbdTF
X-Gm-Gg: AYBFou2z9SmwvwslCKglOi/wDmc9Ka6mZ3xGdJu67LU9cpDGRi6eSd/HERGHuFYXjC6
	nyMS14VSns8x/+DlSCcd7dnI4AbAdMDt3w1O75tBQSg8v5vpReO8UpL22gIQ5kwJnYzGmMh7rGY
	5P/NnyB37l1jco2Nx7w+93sbAKp+C9A9EPzHgoIzg7NAgcO9ze3RCMh2AorwsSWSULh2G6YAjOG
	243/3x2ZAKva8+vQny0xff/wC5pf9dO75CTIz0Qw/WrgM3I3ZCfNlF1B+UsOLho1YtFsndeMPxJ
	msLqexhK3z9HtPhNkAoUn6TTOQe2rvLXufaeGMkUR/kQonkekpd5DM7H9j1pz40JeqYITFHlRLh
	vPIc0yVNlQ7ItPTQ7oTNewUX3u3HXCsY=
X-Received: by 2002:a05:7301:e10e:b0:35c:707b:acba with SMTP id 5a478bee46e88-35c707baed8mr14511624eec.3.1792155371201;
        Fri, 16 Oct 2026 05:56:11 -0700 (PDT)
X-Received: by 2002:a05:7301:e10e:b0:35c:707b:acba with SMTP id 5a478bee46e88-35c707baed8mr14511598eec.3.1792155370692;
        Fri, 16 Oct 2026 05:56:10 -0700 (PDT)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607ee0d391sm7195899eec.4.2026.10.16.05.56.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 05:56:09 -0700 (PDT)
Message-ID: <c9d04672-0099-478c-a774-cfa4fbc2afdb@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 18:26:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/7] tee: qcomtee: Add support for registering QTEE
 services on TEE bus
To: Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20261015-qcom_uefisecapp_migrate_qcomtee-v5-0-1460691b35d3@oss.qualcomm.com>
 <20261015-qcom_uefisecapp_migrate_qcomtee-v5-5-1460691b35d3@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261015-qcom_uefisecapp_migrate_qcomtee-v5-5-1460691b35d3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 4hon-eZz-KuFRVSsyvn3axjJr1j_VhjE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1MSBTYWx0ZWRfX3W2Gi4WGCyn2
 qc6JsXGPMs4Kfljybglt1vwBLQ23c7TxF8slxMjvMwgCoLv2DjPWJu6aEtZe1lvrwJmt0WcYJdD
 xBD25wNNmxUMxD3r4F0rjgeT9OYxl1g=
X-Authority-Analysis: v=2.4 cv=SrAFe/O0 c=1 sm=1 tr=0 ts=6ad21eec cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=7ituTzxtpmmrCW-Ko3oA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: 4hon-eZz-KuFRVSsyvn3axjJr1j_VhjE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1MSBTYWx0ZWRfX1FaJ88hlLal4
 Zc7RHZIs/NLtBdAorrDa/IvreoIgOlMONh35TXa32m9ZiZZ9fEVv/FsC6+hOwRCMtCBCng9YMz0
 DTjaZFjSRNK7mrA8Wq7Y2AAIrMEZR3aSFIswArbC6qZoXz7877YXS/6bVLKRnz+7CXGw39an0bW
 xVixufdwj0dXFvvg7YgievKeLlkLXJPUX8pmQ6vWhKUOdPpXSWauTpJB4oLC6D8RBU/Kr+M9Kgp
 m/ouuGvyPUvxcdJPLz09pr4G48u24ZBNlcC0NDr8fvMbsAvhtx0B7F/4P/RoYens7/auBML37gg
 1VmEKqCtdTOyck+czHfxWbynPTl0QgpJDssKP+y8riFkjpfIhA6UFj50k8LNf6YQgKcJnYWHmcf
 hYZeBtqPuTsJKYuX7ckYzNIu+OTPOCDUE83Q6JAFHHXorgFzVa3G8/Ti2PUN3FnX2khRMVj/0vx
 Q1t9Lfvzdq5bQtV7iNg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610160051
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.70 / 15.00];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	BAYES_HAM(-1.70)[93.15%];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.197:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[202.46.22.19:received,205.220.168.131:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4DE0243A5F
X-Spamd-Bar: ----
Message-ID-Hash: QNBZ2BJFV2MGTZPBJLVGTC3BCZMZWVJV
X-Message-ID-Hash: QNBZ2BJFV2MGTZPBJLVGTC3BCZMZWVJV
X-MailFrom: kuldeep.singh@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/QNBZ2BJFV2MGTZPBJLVGTC3BCZMZWVJV/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Kuldeep Singh via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

On 15-10-2026 17:09, Harshal Dev wrote:
> QTEE exposes certain secure services implemented either within the QTEE
> kernel or via pre-loaded Trusted Applications (TAs). Such always-available
> services can be readily accessed by TEE client drivers via QTEE's
> object-IPC protocol if the service is registered as a device on the TEE
> bus.
> 
> One such service is the EFI-variables service, implemented by the
> uefisecapp TA which enables kernel clients to access EFI variables at
> runtime.
> 
> Maintain a static list of such always-available secure services and add
> support for the QCOMTEE driver to register these services as devices on
> the TEE bus during probe.
> 
> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>

Tested-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com> #on Glymur-crd

-- 
Regards
Kuldeep

