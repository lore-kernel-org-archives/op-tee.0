Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3192FE7BD8A
	for <op-tee@archiver.kernel.org>; Mon, 16 Feb 2026 10:39:45 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7ED284386E
	for <op-tee@archiver.kernel.org>; Mon, 16 Feb 2026 10:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1771238384;
	bh=cMXN4VQHbNnT4KtvgEG3filgpCyv150mZLQl8Lllfro=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=n6i6q3znffsSajLS8Wjo+yvKpwl+/CcMvorCodfQzWZZvbz+ZUtdLeznF10GqDGnw
	 n0ndV9UKf2q/QSTHHnxVMUwFEmtk25J9Au9ZdjLdSUxnC/ysT4oIxMEfbgNixNF7n9
	 JfT2/fFllTJ+ZRIAUZdJkCl0mwGoSOj41zjAHtrI100nZa5MxiedaBO+s6OZ17czSY
	 6NjgXMnbHYGYxhDgMH18+hMUbALWbN3LYM6XkHr9kyNL7hk2HNoaqpw8q5LhSuXoqc
	 xiwC1gwJ83X4fetBHTn8ZWqYBTrkzLfBQlhSoKsHNH2YpZ5zhncjrGt6ueSggGJQUF
	 AmkRLyPZyOpIw==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3274643848
	for <op-tee@lists.trustedfirmware.org>; Mon, 16 Feb 2026 10:39:26 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Xy+Om1Xu;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id ACE0A600C4;
	Mon, 16 Feb 2026 10:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D844C116C6;
	Mon, 16 Feb 2026 10:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771238365;
	bh=cMXN4VQHbNnT4KtvgEG3filgpCyv150mZLQl8Lllfro=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Xy+Om1XuZIGQeCSYwRgIALrucss/O+hqJ33rI5XKTbt9Xsgp3Jct4SzM7m+tJYCfn
	 0sk8CzKNQkpOrNPPLphTBhw/ZUOs60WU4edDn2/N1gHA/uH7d803f2wkLUvfBOajpB
	 XgGkWEViy3+KVtDw99pNtdqKHlc6jWubCrsZcnGol4PKHRQKpcMBEZ3PYCNYZzGomn
	 b4rKpW0GeXXsvb1DZ0e5Zv1DycReZ/am68xVoT8baPWeKB2TEMyCGcQY9dCeHSkYnQ
	 ylQDk28AgGUBzfc6I5FI/2jWV0nIXhdKJoHBeAfTgN54NvesudK3YF7xsJd8cT3rfj
	 a08XmG/aiy1Vw==
Message-ID: <7d4006b0-8fcc-4e31-abfc-98ca8bf3bc2f@kernel.org>
Date: Mon, 16 Feb 2026 11:39:20 +0100
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
 <91ccacf3-68cf-4bfe-879a-db515a6732ec@oss.qualcomm.com>
 <804c0c03-d461-4fd9-ad0f-be123b3f1798@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <804c0c03-d461-4fd9-ad0f-be123b3f1798@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	TAGGED_RCPT(0.00)[renesas];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_NONE(0.00)[kernel.org:dkim];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 3274643848
X-Spamd-Bar: --
Message-ID-Hash: 4KXP55S2HXE5H4NQUEQI4JAO4G6UR4BE
X-Message-ID-Hash: 4KXP55S2HXE5H4NQUEQI4JAO4G6UR4BE
X-MailFrom: krzk@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/4KXP55S2HXE5H4NQUEQI4JAO4G6UR4BE/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Krzysztof Kozlowski via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Krzysztof Kozlowski <krzk@kernel.org>

On 16/02/2026 11:36, Harshal Dev wrote:
> 
> 
> On 2/16/2026 10:48 AM, Kuldeep Singh wrote:
>>
>>
>> On 2/13/2026 3:56 PM, Krzysztof Kozlowski wrote:
>>> On 13/02/2026 11:24, Kuldeep Singh wrote:
>>>>
>>>>
>>>> On 1/14/2026 1:49 PM, Harshal Dev via OP-TEE wrote:
>>>>> All Qualcomm SoCs starting from SM8650 provide access to the Qualcomm
>>>>> Trusted Execution Environment (QTEE) through the SMCInvoke interface,
>>>>> implemented by the QCOMTEE driver. QTEE runs in the Secure World domain
>>>>> on ARM64 CPUs and exposes secure services to Linux running in the Normal
>>>>> World domain.
>>>>>
>>>>> This change enables the QCOMTEE driver as a module to support
>>>>> communication with QTEE.
>>>>>
>>>>> QCOMTEE has been tested on a Qualcomm RB3Gen2 board by loading and
>>>>> executing a Trusted Application via tests hosted at
>>>>> github.com/qualcomm/minkipc.
>>>>>
>>>>> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
>>>>
>>>> Tested on rb3gen2 device and able to see driver load successfully.
>>>
>>> What exactly did you test? That a module can be built?
>>>
>>>>
>>>> root@qcom-armv8a:~# lsmod | grep qcomtee
>>>> qcomtee                32768  0
>>>
>>> Sorry, but that's basic of kbuild and module system.
>>
>> Yes, did a basic testing only.
>>
>>>
>>>
>>>> root@qcom-armv8a:~# rmmod qcomtee
>>>> root@qcom-armv8a:~# insmod
>>>
>>> Not a defconfig testing.
>>>
>>>> /lib/modules/6.18.0-next-20251202-00002-ga8c3ce157925
>>>> -dirty/kernel/drivers/tee/qcomtee/qcomtee.ko
>>>> [  164.464598] qcomtee: QTEE version 5.2.0
>>>> root@qcom-armv8a:~# ls /dev/tee0
>>>> /dev/tee0
>>>> root@qcom-armv8a:~#
>>>>
>>>> With that,
>>>> Reviewed-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
>>>> Tested-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
>>>
>>> You cannot test a defconfig.
>>
>> Sure, we can drop tested-by tag.
>> Maybe patch author once send next rev can just add Reviewed-by tag only.
>> Hope this is fine.
>>
> 
> I am fine with us dropping this Tested-by tag. I thought it made sense to test that
> the driver being built as a module is removed without encountering any issues.

We do not talk about this. No one claimed that this test is good or not.
Read again discussion - there was no test of this defconfig change. It
did not happen as it cannot happen or is completely pointless. The tag
applies to THE COMMIT not to something else. I explained this way too
many times.

> I will not send another patch revision just to collect/drop tags.
> 
> Thanks,
> Harshal


Best regards,
Krzysztof
