From: Julius Werner <jwerner@chromium.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Post-boot loading of OP-TEE
Date: Mon, 09 Jan 2023 18:04:34 +0100
Message-ID: 
 <CAODwPW_b9Ew2sp6mR_R8zx1Qc7g2YhkJmS5kwTbn0OaaVw+gwA@mail.gmail.com>
In-Reply-To: <
 <CAHUa44Eq7u2jQD-AinskV6RRbiRhb1gO-KmR562VzCC0fYqoag@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1516938713237661934=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1516938713237661934==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Jens,

As I already argued in that older thread, I think the whole TrustZone
/ secure world mechanism is fundamentally just a sort of security
toolkit that allows the platform implementer to enforce certain
security guarantees and isolate certain execution contexts from
another. What you actually want to do with that, what threats you're
trying to protect against, what secrets or resources you're actually
trying to protect from whom, are all questions that only make sense to
ask for the platform as a whole, not for EL3 in isolation, and thus
can only be answered by the platform implementer. As such, I don't
think you can really say things like this seems very "risky" or gives
up a "critical level of defense" without actually looking at the
platform in question.

Of course I know that the majority of TF-A users have security models
that are incompatible with this sort of post-boot loading, because
they do not secure their operating system with the same level of trust
as EL3 firmware. But our system is different -- we have firmware,
kernel and userland all owned by the same entity and secured with a
single chain of trust from the first boot firmware components down to
the OS root file system. We have tight control over our early userland
initialization and can actually ensure that the OS doesn't open any
external attack vectors before it loads OP-TEE from the verified file
system and sends it to EL3. I understand that this is not a common
situation but it is the case for us, and all we're asking is that we
can contribute this as an optional, default-off compile time setting
so that we aren't forced to either implement a (for us) vastly
inferior solution or fork the whole project, just because we have a
less common case. (I also don't think it is fair to say this code
would set a "bad example", because there's nothing actually bad about
it for our use case. Security models always take the whole platform
into account, and TF-A was not designed with a single "default
security model" that needs to be forced upon every platform running
it. We are happy to work with you on ways to ensure the implications
and limitations of this compile-time option are clearly labeled so
that nobody would turn it on without knowing what they're doing and
create an insecure situation by accident.)

As for the alternative proposals, they're all implying large drawbacks
for our use case which is why we decided on this kind of solution in
the first place. Of course there are a dozen different ways to get a
system that somehow "works", but there are more constraints here that
we need to be aware of since we're trying to ship an efficient and
maintainable production system. Our BL2 (which is not part of TF-A) is
not designed to stay resident, and any runtime verification in
firmware (whether in BL2 or a stub OP-TEE) would require us to create
and maintain a whole separate key infrastructure just to verify that
one component (and add the code bloat of all those crypto routines to
firmware components which would otherwise not need them, and the boot
time cost of verifying them, and add new headaches about key
revocation for this separate verification system, and...). Why would
we do all of that if we already have a key infrastructure in place
that verifies our root file system to begin with, and we know that our
system encounters no additional attack vectors between initial BL31
loading time and the time when the kernel would load the OP-TEE binary
from that verified file system? It just doesn't make any sense for our
case.

I do hope that we can continue the exiting TF-A design pattern of
offering platforms different options for different use cases here,
rather than trying to force everyone on a single model which just
isn't going to work out well for a project that gets embedded into so
many different systems with different constraints.

--===============1516938713237661934==--

