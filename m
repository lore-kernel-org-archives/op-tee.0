From: Jerome Forissier <jerome.forissier@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [EXT] Re: [PATCH v2 1/1] tee: new ioctl to a register tee_shm
 from a dmabuf file descriptor
Date: Fri, 03 Feb 2023 13:31:57 +0100
Message-ID: <f3ccd7ad-0bbb-be39-c989-765552e2c6af@linaro.org>
In-Reply-To: <
 <CAN5uoS-A8EovbnxvcXqiYHcy95d-PTYUZvnNr3=kf84AGkG8Kw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8727912016196882202=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8727912016196882202==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 2/3/23 12:37, Etienne Carriere wrote:
> Hell all,
>=20
> +jerome f.
>=20
> On Fri, 3 Feb 2023 at 12:01, Olivier Masse <olivier.masse@nxp.com> wrote:
>>
>> On jeu., 2023-02-02 at 10:58 +0100, Etienne Carriere wrote:
>>> Caution: EXT Email
>>>
>>> On Thu, 2 Feb 2023 at 09:35, Sumit Garg <sumit.garg@linaro.org>
>>> wrote:
>>>> Hi Cyrille,
>>>>
>>>> Please don't top post as it makes it harder to follow-up.
>>>>
>>>> On Thu, 2 Feb 2023 at 13:26, Cyrille Fleury <cyrille.fleury@nxp.com
>>>>> wrote:
>>>>> Hi Sumit, all
>>>>>
>>>>> Upstream OP-TEE should support registering a dmabuf since a
>>>>> while, given how widely dmabuf is used in Linux for passing
>>>>> buffers around between devices.
>>>>>
>>>>> Purpose of the new register_tee_shm ioctl is to allow OPTEE to
>>>>> use memory allocated from the exiting linux dma buffer. We don't
>>>>> need to have secure dma-heap up streamed.
>>>>>
>>>>> You mentioned secure dma-buffer, but secure dma-buffer is a dma-
>>>>> buffer, so the work to be done for secure or "regular" dma
>>>>> buffers by the register_tee_shm ioctl is 100% the same.
>>>>>
>>>>> The scope of this ioctl is limited to what existing upstream dma-
>>>>> buffers are:
>>>>>         -> sharing buffers for hardware (DMA) access across
>>>>> multiple device drivers and subsystems, and for synchronizing
>>>>> asynchronous hardware access.
>>>>>        -> It means continuous memory only.
>>>>>
>>>>> So if we reduce the scope of register tee_shm to exiting dma-
>>>>> buffer area, the current patch does the job.
>>>>
>>>> Do you have a corresponding real world use-case supported by
>>>> upstream
>>>> OP-TEE? AFAIK, the Secure Data Path (SDP) use-case is the one
>>>> supported in OP-TEE upstream but without secure dmabuf heap [1]
>>>> available, the new ioctl can't be exercised.
>>>>
>>>> [1] https://github.com/OP-TEE/optee_test/blob/master/host/xtest/sdp_basi=
c.h#L15
>>>
>>> OP-TEE has some SDP test taht can exercice SDP: 'xtest
>>> regression_1014'.
>>> https://github.com/OP-TEE/optee_test/blob/3.20.0/host/xtest/regression_10=
00.c#L1256
>>>
>>> The test relies on old staged ION + local secure dmabuf heaps no more
>>> maintained, so this test is currently not functional.
>>> If we upgrade the test to mainline dmabuf alloc means, and apply the
>>> change discussed here, we should be able to regularly test SDP in
>>> OP-TEE project CI.
>>> The part to update is the userland allocation of the dmabuf:
>>> https://github.com/OP-TEE/optee_test/blob/3.20.0/host/xtest/sdp_basic.c#L=
91
>>>
>>>
>>
>> the test was already updated to support secure dma heap with Kernel
>> version 5.11 and higher. the userland allocation could be find here:
>> https://github.com/OP-TEE/optee_test/blob/3.20.0/host/xtest/sdp_basic.c#L1=
53
>>
>=20
> Oh, right. So fine, optee_test is ready for the new flavor of secure
> buffer fd's.
>=20
>=20
>> This upgrade need a Linux dma-buf patch:
>> https://lore.kernel.org/all/20220805154139.2qkqxwklufjpsfdx(a)000377403353=
/T/
>=20
> @Jens, @Jerome, do we want to pick the 2 necessary Linux patches in
> our Linux kernel fork (github.com/linaro-swg/linux.git) to exercise
> SDP in our CI and be ready if dma-buf secure heaps (ref right above)
> is accepted and merged in mainline kernel?.

How would that help? I mean, when the kernel patches are merged and if
things break we can make the necessary adjustments in the optee_test app
or whatever, but in the meantime I don't see much point. I suppose the
people who are actively developing the patches do make sure it works with
OP-TEE ;-)

Regards,
--=20
Jerome

--===============8727912016196882202==--

