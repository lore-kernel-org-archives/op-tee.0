From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [RFC PATCH 1/4] tee: Re-enable vmalloc page support for shared memory
Date: Wed, 24 May 2023 14:01:35 +0000
Message-ID: <18a8528d-7d9d-6ed0-0045-5ee47dd39fb2@foss.st.com>
In-Reply-To: <ZG2yw0xZ6XGGp9E5@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3668711044579667491=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3668711044579667491==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hello Christoph,

On 5/24/23 08:46, Christoph Hellwig wrote:
> On Tue, May 23, 2023 at 11:13:47AM +0200, Arnaud Pouliquen wrote:
>> This patch revert commit c83900393aa1 ("tee: Remove vmalloc page support")
> 
> As per the discussion back then: don't just blindly do the same dumb
> thing again and fix the interfae to actually pass in a page array,
> or iov_iter or an actually useful container that fits.
> 

I suppose your are speaking about this discussion:
https://lore.kernel.org/all/20221002002326.946620-3-ira.weiny(a)intel.com/

If I'm not mistaken, I should modify at tee_shm_register_kernel_buf API and
register_shm_helper inernal function, right?

Seems that Jens has also pointed out the free part...

What about having equivalent of shm_get_kernel_pages in an external helper (to
defined where to put it), could it be an alternative of the upadate of the
tee_shm API?

Thanks,
Arnaud

--===============3668711044579667491==--

