From: Andrew Morton <akpm@linux-foundation.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 1/4] highmem: Enhance is_kmap_addr() to check
 kmap_local_page() mappings
Date: Fri, 10 Feb 2023 21:59:08 +0000
Message-ID: <20230210135902.343f6c40001f1f2e10cedd93@linux-foundation.org>
In-Reply-To: <20230203-get_kernel_pages-v2-1-f1dc4af273f1@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0184956508498036319=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0184956508498036319==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, 03 Feb 2023 20:06:32 -0800 Ira Weiny <ira.weiny@intel.com> wrote:

> is_kmap_addr() is only looking at the kmap() address range which may
> cause check_heap_object() to miss checking an overflow on a
> kmap_local_page() page.
> 
> Add a check for the kmap_local_page() address range to is_kmap_addr().

Acked-by: Andrew Morton <akpm@linux-foudation.org>


--===============0184956508498036319==--

