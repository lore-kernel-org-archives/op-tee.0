From: Ira Weiny <ira.weiny@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 1/4] highmem: Enhance is_kmap_addr() to check
 kmap_local_page() mappings
Date: Sat, 04 Feb 2023 10:37:42 -0800
Message-ID: <63dea5f637532_f9c512941c@iweiny-mobl.notmuch>
In-Reply-To: <20230204065001.GA18482@lst.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4548193612530263113=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4548193612530263113==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Christoph Hellwig wrote:
> On Fri, Feb 03, 2023 at 08:06:32PM -0800, Ira Weiny wrote:
> > -	return addr >= PKMAP_ADDR(0) && addr < PKMAP_ADDR(LAST_PKMAP);
> > +
> > +	return (addr >= PKMAP_ADDR(0) && addr < PKMAP_ADDR(LAST_PKMAP)) ||
> > +		(addr >= __fix_to_virt(FIX_KMAP_END) &&
> > +		 addr < __fix_to_virt(FIX_KMAP_BEGIN));
> 
> Isn't the second check inverted?
> 

The enum map runs from top down.  So I believe this is correct.  I tested
it with a different series and it worked.

Ira

--===============4548193612530263113==--

