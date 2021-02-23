From: Allen Pais <apais@linux.microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH 1/2] optee: fix tee out of memory failure seen during kexec reboot
Date: Tue, 23 Feb 2021 21:56:13 +0530
Message-ID: <cbc963d5-6c4b-7e69-4a9b-3d66b95affab@linux.microsoft.com>
In-Reply-To: <20210223081948.GA1836717@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2780181658428838574=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2780181658428838574==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit



>>>> -	/*
>>>> -	 * Ask OP-TEE to free all cached shared memory objects to decrease
>>>> -	 * reference counters and also avoid wild pointers in secure world
>>>> -	 * into the old shared memory range.
>>>> -	 */
>>>> -	optee_disable_shm_cache(optee);
>>>> +	if (shutdown) {
>>>> +		optee_disable_shm_cache(optee);
>>>> +	} else {
>>>> +		/*
>>>> +		 * Ask OP-TEE to free all cached shared memory
>>>> +		 * objects to decrease reference counters and
>>>> +		 * also avoid wild pointers in secure world
>>>> +		 * into the old shared memory range.
>>>> +		 */
>>>> +		optee_disable_shm_cache(optee);
>>> Calling optee_disable_shm_cache() in both if and else. It could be
>>> put in front of if().
>>>
>>
>>    Ideally, I could just use optee_remove for shutdown() too.
>> But it would not look good. Hence this approach.
> 
> What is the problem with using optee_remove() for shutdown()?
> 

  There is no problem, I just thought it would be more cleaner/readable
with this approach. If you'd like to keep it simple by just calling
optee_remove() for shutdown() too, I could quickly send out V2.

Thanks for the review.

- Allen

--===============2780181658428838574==--

