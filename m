Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A429CA5FD2
	for <op-tee@archiver.kernel.org>; Thu,  1 Oct 2026 20:27:29 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 855C5451D6
	for <op-tee@archiver.kernel.org>; Thu,  1 Oct 2026 20:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790886448;
	bh=wVmEFIDLQvEJ1Un315FMH1sKflA3HdQiFPaRfBWSbCE=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=UkTARJkrXpQNjdvmGfNsVuFFLvt4ciIzbsqIoVnMqAKkSvmiBL2ocaFXajKrLQkTu
	 kqhFNhHYTArtYZf6HuNfQHfLpIZW8fFJOAV9qBscZxiEhpHk5ot64drz9y+N+OAIK2
	 4JCyUwmyi+2ah74XlUSf/wuzSGDwIzdp2MV+U+lMcSxRiBuwhRr57YzotgSz+XBsOL
	 jIRtCeVwjOYLmIuYGTbJX2gz4PGdVdvt5pdKCKSR+jDAHMK3nkF8Ab2TuHf1rShlwg
	 gxccOtMhgvQylgE3pHXSE+7XImtxbHC++5eYxIlIcggM3EhBU0dgKZsTh7IC0Rkhyd
	 c+63xC9eAnUsw==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 09B1D44F7B
	for <op-tee@lists.trustedfirmware.org>; Thu,  1 Oct 2026 20:27:21 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Lv/W6Kls;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d0XBZqy3;
	dkim-atps=neutral
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691FsdAV3109251
	for <op-tee@lists.trustedfirmware.org>; Thu, 1 Oct 2026 20:27:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GWv0CTeZ2vuMvNSD1JU+sMxbnaSK0ikbtxrvqbpR3Rs=; b=Lv/W6KlsSr9yxAAn
	dIhtQW+4fOCWHSoO4mKFjwSH183LXVWCVQYci4MBw814SIY/fUZtOlKKvwnFcaiO
	Pz16z+0GWLgaC/4miTtjHNtdxcyNBam/+JMVqXV0mxDEgEUn0SgXMKhPDl261sIp
	iWcwPxnyamU3FwREfmG/2fNLQRgHLxKSDInF+OKVA5YhDHLJW8CefDRS39b1Cc5C
	1TdxYxkerQijPeKKDpZQ+/P57cV5GlO6cq0Za6SnQTwyCybHQmPLsVcdD4RZBBe+
	ZcuGooTQcaIv3eexa9JODYKQWetQvkNqPkcVkGaWuwcrjJdZh2ylV4JPxypgEkRX
	uyUu+A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1jcfumbw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 01 Oct 2026 20:27:20 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3a46f0f158dso1448417a91.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 01 Oct 2026 13:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790886439; x=1791491239; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GWv0CTeZ2vuMvNSD1JU+sMxbnaSK0ikbtxrvqbpR3Rs=;
        b=d0XBZqy32yY83uZiO14HEfoeKN35slNyu9vuOTehHqHDaObE2g9VgEu6F4bsg1Wctc
         lwch2OiX0l42w7hCM66LWL+GQcj1hMENm06U2NG8gMdT0f1ZUsISjbMY7RRBSnUaEdbG
         tUnw021r0lxMwWW/OQxuwvovK1c33gW+gbCUH/6CW6e6UuX/xGQY9zwAWs9FL6JQe6Oh
         CRywuNini/opgTX9M9PMUVnKe1eTzIo94K4WWp013xXZsD+FNRMrqUSQB2sGJRxAaA9y
         Cmb/kP1w11M4cDYjvB9/u5eU8sLC5dSM+7A7T4gYEYidwieGRQMdc+DHsEsWdu03oLAA
         HZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790886439; x=1791491239;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GWv0CTeZ2vuMvNSD1JU+sMxbnaSK0ikbtxrvqbpR3Rs=;
        b=PwK3GJCO1XXN0B4vOPrnQv2C7O3XFeD9Db+hjdAJFbZ+s72+AGhE4axtBQqS/8vlB6
         p7IhOqQax0QH05PZCdQWpiH6oWTel9KHnVPzFnjQbceu77erdfitlt2u9rgfWLd5283o
         SZ+NmBHKfeiw+Z49lwy7MOUrLta45wIsUPHBWhe4G0vvron1egFBXY/xqUMIgDywC7Eo
         gQJfvF0rCi8ypXGORZPDbNwezsh/ykeRAMRnPq7i51AdQ3x9/UvqNyGzdwrMwtu0FeZe
         VtYkWpGIPLU9VhMqFhmg9PYVQMgoddFnX99PQDmhYBF6Wfnh/U9287EAZKzKQJlpUbQs
         8cuw==
