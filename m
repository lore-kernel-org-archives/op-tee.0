From: Cyrille Fleury <cyrille.fleury@nxp.com>
To: op-tee@lists.trustedfirmware.org
Subject: RE: [EXT] Re: [PATCH v2 1/1] tee: new ioctl to a register tee_shm
 from a dmabuf file descriptor
Date: Fri, 03 Feb 2023 14:13:53 +0000
Message-ID: <PA4PR04MB75207FF08A6C2EEC1944FFFE88D79@PA4PR04MB7520.eurprd04.prod.outlook.com>
In-Reply-To: <f3ccd7ad-0bbb-be39-c989-765552e2c6af@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5823251096826552607=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5823251096826552607==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



-----Original Message-----
From: Jerome Forissier <jerome.forissier@linaro.org>
Sent: Friday, February 3, 2023 1:32 PM
To: Etienne Carriere <etienne.carriere@linaro.org>; Olivier Masse <olivier.=
masse@nxp.com>
Cc: sumit.garg(a)linaro.org; linux-media(a)vger.kernel.org; fredgc(a)google.c=
om; linaro-mm-sig(a)lists.linaro.org; afd(a)ti.com; op-tee(a)lists.trustedfir=
mware.org; jens.wiklander(a)linaro.org; joakim.bech(a)linaro.org; sumit.semwa=
l(a)linaro.org; Cyrille Fleury <cyrille.fleury@nxp.com>; Peter Griffin <pet=
er.griffin@linaro.org>; linux-kernel(a)vger.kernel.org; dri-devel(a)lists.f=
reedesktop.org; Cl=C3=A9ment Faure <clement.faure@nxp.com>; christian.koeni=
g(a)amd.com
Subject: Re: [EXT] Re: [PATCH v2 1/1] tee: new ioctl to a register tee_shm fr=
om a dmabuf file descriptor

On 2/3/23 15:12, Cyrille Fleury wrote:
Hi all,

