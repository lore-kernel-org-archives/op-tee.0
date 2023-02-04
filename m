From: Christoph Hellwig <hch@lst.de>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 1/4] highmem: Enhance is_kmap_addr() to check
 kmap_local_page() mappings
Date: Sat, 04 Feb 2023 06:50:07 +0000
Message-ID: <20230204065001.GA18482@lst.de>
In-Reply-To: <20230203-get_kernel_pages-v2-1-f1dc4af273f1@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0241112204297171763=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0241112204297171763==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, Feb 03, 2023 at 08:06:32PM -0800, Ira Weiny wrote:
> -	return addr >= PKMAP_ADDR(0) && addr < PKMAP_ADDR(LAST_PKMAP);
> +
> +	return (addr >= PKMAP_ADDR(0) && addr < PKMAP_ADDR(LAST_PKMAP)) ||
> +		(addr >= __fix_to_virt(FIX_KMAP_END) &&
> +		 addr < __fix_to_virt(FIX_KMAP_BEGIN));

Isn't the second check inverted?


--===============0241112204297171763==--

