Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4DF4C55174
	for <op-tee@archiver.kernel.org>; Wed,  5 Aug 2026 09:13:24 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id CC36444F03
	for <op-tee@archiver.kernel.org>; Wed,  5 Aug 2026 09:13:23 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=HaQp00z+;
	dkim=fail reason="signature verification failed" header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Nr8GrEXi;
	dkim-atps=neutral
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 397B344495
	for <op-tee@lists.trustedfirmware.org>; Wed,  1 Jul 2026 09:12:29 +0000 (UTC)
Date: Wed, 1 Jul 2026 11:12:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782897147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VxUjj+58AxN1DHcZllF59XGxoFN64vOpQQG615c8HNA=;
	b=HaQp00z++5NRvJYVHWDOmBOxrWr5RhP6Nyw6ZNOpHMGRX5TfxZi/jmnCAeLa6/AEYl1siF
	ZZLi9L9G/mRQgD4BZOsbljQuufgnPe61LN/zfZhKLKHcRjFbdaAq0u4UlTBnZQ1E0Otool
	XY6QWyHoVLA8V7U9Pvby1r6KmRP7IxIai6LlOyNhPKidTORQWlP+z+iP/YnClAxMJki4m1
	Vbrhh0ZHOwsX5wDbcBBMPOxBj4Gq5DBZLKdlnVYyhif3jCtG5NvFmGYrCVg439rAyBGkJr
	vQyvbhzP4TyZ8JaP/v9XQlI35bPmSwjolXNnefQIj7aXgZmR2pPAJ0H3ISW7gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782897147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VxUjj+58AxN1DHcZllF59XGxoFN64vOpQQG615c8HNA=;
	b=Nr8GrEXiJ/sKMV0gvf+V2fSf/wvKN6Np/MBR+idrWgrto2GX7DIiG0OIJsMKlYOA5cX12Z
	Wk4IaoZI1e6AlIAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-rt-devel@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org, op-tee@lists.trustedfirmware.org
Subject: [PATCH] Documentation: Extend the real-time hardware bits with some
 firmware bits
