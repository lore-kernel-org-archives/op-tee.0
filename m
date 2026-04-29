Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 712FAFF8864
	for <op-tee@archiver.kernel.org>; Wed, 29 Apr 2026 06:18:42 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id AE00044DEC
	for <op-tee@archiver.kernel.org>; Wed, 29 Apr 2026 06:18:41 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GWozT1Sj;
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 02F6A43085
	for <op-tee@lists.trustedfirmware.org>; Wed, 29 Apr 2026 03:07:35 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35448ca4689so1936798a91.0
        for <op-tee@lists.trustedfirmware.org>; Tue, 28 Apr 2026 20:07:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777432054; cv=none;
        d=google.com; s=arc-20240605;
        b=Vq9Adf1QHx63WGHVgDFZQZ+vMs4IsHWBpqWZHNWKi1Km3Ae6A2d6rjlr+vxoAhi/s+
         7A9WkUkhrdgFhBS0ukn6ZQ58d99RhB5SHHLwhhLK+R1q8Lo6g5scJxbRSWcZlx+163Nx
         ZEEhXS3uuQPQGqVMZXBBjZZmGEn38YHYu+PYR7XiZr3ZAZBtygvqavlAcopbx9ZIyAXS
         wvfbDp0u66uDqBhEIEUycFGlRz8JTIlBdrS1TRz5S8c0UtxgspiiSJX15oJSdHtebBzt
         ZV0UEv6vqsBnsZRBKrR69tiWyoADRfskwfihy/+YxzgUmWA2l4jDzSUHUSN5rreAptv7
         XpNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=xwT3vH7NzQxds5/7BHfYQPsuqScyfTyHgF2MGEnD6yo=;
        fh=Xe26FmfEn01InvkUPXQXxh3KZJfh9RnMxX/fMjtTcug=;
        b=We5ClBeZjw2/+7djcfXERAJ0CRNAVMOV7jhle2lbXlAgSr0rgvYA53kS2wsg8j7JXR
         RfjpA1DFCij0NX+5kcmXCCKwjPEtpK6Qf817l7vs/Pp5BiNkIuCKpUfABYoq4ulrrp7H
         Da6LIG4e/YdTzeOCFhhDNTHAOaJQzh5FCA+kpw67EOpkaqAwS76EUd4D9Jb4KZW3O9EX
         8LrjsV7fP+sJqdRl3R0uIfPIUQucguZ4y5Ns76Za+lHglYzffrzs3n8Y1fLGIalbgEco
         Guo+U1MXTSZoFYFOWF6s9LiT4f0o9j461DpA0aA1Wwyx4+H9yOwnJayMlQ8ssFmxSrDn
         IudQ==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777432054; x=1778036854; darn=lists.trustedfirmware.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xwT3vH7NzQxds5/7BHfYQPsuqScyfTyHgF2MGEnD6yo=;
        b=GWozT1SjCtHgqJ5tCcmTgAfrq4eIlu2ZrAkf5k8pFO+98wntJrxlOiDTEsQNzZ/Bjm
         SQiPjXCUr4SEmsP33j6JLtUQAWufS62G22uJ9SePlJL/SUgNSjUm3aWnKtxi/t3Yiqwb
         /zeq8/S5PeSSkIr4E9qXOnZH7fZ7dKbAp3/tyAbGofZl9q1NBLOHMODATqYuVR7pG6+o
         TbRTmUjtkNPSyF9OwWOJCo/0xTSCYb1i+AY2Td2p5JnY5/cXm99xrfAD3cd1zL40RVaT
         ZwON0QxjETB0s47t7QoN+eAFu4R5WWWUIdgSmqAkdsIpV7fY7STiprgOFi8r+WCyg/Du
         2yYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777432054; x=1778036854;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xwT3vH7NzQxds5/7BHfYQPsuqScyfTyHgF2MGEnD6yo=;
        b=a5myM2B0ZJQeAxbnDqjqzzsykI4mX18GnKVm7G0YE2ixHAhFIE3FGFOqJcGxgSjTZI
         wX2l/WvbJrOslLtFlDJjZ8Q1XrUjnVu7YxBv80Yp8lhGHLpf6Z//5wdiUgR7iTcXkDbz
         RHclCgXGyaOaiP/434I34dcX26w+J8gSi1rrRczrFLn3SL7ou+JiQ7hJetu9ti/vNLgj
         iDC11Gbu0myMuXT/jtM9fD6TpPSns6ABgmAVoRLmBZ/HW5VrKlQ3iJsCwjbor2oGvhiq
         CHYDqrresR5NrZ8vA3LX2eAY0SYE05QqebqjvS5abXcl/ypsLJelzkeP5LHuRRCqFKKT
         eCYQ==
