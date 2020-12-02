From: gmail Elaine Palmer <erpalmerny@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v8 3/4] doc: trusted-encrypted: updates with TEE as a new
 trust source
Date: Wed, 02 Dec 2020 14:34:07 -0500
Message-ID: <81A6B61D-3811-4957-B270-52AE5FA6DE4F@gmail.com>
In-Reply-To: <1604419306-26105-4-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5427457770710711221=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5427457770710711221==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


Hi Sumit, =20

Thank you for the detailed descriptions and examples of trust sources for Tru=
sted Keys.   A group of us in IBM (Stefan Berger, Ken Goldman, Zhongshu Gu, N=
ayna Jain, Elaine Palmer, George Wilson, Mimi Zohar) have been doing related =
work for quite some time, and we have one primary concern and some suggested =
changes to the document.=20

Our primary concern is that describing a TEE as a Trust Source needs to be mo=
re specific.   For example, "ARM TrustZone" is not sufficient, but "wolfSSL e=
mbedded SSL/TLS library with ARM TrustZone CryptoCell-310" is.  Just because =
a key is protected by software running in a TEE is not enough to establish tr=
ust.  Just like cryptographic modules, a Trust Source should be defined as a =
specific implementation on specific hardware with well-documented environment=
al assumptions, dependencies, and threats.

In addition to the above concern, our suggested changes are inline below.

> Begin forwarded message:
>=20
> From: Sumit Garg <sumit.garg@linaro.org>
> Subject: [PATCH v8 3/4] doc: trusted-encrypted: updates with TEE as a new t=
rust source
> Date: November 3, 2020 at 11:01:45 AM EST
> To: jarkko.sakkinen(a)linux.intel.com, zohar(a)linux.ibm.com, jejb(a)linux.=
ibm.com
> Cc: dhowells(a)redhat.com, jens.wiklander(a)linaro.org, corbet(a)lwn.net, j=
morris(a)namei.org, serge(a)hallyn.com, casey(a)schaufler-ca.com, janne.karhu=
nen(a)gmail.com, daniel.thompson(a)linaro.org, Markus.Wamser(a)mixed-mode.de,=
 lhinds(a)redhat.com, keyrings(a)vger.kernel.org, linux-integrity(a)vger.kern=
el.org, linux-security-module(a)vger.kernel.org, linux-doc(a)vger.kernel.org,=
 linux-kernel(a)vger.kernel.org, linux-arm-kernel(a)lists.infradead.org, op-t=
ee(a)lists.trustedfirmware.org, Sumit Garg <sumit.garg@linaro.org>
>=20
> Update documentation for Trusted and Encrypted Keys with TEE as a new
> trust source. Following is brief description of updates:
>=20
> - Add a section to demostrate a list of supported devices along with
> their security properties/guarantees.
> - Add a key generation section.
> - Updates for usage section including differences specific to a trust
> source.
>=20
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
> Documentation/security/keys/trusted-encrypted.rst | 203 ++++++++++++++++++-=
---
> 1 file changed, 171 insertions(+), 32 deletions(-)
>=20
> diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentat=
ion/security/keys/trusted-encrypted.rst
> index 1da879a..16042c8 100644
> --- a/Documentation/security/keys/trusted-encrypted.rst
> +++ b/Documentation/security/keys/trusted-encrypted.rst
> @@ -6,30 +6,161 @@ Trusted and Encrypted Keys are two new key types added t=
o the existing kernel
> key ring service.  Both of these new types are variable length symmetric ke=
ys,
> and in both cases all keys are created in the kernel, and user space sees,
> stores, and loads only encrypted blobs.  Trusted Keys require the availabil=
ity
> -of a Trusted Platform Module (TPM) chip for greater security, while Encryp=
ted
> -Keys can be used on any system.  All user level blobs, are displayed and l=
oaded
> -in hex ascii for convenience, and are integrity verified.
> +of a Trust Source for greater security, while Encrypted Keys can be used o=
n any
> +system. All user level blobs, are displayed and loaded in hex ascii for
> +convenience, and are integrity verified.
>=20
> -Trusted Keys use a TPM both to generate and to seal the keys.  Keys are se=
aled
> -under a 2048 bit RSA key in the TPM, and optionally sealed to specified PCR
> -(integrity measurement) values, and only unsealed by the TPM, if PCRs and =
blob
> -integrity verifications match.  A loaded Trusted Key can be updated with n=
ew
> -(future) PCR values, so keys are easily migrated to new pcr values, such as
> -when the kernel and initramfs are updated.  The same key can have many sav=
ed
> -blobs under different PCR values, so multiple boots are easily supported.
>=20
> -TPM 1.2
> --------
> +Trust Source
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> -By default, trusted keys are sealed under the SRK, which has the default
> -authorization value (20 zeros).  This can be set at takeownership time wit=
h the
> -trouser's utility: "tpm_takeownership -u -z".
> +Trust Source provides the source of security for the Trusted Keys, on which
> +basis Trusted Keys establishes a Trust model with its user. A Trust Source=
 could
