From: Miklos Balint <Miklos.Balint@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: RE: [TF-A] Firmware FuSa workshop
Date: Mon, 29 Mar 2021 08:07:40 +0000
Message-ID: <VE1PR08MB48615EE9AB5D90C93C3FAE34E67E9@VE1PR08MB4861.eurprd08.prod.outlook.com>
In-Reply-To: <=?utf-8?q?=3C010001786fb8ce6a-a2addc27-58c8-48f8-a93b-6a3ac04a4?=
 =?utf-8?q?d82-000000=40email=2Eamazonses=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6048287330695184218=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6048287330695184218==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

To +=3D op-tee(a)lists.trustedfirmware.org<mailto:op-tee@lists.trustedfirmw=
are.org>

From: TF-A <tf-a-bounces@lists.trustedfirmware.org> On Behalf Of Fran=C3=A7=
ois Ozog via TF-A
Sent: 26 March 2021 19:08
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: tf-a(a)lists.trustedfirmware.org; Boot Architecture Mailman List <boot-ar=
chitecture@lists.linaro.org>; Ilias Apalodimas <ilias.apalodimas@linaro.o=
rg>
Subject: Re: [TF-A] Firmware FuSa workshop



Le ven. 26 mars 2021 =C3=A0 18:42, Heinrich Schuchardt <xypron.glpk(a)gmx.de<=
mailto:xypron.glpk@gmx.de>> a =C3=A9crit :
On 26.03.21 16:05, Fran=C3=A7ois Ozog wrote:
> Hi,
>
>
> Linaro is conducting an opportunity assessment to make OP-TEE ready for
> functional safety sensitive environments. The goal is to present a plan to
> Linaro members by the end of July 2021.
>
> The scope of the research is somewhat bigger because we can=E2=80=99t think=
 of
> OP-TEE without thinking of Trusted Firmware and Hafnium. The plan will
> though not address those (unless we recognize we have to). We don=E2=80=99t=
 think
> U-Boot shall be part of the picture but we are welcoming contradictory
> points of views.

Hello Fran=C3=A7ois,

Some boards boot via SPL->TF-A->U-Boot. Here U-Boot's SPL is relevant
for OP-TEE's security.

U-Boot can save variables via OP-TEE (implemented by Ilias). In this
case OP-TEE has an implication on secure boot.

I fully understand that these scenarios are not in the focus of the
workshop.
it may if companies have this particular flow in mind for safety certificatio=
n.  Our goal is not to make all boot flows safety ready but to identify which=
 ones we need to consider. And the workshop may help in this identification.

Best regards

Heinrich

>
> We are organizing a 2 hours workshop on April 15th 9am CET to mostly hear
> about use cases and ideas about Long Term Support requirements . We will
> present the state of the research.
>
> The first  use case is booting a safety certified type-1 hypervisor (open
> source or commercial is irrelevant).
>
> But we know there are many more: please be ready to contribute.
>
> We think of more radical use cases: a safety payload is actually loaded as
> a Secure Partition on top of Hafnium with OP-TEE or Zephyr used as a device
> backends. In other words, Trust Zone hosts both safety and security worlds
> , EL3 being the =C2=AB software root of trust =C2=BB pivot world. In those =
cases,
> some cores never go out of secure state=E2=80=A6
>
>
> Agenda (to be refined)
>
>    -
>
>    Vision
>    -
>
>    State of the research
>    <https://docs.google.com/presentation/u/0/d/1jWqu39gCF-5XzbFkodXsiVNJJLU=
N88BgkiBu__D5KeE/edit>
>    -
>
>    Use cases discussion
>    -
>
>    What is the right scope?
>    -
>
>    =E2=80=9CWho do what=E2=80=9D discussion (LTS, archiving...)
>    -
>
>    Safety personnel (Linaro and contractors) discussion
>    -
>
>    Other considerations from participants?
>    -
>
>    Community organizations and funding?
>    -
>
>    Closing and next steps
>
>
> Should you want to participate and have not yet received an invite, please
> contact me directly.
>
> Cordially,
>
> Fran=C3=A7ois-Fr=C3=A9d=C3=A9ric
>
> PS: Please reach out should you want another date with a time compatible
> with more time zones. This alternate date is not guaranteed though.
>
>
--
[https://drive.google.com/a/linaro.org/uc?id=3D0BxTAygkus3RgQVhuNHMwUi1mYWc&e=
xport=3Ddownload]
Fran=C3=A7ois-Fr=C3=A9d=C3=A9ric Ozog | Director Linaro Edge & Fog Computing =
Group
T: +33.67221.6485
francois.ozog(a)linaro.org<mailto:francois.ozog@linaro.org> | Skype: ffozog


--===============6048287330695184218==--

