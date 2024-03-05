From: Balint Dobszay <balint.dobszay@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 1/3] tee: optee: Move pool_op helper functions
Date: Tue, 05 Mar 2024 11:21:40 +0100
Message-ID: <ABE8D9AB-8F66-49F4-B442-F74EC2EF5C04@arm.com>
In-Reply-To: <
 <CAFA6WYMocdcQXaqk8hS8dwnfwJLNWKWSEfMLO4wXyCQM=TQ8vQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2976882987761850657=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2976882987761850657==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 5 Mar 2024, at 6:36, Sumit Garg wrote:

> On Mon, 4 Mar 2024 at 19:57, Balint Dobszay <balint.dobszay@arm.com> wrot=
e:
>>
>> On 4 Mar 2024, at 10:17, Sumit Garg wrote:
>>
>>> Hi Balint,
>>>
>>> On Mon, 4 Mar 2024 at 14:33, Balint Dobszay <balint.dobszay@arm.com> wr=
ote:
>>>>
>>>> Hi Sumit,
>>>>
>>>
>>> [snip]
>>>
>>>>>> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
>>>>>> index 911ddf92dcee..4cf402424e71 100644
>>>>>> --- a/include/linux/tee_drv.h
>>>>>> +++ b/include/linux/tee_drv.h
>>>>>> @@ -275,6 +275,17 @@ void *tee_get_drvdata(struct tee_device *teedev);
>>>>>>  struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_=
t size);
>>>>>>  struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, siz=
e_t size);
>>>>>>
>>>>>> +int tee_shm_pool_op_alloc_helper(struct tee_shm_pool *pool, struct te=
e_shm *shm,
>>>>>> +                                size_t size, size_t align,
>>>>>> +                                int (*shm_register)(struct tee_contex=
t *ctx,
>>>>>> +                                                    struct tee_shm *s=
hm,
>>>>>> +                                                    struct page **pag=
es,
>>>>>> +                                                    size_t num_pages,
>>>>>> +                                                    unsigned long sta=
rt));
>>>>>> +void tee_shm_pool_op_free_helper(struct tee_shm_pool *pool, struct te=
e_shm *shm,
>>>>>> +                                int (*shm_unregister)(struct tee_cont=
ext *ctx,
>>>>>> +                                                      struct tee_shm =
*shm));
>>>>>> +
>>>>>
>>>>> These rather belong to drivers/tee/tee_private.h as we shouldn't
>>>>> expose them to other kernel client drivers.
>>>>
>>>> As per the discussion in the other thread I'll ignore this.
>>>>
>>>
>>> Then it will have conflicts with this [1] patch. If you are fine to
>>> incorporate [1] in your series then the right place for these function
>>> declarations should be include/linux/tee_core.h.
>>>
>>> [1] https://www.spinics.net/lists/kernel/msg5122983.html
>>
>> You're right, I'll rebase my patches on this.
>>
>> By incorporating your patch in my series, do you mean that I should just
>> add it as the first patch in the series for the next version?
>
> If you are happy to carry it then I would be in favour of this to take
> care of dependency.

Sure, I've added it to v3.

Regards,
Balint

>> Or keep my
>> series as is (do the rebase of course) and just mention that it's using
>> your patch as base?
>>
>> Regards,
>> Balint
>>
>>>>
>>>>>>  struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
>>>>>>                                             void *addr, size_t length);
>>>>>>
>>>>>> --
>>>>>> 2.34.1
>>>>>>

--===============2976882987761850657==--

