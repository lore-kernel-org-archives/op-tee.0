From: Phil Chang <phil.chang@mediatek.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: Re: [PATCH v4] tee: make tee_shm_register_kernel_buf vmalloc supported
Date: Wed, 06 Apr 2022 22:40:28 +0800
Message-ID: <20220406144028.4203-1-phil.chang@mediatek.com>
In-Reply-To: <
 <CAHUa44GDg7hAAFsmeOOkeqi8_1P1Q6jATRdnV9b6S-DhpEEQrA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8422315689009070529=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8422315689009070529==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

> On Fri, Feb 25, 2022 at 4:20 PM Phil Chang <phil.chang@mediatek.com>
> wrote:
>>
>> In some low-memory devices, it's hard to aquire large-orders pages,
>> this patch allowed user using scatter pages to register shm.
>>
>> Signed-off-by: Phil Chang <phil.chang@mediatek.com>
>> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
>> ---
>>  drivers/tee/optee/call.c |  2 +-
>>  drivers/tee/tee_shm.c    | 35 +++++++++++++++++++++++++----------
>>  2 files changed, 26 insertions(+), 11 deletions(-)
>
> Looks good to me. Unfortunately this is too late for the coming merge
> window, so it's going to be the one after that. Meanwhile it will be
> in linux-next.
>
> Thanks,
> Jens

 Hi Jens
   thanks for your review, did I push again wile merge window open ?
   Or just wait ?

 Thanks

>>
>> diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
>> index bd49ec934060..2082e632adff 100644
>> --- a/drivers/tee/optee/call.c
>> +++ b/drivers/tee/optee/call.c
>> @@ -362,7 +362,7 @@ int optee_check_mem_type(unsigned long start,
>> size_t num_pages)
>>          * Allow kernel address to register with OP-TEE as kernel
>>          * pages are configured as normal memory only.
>>          */
>> -       if (virt_addr_valid(start))
>> +       if (virt_addr_valid(start) || is_vmalloc_addr((void *)start))
>>                 return 0;
>>
>>         mmap_read_lock(mm);
>> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
>> index f31e29e8f1ca..836872467dc6 100644
>> --- a/drivers/tee/tee_shm.c
>> +++ b/drivers/tee/tee_shm.c
>> @@ -23,21 +23,36 @@ static void shm_put_kernel_pages(struct page
>> **pages, size_t page_count)
>>  static int shm_get_kernel_pages(unsigned long start, size_t
>>  page_count,
>>                                 struct page **pages)
>>  {
>> -       struct kvec *kiov;
>>         size_t n;
>>         int rc;
>>
>> -       kiov = kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
>> -       if (!kiov)
>> -               return -ENOMEM;
>> +       if (is_vmalloc_addr((void *)start)) {
>> +               struct page *page;
>>
>> -       for (n = 0; n < page_count; n++) {
>> -               kiov[n].iov_base = (void *)(start + n * PAGE_SIZE);
>> -               kiov[n].iov_len = PAGE_SIZE;
>> -       }
>> +               for (n = 0; n < page_count; n++) {
>> +                       page = vmalloc_to_page((void *)(start +
>> PAGE_SIZE * n));
>> +                       if (!page)
>> +                               return -ENOMEM;
>> +
>> +                       get_page(page);
>> +                       pages[n] = page;
>> +               }
>> +               rc = page_count;
>> +       } else {
>> +               struct kvec *kiov;
>> +
>> +               kiov = kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
>> +               if (!kiov)
>> +                       return -ENOMEM;
>>
>> -       rc = get_kernel_pages(kiov, page_count, 0, pages);
>> -       kfree(kiov);
>> +               for (n = 0; n < page_count; n++) {
>> +                       kiov[n].iov_base = (void *)(start + n *
>> PAGE_SIZE);
>> +                       kiov[n].iov_len = PAGE_SIZE;
>> +               }
>> +
>> +               rc = get_kernel_pages(kiov, page_count, 0, pages);
>> +               kfree(kiov);
>> +       }
>>
>>         return rc;
>>  }
>> --
>> 2.25.1

--===============8422315689009070529==--

