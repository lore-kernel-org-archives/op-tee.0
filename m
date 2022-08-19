From: Greg KH <gregkh@linuxfoundation.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v3] tee: add overflow check in register_shm_helper()
Date: Fri, 19 Aug 2022 12:36:31 +0200
Message-ID: <Yv9nr4/XQI0Tl4XO@kroah.com>
In-Reply-To: <20220819094952.2602066-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2594293756167957887=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2594293756167957887==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 19, 2022 at 11:49:52AM +0200, Jens Wiklander wrote:
> With special lengths supplied by user space, register_shm_helper() has
> an integer overflow when calculating the number of pages covered by a
> supplied user space memory region. This causes
> internal_get_user_pages_fast() a helper function of
> pin_user_pages_fast() to do a NULL pointer dereference.
>=20
> [   14.141620] Unable to handle kernel NULL pointer dereference at virtual =
address 0000000000000010
> [   14.142556] Mem abort info:
> [   14.142829]   ESR =3D 0x0000000096000044
> [   14.143237]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> [   14.143742]   SET =3D 0, FnV =3D 0
> [   14.144052]   EA =3D 0, S1PTW =3D 0
> [   14.144348]   FSC =3D 0x04: level 0 translation fault
> [   14.144767] Data abort info:
> [   14.145053]   ISV =3D 0, ISS =3D 0x00000044
> [   14.145394]   CM =3D 0, WnR =3D 1
> [   14.145766] user pgtable: 4k pages, 48-bit VAs, pgdp=3D000000004278e000
> [   14.146279] [0000000000000010] pgd=3D0000000000000000, p4d=3D00000000000=
00000
> [   14.147435] Internal error: Oops: 96000044 [#1] PREEMPT SMP
> [   14.148026] Modules linked in:
> [   14.148595] CPU: 1 PID: 173 Comm: optee_example_a Not tainted 5.19.0 #11
> [   14.149204] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2=
015
> [   14.149832] pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
> [   14.150481] pc : internal_get_user_pages_fast+0x474/0xa80
> [   14.151640] lr : internal_get_user_pages_fast+0x404/0xa80
> [   14.152408] sp : ffff80000a88bb30
> [   14.152711] x29: ffff80000a88bb30 x28: 0000fffff836d000 x27: 0000fffff83=
6e000
> [   14.153580] x26: fffffc0000000000 x25: fffffc0000f4a1c0 x24: ffff0000028=
9fb70
> [   14.154634] x23: ffff000002702e08 x22: 0000000000040001 x21: ffff8000097=
eec60
> [   14.155378] x20: 0000000000f4a1c0 x19: 00e800007d287f43 x18: 00000000000=
00000
> [   14.156215] x17: 0000000000000000 x16: 0000000000000000 x15: 0000fffff83=
6cfb0
> [   14.157068] x14: 0000000000000000 x13: 0000000000000000 x12: 00000000000=
00000
> [   14.157747] x11: 0000000000000000 x10: 0000000000000000 x9 : 00000000000=
00000
> [   14.158576] x8 : ffff00000276ec80 x7 : 0000000000000000 x6 : 00000000000=
0003f
> [   14.159243] x5 : 0000000000000000 x4 : ffff000041ec4eac x3 : ffff0000027=
74cb8
> [   14.159977] x2 : 0000000000000004 x1 : 0000000000000010 x0 : 00000000000=
00000
> [   14.160883] Call trace:
> [   14.161166]  internal_get_user_pages_fast+0x474/0xa80
> [   14.161763]  pin_user_pages_fast+0x24/0x4c
> [   14.162227]  register_shm_helper+0x194/0x330
> [   14.162734]  tee_shm_register_user_buf+0x78/0x120
> [   14.163290]  tee_ioctl+0xd0/0x11a0
> [   14.163739]  __arm64_sys_ioctl+0xa8/0xec
> [   14.164227]  invoke_syscall+0x48/0x114
> [   14.164653]  el0_svc_common.constprop.0+0x44/0xec
> [   14.165130]  do_el0_svc+0x2c/0xc0
> [   14.165498]  el0_svc+0x2c/0x84
> [   14.165847]  el0t_64_sync_handler+0x1ac/0x1b0
> [   14.166258]  el0t_64_sync+0x18c/0x190
> [   14.166878] Code: 91002318 11000401 b900f7e1 f9403be1 (f820d839)
> [   14.167666] ---[ end trace 0000000000000000 ]---
>=20
> Fix this by adding an overflow check when calculating the end of the
> memory range. Also add an explicit call to access_ok() in
> tee_shm_register_user_buf() to catch an invalid user space address
> early.
>=20
> Fixes: 033ddf12bcf5 ("tee: add register user memory")
> Cc: stable(a)vger.kernel.org
> Reported-by: Nimish Mishra <neelam.nimish@gmail.com>
> Reported-by: Anirban Chakraborty <ch.anirban00727@gmail.com>
> Reported-by: Debdeep Mukhopadhyay <debdeep.mukhopadhyay@gmail.com>
> Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>

This conflicts with 573ae4f13f63 ("tee: add overflow check in
register_shm_helper()") in Linus's tree :(


--===============2594293756167957887==--

