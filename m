Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC5FCA5FF1
	for <op-tee@archiver.kernel.org>; Wed,  7 Oct 2026 13:45:22 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8C7BF454AF
	for <op-tee@archiver.kernel.org>; Wed,  7 Oct 2026 13:45:21 +0000 (UTC)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 10ACB43730
	for <op-tee@lists.trustedfirmware.org>; Wed,  7 Oct 2026 13:40:50 +0000 (UTC)
X-QQ-mid: zesmtpsz4t1791380416t8179b403
X-QQ-Originating-IP: PWpttXQ3DOBp5n0jZQWtZkD4nf5QeEN4Sg0ISfK7Tas=
Received: from [127.0.0.1] ( [180.159.160.209])
	by bizesmtp.qq.com (ESMTP) with
	id ; Wed, 07 Oct 2026 21:40:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9570977485540682427
Message-ID: <401F87C23DE9A910+997f9376-6810-4066-ae0a-686af834c0bd@radxa.com>
Date: Wed, 7 Oct 2026 21:40:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Add TPM support via Qualcomm TEE TPM TA
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
References: <20261001055029.1960743-1-zeroknots@protonmail.com>
 <0c6d29ce-920a-4566-9a4f-a0687b0e5ddc@oss.qualcomm.com>
 <b2xdth3hkuypnvxlrgssnj4toffbceohhnh7w2ju46fzinflfd@qaq6ai5plolq>
From: Xilin Wu <sophon@radxa.com>
Organization: Radxa Computer (Shenzhen) Co., Ltd
In-Reply-To: <b2xdth3hkuypnvxlrgssnj4toffbceohhnh7w2ju46fzinflfd@qaq6ai5plolq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OQNQM5UP8StMrhpdw91u533Bb5Ceepdsc8Zx6HmiHW2tSz+l4vqVDCEk
	sJHB9py06Tl6C+//3WL5VMpqzzypNYGUN6/y6qFAQCEdICs5pFMfmQ4FNpt95Zprmf3Hj4K
	Ncw/zh/4DIEaGuPK44XI6yc7V6lwWfk4Ml62lLX1jJyRNQX7Lr3gNBlwr/yoah6uhgOgWxF
	wIB2PQBBb1lNzEPjK0O6wkIn+H+LBixn9DVfeoMd0xAXWgJzE+/SolSLZr9WIffPCzwai2a
	BU3HEEQJ+GxKpWIoSM98uoJqh43U2Bd+JZ8bhAlOm7ZceyRIS3nOdRFiDvv39OLW5Fz3fRy
	f9D+VHGNrsc54JcmSwq7YpWXOBKhAdyab1PaAPwCj/aFI5Bhn4/9u+HmL+e+qEh/LjQR57U
	ZuqufE1tineiXC2MITe40Z+MWJQhHIDZ/PjfwQBTakIk5Gz3xks0jqEX2NpMKSAXUagQdEw
	8FR8yl/r90fNOqDv4ZDsPVhrTmZnfXaDLxCD0tkyyxTDuynIGtxK5Z4HmSZWhYIotylhXFl
	BOofoTQMdPVSLmEIuBsGgDE22VmfYZ2zHHW/fv0qFHznRH32b4bOanq9vmerww1VB5K7vHe
	ViRssivMmmUigaFqqVx66JaRNtulvfHhP7JUcZXIRjve4wOGptDCk4+UCl4+4Uak6+Hjpfk
	NgyoYQ+Poinrhe7TpgBEJ/SNREb3VRf/leP6oMFNV9gllFz7kYxRULFav67A4l1g1MCeD1T
	4H3tZTBr8D4RAOki9R/UYJo0ZIf7chLrBMp4oCWVu9qOK6bXoLH+6Y2NTFYPHNdmFQA18Kx
	x5BY9iNggknN7ctoN2xjPua5YfmelSEhbupKaVj+kaDsGthog6ZQl39YxBOdLm55xR0Jdqv
	mP1WgO7D3DEtppKZ2LYkWmznelUE22HJf3ub3G0rjh4wFhmr70G1bRzIaIXbFIeRcrM8GoI
	ytO6vwnTAscu2xTSRnoya0GvVnMSmGAQe5aEmCA7cTUuEik8D8F0Jm0SM2TZDLc4+OWwNvR
	K2IoJvMQ==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.10 / 15.00];
	BAYES_HAM(-3.00)[99.98%];
	FORGED_MUA_THUNDERBIRD_MSGID_UNKNOWN(2.50)[];
	DMARC_POLICY_ALLOW(-0.50)[radxa.com,none];
	ONCE_RECEIVED(0.20)[];
	R_SPF_ALLOW(-0.20)[+ip4:54.207.19.206];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[protonmail.com,oss.qualcomm.com,kernel.org,ziepe.ca,vger.kernel.org,lists.trustedfirmware.org,gmx.de];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.996];
	RCVD_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[54.207.19.206:from];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:16509, ipnet:54.207.0.0/17, country:US];
	RWL_MAILSPIKE_POSSIBLE(0.00)[54.207.19.206:from];
	HAS_REPLYTO(0.00)[sophon@radxa.com]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 10ACB43730
