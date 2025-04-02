From: Yuvraj Sakshith <yuvraj.kernel@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [RFC PATCH 0/7] KVM: optee: Introduce OP-TEE Mediator for
 exposing secure world to KVM guests
Date: Wed, 02 Apr 2025 08:28:48 +0530
Message-ID: <Z-yn6BdPcuM_aDBX@raj>
In-Reply-To: <87ldsjzr5l.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7331152361585663720=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7331152361585663720==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 01, 2025 at 07:13:26PM +0100, Marc Zyngier wrote:
> On Tue, 01 Apr 2025 18:05:20 +0100,
> Yuvraj Sakshith <yuvraj.kernel@gmail.com> wrote:
> >=20
> > A KVM guest running on an arm64 machine will not be able to interact with=
 a trusted execution environment
> > (which supports non-secure guests) like OP-TEE in the secure world. This =
is because, instructions provided
> > by the architecture (such as, SMC)  which switch control to the firmware,=
 are trapped in EL2 when the guest
> > is executes them.
> >=20
> > This series adds a feature into the kernel called the TEE mediator abstra=
ction layer, which lets
> > a guest interact with the secure world. Additionally, a OP-TEE specific m=
ediator is also implemented, which
> > hooks itself to the TEE mediator layer and intercepts guest SMCs targette=
d at OP-TEE.
> >=20
> > Overview
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > Essentially, if the kernel wants to interact with OP-TEE, it makes an "sm=
c - secure monitor call instruction",
> > after loading in arguments into CPU registers. What these arguments consi=
sts of and how both these entities=20
> > communicate can vary. If a guest wants to establish a connection with the=
 secure world, its not possible.=20
> > This is because of the fact that "smc" by the guest are trapped by the hy=
pervisor in EL2. This is done by setting
> > the HCR_EL2.TSC bit before entering the guest.
> >=20
> > Hence, this feature which I we may call TEE mediator, acts as an intermed=
iary between the guest and OP-TEE.
> > Instead of denying the guest SMC and jumping back into the guest, the med=
iator forwards the request to
> > OP-TEE.
> >=20
> > OP-TEE supports virtualization in the normal world and expects 6 things f=
rom the NS-hypervisor:
> >=20
> > 1. Notify OP-TEE when a VM is created.
> > 2. Notify OP-TEE when a VM is destroyed.
> > 3. Any SMC to OP-TEE has to contain the VMID in x7. If its the hypervisor=
 sending, then VMID is 0.
> > 4. Hypervisor has to perform IPA->PA translations of the memory addresses=
 sent by guest.
> > 5. Memory shared by the VM to OP-TEE has to remain pinned.
> > 6. The hypervisor has to follow the OP-TEE protocol, so the guest thinks =
it is directly speaking to OP-TEE.
> >=20
> > Its important to note that, if OP-TEE is built with NS-virtualization sup=
port, it can only function if there is=20
> > a hypervisor with a mediator in normal world.
> >=20
> > This implementation has been heavily inspired by Xen's OP-TEE
> > mediator.
>=20
> [...]
>=20
> And I think this inspiration is the source of most of the problems in
> this series.
>=20
> Routing Secure Calls from the guest to whatever is on the secure side
> should not be the kernel's job at all. It should be the VMM's job. All
> you need to do is to route the SMCs from the guest to userspace, and
> we already have all the required infrastructure for that.
>
Yes, this was an argument at the time of designing this solution.

> It is the VMM that should:
>=20
> - signal the TEE of VM creation/teardown
>=20
> - translate between IPAs and host VAs without involving KVM
>=20
> - let the host TEE driver translate between VAs and PAs and deal with
>   the pinning as required, just like it would do for any userspace
>   (without ever using the KVM memslot interface)
>=20
> - proxy requests from the guest to the TEE
>=20
> - in general, bear the complexity of anything related to the TEE
>

Major reason why I went with placing the implementation inside the kernel is,
	- OP-TEE userspace lib (client) does not support sending SMCs for VM events
	  and needs modification.
	- QEMU (or every other VMM)  will have to be modified.
	- OP-TEE driver is anyways in the kernel. A mediator will just be an addition
		and not a completely new entity.
	- (Potential) issues if we would want to mediate requests from VM which has
	  private mem.
	- Heavy VM exits if guest makes frequent TOS calls.

Hence, the thought of making changes to too many entities (libteec, VMM, etc.=
) was a
strong reason, although arguable.

> In short, the VMM is just another piece of userspace using the TEE to
> do whatever it wants. The TEE driver on the host must obviously know
> about VMs, but that's about it.
>=20
> Crucially, KVM should:
>=20
> - be completely TEE agnostic and never call into something that is
>   TEE-specific
>=20
> - allow a TEE implementation entirely in userspace, specially for the
>   machines that do not have EL3
>

Yes, you're right. Although I believe there still are some changes that need =
to be made
to KVM for facilitating this. For example, kvm_smccc_get_action() would deny =
TOS call.

So, having an implementation completely in VMM without any change in KVM migh=
t be challenging,
any potential solutions are welcome.
=20
> As it stands, your design looks completely upside-down. Most of this
> code should be userspace code and live in (or close to) the VMM, with
> the host kernel only providing the basic primitives, most of which
> should already be there.
>=20
> Thanks,
>=20
> 	M.
>=20
> --=20
> Jazz isn't dead. It just smells funny.

--===============7331152361585663720==--

