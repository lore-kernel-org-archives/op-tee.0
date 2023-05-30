From: Krzysztof Kozlowski <krzk@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [RFC PATCH 3/4] dt-bindings: remoteproc: add compatibility for
 TEE support
Date: Tue, 30 May 2023 17:12:28 +0200
Message-ID: <7bdb0e44-eaf7-8085-2ea5-6bb06b01ef35@kernel.org>
In-Reply-To: <d4a98500-5cb0-b3fd-7f40-8b56a2258619@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3726129692975947432=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3726129692975947432==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 30/05/2023 17:00, Arnaud POULIQUEN wrote:
> Hello Krzysztof,
>=20
> On 5/30/23 13:50, Krzysztof Kozlowski wrote:
>> On 23/05/2023 11:13, Arnaud Pouliquen wrote:
>>> Rework compatibility description according to the support of
>>> the authenticated firmware relying on OP-TEE authentication.
>>>
>>> The expected behavior is:
>>> - with legacy compatible "st,stm32mp1-m4" the Linux kernel loads a
>>>   non-signed (ELF) firmware image,
>>> - with compatible "st,stm32mp1-m4-tee" the Linux kernel load a signed
>>>   firmware image. In this case it calls TEE services to manage the firmwa=
re
>>>   loading and the remoteproc life-cycle.
>>>
>>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>>> ---
>>>  .../bindings/remoteproc/st,stm32-rproc.yaml   | 33 +++++++++++++++++--
>>>  1 file changed, 30 insertions(+), 3 deletions(-)
>>
>> Please use scripts/get_maintainers.pl to get a list of necessary people
>> and lists to CC.  It might happen, that command when run on an older
>> kernel, gives you outdated entries.  Therefore please be sure you base
>> your patches on recent Linux kernel.
>>
>> You missed at least DT list (maybe more), so this won't be tested.
>> Please resend and include all necessary entries.
>>
>> Because of above and RFC, I assume there is no need for review. Just to
>> be clear - that's a no.
>=20
> I did not add DT list and maintainers intentionally to avoid that you
> review it.
> As in a first step the associated OP-TEE pull request has to be reviewed.
> And my plan was just to share the Linux implementation part until the
> OP-TEE review cycle is finished.

Sure, that's fine. I just don't know whether this is intentional or not.
Many people skip list without such reason...

>=20
> Now regarding your mail (and very interesting feedback from Christoph Hellw=
ig),
> it was clearly not the good strategy.
> So my apologize and next time whatever the objective of the series I will a=
dd
> all peoples and lists in the loop.

No worries! Thanks.

Best regards,
Krzysztof


--===============3726129692975947432==--

