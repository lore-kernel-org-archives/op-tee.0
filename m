Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8025BC88E72
	for <op-tee@archiver.kernel.org>; Thu, 17 Sep 2026 23:45:11 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A2A4E44FF4
	for <op-tee@archiver.kernel.org>; Thu, 17 Sep 2026 23:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1789688710;
	bh=388rFBgeu+8MFiw1XJ1xGKSDVsrfo13frUk4Z/Q58vI=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=ulLNRESxAyalAiyWg74MCvM1dmNtNl4wu465zg036STUrAnko/cQpWgN6S/axswn6
	 QVkijvmkcm1Au62TQAsNj78TXcm0M0p9ShJXRyy3WjXDD74AzkhKVWDOnQiUcWMBn9
	 Y+LM8nqDDd7wThWzgQaA13ph0Cg76codV4LkMdQqXt3alIztwiveIP2jM3wBxmJUUw
	 iWfch9rAOU53mI1rVP/TYYHFDa/1koZlR6wg99x7TTumr/6Lv5wqKoZlfdxozWoqHn
	 sfB1ZUWl0VHkvqWWPtsrzHs/cb6djQvo9wDk7B1+EEMutuFuNZ0zR78oWCUB9NYLg7
	 P7RDEXH8PVkpQ==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B84ED43AC9
	for <op-tee@lists.trustedfirmware.org>; Thu, 17 Sep 2026 23:45:02 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YsqSf2Me;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 09E42405E3;
	Thu, 17 Sep 2026 23:45:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FFB1F000FF;
	Thu, 17 Sep 2026 23:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789688701;
	bh=tdagK5hSqGq/Ri3qTRfmlEEmMLaB5aYrPXTv05/dT5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YsqSf2MeYxljNQLqp60U1Ydq6q5dSvRhyM5Fb4lB/pgPnT+qB7zn2tVOhKHsJvS7f
	 PAOCigqbOQtB11RRew6HwZsLm9f/gfgOwgun7mwquCH7w2OLrSKBIELu0lAm2Qrx76
	 xTqWNa6jbR/NGQl32gI2Z5sf8damQUsODIA89i6g02s2pa/0QOLSL/agmwaEZLCYqm
	 lIGLGHZeKBPPYKO23Ba/9RE6ZgsBwdn0ug1I/DnJND2P8xLa5/tP1/b++Cdt7lc8DJ
	 ijkrul4zBpIS9sjUV0SNfKqOFxynXS+v/ofoo686Pr32BnluJUncx6zdeN7wL2iWzu
	 WOLPa9pVXNgbA==
Date: Thu, 17 Sep 2026 16:44:56 -0700
To: Julian Braha <julianbraha@gmail.com>, andersson@kernel.org
Subject: Re: [PATCH v3] tee: remove TZMEM_MODE_GENERIC
Message-ID: <20260917234456.GA1570097@ax162>
References: <20260807175041.3299349-1-julianbraha@gmail.com>
 <20260807190513.GA2638974@ax162>
 <20260831235305.GA2963642@ax162>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831235305.GA2963642@ax162>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.00 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B84ED43AC9
X-Spamd-Bar: ------
Message-ID-Hash: VBENZLFCYQRCH65RPWTZTYXVAOVGHCSH
X-Message-ID-Hash: VBENZLFCYQRCH65RPWTZTYXVAOVGHCSH
X-MailFrom: nathan@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: amirreza.zarrabi@oss.qualcomm.com, jenswi@kernel.org, sumit.garg@kernel.org, arnd@arndb.de, geert+renesas@glider.be, amirreza.zarrabi@oss.qualcomm.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, quic_eberman@quicinc.com, brgl@kernel.org, harshal.dev@oss.qualcomm.com, nsc@kernel.org, jani.nikula@linux.intel.com, kees@kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/VBENZLFCYQRCH65RPWTZTYXVAOVGHCSH/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Nathan Chancellor via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Nathan Chancellor <nathan@kernel.org>

On Mon, Aug 31, 2026 at 04:53:12PM -0700, Nathan Chancellor wrote:
> Hi folks,
> 
> On Fri, Aug 07, 2026 at 12:05:13PM -0700, Nathan Chancellor wrote:
> > On Fri, Aug 07, 2026 at 06:50:41PM +0100, Julian Braha wrote:
> > > 'select' does not work on config options in a 'choice', so currently it is
> > > possible to enable QCOMTEE without QCOM_TZMEM_MODE_SHMBRIDGE, even though
> > > this is needed at runtime.
> > > 
> > > There are no users of the generic allocator option,
> > > QCOM_TZMEM_MODE_GENERIC, so let's remove it. Then, we can remove the
> > > containing choice..endchoice, which allows the 'select' to work as
> > > intended.
> > > 
> > > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > > Signed-off-by: Julian Braha <julianbraha@gmail.com>
> ...
> 
> > A note to the maintainers: We would like to turn selecting a choice
> > symbol into a hard error in 7.4, so please consider picking this up for
> > 7.3-rc1.
> 
> I would like to pick up
> 
>   https://lore.kernel.org/20260804-kconfig-warn-on-dead-select-for-choice-value-v1-1-e5c9a274d291@kernel.org/
> 
> for 7.4 but this was the only patch that did not make 7.3-rc1. Could I
> take it via the Kconfig tree with an ack or be given a shared branch so
> that I can pull it in before I take the above patch?

I have picked this up via the Kbuild tree as

  35abc3cd8ab6 ("tee: remove TZMEM_MODE_GENERIC")

to allow me to pick up the above patch. If you would like to pull it
in, I have added a stable tag.

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/kbuild/linux.git tags/kbuild-tzmem-kconfig-7.4

for you to fetch changes up to 35abc3cd8ab65dd7d07d4fc48a0d7048ce47d055:

  tee: remove TZMEM_MODE_GENERIC (2026-09-17 16:34:13 -0700)

----------------------------------------------------------------
Stable tag for "tee: remove TZMEM_MODE_GENERIC"

Apply "tee: remove TZMEM_MODE_GENERIC" so that the Kbuild tree can turn
on a warning about selecting a choice configuration option.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>

----------------------------------------------------------------
Julian Braha (1):
      tee: remove TZMEM_MODE_GENERIC

 drivers/firmware/qcom/Kconfig      | 26 +++++---------------------
 drivers/firmware/qcom/qcom_tzmem.c |  4 ++--
 2 files changed, 7 insertions(+), 23 deletions(-)

-- 
Cheers,
Nathan
