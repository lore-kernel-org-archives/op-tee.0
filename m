From: Yuvraj Sakshith <yuvraj.kernel@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [RFC PATCH 0/7] KVM: optee: Introduce OP-TEE Mediator for
 exposing secure world to KVM guests
Date: Wed, 02 Apr 2025 16:49:50 +0530
Message-ID: <Z-0dVi1_XMmmVZsL@raj>
In-Reply-To: <87jz83ymww.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8088995966045933458=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8088995966045933458==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 02, 2025 at 09:42:39AM +0100, Marc Zyngier wrote:
> On Wed, 02 Apr 2025 03:58:48 +0100,
> Yuvraj Sakshith <yuvraj.kernel@gmail.com> wrote:
> >=20
> > On Tue, Apr 01, 2025 at 07:13:26PM +0100, Marc Zyngier wrote:
> > > On Tue, 01 Apr 2025 18:05:20 +0100,
> > > Yuvraj Sakshith <yuvraj.kernel@gmail.com> wrote:
> > > >
>=20
> [...]
>=20
> > > > This implementation has been heavily inspired by Xen's OP-TEE
> > > > mediator.
> > >=20
> > > [...]
> > >=20
> > > And I think this inspiration is the source of most of the problems in
> > > this series.
> > >=20
> > > Routing Secure Calls from the guest to whatever is on the secure side
> > > should not be the kernel's job at all. It should be the VMM's job. All
> > > you need to do is to route the SMCs from the guest to userspace, and
> > > we already have all the required infrastructure for that.
> > >
> > Yes, this was an argument at the time of designing this solution.
> >
> > > It is the VMM that should:
> > >=20
> > > - signal the TEE of VM creation/teardown
> > >=20
> > > - translate between IPAs and host VAs without involving KVM
> > >=20
> > > - let the host TEE driver translate between VAs and PAs and deal with
> > >   the pinning as required, just like it would do for any userspace
> > >   (without ever using the KVM memslot interface)
> > >=20
> > > - proxy requests from the guest to the TEE
> > >=20
> > > - in general, bear the complexity of anything related to the TEE
> > >
> >=20
> > Major reason why I went with placing the implementation inside the kernel=
 is,
> > 	- OP-TEE userspace lib (client) does not support sending SMCs for VM eve=
nts
> > 	  and needs modification.
> > 	- QEMU (or every other VMM)  will have to be modified.
>=20
> Sure. And what? New feature, new API, new code. And what will happen
> once someone wants to use something other than OP-TEE? Or one of the
> many forks of OP-TEE that have a completely different ABI (cue the
> Android forks -- yes, plural)?

If something other than OP-TEE has to be supported, a specific mediator
(such as drivers/tee/optee/optee_mediator.c) has to be constructed
with handlers hooked via tee_mediator_register_ops().

But yes, the ABI might change and the implementor has the freedom to
mediate it as required.

> > 	- OP-TEE driver is anyways in the kernel. A mediator will just be an add=
ition
> > 		and not a completely new entity.
>=20
> Of course not. The TEE can be anywhere I want. On another machine if I
> decide so. Just because OP-TEE has a very simplistic model doesn't
> mean we have to be constrained by it.
>=20
> > 	- (Potential) issues if we would want to mediate requests from VM which =
has
> > 	  private mem.
>=20
> Private memory means that not even the host has access to it, as it is
> the case with pKVM. How would that be an issue?
>

Guest shares memory to OP-TEE through a buffer filled with pointers, which
the mediator has to read for IPA->PA translations of all these pointers.
VMM wont be able to read these if memory is private.

But, this is a "potential" solution and if at all the mediator is moved to VM=
M,
this is completely ruled out.
=20
> > 	- Heavy VM exits if guest makes frequent TOS calls.
>=20
> Sorry, I have to completely dismiss the argument here. I'm not even
> remotely considering performance for something that is essentially a
> full context switch of the whole machine. By definition, calling into
> EL3, and then S-EL1/S-EL2 is going to be as fast as a dying snail, and
> an additional exit to userspace will hardly register for anything
> other than a pointless latency benchmark.
>=20
Okay, makes sense.
> >=20
> > Hence, the thought of making changes to too many entities (libteec,
> > VMM, etc.) was a strong reason, although arguable.
>=20
> It is a *terrible* reason. By this reasoning, we would have subsumed
> the whole VMM into the kernel (just like Xen), because "we don't want
> to change userspace".
>=20
> Furthermore, you are not even considering basic things such as
> permissions. Your approach completely circumvents any form of access
> control, meaning that if any user that can create a VM can talk to the
> TEE, even if they don't have access to the TEE driver.

Well, this is a good point. OP-TEE built for NS-Virt supports handles calls
from different VMs under different MMU partitions (will need to go off track
to explain this). But, each VM's state and data remains isolated internally
in S-EL1.

> Yes, you could replicate access permission, SE-Linux, seccomp (and the
> rest of the security theater) at the KVM/TEE boundary, making the
> whole thing even more of a twisted mess.
>=20
> Or you could simply do the right thing and let the kernel do its job
> the way it was intended by using the syscall interface from userspace.
>=20
> >=20
> > > In short, the VMM is just another piece of userspace using the TEE to
> > > do whatever it wants. The TEE driver on the host must obviously know
> > > about VMs, but that's about it.
> > >=20
> > > Crucially, KVM should:
> > >=20
> > > - be completely TEE agnostic and never call into something that is
> > >   TEE-specific
> > >=20
> > > - allow a TEE implementation entirely in userspace, specially for the
> > >   machines that do not have EL3
> > >
> >=20
> > Yes, you're right. Although I believe there still are some changes
> > that need to be made to KVM for facilitating this. For example,
> > kvm_smccc_get_action() would deny TOS call.
>=20
> If something is missing in KVM to allow routing of SMCs to userspace,
> I'm more than happy to entertain the change.

Okay.

> > So, having an implementation completely in VMM without any change in
> > KVM might be challenging, any potential solutions are welcome.
>=20
> I've said what I have to say already, and pointed you in a direction
> that I see as both correct and maintainable.
>=20

Yes, I get your point on placing mediator in VMM. And now that I think of it,
I believe I can make an improvement.

But yes, since too many entities are involved, the design of this solution ha=
s been
a nightmare. Good to have been pushed this way.

> Thanks,
>=20
> 	M.
>=20
> --=20
> Jazz isn't dead. It just smells funny.

Thanks,
Yuvraj Sakshith

--===============8088995966045933458==--

