Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A34EDF148
	for <op-tee@archiver.kernel.org>; Fri, 13 Feb 2026 11:19:07 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9A96243811
	for <op-tee@archiver.kernel.org>; Fri, 13 Feb 2026 11:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1770981546;
	bh=DAHZXmGKskaOy2r111t3zta2sC+sHwOgIrSBB1W5Zck=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=ca2lzEBDMVnJhT5hLxohd5lQrKd+5d0jMJLeFFcLiA8nuXHXcb7w6cckOc2t8RA6b
	 ADesSqkoVGkgw2dHlZcbyTRPZs/bP8mwJ8NRHpHT4GQ92ezivVwxAwUaXT0q3v8Dbh
	 Qm2QGARnBjZbO3opc9Qdp3s1adbIhAtsGHMz4RW0g7PP5vEVHYq3/jSdBwVd9Qk8Rt
	 d8bt4csrHRX49gRLSJ9Fhn/rfVOLmby3F1oPy+av+2eYIUymGB1YvXhnuUkIcSkiYm
	 5iKJV45OHTA7kpw80uWp7jD2rOBdmNt5p7r4GKNtZuFIFr6qh8LTzLY6aWEpYSDakA
	 eFprNijuYnSNA==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id EF4FF43149
	for <op-tee@lists.trustedfirmware.org>; Fri, 13 Feb 2026 11:18:46 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=anP73G3y;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5232244230;
	Fri, 13 Feb 2026 11:18:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89768C116C6;
	Fri, 13 Feb 2026 11:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770981526;
	bh=DAHZXmGKskaOy2r111t3zta2sC+sHwOgIrSBB1W5Zck=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=anP73G3yhGpqMKjglTP+aDuAD4chFGOsVX3RU3k8mX9cOBh8a/+f9E+WGVE02DR1k
	 TxBt9ONlXrtTB+dlLHhIcnSvFFHcLfl4a8MJNvShvoKxjvj4HdNrdMDstZaFfeJ1kp
	 torszmr6DQ2obosXiF2HND76xGSSpC0s+A5Uue+uayaQmHfcpnxghulr6zN6s1aAGb
	 iZTvOI2AHQ6gXc9kc/r2EIu5We+2DDcrKZYZq7lfX+WtK8VEPAwRf2l+IpTIRO2ZB/
	 qPUp7rRqOlOSqw8i9uAc6hYls/6GhrXRCwR/UVAwZnAmj76T7+lk/ZF/NUexFFFDtw
	 PLa1U8UkwfPAQ==
Message-ID: <e52815b1-485d-4516-9448-1614f814981d@kernel.org>
Date: Fri, 13 Feb 2026 12:18:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] arm64: defconfig: Enable QCOMTEE module for
 QTEE-enabled Qualcomm SoCs
To: Harshal Dev <harshal.dev@oss.qualcomm.com>,
 Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
References: <20260114-qcom_qcomtee_defconfig-v4-1-ec676311171f@oss.qualcomm.com>
 <b7985f86-1df7-439c-8c54-abcf693180d0@oss.qualcomm.com>
 <f8a0e9ab-2d11-4ac9-aa5a-f216b348f81f@kernel.org>
 <12582709-7dca-4f1a-99ab-8a21cd70f1c5@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <12582709-7dca-4f1a-99ab-8a21cd70f1c5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[renesas];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DWL_DNSWL_NONE(0.00)[kernel.org:dkim];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DNSWL_BLOCKED(0.00)[172.234.252.31:from,100.75.92.58:received];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: EF4FF43149
X-Spamd-Bar: --
Message-ID-Hash: IS2J5HSLHGFUZGXYPMDRZH3CBZ3ETUHD
X-Message-ID-Hash: IS2J5HSLHGFUZGXYPMDRZH3CBZ3ETUHD
X-MailFrom: krzk@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/IS2J5HSLHGFUZGXYPMDRZH3CBZ3ETUHD/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Krzysztof Kozlowski via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Krzysztof Kozlowski <krzk@kernel.org>

On 13/02/2026 11:56, Harshal Dev wrote:
> Hi Krzysztof,
> 
> On 2/13/2026 3:56 PM, Krzysztof Kozlowski wrote:
>> On 13/02/2026 11:24, Kuldeep Singh wrote:
>>>
>>>
>>> On 1/14/2026 1:49 PM, Harshal Dev via OP-TEE wrote:
>>>> All Qualcomm SoCs starting from SM8650 provide access to the Qualcomm
>>>> Trusted Execution Environment (QTEE) through the SMCInvoke interface,
>>>> implemented by the QCOMTEE driver. QTEE runs in the Secure World domain
>>>> on ARM64 CPUs and exposes secure services to Linux running in the Normal
>>>> World domain.
>>>>
>>>> This change enables the QCOMTEE driver as a module to support
>>>> communication with QTEE.
>>>>
>>>> QCOMTEE has been tested on a Qualcomm RB3Gen2 board by loading and
>>>> executing a Trusted Application via tests hosted at
>>>> github.com/qualcomm/minkipc.
>>>>
>>>> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
>>>
>>> Tested on rb3gen2 device and able to see driver load successfully.
>>
>> What exactly did you test? That a module can be built?
>>
>>>
>>> root@qcom-armv8a:~# lsmod | grep qcomtee
>>> qcomtee                32768  0
>>
>> Sorry, but that's basic of kbuild and module system.
>>
>>
>>> root@qcom-armv8a:~# rmmod qcomtee
>>> root@qcom-armv8a:~# insmod
>>
>> Not a defconfig testing.
>>
>>> /lib/modules/6.18.0-next-20251202-00002-ga8c3ce157925
>>> -dirty/kernel/drivers/tee/qcomtee/qcomtee.ko
>>> [  164.464598] qcomtee: QTEE version 5.2.0
>>> root@qcom-armv8a:~# ls /dev/tee0
>>> /dev/tee0
>>> root@qcom-armv8a:~#
>>>
>>> With that,
>>> Reviewed-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
>>> Tested-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
>>
>> You cannot test a defconfig.
> 
> I think these logs didn't convey the full picture. QCOMTEE driver holds
> references to objects and callback requests received from QTEE during invocations.
> 
> Being able to remove the driver without the the user thread being stuck helps
> test that the close_context() callback which calls into QTEE to release all pending
> objects and callback requests held in qcomtee_context_data is correctly implemented
> by the driver.
> https://elixir.bootlin.com/linux/v6.19-rc5/source/drivers/tee/qcomtee/call.c#L600
> 
> Before this patch, I believe the driver was being compiled with CONFIG_QCOMTEE=y
> so the qcomtee_remove() function path wasn't being exercised.
> 
> Perhaps we can provide more logs (rmmod attempted after running direct invocation
> tests) to convey that this is what we are testing here on the RB3Gen2 board.
> 

I do not see at all how you address/respond to my comment.

Best regards,
Krzysztof