X-Forwarded-Encrypted: i=1; AFNElJ+sUYmX8IFgqoudb9K/ugCBLBR0HbDinFXr8juix9vQk22x96JwaPvk6wcHoB2IzVvgif6kysA=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzzYtZCv07F7yP4kjZ9fY3rNxisfj3G4aFp88AXM4tjEhM31DkH
	dgGTSMGJj+7lo+FA232ubfKmUKwIzbnou6OPmII1vMQg4oxQMXmerggD+VBLIOqexqqvlr+hipy
	Q4NRC1k56Od9QRqzSaDmDW4UlIreeP5o=
X-Gm-Gg: AeBDieuRBf46A+Fd6gwrbkMNxIi4oz6UBCFpECDDRMDADW2yqdBExZs3QrKUzZ+4atN
	LDILknlf/GAJp7ZcQfcjYT506N+Ziv7LnOZXGwXrLHtT7NFo0zqeqB/1fGgAGs2Ux0IvZwhBM1O
	5SyL611uw7f5wL/hCcMlXha3HxGu4blX6qhg2hAtkLcdLf0dfIqTL6R2qrYP+7b4MIharqWHxsS
	IixPSKXQQpVMYCy7SPQiOKeIcofdFr7griPzJA7xZB1pq11yaT991LdflAtFMuQZw+udUyg1W8k
	Gg3LMOj9y229pM0zgysoj01h7SaJgN2iC4kGqdQCvBJemKYdjqMb
X-Received: by 2002:a17:90b:2e42:b0:35f:b953:2444 with SMTP id
 98e67ed59e1d1-36490be7189mr3231148a91.2.1777432054015; Tue, 28 Apr 2026
 20:07:34 -0700 (PDT)
MIME-Version: 1.0
From: Qihang <q.h.hack.winter@gmail.com>
Date: Wed, 29 Apr 2026 11:07:22 +0800
X-Gm-Features: AVHnY4KLCIratMgL9TjlGX9s3UYFhEiv0SKKffo-1KJw2PpezSb_zfw__V_3SUU
Message-ID: <CAH78Gvtd_reUt1mCasR=grZuLWWHcn4-ox3bXWXNEvbTOV3UGA@mail.gmail.com>
Subject: [REPORT] tee: tee_ioctl_supp_recv() missing tee_shm_put() cleanup for
 memref params
To: Jens Wiklander <jens.wiklander@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20240605:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.216.54:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.54:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	FREEMAIL_ENVFROM(0.00)[gmail.com]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 02F6A43085
X-Spamd-Bar: -----
X-MailFrom: q.h.hack.winter@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: JX242CYI2XJBUQJE3GC2GHSW6XLFBKMR
X-Message-ID-Hash: JX242CYI2XJBUQJE3GC2GHSW6XLFBKMR
X-Mailman-Approved-At: Wed, 29 Apr 2026 06:16:38 +0000
CC: Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/JX242CYI2XJBUQJE3GC2GHSW6XLFBKMR/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

I would like to report a likely shared-memory reference leak in
drivers/tee/tee_core.c, in tee_ioctl_supp_recv().

The issue is that tee_ioctl_supp_recv() calls params_from_user(), which
acquires references for MEMREF-type parameters via tee_shm_get_from_id(),
but the cleanup path only frees the params array and does not drop the
acquired shm references.

Relevant code in tee_ioctl_supp_recv():

  rc = params_from_user(ctx, params, num_params, uarg->params);
  if (rc)
          goto out;

  rc = ctx->teedev->desc->ops->supp_recv(ctx, &func, &num_params, params);
  if (rc)
          goto out;
  ...
out:
  kfree(params);
  return rc;

By contrast, other callers of params_from_user() in tee_core.c do release
MEMREF references on cleanup, for example:
- tee_ioctl_open_session()
- tee_ioctl_invoke()
- tee_ioctl_object_invoke()

The helper comment in param_from_user_memref() also states that the caller
is responsible for calling tee_shm_put() on all resolved pointers.

Reachability / trigger paths:

1. qcomtee backend:
   qcomtee registers .supp_recv = qcomtee_supp_recv on a non-privileged
   tee device path. qcomtee_supp_recv() rejects any non-meta parameter
   after the first one:
     for (i = 1; i < *num_params; i++)
             if (params[i].attr)
                     return -EINVAL;
   This allows a path where params_from_user() has already acquired a shm
   reference for a MEMREF parameter, then qcomtee_supp_recv() returns an
   error, and tee_ioctl_supp_recv() exits without tee_shm_put().

2. Partial failure before backend callback:
   if params_from_user() successfully resolves an earlier MEMREF parameter
   and then fails on a later parameter, tee_ioctl_supp_recv() still goes
   to the same cleanup path without dropping already acquired shm refs.

This means the issue is not just a backend-specific quirk: the core ioctl
cleanup path itself is missing tee_shm_put() handling.

Impact:
- leaked shared-memory references
- shared-memory objects may remain pinned and never reach final release
- repeated triggering can cause resource exhaustion / DoS

This does not appear to be a UAF, since refcount_t saturation prevents
wraparound. The impact looks limited to resource leakage and availability.

If useful, I can also prepare a patch.

Thanks,
Qihang
