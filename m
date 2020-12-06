From: Randy Dunlap <rdunlap@infradead.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v8 3/4] doc: trusted-encrypted: updates with TEE as a new
 trust source
Date: Sun, 06 Dec 2020 10:51:59 -0800
Message-ID: <a13a0e50-2a2d-711e-b547-22d18d776352@infradead.org>
In-Reply-To: <1604419306-26105-4-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6887388493379315207=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6887388493379315207==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi--

Please see doc. comments below.


On 11/3/20 8:01 AM, Sumit Garg wrote:
> Update documentation for Trusted and Encrypted Keys with TEE as a new
> trust source. Following is brief description of updates:
>=20
> - Add a section to demostrate a list of supported devices along with

                     demonstrate

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

s/ascii/ASCII/ please. Yes, I know that it was already there in lower case.

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
> +basis Trusted Keys establishes a Trust model with its user. A Trust Source=
 could
> +differ from one system to another depending on its security requirements. =
It
> +could be either an off-chip device or an on-chip device. Following section
> +demostrates a list of supported devices along with their security properti=
es/

   demonstrates

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

                        DRAM-based

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

	                                    e.g.

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
> +Key Generation
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Trusted Keys
> +------------
> +
> +New keys are created from trust source generated random numbers, and are
> +encrypted/decrypted using trust source storage root key.
> +
> +  *  TPM (hardware device) based RNG
> +
> +     Strength of random numbers may vary from one device manufacturer to
> +     another.
> +
> +  *  TEE (OP-TEE based on Arm TrustZone) based RNG
> +
> +     RNG is customizable as per platform needs. It can either be direct ou=
tput
> +     from platform specific hardware RNG or a software based Fortuna CSPRNG
> +     which can be seeded via multiple entropy sources.
> +
> +Encrypted Keys
> +--------------
> +
> +Encrypted keys do not depend on a trust source, and are faster, as they us=
e AES
> +for encryption/decryption. New keys are created from kernel generated rand=
om

                                                        kernel-generated

> +numbers, and are encrypted/decrypted using a specified =E2=80=98master=E2=
=80=99 key. The
> +=E2=80=98master=E2=80=99 key can either be a trusted-key or user-key type.=
 The main disadvantage
> +of encrypted keys is that if they are not rooted in a trusted key, they ar=
e only
> +as secure as the user key encrypting them. The master user key should ther=
efore
> +be loaded in as secure a way as possible, preferably early in boot.
> +
> +
> +Usage
> +=3D=3D=3D=3D=3D
> +
> +Trusted Keys usage: TPM
> +-----------------------
> +
> +TPM 1.2: By default, trusted keys are sealed under the SRK, which has the
> +default authorization value (20 zeros).  This can be set at takeownership =
time

Does "20 zeros" mean 20 bytes of 0s or 20 bits of 0s or something else?

> +with the TrouSerS utility: "tpm_takeownership -u -z".
> +
> +TPM 2.0: The user must first create a storage key and make it persistent, =
so the
> +key is available after reboot. This can be done using the following comman=
ds.
> =20
>  With the IBM TSS 2 stack::
> =20
> @@ -78,14 +209,21 @@ TPM_STORED_DATA format.  The key length for new keys a=
re always in bytes.
>  Trusted Keys can be 32 - 128 bytes (256 - 1024 bits), the upper limit is t=
o fit
>  within the 2048 bit SRK (RSA) keylength, with all necessary structure/padd=
ing.
> =20
> -Encrypted keys do not depend on a TPM, and are faster, as they use AES for
> -encryption/decryption.  New keys are created from kernel generated random
> -numbers, and are encrypted/decrypted using a specified 'master' key.  The
> -'master' key can either be a trusted-key or user-key type.  The main
> -disadvantage of encrypted keys is that if they are not rooted in a trusted=
 key,
> -they are only as secure as the user key encrypting them.  The master user =
key
> -should therefore be loaded in as secure a way as possible, preferably earl=
y in
> -boot.
> +Trusted Keys usage: TEE
> +-----------------------
> +
> +Usage::
> +
> +    keyctl add trusted name "new keylen" ring
> +    keyctl add trusted name "load hex_blob" ring
> +    keyctl print keyid
> +
> +"keyctl print" returns an ascii hex copy of the sealed key, which is in fo=
rmat

                             ASCII

> +specific to TEE device implementation.  The key length for new keys are al=
ways

                                                                       is alw=
ays

> +in bytes. Trusted Keys can be 32 - 128 bytes (256 - 1024 bits).
> +
> +Encrypted Keys usage
> +--------------------
> =20
>  The decrypted portion of encrypted keys can contain either a simple symmet=
ric
>  key or a more complex structure. The format of the more complex structure =
is
> @@ -103,8 +241,8 @@ Where::
>  	format:=3D 'default | ecryptfs | enc32'
>  	key-type:=3D 'trusted' | 'user'
> =20
> -
>  Examples of trusted and encrypted key usage:
> +--------------------------------------------

No colon at end of heading, please.

> =20
>  Create and save a trusted key named "kmk" of length 32 bytes.
> =20
> @@ -150,7 +288,7 @@ Load a trusted key from the saved blob::
>      f1f8fff03ad0acb083725535636addb08d73dedb9832da198081e5deae84bfaf0409c2=
2b
>      e4a8aea2b607ec96931e6f4d4fe563ba
> =20
> -Reseal a trusted key under new pcr values::
> +Reseal (TPM specific) a trusted key under new PCR values::
> =20
>      $ keyctl update 268728824 "update pcrinfo=3D`cat pcr.blob`"
>      $ keyctl print 268728824
> @@ -164,11 +302,12 @@ Reseal a trusted key under new pcr values::
>      7ef6a24defe4846104209bf0c3eced7fa1a672ed5b125fc9d8cd88b476a658a4434644=
ef
>      df8ae9a178e9f83ba9f08d10fa47e4226b98b0702f06b3b8
> =20
> +
>  The initial consumer of trusted keys is EVM, which at boot time needs a hi=
gh
> -quality symmetric key for HMAC protection of file metadata.  The use of a
> +quality symmetric key for HMAC protection of file metadata. The use of a
>  trusted key provides strong guarantees that the EVM key has not been
> -compromised by a user level problem, and when sealed to specific boot PCR
> -values, protects against boot and offline attacks.  Create and save an
> +compromised by a user level problem, and when sealed to a platform integri=
ty
> +state, protects against boot and offline attacks. Create and save an
>  encrypted key "evm" using the above trusted key "kmk":
> =20
>  option 1: omitting 'format'::
>=20


thanks.
--=20
~Randy


--===============6887388493379315207==--

