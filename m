From: Yuvraj Sakshith <yuvraj.kernel@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: [RFC PATCH 0/7] KVM: optee: Introduce OP-TEE Mediator for exposing
 secure world to KVM guests
Date: Tue, 01 Apr 2025 22:35:20 +0530
Message-ID: <20250401170527.344092-1-yuvraj.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7338967310430275494=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7338967310430275494==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

A KVM guest running on an arm64 machine will not be able to interact with a t=
rusted execution environment
(which supports non-secure guests) like OP-TEE in the secure world. This is b=
ecause, instructions provided
by the architecture (such as, SMC)  which switch control to the firmware, are=
 trapped in EL2 when the guest
is executes them.

This series adds a feature into the kernel called the TEE mediator abstractio=
n layer, which lets
a guest interact with the secure world. Additionally, a OP-TEE specific media=
tor is also implemented, which
hooks itself to the TEE mediator layer and intercepts guest SMCs targetted at=
 OP-TEE.

Overview
=3D=3D=3D=3D=3D=3D=3D=3D=3D

Essentially, if the kernel wants to interact with OP-TEE, it makes an "smc - =
secure monitor call instruction",
after loading in arguments into CPU registers. What these arguments consists =
of and how both these entities=20
communicate can vary. If a guest wants to establish a connection with the sec=
ure world, its not possible.=20
This is because of the fact that "smc" by the guest are trapped by the hyperv=
isor in EL2. This is done by setting
the HCR_EL2.TSC bit before entering the guest.

Hence, this feature which I we may call TEE mediator, acts as an intermediary=
 between the guest and OP-TEE.
Instead of denying the guest SMC and jumping back into the guest, the mediato=
r forwards the request to
OP-TEE.

OP-TEE supports virtualization in the normal world and expects 6 things from =
the NS-hypervisor:

1. Notify OP-TEE when a VM is created.
2. Notify OP-TEE when a VM is destroyed.
3. Any SMC to OP-TEE has to contain the VMID in x7. If its the hypervisor sen=
ding, then VMID is 0.
4. Hypervisor has to perform IPA->PA translations of the memory addresses sen=
t by guest.
5. Memory shared by the VM to OP-TEE has to remain pinned.
6. The hypervisor has to follow the OP-TEE protocol, so the guest thinks it i=
s directly speaking to OP-TEE.

Its important to note that, if OP-TEE is built with NS-virtualization support=
, it can only function if there is=20
a hypervisor with a mediator in normal world.

This implementation has been heavily inspired by Xen's OP-TEE mediator.

Design
=3D=3D=3D=3D=3D=3D

The unique design of KVM makes it quite challenging to implement such a media=
tor. OP-TEE is not aware of the host-guest
paradigm. Hence, the mediator treats the host as a VM with VMID 1. The guests=
 are assigned VMIDs starting from 2 (note,
these are not the VMIDs tagged in TLB, rather we implement our own simple ind=
exing mechanism).

When the host's OP-TEE driver is initialised or released, OP-TEE is notified =
about VM 1 being created/destroyed.

When a VMM (such as, QEMU) created a guest through KVM ioctls, a call to the =
TEE mediator layer is made, which in-turn
calls OP-TEE mediator which eventually assigns a VM context, VMID, etc. and n=
otifies OP-TEE about guest creation. The
opposite happens on guest destruction.

When the guest makes an SMC targetting OP-TEE, it is trapped by the hyperviso=
r and the register state (kvm_vcpu) is sent to
the OP-TEE mediator through the TEE layer. Here there are two possibilities.

The guest may make an SMC with arguments which are simple numeric values, exc=
hanging UUID, version information, etc.
In this case, the mediator has much less work. It has to attach VMID into X7 =
and pass the register state to OP-TEE.

But, when guest passes memory addresses as arguments, the mediator has to tra=
nslate these into physical addresses from
intermediate physical addresses (IPA). According to the OP-TEE protocol (as d=
ocumented in optee_smc.h and optee_msg.h),
the guest OP-TEE driver would share a buffer filled with pointers, which the =
mediator translates.

The OP-TEE mediator also keeps track of active calls between each guest and O=
P-TEE, and pins pages which are already shared.
This is to avoid swapping of shared pages by the host under memory pressure. =
These pages are unpinned as soon as guest's
transaction completes with OP-TEE.

Testing
=3D=3D=3D=3D=3D=3D=3D

The feature has been tested on QEMU virt platform using "xtest" as the test s=
uite. As of now, all of 35000+ tests pass.
The mediator has also been stressed under memory pressure and all tests pass =
too. Any suggestions on further testing the
feature are welcome.

Call for review
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Any insights/suggestions regarding the implementation are appreciated.

Yuvraj Sakshith (7):
  firmware: smccc: Add macros for Trusted OS/App owner check on SMC
    value
  tee: Add TEE Mediator module which aims to expose TEE to a KVM guest.
  KVM: Notify TEE Mediator when KVM creates and destroys guests
  KVM: arm64: Forward guest CPU state to TEE mediator on SMC trap
  tee: optee: Add OPTEE_SMC_VM_CREATED and OPTEE_SMC_VM_DESTROYED
  tee: optee: Add OP-TEE Mediator
  tee: optee: Notify TEE Mediator on OP-TEE driver initialization and
    release

 arch/arm64/kvm/hypercalls.c        |   15 +-
 drivers/tee/Kconfig                |    5 +
 drivers/tee/Makefile               |    1 +
 drivers/tee/optee/Kconfig          |    7 +
 drivers/tee/optee/Makefile         |    1 +
 drivers/tee/optee/core.c           |   13 +-
 drivers/tee/optee/optee_mediator.c | 1319 ++++++++++++++++++++++++++++
 drivers/tee/optee/optee_mediator.h |  103 +++
 drivers/tee/optee/optee_smc.h      |   53 ++
 drivers/tee/optee/smc_abi.c        |    6 +
 drivers/tee/tee_mediator.c         |  145 +++
 include/linux/arm-smccc.h          |    8 +
 include/linux/tee_mediator.h       |   39 +
 virt/kvm/kvm_main.c                |   11 +-
 14 files changed, 1721 insertions(+), 5 deletions(-)
 create mode 100644 drivers/tee/optee/optee_mediator.c
 create mode 100644 drivers/tee/optee/optee_mediator.h
 create mode 100644 drivers/tee/tee_mediator.c
 create mode 100644 include/linux/tee_mediator.h

--=20
2.43.0


--===============7338967310430275494==--