> +differ from one system to another depending on its security requirements. =
It
> +could be either an off-chip device or an on-chip device. Following section
> +demostrates a list of supported devices along with their security properti=
es/
> +guarantees:
Please change the following=20
"Trust Source provides the source of security for the Trusted Keys, on which =
basis Trusted Keys establishes a Trust model with its user."=20
to=20
"A trust source provides the source of security for the Trusted Keys.  Whethe=
r or not a trust source is sufficiently safe depends on the strength and corr=
ectness of its implementation, as well as the threat environment for a specif=
ic use case.  Since the kernel doesn't know what the environment is, and ther=
e is no metric of trust, it is dependent on the consumer of the Trusted Keys =
to determine if the trust source is sufficiently safe."
>=20
> -TPM 2.0
> --------
> +  *  Root of trust for storage
>=20
> -The user must first create a storage key and make it persistent, so the ke=
y is
> -available after reboot. This can be done using the following commands.
> +     (1) TPM (Trusted Platform Module: hardware device)
> +
> +         Rooted to Storage Root Key (SRK) which never leaves the TPM that
> +         provides crypto operation to establish root of trust for storage.
> +
> +     (2) TEE (Trusted Execution Environment: OP-TEE based on Arm TrustZone)
> +
> +         Rooted to Hardware Unique Key (HUK) which is generally burnt in o=
n-chip
> +         fuses and is accessible to TEE only.
> +
> +  *  Execution isolation
> +
> +     (1) TPM
> +
> +         Fixed set of operations running in isolated execution environment.
> +
> +     (2) TEE
> +
> +         Customizable set of operations running in isolated execution
> +         environment verified via Secure/Trusted boot process.
> +
> +  * Optional binding to platform integrity state
> +
> +     (1) TPM
> +
> +         Keys can be optionally sealed to specified PCR (integrity measure=
ment)
> +         values, and only unsealed by the TPM, if PCRs and blob integrity
> +         verifications match. A loaded Trusted Key can be updated with new
> +         (future) PCR values, so keys are easily migrated to new PCR value=
s,
> +         such as when the kernel and initramfs are updated. The same key c=
an
> +         have many saved blobs under different PCR values, so multiple boo=
ts are
> +         easily supported.
> +
> +     (2) TEE
> +
> +         Relies on Secure/Trusted boot process for platform integrity. It =
can
> +         be extended with TEE based measured boot process.
> +
> +  *  On-chip versus off-chip
> +
> +     (1) TPM
> +
> +         Off-chip device connected via serial bus (like I2C, SPI etc.) exp=
osing
> +         physical access which represents an attack surface that can be
> +         mitigated via tamper detection.
> +
> +     (2) TEE
> +
> +         On-chip functionality, immune to this attack surface.
> +
> +  *  Memory attacks (DRAM based like attaching a bus monitor etc.)
> +
> +     (1) TPM
> +
> +         Immune to these attacks as it doesn=E2=80=99t make use of system =
DRAM.
> +
> +     (2) TEE
> +
> +         An implementation based on TrustZone protected DRAM is susceptibl=
e to
> +         such attacks. In order to mitigate these attacks one needs to rel=
y on
> +         on-chip secure RAM to store secrets or have the entire TEE
> +         implementation based on on-chip secure RAM. An alternative mitiga=
tion
> +         would be to use encrypted DRAM.
> +
> +  *  Side-channel attacks (cache, memory, CPU or time based)
> +
> +     (1) TPM
> +
> +         Immune to side-channel attacks as its resources are isolated from=
 the
> +         main OS.
> +
> +     (2) TEE
> +
> +         A careful implementation is required to mitigate against these at=
tacks
> +         for resources which are shared (eg. shared memory) with the main =
OS.
> +         Cache and CPU based side-channel attacks can be mitigated via
> +         invalidating caches and CPU registers during context switch to an=
d from
> +         the secure world.
> +         To mitigate against time based attacks, one needs to have time
> +         invariant implementations (like crypto algorithms etc.).
> +
> +  *  Resistance to physical attacks (power analysis, electromagnetic emana=
tion,
> +     probes etc.)
> +
> +     (1) TPM
> +
> +         Provides limited protection utilizing tamper resistance.
> +
> +     (2) TEE
> +
> +         Provides no protection by itself, relies on the underlying platfo=
rm for
> +         features such as tamper resistance.
> +
> +
please add the following:

* Provisioning - the trust source's unique and verifiable cryptographic ident=
ity is provisioned during manufacturing

