From: Randy Li <ayaka@soulik.info>
To: op-tee@lists.trustedfirmware.org
Subject: Could secure monitor let op-tee handle secure interrupter?
Date: Wed, 22 Nov 2023 23:01:31 +0000
Message-ID: <de1c35aa-1cbf-450a-9953-eee557c8e8ce@soulik.info>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0098986726040362733=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0098986726040362733==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hello

I was wondering whether the current op-tee os support this that secure 
monitor would trigger the op-tee to handle the native interrupter 
without forwarding it to the REE?

If the answer is yes, could it lead to a dead lock when the linux kernel 
is holding a spinlock(usually irq is disabled in that CPU core) ?

I didn't find much about how should we handle the secure interrupter 
from document, the general way seems to either forward it to REE or just 
don't use the secure interrupter at all.

Let the REE handle the interrupter may not be a good idea, since the 
device could we should ack the interrupter in it, is protected by the 
trustzone, we need to switch CPU to secure mode to handle this tiny task.

I wish I could know more solution about the interrupter here.

Sincerely

Randy


--===============0098986726040362733==--

