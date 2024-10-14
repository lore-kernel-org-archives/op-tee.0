From: Jérôme Forissier <jerome.forissier@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Padding on Optee + AES Block Cyphers
Date: Mon, 14 Oct 2024 15:02:09 +0200
Message-ID: 
 <CA+NB=mbwffDf0=Ko3r-ifd6NmfF0JVW4b=yM1GY-5WA+WOMpBw@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3CSN7PR22MB3762671B5F65160819AE98689D792=40SN7PR22MB?=
 =?utf-8?q?3762=2Enamprd22=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2735137168329073743=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2735137168329073743==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hello Hareesh,

On Fri, 11 Oct 2024 at 11:33, Hareesh Das Ulleri <hareesh.ulleri@ovt.com>
wrote:

> Dear Op-Tee support team,
>
>    Required some expert opinion - Could you please confirm whether AES
> block cyphers (ECB and CBC mode) support non-block aligned input for
> cryption ?
>

AES block ciphers in "plain" ECB and CBC mode do NOT support input data
that are not a multiple of the block size (16 bytes). Please refer to this
note in the GlobalPlatform TEE Internal Core API v1.3.1, section 6.4.3
TEE_CipherDofinal: "[Panic Reasons] If the total length of the input is not
a multiple of a block size when the algorithm of the operation is a
symmetric block cipher which does not specify padding.".


>    My Use case as below App (say input buffer as 17 bytes) -> OpTee (CA +
> TA) -> HSM.
>
>    In the above mentioned case, Does Op-Tee can take care the input buffer
> with any size or does it expect block-size aligned input buffer ? In which
> layer does the padding recommended ? Could you please provide any
> suggestions / links ?
>

You would need to take care of the padding yourself, typically in the TA.
That being said, you need to be very careful with ECB as it is susceptible
to pattern repetition attacks. It should be used only in very specific
circumstances. For CBC, a common padding scheme is PKCS#7. Other AES modes
on the other hand (CCM, CTR, CTS, GCM and XTS) do NOT require padding --
i.e., the input data can be of arbitrary length.

Note that I am talking about data being a "multiple of the block size" and
I am not saying "blocksize-aligned" data. Alignment usually conveys a
different meaning, i.e., whether or not the start address of the buffer is
a multiple of the block size. This has no impact whatsoever with OP-TEE.
Any alignment requirements of hardware crypto engines or crypto
instructions etc. are dealt with internally.

HTH,
-- 
Jerome


>
> Thanks & Regards,
> Hareesh
>

--===============2735137168329073743==--

