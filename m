From: dourlent cédric <cedric.dourlent@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: PKCS11 TA: MR https://github.com/OP-TEE/optee_os/pull/5166
Date: Thu, 08 Jun 2023 15:46:02 +0000
Message-ID: 
 <CA+yr+0-ifyaK_Rz4-M-vHojNzCEvJrAckUms3HeqSYPF3SiQSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0530363968968030885=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0530363968968030885==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

I contact you about the merge request
https://github.com/OP-TEE/optee_os/pull/5166 that is mandatory to be able
to use ECC private key imported in PKCS11 TA and not generate by the TA.

Currently the status is
Attribute on generated ECC private key are
- EC_PARAMS
- VALUE
- EC_POINT
=> This object can be use for crypto operation

Attribute on imported ECC private key are
- EC_PARAMS
- VALUE
=> PKCS11 TA can not use it because TA expect EC_POINTS attributes on ECC
Private key.

Could you accept the merge request and have a coherence between generated
and imported object even if for the moment it's doesn't respect PKCS11
standard ?

Two options for the next step.
- check with PKCS11 editors to upgrade the spec and have a same behavior
between RSA Private object and ECC Private object.
- rework the code of the TA for ECC to link Private and public object but
that mean that ECC Private and Public object must be present in the same
slot to be able to perform crypto operation.

Best regards,

Cédric Dourlent,

--===============0530363968968030885==--

