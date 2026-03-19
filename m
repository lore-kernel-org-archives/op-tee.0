Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEF6108E1DD
	for <op-tee@archiver.kernel.org>; Thu, 19 Mar 2026 10:32:34 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 58FE643AC9
	for <op-tee@archiver.kernel.org>; Thu, 19 Mar 2026 10:32:33 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=axCQwfod;
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013066.outbound.protection.outlook.com [40.107.162.66])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 35D764383D
	for <op-tee@lists.trustedfirmware.org>; Thu, 19 Mar 2026 10:32:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C87/IlIQ/FEYUvXgJQBKweZw/0us3aYqyuXSaKVw1HJcEsm4G4TLm9hj+rYIPODcilYQ61EEt8uTfCJp9CTKPZ8I1m03ldWmPXI18DWvcu8osFQ5T8xDEOTAQ1XNuZva26pMbFmOHNzvgEIFyllTxbwRF5Z6+u5PBDK9uVCiXa+4yKJLO49DAQvgQoKZETI2YKLRuRKUsEqiIDX9RZlbC0Ah0HptNF842CttMt/qsGpyf1zejj9SscUT6kopTXjOev7ihREL3ziHtmifc/jvro1UllxC4TMRfamLUjWfEUsab8ebr+x9LvClvSOq+1PhiX+/aIk5eXHXfP609zeYDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHOAXXZ/eo+gGOneXEPPxRZItUraHv3c0j7lWTUMNnM=;
 b=ntIlwI9A8xG+Rs9Fh5mSG5NBJVLFwdn7L0Innr3hkS+2ddQinpunFgIwnLRKbH9ZXkjnQbSHSZXblTkl9b7I0rLug4hBCoiVMwLvLLPqrplT5gMlenlog1c8PV6WXPeYv5KMdBLCK7brdJFl6+ZqK6n/JVuYpbAmXees+GlZoKlJb4pjxp7DDMCLzSBiUcdlEfTHlYRJ7qmMmocg+iAwXpIBG9xHOE1bs3AURVyw9ksM208skG7/vsvBv0aj2JiVUjMdIV8zQYBLcQq5a12Ubs/7fahLw26Sf0iZ9ba8zf36CHCXP1ZSyqD7/q5N62bK9NjbUQ6o8vx6BlVyoblL8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHOAXXZ/eo+gGOneXEPPxRZItUraHv3c0j7lWTUMNnM=;
 b=axCQwfodDxLORO+5uFLO7+qUEDYS9GsBeN9XbMeqjYty9f7ep3Bea/QfQmJIN6dEzV2U2WOM+AubPUWYl1zKBfWLh7/3UBxYVdz3T9QX2GzfBF21k2ZH1zQndhRtpcQqxewfdALhubKWYaUagCgAjEisoEQW4LETZHEFTVilh6a/c0bTJZaadKivkMgt/iztjO7zn0/0eDWRQ3oSY2PIm3d7UWA4/lBTwhgzBbEL/wUqcO/yHgIYjqHXu5SQGBmgOy02IWQDt4VQZamJzgHRT52kVczyRVEZ15RT7VuXqQizAKXic7Im+Wz+o51lmVlV/9UNFbDW/tYvZpyVKMDWPw==
Received: from DB9PR05CA0026.eurprd05.prod.outlook.com (2603:10a6:10:1da::31)
 by DB8PR10MB3468.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 10:32:07 +0000
