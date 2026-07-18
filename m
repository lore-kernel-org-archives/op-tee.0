Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0EB5C55174
	for <op-tee@archiver.kernel.org>; Wed,  5 Aug 2026 09:20:37 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E3F1545278
	for <op-tee@archiver.kernel.org>; Wed,  5 Aug 2026 09:20:36 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=UjRGUH1e;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Y3DZm8us;
	dkim-atps=neutral
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3170F42FBE
	for <op-tee@lists.trustedfirmware.org>; Sat, 18 Jul 2026 17:50:44 +0000 (UTC)
Date: Sat, 18 Jul 2026 19:50:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784397042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HnCRoTidLdTf7uGb5+cyEo3j85yiTiGjdgCJTfUNd9A=;
	b=UjRGUH1ewnXDB+7bA3vY6bllDRkAsrRs0EJiAw/WLA8f8siIUfzo2kcwtLuilIO16djMt9
	vyKB0nvQ51/ASWbhyRPEEywx9XHjDyGmn/cAaneOGvH9pWseHX1wHgUbsGXmz9O1s4UhWB
	He3WU+uQL79LQt5RQ0Pr7Ra7ckplXiZw4qjQOy41x66R9GlggrEP7CkWmn9r4W7REjUlW2
	ZdhtWGPRQ+StUxCM0E4uaRc6+OE7ab15WIvTzRfeZRHm7RgWsN2RvkUWNnlzDz7AxV6zF1
	IGY3Hh1WVeqKrgzjBdg2RK3g+gOS/ubuP76SSQhzE+CYpxPgkoQqQHN32pY5Tg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784397042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HnCRoTidLdTf7uGb5+cyEo3j85yiTiGjdgCJTfUNd9A=;
	b=Y3DZm8usu39GZQIHABG8FHwW08JUSpfhXzvxxmIvKt0c/W5XTtRbzRJc5w25addlSNighs
	AMwxxIkmKgs3rKDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-rt-devel@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH v2] Documentation: Extend the real-time hardware bits with
 some firmware bits
Message-ID: <20260718175041.QXn9iOFK@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_LOW(-1.00)[linutronix.de:dkim];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+mx];
	RCVD_IN_DNSWL_MED(-0.20)[193.142.43.55:from];
	ONCE_RECEIVED(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:48314, ipnet:193.142.43.0/24, country:DE];
	RCVD_COUNT_ZERO(0.00)[0];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 3170F42FBE
X-Spamd-Bar: -----
X-MailFrom: bigeasy@linutronix.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: 563CAOV2DXRCR6EAQGBTADH4ZLJLFL77
X-Message-ID-Hash: 563CAOV2DXRCR6EAQGBTADH4ZLJLFL77
X-Mailman-Approved-At: Wed, 05 Aug 2026 09:14:07 +0000
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>, "jenswi@kernel.org" <jenswi@kernel.org>, op-tee@lists.trustedfirmware.org, Ard Biesheuvel <ardb@kernel.org>, Clark Williams <clrkwllms@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/563CAOV2DXRCR6EAQGBTADH4ZLJLFL77/>
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

v1=E2=80=A6v2: https://lore.kernel.org/all/20260701091226.7SWW4TrT@linutron=
ix.de
- Rewrote the OP-TEE bits after some feedback from Ilias and Jens.
  Added a link to the TF-A/OP-TEE documentation. The main difference is
  that in contrast to my initial belief, OP-TEE can disable
  normal-world's interrupts and it is not guaranteed that normal world
  can always preempt the secure world.

 Documentation/core-api/real-time/hardware.rst | 104 ++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/Documentation/core-api/real-time/hardware.rst b/Documentation/=
core-api/real-time/hardware.rst
index 19f9bb3786e03..9f95e75e6aa18 100644
--- a/Documentation/core-api/real-time/hardware.rst
+++ b/Documentation/core-api/real-time/hardware.rst
@@ -130,3 +130,107 @@ https://github.com/Linutronix/RTC-Testbench.
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
+In contrast, some systems provide hardware-based memory scrubbing, which
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
+the kernel are either 32-bit or 64-bit executables) uses a wrapper mechani=
sm
+that invokes the service through a dedicated workqueue. This workqueue is =
named
+efi_runtime, and it can be restricted to a housekeeping CPU using the
+``/sys/devices/virtual/workqueue/efi_runtime/cpumask`` sysfs file. Assigni=
ng it
+to a housekeeping CPU ensures that potentially long service invocations do=
 not
+impact the real-time workload which is restricted to other CPUs.
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
+Execution flows from the normal world (Linux) into the secure world (OP-TE=
E)
+through the secure monitor at EL3. The transition is initiated by the `smc`
+(Secure Monitor Call) opcode or the `hvc` (Hypervisor Call) opcode together
+with a function identifier. The calling convention defines two types of ca=
lls:
+**yielding calls** and **fast calls**:
+
+- A **yielding call** unmasks interrupts before handling the requested ser=
vice,
+  allowing normal world interrupts to occur.
+- A **fast call** handles the requested service atomically, without allowi=
ng
+  interrupts from either the normal world or the secure world.
+
+In addition, the secure world (EL3 and OP-TEE) can receive interrupts rout=
ed to
+the secure world. While a secure world interrupt is being serviced,
+normal world interrupts are masked and cannot preempt the operation.
+
+The transition from normal world to secure monitor to OP-TEE and back intr=
oduces
+additional latency due to world switching and context save/restore. This
+overhead is typically a few microseconds and usually remains within the no=
ise
+floor.
+
+It is worth noting that the normal world cannot mask secure interrupts, wh=
ile
+the secure world can mask normal-world interrupts during execution. How OP=
-TEE
+affects real-time workloads depends on whether secure interrupts are enabl=
ed
+and which OP-TEE services are invoked.
+
+A practical concern is any fast call that runs longer than expected, for
+example a function that occasionally performs a long-running cryptographic
+computation. Another example that may block in an unexpected way are OP-TEE
+drivers that issue RPC requests. An OP-TEE service in the secure world (RP=
MB
+for instance) may need to issue a request back to the normal world (the Li=
nux
+driver) in order to complete the operation. While Linux remains preemptibl=
e,
+the thread that issued the request stays blocked until the RPC completes a=
nd
+the secure function call returns.
+
+The TF-A project provides documentation on interrupt management:
+https://trustedfirmware-a.readthedocs.io/en/latest/design/interrupt-framew=
ork-design.html#interrupt-management-framework
+
+The OP-TEE project provides documentation on how interrupts are handled:
+https://optee.readthedocs.io/en/latest/architecture/core.html#interrupt-ha=
ndling
--=20
2.53.0

