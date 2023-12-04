From: Jens Axboe <axboe@kernel.dk>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v4] tee: Use iov_iter to better support shared buffer registration
Date: Mon, 04 Dec 2023 10:13:29 -0700
Message-ID: <dfa547c0-e889-4ac6-94c5-344905a6644f@kernel.dk>
In-Reply-To: <a1f4e290-34ad-4606-9a95-350d00727483@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6828351498697668177=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6828351498697668177==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 12/4/23 10:02 AM, Arnaud POULIQUEN wrote:
> Hi,
>=20
> On 12/4/23 17:40, Jens Axboe wrote:
>> On 12/4/23 9:36 AM, Jens Axboe wrote:
>>> On 12/4/23 5:42 AM, Sumit Garg wrote:
>>>> IMO, access_ok() should be the first thing that import_ubuf() or
>>>> import_single_range() should do, something as follows:
>>>>
>>>> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
>>>> index 8ff6824a1005..4aee0371824c 100644
>>>> --- a/lib/iov_iter.c
>>>> +++ b/lib/iov_iter.c
>>>> @@ -1384,10 +1384,10 @@ EXPORT_SYMBOL(import_single_range);
>>>>
>>>>  int import_ubuf(int rw, void __user *buf, size_t len, struct iov_iter *=
i)
>>>>  {
>>>> -       if (len > MAX_RW_COUNT)
>>>> -               len =3D MAX_RW_COUNT;
>>>>         if (unlikely(!access_ok(buf, len)))
>>>>                 return -EFAULT;
>>>> +       if (len > MAX_RW_COUNT)
>>>> +               len =3D MAX_RW_COUNT;
>>>>
>>>>         iov_iter_ubuf(i, rw, buf, len);
>>>>         return 0;
>>>>
>>>> Jens A., Al Viro,
>>>>
>>>> Was there any particular reason which I am unaware of to perform
>>>> access_ok() check on modified input length?
>>>
>>> This change makes sense to me, and seems consistent with what is done
>>> elsewhere too.
>>
>> For some reason I missed import_single_range(), which does it the same
>> way as import_ubuf() currently does - cap the range before the
>> access_ok() check. The vec variants sum as they go, but access_ok()
>> before the range.
>>
>> I think part of the issue here is that the single range imports return 0
>> for success and -ERROR otherwise. This means that the caller does not
>> know if the full range was imported or not. OTOH, we always cap any data
>> transfer at MAX_RW_COUNT, so may make more sense to fix up the caller
>> here.
>>
>=20
> Should we limit to MAX_RW_COUNT or return an error? Seems to me that
> limiting could generate side effect later that could be not simple to
> debug.

We've traditionally just truncated the length, so principle of least
surprise says we should continue doing that.

--=20
Jens Axboe


--===============6828351498697668177==--