Received: from DU2PEPF0001E9C0.eurprd03.prod.outlook.com
 (2603:10a6:10:1da:cafe::52) by DB9PR05CA0026.outlook.office365.com
 (2603:10a6:10:1da::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Thu,
 19 Mar 2026 10:32:07 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU2PEPF0001E9C0.mail.protection.outlook.com (10.167.8.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 10:32:07 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 19 Mar
 2026 11:34:17 +0100
Received: from [10.48.87.127] (10.48.87.127) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 19 Mar
 2026 11:31:57 +0100
Message-ID: <420953af-6a12-4277-8c31-062db01f78cc@foss.st.com>
Date: Thu, 19 Mar 2026 11:31:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 2/6] dt-bindings: remoteproc: Add STM32 TEE-controlled
 rproc binding
To: Krzysztof Kozlowski <krzk@kernel.org>
References: <20260317180329.1207625-1-arnaud.pouliquen@foss.st.com>
 <20260317180329.1207625-3-arnaud.pouliquen@foss.st.com>
 <20260319-glistening-ultramarine-ibis-1eb3d6@quoll>
Content-Language: en-US
From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <20260319-glistening-ultramarine-ibis-1eb3d6@quoll>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.127]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C0:EE_|DB8PR10MB3468:EE_
X-MS-Office365-Filtering-Correlation-Id: 1873009d-6059-41e0-1583-08de85a2c532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|7416014|22082099003|56012099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: 
	QWve+BY+x6HpGenr6j1IPHEwbGyMsTXUTtmBtypDjBJORcN8rLudvsKqJV4yb9yc5UfyalqfHyMgieaRZjNmEQbbdu27LFv0DxxkYH353WFESUes9/m0apUhHAy8skVCFDHEwNleTENYKQf2S6GxOzm0VTfdRlbi2H7xcQLH+7ZP7OszlsilkhyQbnphhtK+QwIKlA04qql9dLxqqYyzeFPpXisN+OYakpJoaraD/+BIOxKj5VlDnitWWutXTCTcl5j4zk8DIKhjWouSd0wx6lgA/Bsc7XGV2nxUlACZKOGMuxzhw2zEBzhrTU9pGfjr6zsHPPyoiH8p49IBcM/mkUR64k/GVkDX+MwtvGeLaScGAsDttIeKE0T04M7fkpiLnoaBLKVS1yOAKjCk3DjKrMT1mUh7Iil7fSt38eq4CL2KGcnb6dsOV1nM13P28Deg8AQNFPfOdDPhatD3GzKCbYvk4DhiZ7dtrFxEgr9F9DhDKSZSo4EmVN1w4wHCmB56ceUX3dLr0cdtyefVPQU5bXW96NH90SFcVqUv2isa1y9343FYC6XJFa3E2u7ncsXTuviTGiUSbix1hxKhGVEQESeZC6kKQZPWoKSJ2QpiXuPrcchXukMn9wuwEbVPxa6LLJchQscimgFBL7yExkQVXbyAdp0QJGadmWrW/JzH/kfKZVMrxUjV0ri3NEyTqcP2ummuCeNewJStCozjP4CXIXH1IkAmF1a6h6pOMNwyHQg=
