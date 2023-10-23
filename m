From: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v2 1/2] tee: amdtee: use page_alloc_exact() for memory allocations
Date: Mon, 23 Oct 2023 19:31:45 +0530
Message-ID: <cbe9af6c-cf92-4683-b302-0fdfc9c5009b@amd.com>
In-Reply-To: <f08778aa-0e50-40aa-a1be-9cc894b2e219@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1789006445515538273=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1789006445515538273==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit


On 10/5/2023 12:39 AM, Jeff Johnson wrote:
> On 8/29/2023 1:19 PM, Devaraj Rangasamy wrote:> Use page_alloc_exact() 
> to get buffers, instead of
>> get_free_pages(), so as to avoid wastage of memory.
>> Currently get_free_pages() is allocating at next order,
>> while page_alloc_exact() will free the unused pages.
>
> s/page_alloc_exact()/alloc_pages_exact()/ everywhere including subject 
> to match the actual code change?

Ack. Thanks for the catching this.

While I could send an updated patch taking care of this, we are working 
on a rearchitected patch, due to a new requirement.

Kindly abandon this patch series, and we will be posting new support 
soon to the community.


--===============1789006445515538273==--