Message-ID: <20260701091226.7SWW4TrT@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.90 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+mx];
	MIME_GOOD(-0.10)[text/plain];
	ONCE_RECEIVED(0.10)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:48314, ipnet:193.142.43.0/24, country:DE];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_ZERO(0.00)[0];
	DWL_DNSWL_BLOCKED(0.00)[linutronix.de:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DNSWL_BLOCKED(0.00)[193.142.43.55:from];
	DKIM_TRACE(0.00)[linutronix.de:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 397B344495
X-Spamd-Bar: ---
X-MailFrom: bigeasy@linutronix.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: QSN43HTZ2R3GJTF6VA3XZYUCI3KWH3SK
X-Message-ID-Hash: QSN43HTZ2R3GJTF6VA3XZYUCI3KWH3SK
X-Mailman-Approved-At: Wed, 05 Aug 2026 09:13:16 +0000
CC: Ard Biesheuvel <ardb@kernel.org>, Clark Williams <clrkwllms@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/QSN43HTZ2R3GJTF6VA3XZYUCI3KWH3SK/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

I have been reviewing how OP=E2=80=91TEE is implemented and how secure=E2=
=80=91world
invocations behave. The goal was to determine whether an OP=E2=80=91TEE cal=
l can
delay the Linux side and introduce latency depending on the time spent
in the secure world.

Similar latency effects are already known for EFI runtime services, but
this was not documented. To mitigate the impact, EFI runtime invocations
can be restricted to specific CPUs so that real=E2=80=91time workloads on o=
ther
CPUs remain unaffected. This mechanism, however, is only described in
the commit that introduced it.

This change adds a firmware section that documents these behaviours
explicitly. It highlights cases where firmware can delay the kernel,
information that may be unfamiliar to some users and surprising-or
concerning-to others.

Assisted-by: Microsoft-Copilot
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

I would appreciate an ACK from the OP-TEE camp that I got my little
research right.

 Documentation/core-api/real-time/hardware.rst | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/Documentation/core-api/real-time/hardware.rst b/Documentation/=
core-api/real-time/hardware.rst
index 19f9bb3786e03..fb113848c2f70 100644
--- a/Documentation/core-api/real-time/hardware.rst
+++ b/Documentation/core-api/real-time/hardware.rst
@@ -130,3 +130,95 @@ https://github.com/Linutronix/RTC-Testbench.
 The goal of this project is to validate real-time network communication. I=
t can
 be thought of as a "cyclictest" for networking and also serves as a starti=
ng
 point for application development.
+
+Firmware
+--------
+
+The firmware often plays a significant role in system operation because it=
 can
+perform tasks that the kernel cannot directly access, and in some cases it=
 can
+even preempt or intercept the kernel.
+
+A common example of firmware assisting the kernel is when it provides a ge=
neric
+interface to a resource. Instead of accessing an RTC chip through an I2C h=
ost
+controller, the kernel may query the firmware for the current time, and the
+firmware then accesses the RTC behind the scenes.
+
+Firmware can also intercept kernel execution by providing services that
+temporarily take control of the system. One example is memory scrubbing, w=
here
+the firmware periodically pauses the kernel, reads back portions of system
+memory, and then returns control. During this time, the kernel is effectiv=
ely
+interrupted.
+In contrast, some systems provide hardware=E2=80=91based memory scrubbing,=
 which
+operates independently of firmware or software. See
+Documentation/edac/scrub.rst for details.
+
+If the kernel is intercepted for longer periods then these periods can be =
made
+visible with the hardware latency detector. See
+Documentation/trace/hwlat_detector.rst.
+
+The kernel can also be intercepted in response to specific events, such as
+overheating. In this case, the firmware may throttle the CPU or shut it do=
wn
+immediately to prevent hardware damage.
+
+Unless the firmware is well documented, it should be thoroughly tested to
+uncover any unexpected behaviour.
+
+EFI
+~~~~
+
+EFI provides runtime services that act as a communication interface betwee=
n the
+firmware and the operating system. One such service is reading and writing=
 EFI
+variables, which are used, for example, to determine the boot source.
+
+Invoking a runtime service may require the architecture to disable kernel
+preemption or interrupts during the call. This means the duration of a ser=
vice
+invocation directly affects the system=E2=80=99s observable latency. There=
 is also
+nothing that prevents a service call from disabling interrupts internally =
while
+it runs.
+
+For these reasons, EFI runtime services are disabled by default on a PREEM=
PT_RT
+kernel. They can still be enabled at boot time or via a Kconfig option if
+required.
+The native EFI runtime service implementation (where both the EFI service =
and
+the kernel are either 32=E2=80=91bit or 64=E2=80=91bit executables) uses a=
 wrapper mechanism
+that invokes the service through a dedicated workqueue. This workqueue is =
named
+efi_runtime, and it can be restricted to a housekeeping CPU using the
+``/sys/devices/virtual/workqueue/efi_runtime/cpumask`` sysfs file. Assigni=
ng it
+to a housekeeping CPU ensures that potentially long service invocations do=
 not
+impact the real=E2=80=91time workload which is restricted to other CPUs.
+
+It must also be verified that the runtime services behave as expected. Some
+implementations on the x86 architecture pause all other CPUs while one CPU
+performs the service call. In such cases, the interruption affects all CPU=
s,
+and restricting the workqueue to a single CPU provides no benefit.
+
+OP-TEE (ARM)
+~~~~~~~~~~~~
+
+OP=E2=80=91TEE uses a global serialization mechanism (the "big lock"), ens=
uring that on
+each core only one OP=E2=80=91TEE thread executes secure=E2=80=91world cod=
e at a time.
+
+Execution flows from the normal world (Linux) into the secure world (OP=E2=
=80=91TEE)
+through the secure monitor at EL3. Linux and OP=E2=80=91TEE cannot disable=
 or mask each
+other=E2=80=99s interrupts because both run at EL1 in different security s=
tates.
+
+Architecturally, the secure monitor can mask or reroute normal=E2=80=91wor=
ld interrupts
+before entering the secure world. In a correct OP=E2=80=91TEE/ TF=E2=80=91=
A implementation, it
+does not do this for the duration of secure calls. Normal=E2=80=91world in=
terrupts
+remain deliverable, and a normal=E2=80=91world IRQ will preempt OP=E2=80=
=91TEE via EL3 and
+return control to Linux.
+
+Secure=E2=80=91world interrupts (FIQs) are possible if the SoC routes a de=
vice's
+interrupt as secure. Such a secure FIQ will preempt Linux immediately, trap
+into EL3, and transfer control to OP=E2=80=91TEE's secure interrupt handle=
r. Linux
+cannot mask or preempt this. Secure FIQ handlers must therefore be extreme=
ly
+short to avoid introducing noticeable latency.
+
+The transition from normal world -> secure monitor -> OP=E2=80=91TEE and b=
ack introduces
+additional latency due to world switching and context save/ restore. This
+overhead is typically a few microseconds and usually remains in the noise
+floor.
+
+If the secure monitor masks normal=E2=80=91world interrupts during OP=E2=
=80=91TEE invocations,
+or if OP=E2=80=91TEE uses long=E2=80=91running secure FIQ handlers, then O=
P=E2=80=91TEE can introduce
+measurable latency spikes.
--=20
2.53.0

