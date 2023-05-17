From: David Hildenbrand <david@redhat.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: add FOLL_LONGTERM for CMA case when alloc shm
Date: Wed, 17 May 2023 20:23:33 +0200
Message-ID: <d4773626-6cf0-c929-c775-a84ac41fd719@redhat.com>
In-Reply-To: <
 <CAFA6WYO+EpiECFxdVgmd-Ey9jq1Ybt78WupK_bW5+oDcW-soVQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1702287813607224029=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1702287813607224029==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On 17.05.23 12:19, Sumit Garg wrote:
> On Wed, 17 May 2023 at 15:06, Christoph Hellwig <hch@infradead.org> wrote:
>>
>> On Wed, May 17, 2023 at 02:56:13PM +0530, Sumit Garg wrote:
>>> Do you mean a pinned user-space page can be paged out automatically?
>>
>> No, pinned pages can't be paged out.
>>
>> But a short term pin implies it will be release after a short delay,
>> and it is feasible for wait for the pin to go away.
> 
> Okay, I see. I would be interested to know the ranges for that short
> delay. I guess it may depend on how much memory pressure there is...
> 

In general: if user space controls it -> possibly forever -> long-term. 
Even if in most cases it's a short delay: there is no trusting on user 
space.

For example, iouring fixed buffers keep pages pinned until user space 
decides to unregistered the buffers -> long-term.

Short-term is, for example, something like O_DIRECT where we pin -> DMA 
-> unpin in essentially one operation.

-- 
Thanks,

David / dhildenb


--===============1702287813607224029==--