X-Forwarded-Encrypted: i=1; AKwUvBzRXzRauT1jYC/P48FKbyNZ/+6nNchXFzP6zcdD/Ohcixj1dxCo39vf3+CG9wQBEQ1wWshZaLk=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYIXJm46AXtKnU8BubsHI/juaIubrvKHINjhEmZMw7eCnqL3nEgM
	g5jwm50HGnubKTUewub8fneCnBiU/ti7fGHJLXx42m8qfPS1lE1C8PaVqDv89yUdy1oqsybWWyI
	5ZDvXfLBdNFBcKX36BicNRUC8/GbINc/ZnRdEXAMjAm0kITlPHoTwsKfwLgI4beMB69Tfe2E=
X-Gm-Gg: AYBFou2b2NriLuSoV+VafCw/Rcw2esgcQb7NHX8JA2YbfP1wJ8KKtp6/jS4riOcFhaM
	2MYo9AWNsz2ypshS3ZABOqwh8DHS/bCMDv3t/9P3rxW5Y2likOa2y2UJs49y4QxxEcC4CN5IBRc
	atjVHBsy620jXBEaJal2+/8Q3eywM5Gttx9xLNXgPS4ugHbPyvTbt/+yrS1mzyAiIrDgJtNxFOe
	J9OTh5yWeqodWWExZNgfjL/z440AZZf8pnOTKwxG9o3wIjW39rgSCT22Bm0OwepOnJsmE4cpOp9
	AVv4QC/ZVFx2kEVrxS03YA6BKcaGPblRJjX2x6T+eYwaJF1nI9tvLnDBs0L3ugx9i9L4ECpkPqj
	pP29k+rIB8w8teuZH6UiCFH6R3+hHUrfh
X-Received: by 2002:a17:90b:4ac6:b0:3a4:c673:764a with SMTP id 98e67ed59e1d1-3a6cecac6b7mr358817a91.42.1790886439202;
        Thu, 01 Oct 2026 13:27:19 -0700 (PDT)
X-Received: by 2002:a17:90b:4ac6:b0:3a4:c673:764a with SMTP id 98e67ed59e1d1-3a6cecac6b7mr358807a91.42.1790886438569;
        Thu, 01 Oct 2026 13:27:18 -0700 (PDT)
Received: from [192.168.1.86] ([206.83.119.45])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f439f9f9sm5933422a91.1.2026.10.01.13.27.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 13:27:17 -0700 (PDT)
Message-ID: <27748440-8d0c-4163-bc73-842b77791017@oss.qualcomm.com>
Date: Fri, 2 Oct 2026 06:27:12 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] tee: optee: build the Arm-specific code only on Arm
To: marouene.boubakri@oss.nxp.com, jenswi@kernel.org
References: <20260924105145.532787-1-marouene.boubakri@oss.nxp.com>
Content-Language: en-US
In-Reply-To: <20260924105145.532787-1-marouene.boubakri@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA4MSBTYWx0ZWRfXz/99wLsWdJEi
 a3QcMsErBPKFBhbPujSBI7tFZWEWAUrfmd/hL2lo2ge83POdKtHEP+FB0TRxRPg2hcZGcGJF5Pe
 +S70CO6SvjsuUrZS+ANia8miiL62bBs=
