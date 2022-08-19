From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2] tee: add overflow check in register_shm_helper()
Date: Fri, 19 Aug 2022 08:07:34 +0200
Message-ID: 
 <CAHUa44Hm7VOb-qoi1N3pm6+wdS+zHTgsHG5C5GzrrvMOd+n6aQ@mail.gmail.com>
In-Reply-To: <
 <CAHk-=wiEqhzrMskE=7_q4E+X+zPyxm6xvuADhaBxh8gD5p57kA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5663958694863450848=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5663958694863450848==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, Aug 18, 2022 at 6:38 PM Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
>
> On Thu, Aug 18, 2022 at 4:09 AM Jens Wiklander
> <jens.wiklander@linaro.org> wrote:
> >
> > Fix this by adding an overflow check when calculating the end of the
> > memory range. Also add an explicit call to access_ok() in
> > tee_shm_register_user_buf() to catch an invalid user space address
> > early.
>
> I applied the access_ok() part of this which was clearly missing.
>
> The check_add_overflow() should be pointless with that.
>
> And the "roundup() overflows" check should just check for a zero
> result - if it is actually needed. Which I don't think it is on any
> relevant platform (the TEE subsystem only works on arm and x86).
>
> I do think it might be worth discussing whether
> ALTERNATE_USER_ADDRESS_SPACE (and no-MMU) architectures should still
> have access_ok() check that it doesn't actually wrap around in the
> address space, so I've added linux-arch here.
>
> That's m68k, PA-RISC, S390 and sparc.
>
> In fact, I wonder if some or all of those might want to have the
> TASK_SIZE limit anyway - they may have a separate user address space,
> but several ones have some limits even then, and probably should have
> access_ok() check them rather than depend on the hardware then giving
> page fault.
>
> For example, sparc32 has a user address space, but defines TASK_SIZE
> to 0xF0000000. m68k has several different case. parisc also has an
> actual limit.
>
> And s390 uses
>
>     #define TASK_SIZE_MAX         (-PAGE_SIZE)
>
> which is a good value and leaves a guard page at the top.
>
> So I think the "roundup overflows" would probably be best fixed by
> just admitting that every architecture in practice has a TASK_SIZE_MAX
> anyway, and we should just make access_ok() check it.

Thanks for the detailed clarifications. I'll remove the redundant
overflow checks.

Cheers,
Jens

>
>               Linus

--===============5663958694863450848==--

