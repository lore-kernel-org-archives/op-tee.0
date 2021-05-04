From: Rijo Thomas <Rijo-john.Thomas@amd.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v3] tee: amdtee: unload TA only when its refcount becomes 0
Date: Tue, 04 May 2021 09:56:10 +0530
Message-ID: <01387b92-263c-edf1-52bf-b2244ebbd311@amd.com>
In-Reply-To: <20210503114734.GI21598@kadam>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5629082342605353519=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5629082342605353519==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit



On 03/05/21 5:17 pm, Dan Carpenter wrote:
> On Mon, May 03, 2021 at 09:04:35AM +0530, Rijo Thomas wrote:
>>
>>
>> On 14/04/21 11:08 pm, Rijo Thomas wrote:
>>> Same Trusted Application (TA) can be loaded in multiple TEE contexts.
>>>
>>> If it is a single instance TA, the TA should not get unloaded from AMD
>>> Secure Processor, while it is still in use in another TEE context.
>>>
>>> Therefore reference count TA and unload it when the count becomes zero.
>>>
>>> Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
>>> Reviewed-by: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
>>> Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
>>
>> Hi Dan,
>>
>> Can you please give an Ack if you are okay with this patch.
>> I have incorporated your review comments for v2.
>>
> 
> Oh, Sorry.  Thanks!
> 
> Acked-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks Dan!

Jens, can you please pull in this patch.

Thanks,
Rijo

> 
> regards,
> dan carpenter
> 

--===============5629082342605353519==--