X-Proofpoint-GUID: L-899rcsq72KY6Oy38ImfIH9d61Vzsjq
X-Authority-Analysis: v=2.4 cv=b4YncdGx c=1 sm=1 tr=0 ts=6abec228 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nLoy2YM07uCa/jC45NrMpw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=8AirrxEcAAAA:8 a=uypRWGK5JkTHnb3kk54A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: L-899rcsq72KY6Oy38ImfIH9d61Vzsjq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA4MSBTYWx0ZWRfXw80faK/xtcvO
 80WPM8EQrr+s6ymo2M3MbeN3F8Cf8MPTzdsNbTgeOfL7HEYyg76jcbLZGFIN82Z4f448rVL+1uU
 EnXK9al2/AiYey89KUn64jqdTf/DasC/aqb3CYyRMH+56Azg/rAzJWo5m/wS51VY7TLNvTzOnlO
 AtxAzhMfGB79roDz3uN5rcW2YTCpFPcyuGFdXmt2AAHoQNAOmaci7Tp6ZosSveQjykQW1oeccDU
 X6hieoGXCHM1uBbFQRoB+W1Mupi5erNnYfmJYnHGPLz5w+tmLvFwocVqB4f4HvVzov1IHVErX8/
 wv3oCpwmegJECI4r50a+5Rr/ekWLXZMjBiM3oKvdFq5rD1DPFtS8ZNTEz9E4QSopaMEzJ58GPFn
 JUbhSWl9g+kyEG8InWVDBfkHCZXk7Slfo3YJX5fzP5c1AdsBh7yLjh9HlmAmxx4stlUMvgMUGkF
 R+rH0ieL25zrZx7HRMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010081
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DNSWL_BLOCKED(0.00)[205.220.180.131:from];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.72:received];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 09B1D44F7B
X-Spamd-Bar: ----
Message-ID-Hash: UVJC36FSUJLOPK24RLLNLWMYVJN6HOQL
X-Message-ID-Hash: UVJC36FSUJLOPK24RLLNLWMYVJN6HOQL
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: sumit.garg@kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, peter.lin@sifive.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/UVJC36FSUJLOPK24RLLNLWMYVJN6HOQL/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Hi Marouene,

