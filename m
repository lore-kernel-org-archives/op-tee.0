From: Robert Delien <r.delien@payter.nl>
To: op-tee@lists.trustedfirmware.org
Subject: Shared memory mapping invalid after fork()
Date: Thu, 07 Oct 2021 16:57:18 +0200
Message-ID: 
 <CAEhEOQkqLvFQ2bR69F0q-BdJVpjq2r7soWtMfCrvQDkJSUFfaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4174616169404988228=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4174616169404988228==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

First of all, as I don't see a lot of questions being asked here, so
please feel free to direct me elsewhere with my question(s) if this is
not the proper place to do so.

In our application, we are using a custom Optee PTA to control our
display securely. Our user space application utilizes LVGL with a
custom LVGL Optee PTA driver, which allocates TEEC_SharedMemory using
TEEC_AllocateSharedMemory() for the frame buffer, which transferred as
TEEC_MEMREF_WHOLE to our custom PTA by our custom LVGL Optee-PTA
driver whenever LVGL flushes its frame buffer.

Our user space application also starts and stops several LXC containers.

We noticed that after starting any LXC container, our display freezes.
In this scenario, our custom LVGL Optee PTA driver is still pushing
newly updated frame buffer contents to our custom Optee PTA, but the
buffer received by our custom Optee PTA contains old data.

We have traced down the cause to a fork() call in lxc_start();
Replacing lxc_start() with fork() has the same effect, hence we think
the problem is caused by fork(). After fork, updates from neither the
parent nor the child appear in the buffer at our custom Optee PTA end.

We wonder if this is by design, as shared memory in combination with
fork() might be a security hazard, exposing memory shared with the
secure world to any forked process. Are we right? We really would like
to understand this.

If, instead of using TEEC_AllocateSharedMemory() and
TEEC_MEMREF_WHOLE, we use calloc() and TEEC_MEMREF_WHOLE instead, the
problem does not occur. Probably because the memory is mapped at each
use. Is this the suggested work-around?

Thank you in advance.

With kind regards,

        Robert Deliën.

-- 
DISCLAIMER
De informatie, verzonden in of met dit e-mailbericht, is 
vertrouwelijk en uitsluitend voor de geadresseerde(n) bestemd. Het gebruik 
van de informatie in dit bericht, de openbaarmaking, vermenigvuldiging, 
verspreiding en|of verstrekking daarvan aan derden is niet toegestaan. 
Gebruik van deze informatie door anderen dan geadresseerde(n) is strikt 
verboden. Aan deze informatie kunnen geen rechten worden ontleend. U wordt 
verzocht bij onjuiste adressering de afzender direct te informeren door het 
bericht te retourneren en het bericht uit uw computersysteem te verwijderen.

--===============4174616169404988228==--

