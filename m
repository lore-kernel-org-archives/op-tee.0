From: Patrik Lantz <Patrik.Lantz@axis.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: drivers/tee double-free of page when optee_shm_register fails
Date: Tue, 14 Dec 2021 11:25:34 +0000
Message-ID: <baaa865865c04375ad5e3a9602de0bc5@axis.com>
In-Reply-To: <
 <CAFA6WYObPg3gTh9Vas55ae7AhRHWHV7sLNq8=BPNYKqK2aXS8g@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5614348010412584930=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5614348010412584930==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I'm running the version from [1] (5.14.0) with CONFIG_KASAN=3Dy and CONFIG_KA=
SAN_INLINE=3Dy.


[1] https://optee.readthedocs.io/en/latest/faq/faq.html#faq-try-optee
________________________________
From: Sumit Garg <sumit.garg@linaro.org>
Sent: Tuesday, December 14, 2021 10:55:53 AM
To: Patrik Lantz
Cc: Lars Persson; op-tee(a)lists.trustedfirmware.org
Subject: Re: drivers/tee double-free of page when optee_shm_register fails

On Tue, 14 Dec 2021 at 14:00, Patrik Lantz <Patrik.Lantz@axis.com> wrote:
>
> Hi,
>
>
> I'm attaching a reproducer (only CA, there is no TA used in this case ) and=
 crash log for reference.
>

I compiled and ran this CA on my Qemuv8 setup (using the latest OP-TEE
build master) and I can't reproduce this double-free issue. Can you
share details regarding your OP-TEE setup?

-Sumit

>
> Regards,
>
> Patrik
>
> ________________________________
> From: Sumit Garg <sumit.garg@linaro.org>
> Sent: Tuesday, December 14, 2021 8:41:20 AM
> To: Lars Persson
> Cc: op-tee(a)lists.trustedfirmware.org; Patrik Lantz
> Subject: Re: drivers/tee double-free of page when optee_shm_register fails
>
> Hi Lars,
>
> On Fri, 10 Dec 2021 at 20:23, Lars Persson <larper@axis.com> wrote:
> >
> > Hi
> >
> > Me and Patrik have been tracing a kernel memory corruption bug that is
> > triggered when op-tee runs out of resources and returns an error from
> > the OPTEE_MSG_CMD_REGISTER_SHM call. This is yet another fall-out from
> > Patrik's fuzzing of the TEE subsystem.
> >
> > The symptoms would look like this when page debugging is enabled:
> > BUG: Bad page state in process optee_example_h  pfn:46bb0
> > page:(ptrval) refcount:-1 mapcount:0 mapping:00000000 index:0x0 pfn:0x46b=
b0
> > flags: 0x0(zone=3D0)
> >
> > Our reproducer runs a loop with the TEE_IOC_SHM_ALLOC until memory runs
> > out at the optee-os end (dynamic SHM enabled). The error is 100%
> > reproducible with such a loop.
>
> Can you share a simple reproducer test application (CA and TA)?
>
> >
> > We have traced this down to what seems to be a miss in the memory
> > ownership contract during the call to OPTEE_MSG_CMD_REGISTER_SHM.
> >
> > When pool_op_alloc() detects that optee_shm_register() has failed, it
> > will free the allocated page at the very end of the function.
> > Unfortunately that page has already been freed because OP-TEE has sent a
> > OPTEE_RPC_CMD_SHM_FREE for this shm object before returning from
> > OPTEE_MSG_CMD_REGISTER_SHM. This is my conclusion based on prints added
> > to the code.
>
> I can't see any RPC free command from OP-TEE in case the
> OPTEE_MSG_CMD_REGISTER_SHM fails. Have you compared kernel addresses
> for SHM during OPTEE_MSG_CMD_REGISTER_SHM and OPTEE_RPC_CMD_SHM_FREE?
>
> >
> > I cannot write a patch for this because I am at a loss of who actually
> > is supposed to trigger the free of the pages in this situation. Is there
> > an API spec that makes this clear ?
>
> It should only be the pool_op_alloc() API in case
> OPTEE_MSG_CMD_REGISTER_SHM fails.
>
> -Sumit
>
> >
> > BR,
> >   Lars

--===============5614348010412584930==--