X-Spamd-Bar: -
X-MailFrom: sophon@radxa.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: X67FEOTZANQDV7FVFJWTXWSSOJANHWTO
X-Message-ID-Hash: X67FEOTZANQDV7FVFJWTXWSSOJANHWTO
X-Mailman-Approved-At: Wed, 07 Oct 2026 13:45:16 +0000
CC: zeroknots <zeroknots@protonmail.com>, amirreza.zarrabi@oss.qualcomm.com, jarkko@kernel.org, jenswi@kernel.org, jgg@ziepe.ca, linux-arm-msm@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, peterhuewe@gmx.de, sumit.garg@kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
Reply-To: sophon@radxa.com
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/X67FEOTZANQDV7FVFJWTXWSSOJANHWTO/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On 10/5/2026 3:24 PM, Dmitry Baryshkov wrote:
> On Mon, Oct 05, 2026 at 12:27:40PM +0530, Kuldeep Singh wrote:
>> On 01-10-2026 11:20, zeroknots wrote:
>>> Hi Kuldeep,
>>>
>>> A data point from retail hardware, in case it is useful for this
>>> series: on an ASUS Zenbook A14 UX3407NA (Glymur, X2E-88-100, BIOS
>>> UX3407NA.315) the TPM TA is not reachable as QTEE service 81, but it
>>> is present as the QSEECOM application "qcom.tz.tpm".
>>
>> Thanks for reaching out, Kindly check below.
>>
>>> With the qcomtee driver on a 7.3-rc3 based kernel, QTEE reports
>>> version 5.2.0, and service discovery finds neither 81 (TPM) nor 413
>>> (UEFI secure app). On the same boot, qseecom (version 0x1402000) works
>>> and backs efivars through "qcom.tz.uefisecapp" (app id 7). An app-id
>>> lookup for "qcom.tz.tpm" returns app id 1; a made-up name returns
>>> -ENOENT.
>>>
>>> The Windows driver for this machine agrees: QcTrEE8480.inf configures
>>> the TPM service with AppName="qcom.tz.tpm", SecureApp=1, LoadApp=0
>>> (preloaded by firmware). The EFI configuration table carries the
>>> TPMEventLog and TPMFinalLog entries, so the firmware TPM is active.
>>>
>>> Through that app, using a QSEECOM transport (based on Xilin Wu's
>>> out-of-tree SC8280XP driver: QUERY_INFO_2 / SEND_COMMAND with a
>>> CRB-style control area, here at 0x81d10000), /dev/tpm0 works: TPM 2.0,
>>> manufacturer QCOM, vendor string "xCG fTPM", firmware 0x40000, real
>>> PCR 0-7 values, GetRandom, ECC and RSA-2048 primaries, sign and
>>> verify, and a sealed object that persists across reboots.
>>>
>>> So, as far as I can tell, retail Glymur laptops may ship firmware on
>>> which this driver finds no TPM, while the same TA is available over
>>> QSEECOM.
>>>
>>> The same applies to the prerequisite series that moves uefisecapp to
>>> QCOMTEE [1]: on this firmware service 413 is absent and EFI variables
>>> work only through the QSEECOM uefisecapp. If the QSEECOM path were
>>> dropped for Glymur, efivars would stop working on this machine, so it
>>> would be good to keep it as a fallback when the QTEE service is not
>>> found.
> 
> No, the existing paths are not going to be stripped.
> 
>>>
>>> Two questions:
>>>
>>>   - Is service 81 expected to appear on retail firmware through an
>>>     update, or is it specific to the CRD firmware?
>>
>> Yes, there's spinor update(bootfw2.mbn) needed which is in progress to
>> publish as QTEE side changes were already merged long back.
>> Roughly it takes ~1month(ideal scenario) to get firmware changes
>> available but somehow it's taking more this time.
>>
>> I think i should have captured this dependency info in my series cover
>> letter to avoid any confusion.
>>
>> With the changes, service uid 81 will be available and won't see qcomtee
>> driver issue log there.
> 
> You are responding to the user who uses a COTS commercial device. Are
> you suggesting that the user can somehow update the firmware on that
> device?
> 
>>
>>>   - Would you consider a QSEECOM-based path for such firmware? I am
>>>     happy to test this series, or any other service UID you would like
>>>     checked, on this machine, and to share the transport code.
>>>
>>
>> Qseecom-based firmware path is not recommend approach as it's not
>> generic and less scalable leaving less room for expanding featuresets.
>> qcomtee uses mink-ipc based model which does all interaction with TA
>> with just 2 scm calls and is very much scalable compared to qseecom.
>>
>> So, we are planning to use mink-ipc based qcomtee path only and I'll
>> drop an update once QTEE firmware changes are available in meta builds.
>> I'd be happy you to try it out and give any suggestions!
> 
> I feel it really sad that the team (again) ignores existing available
> devices. Yes, QSEECOM is legacy, etc., etc. However we must make sure
> that devices are being sold can be used.
> 
> I guess, at this point, the best course of action would be for Xilin Wu
> to submit the QSEECOM driver upstream. Xiling, could you please do it?
> 

I'm also sad to hear that the proposed qcomtee path isn't even supported 
on Glymur, and yet the Qualcomm team is ignoring QSEECOM, which is used 
on all the devices currently being sold. I might submit the driver 
upstream, but I can't promise anything.

-- 
Best regards,
Xilin Wu <sophon@radxa.com>

