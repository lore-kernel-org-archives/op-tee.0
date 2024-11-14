From: Matteo Facchinetti <facmatteo@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: tee-supplicant priority
Date: Thu, 14 Nov 2024 14:19:06 +0100
Message-ID: 
 <CAAsLiDOH9PxL2HSopuY-FD8QosQT6E32ywhQtpY6SLqc6Af=Ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1167479269720674546=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1167479269720674546==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi,
I have a doubt about the correct priority that tee-supplicant should have
in the system.

In detail, we have 2 user-space applications (user-pkcs11-0, user-pkcs11-1)
that use the same PKCS11 services from OPTEE-OS (access to RPDB partition
for private key).
For project reason we use the following nice priority values:

     user-pkcs11-0, nice=-5
     user-pkcs11-1, nice=-10
     ....
     tee-supplcant, nice=0
     ...
     a lot of other services with nice=0
     ...

Unfortunately, in some strange case when CPU is overload (booting)....
appear a strange problem in user-pkcs11-1: occasionally the time for the
certificate's signature check explode to 400ms.

Due to the problem to replicate this defect, I have try to investigate in
theory if could be verify a starvation/race-condition between
tee-supplicant and user-pkcs11-1 or other-services.
In this scenario, what is the correct priority value that tee-supplicant
should have?

I suspect that we should change the priority of tee-supplcant =
user-pkcs11-1 = -10
Is it make sense for you, or maybe better to search the problem from an
other side :-) ?

Thanks in advance for your attention

BR
Matteo Facchinetti

--===============1167479269720674546==--

