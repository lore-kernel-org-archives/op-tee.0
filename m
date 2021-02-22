From: Allen Pais <apais@linux.microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH 1/2] optee: fix tee out of memory failure seen during kexec reboot
Date: Mon, 22 Feb 2021 18:15:08 +0530
Message-ID: <8d87655f-27c6-6a66-6eb0-9244279fbf2c@linux.microsoft.com>
In-Reply-To: <20210217092714.121297-2-allen.lkml@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5958775165474299581=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5958775165474299581==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit


> On Wed, 17 Feb 2021 14:57:12 +0530, Allen Pais wrote:
>> -	/*
>> -	 * Ask OP-TEE to free all cached shared memory objects to decrease
>> -	 * reference counters and also avoid wild pointers in secure world
>> -	 * into the old shared memory range.
>> -	 */
>> -	optee_disable_shm_cache(optee);
>> +	if (shutdown) {
>> +		optee_disable_shm_cache(optee);
>> +	} else {
>> +		/*
>> +		 * Ask OP-TEE to free all cached shared memory
>> +		 * objects to decrease reference counters and
>> +		 * also avoid wild pointers in secure world
>> +		 * into the old shared memory range.
>> +		 */
>> +		optee_disable_shm_cache(optee);
>   
> Calling optee_disable_shm_cache() in both if and else. It could be
> put in front of if().
> 

   Ideally, I could just use optee_remove for shutdown() too.
But it would not look good. Hence this approach.

- Allen

--===============5958775165474299581==--

