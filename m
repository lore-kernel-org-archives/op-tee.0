From: Miklos Balint <Miklos.Balint@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: PSA OP-TEE development
Date: Tue, 28 Jul 2020 15:07:05 +0000
Message-ID: <VE1PR08MB4861D15A391123BF372A785BE6730@VE1PR08MB4861.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1142949017197780769=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1142949017197780769==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

In parallel with - and based on - the work by Jens to enable PSA FF-A as a tr=
ansport for the SMC ABI (recently merged to the upstream as PR #3908) there's=
 an effort to provide a fully-functional SPMC component in OP-TEE to manage S=
-EL0 Secure Partitions, with the goal of providing a similar set of PSA Root =
of Trust services over OP-TEE as presently supported for M-profile processors=
, while also providing a standard execution framework and ABI for potential i=
ntegration of 3rd party partitions, such as StMM.
Please note that this work is currently at the prototyping stage and is manag=
ed as a fork on trustedfirmware.org, but is planned to be merged with the off=
icial OP-TEE stream as it matures.

There's an initial set of patches on review to provide

  *   A library for S-EL0 SPs to access FF-A ABI at the SVC call interface:
https://review.trustedfirmware.org/c/OP-TEE/optee_os/+/4751
  *   A change to introduce an SP build system to OP-TEE:
https://review.trustedfirmware.org/c/OP-TEE/optee_os/+/4752
  *   OP-TEE kernel changes to support initialization and context management =
of SPs and the forwarding of FF-A messages to their designated endpoints:
https://review.trustedfirmware.org/c/OP-TEE/optee_os/+/4987

All related open reviews at the moment can be found here:
https://review.trustedfirmware.org/q/project:OP-TEE%252Foptee_os+status:open

For the S-EL1 SPMC configuration functionality and requirements see the PSA F=
F-A specification (https://developer.arm.com/documentation/den0077/latest)

Work is in progress to showcase the capabilities of the framework using a sub=
set of PSA Crypto API and also to propose a standardized protocol layer for p=
artitions, but as mentioned work is still at the early stages so expect gradu=
al increments in functionality and flexibility.
Any questions and feedback are very welcome

Cheers,
Miklos

IMPORTANT NOTICE: The contents of this email and any attachments are confiden=
tial and may also be privileged. If you are not the intended recipient, pleas=
e notify the sender immediately and do not disclose the contents to any other=
 person, use it for any purpose, or store or copy the information in any medi=
um. Thank you.

--===============1142949017197780769==--

