From: Hareesh Das Ulleri <hareesh.ulleri@ovt.com>
To: op-tee@lists.trustedfirmware.org
Subject: RE: Optee + OpenSSH/OpenSSL
Date: Tue, 05 Sep 2023 02:14:38 +0000
Message-ID: <SN7PR22MB376296D30C92592A0C2303189DE8A@SN7PR22MB3762.namprd22.prod.outlook.com>
In-Reply-To: <=?utf-8?q?=3CSN7PR22MB37629A8713C53FAD769066719DE6A=40SN7PR22MB?=
 =?utf-8?q?3762=2Enamprd22=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6287608334115328718=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6287608334115328718==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello All,=20

  Update: I have quickly integrated OPTEE v3.18 with OpenSSL_3.0.8 and OpenSS=
H_9.1. Now when tee_supplicant or sshd starts it access optee client via the =
openssl provider. And then ssd stops and it shows...

" sshd: TEEC_InvokeCommand(PREPARE) failed 0xffff0000 origin 0x2".

  As per my understanding, when sshd starts, optee client file handling is no=
t correct and this may lead to failure. Could someone please clarify more on =
the above scenario and any suggestions are greatly appreciated?

Note: I have tested the optee with some other test application and openssl co=
mmandline scripts (without OpenSSH), and that is working.

Thank you,
Hareesh


-----Original Message-----
From: Hareesh Das Ulleri=20
Sent: Wednesday, August 30, 2023 6:12 PM
To: Jorge Ramirez-Ortiz, Foundries <jorge@foundries.io>; Sumit Garg <sumit.=
garg@linaro.org>
Cc: op-tee(a)lists.trustedfirmware.org
Subject: RE: Optee + OpenSSH/OpenSSL

Thank you all for your prompt responses and links you shared.

   In our earlier system, we tried openssh + openssl 3.x custom provider + HW=
 crypto (without OP_TEE) and it works.

   In this new system we have OP_TEE and try to port earlier approach. But wh=
at we could foresee is some potential issue on how OpenSSH handling with OP_T=
EE file handlers.

   whether anybody tried before or knows OpenSSH + OP_TEE implementation? I a=
m not sure whether we need PKCS#11 implementation, as per my understanding no=
t needed !

Regards,
Hareesh =20


-----Original Message-----
From: Jorge Ramirez-Ortiz, Foundries <jorge@foundries.io>
Sent: Wednesday, August 30, 2023 4:52 PM
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Hareesh Das Ulleri <hareesh.ulleri@ovt.com>; op-tee(a)lists.trustedfirm=
ware.org
Subject: Re: Optee + OpenSSH/OpenSSL

[CAUTION]: EXTERNAL EMAIL


On 29/08/23 15:25:42, Sumit Garg wrote:
> Hi Hareesh,
>
> On Tue, 29 Aug 2023 at 13:35, Hareesh Das Ulleri <hareesh.ulleri@ovt.com>=
 wrote:
> >
> > Hello all,
> >
> >    We are started using Op-tee in our project.
> >
> >    Since we are new to Op-tee, could someone please confirm whether anyon=
e has already tried below in their project or is it possible to use along wit=
h OpenSSH/OpenSSL ?
> >
> >    What we try to accomplish is:  application/sshd -> openssl (libcrypto/=
provider) -> Optee (client/TA) -> (HW or SW cipher algorithm) for data encryp=
tion/decryption.
> >
>
> I would rather suggest you to use the existing OP-TEE based PKCS#11=20
> engine for openssl. For detailed information, I would suggest you to=20
> go through [1].

+1

>
> [1]
> https://urldefense.com/v3/__https://optee.readthedocs.io/en/latest/bui
> lding/userland_integration.html*pkcs-11-driver__;Iw!!AYUVhIwY!5CEUbRG2
> _XfcFjd9qMKwDuxEY3bwTdRTQOm0dG-unCC52ylg2npsi4CLlZ74Ncm5BBrSdDm6osheiU
> JyNrQ$


If you use an openssl provider you will be developing on the edge so I will b=
e interested in your commits upstream if you are using it to access a TPM (la=
st time I checked the tpm2-pkcs11 implementation was not working with an open=
ssl provider - just the engine)

what we did at foundries was to use the engine interface and from there plug =
the different pkcs11 implementations (op-tee being one, tpm2 being
another)

>
> -Sumit
>
> > Thanks,
> > Hareesh
> >

--===============6287608334115328718==--

