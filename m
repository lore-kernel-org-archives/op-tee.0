From: Jan Kiszka <jan.kiszka@siemens.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v5 3/3] efi: Add tee-based EFI variable driver
Date: Wed, 07 Jun 2023 16:04:23 +0000
Message-ID: <cc6bd203-83ea-c247-0986-7fec6f327ee8@siemens.com>
In-Reply-To: <
 <CAFA6WYPCDRjFzsUMU=SNzEt88nT7Fcm1eOFL8z4HiQO+=2JeVA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1504826581483635712=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1504826581483635712==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 07.06.23 17:18, Sumit Garg wrote:
> On Wed, 7 Jun 2023 at 18:10, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 07.06.23 10:25, Ilias Apalodimas wrote:
>>> Hi Sumit,
>>>
>>> On Wed, 7 Jun 2023 at 10:25, Sumit Garg <sumit.garg@linaro.org> wrote:
>>>>
>>>> Hi Ilias,
>>>>
>>>> On Wed, 7 Jun 2023 at 12:05, Ilias Apalodimas
>>>> <ilias.apalodimas@linaro.org> wrote:
>>>>>
>>>>> Hi Jan,
>>>>>
>>>>> [...]
>>>>>
>>>>>>>>>>
>>>>>>> ...
>>>>>>>>>
>>>>>>>>> I think we have a probe ordering issue with this driver:
>>>>>>>>> efivarfs_fill_super() may be called before the TEE bus was probed, =
thus
>>>>>>>>> with the default efivar ops still registered. And that means
>>>>>>>>> efivar_supports_writes() will return false, and the fs declares its=
elf
>>>>>>>>> as readonly. I've seen systemd mounting it r/o initialling, and you=
 need
>>>>>>>>> to remount the fs to enable writability.
>>>>>>>>>
>>>>>>>>> Is there anything that could be done to re-order things reliably, p=
robe
>>>>>>>>> the tee bus earlier etc.?
>>>>>>>>
>>>>>>>> This driver has a dependency on user-space daemon: tee-supplicant to
>>>>>>>> be running for RPMB access. So once you start that daemon the
>>>>>>>> corresponding device will be enumerated on the TEE bus and this driv=
er
>>>>>>>> probe will be invoked. So I would suggest you to load this daemon ve=
ry
>>>>>>>> early in the boot process or better to make it a part of initramfs.
>>>>>>>>
>>>>>>>
>>>>>>> That is not the point, really.
>>>>>>>
>>>>>>> If this dependency exists, the code should be aware of that, and made
>>>>>>> to work correctly in spite of it. Requiring a module to be part of
>>>>>>> initramfs is not a reasonable fix.
>>>>>>
>>>>>> In fact, I've tested a non-modularized build as well, just to exclude
>>>>>> that issue. The daemon dependency is more likely the problem here.
>>>>>>
>>>>>>>
>>>>>>> IIUC, this also means that the efivar ops are updated while there is
>>>>>>> already a client. This seems less than ideal as well
>>>>>
>>>>> As Sumit pointed out, the 'device' won't be available from OP-TEE
>>>>> until the supplicant is up and running and as a result, the module
>>>>> _probe() function won't run.  Unfortunately, this isn't something we
>>>>> can avoid since the supplicant is responsible for the RPMB writes.
>>>>> The only thing I can think of is moving parts of the supplicant to the
>>>>> kernel and wiring up the RPC calls for reading/writing data to the
>>>>> eMMC subsystem.  There was another discussion here [0] requesting the
>>>>> same thing for different reasons. But unless I am missing something
>>>>> this won't solve the problem completely either.  You still have a
>>>>> timing dependency of "when did the RT callbacks change" -- "when was
>>>>> my efivarfs mounted".
>>>>
>>>> With the RPMB writes wired through the kernel [1], the only dependency
>>>> left is when do you load the tee-stmm-efi driver to have real EFI
>>>> runtime variables support. IMO, tee-stmm-efi driver should be built-in
>>>> to support systems without initramfs. The distro installers may choose
>>>> to bundle it in initramfs. Do you still see a timing dependency with
>>>> this approach?
>>>
>>> No I don't, this will work reliably without the need to remount the efiva=
rfs.
>>> As you point out you will still have this dependency if you end up
>>> building them as modules and you manage to mount the efivarfs before
>>> those get inserted.  Does anyone see a reasonable workaround?
>>> Deceiving the kernel and making the bootloader set the RT property bit
>>> to force the filesystem being mounted as rw is a nasty hack that we
>>> should avoid.  Maybe adding a kernel command line parameter that says
>>> "Ignore the RTPROP I know what I am doing"?  I don't particularly love
>>> this either, but it's not unreasonable.
>>
>> In the context of https://github.com/OP-TEE/optee_os/issues/6094,
>> basically this issue mapped on reboot/shutdown, I would really love to
>> see the unhandy tee-supplicant daemon to be overcome.
>=20
> I have seen this error before and it has been on my todo list. So I
> have tried to fix it here [1]. Feel free to test it and let me know if
> you see any further issues.
>=20
> [1] https://lkml.org/lkml/2023/6/7/927
>=20

