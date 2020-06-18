From: Muhammad Saad <saad.ucf@Knights.ucf.edu>
To: op-tee@lists.trustedfirmware.org
Subject: OP-TEE Development Guidance
Date: Thu, 18 Jun 2020 07:32:22 +0000
Message-ID: <BL0PR07MB55243FCAF31BAC3A01572032D39B0@BL0PR07MB5524.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2485909606693283627=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2485909606693283627==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello All,

First, I hope you are safe and doing fine in the unfortunate COVID-19 situati=
on. I am a Ph.D. student at the University of Central Florida. Currently, I a=
m working on a TEE-based prototype application for a proof-of-concept. Since =
I am totally new in this domain, so it is taking some effort. I have a few qu=
estions and I hope you guys can help me in that.

At present, I am able to set up OP-TEE on Qemu and run the examples on the no=
rmal world and the secure world. Additionally, I tweaked a few parameters (ie=
., the integer value in the main.c) for the CA and the addition and subtracti=
on sequence in the TA. Upon building it again (cd/build/make all run), it see=
ms to work. However, if I need to pass a normal string to the TA and the TA c=
omputes Sha256 of the string and returns the value, what steps do I need to t=
ake? In other words, how can I pass a tuple from the TA to the CA and obtain =
the Hash of the tuple. Additionally, if I am able to do that by tailoring the=
 HelloWorld examples, how can I develop new CA and TA with unique UUID and pe=
rform the same procedure. Finally, instead of doing the entire (cd/build/make=
 all run), is there a method by which I can simply build the application and =
alone and run it on Qemu?

I understand that these must be trivial questions, however, I will deeply app=
reciate if you can help me in figuring them out.


Best,

Saad

--===============2485909606693283627==--

