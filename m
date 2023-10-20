From: Balint Dobszay <balint.dobszay@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [RFC PATCH] tee: tstee: Add initial Trusted Services TEE driver
Date: Fri, 20 Oct 2023 15:54:52 +0200
Message-ID: <BE735A4E-2E55-4C1B-956B-FC859B1DCFF5@arm.com>
In-Reply-To: <
 <CAFA6WYNzVspbsDtCFCCTvWtFRd0Ns+B6-V0U8qS3xhSLBNA3ZQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5924297623498478368=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5924297623498478368==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 13 Oct 2023, at 13:38, Sumit Garg wrote:
> On Tue, 10 Oct 2023 at 21:11, Balint Dobszay <balint.dobszay@arm.com> wro=
te:
>> On 3 Oct 2023, at 17:42, Sumit Garg wrote:
>>> On Wed, 27 Sept 2023 at 20:56, Balint Dobszay <balint.dobszay@arm.com> =
wrote:
>>>>
>>>> The Trusted Services project provides a framework for developing and
>>>> deploying device Root Of Trust services in FF-A Secure Partitions. The
>>>> FF-A SPs are accessible through the FF-A driver, but this doesn't
>>>> provide a user space interface. The goal of this TEE driver is to make
>>>> Trusted Services SPs accessible for user space clients.
>>>
>>> I am interested in exploring the user space library/applications. Do
>>> you have a standard library implementation and some example user-space
>>> applications leveraging this driver interface?
>>
>> Yes we have a library reference implementation in Trusted Services using
>> this driver called libts [1]. There are some test applications that rely
>> on this library, e.g. ts-service-test [2]. Also, the Parsec project can
>> use Trusted Services as backend through libts [3] (note, the version of
>> TS currently integrated in Parsec is not recent, thus the libts in there
>> still uses an earlier version of this driver).
>
> Although I am currently exploring the user-space interface, I would
> like to give it a hands-on. Is it possible to run this trusted
> services setup on Qemu? If yes then can you share instructions how to
> test them?

Currently we only support the FVP Base platform. Please find the
instructions for setting up the build environment and running the tests
at [1]. Note, our upstream end-to-end integration currently relies on
the out-of-tree version of this driver, so Trusted Services is looking
for driver version number in that repository. To make it compatible with
this in-tree version, please use the branch at [2].

Regards,
Balint

[1] https://developer.trustedfirmware.org/w/trusted-services/running_ts_on_fvp
[2] https://git.trustedfirmware.org/TS/trusted-services.git/log/?h=3Dtopics/b=
d/tstee-in-tree

--===============5924297623498478368==--

