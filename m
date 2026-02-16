Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1DBEE63F3A
	for <op-tee@archiver.kernel.org>; Mon, 16 Feb 2026 08:29:16 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E38C14386A
	for <op-tee@archiver.kernel.org>; Mon, 16 Feb 2026 08:29:15 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9A36143862
	for <op-tee@lists.trustedfirmware.org>; Mon, 16 Feb 2026 08:28:56 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1vrtyI-0007ps-BR; Mon, 16 Feb 2026 09:28:46 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vrtyF-00124l-14;
	Mon, 16 Feb 2026 09:28:44 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1vrtyG-00000005lQU-2Igd;
	Mon, 16 Feb 2026 09:28:44 +0100
Date: Mon, 16 Feb 2026 09:28:44 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Sumit Garg <sumit.garg@kernel.org>
Subject: Re: [PATCH v2] tee: shm: fix slab page refcounting
Message-ID: <3h43lflf4r7m4dmec4t4snomt2wdvuwdrikwdw5dc7zan44xmi@fcunxxskfnje>
References: <20250325200740.3645331-1-m.felsch@pengutronix.de>
 <Z-Pc6C1YUqLyej3Z@casper.infradead.org>
 <20250326110718.qzbwpmaf6xlcb4xf@pengutronix.de>
 <CAHUa44FUK_73oKSaqGdiPqB3geZbTNDFsC1Mh=KN3YPWr9=7gQ@mail.gmail.com>
 <Z-TXMIXzaro0w60M@sumit-X1>
 <CAHUa44HEsMkzQHZZufdwutQyZRtig6e0qWomhwgDZAhy2qDyhg@mail.gmail.com>
 <20260212125830.jfwos3flga2l5uwk@pengutronix.de>
 <aY8N90jMp25bBZhi@sumit-xelite>
 <252s4lfnujhrl3bkqm3xwatdkcdd3tfge3e6fla6f2llq4szjm@xltjvpqjgffn>
 <aZK4-grGSdOFXHTK@sumit-xelite>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZK4-grGSdOFXHTK@sumit-xelite>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: op-tee@lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.40 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	RCVD_IN_DNSWL_MED(-0.40)[185.203.201.7:from,2a0a:edc0:0:c01:1d::a2:received];
	FORGED_SENDER(0.30)[m.felsch@pengutronix.de,mfe@pengutronix.de];
	R_SPF_ALLOW(-0.20)[+mx];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:209379, ipnet:185.203.200.0/22, country:DE];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,infradead.org,suse.cz,linux-foundation.org,pengutronix.de,lists.trustedfirmware.org,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,gmail.com,foss.st.com,siemens.com];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.felsch@pengutronix.de,mfe@pengutronix.de];
	DMARC_NA(0.00)[pengutronix.de];
	NEURAL_SPAM(0.00)[0.996]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 9A36143862
X-Spamd-Bar: -
Message-ID-Hash: VGC333R6TFV2FGO73FVPPH3PY7M3CVQV
X-Message-ID-Hash: VGC333R6TFV2FGO73FVPPH3PY7M3CVQV
X-MailFrom: mfe@pengutronix.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Matthew Wilcox <willy@infradead.org>, vbabka@suse.cz, akpm@linux-foundation.org, kernel@pengutronix.de, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ilias.apalodimas@linaro.org, jan.kiszka@siemens.com, masahisa.kojima@linaro.org, spu@pengutronix.de
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/VGC333R6TFV2FGO73FVPPH3PY7M3CVQV/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On 26-02-16, Sumit Garg wrote:
> On Fri, Feb 13, 2026 at 11:04:48PM +0100, Marco Felsch wrote:
> > Hi Sumit,
> > 
> > On 26-02-13, Sumit Garg wrote:
> > > Hi Marco,
> > > 
> > > On Thu, Feb 12, 2026 at 01:58:30PM +0100, Marco Felsch wrote:
> > > > Hi Sumit,
> > > > 
> > > > TBH: I was hoping that you will take care of this since you're marked as
> > > > maintainer for the tee-trusted-key and we noticed the warning with 6.14
> > > > and still no fix available :/
> > > 
> > > Mathew did suggested a fix long back on which everybody agreed but
> > 
> > You agreed. I said that the current TEE API also allows non-slabed based
> > backed memory and therefore I don't wanted to send this patch approach
> > and instead asked you to do so since you're the maintainer and fine with
> > the change.
> > 
> > > didn't got enough attention from you to test and report if that fixed
> > 
> > Why should it get attention from us? Maybe we do have different views of
> > being a maintainer.
> 
> It's really the basic expectation I have put here which every reporter
> of a bug needs to say if a suggested fix works for them or not.
> 
> > 
> > > your issue. Since you insisted further, I have created a formal fix
> > 
> > Why is it our issue? It's everyones issue which uses the tee trusted-key
> > driver.
> > 
> > > patch based on that here [1]. Care to test that?
> > 
> > A colleague of mine is going to test it and will reply on the patch.
> > 
> > > [1] https://lore.kernel.org/all/20260213113317.1728769-1-sumit.garg@kernel.org/
> > 
> > ...
> > 
> > > > I checked the code once again and figured that we could drop/replace
> > > > tee_shm_register_kernel_buf() with tee_shm_alloc_kernel_buf(). I don't
> > > > see why a kernel driver needs to tee_shm_register_kernel_buf() in the
> > > > first place, maybe this is legacy. The only users of
> > > > tee_shm_register_kernel_buf() are trusted_tee.c and tee_stmm_efi.c.
> > > 
> > > No it's not legacy but allows for efficient memory reuse within the
> > > kernel as to not create bounce buffers to share data with TEE.
> > 
> > To be hones, there are only two driver using the API. The tee_stmm_efi
> > driver can do the alloc during the probe(). The trusted_tee has to use a
> > bounce buffer, yes but how often do you assume that (un)sealing and rng
> > ops have to be done during runtime? This shouldn't be a overhead at all.
> > 
> > Therefore my suggestion would be still to drop the internal kernel API
> > and only use it for userspace pages, where it could really matter.
> 
> I don't disagree with what you are saying here but we really need to
> promote efficient memory reuse for TEE clients. There will surely be
> more use-cases coming in future which can benefit from the flexibility
> to register buffer. One another kernel client being remoteproc subsystem
> which is already under review for this API.

I see, thanks for the pointer. I'm really curious why STM didn't
reported the warning stacktrace, since they should trigger it too.

Regards,
  Marco

> 
> -Sumit
> 
> > 
> > Regards,
> >   Marco
> > -- 
> > #gernperDu 
> > #CallMeByMyFirstName
> > 
> > Pengutronix e.K.                           |                             |
> > Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
> > 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
> 

-- 
#gernperDu 
#CallMeByMyFirstName

Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
