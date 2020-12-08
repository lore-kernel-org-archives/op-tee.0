From: Mimi Zohar <zohar@linux.ibm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v8 3/4] doc: trusted-encrypted: updates with TEE as a new
 trust source
Date: Tue, 08 Dec 2020 10:55:23 -0500
Message-ID: <f00c8c7dd1e184e139e6cb5aba2b4a1c5fc68363.camel@linux.ibm.com>
In-Reply-To: <1604419306-26105-4-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7768130971371481631=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7768130971371481631==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Sumit, Jarkko,

Re-posting Elaine Palmer's comments, inline below, trimmed and properly
formatted.

On Tue, 2020-11-03 at 21:31 +0530, Sumit Garg wrote:
> Update documentation for Trusted and Encrypted Keys with TEE as a new
> trust source. Following is brief description of updates:
>=20
> - Add a section to demostrate a list of supported devices along with
>   their security properties/guarantees.
> - Add a key generation section.
> - Updates for usage section including differences specific to a trust
>   source.
>=20
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  Documentation/security/keys/trusted-encrypted.rst | 203 ++++++++++++++++++=
----
>  1 file changed, 171 insertions(+), 32 deletions(-)
>=20
> diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentat=
ion/security/keys/trusted-encrypted.rst
> index 1da879a..16042c8 100644
> --- a/Documentation/security/keys/trusted-encrypted.rst
> +++ b/Documentation/security/keys/trusted-encrypted.rst
> @@ -6,30 +6,161 @@ Trusted and Encrypted Keys are two new key types added t=
o the existing kernel
>  key ring service.  Both of these new types are variable length symmetric k=
eys,
>  and in both cases all keys are created in the kernel, and user space sees,
>  stores, and loads only encrypted blobs.  Trusted Keys require the availabi=
lity
> -of a Trusted Platform Module (TPM) chip for greater security, while Encryp=
ted
> -Keys can be used on any system.  All user level blobs, are displayed and l=
oaded
> -in hex ascii for convenience, and are integrity verified.
> +of a Trust Source for greater security, while Encrypted Keys can be used o=
n any
> +system. All user level blobs, are displayed and loaded in hex ascii for
> +convenience, and are integrity verified.
> =20
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
> =20
> -TPM 1.2
> --------
> +Trust Source
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> -By default, trusted keys are sealed under the SRK, which has the default
> -authorization value (20 zeros).  This can be set at takeownership time wit=
h the
> -trouser's utility: "tpm_takeownership -u -z".
> +Trust Source provides the source of security for the Trusted Keys, on which
> +basis Trusted Keys establishes a Trust model with its user.

A trust source provides the source of security for the Trusted
Keys.  Whether or not a trust source is sufficiently safe depends on
the strength and correctness of its implementation, as well as the
threat environment for a specific use case.  Since the kernel doesn't
know what the environment is, and there is no metric of trust, it is
dependent on the consumer of the Trusted Keys to determine if the trust
source is sufficiently safe.

>  A Trust Source could
> +differ from one system to another depending on its security requirements. =
It
> +could be either an off-chip device or an on-chip device. Following section
> +demostrates a list of supported devices along with their security properti=
es/
> +guarantees:
> =20
> -TPM 2.0
> --------
> +  *  Root of trust for storage
> =20
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

Please add the following topics:

* Provisioning - the trust source's unique and verifiable cryptographic
identity is provisioned during manufacturing

(1) TPM

The unique and verifiable cryptographic identity is the endorsement key
(EK) or its primary seed.  A review of the generation of the EK and its
accompanying certificate is part of the Common Criteria evaluation of
the product's lifecycle processes (ALC_*).  See "TCG Protection Profile
for PC Client Specific TPM 2" (
https://trustedcomputinggroup.org/resource/pc-client-protection-profile-for-t=
pm-2-0/
).

(2) TEE

A protection profile for TEEs does not yet exist.  Therefore, the
provisioning process that generates the Hardware Unique Key is not
evaluated by an independent third party and is highly dependent on the
manufacturing environment.


* Cryptography

(1) TPM

As part of the TPM's mandatory Common Criteria evaluation, the
correctness of the TPM's implementation of cryptographic algorithms,
the protection of keys, and the generation of random numbers, and other
security-relevant functions must be documented, reviewed, and tested by
an independent third party evaluation agency.  It must meet the
requirements of FIPS 140-2, FIPS 140-3, or ISO/IEC 19790:2012.=20

(2) TEE

Evaluations of cryptographic modules within TEEs are not required, but
some are available for specific implementations within TEEs.


* Interfaces and APIs

(1) TPM

 TPMs have well-documented, standardized interfaces and APIs.

(2) TEE

Unless TEEs implement functionality such as a virtual TPM, they have
custom interfaces and APIs.=20


* Threat model

The strength and appropriateness of TPMs and TEEs for a given purpose
must be assessed when using them to protect security-relevant data.

> +
> +Key Generation
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Trusted Keys
> +------------
> +
> +New keys are created from trust source generated random numbers, and are
> +encrypted/decrypted using trust source storage root key.

New keys are created from random numbers generated in the trust source.
They are encrypted/decrypted using a child key in the storage key
hierarchy.  Encryption and decryption of the child key must be
protected by a strong access control policy within the trust source.

Thank you,

Elaine (and Mimi)


--===============7768130971371481631==--