On 9/24/2026 8:51 PM, marouene.boubakri@oss.nxp.com wrote:
> From: Marouene Boubakri <marouene.boubakri@oss.nxp.com>
> 
> The OP-TEE driver reaches OP-TEE through the SMC ABI or the FF-A ABI,
> both specific to Arm, yet builds both unconditionally together with the
> SMC Calling Convention definitions they rely on: ffa_abi.c is always
> compiled and only its registration is conditioned on
> IS_REACHABLE(CONFIG_ARM_FFA_TRANSPORT), and optee_private.h includes
> <linux/arm-smccc.h> and defines the SMC and FF-A specific types for
> every file of the driver. This is fine as long as the driver depends on
> HAVE_ARM_SMCCC, but it keeps the driver from being built for an
> architecture without SMCCC, such as RISC-V.
> 
> Build smc_abi.c only when HAVE_ARM_SMCCC is set and ffa_abi.c only when
> the FF-A transport is enabled, and provide stubs for their registration
> otherwise, so that it fails with -EOPNOTSUPP as the FF-A ABI already
> does when the FF-A transport is not reachable. Keep the SMCCC header,
> the SMC invoke function type, the SMC and FF-A specific structures and
> the SMC RPC register parameters in optee_private.h under the same
> conditions, and drop the unused <linux/arm-smccc.h> include from
> notif.c.
> 
> Make OPTEE depend on ARM_FFA_TRANSPORT || !ARM_FFA_TRANSPORT, as it
> already does for RPMB, so that the driver is limited to a module when
> the FF-A transport is one, rather than built in without FF-A support.
> ffa_abi.c is thus built exactly when the FF-A transport is reachable
> from the driver, and the IS_REACHABLE() checks in
> optee_ffa_abi_register() and optee_ffa_abi_unregister() are always
> true, so drop them.
> 
> OPTEE still depends on HAVE_ARM_SMCCC, so smc_abi.c is still always
> built. The only visible change is that OPTEE=y can no longer be
> combined with ARM_FFA_TRANSPORT=m: such a configuration now resolves to
> OPTEE=m, with the FF-A ABI available.
> 
> Signed-off-by: Marouene Boubakri <marouene.boubakri@oss.nxp.com>
> ---
> Changes in v4:
> - Make OPTEE depend on ARM_FFA_TRANSPORT || !ARM_FFA_TRANSPORT so that
>   the driver is limited to =m when the FF-A transport is =m (Jens).
> - Update the commit message accordingly.
> v3: https://lore.kernel.org/all/20260922131735.524635-1-marouene.boubakri@oss.nxp.com/
> 
> Changes in v3:
> - Dropped the RPMI ABI placeholder and the RISC-V enablement patches,
>   this is now a single patch (Jens).
> - Key the FF-A parts of optee_private.h on IS_REACHABLE() instead of
>   IS_ENABLED(): with OPTEE=y and ARM_FFA_TRANSPORT=m kbuild drops
>   ffa_abi.o from the built-in optee.o while optee_ffa_abi_register()
>   was still declared, which does not link.
> - Drop the now always true IS_REACHABLE() checks in
>   optee_ffa_abi_register() and optee_ffa_abi_unregister().
> - Describe the current FF-A conditional compilation accurately in the
>   commit message.
> - Posted as a new thread with a proper subject prefix.
> v2: https://lore.kernel.org/op-tee/20260915020235.507302-2-marouene.boubakri@oss.nxp.com/
> 
> Changes in v2:
> - No code change, the testing section of the cover letter was completed.
> v1: https://lore.kernel.org/op-tee/20260914175435.118303-2-marouene.boubakri@oss.nxp.com/
>  drivers/tee/optee/Kconfig         |  1 +
>  drivers/tee/optee/Makefile        |  4 ++--
>  drivers/tee/optee/ffa_abi.c       |  8 ++-----
>  drivers/tee/optee/notif.c         |  1 -
>  drivers/tee/optee/optee_private.h | 39 ++++++++++++++++++++++++++++++-
>  5 files changed, 43 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
> index 50d2051..891dac6 100644
> --- a/drivers/tee/optee/Kconfig
> +++ b/drivers/tee/optee/Kconfig
> @@ -5,6 +5,7 @@ config OPTEE
>  	depends on HAVE_ARM_SMCCC
>  	depends on MMU
>  	depends on RPMB || !RPMB
> +	depends on ARM_FFA_TRANSPORT || !ARM_FFA_TRANSPORT
>  	help
>  	  This implements the OP-TEE Trusted Execution Environment (TEE)
>  	  driver.
> diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
> index ad7049c..183cdde 100644
> --- a/drivers/tee/optee/Makefile
> +++ b/drivers/tee/optee/Makefile
> @@ -7,8 +7,8 @@ optee-objs += rpc.o
>  optee-objs += protmem.o
>  optee-objs += supp.o
>  optee-objs += device.o
> -optee-objs += smc_abi.o
> -optee-objs += ffa_abi.o
> +optee-$(CONFIG_HAVE_ARM_SMCCC) += smc_abi.o
> +optee-$(CONFIG_ARM_FFA_TRANSPORT) += ffa_abi.o
>  
>  # for tracing framework to find optee_trace.h
>  CFLAGS_smc_abi.o := -I$(src)
> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index 633715b..08236d8 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -1212,14 +1212,10 @@ static struct ffa_driver optee_ffa_driver = {
>  
>  int optee_ffa_abi_register(void)
>  {
> -	if (IS_REACHABLE(CONFIG_ARM_FFA_TRANSPORT))
> -		return ffa_register(&optee_ffa_driver);
> -	else
> -		return -EOPNOTSUPP;
> +	return ffa_register(&optee_ffa_driver);
>  }
>  
>  void optee_ffa_abi_unregister(void)
>  {
> -	if (IS_REACHABLE(CONFIG_ARM_FFA_TRANSPORT))
> -		ffa_unregister(&optee_ffa_driver);
> +	ffa_unregister(&optee_ffa_driver);
>  }
> diff --git a/drivers/tee/optee/notif.c b/drivers/tee/optee/notif.c
> index 6e85f2f..6801422 100644
> --- a/drivers/tee/optee/notif.c
> +++ b/drivers/tee/optee/notif.c
> @@ -5,7 +5,6 @@
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> -#include <linux/arm-smccc.h>
>  #include <linux/errno.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> index aefe1e6..02d6f79 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -6,7 +6,6 @@
>  #ifndef OPTEE_PRIVATE_H
>  #define OPTEE_PRIVATE_H
>  
> -#include <linux/arm-smccc.h>
>  #include <linux/notifier.h>
>  #include <linux/rhashtable.h>
>  #include <linux/rpmb.h>
> @@ -15,6 +14,10 @@
>  #include <linux/types.h>
>  #include "optee_msg.h"
>  
> +#ifdef CONFIG_HAVE_ARM_SMCCC
> +#include <linux/arm-smccc.h>
> +#endif
> +
>  #define DRIVER_NAME "optee"
>  
>  #define OPTEE_MAX_ARG_SIZE	1024
> @@ -42,10 +45,12 @@
>   */
>  #define OPTEE_DEFAULT_MAX_NOTIF_VALUE	255
>  
> +#ifdef CONFIG_HAVE_ARM_SMCCC
>  typedef void (optee_invoke_fn)(unsigned long, unsigned long, unsigned long,
>  				unsigned long, unsigned long, unsigned long,
>  				unsigned long, unsigned long,
>  				struct arm_smccc_res *);
> +#endif
>  
>  /**
>   * struct optee_call_waiter - TEE entry may need to wait for a free TEE thread
> @@ -119,6 +124,7 @@ struct optee_supp {
>  	struct completion reqs_c;
>  };
>  
> +#ifdef CONFIG_HAVE_ARM_SMCCC
>  /**
>   * struct optee_pcpu - per cpu notif private struct passed to work functions
>   * @optee:	optee device reference
> @@ -149,7 +155,9 @@ struct optee_smc {
>  	struct work_struct notif_pcpu_work;
>  	unsigned int notif_cpuhp_state;
>  };
> +#endif
>  
> +#if IS_REACHABLE(CONFIG_ARM_FFA_TRANSPORT)
>  /**
>   * struct optee_ffa -  FFA communication struct
>   * @ffa_dev:		FFA device, contains the destination id, the id of
> @@ -170,6 +178,7 @@ struct optee_ffa {
>  	struct workqueue_struct *notif_wq;
>  	struct work_struct notif_work;
>  };
> +#endif
>  
>  struct optee;
>  
> @@ -257,8 +266,12 @@ struct optee {
>  	const struct optee_ops *ops;
>  	struct tee_context *ctx;
>  	union {
> +#ifdef CONFIG_HAVE_ARM_SMCCC
>  		struct optee_smc smc;
> +#endif
> +#if IS_REACHABLE(CONFIG_ARM_FFA_TRANSPORT)
>  		struct optee_ffa ffa;
> +#endif

Does this need to be a union if we filter the members?

Best Regards,
Amir

>  	};
>  	struct optee_shm_arg_cache shm_arg_cache;
>  	struct optee_call_queue call_queue;
> @@ -290,6 +303,7 @@ struct optee_context_data {
>  	struct list_head sess_list;
>  };
>  
> +#ifdef CONFIG_HAVE_ARM_SMCCC
>  struct optee_rpc_param {
>  	u32	a0;
>  	u32	a1;
> @@ -300,6 +314,7 @@ struct optee_rpc_param {
>  	u32	a6;
>  	u32	a7;
>  };
> +#endif
>  
>  /* Holds context that is preserved during one STD call */
>  struct optee_call_ctx {
> @@ -422,9 +437,31 @@ static inline void reg_pair_from_64(u32 *reg0, u32 *reg1, u64 val)
>  }
>  
>  /* Registration of the ABIs */
> +#ifdef CONFIG_HAVE_ARM_SMCCC
>  int optee_smc_abi_register(void);
>  void optee_smc_abi_unregister(void);
> +#else
> +static inline int optee_smc_abi_register(void)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline void optee_smc_abi_unregister(void)
> +{
> +}
> +#endif
> +#if IS_REACHABLE(CONFIG_ARM_FFA_TRANSPORT)
>  int optee_ffa_abi_register(void);
>  void optee_ffa_abi_unregister(void);
> +#else
> +static inline int optee_ffa_abi_register(void)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline void optee_ffa_abi_unregister(void)
> +{
> +}
> +#endif
>  
>  #endif /*OPTEE_PRIVATE_H*/
> 
> base-commit: 827751b699b79a6e569983359c02dce67f81b94c

