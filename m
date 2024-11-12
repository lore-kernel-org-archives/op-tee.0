From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: optee-based efi runtime variable service on TI j784s4 platforms
Date: Tue, 12 Nov 2024 21:21:06 +0200
Message-ID: 
 <CAC_iWj+4G3LG0XpsygS+MYJU9+oPhftOnPAfkOnEgn+GgTp2OA@mail.gmail.com>
In-Reply-To: <
 <CALE0LRsA==Art8xqRQfPQq0HP6ebtYTuQ677t-BV7fDZB3grWg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8516327368055440863=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8516327368055440863==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Enric

[...]

> > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > ... stuck here ... traces indicates never outs from the efi_setup, so
> > > > looks like hungs
> > > >
> > > > Let me try with BeaglePlay and read a bit more, as I feel I'm a bit
> > > > lost right now.
> > >
> > > Sure, let me know if you need anything else.
> > >
> >
> > Same behaviour on BeaglePlay, so either it's currently broken or I'm
> > making the same mistake in my process on both boards.
> >
> > Ilias, by chance, do you have in which versions did you test?
> >
>
> So it looks like it is a problem with edk2 and/or edk2-platform, since
> reverting those repositories back to September, things started to look
> a lot better and I'm able to see en UEFI variables programmed.
>
> FWIW I just found this project [1] from you, thank you for it. Turns
> out that it is easy to reproduce the issue I'm facing even with qemu.
> I'll try to bisect what's the problem and report properly.

There were recently some patches in EDK2 changing some aspects and you
also have to update edk2-platforms & OP-TEE [0] to test this, but this
is not merged yet.  I did try those changes and they worked fine. When
you bisect why EDK2 is broken please let me know otherwise I'll have a
look.

>
> Thank you very much for your guidance and support.

You're welcome.
Keep in mind that [1] is _very_ hacky and it's just testing variable
accesses in the firmware since U-Boot emulates the RPMB, not QEMU. IOW
it's fine to use it and test U-Boot but the changes won't survive
ExitBootServris and won't work in Linux.

>
> Cheers,
>   Enric
>
> [1] https://git.linaro.org/people/ilias.apalodimas/efi_optee_variables.git/

[0] https://github.com/tianocore/edk2/pull/6116
[1] https://git.linaro.org/people/ilias.apalodimas/efi_optee_variables.git/

Cheers
/Ilias
>
>
> > Thanks,
> >   Enric
> > > /Ilias
> > > >
> > > > > >
> > > > > > =3D> optee_rpmb read test 4
> > > > > > D/TC:? 0 tee_ta_init_pseudo_ta_session:303 Lookup pseudo TA
> > > > > > 023f8f1a-292a-432b-8fc4-de8471358067
> > > > > > D/TC:? 0 ldelf_load_ldelf:110 ldelf load address 0x40007000
> > > > > > D/LD:  ldelf:142 Loading TS 023f8f1a-292a-432b-8fc4-de8471358067
> > > > > > F/TC:? 0 trace_syscall:147 syscall #3 (syscall_get_property)
> > > > > > F/TC:? 0 trace_syscall:147 syscall #5 (syscall_open_ta_session)
> > > > > > D/TC:? 0 ldelf_syscall_open_bin:135 > ldelf_syscall_open_bin
> > > > > > D/TC:? 0 ldelf_syscall_open_bin:164 Lookup user TA ELF
> > > > > > 023f8f1a-292a-432b-8fc4-de8471358067 (early TA)
> > > > > > D/TC:? 0 ldelf_syscall_open_bin:168 res=3D0
> > > > > > F/TC:? 0 trace_syscall:147 syscall #7 (syscall_invoke_ta_command)
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 trace_syscall:147 syscall #11 (syscall_mask_cancellation)
> > > > > > F/TC:? 0 trace_syscall:147 syscall #7 (syscall_invoke_ta_command)
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 492 bytes
> > > > > > F/TC:? 0 trace_syscall:147 syscall #3 (syscall_get_property)
> > > > > > F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_right=
s)
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 532 bytes
> > > > > > F/TC:? 0 read_compressed:178 924 bytes
> > > > > > F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_right=
s)
> > > > > > F/TC:? 0 read_compressed:178 248 bytes
> > > > > > F/TC:? 0 read_compressed:178 760 bytes
> > > > > > F/TC:? 0 trace_syscall:147 syscall #6 (syscall_close_ta_session)
> > > > > > F/TC:? 0 trace_syscall:147 syscall #3 (syscall_get_property)
> > > > > > D/LD:  ldelf:176 ELF (023f8f1a-292a-432b-8fc4-de8471358067) at 0x=
40048000
> > > > > > F/TC:? 0 trace_syscall:147 syscall #33 (syscall_cryp_random_numbe=
r_generate)
> > > > > > F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_right=
s)
> > > > > > F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_right=
s)
> > > > > > F/TC:? 0 trace_syscall:147 syscall #4 (syscall_get_property_name_=
to_index)
> > > > > > F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_right=
s)
> > > > > > F/TC:? 0 trace_syscall:147 syscall #41 (syscall_storage_obj_open)
> > > > > > D/TC:? 0 rpmb_fs_open_internal:2356 >>> rpmb_fs_open_internal
> > > > > > D/TC:? 0 tee_rpmb_init:1205 >>> core/tee/tee_rpmb_fs.c:1205
> > > > > > D/TC:? 0 tee_rpmb_init:1214 >>> core/tee/tee_rpmb_fs.c:1214
> > > > > > D/TC:? 0 tee_rpmb_init:1253 >>> core/tee/tee_rpmb_fs.c:1253
> > > > > > D/TC:? 0 legacy_rpmb_init:1142 Trying legacy RPMB init
> > > > > > D/TC:? 0 rpmb_set_dev_info:1111 RPMB: Syncing device information
> > > > > > D/TC:? 0 rpmb_set_dev_info:1113 RPMB: RPMB size is 32*128 KB
> > > > > > D/TC:? 0 rpmb_set_dev_info:1114 RPMB: Reliable Write Sector Count=
 is 1
