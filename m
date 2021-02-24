From: Allen Pais <apais@linux.microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH 1/2] optee: fix tee out of memory failure seen during kexec reboot
Date: Wed, 24 Feb 2021 22:23:34 +0530
Message-ID: <9f4b44c1-cf86-a061-a9c6-726c4e23f99b@linux.microsoft.com>
In-Reply-To: <20210224081553.GB2653493@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9209883478016117929=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============9209883478016117929==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit


>>>>>> -	/*
>>>>>> -	 * Ask OP-TEE to free all cached shared memory objects to decrease
>>>>>> -	 * reference counters and also avoid wild pointers in secure world
>>>>>> -	 * into the old shared memory range.
>>>>>> -	 */
>>>>>> -	optee_disable_shm_cache(optee);
>>>>>> +	if (shutdown) {
>>>>>> +		optee_disable_shm_cache(optee);
>>>>>> +	} else {
>>>>>> +		/*
>>>>>> +		 * Ask OP-TEE to free all cached shared memory
>>>>>> +		 * objects to decrease reference counters and
>>>>>> +		 * also avoid wild pointers in secure world
>>>>>> +		 * into the old shared memory range.
>>>>>> +		 */
>>>>>> +		optee_disable_shm_cache(optee);
>>>>> Calling optee_disable_shm_cache() in both if and else. It could be
>>>>> put in front of if().
>>>>>
>>>>
>>>>     Ideally, I could just use optee_remove for shutdown() too.
>>>> But it would not look good. Hence this approach.
>>>
>>> What is the problem with using optee_remove() for shutdown()?
>>>
>>
>>   There is no problem, I just thought it would be more cleaner/readable
>> with this approach. If you'd like to keep it simple by just calling
>> optee_remove() for shutdown() too, I could quickly send out V2.
> 
> In the patch you posted it looks like you'd like to call
> only optee_disable_shm_cache() in the case of shutdown. Like:
> 
> static void optee_shutdown(struct platform_device *pdev)
> {
>          optee_disable_shm_cache(platform_get_drvdata(pdev));
> }
> 
> and optee_remove() kept as it was before this patch.
> 

  Sure, Will have it fixed and send out V2.

Thanks.

--===============9209883478016117929==--

