From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v2 1/2] tee: amdtee: use page_alloc_exact() for memory allocations
Date: Wed, 04 Oct 2023 19:10:04 +0000
Message-ID: <f08778aa-0e50-40aa-a1be-9cc894b2e219@quicinc.com>
In-Reply-To: <=?utf-8?q?=3Cfe6fd7781d77ea32064e5b861f33150b28768278=2E1693340?=
 =?utf-8?q?098=2Egit=2EDevaraj=2ERangasamy=40amd=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6418643503978030545=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6418643503978030545==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On 8/29/2023 1:19 PM, Devaraj Rangasamy wrote:> Use page_alloc_exact() 
to get buffers, instead of
> get_free_pages(), so as to avoid wastage of memory.
> Currently get_free_pages() is allocating at next order,
> while page_alloc_exact() will free the unused pages.

s/page_alloc_exact()/alloc_pages_exact()/ everywhere including subject 
to match the actual code change?


--===============6418643503978030545==--

