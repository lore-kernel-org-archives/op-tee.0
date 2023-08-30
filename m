From: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Optee + OpenSSH/OpenSSL
Date: Wed, 30 Aug 2023 10:51:46 +0200
Message-ID: <ZO8DIhS/ZuZSAKm6@trax>
In-Reply-To: <
 <CAFA6WYMSFc153i+r=yV3G0MW3FyfBgwoGsz+ma4Pg9E9190Tvg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5940267951170659738=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5940267951170659738==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

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
> I would rather suggest you to use the existing OP-TEE based PKCS#11
> engine for openssl. For detailed information, I would suggest you to
> go through [1].

+1

>
> [1] https://optee.readthedocs.io/en/latest/building/userland_integration.ht=
ml#pkcs-11-driver


If you use an openssl provider you will be developing on the edge so I
will be interested in your commits upstream if you are using it to
access a TPM (last time I checked the tpm2-pkcs11 implementation was not
working with an openssl provider - just the engine)

what we did at foundries was to use the engine interface and from there
plug the different pkcs11 implementations (op-tee being one, tpm2 being
another)

>
> -Sumit
>
> > Thanks,
> > Hareesh
> >

--===============5940267951170659738==--

