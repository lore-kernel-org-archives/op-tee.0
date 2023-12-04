From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Could secure monitor let op-tee handle secure interrupter?
Date: Mon, 04 Dec 2023 19:24:32 +0530
Message-ID: 
 <CAFA6WYOUbix72jQ=UW8r_UspngBwVetnn89OdkN3skuzBqMhgg@mail.gmail.com>
In-Reply-To: <de1c35aa-1cbf-450a-9953-eee557c8e8ce@soulik.info>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2745615026001543363=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2745615026001543363==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Randy,

On Mon, 27 Nov 2023 at 13:03, Randy Li via OP-TEE
<op-tee@lists.trustedfirmware.org> wrote:
>
> Hello
>
> I was wondering whether the current op-tee os support this that secure
> monitor would trigger the op-tee to handle the native interrupter
> without forwarding it to the REE?

I would suggest you to go through this doc [1] to see if it answers
all your questions. If not then let us know, we will help to clarify
further.

[1] https://optee.readthedocs.io/en/latest/architecture/core.html#interrupt-h=
andling

-Sumit

>
> If the answer is yes, could it lead to a dead lock when the linux kernel
> is holding a spinlock(usually irq is disabled in that CPU core) ?
>
> I didn't find much about how should we handle the secure interrupter
> from document, the general way seems to either forward it to REE or just
> don't use the secure interrupter at all.
>
> Let the REE handle the interrupter may not be a good idea, since the
> device could we should ack the interrupter in it, is protected by the
> trustzone, we need to switch CPU to secure mode to handle this tiny task.
>
> I wish I could know more solution about the interrupter here.
>
> Sincerely
>
> Randy
>

--===============2745615026001543363==--

