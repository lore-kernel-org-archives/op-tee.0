From: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: amdtee: add support for use of cma region
Date: Tue, 29 Aug 2023 22:17:06 +0530
Message-ID: <b04ac070-2149-4d61-ad90-75401e173b29@amd.com>
In-Reply-To: <b908433c-0924-fbf7-f555-532e438ff050@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4455446051756352023=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4455446051756352023==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit


On 8/18/2023 8:56 PM, Dave Hansen wrote:
> On 8/18/23 07:42, Devaraj Rangasamy wrote:
>> --- a/arch/x86/kernel/setup.c
>> +++ b/arch/x86/kernel/setup.c
>> @@ -1223,6 +1223,8 @@ void __init setup_arch(char **cmdline_p)
>>   	initmem_init();
>>   	dma_contiguous_reserve(max_pfn_mapped << PAGE_SHIFT);
>>   
>> +	amdtee_cma_reserve();
>> +
>>   	if (boot_cpu_has(X86_FEATURE_GBPAGES))
>>   		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
> Right now, we have *A* global CMA pool set up in
> dma_contiguous_reserve() that everyone shares.
>
> Why does this *one* driver deserve to be a special snowflake and get its
> own private CMA area and own command-line options?
>
> It seems to me like you should just tell users to set
> CONFIG_CMA_SIZE_MBYTES or use cma=size on the command-line and just use
> the global pool.  If you want to make it a special snowflake, there's a
> much higher bar to clear, and there's zero justification for that right now.

Ack.

We had exclusive cma zone due to concern over contention for generic cma 
zone, and to guarentee buffer allocation. We profiled and migrated to 
generic cma zone.

> Oh, and this:
>
>>   static int pool_op_alloc(struct tee_shm_pool *pool, struct tee_shm *shm,
>>   			 size_t size, size_t align)
>>   {
>>   	unsigned int order = get_order(size);
>>   	unsigned long va;
>>   	int rc;
>>   
>>   	/*
>>   	 * Ignore alignment since this is already going to be page aligned
>>   	 * and there's no need for any larger alignment.
>>   	 */
>> 	va = __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
> is goofy.  It either only needs powers-of-2 and can take "order" as an
> argument instead of 'size', or it should be using alloc_pages_exact() to
> avoid wasting memory.

Ack.
This was inherently introduced by __get_free_pages() requirement, and 
constly indeed.
alloc_pages_exact() do call __get_free_pages() internally, and doesnot 
prevent memory fragmentation. but at least unnecessary pages are 
returned back to free pool.

We will update the section accordingly, and post updated patch. Thanks 
for the review.


--===============4455446051756352023==--

