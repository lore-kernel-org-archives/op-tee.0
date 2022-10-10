From: Christoph Hellwig <hch@lst.de>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 2/4] tee: Remove vmalloc page support
Date: Mon, 10 Oct 2022 09:42:34 +0200
Message-ID: <20221010074234.GA20788@lst.de>
In-Reply-To: <
 <CAHk-=whVyH-wSWLd=Zn4rwo+91T+qzRvfMPC2yFX98GxykOqOw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7678119409563277736=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7678119409563277736==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, Oct 06, 2022 at 11:20:16AM -0700, Linus Torvalds wrote:
> Actually, I think even then we shouldn't support vmalloc - and
> register_shm_helper() just needs to be changed to pass in an array of
> actual page pointers instead.
> 
> At that point TEE_SHM_USER_MAPPED should also go away, because then
> it's the caller that should just do either the user space page
> pinning, or pass in the kernel page pointer.
> 
> JensW, is there some reason that wouldn't work?

I suspect the best long term option would be to just pass an iov_iter..

--===============7678119409563277736==--