(1) TPM
The unique and verifiable cryptographic identity is the endorsement key (EK) =
or its primary seed.  A review of the generation of the EK and its accompanyi=
ng certificate is part of the Common Criteria evaluation of the product's lif=
ecycle processes (ALC_*).  See "TCG Protection Profile for PC Client Specific=
 TPM 2" (https://trustedcomputinggroup.org/resource/pc-client-protection-prof=
ile-for-tpm-2-0/).

(2) TEE
A protection profile for TEEs does not yet exist.  Therefore, the provisionin=
g process that generates the Hardware Unique Key is not evaluated by an indep=
endent third party and is highly dependent on the manufacturing environment. =
=20


* Cryptography
(1) TPM
As part of the TPM's mandatory Common Criteria evaluation, the correctness of=
 the TPM's implementation of cryptographic algorithms, the protection of keys=
, and the generation of random numbers, and other security-relevant functions=
 must be documented, reviewed, and tested by an independent third party evalu=
ation agency.  It must meet the requirements of FIPS 140-2, FIPS 140-3, or IS=
O/IEC 19790:2012.=20

(2) TEE
Evaluations of cryptographic modules within TEEs are not required, but some a=
re available for specific implementations within TEEs.



* Interfaces and APIs
(1) TPMs have well-documented, standardized interfaces and APIs.
(2) Unless they implement functionality such as a virtual TPM, TEEs have cust=
om interfaces and APIs.=20



* Threat model
The strength and appropriateness of  TPMs and TEEs for a given purpose must b=
e assessed when using them to protect security-relevant data.   =20

We suggest documenting environmental assumptions and dependencies in a high-l=
evel threat model for each additional trust source.  Just as each new LSM nee=
ds to comply with Documentation/security/lsm-development.rst, each new Truste=
d Key source should provide a high-level threat model.   An example of a high=
-level threat model is "Common Security Threats v1.0=E2=80=9D (https://www.op=
encompute.org/documents/common-security-threats-notes-1-pdf ).=20

The original Trusted Keys implementation assumed discrete physical TPMs for k=
ey protection.  However, even physical TPMs themselves vary based on the manu=
facturer and systems in which they are placed.  The embedded chipset, firmwar=
e load, algorithms, packaging, pins, and countermeasures vary.  (Threats and =
mitigations on physical TPMs are well documented, e.g., "Threat Model of a Sc=
enario Based on Trusted Platform Module 2.0 Specification=E2=80=9D (http://ce=
ur-ws.org/Vol-1011/6.pdf).

Specific to Trusted Keys and TPMs, there is some discussion of threats and mi=
tigations in the Integrity_overview.pdf on the IMA wiki:

	=E2=80=A2 The trusted key component does two things to help with secure key =
management on Linux. First, it provides a kernel key ring service in which th=
e symmetric encryption keys are never visible in plain text to userspace. The=
 keys are created in the kernel, and sealed by a hardware device such as a TP=
M, with userspace seeing only the sealed blobs. Malicious or compromised appl=
ications cannot steal a trusted key, since only the kernel can see the unseal=
ed blobs. Secondly, the trusted keys can tie key unsealing to the integrity m=
easurements, so that keys cannot be stolen in an offline attack, such as by b=
ooting an unlocked Linux image from CD or USB.  As the measurements will be d=
ifferent, the TPM chip will refuse to unseal the keys, even for the kernel.

Consumers of Trusted Keys in different environments need enough information s=
o that they can create their own threat models tailored to their use cases.  =
For the present submission, a high-level security model of ARM TrustZone and =
how Trusted Keys key protection is implemented along with an enumeration of s=
ecurity considerations for end-use threat models would be appropriate. =20

An excellent and related paper describes the strengths, weaknesses, and count=
ermeasures of a firmware TPM implemented within a TEE.  See "fTPM: A Software=
-only Implementation of a TPM Chip=E2=80=9D (https://www.usenix.org/conferenc=
e/usenixsecurity16/technical-sessions/presentation/raj)


> +Key Generation
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Trusted Keys
> +------------
> +
> +New keys are created from trust source generated random numbers, and are
> +encrypted/decrypted using trust source storage root key.
Please change the following
"New keys are created from trust source generated random numbers, and are enc=
rypted/decrypted using trust source storage root key."
to
"New keys are created from random numbers generated in the trust source. They=
 are encrypted/decrypted using a child key in the storage key hierarchy.  Enc=
ryption and decryption of the child key must be protected by a strong access =
control policy within the trust source. =E2=80=9C

Thank you.=20
Elaine
_____________________________________
Elaine R. Palmer, Senior Technical Staff Member
Secure Systems and Academy of Technology
IBM T.J. Watson Research Center

--===============5427457770710711221==--

