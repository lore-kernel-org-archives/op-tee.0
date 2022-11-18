From: Jeffrey Kardatzke <jkardatzke@google.com>
To: op-tee@lists.trustedfirmware.org
Subject: register_ddr() with larger than physical RAM size
Date: Fri, 18 Nov 2022 14:01:41 -0800
Message-ID: 
 <CA+ddPcMgFgaq2_bUULtfC_VNQoaUaahH7efZaba0jg=1sebW+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2926372475348289694=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2926372475348289694==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,

New to this list, I'm working on integrating Op-Tee into ChromeOS ARM
devices for the purpose of Widevine DRM.

Does anybody know if Op-Tee creates mappings in the MMU that go beyond
the registered TZ memory region and the static non-secure shared
memory region?

TL;DR

Does anyone know if there would be problems associated with invoking
register_ddr()[1] with a size larger than the physical RAM size?  The
reason I want to do this is because we have multiple different SKUs
for the same reference board, and for ChromeOS we build per-board
images and not per-SKU images. We could use a DT to do this, but
that's running into other issues...so I'm trying to determine if this
easy fix will solve the problem w/out creating new ones.  (it does
work fine when I test it)

I understand that an exploited normal world could send a PA pointing
to a region outside of the physical bounds for dynamic shared memory,
and then Op-Tee would try to map that and undesirable things may
happen (but I don't think they would lead to secure world exploits
since the memory will be mapped as non-secure, so it shouldn't be any
worse that the normal world trying to access physical memory out of
bounds).

One of the main concerns is around whether Op-Tee is creating mappings
in the MMU that reference the whole nonsecure DDR size for some other
reason.  Then the CPU may do speculative execution and try to access
the physical memory at that invalid mapping and create problems, which
could then lead to failure when someone isn't trying to exploit the
system.

Does anybody know if Op-Tee creates mappings in the MMU that go beyond
the registered TZ memory region and the static non-secure shared
memory region?

[1] https://github.com/OP-TEE/optee_os/blob/master/core/arch/arm/plat-mediate=
k/main.c#L20

Thanks,
--=20
Jeffrey Kardatzke
jkardatzke(a)google.com
Google, Inc.

--===============2926372475348289694==--

