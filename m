From: Hareesh Das Ulleri <hareesh.ulleri@ovt.com>
To: op-tee@lists.trustedfirmware.org
Subject: RE: Padding on Optee + AES Block Cyphers
Date: Tue, 15 Oct 2024 01:56:12 +0000
Message-ID: <SN7PR22MB37624B2C5C04DD49A0CDF5B29D452@SN7PR22MB3762.namprd22.prod.outlook.com>
In-Reply-To: <
 <CA+NB=mbwffDf0=Ko3r-ifd6NmfF0JVW4b=yM1GY-5WA+WOMpBw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5073824306118506929=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5073824306118506929==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jerome

  Thanks for the reply. Yes this helps.

Regards,
Hareesh

From: J=C3=A9r=C3=B4me Forissier <jerome.forissier@linaro.org>
Sent: Monday, October 14, 2024 9:02 PM
To: Hareesh Das Ulleri <hareesh.ulleri@ovt.com>
Cc: op-tee(a)lists.trustedfirmware.org
Subject: Re: Padding on Optee + AES Block Cyphers

[CAUTION]: EXTERNAL EMAIL

Hello Hareesh,

On Fri, 11 Oct 2024 at 11:33, Hareesh Das Ulleri <hareesh.ulleri(a)ovt.com<ma=
ilto:hareesh.ulleri@ovt.com>> wrote:
Dear Op-Tee support team,

   Required some expert opinion - Could you please confirm whether AES block =
cyphers (ECB and CBC mode) support non-block aligned input for cryption ?

AES block ciphers in "plain" ECB and CBC mode do NOT support input data that =
are not a multiple of the block size (16 bytes). Please refer to this note in=
 the GlobalPlatform TEE Internal Core API v1.3.1, section 6.4.3 TEE_CipherDof=
inal: "[Panic Reasons] If the total length of the input is not a multiple of =
a block size when the algorithm of the operation is a symmetric block cipher =
which does not specify padding.".


   My Use case as below App (say input buffer as 17 bytes) -> OpTee (CA + TA)=
 -> HSM.

   In the above mentioned case, Does Op-Tee can take care the input buffer wi=
th any size or does it expect block-size aligned input buffer ? In which laye=
r does the padding recommended ? Could you please provide any suggestions / l=
inks ?

You would need to take care of the padding yourself, typically in the TA. Tha=
t being said, you need to be very careful with ECB as it is susceptible to pa=
ttern repetition attacks. It should be used only in very specific circumstanc=
es. For CBC, a common padding scheme is PKCS#7. Other AES modes on the other =
hand (CCM, CTR, CTS, GCM and XTS) do NOT require padding -- i.e., the input d=
ata can be of arbitrary length.

Note that I am talking about data being a "multiple of the block size" and I =
am not saying "blocksize-aligned" data. Alignment usually conveys a different=
 meaning, i.e., whether or not the start address of the buffer is a multiple =
of the block size. This has no impact whatsoever with OP-TEE. Any alignment r=
equirements of hardware crypto engines or crypto instructions etc. are dealt =
with internally.

HTH,
--
Jerome


Thanks & Regards,
Hareesh

--===============5073824306118506929==--

