Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8882ECA5FB3
	for <op-tee@archiver.kernel.org>; Thu,  1 Oct 2026 06:03:12 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9A1C344A49
	for <op-tee@archiver.kernel.org>; Thu,  1 Oct 2026 06:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790834591;
	bh=LHvwzomglSZ+GGcJZchaw/w0UsqiVLKCXgj9Oi0J3zg=;
	h=Date:To:Subject:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=mCEWGXLg9SzBOIy31JeXXwUSXKuqP0s9vp8UBo/x5CZaGUHqKbrEOifSGEBjcwdmr
	 PSg7zVc5xYOHCeqYCkmzCZ/RXnriLM5mzGHT5oApIVXSWpaltYD1TvXQHqfirMbRZD
	 RIjc7Y1ewSMbEwio6jjiqy/WVrtItXtW9oEaIeObnE1J9jzmLT86hZDTuem/f0R+v0
	 eb33wPC7En1CeJFO03peUh/bTeZ2xIuEs94+MffkbMxFytT0W2TXlyKTjuFtAcW30l
	 GCN8FeM/ej790Nyb7+uMYMolskGUI1GteJoRo6nQxiieozXmDRUT1KUvK4rNV6IrR5
	 uS+Z3OZQaUMfA==
Received: from mail-43100.protonmail.ch (mail-43100.protonmail.ch [185.70.43.100])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 764B344A45
	for <op-tee@lists.trustedfirmware.org>; Thu,  1 Oct 2026 05:50:40 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=ANBwIvp1;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1790833839; x=1791093039;
	bh=8ksQy6MeanfkvfpHQut3hQ6xN1hUcsCd/pALFRS+d1A=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ANBwIvp1/ocowntL22wAN4kLe7moxsFWk60wzZE3feu/nI9zJ9GkL/LVDTmQfALs0
	 MT0ibl8G+v0sTu+q1a/5/9YbOSL05r7wkKQfsvNCuUT9QI22m6n6V5lS8Y+PVSm1PZ
	 rc5RG8Auvi6ZxLGOBwnd+TtghDLlK99wxbrybcfNBtefVnB0L/xBVsB2WcEWWo9Z/2
	 e0OIKnbyv1DbhM3h9st1lSUufUFNAQjAWUkfoXALpfl9UHQTJn29CFSbHiysqNaEMB
	 mNz+uqjE+XWErGXSN22IQhwduzO7NKdQShrikpq78ljeR8IAJrn4OqjosTBx3B2kse
	 aWg1T1dLu6yNA==
Date: Thu, 01 Oct 2026 05:50:34 +0000
To: kuldeep.singh@oss.qualcomm.com
Subject: Re: [PATCH v2 0/3] Add TPM support via Qualcomm TEE TPM TA
Message-ID: <20261001055029.1960743-1-zeroknots@protonmail.com>
Feedback-ID: 44664438:user:proton
X-Pm-Message-ID: 5be19f9a5cd05f46b76827da84152667a78aadda
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.99 / 15.00];
	BAYES_HAM(-2.99)[99.95%];
	FAKE_REPLY(1.00)[];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[protonmail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:185.70.43.0/24];
	R_DKIM_ALLOW(-0.20)[protonmail.com:s=protonmail3];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:62371, ipnet:185.70.43.0/24, country:CH];
	FREEMAIL_FROM(0.00)[protonmail.com];
	RWL_MAILSPIKE_POSSIBLE(0.00)[185.70.43.100:from];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_SEVEN(0.00)[11];
	DWL_DNSWL_BLOCKED(0.00)[protonmail.com:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,ziepe.ca,vger.kernel.org,lists.trustedfirmware.org,gmx.de];
	FREEMAIL_ENVFROM(0.00)[protonmail.com];
	TO_DN_NONE(0.00)[];
	DNSWL_BLOCKED(0.00)[185.70.43.100:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.929];
	DKIM_TRACE(0.00)[protonmail.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 764B344A45
X-Spamd-Bar: -
X-MailFrom: zeroknots@protonmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: 7SIHZF76LCP3MPEOZYKT5I5EL2NI4PVD
X-Message-ID-Hash: 7SIHZF76LCP3MPEOZYKT5I5EL2NI4PVD
X-Mailman-Approved-At: Thu, 01 Oct 2026 06:03:05 +0000
CC: amirreza.zarrabi@oss.qualcomm.com, jarkko@kernel.org, jenswi@kernel.org, jgg@ziepe.ca, linux-arm-msm@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, peterhuewe@gmx.de, sumit.garg@kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/7SIHZF76LCP3MPEOZYKT5I5EL2NI4PVD/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: zeroknots via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: zeroknots <zeroknots@protonmail.com>

Hi Kuldeep,

A data point from retail hardware, in case it is useful for this
series: on an ASUS Zenbook A14 UX3407NA (Glymur, X2E-88-100, BIOS
UX3407NA.315) the TPM TA is not reachable as QTEE service 81, but it
is present as the QSEECOM application "qcom.tz.tpm".

With the qcomtee driver on a 7.3-rc3 based kernel, QTEE reports
version 5.2.0, and service discovery finds neither 81 (TPM) nor 413
(UEFI secure app). On the same boot, qseecom (version 0x1402000) works
and backs efivars through "qcom.tz.uefisecapp" (app id 7). An app-id
lookup for "qcom.tz.tpm" returns app id 1; a made-up name returns
-ENOENT.

The Windows driver for this machine agrees: QcTrEE8480.inf configures
the TPM service with AppName=3D"qcom.tz.tpm", SecureApp=3D1, LoadApp=3D0
(preloaded by firmware). The EFI configuration table carries the
TPMEventLog and TPMFinalLog entries, so the firmware TPM is active.

Through that app, using a QSEECOM transport (based on Xilin Wu's
out-of-tree SC8280XP driver: QUERY_INFO_2 / SEND_COMMAND with a
CRB-style control area, here at 0x81d10000), /dev/tpm0 works: TPM 2.0,
manufacturer QCOM, vendor string "xCG fTPM", firmware 0x40000, real
PCR 0-7 values, GetRandom, ECC and RSA-2048 primaries, sign and
verify, and a sealed object that persists across reboots.

So, as far as I can tell, retail Glymur laptops may ship firmware on
which this driver finds no TPM, while the same TA is available over
QSEECOM.

The same applies to the prerequisite series that moves uefisecapp to
QCOMTEE [1]: on this firmware service 413 is absent and EFI variables
work only through the QSEECOM uefisecapp. If the QSEECOM path were
dropped for Glymur, efivars would stop working on this machine, so it
would be good to keep it as a fallback when the QTEE service is not
found.

Two questions:

 - Is service 81 expected to appear on retail firmware through an
   update, or is it specific to the CRD firmware?
 - Would you consider a QSEECOM-based path for such firmware? I am
   happy to test this series, or any other service UID you would like
   checked, on this machine, and to share the transport code.

[1] https://lore.kernel.org/lkml/20260722-qcom_uefisecapp_migrate_qcomtee-v=
2-0-b8a8fcbe4211@oss.qualcomm.com/

Thanks,
zeroknots

Assisted-by: LLM (analysis and drafting; the measurements were made on
the hardware and reviewed by me)

