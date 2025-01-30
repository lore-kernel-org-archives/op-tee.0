From: Patryk <pbiel7@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: Registering dynamic shared memory
Date: Thu, 30 Jan 2025 08:33:08 +0100
Message-ID: 
 <CA+DkFDYCK_41FO-P3q=A4aU0dM-gVgdmgLU+9jUtRdee0qSi7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5625403455008609139=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5625403455008609139==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,
I have some problems configuring dynamic shared memory on my platform,
and thought that perhaps somebody could give me a hint.
My SoC (LS1028A, board: LS1028A-RDB), according to reference manual
has two DRAM regions:
- DRAM region 0 : start address: 0x80000000, size: 0x80000000
- DRAM region 2:  start address: 0x2080000000, size: 0x1F80000000

I tried two approaches:
1) In optee-os, in a part of code that handles my SoC I added a call
to register DDR only for the first region:
register_addr(0x80000000, 2G - some size for TZ DRAM) (similarly like
in case of other SoCs)

However when the system boots up, the optee driver logs the following
information:
[ 5.703831] optee: dynamic shared memory is enabled
E/TC:0 0 std_entry_with_parg:234 Bad arg address 0x208100e000
It seems that there is some problem with an address that the driver wants to =
use

2) Apart from registering first region I also added a call that
registers the second region so I ended up with two calls:
register_addr(0x80000000, 2G - some size for TZ DRAM)
register_ddr(0x2080000000, 0x1F80000000);

Now the problem is different since the platform no longer boots, due
to the panic with the following output:
D/TC:0 0 discover_nsec_memory:1117 No non-secure memory found in external DT
D/TC:0 0 carve_out_phys_mem:362 No need to carve out 0xfc000000 size 0x3e00000
D/TC:0 0 carve_out_phys_mem:362 No need to carve out 0xffe00000 size 0x200000
E/TC:0 0 Panic at
/usr/src/debug/optee-os-qoriq/4.2.0+git/core/mm/core_mmu.c:490
<core_mmu_set_discovered_nsec_ddr>

I'm wondering, what am I missing?
Do I need to register both regions? If so, why does the optee panic
when the second region gets registered?

I would be grateful for some ideas.

Best regards
Patryk

--===============5625403455008609139==--

