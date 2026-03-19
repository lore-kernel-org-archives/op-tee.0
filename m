Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEED0108E1E2
	for <op-tee@archiver.kernel.org>; Thu, 19 Mar 2026 10:42:27 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id DB34143ACB
	for <op-tee@archiver.kernel.org>; Thu, 19 Mar 2026 10:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1773916947;
	bh=aJWa94CtA9j8mAxqF/xpiC4QvlVH32SKPSkyFhKrjJY=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Jn2bJTySZckMhOlmVPAPj6Tx9yvUQgBaag5hgGlpbPInIx7snGWZPlQv67JNzKNxc
	 +RNYpoOQaU9t1j14+XQmC5mOSdlutJ4dTxkg4VjzNnE4YYB23gArU+AC46kexTNjBU
	 0Lup+1mRui7MBnLAQe0FderXW5r1zD5PQK0DrbVggZxweCTUCXXGBbsZTmlVdj1ujT
	 khKDEerdPbw88QZOp3K+0YSRrZZY/b/Bnwi/EFrMnS5p7AOQVrYg8X90qqMEVnoxTC
	 wWtqzj+ZrJFcOPO5ktM+pnb6MtXeu0H9HQa6FdXdPl9YDGMy1yEPSnYdMWSZWztr7M
	 SYGoNqp/BzxBA==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id ED52C4383D
	for <op-tee@lists.trustedfirmware.org>; Thu, 19 Mar 2026 10:42:04 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uel6/ql+;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1FE4D4072B;
	Thu, 19 Mar 2026 10:42:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC83C19424;
	Thu, 19 Mar 2026 10:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773916924;
	bh=aJWa94CtA9j8mAxqF/xpiC4QvlVH32SKPSkyFhKrjJY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uel6/ql+pRfFm5jj4EAWzusvayTD9UKGYdJKZpdUNDWTM9gCB65uPPjSXy890p0Zl
	 rlVLyO9LBJ7/0YVY3KV4/YpIL71uXYJsTMXSlKbxPt2rvKrIJXVC2Y4MA8YUca2m7H
	 iwobC4JQIiqy2xL0t0iAlS8fugXg4/VmQVKPWKY92ddK+o1qWf0hpSudCYUs8a3j8U
	 mVi9YDAdVLHw1oHj0H0e6xVri9q6ddRqDbvFnLUCmc1/Q3eaUhZeT2uux0UFoi0THD
	 mGFTqQsqBfDsa34l68AAYFnZO+DrXcxZkeFoBbGnm3Vi4sO9KUJ2qRshdUmOGiky25
	 grOO0Aryv0V7g==
Message-ID: <0068d43a-e875-4f4e-aff6-3e8330e66c82@kernel.org>
Date: Thu, 19 Mar 2026 11:41:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 2/6] dt-bindings: remoteproc: Add STM32 TEE-controlled
 rproc binding
To: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
References: <20260317180329.1207625-1-arnaud.pouliquen@foss.st.com>
 <20260317180329.1207625-3-arnaud.pouliquen@foss.st.com>
 <20260319-glistening-ultramarine-ibis-1eb3d6@quoll>
 <420953af-6a12-4277-8c31-062db01f78cc@foss.st.com>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <420953af-6a12-4277-8c31-062db01f78cc@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[dt];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DNSWL_BLOCKED(0.00)[172.234.252.31:from];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: ED52C4383D
X-Spamd-Bar: --
Message-ID-Hash: DTYXKUR6OIB7NX73X7VCVLGJ47BCDSAX
X-Message-ID-Hash: DTYXKUR6OIB7NX73X7VCVLGJ47BCDSAX
X-MailFrom: krzk@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/DTYXKUR6OIB7NX73X7VCVLGJ47BCDSAX/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Krzysztof Kozlowski via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Krzysztof Kozlowski <krzk@kernel.org>