X-Forefront-Antispam-Report: 
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(7416014)(22082099003)(56012099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	25QiXcyWSsmb06IhMXt9SGF2GQvEYvbJ7X8KPPARfLYoL5bn5rqP4ITp/zfyHYiDK+tPUrxwxLvwc6XKxBvXI9J87TzJ1c5kqmX3cEyH17gHXiA1cW1M7AbvXk1PfhkldYM78W72/MhSt9XjnUq8ZHc2ly7hh4ds0UoaFzy4baA76c8MDK+9Ljr4CpOPrflg7Fe8/C0dFMe8xvGUtI7zAxQqoUvr/O395C7J4q97sKAHaR0cFYt2W1nTuReXYEsjFgSj1RKW1w9BSPvdnjxwdiny/kIsUhPzlqE35IjjmJ96LeeXZyy2/mUIdfmqVP0tV2QLlqyVCM/N0/CS0xDFyyUoBnZjZBPmXU2DfmMhEykN/Ho1nSEULt3+eovX0WzNtbLa6ekCXoYIfM9D5L2xxOa6gpm6WPqy49ixiq3xub69b4fF/Way1X3clFMEYCIQ
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 10:32:07.1602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1873009d-6059-41e0-1583-08de85a2c532
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DU2PEPF0001E9C0.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3468
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	URL_BACKSLASH_PATH(2.00)[0.0.0.0];
	URL_NUMERIC_IP(1.50)[0.0.0.0];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	DMARC_POLICY_ALLOW(-0.50)[foss.st.com,none];
	R_DKIM_ALLOW(-0.20)[foss.st.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:40.107.0.0/16];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RWL_MAILSPIKE_POSSIBLE(0.00)[40.107.162.66:from];
	DKIM_TRACE(0.00)[foss.st.com:+];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	ASN(0.00)[asn:8075, ipnet:40.104.0.0/14, country:US];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	HAS_XOIP(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[st.com:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 35D764383D
X-Spamd-Bar: /
Message-ID-Hash: K3XHWPBEGH6NVMPFMWE6TQRLLPZ5FKUV
X-Message-ID-Hash: K3XHWPBEGH6NVMPFMWE6TQRLLPZ5FKUV
X-MailFrom: arnaud.pouliquen@foss.st.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/K3XHWPBEGH6NVMPFMWE6TQRLLPZ5FKUV/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hello Krzysztof,


On 3/19/26 09:06, Krzysztof Kozlowski wrote:
> On Tue, Mar 17, 2026 at 07:03:23PM +0100, Arnaud Pouliquen wrote:
>> Add a Device Tree binding for the STM32 remote processor controlled
>> via a Trusted Application running in OP-TEE.
>> This binding describes the interface and properties required for STM32MP
>> remoteproc instances managed by the TEE rproc service, including a
>> linkage to the TEE backend through the property "rproc-tee-phandle".
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>> ---
>> V21 updates:
>> - the m4 node is no more declared as a child of the optee-rproc node
>> - "rproc-tee-phandle" property is introduced to reference the optee-rproc
>> ---
>>   .../remoteproc/st,stm32-rproc-tee.yaml        | 108 ++++++++++++++++++
>>   1 file changed, 108 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/remoteproc/st,stm32-rproc-tee.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc-tee.yaml b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc-tee.yaml
>> new file mode 100644
>> index 000000000000..ca4dd1c8e7b0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc-tee.yaml
>> @@ -0,0 +1,108 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/remoteproc/st,stm32-rproc-tee.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: STMicroelectronics STM32 remote processor controlled via TEE
>> +
>> +maintainers:
>> +  - Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>> +
>> +description: |
>> +  STM32MP remote processor controlled by a Trusted Application
>> +  running in OP-TEE. This node is a child of the TEE remoteproc service
>> +  (UUID 80a4c275-0a47-4905-8285-1486a9771a08) and exposes a remoteproc
>> +  instance managed by the Linux remoteproc core via the TEE rproc service.
>> +
>> +  Firmware loading, authentication and remote processor start/stop are managed
>> +  by the TEE application. The STM32-specific driver handles platform resources
>> +  such as the mailboxes and reserved-memory.
>> +
>> +properties:
>> +  compatible:
>> +    const: st,stm32mp1-m4-tee
> 
> Drop "tee", it suggests that compatible is tied to implementation of FW
> you put there.

The "st,stm32mp1-m4" compatible string already exists in 
drivers/remoteproc/stm32_rproc.c, and "st,stm32mp1-m4-tee" compatible is 
upstreamed in OP-TEE.

Notice that I have also the stm32mp2 SoC to upstream expecting to have 
similar compatible:
- st,stm32mp1-m33
- st,stm32mp2-m33-tee

Depending on the compatible string, the hardware behavior changes.
With the "xxxx-tee" compatible, OP-TEE also manages the isolation of 
remote processor resources (memory, clock reset, peripherals).
Without the "xxxx-tee" compatible, OP-TEE have to ensure that the Linux
has the good access right to manage the remote processor.

For instance if st,stm32mp1-m4-tee is set instead of st,stm32mp1-m4, on
linux side
- only memory regions used for IPC should be declared
- memory regions containing the remote firmware must not be declared as 
not accessible by the Linux ( managed by OP-TEE).
- resets must not be declared ( managed by OP-TEE)

You probably don't remember, as it was a long time ago, but we already 
discussed this point with Rob[1].
[1] https://lkml.org/lkml/2024/1/18/100

Do it still reasonable to you and Rob or should we find an alternative?


Thanks and Regards,

Arnaud

> 
>> +
>> +  reg:
>> +    description: |
> 
> Do not need '|' unless you need to preserve formatting.
> 
>> +      Remote processor identifier used by the TEE service. The <0> value
>> +      in the example denotes a single instance with ID 0.
>> +    maxItems: 1
>> +
>> +  mboxes:
>> +    description: |
>> +      Mailbox channels used for rpmsg/virtio functionality and processor
>> +      shutdown.
>> +    maxItems: 3
>> +
>> +  mbox-names:
>> +    items:
>> +      - const: vq0
>> +      - const: vq1
>> +      - const: shutdown
>> +
>> +  memory-region:
>> +    description: |
>> +      List of phandles to reserved-memory nodes describing the memory layout
>> +      for the interprocessors communication.
> 
> Drop description. You miss maxItems, though.
> 
>> +
>> +  interrupts:
>> +    description: |
> 
> Same comments...
> 
>> +      Optional watchdog / status interrupt line used to detect crashes
>> +      and optionally wake up the system.
>> +    maxItems: 1
>> +
>> +  st,auto-boot:
>> +    type: boolean
>> +    description: |
>> +      If present, the remote processor will be automatically started by
>> +      the remoteproc core at boot.
> 
> That's policy, not DT property.
> 
>> +
>> +  wakeup-source:
>> +    type: boolean
>> +    description: |
>> +      Indicates that the watchdog interrupt can be used as a wakeup source.
>> +
>> +  rproc-tee-phandle:
> 
> Missing vendor prefix, drop phandle. You do not say that "st,auto-boot"
> is "st,auto-boot-boolean"
> 
>> +    description: |
>> +      Phandle to the remote processor backend node and its identifier. This property
>> +      is used to link the TEE remoteproc service to the remote processor instance
>> +      it controls. The value is a phandle reference to the remote processor node,
>> +      followed by a cell specifying the remote processor identifier used by the TEE.
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> 
> Missing constraints.
> 
> I also do not understand which bus node this is being child, if not
> remote proc.
> 
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - rproc-tee-phandle
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    firmware {
>> +        tee_rproc: optee-rproc {
>> +            compatible = "80a4c275-0a47-4905-8285-1486a9771a08";
>> +        };
>> +    };
> 
> Drop
> 
>> +
>> +    m4: m4@0 {
> 
> Drop unused label.
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> If you cannot find a name matching your device, please check in kernel
> sources for similar cases or you can grow the spec (via pull request to
> DT spec repo).
> 
> e.g. mcu, because m4 feels like given model (Cortex M4?).
> 
>> +      compatible = "st,stm32mp1-m4-tee";
>> +      reg = <0 0>;
>> +
>> +      mboxes = <&ipcc 0>, <&ipcc 1>, <&ipcc 2>;
>> +      mbox-names = "vq0", "vq1", "shutdown";
>> +
>> +      memory-region = <&vdev0vring0>, <&m_ipc_shm>, <&mcuram2>,
>> +                      <&vdev0vring1>, <&vdev0buffer>, <&retram>;
>> +
>> +      interrupt-parent = <&exti>;
>> +      interrupts = <68 1>;
>> +
>> +      rproc-tee-phandle = <&tee_rproc 0>;
>> +      st,auto-boot;
>> +      wakeup-source;
>> +
>> +      status = "okay";
> 
> Drop
> 
> Best regards,
> Krzysztof
> 

