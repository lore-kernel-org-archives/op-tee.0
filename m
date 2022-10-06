From: Linus Torvalds <torvalds@linux-foundation.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 2/4] tee: Remove vmalloc page support
Date: Thu, 06 Oct 2022 11:20:16 -0700
Message-ID: 
 <CAHk-=whVyH-wSWLd=Zn4rwo+91T+qzRvfMPC2yFX98GxykOqOw@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYMT9S1Di6DN_UXc823f0ZTkqerE1PB=oG6wmfx28vEbDg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0093557125096530297=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0093557125096530297==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, Oct 5, 2022 at 11:24 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Sorry but you need to get your driver mainline in order to support
> vmalloc interface.

Actually, I think even then we shouldn't support vmalloc - and
register_shm_helper() just needs to be changed to pass in an array of
actual page pointers instead.

At that point TEE_SHM_USER_MAPPED should also go away, because then
it's the caller that should just do either the user space page
pinning, or pass in the kernel page pointer.

JensW, is there some reason that wouldn't work?

                 Linus

--===============0093557125096530297==--