On 19/03/2026 11:31, Arnaud POULIQUEN wrote:
> Hello Krzysztof,
> 
> 
> On 3/19/26 09:06, Krzysztof Kozlowski wrote:
>> On Tue, Mar 17, 2026 at 07:03:23PM +0100, Arnaud Pouliquen wrote:
>>> Add a Device Tree binding for the STM32 remote processor controlled
>>> via a Trusted Application running in OP-TEE.
>>> This binding describes the interface and properties required for STM32MP
>>> remoteproc instances managed by the TEE rproc service, including a
>>> linkage to the TEE backend through the property "rproc-tee-phandle".
>>>
>>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>>> ---
>>> V21 updates:
>>> - the m4 node is no more declared as a child of the optee-rproc node
>>> - "rproc-tee-phandle" property is introduced to reference the optee-rproc
>>> ---
>>>   .../remoteproc/st,stm32-rproc-tee.yaml        | 108 ++++++++++++++++++
>>>   1 file changed, 108 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/remoteproc/st,stm32-rproc-tee.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc-tee.yaml b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc-tee.yaml
>>> new file mode 100644
>>> index 000000000000..ca4dd1c8e7b0
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc-tee.yaml
>>> @@ -0,0 +1,108 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/remoteproc/st,stm32-rproc-tee.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: STMicroelectronics STM32 remote processor controlled via TEE
>>> +
>>> +maintainers:
>>> +  - Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>>> +
>>> +description: |
>>> +  STM32MP remote processor controlled by a Trusted Application
>>> +  running in OP-TEE. This node is a child of the TEE remoteproc service
>>> +  (UUID 80a4c275-0a47-4905-8285-1486a9771a08) and exposes a remoteproc
>>> +  instance managed by the Linux remoteproc core via the TEE rproc service.
>>> +
>>> +  Firmware loading, authentication and remote processor start/stop are managed
>>> +  by the TEE application. The STM32-specific driver handles platform resources
>>> +  such as the mailboxes and reserved-memory.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: st,stm32mp1-m4-tee
>>
>> Drop "tee", it suggests that compatible is tied to implementation of FW
>> you put there.
> 
> The "st,stm32mp1-m4" compatible string already exists in 

Then probably this binding needs changes, because in general you should
not have two compatibles for the same hardware. Maybe that's special
case, but then needs explanations in commit msg why is that.

> drivers/remoteproc/stm32_rproc.c, and "st,stm32mp1-m4-tee" compatible is 
> upstreamed in OP-TEE.

That is not our problem and strong no-go. Other projects are supposed to
participate in upstream bindings review and take the bindings once they
are reviewed and accepted here. If they take without review, it's their
problem.

Imagine that: some whatever project takes whatever crap (not saying
Optee is like that, just imagine for sake of discussion) and then you
send bindings to upstream and claim "that project took it, so you must
do as well". Great loophole to squeeze poor stuff to the kernel, so any
such argument is for me a warning sign.


> 
> Notice that I have also the stm32mp2 SoC to upstream expecting to have 
> similar compatible:
> - st,stm32mp1-m33
> - st,stm32mp2-m33-tee
> 
> Depending on the compatible string, the hardware behavior changes.
> With the "xxxx-tee" compatible, OP-TEE also manages the isolation of 
> remote processor resources (memory, clock reset, peripherals).
> Without the "xxxx-tee" compatible, OP-TEE have to ensure that the Linux
> has the good access right to manage the remote processor.

Still the same device, no?

You can have a property defining how Linux should access such device,
e.g. because FW does this and that.

> 
> For instance if st,stm32mp1-m4-tee is set instead of st,stm32mp1-m4, on
> linux side
> - only memory regions used for IPC should be declared
> - memory regions containing the remote firmware must not be declared as 
> not accessible by the Linux ( managed by OP-TEE).
> - resets must not be declared ( managed by OP-TEE)
> 
> You probably don't remember, as it was a long time ago, but we already 
> discussed this point with Rob[1].
> [1] https://lkml.org/lkml/2024/1/18/100
> 
> Do it still reasonable to you and Rob or should we find an alternative?

Get ack from Rob then.


Best regards,
Krzysztof