Ah, nice, will test ASAP!

Meanwhile more food: I managed to build a firmware that was missing=20
STMM. But the driver loaded, and I got this:

root(a)iot2050-debian:~# efi-updatevar -f PK.auth PK
[  243.407097] Unable to handle kernel NULL pointer dereference at virtual ad=
dress 0000000000000000
[  243.415959] Mem abort info:
[  243.418801]   ESR =3D 0x86000004
[  243.422099]   EC =3D 0x21: IABT (current EL), IL =3D 32 bits
[  243.427529]   SET =3D 0, FnV =3D 0
[  243.430755]   EA =3D 0, S1PTW =3D 0
[  243.433931] user pgtable: 4k pages, 48-bit VAs, pgdp=3D000000008b74e000
[  243.440438] [0000000000000000] pgd=3D0000000000000000, p4d=3D0000000000000=
000
[  243.447274] Internal error: Oops: 86000004 [#1] PREEMPT SMP
[  243.452835] Modules linked in: ctr ccm mt7601u mac80211 cfg80211 rfkill li=
barc4 cp210x usbserial pci_endpoint_test ti_k3_r5_remoteproc optee_rng rng_co=
re ti_cal ti_am335x_adc videobuf2_dma_contig kfifo_buf v4l2_fwnode videobuf2_=
memops videobuf2_v4l2 videobuf2_common irq_pruss_intc at24 fuse ip_tables x_t=
ables ipv6 tpm_ftpm_tee icssg_prueth pru_rproc icss_iep ptp pps_core ti_am335=
x_tscadc pruss
[  243.487733] CPU: 0 PID: 875 Comm: efi-updatevar Not tainted 5.10.162-cip24=
 #1
[  243.494851] Hardware name: Unknown Unknown Product/Unknown Product, BIOS 2=
023.07-rc3-00018-g0afdaac6505 07/01/2023
[  243.505180] pstate: 00000005 (nzcv daif -PAN -UAO -TCO BTYPE=3D--)
[  243.511179] pc : 0x0
[  243.513366] lr : efivar_entry_set_get_size+0xd4/0x1e0
[  243.518404] sp : ffff8000127a3d00
[  243.521708] x29: ffff8000127a3d00 x28: 0000000000000f87=20
[  243.527012] x27: ffff000005bae400 x26: ffff800011254000=20
[  243.532315] x25: ffff000005baf000 x24: ffff800011254aa0=20
[  243.537618] x23: ffff8000127a3dab x22: ffff8000111d0268=20
[  243.542921] x21: ffff8000127a3db0 x20: 0000000000000000=20
[  243.548224] x19: ffff000005bae000 x18: 0000000000000000=20
[  243.553527] x17: 0000000000000000 x16: 0000000000000000=20
[  243.558829] x15: 0000aaab0876f264 x14: 35cd6a1025d11a20=20
[  243.564132] x13: ac6f8dda3945638d x12: fb482642e3487f2d=20
[  243.569435] x11: 0000000000000003 x10: ffff00000b792a80=20
[  243.574738] x9 : a098e2bf989ff097 x8 : 0000000000000010=20
[  243.580041] x7 : ffff800010e35c00 x6 : 4ddcbe2ecfc8fc79=20
[  243.585345] x5 : 0000000000000000 x4 : ffff000005baf000=20
[  243.590647] x3 : 0000000000000f87 x2 : 0000000000000027=20
[  243.595950] x1 : ffff000005bae400 x0 : ffff000005bae000=20
[  243.601254] Call trace:
[  243.603695]  0x0
[  243.605531]  efivarfs_file_write+0xa4/0x170
[  243.609709]  vfs_write+0xf0/0x2a4
[  243.613016]  ksys_write+0x68/0xf4
[  243.616323]  __arm64_sys_write+0x1c/0x2c
[  243.620241]  el0_svc_common.constprop.0+0x78/0x1c4
[  243.625022]  do_el0_svc+0x24/0x8c
[  243.628331]  el0_svc+0x14/0x20
[  243.631378]  el0_sync_handler+0xb0/0xb4
[  243.635206]  el0_sync+0x180/0x1c0
[  243.638523] Code: bad PC value
[  243.641573] ---[ end trace 369e4632cb003adc ]---

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


--===============1504826581483635712==--

