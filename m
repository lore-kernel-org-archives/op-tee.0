From: Linus Torvalds <torvalds@linux-foundation.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 2/4] tee: Remove vmalloc page support
Date: Mon, 10 Oct 2022 10:20:15 -0700
Message-ID: 
 <CAHk-=whvmR98OHdYf4yOJgp86hq0VMVXJ9b1Qk7P_Rjq_=HU+A@mail.gmail.com>
In-Reply-To: <20221010074234.GA20788@lst.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3357829312643277119=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3357829312643277119==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Mon, Oct 10, 2022 at 12:42 AM Christoph Hellwig <hch@lst.de> wrote:
>
> I suspect the best long term option would be to just pass an iov_iter..

Hmm. Yeah, that sounds like a workable model, and solves the problem
JensW pointed out with my simplistic "just pass a page array" approach
where you also need to keep track of how to release things.

                   Linus

--===============3357829312643277119==--

