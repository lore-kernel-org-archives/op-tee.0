From: Hareesh Das Ulleri <hareesh.ulleri@ovt.com>
To: op-tee@lists.trustedfirmware.org
Subject: Padding on Optee + AES Block Cyphers
Date: Fri, 11 Oct 2024 09:33:27 +0000
Message-ID: <SN7PR22MB3762671B5F65160819AE98689D792@SN7PR22MB3762.namprd22.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5490488353036166822=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5490488353036166822==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Dear Op-Tee support team,

   Required some expert opinion - Could you please confirm whether AES block =
cyphers (ECB and CBC mode) support non-block aligned input for cryption ?

   My Use case as below App (say input buffer as 17 bytes) -> OpTee (CA + TA)=
 -> HSM.

   In the above mentioned case, Does Op-Tee can take care the input buffer wi=
th any size or does it expect block-size aligned input buffer ? In which laye=
r does the padding recommended ? Could you please provide any suggestions / l=
inks ?

Thanks & Regards,
Hareesh

--===============5490488353036166822==--

