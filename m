From: Andrew Morton <akpm@linux-foundation.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 4/4] mm: Remove get_kernel_pages()
Date: Fri, 10 Feb 2023 21:59:30 +0000
Message-ID: <20230210135926.f0c86a21d5b4862d4d897b25@linux-foundation.org>
In-Reply-To: <20230203-get_kernel_pages-v2-4-f1dc4af273f1@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4891521023469222583=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4891521023469222583==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, 03 Feb 2023 20:06:35 -0800 Ira Weiny <ira.weiny@intel.com> wrote:

> The only caller to get_kernel_pages() [shm_get_kernel_pages()] has been
> updated to not need it.
> 
> Remove get_kernel_pages().

Acked-by: Andrew Morton <akpm@linux-foudation.org>


--===============4891521023469222583==--

