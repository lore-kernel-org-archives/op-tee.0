From: Amirreza Zarrabi <quic_azarrabi@quicinc.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 0/8] Trusted Execution Environment (TEE) driver for
 Qualcomm TEE (QTEE)
Date: Mon, 10 Feb 2025 07:18:36 +1100
Message-ID: <c4f6f9e0-5a5f-4286-95f1-f01a46d415ee@quicinc.com>
In-Reply-To: <
 <CAFA6WYMhyDLmFaZMWd3TFfNTnujAN8ZuzguPgzjJXfhZf2ZnKA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3984833334708667301=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3984833334708667301==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 2/7/2025 4:12 PM, Sumit Garg wrote:
> On Fri, 7 Feb 2025 at 01:25, Amirreza Zarrabi <quic_azarrabi@quicinc.com>=
 wrote:
>>
>>
>>
>> On 2/5/2025 4:38 PM, Sumit Garg wrote:
>>> Hi Amirreza,
>>>
>>> On Mon, 3 Feb 2025 at 08:14, Amirreza Zarrabi <quic_azarrabi@quicinc.co=
m> wrote:
>>>>
>>>> This patch series introduces a Trusted Execution Environment (TEE)
>>>> driver for Qualcomm TEE (QTEE). QTEE enables Trusted Applications (TAs)
>>>> and services to run securely. It uses an object-based interface, where
>>>> each service is an object with sets of operations. Clients can invoke
>>>> these operations on objects, which can generate results, including other
>>>> objects. For example, an object can load a TA and return another object
>>>> that represents the loaded TA, allowing access to its services.
>>>>
>>>> Kernel and userspace services are also available to QTEE through a
>>>> similar approach. QTEE makes callback requests that are converted into
>>>> object invocations. These objects can represent services within the
>>>> kernel or userspace process.
>>>>
>>>> Note: This patch series focuses on QTEE objects and userspace services.
>>>>
>>>> Linux already provides a TEE subsystem, which is described in [1]. The
>>>> tee subsystem provides a generic ioctl interface, TEE_IOC_INVOKE, which
>>>> can be used by userspace to talk to a TEE backend driver. We extend the
>>>> Linux TEE subsystem to understand object parameters and an ioctl call so
>>>> client can invoke objects in QTEE:
>>>>
>>>>   - TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_*
>>>>   - TEE_IOC_OBJECT_INVOKE
>>>>
>>>> The existing ioctl calls TEE_IOC_SUPPL_RECV and TEE_IOC_SUPPL_SEND are
>>>> used for invoking services in the userspace process by QTEE.
>>>>
>>>> The TEE backend driver uses the QTEE Transport Message to communicate
>>>> with QTEE. Interactions through the object INVOKE interface are
>>>> translated into QTEE messages. Likewise, object invocations from QTEE
>>>> for userspace objects are converted into SEND/RECV ioctl calls to
>>>> supplicants.
>>>>
>>>> The details of QTEE Transport Message to communicate with QTEE is
>>>> available in [PATCH 10/10] Documentation: tee: Add Qualcomm TEE driver.
>>>>
>>>> You can run basic tests with following steps:
>>>> git clone https://github.com/quic/quic-teec.git
>>>> cd quic-teec
>>>> mkdir build
>>>> cmake .. -DCMAKE_TOOLCHAIN_FILE=3DCMakeToolchain.txt -DBUILD_UNITTEST=3D=
ON
>>>>
>>>> https://github.com/quic/quic-teec/blob/main/README.md lists dependancies
>>>> needed to build the above.
>>>>
>>>> This series has been tested for basic QTEE object invocations and
>>>> callback requests, including loading a TA and requesting services form
>>>> the TA.
>>>
>>> Thanks for sharing these test user-space applications/libraries. Can I
>>> know which platforms are currently supported by this QTEE driver? I
>>> would like to run and understand the overall stack on a real device. I
>>> do have rb3, rb5 and db410c on my desk to test with.
>>>
>>> Also, platform support is important information you should put in the
>>> cover letter as well as the QTEE documentation.
>>>
>>> -Sumit
>>>
>>
>> I have tested it with sm8650-mtp. But would expect it to work with any pla=
tform.
>=20
> Good to know that I will try to test it by next week on one of the
> available platforms on my desk.
>=20
>> I'll update the cover letter with the details :).
>=20
> Also, put it in QTEE documentation too such that people are aware
> about supported platforms.
>=20

Ack.

> -Sumit


--===============3984833334708667301==--

