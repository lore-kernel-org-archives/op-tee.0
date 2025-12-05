Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A9FD2F7D1
	for <op-tee@archiver.kernel.org>; Fri,  5 Dec 2025 11:12:56 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 15C4D50037
	for <op-tee@archiver.kernel.org>; Fri,  5 Dec 2025 11:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1764933176;
	bh=0EaIjAihWWlZPcb9Q6V07nqMt6YzJeUWfYDX8Tp8ac8=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=wWr06dXgApCiU6FG/z4CU0GDxR8mAfCKMEDpxDodN/AQqrjMorB9DTQUM52dFs2Ym
	 8sEY/N63jLOFB1XIA9UppCD95geTNVk03WejWOrgEtMLYZTFG0drAc+FWALHM3fQfi
	 KRxER8dh5ARK0rSdgJE4zi0VAhEDEnhC8ypAdq8br83jdRy5qcGy7vx+wphF7AnwpX
	 Spp4Y6WJuPGvOU389Che4W1pN0jpH1EK+406+pUvvGwo4ELNC5D7Ans34hlE0yWZhS
	 ywQFq0z4CRex9Hj+HXv8jwajb9Uh9NG8tYYQu4Vy/h20k9cxhHmVnY8HrwOjJTYLs7
	 FGD2yp84w8jog==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C6AF343069
	for <op-tee@lists.trustedfirmware.org>; Fri,  5 Dec 2025 11:12:44 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=e+TDcX7c;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 37E0D407E7;
	Fri,  5 Dec 2025 11:12:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D9CC4CEF1;
	Fri,  5 Dec 2025 11:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764933164;
	bh=0EaIjAihWWlZPcb9Q6V07nqMt6YzJeUWfYDX8Tp8ac8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e+TDcX7cntb4B1BegRI2DWth9FaVe+m6rarUZIBh6J6N8eZuW4mnQkYFz3eBsIUxG
	 FqL5P14zHKx5tx0f3x1DvOb480dBDPyNGwv6+kovYXvGwE47Re48hHKU33uJHPSEw3
	 5+yqYkqPmk4wBV/ed336pMj8KyBteJ0bouaYi0Fe0qSzjmWA38Pfakw72/dgt6FjoY
	 uQDBDY47SJD3uMbkm6WDUPum8huJtUCDPq5HPCclgEnrepjjEDbp7Bwuw5oCPwW/Hi
	 M1GBZFX4RaPsC3rmwTXlHYl2a/IPRgEz/KQbOPABz8N6H8bMgd2Rkwee9Yz4Xya+6c
	 zkwqaBI0L1yGg==
Message-ID: <083ebd3c-6d19-44c4-9a46-f7fba01111bf@kernel.org>
Date: Fri, 5 Dec 2025 12:12:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: defconfig: Enable QCOMTEE for Qualcomm SoCs
To: Harshal Dev <harshal.dev@oss.qualcomm.com>,
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
References: <20251205-qcom_qcomtee_defconfig-v2-1-c92560b0346e@qti.qualcomm.com>
 <7ffb61c8-465c-40f1-b794-4f573c8f96ec@kernel.org>
 <4d4a6614-9460-48b4-8e6a-77d3395abfbf@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <4d4a6614-9460-48b4-8e6a-77d3395abfbf@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: ----
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C6AF343069
X-Spamd-Result: default: False [-4.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	URIBL_BLOCKED(0.00)[sea.source.kernel.org:helo,sea.source.kernel.org:rdns];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[172.234.252.31:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
Message-ID-Hash: QVJCUC2IGHM2DOD65AXJYI2YJVCQ45NU
X-Message-ID-Hash: QVJCUC2IGHM2DOD65AXJYI2YJVCQ45NU
X-MailFrom: krzk@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/QVJCUC2IGHM2DOD65AXJYI2YJVCQ45NU/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Krzysztof Kozlowski via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Krzysztof Kozlowski <krzk@kernel.org>

On 05/12/2025 11:58, Harshal Dev wrote:
> Hi Krzysztof
> 
> On 12/5/2025 1:45 PM, Krzysztof Kozlowski wrote:
>> On 05/12/2025 09:12, Harshal Dev wrote:
>>> Enable config 'm' for the QCOMTEE driver to facilitate communication with
>>> the Qualcomm Trusted Execution Environment (QTEE) on Qualcomm platforms.
>>
>> I can do it forever, but next time I will just NAK.
>>
>> Which platforms need this? Which platforms use this?
> 
> Looks like I misunderstood your comment on the last patch regarding Qualcomm
> platform support for this driver as more of a generic question instead of being
> a hard request to update the commit message. 
> https://lore.kernel.org/all/f20833a4-1571-41f8-875a-d27086be3090@oss.qualcomm.com/
> 
> I will take care of this now, however I am still a bit confused regarding how many
> platforms should I explicitly list out in the commit message. I took reference of

Just mention which UPSTREAM boards (which you called Qualcomm platforms)
use this driver. It's enough to mention one, for justification of
commit. You can mention two as well. Or three.

> these below patches merged earlier in the defconfig for enabling the QCE crypto block driver,
> Qualcomm Watchdog driver and Qualcomm RNG driver. And I did not see them listing out
> any specific Qualcomm platforms which need/use these drivers. I understand that this is
> because the drivers provide generic functionality applicable on all Qualcomm SoCs.
> https://lore.kernel.org/all/20220921045602.1462007-5-bhupesh.sharma@linaro.org/
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f27dbbda5900c20e07418c6893ca6e95b634f4ff
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2774e558151a6e325e1f9f278722479601319f78

:) unfortunately all poor examples. And from 2019! You can find many
poor examples in the kernel - in commit msgs or code. You can find many
obsolete drivers written in old, not updated style. These are not
examples to be based on.

Usually it is the best to take LATEST reviewed code, not something 6
years old, so the process would be:

tig -- arch/arm64/configs/defconfig
/Qualcomm
(or whatever search query you want)
Which would give you commit c5d02bbaa217b2454ba1ce7528113aa2ecf14f3c
from June for example. It even caries two review tags.

> 
> Similarly, all Qualcomm SoCs have ARM TrustZone support with a QTEE firmware OS running.
> The version of the firmware might differ, but it is always there, and so the QCOMTEE driver is
> applicable to all Qualcomm SoCs just like the Watchdog or RNG driver.

You can say that all Qualcomm platforms use it... but I would challange
it, because not all platforms use watchdog or RNG.

Best regards,
Krzysztof
