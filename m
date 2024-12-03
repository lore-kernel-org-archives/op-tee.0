From: murali selvaraj <muraliselvaraj2020@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: OP-TEE queries
Date: Tue, 03 Dec 2024 15:08:06 -0500
Message-ID: 
 <CABBtTm973zFtNDixvV-9deQVJu3OUUux1sVckuKH9uSWJcFMnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2804590150042922735=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2804590150042922735==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi All,

We are currently working on standard PKCS#11 TA and I'm new to this topic
(PKCS11, OP-TEE,TA).

Please go through and share your inputs on the following queries.

-> slot
        How do we know how many slots are supported in my device?
        Is it based on the physical interface of the device or how do we
find the list of available slots without pkcs11-tool?
        Please share the details with an example.

-> token
        Is token is a kind of virtual to hold different objects(keys, cert
and so on).
        Can one token have private, public, leaf cert, intermediate ca
cert, root ca cart and so on or any limitations on the number of objects in
a token?
        Can we have each token be specific to the object ( for example ,
token1 will have cert, token 2 will have key, token 3 will have seed/client
cert )?
        How many tokens maximum support on each slot?

->    As part of pkcs11-tool, we have been using SO-PIN, user PIN,
token/label name which are more specific to security.
       If the normal world/REE is compromised, any sensitive data it holds,
including PINs and tokens, could be exposed.
       Do we have any access control mechanism to avoid this security issue
( in PKCS11 TA, OP-TEE context).

Thanks,
Murali.S

--===============2804590150042922735==--

