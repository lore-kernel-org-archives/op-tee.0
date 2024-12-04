From: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 00/10] Trusted Execution Environment (TEE) driver for
 Qualcomm TEE (QTEE)
Date: Wed, 04 Dec 2024 11:45:17 +1100
Message-ID: <873da5ca-c18a-4f31-a4a5-53903e14950f@quicinc.com>
In-Reply-To: <gtfm7paylpcobucmwmapgdxva2wnvn5skkakaalzpx4ip7x2h2@lphbinkzaw7k>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4514624413636838189=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4514624413636838189==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 12/4/2024 10:43 AM, Dmitry Baryshkov wrote:
> On Wed, Dec 04, 2024 at 09:13:43AM +1100, Amirreza Zarrabi wrote:
>> Based on our discussions, we implemented significant changes. We essential=
ly
>> rewrote most of the files and altered the overall direction, except for a
>> couple of files. The changelog entry would have been extensive.
>=20
> At least some changelog should be provided, even if tells "reworked to
> use TEE framework, made it jump over the head and tie the shoelaces".
>=20

Sure, I'll provide some changelog.

> Also please don't top-post, this style is frowned upon in the mailing
> list discussions, it breaks the logic of reading.
>=20

;) Oops, that shouldn't have been sent out like this. My apologies.
I'll ensure it doesn't happen again..

- Amir

>>
>> - Amir
>>
>> On 12/3/2024 5:06 PM, Trilok Soni wrote:
>>> On 12/2/2024 8:19 PM, Amirreza Zarrabi wrote:
>>>> This patch series introduces a Trusted Execution Environment (TEE)
>>>> driver for Qualcomm TEE (QTEE). QTEE enables Trusted Applications (TAs)
>>>> and services to run securely. It uses an object-based interface, where
>>>> each service is an object with sets of operations. Clients can invoke
>>>> these operations on objects, which can generate results, including other
>>>> objects. For example, an object can load a TA and return another object
>>>> that represents the loaded TA, allowing access to its services.
>>>
>>> The first patch series was RFC and now you had removed the RFC. Can you p=
lease
>>> provide the reasons?
>>>
>>> https://lwn.net/ml/all/20240702-qcom-tee-object-and-ioctls-v1-0-633c3ddf5=
7ee(a)quicinc.com/
>>>
>>> I understand that you have now changed to tee framework but I want to che=
ck
>>> if we should continue with the version and increment here or start from [=
00]?
>>>
>=20

--===============4514624413636838189==--

