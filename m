From: Daniel Thompson <daniel.thompson@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] optee: Suppress false positive kmemleak report in
 optee_handle_rpc()
Date: Mon, 13 Dec 2021 13:04:00 +0000
Message-ID: <20211213130400.npccyt36r5sysca3@maple.lan>
In-Reply-To: <
 <CAFA6WYPd+SLT+XZgLPVjLph27P1D5RpYuLwNu4KC+2nOQH07_Q@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0380705613349935273=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0380705613349935273==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 13, 2021 at 02:28:01PM +0530, Sumit Garg wrote:
> On Fri, 10 Dec 2021 at 21:19, Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> > On Fri, Dec 10, 2021 at 03:08:21PM +0530, Sumit Garg wrote:
> > > On Fri, 10 Dec 2021 at 13:40, Jerome Forissier <jerome@forissier.org>=
 wrote:
> > > > On 12/10/21 06:00, Sumit Garg wrote:
> > > > > On Fri, 10 Dec 2021 at 09:42, Wang, Xiaolei <Xiaolei.Wang@windriv=
er.com> wrote:
> > > > > Yes. AFAICT, optee-os should allocate shared memory to communicate
> > > > > with tee-supplicant. So once the communication is done, the underly=
ing
> > > > > shared memory should be freed. I can't think of any scenario where
> > > > > optee-os should keep hold-off shared memory indefinitely.
> > > >
> > > > I believe it can happen when OP-TEE's CFG_PREALLOC_RPC_CACHE is y. See
> > > > the config file [1] and the commit which introduced this config [2].
> > >
> > > Okay, I see the reasoning. So during the OP-TEE driver's lifetime, the
> > > RPC shared memory remains allocated. I guess that is done primarily
> > > for performance reasons.
> > >
> > > But still it doesn't feel appropriate that we term all RPC shm
> > > allocations as not leaking memory as we might miss obvious ones.
> >
> > IIUC this patch adds kmemleak_not_leak() at (pretty much) the last
> > possible point before *ownership* of the SHM block is passed from kernel
> > to OP-TEE.
>=20
> I wouldn't say it's a transfer of ownership from kernel to OP-TEE but
> rather a way for OP-TEE to access kernel's memory in order to pass
> info or execute further RPC commands.

The RPC handler allocates a pointer (e.g. now the RPC handler owns the
allocated memory). The RPC handler then passes that pointer to OP-TEE and
forgets what it's value was.

That is a transfer of ownership: the RPC handler does not hold any pointer
to the memory and is incapable of freeing it. Moreover this situation is
what kmemleak_no_leak() is for! Its job it to inform kmemleak that the
pointer is owned/stored somewhere that is does not scan.


> > Sure, after we change ownership it could still be leaked... but it can
> > no longer be leaked by the kernel because the kernel no longer owns it!
> > More importantly, it makes no sense to run the kernel memory detector on =
the
> > buffer because it simply can't work.
> >
> > After the RPC completes, doesn't it become impossible for kmemleak to
> > scan to see if the pointer is lost[1]?
>=20
> Apart from the special OP-TEE prealloc SHM cache stuff, I can't think
> of any scenario where an OP-TEE thread should hold off kernel's memory
> pointers for more than 5 seconds before being passed onto kernel for
> further RPC commands or RPC free action. So the kmemleak should be
> able to detect if a pointer is lost.

Or putting this a different way: there is known to be firmware in the
field that allocates pointers for more then five seconds!


> /*
>  * Kmemleak configuration and common defines.
>  */
> <snip>
> #define MSECS_MIN_AGE           5000    /* minimum object age for reporting=
 */
> <snip>
>=20
> > kmemleak is essentially a tracing
> > garbage collector and needs to be able to scan all memory that could
> > hold a pointer to leakable memory. After the RPC completes the
> > only copy of the pointer will be stored in a memory region that the
> > kernel is prohibited from reading. How could kmemleak possibly give you
> > a useful answer in this circumstance?
> >
>=20
> There is another aspect of kmemleak being the minimum age of an object
> to be reported as a memory leak as described above. Also, this case
> resembles where a pointer is stored on the CPU stack (see struct
> optee_rpc_param param =3D { };).

I can't see how this resembles pointers stored on the stack.

Firstly, stack memory is scanned by kmemleak meaning a thread is
permitted to own memory for more than five seconds without provoking a
warning. OP-TEE memory cannot be scanned like this.

Secondly, stacks don't have any concept of sessions. It is *really*
buggy behaviour for a TA to allocate SHM memory during a session open so
it can avoid critical path RPC round trips when operational?

=20
> In most of the scenarios apart from special prealloc shm cache case,
> the flow should be as follows:
>=20
> 1) Alloc kernel memory via RPC
> 2) OP-TEE passes references to kernel memory for RPC action commands
> 3) Free kernel memory via RPC
>=20
> kmemleak should be useful in case the 3rd step is skipped due to
> incorrect behaviour of a particular OP-TEE thread. And I can't think
> of any appropriate way in OP-TEE OS to detect this type of kernel
> memory leak caused by one of its threads.

If OP-TEE is the only place the pointer is held and you can't think of
any way for OP-TEE OS to detect if it has leaked the pointer then how
can you expect the kernel to give a correct verdict when it has even
less visibility than OP-TEE OS.

Note that, if you think OP-TEE routinely leaks memory, then there are
ways that the corresponding kernel driver could track what memory it has
handed to OP-TEE. However this should be described as a list of
*allocations* rather than a list of *leaks* because the driver cannot
distinguish the two.


Daniel.

--===============0380705613349935273==--

