From: Marc Zyngier <maz@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [RFC PATCH 0/7] KVM: optee: Introduce OP-TEE Mediator for
 exposing secure world to KVM guests
Date: Tue, 01 Apr 2025 19:13:26 +0100
Message-ID: <87ldsjzr5l.wl-maz@kernel.org>
In-Reply-To: <20250401170527.344092-1-yuvraj.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4969290002053694082=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4969290002053694082==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 01 Apr 2025 18:05:20 +0100,
Yuvraj Sakshith <yuvraj.kernel@gmail.com> wrote:
>=20
> A KVM guest running on an arm64 machine will not be able to interact with a=
 trusted execution environment
> (which supports non-secure guests) like OP-TEE in the secure world. This is=
 because, instructions provided
> by the architecture (such as, SMC)  which switch control to the firmware, a=
re trapped in EL2 when the guest
> is executes them.
>=20
> This series adds a feature into the kernel called the TEE mediator abstract=
ion layer, which lets
> a guest interact with the secure world. Additionally, a OP-TEE specific med=
iator is also implemented, which
> hooks itself to the TEE mediator layer and intercepts guest SMCs targetted =
at OP-TEE.
>=20
> Overview
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Essentially, if the kernel wants to interact with OP-TEE, it makes an "smc =
- secure monitor call instruction",
> after loading in arguments into CPU registers. What these arguments consist=
s of and how both these entities=20
> communicate can vary. If a guest wants to establish a connection with the s=
ecure world, its not possible.=20
> This is because of the fact that "smc" by the guest are trapped by the hype=
rvisor in EL2. This is done by setting
> the HCR_EL2.TSC bit before entering the guest.
>=20
> Hence, this feature which I we may call TEE mediator, acts as an intermedia=
ry between the guest and OP-TEE.
> Instead of denying the guest SMC and jumping back into the guest, the media=
tor forwards the request to
> OP-TEE.
>=20
> OP-TEE supports virtualization in the normal world and expects 6 things fro=
m the NS-hypervisor:
>=20
> 1. Notify OP-TEE when a VM is created.
> 2. Notify OP-TEE when a VM is destroyed.
> 3. Any SMC to OP-TEE has to contain the VMID in x7. If its the hypervisor s=
ending, then VMID is 0.
> 4. Hypervisor has to perform IPA->PA translations of the memory addresses s=
ent by guest.
> 5. Memory shared by the VM to OP-TEE has to remain pinned.
> 6. The hypervisor has to follow the OP-TEE protocol, so the guest thinks it=
 is directly speaking to OP-TEE.
>=20
> Its important to note that, if OP-TEE is built with NS-virtualization suppo=
rt, it can only function if there is=20
> a hypervisor with a mediator in normal world.
>=20
> This implementation has been heavily inspired by Xen's OP-TEE
> mediator.

[...]

And I think this inspiration is the source of most of the problems in
this series.

Routing Secure Calls from the guest to whatever is on the secure side
should not be the kernel's job at all. It should be the VMM's job. All
you need to do is to route the SMCs from the guest to userspace, and
we already have all the required infrastructure for that.

It is the VMM that should:

- signal the TEE of VM creation/teardown

- translate between IPAs and host VAs without involving KVM

- let the host TEE driver translate between VAs and PAs and deal with
  the pinning as required, just like it would do for any userspace
  (without ever using the KVM memslot interface)

- proxy requests from the guest to the TEE

- in general, bear the complexity of anything related to the TEE

In short, the VMM is just another piece of userspace using the TEE to
do whatever it wants. The TEE driver on the host must obviously know
about VMs, but that's about it.

Crucially, KVM should:

- be completely TEE agnostic and never call into something that is
  TEE-specific

- allow a TEE implementation entirely in userspace, specially for the
  machines that do not have EL3

As it stands, your design looks completely upside-down. Most of this
code should be userspace code and live in (or close to) the VMM, with
the host kernel only providing the basic primitives, most of which
should already be there.

Thanks,

	M.

--=20
Jazz isn't dead. It just smells funny.

--===============4969290002053694082==--

