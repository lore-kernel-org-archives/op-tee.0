From: Jerome Forissier <jerome@forissier.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Shared memory mapping invalid after fork()
Date: Fri, 08 Oct 2021 13:01:53 +0200
Message-ID: <3120b51e-358f-0cbd-8623-d5ff2f2a5ee7@forissier.org>
In-Reply-To: <
 <CAEhEOQkqLvFQ2bR69F0q-BdJVpjq2r7soWtMfCrvQDkJSUFfaw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8024165414133952977=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8024165414133952977==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Robert,

On 10/7/21 4:57 PM, Robert Delien wrote:
> Hi,
> 
> First of all, as I don't see a lot of questions being asked here, so
> please feel free to direct me elsewhere with my question(s) if this is
> not the proper place to do so.

Many people report issues and ask questions on GitHub [1] but here is
fine, too.

[1] https://github.com/OP-TEE/optee_os/issues

> In our application, we are using a custom Optee PTA to control our
> display securely. Our user space application utilizes LVGL with a
> custom LVGL Optee PTA driver, which allocates TEEC_SharedMemory using
> TEEC_AllocateSharedMemory() for the frame buffer, which transferred as
> TEEC_MEMREF_WHOLE to our custom PTA by our custom LVGL Optee-PTA
> driver whenever LVGL flushes its frame buffer.
> 
> Our user space application also starts and stops several LXC containers.
> 
> We noticed that after starting any LXC container, our display freezes.
> In this scenario, our custom LVGL Optee PTA driver is still pushing
> newly updated frame buffer contents to our custom Optee PTA, but the
> buffer received by our custom Optee PTA contains old data.
> 
> We have traced down the cause to a fork() call in lxc_start();
> Replacing lxc_start() with fork() has the same effect, hence we think
> the problem is caused by fork(). After fork, updates from neither the
> parent nor the child appear in the buffer at our custom Optee PTA end.

Do you have a simple reproducer? I tried a simple modification to the
"Hello world" example but could not reproduce the issue. That being
said, the example involves a TA, not a PTA. So perhaps the problem is
caused by some invalid re-use of physical addresses (virt_to_phys())?

> We wonder if this is by design, as shared memory in combination with
> fork() might be a security hazard, exposing memory shared with the
> secure world to any forked process. Are we right? We really would like
> to understand this.

The GlobalPlatform TEE Client API Specification does not mention
anything wrt. fork(). I would say things should "just work", i.e., allow
both the parent and the child to continue communicating with the (P)TA.

Note that the term "shared memory" doesn't imply the existence of a
single physical buffer. An implementation is allowed to copy data
between buffers as long as the semantics of the GP APIs is preserved.
See section 3.2.4 Shared Memory. OP-TEE tries to avoid copies when
possible but this depends on which APIs are used and if dynamic shared
memory is used (CFG_CORE_DYN_SHM=y [default] and a not too old Linux
driver).

> If, instead of using TEEC_AllocateSharedMemory() and
> TEEC_MEMREF_WHOLE, we use calloc() and TEEC_MEMREF_WHOLE instead, the
> problem does not occur. Probably because the memory is mapped at each
> use. Is this the suggested work-around?

I would think both ways should work as you expect, but I might be
missing something.

Regards,
-- 
Jerome

--===============8024165414133952977==--

