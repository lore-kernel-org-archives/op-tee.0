From: Dave Hansen <dave.hansen@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: amdtee: add support for use of cma region
Date: Fri, 18 Aug 2023 08:26:09 -0700
Message-ID: <b908433c-0924-fbf7-f555-532e438ff050@intel.com>
In-Reply-To: <=?utf-8?q?=3C7531423fcb3b18ff78737ae5eabc84b0e3cb2909=2E1692369?=
 =?utf-8?q?704=2Egit=2EDevaraj=2ERangasamy=40amd=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1438861534973969541=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1438861534973969541==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On 8/18/23 07:42, Devaraj Rangasamy wrote:
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1223,6 +1223,8 @@ void __init setup_arch(char **cmdline_p)
>  	initmem_init();
>  	dma_contiguous_reserve(max_pfn_mapped << PAGE_SHIFT);
>  
> +	amdtee_cma_reserve();
> +
>  	if (boot_cpu_has(X86_FEATURE_GBPAGES))
>  		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);

Right now, we have *A* global CMA pool set up in
dma_contiguous_reserve() that everyone shares.

Why does this *one* driver deserve to be a special snowflake and get its
own private CMA area and own command-line options?

It seems to me like you should just tell users to set
CONFIG_CMA_SIZE_MBYTES or use cma=size on the command-line and just use
the global pool.  If you want to make it a special snowflake, there's a
much higher bar to clear, and there's zero justification for that right now.

Oh, and this:

>  static int pool_op_alloc(struct tee_shm_pool *pool, struct tee_shm *shm,
>  			 size_t size, size_t align)
>  {
>  	unsigned int order = get_order(size);
>  	unsigned long va;
>  	int rc;
>  
>  	/*
>  	 * Ignore alignment since this is already going to be page aligned
>  	 * and there's no need for any larger alignment.
>  	 */
> 	va = __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);

is goofy.  It either only needs powers-of-2 and can take "order" as an
argument instead of 'size', or it should be using alloc_pages_exact() to
avoid wasting memory.

--===============1438861534973969541==--

