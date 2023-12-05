From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v4] tee: Use iov_iter to better support shared buffer registration
Date: Tue, 05 Dec 2023 16:55:49 +0000
Message-ID: <c9d5c8b8-ca5e-4593-b7ff-707f21dee91f@foss.st.com>
In-Reply-To: <dfa547c0-e889-4ac6-94c5-344905a6644f@kernel.dk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3379512744036128099=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3379512744036128099==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

hi Jens Axboe, Al Viro,

On 12/4/23 18:13, Jens Axboe wrote:
> On 12/4/23 10:02 AM, Arnaud POULIQUEN wrote:
>> Hi,
>>
>> On 12/4/23 17:40, Jens Axboe wrote:
>>> On 12/4/23 9:36 AM, Jens Axboe wrote:
>>>> On 12/4/23 5:42 AM, Sumit Garg wrote:
>>>>> IMO, access_ok() should be the first thing that import_ubuf() or
>>>>> import_single_range() should do, something as follows:
>>>>>
>>>>> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
>>>>> index 8ff6824a1005..4aee0371824c 100644
>>>>> --- a/lib/iov_iter.c
>>>>> +++ b/lib/iov_iter.c
>>>>> @@ -1384,10 +1384,10 @@ EXPORT_SYMBOL(import_single_range);
>>>>>
>>>>>  int import_ubuf(int rw, void __user *buf, size_t len, struct iov_iter =
*i)
>>>>>  {
>>>>> -       if (len > MAX_RW_COUNT)
>>>>> -               len =3D MAX_RW_COUNT;
>>>>>         if (unlikely(!access_ok(buf, len)))
>>>>>                 return -EFAULT;
>>>>> +       if (len > MAX_RW_COUNT)
>>>>> +               len =3D MAX_RW_COUNT;
>>>>>
>>>>>         iov_iter_ubuf(i, rw, buf, len);
>>>>>         return 0;
>>>>>
>>>>> Jens A., Al Viro,
>>>>>
>>>>> Was there any particular reason which I am unaware of to perform
>>>>> access_ok() check on modified input length?
>>>>
>>>> This change makes sense to me, and seems consistent with what is done
>>>> elsewhere too.
>>>
>>> For some reason I missed import_single_range(), which does it the same
>>> way as import_ubuf() currently does - cap the range before the
>>> access_ok() check. The vec variants sum as they go, but access_ok()
>>> before the range.
>>>
>>> I think part of the issue here is that the single range imports return 0
>>> for success and -ERROR otherwise. This means that the caller does not
>>> know if the full range was imported or not. OTOH, we always cap any data
>>> transfer at MAX_RW_COUNT, so may make more sense to fix up the caller
>>> here.
>>>
>>
>> Should we limit to MAX_RW_COUNT or return an error? Seems to me that
>> limiting could generate side effect later that could be not simple to
>> debug.
>=20
> We've traditionally just truncated the length, so principle of least
> surprise says we should continue doing that.
>=20


As Jens Wiklander has proposed using iov_iter_ubuf() instead of import_ubuf(),
should I propose a patch updating import_ubuf() and import_single_range()?
Or would you prefer that we keep the functions unchanged for the time being?

Regards,
Arnaud

--===============3379512744036128099==--

