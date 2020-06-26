From: Julien Grall <julien@xen.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 2/2] optee: allow plain TMEM buffers with NULL address
Date: Fri, 26 Jun 2020 18:54:23 +0100
Message-ID: <b1891206-b883-46b9-70a3-3027a931d2ed@xen.org>
In-Reply-To: <alpine.DEB.2.21.2006231403220.8121@sstabellini-ThinkPad-T480s>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2573884625324716039=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2573884625324716039==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

(using paul xen.org's email)

Hi,

Apologies for the late answer.

On 23/06/2020 22:09, Stefano Stabellini wrote:
> On Tue, 23 Jun 2020, Julien Grall wrote:
>> On 23/06/2020 03:49, Volodymyr Babchuk wrote:
>>>
>>> Hi Stefano,
>>>
>>> Stefano Stabellini writes:
>>>
>>>> On Fri, 19 Jun 2020, Volodymyr Babchuk wrote:
>>>>> Trusted Applications use popular approach to determine required size
>>>>> of buffer: client provides a memory reference with the NULL pointer to
>>>>> a buffer. This is so called "Null memory reference". TA updates the
>>>>> reference with the required size and returns it back to the
>>>>> client. Then client allocates buffer of needed size and repeats the
>>>>> operation.
>>>>>
>>>>> This behavior is described in TEE Client API Specification, paragraph
>>>>> 3.2.5. Memory References.
>>>>>
>>>>> OP-TEE represents this null memory reference as a TMEM parameter with
>>>>> buf_ptr =3D 0x0. This is the only case when we should allow TMEM
>>>>> buffer without the OPTEE_MSG_ATTR_NONCONTIG flag. This also the
>>>>> special case for a buffer with OPTEE_MSG_ATTR_NONCONTIG flag.
>>>>>
>>>>> This could lead to a potential issue, because IPA 0x0 is a valid
>>>>> address, but OP-TEE will treat it as a special case. So, care should
>>>>> be taken when construction OP-TEE enabled guest to make sure that such
>>>>> guest have no memory at IPA 0x0 and none of its memory is mapped at PA
>>>>> 0x0.
>>>>>
>>>>> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
>>>>> ---
>>>>>
>>>>> Changes from v1:
>>>>>    - Added comment with TODO about possible PA/IPA 0x0 issue
>>>>>    - The same is described in the commit message
>>>>>    - Added check in translate_noncontig() for the NULL ptr buffer
>>>>>
>>>>> ---
>>>>>    xen/arch/arm/tee/optee.c | 27 ++++++++++++++++++++++++---
>>>>>    1 file changed, 24 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/xen/arch/arm/tee/optee.c b/xen/arch/arm/tee/optee.c
>>>>> index 6963238056..70bfef7e5f 100644
>>>>> --- a/xen/arch/arm/tee/optee.c
>>>>> +++ b/xen/arch/arm/tee/optee.c
>>>>> @@ -215,6 +215,15 @@ static bool optee_probe(void)
>>>>>        return true;
>>>>>    }
>>>>>    +/*
>>>>> + * TODO: There is a potential issue with guests that either have RAM
>>>>> + * at IPA of 0x0 or some of theirs memory is mapped at PA 0x0. This is
>>>>                                  ^ their
>>>>
>>>>> + * because PA of 0x0 is considered as NULL pointer by OP-TEE. It will
>>>>> + * not be able to map buffer with such pointer to TA address space, or
>>>>> + * use such buffer for communication with the guest. We either need to
>>>>> + * check that guest have no such mappings or ensure that OP-TEE
>>>>> + * enabled guest will not be created with such mappings.
>>>>> + */
>>>>>    static int optee_domain_init(struct domain *d)
>>>>>    {
>>>>>        struct arm_smccc_res resp;
>>>>> @@ -725,6 +734,15 @@ static int translate_noncontig(struct optee_domain
>>>>> *ctx,
>>>>>            uint64_t next_page_data;
>>>>>        } *guest_data, *xen_data;
>>>>>    +    /*
>>>>> +     * Special case: buffer with buf_ptr =3D=3D 0x0 is considered as N=
ULL
>>>>> +     * pointer by OP-TEE. No translation is needed. This can lead to
>>>>> +     * an issue as IPA 0x0 is a valid address for Xen. See the comment
>>>>> +     * near optee_domain_init()
>>>>> +     */
>>>>> +    if ( !param->u.tmem.buf_ptr )
>>>>> +        return 0;
>>>>
>>>> Given that today it is not possible for this to happen, it could even be
>>>> an ASSERT. But I think I would just return an error, maybe -EINVAL?
>>>
>>> Hmm, looks like my comment is somewhat misleading :(
>>
>> How about the following comment:
>>
>> We don't want to translate NULL (0) as it can be used by the guest to fetch
>> the size of the buffer to allocate. This behavior depends on TA, but there=
 is
>> a guarantee that OP-TEE will not try to map it (see more details on top of
>> optee_domain_init()).
>>
>>>
>>> What I mean, is that param->u.tmem.buf_ptr =3D=3D 0 is the normal situati=
on.
>>> This is the special case, when OP-TEE treats this buffer as a NULL. So
>>> we are doing nothing there. Thus, "return 0".
>>>
>>> But, as Julien pointed out, we can have machine where 0x0 is the valid
>>> memory address and there is a chance, that some guest will use it as a
>>> pointer to buffer.
>>>
>>>> Aside from this, and the small grammar issue, everything else looks fine
>>>> to me.
>>>>
>>>> Let's wait for Julien's reply, but if this is the only thing I could fix
>>>> on commit.
>>
>> I agree with Volodymyr, this is the normal case here. There are more work =
to
>> prevent MFN 0 to be mapped in the guest but this shouldn't be an issue tod=
ay.
>=20
> Let's put the MFN 0 issue aside for a moment.
>=20
>  From the commit message I thought that if the guest wanted to pass a
> NULL buffer ("Null memory reference") then it would also *not* set
> OPTEE_MSG_ATTR_NONCONTIG, which would be handled by the "else" statement
> also modified by this patch. Thus, I thought that reaching
> translate_noncontig with buf_ptr =3D=3D NULL would always be an error.
>=20
> But re-reading the commit message and from both your answers it is not
> the case: a "Null memory reference" is allowed with
> OPTEE_MSG_ATTR_NONCONTIG set too.
>=20
> Thus, I have no further comments and the improvements on the in-code
> comment could be done on commit.

Good :). IIRC Paul gave a provisional RaB for this series. @Paul, now=20
that we are settled, could we get a formal one?

Cheers,

--=20
Julien Grall

--===============2573884625324716039==--

