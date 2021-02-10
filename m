From: Jerome Forissier <jerome@forissier.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [Tee-dev] OpenVPN hardening with OP-TEE
Date: Wed, 10 Feb 2021 10:16:06 +0100
Message-ID: <55dbe490-b685-a331-df00-56ba80bea2a0@forissier.org>
In-Reply-To: <4abe37c7-25f9-0680-1212-cf3253ac7394@amongbytes.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8986709961731491554=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8986709961731491554==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Kris,

[CC op-tee(a)lists.trustedfirmware.org the newer ML for OP-TEE which is
now under the TrustedFirmware.org umbrella]


On 2/9/21 11:04 PM, Kris Kwiatkowski wrote:
> Hello,
>=20
> I've recently been involved in producing PoC, which utilizes OP-TEE
> to produce proof of a secret key possession. That is used during tunnel
> establishment by OpenVPN.
>=20
> In case someone finds it interesting, for example as kind of "real-world"
> use case of OP-TEE, then details are described here:
> https://www.amongbytes.com/post/20210112-optee-openssl-engine/

Thanks for sharing! It is a well-written article, quite interesting to
read IMO. I always like to see how OP-TEE is used in various scenarios.
As upstream project maintainers we hear about bug reports and we review
new contributions of course, but there is clearly a lot of activity
going on downstream that we don't know much about. Yet, a bit of context
certainly helps take the good decisions for the project going forward!

> and code is here:
> https://github.com/henrydcase/optee_eng
>=20
> The actual PoC used post-quantum schemes integrated into TEE OS and TF-A
> (secure boot). Those two points are not described really described for brev=
ity
> (and probably there is low interest anyway).
>=20
> Kind regards,
> Kris
> _______________________________________________
> Tee-dev mailing list
> Tee-dev(a)lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/tee-dev

Thanks,
--=20
Jerome

--===============8986709961731491554==--

