From: Jens Axboe <axboe@kernel.dk>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v4] tee: Use iov_iter to better support shared buffer registration
Date: Mon, 04 Dec 2023 09:40:48 -0700
Message-ID: <cf00a996-c262-4457-93de-ca7960ad6df6@kernel.dk>
In-Reply-To: <438a8b44-ea5f-4e13-bd7e-e1c2e2a481c4@kernel.dk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3893390415953056620=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3893390415953056620==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On 12/4/23 9:36 AM, Jens Axboe wrote:
> On 12/4/23 5:42 AM, Sumit Garg wrote:
>> IMO, access_ok() should be the first thing that import_ubuf() or
>> import_single_range() should do, something as follows:
>>
>> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
>> index 8ff6824a1005..4aee0371824c 100644
>> --- a/lib/iov_iter.c
>> +++ b/lib/iov_iter.c
>> @@ -1384,10 +1384,10 @@ EXPORT_SYMBOL(import_single_range);
>>
>>  int import_ubuf(int rw, void __user *buf, size_t len, struct iov_iter *i)
>>  {
>> -       if (len > MAX_RW_COUNT)
>> -               len = MAX_RW_COUNT;
>>         if (unlikely(!access_ok(buf, len)))
>>                 return -EFAULT;
>> +       if (len > MAX_RW_COUNT)
>> +               len = MAX_RW_COUNT;
>>
>>         iov_iter_ubuf(i, rw, buf, len);
>>         return 0;
>>
>> Jens A., Al Viro,
>>
>> Was there any particular reason which I am unaware of to perform
>> access_ok() check on modified input length?
> 
> This change makes sense to me, and seems consistent with what is done
> elsewhere too.

For some reason I missed import_single_range(), which does it the same
way as import_ubuf() currently does - cap the range before the
access_ok() check. The vec variants sum as they go, but access_ok()
before the range.

I think part of the issue here is that the single range imports return 0
for success and -ERROR otherwise. This means that the caller does not
know if the full range was imported or not. OTOH, we always cap any data
transfer at MAX_RW_COUNT, so may make more sense to fix up the caller
here.

-- 
Jens Axboe


--===============3893390415953056620==--