>On 2/3/23 12:37, Etienne Carriere wrote:
>> Hell all,
>>
>> +jerome f.
>>
>> On Fri, 3 Feb 2023 at 12:01, Olivier Masse <olivier.masse@nxp.com> wrote:
>>>
>>> On jeu., 2023-02-02 at 10:58 +0100, Etienne Carriere wrote:
>>>> Caution: EXT Email
>>>>
>>>> On Thu, 2 Feb 2023 at 09:35, Sumit Garg <sumit.garg@linaro.org>
>>>> wrote:
>>>>> Hi Cyrille,
>>>>>
>>>>> Please don't top post as it makes it harder to follow-up.
>>>>>
>>>>> On Thu, 2 Feb 2023 at 13:26, Cyrille Fleury <cyrille.fleury@nxp.com
>>>>>> wrote:
>>>>>> Hi Sumit, all
>>>>>>
>>>>>> Upstream OP-TEE should support registering a dmabuf since a while,=20
>>>>>> given how widely dmabuf is used in Linux for passing buffers=20
>>>>>> around between devices.
>>>>>>
>>>>>> Purpose of the new register_tee_shm ioctl is to allow OPTEE to use=20
>>>>>> memory allocated from the exiting linux dma buffer. We don't need=20
>>>>>> to have secure dma-heap up streamed.
>>>>>>
>>>>>> You mentioned secure dma-buffer, but secure dma-buffer is a dma-=20
>>>>>> buffer, so the work to be done for secure or "regular" dma buffers=20
>>>>>> by the register_tee_shm ioctl is 100% the same.
>>>>>>
>>>>>> The scope of this ioctl is limited to what existing upstream dma-=20
>>>>>> buffers are:
>>>>>>         -> sharing buffers for hardware (DMA) access across=20
>>>>>> multiple device drivers and subsystems, and for synchronizing=20
>>>>>> asynchronous hardware access.
>>>>>>        -> It means continuous memory only.
>>>>>>
>>>>>> So if we reduce the scope of register tee_shm to exiting dma-=20
>>>>>> buffer area, the current patch does the job.
>>>>>
>>>>> Do you have a corresponding real world use-case supported by=20
>>>>> upstream OP-TEE? AFAIK, the Secure Data Path (SDP) use-case is the=20
>>>>> one supported in OP-TEE upstream but without secure dmabuf heap [1]=20
>>>>> available, the new ioctl can't be exercised.
>>>>>
>>>>> [1]=20
>>>>> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg
>>>>> ithub.com%2FOP-TEE%2Foptee_test%2Fblob%2Fmaster%2Fhost%2Fxtest%2Fsd
>>>>> p_basic.h%23L15&data=3D05%7C01%7Ccyrille.fleury%40nxp.com%7C9ff962fb5
>>>>> 8f6401c597808db05e2a64b%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%
>>>>> 7C638110243232457377%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLC
>>>>> JQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3D
>>>>> UNB88rvmhQ5qRoIGN%2FpS4cQTES5joM8AjoyAAYzPKl0%3D&reserved=3D0
>>>>
>>>> OP-TEE has some SDP test taht can exercice SDP: 'xtest=20
>>>> regression_1014'.
>>>> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi
>>>> thub.com%2FOP-TEE%2Foptee_test%2Fblob%2F3.20.0%2Fhost%2Fxtest%2Fregr
>>>> ession_1000.c%23L1256&data=3D05%7C01%7Ccyrille.fleury%40nxp.com%7C9ff9
>>>> 62fb58f6401c597808db05e2a64b%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
>>>> 7C0%7C638110243232457377%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDA
>>>> iLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdat
>>>> a=3De%2B40rwWvtvVFG8aWZNeu%2FgjMXXvZ3pRhJfHLkdurovs%3D&reserved=3D0
>>>>
>>>> The test relies on old staged ION + local secure dmabuf heaps no=20
>>>> more maintained, so this test is currently not functional.
>>>> If we upgrade the test to mainline dmabuf alloc means, and apply the=20
>>>> change discussed here, we should be able to regularly test SDP in=20
>>>> OP-TEE project CI.
>>>> The part to update is the userland allocation of the dmabuf:
>>>> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi
>>>> thub.com%2FOP-TEE%2Foptee_test%2Fblob%2F3.20.0%2Fhost%2Fxtest%2Fsdp_
>>>> basic.c%23L91&data=3D05%7C01%7Ccyrille.fleury%40nxp.com%7C9ff962fb58f6
>>>> 401c597808db05e2a64b%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63
>>>> 8110243232457377%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjo
>>>> iV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3D5rPV1j
>>>> qzqjVh2N5pdUW41YwF6EkgIDwfhyfYkgmtdZI%3D&reserved=3D0
>>>>
>>>>
>>>
>>> the test was already updated to support secure dma heap with Kernel=20
>>> version 5.11 and higher. the userland allocation could be find here:
>>> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit
>>> hub.com%2FOP-TEE%2Foptee_test%2Fblob%2F3.20.0%2Fhost%2Fxtest%2Fsdp_ba
>>> sic.c%23L153&data=3D05%7C01%7Ccyrille.fleury%40nxp.com%7C9ff962fb58f640
>>> 1c597808db05e2a64b%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63811
>>> 0243232457377%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2l
>>> uMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3D01H96n47K6R
>>> mBKZQhRdcqX3nE5VBHOXNfGuMmmkVSvc%3D&reserved=3D0
>>>
>>
>> Oh, right. So fine, optee_test is ready for the new flavor of secure=20
>> buffer fd's.
>>
>>
>>> This upgrade need a Linux dma-buf patch:
>>> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor
>>> e.kernel.org%2Fall%2F20220805154139.2qkqxwklufjpsfdx%40000377403353%2
>>> FT%2F&data=3D05%7C01%7Ccyrille.fleury%40nxp.com%7C9ff962fb58f6401c59780
>>> 8db05e2a64b%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638110243232
>>> 457377%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLC
>>> JBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DyCS%2BDcuGp%2BafAL
>>> tpw74O1bI0K%2Fwnt%2FOw5ob1ngfDA0E%3D&reserved=3D0
>>
>> @Jens, @Jerome, do we want to pick the 2 necessary Linux patches in=20
>> our Linux kernel fork (github.com/linaro-swg/linux.git) to exercise=20
>> SDP in our CI and be ready if dma-buf secure heaps (ref right above)=20
>> is accepted and merged in mainline kernel?.
>
>How would that help? I mean, when the kernel patches are merged and if thing=
s break we can make the necessary adjustments in the optee_test app or whatev=
er, but in the meantime I don't see much point. I suppose the people who are =
actively developing the patches do make sure it works with OP-TEE ;-)
>
>Regards,
>--
>Jerome

As mentioned in the cover letter, this IOCTL got tested by Jens Wiklander <je=
ns.wiklander@linaro.org>, using Linaro reference board from Hikey 6620:
https://lists.trustedfirmware.org/archives/list/op-tee(a)lists.trustedfirmwar=
e.org/thread/I3TZN4TBDOUVE567VMMN2TAXGWZNY7S3/
It also works on i.MX8M EVK boards.

My understanding today is we are good to upstream this patch, knowing:
     - Upstream OPTEE driver should support registering a dmabuf since a whil=
e, given how widely dmabuf is used in Linux for passing buffers around betwee=
n devices.
     - review is OK=20
     - test environment is already available in optee-test
     - it has been tested on 2 different platforms
     - the scope of the new ioctl is limited to existing feature in dma-buffer
    =20
What is missing from this list preventing to upstream ?=20
Who do we still need to convince ?

Regards.

--===============5823251096826552607==--

