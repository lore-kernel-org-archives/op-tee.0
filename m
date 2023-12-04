From: Randy Li <ayaka@soulik.info>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Could secure monitor let op-tee handle secure interrupter?
Date: Tue, 05 Dec 2023 01:09:26 +0800
Message-ID: <1f282d44-7593-47f2-9572-131323f846a1@soulik.info>
In-Reply-To: <
 <CAFA6WYOUbix72jQ=UW8r_UspngBwVetnn89OdkN3skuzBqMhgg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3866785494565667152=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3866785494565667152==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


On 2023/12/4 21:54, Sumit Garg wrote:
> Hi Randy,
>
> On Mon, 27 Nov 2023 at 13:03, Randy Li via OP-TEE
> <op-tee@lists.trustedfirmware.org> wrote:
>> Hello
>>
>> I was wondering whether the current op-tee os support this that secure
>> monitor would trigger the op-tee to handle the native interrupter
>> without forwarding it to the REE?
> I would suggest you to go through this doc [1] to see if it answers
> all your questions. If not then let us know, we will help to clarify
> further.
>
> [1] https://optee.readthedocs.io/en/latest/architecture/core.html#interrupt=
-handling
>
> -Sumit

"When a secure interrupt is signaled by the Arm GIC, it shall reach the=20
OP-TEE OS interrupt exception vector. If the secure world is executing,=20
OP-TEE OS will handle interrupt straight from its exception vector."

And Section "Deliver secure interrupt to secure world when SCR_NS is set"

I think those are the answer to my initial question.

But I didn't see such practice. In the recent changes to Linux kernel,=20
likes OP-TEE notifications, I think the most of platforms would like not=20
let the Secure OS handle the devices' interrupters? I didn't know such a=20
driver in Linux kernel either.

When a CPU core, which is holding a spinlock, have been restored to=20
Secure context by monitor, would it halt the other cores which are=20
waiting for the release of that spinlock?

Besides, when we use a spinlock in the kernel, in the most of time, we=20
except all IRQs are masked(spin_lock_irqsave), could this masked the=20
secure interrupter?

Also, I didn't see there is a guideline about how OP-TEE os should=20
handle native interrupt in this case. If it took too much time, it may=20
lead an innocent process be regarded as hardlockup (or softlockup if it=20
turns to REE after all) in the linux kernel.

>> If the answer is yes, could it lead to a dead lock when the linux kernel
>> is holding a spinlock(usually irq is disabled in that CPU core) ?
>>
>> I didn't find much about how should we handle the secure interrupter
>> from document, the general way seems to either forward it to REE or just
>> don't use the secure interrupter at all.
>>
>> Let the REE handle the interrupter may not be a good idea, since the
>> device could we should ack the interrupter in it, is protected by the
>> trustzone, we need to switch CPU to secure mode to handle this tiny task.
>>
>> I wish I could know more solution about the interrupter here.
>>
>> Sincerely
>>
>> Randy
>>

--===============3866785494565667152==--

