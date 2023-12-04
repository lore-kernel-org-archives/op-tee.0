From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v4] tee: Use iov_iter to better support shared buffer registration
Date: Mon, 04 Dec 2023 18:02:27 +0100
Message-ID: <a1f4e290-34ad-4606-9a95-350d00727483@foss.st.com>
In-Reply-To: <cf00a996-c262-4457-93de-ca7960ad6df6@kernel.dk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5173862191727464677=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5173862191727464677==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 12/4/23 17:40, Jens Axboe wrote:
> On 12/4/23 9:36 AM, Jens Axboe wrote:
>> On 12/4/23 5:42 AM, Sumit Garg wrote:
>>> IMO, access_ok() should be the first thing that import_ubuf() or
>>> import_single_range() should do, something as follows:
>>>
>>> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
>>> index 8ff6824a1005..4aee0371824c 100644
>>> --- a/lib/iov_iter.c
>>> +++ b/lib/iov_iter.c
>>> @@ -1384,10 +1384,10 @@ EXPORT_SYMBOL(import_single_range);
>>>
>>>  int import_ubuf(int rw, void __user *buf, size_t len, struct iov_iter *i)
>>>  {
>>> -       if (len > MAX_RW_COUNT)
>>> -               len =3D MAX_RW_COUNT;
>>>         if (unlikely(!access_ok(buf, len)))
>>>                 return -EFAULT;
>>> +       if (len > MAX_RW_COUNT)
>>> +               len =3D MAX_RW_COUNT;
>>>
>>>         iov_iter_ubuf(i, rw, buf, len);
>>>         return 0;
>>>
>>> Jens A., Al Viro,
>>>
>>> Was there any particular reason which I am unaware of to perform
>>> access_ok() check on modified input length?
>>
>> This change makes sense to me, and seems consistent with what is done
>> elsewhere too.
>=20
> For some reason I missed import_single_range(), which does it the same
> way as import_ubuf() currently does - cap the range before the
> access_ok() check. The vec variants sum as they go, but access_ok()
> before the range.
>=20
> I think part of the issue here is that the single range imports return 0
> for success and -ERROR otherwise. This means that the caller does not
> know if the full range was imported or not. OTOH, we always cap any data
> transfer at MAX_RW_COUNT, so may make more sense to fix up the caller
> here.
>=20

Should we limit to MAX_RW_COUNT or return an error?
Seems to me that limiting could generate side effect later that could be not
simple to debug.


>>>  int import_ubuf(int rw, void __user *buf, size_t len, struct iov_iter *i)
>>>  {
>>> -       if (len > MAX_RW_COUNT)
>>> +               return -EFAULT;
>>>         if (unlikely(!access_ok(buf, len)))
>>>                 return -EFAULT;
>>>
>>>         iov_iter_ubuf(i, rw, buf, len);
>>>         return 0;

or perhaps just remove the test as __access_ok() already tests that the
size < TASK_SIZE

https://elixir.bootlin.com/linux/v6.7-rc4/source/include/asm-generic/access_o=
k.h#L31


Thanks,
Arnaud


--===============5173862191727464677==--

