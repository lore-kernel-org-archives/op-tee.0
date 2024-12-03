From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 00/10] Trusted Execution Environment (TEE) driver for
 Qualcomm TEE (QTEE)
Date: Wed, 04 Dec 2024 01:43:40 +0200
Message-ID: <gtfm7paylpcobucmwmapgdxva2wnvn5skkakaalzpx4ip7x2h2@lphbinkzaw7k>
In-Reply-To: <0df58435-94e7-4b81-b688-ec0e1c49c0e0@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4507892915151040850=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4507892915151040850==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 04, 2024 at 09:13:43AM +1100, Amirreza Zarrabi wrote:
> Based on our discussions, we implemented significant changes. We essentially
> rewrote most of the files and altered the overall direction, except for a
> couple of files. The changelog entry would have been extensive.

At least some changelog should be provided, even if tells "reworked to
use TEE framework, made it jump over the head and tie the shoelaces".

Also please don't top-post, this style is frowned upon in the mailing
list discussions, it breaks the logic of reading.

>=20
> - Amir
>=20
> On 12/3/2024 5:06 PM, Trilok Soni wrote:
> > On 12/2/2024 8:19 PM, Amirreza Zarrabi wrote:
> >> This patch series introduces a Trusted Execution Environment (TEE)
> >> driver for Qualcomm TEE (QTEE). QTEE enables Trusted Applications (TAs)
> >> and services to run securely. It uses an object-based interface, where
> >> each service is an object with sets of operations. Clients can invoke
> >> these operations on objects, which can generate results, including other
> >> objects. For example, an object can load a TA and return another object
> >> that represents the loaded TA, allowing access to its services.
> >=20
> > The first patch series was RFC and now you had removed the RFC. Can you p=
lease
> > provide the reasons?
> >=20
> > https://lwn.net/ml/all/20240702-qcom-tee-object-and-ioctls-v1-0-633c3ddf5=
7ee(a)quicinc.com/
> >=20
> > I understand that you have now changed to tee framework but I want to che=
ck
> > if we should continue with the version and increment here or start from [=
00]?
> >=20

--=20
With best wishes
Dmitry

--===============4507892915151040850==--

