From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Optee + OpenSSH/OpenSSL
Date: Tue, 29 Aug 2023 15:25:42 +0530
Message-ID: 
 <CAFA6WYMSFc153i+r=yV3G0MW3FyfBgwoGsz+ma4Pg9E9190Tvg@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3CSN7PR22MB3762409BC97A4632C914F5A59DE7A=40SN7PR22MB?=
 =?utf-8?q?3762=2Enamprd22=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1775769361836630699=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1775769361836630699==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Hareesh,

On Tue, 29 Aug 2023 at 13:35, Hareesh Das Ulleri <hareesh.ulleri@ovt.com> w=
rote:
>
> Hello all,
>
>    We are started using Op-tee in our project.
>
>    Since we are new to Op-tee, could someone please confirm whether anyone =
has already tried below in their project or is it possible to use along with =
OpenSSH/OpenSSL ?
>
>    What we try to accomplish is:  application/sshd -> openssl (libcrypto/pr=
ovider) -> Optee (client/TA) -> (HW or SW cipher algorithm) for data encrypti=
on/decryption.
>

I would rather suggest you to use the existing OP-TEE based PKCS#11
engine for openssl. For detailed information, I would suggest you to
go through [1].

[1] https://optee.readthedocs.io/en/latest/building/userland_integration.html=
#pkcs-11-driver

-Sumit

> Thanks,
> Hareesh
>

--===============1775769361836630699==--

