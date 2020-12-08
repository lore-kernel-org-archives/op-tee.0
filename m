From: Mimi Zohar <zohar@linux.ibm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v8 3/4] doc: trusted-encrypted: updates with TEE as a new
 trust source
Date: Tue, 08 Dec 2020 12:07:13 -0500
Message-ID: <6c0428647fc83c2220e15e62dc1b566d250b7968.camel@linux.ibm.com>
In-Reply-To: <f00c8c7dd1e184e139e6cb5aba2b4a1c5fc68363.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7002272777296654209=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7002272777296654209==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Sumit, Jarkko,

On Tue, 2020-12-08 at 10:55 -0500, Mimi Zohar wrote:
> Re-posting Elaine Palmer's comments, inline below, trimmed and properly
> formatted.

Continued ...

Thank you for the detailed descriptions and examples of trust sources
for Trusted Keys.  A group of us in IBM (Stefan Berger, Ken Goldman,
Zhongshu Gu, Nayna Jain, Elaine Palmer, George Wilson, Mimi Zohar) have
some concerns with extending trusted keys to new sources without
providing a threat model.   The following is based on our internal
discussions.

> * Threat model
>=20
> The strength and appropriateness of TPMs and TEEs for a given purpose
> must be assessed when using them to protect security-relevant data.

The original Trusted Keys implementation assumed discrete physical TPMs
for key protection[1].  However, even physical TPMs themselves vary
based on the manufacturer and systems in which they are placed.  The
embedded chipset, firmware load, algorithms, packaging, pins, and
countermeasures vary.  (Threats and mitigations on physical TPMs are
well documented, e.g., "Threat Model of a Scenario Based on Trusted
Platform Module 2.0 Specification=E2=80=9D (http://ceur-ws.org/Vol-1011/6.pdf=
).

Extending Trusted Keys to support new trust sources needs to provide
consumers of these new sources enough information so that they can
create their own threat models tailored to their use cases.

Just as each new LSM needs to comply with Documentation/security/lsm-
development.rst, we recommend each new source should provide a high-
level threat model.  We suggest documenting environmental assumptions
and dependencies in a high-level threat model for each additional trust
source.  An example of a high-level threat model is "Common Security
Threats v1.0=E2=80=9D (
https://www.opencompute.org/documents/common-security-threats-notes-1-pdf
 ).

Thank you,

Elaine (and Mimi)


[1] Specific to Trusted Keys and TPMs, there is some discussion of
threats and mitigations in the Integrity_overview.pdf on the IMA wiki:

"The trusted key component does two things to help with secure key management=
 on Linux. First, it provides a kernel key ring service in which the symmetri=
c encryption keys are never visible in plain text to userspace. The keys are =
created in the kernel, and sealed by a hardware device such as a TPM, with us=
erspace seeing only the sealed blobs. Malicious or compromised applications c=
annot steal a trusted key, since only the kernel can see the unsealed blobs. =
Secondly, the trusted keys can tie key unsealing to the integrity measurement=
s, so that keys cannot be stolen in an offline attack, such as by booting an =
unlocked Linux image from CD or USB.  As the measurements will be different, =
the TPM chip will refuse to unseal the keys, even for the kernel."


--===============7002272777296654209==--