> > > > > > D/TC:? 0 rpmb_set_dev_info:1116 RPMB: CID
> > > > > > D/TC:? 0 rpmb_set_dev_info:1117 000000009e93ab30  13 01 4e 47 31 =
4d 31
> > > > > > 35  4c 10 27 91 28 07 a9 00
> > > > > > D/TC:? 0 legacy_rpmb_init:1162 RPMB INIT: Deriving key
> > > > > > D/TC:? 0 tee_rpmb_key_gen:308 RPMB: Using test key
> > > > > > D/TC:? 0 legacy_rpmb_init:1176 RPMB INIT: Verifying Key
> > > > > > F/TC:? 0 plat_prng_add_jitter_entropy:68 0x61
> > > > > > D/TC:? 0 legacy_rpmb_init:1180 Found working RPMB device
> > > > > > D/TC:? 0 tee_rpmb_init:1205 >>> core/tee/tee_rpmb_fs.c:1205
> > > > > > D/TC:? 0 tee_rpmb_init:1214 >>> core/tee/tee_rpmb_fs.c:1214
> > > > > > D/TC:? 0 tee_rpmb_read:1362 Read 1 block at index 0
> > > > > > D/TC:? 0 tee_rpmb_write_blk:1494 Write 1 block at index 0
> > > > > > D/TC:? 0 tee_rpmb_init:1205 >>> core/tee/tee_rpmb_fs.c:1205
> > > > > > D/TC:? 0 tee_rpmb_init:1214 >>> core/tee/tee_rpmb_fs.c:1214
> > > > > > D/TC:? 0 tee_rpmb_init:1205 >>> core/tee/tee_rpmb_fs.c:1205
> > > > > > D/TC:? 0 tee_rpmb_init:1214 >>> core/tee/tee_rpmb_fs.c:1214
> > > > > > D/TC:? 0 tee_rpmb_read:1362 Read 1 block at index 0
> > > > > > E/TC:? 0 rpmb_fs_setup:2143 **** Clearing Storage ****
> > > > > > D/TC:? 0 tee_rpmb_write_blk:1494 Write 1 block at index 2
> > > > > > F/TC:? 0 plat_prng_add_jitter_entropy:68 0xD3
> > > > > > D/TC:? 0 tee_rpmb_read:1362 Read 1 block at index 0
> > > > > > D/TC:? 0 tee_rpmb_write_blk:1494 Write 1 block at index 0
> > > > > > D/TC:? 0 tee_rpmb_read:1362 Read 8 blocks at index 2
> > > > > > F/TC:? 0 dump_fat:1951 flags 0x2, size 0, address 0, filename ''
> > > > > > D/TC:? 0 read_fat:2221 fat_address 0
> > > > > > D/TC:? 0 tee_rpmb_read:1362 Read 8 blocks at index 2
> > > > > > F/TC:? 0 plat_prng_add_jitter_entropy:68 0x18
> > > > > > E/TA:  read_persist_value:338 Can't open named object value, res =
=3D 0xffff0008
> > > > > > D/TC:? 0 tee_ta_invoke_command:798 Error: ffff0008 of 4
> > > > > > D/TC:? 0 tee_ta_close_session:460 csess 0x9e925a50 id 1
> > > > > > D/TC:? 0 tee_ta_close_session:479 Destroy session
> > > > > > D/TC:? 0 destroy_context:318 Destroy TA ctx (0x9e9259f0)
> > > > > > Failed to read persistent value
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > > Cheers
> > > > > > > /Ilias
> > > > > > >
> > > > > > > > =3D> optee_rpmb read test 4
> > > > > > > > D/TC:? 0 tee_ta_init_pseudo_ta_session:303 Lookup pseudo TA
> > > > > > > > 023f8f1a-292a-432b-8fc4-de8471358067
> > > > > > > > D/TC:? 0 ldelf_load_ldelf:110 ldelf load address 0x40007000
> > > > > > > > D/LD:  ldelf:142 Loading TS 023f8f1a-292a-432b-8fc4-de8471358=
067
> > > > > > > > F/TC:? 0 trace_syscall:147 syscall #3 (syscall_get_property)
> > > > > > > > F/TC:? 0 trace_syscall:147 syscall #5 (syscall_open_ta_sessio=
n)
> > > > > > > > D/TC:? 0 ldelf_syscall_open_bin:163 Lookup user TA ELF
> > > > > > > > 023f8f1a-292a-432b-8fc4-de8471358067 (early TA)
> > > > > > > > D/TC:? 0 ldelf_syscall_open_bin:167 res=3D0
> > > > > > > > F/TC:? 0 trace_syscall:147 syscall #7 (syscall_invoke_ta_comm=
and)
> > > > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > > > F/TC:? 0 trace_syscall:147 syscall #11 (syscall_mask_cancella=
tion)
> > > > > > > > F/TC:? 0 trace_syscall:147 syscall #7 (syscall_invoke_ta_comm=
and)
> > > > > > > >
> > > > > > > > =3D> efidebug query -bs -rt -nv
> > > > > > > > MMC: no card present
> > > > > > > > mmc_init: -123, time 2002
> > > > > > > > D/TC:? 0 load_stmm:297 stmm load address 0x40004000
> > > > > > > > D/TC:? 0 spm_handle_scall:859 Received FFA version
> > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > Thanks
> > > > > > > > > > /Ilias
> > > > > > > > > > >
> > > > > > > > > > > =3D> efidebug query -bs -rt -nv
> > > > > > > > > > > D/TC:? 0 load_stmm:297 stmm load address 0x40004000
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:859 Received FFA version
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct reque=
st
> > > > > > > > > > > ... stuck here ... I need to reset the board
> > > > > > > > > > >
> > > > > > > > > > > Will continue to see if I can get more useful messages
> > > > > > > > > > >
> > > > > > > > > > > Thanks,
> > > > > > > > > > >   Enric
> > > > > > > > > > >
> > > > > > > > > > > > Thanks
> > > > > > > > > > > > /Ilias
> > > > > > > > > > > > >
> > > > > > > > > > > > > I'll try to add some more prints to verify if REE i=
s used as a store
> > > > > > > > > > > > > system, I assume this should say something about RP=
MB. Am I right with
> > > > > > > > > > > > > this?
> > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > And tracing the function calls gives me tha=
t:
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > >       tee_stmm_efi_probe() {
> > > > > > > > > > > > > > > > >              tee_client_open_context() {
> > > > > > > > > > > > > > > > >                optee_get_version() {
> > > > > > > > > > > > > > > > >                  tee_get_drvdata(); (ret=3D=
0xffff000002e55800)
> > > > > > > > > > > > > > > > >                } (ret=3D0xd)
> > > > > > > > > > > > > > > > >                tee_ctx_match(); (ret=3D0x1)
> > > > > > > > > > > > > > > > >                optee_smc_open() {
> > > > > > > > > > > > > > > > >                  tee_get_drvdata(); (ret=3D=
0xffff000002e55800)
> > > > > > > > > > > > > > > > >                  optee_open() {
> > > > > > > > > > > > > > > > >                    tee_get_drvdata(); (ret=
=3D0xffff000002e55800)
> > > > > > > > > > > > > > > > >                  } (ret=3D0x0)
> > > > > > > > > > > > > > > > >                } (ret=3D0x0)
> > > > > > > > > > > > > > > > >              } (ret=3D0xffff000004e71c80)
> > > > > > > > > > > > > > > > >              tee_client_open_session() {
> > > > > > > > > > > > > > > > >                optee_open_session() {
> > > > > > > > > > > > > > > > >                  tee_get_drvdata(); (ret=3D=
0xffff000002e55800)
> > > > > > > > > > > > > > > > >                  optee_get_msg_arg() {
> > > > > > > > > > > > > > > > >                    tee_get_drvdata(); (ret=
=3D0xffff000002e55800)
> > > > > > > > > > > > > > > > >                    tee_shm_get_va(); (ret=
=3D0xffff000002909000)
> > > > > > > > > > > > > > > > >                  } (ret=3D0xffff00000290900=
0)
> > > > > > > > > > > > > > > > >                  tee_session_calc_client_uu=
id(); (ret=3D0x0)
> > > > > > > > > > > > > > > > >                  optee_to_msg_param(); (ret=
=3D0x0)
> > > > > > > > > > > > > > > > >                  optee_smc_do_call_with_arg=
() {
> > > > > > > > > > > > > > > > >                    tee_get_drvdata(); (ret=
=3D0xffff000002e55800)
> > > > > > > > > > > > > > > > >                    tee_shm_get_va(); (ret=
=3D0xffff000002909000)
> > > > > > > > > > > > > > > > >                    tee_shm_get_va(); (ret=
=3D0xffff000002909060)
> > > > > > > > > > > > > > > > >                    optee_cq_wait_init(); (r=
et=3D0xffff000002e55910)
> > > > > > > > > > > > > > > > >                    optee_smccc_smc(); (ret=
=3D0xffff0004)
> > > > > > > > > > > > > > > > >                    tee_get_drvdata(); (ret=
=3D0xffff000002e55800)
> > > > > > > > > > > > > > > > >                    optee_smccc_smc(); (ret=
=3D0xffff0004)
> > > > > > > > > > > > > > > > >                    tee_get_drvdata(); (ret=
=3D0xffff000002e55800)
> > > > > > > > > > > > > > > > >                    optee_smccc_smc(); (ret=
=3D0xffff0004)
> > > > > > > > > > > > > > > > >                    tee_get_drvdata(); (ret=
=3D0xffff000002e55800)
> > > > > > > > > > > > > > > > >                    optee_smccc_smc(); (ret=
=3D0xffff0004)
> > > > > > > > > > > > > > > > >                    tee_get_drvdata(); (ret=
=3D0xffff000002e55800)
> > > > > > > > > > > > > > > > >                    optee_smccc_smc(); (ret=
=3D0xffff0004)
> > > > > > > > > > > > > > > > >      ... continues sending this forever ...
> > > > > > > > > > > > > > > > >      ... Hit ^C to stop recording ...
> > > > > > > > > > > > > > > > >                    tee_get_drvdata(); (ret=
=3D0xffff000002e55800)
> > > > > > > > > > > > > > > > >                    optee_smccc_smc() {
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > [1] https://docs.u-boot.org/en/latest/devel=
op/uefi/uefi.html#using-op-tee-for-efi-variables
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > Thanks in advance,
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > The most common problem with this is miscompi=
ling the tee_supplicant
> > > > > > > > > > > > > > > > application.
> > > > > > > > > > > > > > > > Since we don't know if the system has an RPMB=
, we emulate it in the
> > > > > > > > > > > > > > > > tee_supplicant. How did you get the supplican=
t and can you check if it
> > > > > > > > > > > > > > > > was compiled with RPMB_EMU=3D0 or 1?
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > I'm using the tee-supplicant provided by the fe=
dora package which is
> > > > > > > > > > > > > > > built with ` -DRPMB_EMU=3D0`, I think that's co=
rrect, right?
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Yes, this is correct. We fixed the Fedora package=
 to compile the
> > > > > > > > > > > > > > supplicant correctly a while back.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > [0] https://www.linaro.org/blog/uefi-secureboot-i=
n-u-boot/
> > > > > > > > > > > > > > [1] https://apalos.github.io/Protected%20UEFI%20v=
ariables%20with%20U-Boot.html#Protected%20UEFI%20variables%20with%20U-Boot
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Regards
> > > > > > > > > > > > > > /Ilias
> > > > > > > > > > > > > > > Thanks,
> > > > > > > > > > > > > > >    Enric
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Thanks
> > > > > > > > > > > > > > > > /Ilias
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > >    Enric
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > >
> > > > > > >
> > > > > >
> > > > >
> > > >
> > >
>

--===============8516327368055440863==--

