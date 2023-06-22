From: Jan Kiszka <jan.kiszka@siemens.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v6 0/4] introduce tee-based EFI Runtime Variable Service
Date: Thu, 22 Jun 2023 20:44:43 +0000
Message-ID: <8318ced2-9a4a-c0f3-f4ca-f56bf8beaa20@siemens.com>
In-Reply-To: <ZJSbE/82z+319sTL@hera>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0518964878274563235=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0518964878274563235==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 22.06.23 21:03, Ilias Apalodimas wrote:
> On Thu, Jun 22, 2023 at 08:32:44PM +0200, Jan Kiszka wrote:
>> On 22.06.23 17:04, Ilias Apalodimas wrote:
>>> Hi Jan,
>>>
>>> On Thu, 22 Jun 2023 at 17:56, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>
>>>> On 22.06.23 10:51, Masahisa Kojima wrote:
>>>>> This series introduces the tee based EFI Runtime Variable Service.
>>>>>
>>>>> The eMMC device is typically owned by the non-secure world(linux in
>>>>> this case). There is an existing solution utilizing eMMC RPMB partition
>>>>> for EFI Variables, it is implemented by interacting with
>>>>> OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
>>>>> and tee-supplicant. The last piece is the tee-based variable access
>>>>> driver to interact with OP-TEE and StandaloneMM.
>>>>>
>>>>> Changelog:
>>>>> v5 -> v6
>>>>> - new patch #4 is added in this series, #1-#3 patches are unchanged.
>>>>>   automatically update super block flag when the efivarops support
>>>>>   SetVariable runtime service, so that user does not need to manually
>>>>>   remount the efivarfs as RW.
>>>>
>>>> But that is not yet resolving the architectural problem with that
>>>> userspace daemon dependency. What are the next steps for that now?
>>>
>>> We are trying to find some cycles to work on that, however, I don't
>>> have a time estimate on that.  But the question is different here.
>>> Since this addresses the problems distros have wrt to SetVariableRT
>>> (even for a limited set of platforms) are we ok pulling this in?  I
>>> can't think of a technical reason we shouldn't.  The supplicant
>>> limitations are known and the firrmwareTPM has a similar set of
>>> problems.
>>
>> It will not change we have to do on the distro side because we have to
>> deal not only with the startup issue and StMM but also with fTPM and
>> with shutdown. Only an in-kernel supplicant for RPMB would resolve that
>> according to my understanding.
>>
>=20
> Exactly and it's worth noting that even that will come with some minor
> limitations.  E.g the randomseed variables set by the efistub currently
> won't be supported as the modules will come alive way later.  But it's all
> reasonable compromises for hardware that wasn't designed to have a
> dedicated storage in the secure world and support runtime variables sanely.

My feeling is that such simpler setups will be the minority, simply
because eMMCs with RPMBs are standardized, often included anyway, so
come "for free".

>=20
>> But the question is fair if we can evolve from this stage here to an
>> in-kernel approach without causing breakages or other headache to
>> distros adopting it (too early). That's why I asked for the roadmap.
>=20
> Exactly and this is my point as well.  I can't see a technical difference
> other than 'you won't need to launch the supplicant'.  The only thing we
> need to keep in mind is introduce the fallback between the supplicant and
> the (future) kernel supplicant gracefully.  People might still need to run
> the supplicant for other reasons.  But if we design it with the kernel
> module taking precedence over the supplicant we should be fine.
>=20
> So since we lived with it a for a few years, I suggest we let it soak a bit
> and get tested while we try to move the supplicant bits needed over to the
> kernel. In the meantime patch #4 needs some adjustments, so I'll rethink
> the supplicant vs kernel module scenario in case I missed something.

Were there distros adopting all this already? I thought this was a
privilege of custom integrations where you can evolve things simply in
lock-step? At least Debian wasn't considering all these dependencies
yet, even though now providing tee-supplicant. We are patching it for
now [1].

Jan

[1]
https://github.com/BaochengSu/isar/commit/d7646e3bb9d882b26eaf2517fece624010c=
dd46e

--=20
Siemens AG, Technology
Competence Center Embedded Linux


--===============0518964878274563235==--

