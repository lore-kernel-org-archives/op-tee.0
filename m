From: Joanna Farley <Joanna.Farley@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [TF-A] Re: Post-boot loading of OP-TEE
Date: Tue, 17 Jan 2023 16:14:19 +0000
Message-ID: <AS1PR08MB7449CF6412C969A1BCBEA7A2E5C69@AS1PR08MB7449.eurprd08.prod.outlook.com>
In-Reply-To: <
 <CAODwPW_b9Ew2sp6mR_R8zx1Qc7g2YhkJmS5kwTbn0OaaVw+gwA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8714200915352870654=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8714200915352870654==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

My take on this is a question I ask myself. Is this a generic supportable opt=
ion for the SPD or if it is more of a Chromebook specific architecture change?

If this is something specific to the Chromebook architecture that should be c=
alled out more. One reaction is to say these should be kept downstream but I =
do understand the desire to have this upstream and in the SPD code to aid in =
maintainability so lets see what we can do to facilitate that. However, I wou=
ld not want to promote and set a precedence that its ok to scatter platform s=
pecific changes in common generic code behind lots of build flags. I do thoug=
h see that this change is not so much a specific platform architecture behavi=
our but a Chromebook architecture behaviour which supports multiple platforms=
. I can also see trying to split the changes out into a Plat directory in the=
 SPD could be really ugly.

If this is meant to be for a more generic supportable option which is how the=
 patches are written it does undermine the trustzone security model which is =
the more commonly deployed security model in the TF-A reference implementatio=
n as you say Julius. I take the point there are some warning comments in the =
code that this change weakens trustzone which rules out any compliance if sou=
ght but I think if we keep the patches as is I would like to see these warnin=
gs more prominent so that non-Chromebook platforms are more fully aware and s=
o understand the implications of enabling them.

Two things I can suggest are:

  *   First is can this warning be repeated during build time so that people =
building with this option turned on get a message in their build log. We have=
 precedence for this type of build time warning for features marked as experi=
mental. I realise this is not experimental but it is a more limited type of d=
eployment security model and not the default operated by most platforms fully=
 supporting trustzone.
  *   Second is to update the documentation on the Optee SPD. Looking at what=
 we have today
     *   Rendered https://trustedfirmware-a.readthedocs.io/en/latest/componen=
ts/spd/optee-dispatcher.html
     *   Source https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/t=
ree/docs/components/spd/optee-dispatcher.rst

We don=E2=80=99t really have much about the Optee SPD but if we have these ch=
anges it would be good to document the two build variants now and the nature/=
limitations/use-cases of each I think.

Finally as Jens is the Code Owner of the Optee SPD I would like him to be com=
fortable with the changes, he asked for maintainers view and the above is min=
e, others may differ.

Joanna

From: Julius Werner via TF-A <tf-a@lists.trustedfirmware.org>
Date: Monday, 9 January 2023 at 17:05
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: tf-a(a)lists.trustedfirmware.org <tf-a@lists.trustedfirmware.org>, OP-T=
EE TrustedFirmware <op-tee@lists.trustedfirmware.org>, Dan Handley <Dan.Han=
dley@arm.com>, Jeffrey Kardatzke <jkardatzke@google.com>, Ilias Apalodima=
s <ilias.apalodimas@linaro.org>
Subject: [TF-A] Re: Post-boot loading of OP-TEE
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
--
TF-A mailing list -- tf-a(a)lists.trustedfirmware.org
To unsubscribe send an email to tf-a-leave(a)lists.trustedfirmware.org

--===============8714200915352870654==--

