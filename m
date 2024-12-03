From: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 00/10] Trusted Execution Environment (TEE) driver for
 Qualcomm TEE (QTEE)
Date: Wed, 04 Dec 2024 09:13:43 +1100
Message-ID: <0df58435-94e7-4b81-b688-ec0e1c49c0e0@quicinc.com>
In-Reply-To: <518ee3f1-b871-4349-ba85-3b3fc835a4ca@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3430018573478639086=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3430018573478639086==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Based on our discussions, we implemented significant changes. We essentially
rewrote most of the files and altered the overall direction, except for a
couple of files. The changelog entry would have been extensive.

- Amir

On 12/3/2024 5:06 PM, Trilok Soni wrote:
> On 12/2/2024 8:19 PM, Amirreza Zarrabi wrote:
>> This patch series introduces a Trusted Execution Environment (TEE)
>> driver for Qualcomm TEE (QTEE). QTEE enables Trusted Applications (TAs)
>> and services to run securely. It uses an object-based interface, where
>> each service is an object with sets of operations. Clients can invoke
>> these operations on objects, which can generate results, including other
>> objects. For example, an object can load a TA and return another object
>> that represents the loaded TA, allowing access to its services.
>=20
> The first patch series was RFC and now you had removed the RFC. Can you ple=
ase
> provide the reasons?
>=20
> https://lwn.net/ml/all/20240702-qcom-tee-object-and-ioctls-v1-0-633c3ddf57e=
e(a)quicinc.com/
>=20
> I understand that you have now changed to tee framework but I want to check
> if we should continue with the version and increment here or start from [00=
]?
>=20

--===============3430018573478639086==--

