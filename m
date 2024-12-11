From: Etienne CARRIERE - foss <etienne.carriere@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: OP-TEE queries
Date: Wed, 11 Dec 2024 10:13:34 +0000
Message-ID: <92fa2d4ac7d44939a26b4deaa7a5be22@foss.st.com>
In-Reply-To: <
 <CABBtTm973zFtNDixvV-9deQVJu3OUUux1sVckuKH9uSWJcFMnQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3840120890299351563=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3840120890299351563==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Murali,


> From: murali selvaraj <muraliselvaraj2020@gmail.com>
> On Tuesday, December 3, 2024, murali selvaraj wrote:
>=20
> Hi All,
>=20
> We are currently working on standard PKCS#11 TA and I'm new to this topic
> (PKCS11, OP-TEE,TA).
>=20
> Please go through and share your inputs on the following queries.
>=20

As an overall comment, note that PKCS#11 is only an API specification: each p=
ackage/device that implements PKCS#11 services also implements its own Pkcs#1=
1 library (a.k.a Cryptoki library).

OP-TEE pkcs11 TA also provides its Linux userland library (libckteec from OP-=
TEE Client [1]) to allow Linux OS application to access PKCS#11 service embed=
ded in OP-TEE (assuming the pkcs11 TA is also embedded in the system).

On a device/platform, you could have multiple PKCS#11 "devices" (let's say "t=
okens" to use the PKCS#11 wording).
For example, you could have the OP-TEE pkcs11 TA, the SoftHSM package (implem=
ents  a PKCS#11 token as a Linux OS userland application [2]), some physical =
external HSM devices connected through an hardware bus link (I2C, SPI, ...). =
A client application can communicate with each of these "PKCS#11 tokens" usin=
g the same API functions, but that application needs to link with the library=
 dedicated to that token: e.g. libckteec (OP-TEE Client) for the OP-TEE TA, l=
ibsofthsm2.so (provided by SoftHSM package) for the SoftHSM token, a dedicate=
d libXXXXX.so for a harware specific HSM.

Package p11-kit [3] claims to centralize several PKCS#11 libraries interface =
into a single. Maybe have a look at it. I've never used it so I can't really =
tell.

I can have a look at PKCS#11 v2.40 User Guide document [4]. This user guide m=
ay be deprecated (not part of latest PKCS#11 v3.0 specs) but it gives a nice =
overview IMHO.

[1] https://github.com/OP-TEE/optee_client
[2] https://github.com/softhsm/SoftHSMv2
[3] https://github.com/p11-glue/p11-kit
[4] https://docs.oasis-open.org/pkcs11/pkcs11-ug/v2.40/pkcs11-ug-v2.40.html

> -> slot
>         How do we know how many slots are supported in my device?
>         Is it based on the physical interface of the device or how do we
> find the list of available slots without pkcs11-tool?
>         Please share the details with an example.

To discover slot, you can use connect a slot, you can use API function C_GetS=
lotList(), C_GetSlotInfo(). But you will discover only the slots visible to t=
he Cryptoki library you link to.
Once slots are discovered, using C_GetTokenInfo() on slots with a present tok=
en allows to find your target token based on its token label, model, serial n=
umber, ... But again, such a call sees only the token visible to the Cryptoki=
 library you link to.
pkcs11-tool uses these API function. Note that it request you to specify (wit=
h argument "--module" or a likewise method) the Cryptoki library to link to.

>
> -> token
>         Is token is a kind of virtual to hold different objects(keys, cert
> and so on).

A token is (or pretends to be) an isolated entity that can store some secrets=
 and allow clients to manipulate them.
A hardware HSM is likely a physical token.
OP-TEE pkcs11 TA can implement 1 or more tokens (see CFG_PKCS11_TA_TOKEN_COUN=
T) that are isolated by software means by the pkcs11 TA implementation but th=
at physically reside in the very same pkcs11 TA address space and execution c=
ontext.

>         Can one token have private, public, leaf cert, intermediate ca
> cert, root ca cart and so on or any limitations on the number of objects in
> a token?

Limitation of a token depends on the token implementation, being software or
hardware.


>         Can we have each token be specific to the object ( for example ,
> token1 will have cert, token 2 will have key, token 3 will have seed/client
> cert )?

Yes. Note however that object in a token are not visible from another token.

>         How many tokens maximum support on each slot?

From the PKCS#11 spec:
"Slot       A logical reader that potentially contains a token."
"Token       The logical view of a cryptographic device defined by Cryptoki."
Therefore there is at most 1 token per slot. For each slot either the token i=
s present or it is absent (e.g. for pluggable or loadable tokens).

>=20
> ->    As part of pkcs11-tool, we have been using SO-PIN, user PIN,
> token/label name which are more specific to security.
>        If the normal world/REE is compromised, any sensitive data it holds,
> including PINs and tokens, could be exposed.
>        Do we have any access control mechanism to avoid this security issue
> ( in PKCS11 TA, OP-TEE context).

OP-TEE pkcs11 TA currently implements 2 authentication methods.

- PIN based: client must provide the PIN value to login into the token. Faili=
ng the login with the right PIN increments a failure counter that can lock th=
e token.

- Linux ACL based: client must have the right user-id or group-id to login in=
to the token.
  See https://github.com/OP-TEE/optee_os/pull/7040#issuecomment-2370897395

There is a proposal for an variant of the PIN based login method. See https:/=
/github.com/OP-TEE/optee_os/pull/7040.
It proposes to use the PIN based implementation but with large PIN byte strin=
gs and removing the PIN locking mechanism.
The P-R has not been merge, it needs to mature IMO but is really interesting.=
 I think it needs some kind of time based delay between login attempts.

In the hope this helps,
Best regards,
Etienne

>=20
> Thanks,
> Murali.S
>=20

--===============3840120890299351563==--

