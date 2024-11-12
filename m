From: Enric Balletbo i Serra <eballetb@redhat.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: optee-based efi runtime variable service on TI j784s4 platforms
Date: Tue, 12 Nov 2024 17:03:01 +0100
Message-ID: 
 <CALE0LRt2ct8onNyPvTNzy3Ps1kqduqx-OMmnQse-SXsk5M451Q@mail.gmail.com>
In-Reply-To: <
 <CAC_iWjKkdS71Fh3LZ0CJR-vnC+PwGKGndxjU3WjjUPnZ84DYWg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6165994881109226455=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6165994881109226455==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 4:07=E2=80=AFPM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Tue, 12 Nov 2024 at 16:39, Enric Balletbo i Serra
> <eballetb@redhat.com> wrote:
> >
> > On Tue, Nov 12, 2024 at 2:23=E2=80=AFPM Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > [...]
> > >
> > > > > > > >
> > > > > > >
> > > > > > > Unfortunately that didn't help, but I don't see this code being=
 run.
> > > > >
> > > > > That's weird, look below.
> > > > >
> > > > > > > Who sets for the first place the uefi variables, is this u-boot
> > > > > > > writing them to the rpmb? or is optee itself?
> > > > >
> > > > > U-Boot sets the variables, but it does so via StandAloneMM.
> > > > >
> > > > > > >
> > > > > >
> > > > > > I tried to compare the behaviour between optee_rpmb (works) and
> > > > > > efidebug (doesn't worrk). I see that the first thing optee_rpmb
> > > > > > command does is open a session against the TA application, someth=
ing
> > > > > > that efidebug doesn't do, shouldn't efidebug do the same to acces=
s to
> > > > > > the rpmb device and read or write the efi variables?
> > > > > >
> > > > >
> > > > > That's a bit more complicated and explained to one of the blog post=
s I
> > > > > pasted above.
> > > > > We do open an OP-TEE session, but not for talking to a TA. We send =
the
> > > > > messages to StandAloneMM, which then usese OPTEE RPMB APIs to write
> > > > > the flash.
> > > > >
> > > > > The weird thing is why OP-TEE does not format your RPMB when compil=
ing
> > > > > with that flag.
> > > > > If done correctly, OP-TEE will wipe the RPMB contents the first time
> > > > > it tries to access it.
> > > > >
> > > >
> > > > It does if I call optee_rpmb command
> > > >
> > > > E/TC:? 0 rpmb_fs_setup:2143 **** Clearing Storage ****
> > > >
> > > > But I don't see any attempt to write efi variables to the rpmb
> > > > partition if I use the normal boot workflow or calling any efi command
> > > > from the prompt.
> > > >
> > > > I think I need to read a bit more about all the pieces because I might
> > > > miss something.
> > >
> > > You don't need the command above to store variables. You need this in
> > > case you need to use the RPMB from the command line.
> > > Do a 'printenv -e && setenv -e -bs -rt -nv test test1 && printenv -e'.
> > > Does that work ?
> > >
> >
> > No, `printenv -e` gets stuck. This is the log with some debug messages I =
added.
> >
> > =3D> printenv -e
> > > lib/efi_loader/efi_setup.c:227 Initialize once only
> >   > lib/efi_loader/efi_setup.c:234 Set up console modes
> >   > lib/efi_loader/efi_setup.c:242 Proble block devices to find the ESP
> > MMC: no card present
> > mmc_init: -123, time 2002
> >   > lib/efi_loader/efi_setup.c:249 Initialize variable services
> >      > lib/efi_loader/efi_var_mem.c:223 efi_allocate_pages
> >      > lib/efi_loader/efi_var_mem.c:236 efi_create_event
> >   < lib/efi_loader/efi_var_mem.c:244 - ret=3D0
> > D/TC:? 0 load_stmm:297 stmm load address 0x40004000
>
> Please try again with the FAT reset config flag in OP-TEE and without
> doing any reads and writes from the U-Boot console
>
> > D/TC:? 0 spm_handle_scall:859 Received FFA version
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > ... stuck here ... traces indicates never outs from the efi_setup, so
> > looks like hungs
> >
> > Let me try with BeaglePlay and read a bit more, as I feel I'm a bit
> > lost right now.
>
> Sure, let me know if you need anything else.
>

Same behaviour on BeaglePlay, so either it's currently broken or I'm
making the same mistake in my process on both boards.

Ilias, by chance, do you have in which versions did you test?

Thanks,
  Enric
> /Ilias
> >
> > > >
> > > > =3D> optee_rpmb read test 4
> > > > D/TC:? 0 tee_ta_init_pseudo_ta_session:303 Lookup pseudo TA
> > > > 023f8f1a-292a-432b-8fc4-de8471358067
> > > > D/TC:? 0 ldelf_load_ldelf:110 ldelf load address 0x40007000
> > > > D/LD:  ldelf:142 Loading TS 023f8f1a-292a-432b-8fc4-de8471358067
> > > > F/TC:? 0 trace_syscall:147 syscall #3 (syscall_get_property)
> > > > F/TC:? 0 trace_syscall:147 syscall #5 (syscall_open_ta_session)
> > > > D/TC:? 0 ldelf_syscall_open_bin:135 > ldelf_syscall_open_bin
> > > > D/TC:? 0 ldelf_syscall_open_bin:164 Lookup user TA ELF
> > > > 023f8f1a-292a-432b-8fc4-de8471358067 (early TA)
> > > > D/TC:? 0 ldelf_syscall_open_bin:168 res=3D0
> > > > F/TC:? 0 trace_syscall:147 syscall #7 (syscall_invoke_ta_command)
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 trace_syscall:147 syscall #11 (syscall_mask_cancellation)
> > > > F/TC:? 0 trace_syscall:147 syscall #7 (syscall_invoke_ta_command)
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 492 bytes
> > > > F/TC:? 0 trace_syscall:147 syscall #3 (syscall_get_property)
> > > > F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_rights)
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > F/TC:? 0 read_compressed:178 532 bytes
> > > > F/TC:? 0 read_compressed:178 924 bytes
> > > > F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_rights)
> > > > F/TC:? 0 read_compressed:178 248 bytes
> > > > F/TC:? 0 read_compressed:178 760 bytes
> > > > F/TC:? 0 trace_syscall:147 syscall #6 (syscall_close_ta_session)
> > > > F/TC:? 0 trace_syscall:147 syscall #3 (syscall_get_property)
> > > > D/LD:  ldelf:176 ELF (023f8f1a-292a-432b-8fc4-de8471358067) at 0x4004=
8000
> > > > F/TC:? 0 trace_syscall:147 syscall #33 (syscall_cryp_random_number_ge=
nerate)
> > > > F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_rights)
> > > > F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_rights)
> > > > F/TC:? 0 trace_syscall:147 syscall #4 (syscall_get_property_name_to_i=
ndex)
> > > > F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_rights)
> > > > F/TC:? 0 trace_syscall:147 syscall #41 (syscall_storage_obj_open)
> > > > D/TC:? 0 rpmb_fs_open_internal:2356 >>> rpmb_fs_open_internal
> > > > D/TC:? 0 tee_rpmb_init:1205 >>> core/tee/tee_rpmb_fs.c:1205
> > > > D/TC:? 0 tee_rpmb_init:1214 >>> core/tee/tee_rpmb_fs.c:1214
> > > > D/TC:? 0 tee_rpmb_init:1253 >>> core/tee/tee_rpmb_fs.c:1253
> > > > D/TC:? 0 legacy_rpmb_init:1142 Trying legacy RPMB init
> > > > D/TC:? 0 rpmb_set_dev_info:1111 RPMB: Syncing device information
> > > > D/TC:? 0 rpmb_set_dev_info:1113 RPMB: RPMB size is 32*128 KB
> > > > D/TC:? 0 rpmb_set_dev_info:1114 RPMB: Reliable Write Sector Count is 1
> > > > D/TC:? 0 rpmb_set_dev_info:1116 RPMB: CID
> > > > D/TC:? 0 rpmb_set_dev_info:1117 000000009e93ab30  13 01 4e 47 31 4d 31
> > > > 35  4c 10 27 91 28 07 a9 00
> > > > D/TC:? 0 legacy_rpmb_init:1162 RPMB INIT: Deriving key
> > > > D/TC:? 0 tee_rpmb_key_gen:308 RPMB: Using test key
> > > > D/TC:? 0 legacy_rpmb_init:1176 RPMB INIT: Verifying Key
> > > > F/TC:? 0 plat_prng_add_jitter_entropy:68 0x61
> > > > D/TC:? 0 legacy_rpmb_init:1180 Found working RPMB device
> > > > D/TC:? 0 tee_rpmb_init:1205 >>> core/tee/tee_rpmb_fs.c:1205
> > > > D/TC:? 0 tee_rpmb_init:1214 >>> core/tee/tee_rpmb_fs.c:1214
> > > > D/TC:? 0 tee_rpmb_read:1362 Read 1 block at index 0
> > > > D/TC:? 0 tee_rpmb_write_blk:1494 Write 1 block at index 0
> > > > D/TC:? 0 tee_rpmb_init:1205 >>> core/tee/tee_rpmb_fs.c:1205
> > > > D/TC:? 0 tee_rpmb_init:1214 >>> core/tee/tee_rpmb_fs.c:1214
> > > > D/TC:? 0 tee_rpmb_init:1205 >>> core/tee/tee_rpmb_fs.c:1205
> > > > D/TC:? 0 tee_rpmb_init:1214 >>> core/tee/tee_rpmb_fs.c:1214
> > > > D/TC:? 0 tee_rpmb_read:1362 Read 1 block at index 0
> > > > E/TC:? 0 rpmb_fs_setup:2143 **** Clearing Storage ****
> > > > D/TC:? 0 tee_rpmb_write_blk:1494 Write 1 block at index 2
> > > > F/TC:? 0 plat_prng_add_jitter_entropy:68 0xD3
> > > > D/TC:? 0 tee_rpmb_read:1362 Read 1 block at index 0
> > > > D/TC:? 0 tee_rpmb_write_blk:1494 Write 1 block at index 0
> > > > D/TC:? 0 tee_rpmb_read:1362 Read 8 blocks at index 2
> > > > F/TC:? 0 dump_fat:1951 flags 0x2, size 0, address 0, filename ''
> > > > D/TC:? 0 read_fat:2221 fat_address 0
> > > > D/TC:? 0 tee_rpmb_read:1362 Read 8 blocks at index 2
> > > > F/TC:? 0 plat_prng_add_jitter_entropy:68 0x18
> > > > E/TA:  read_persist_value:338 Can't open named object value, res =3D =
0xffff0008
> > > > D/TC:? 0 tee_ta_invoke_command:798 Error: ffff0008 of 4
> > > > D/TC:? 0 tee_ta_close_session:460 csess 0x9e925a50 id 1
> > > > D/TC:? 0 tee_ta_close_session:479 Destroy session
> > > > D/TC:? 0 destroy_context:318 Destroy TA ctx (0x9e9259f0)
> > > > Failed to read persistent value
> > > >
> > > >
> > > >
> > > >
> > > >
> > > >
> > > >
> > > > > Cheers
> > > > > /Ilias
> > > > >
> > > > > > =3D> optee_rpmb read test 4
> > > > > > D/TC:? 0 tee_ta_init_pseudo_ta_session:303 Lookup pseudo TA
> > > > > > 023f8f1a-292a-432b-8fc4-de8471358067
> > > > > > D/TC:? 0 ldelf_load_ldelf:110 ldelf load address 0x40007000
> > > > > > D/LD:  ldelf:142 Loading TS 023f8f1a-292a-432b-8fc4-de8471358067
> > > > > > F/TC:? 0 trace_syscall:147 syscall #3 (syscall_get_property)
> > > > > > F/TC:? 0 trace_syscall:147 syscall #5 (syscall_open_ta_session)
> > > > > > D/TC:? 0 ldelf_syscall_open_bin:163 Lookup user TA ELF
> > > > > > 023f8f1a-292a-432b-8fc4-de8471358067 (early TA)
> > > > > > D/TC:? 0 ldelf_syscall_open_bin:167 res=3D0
> > > > > > F/TC:? 0 trace_syscall:147 syscall #7 (syscall_invoke_ta_command)
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 read_compressed:178 1024 bytes
> > > > > > F/TC:? 0 trace_syscall:147 syscall #11 (syscall_mask_cancellation)
> > > > > > F/TC:? 0 trace_syscall:147 syscall #7 (syscall_invoke_ta_command)
> > > > > >
> > > > > > =3D> efidebug query -bs -rt -nv
> > > > > > MMC: no card present
> > > > > > mmc_init: -123, time 2002
> > > > > > D/TC:? 0 load_stmm:297 stmm load address 0x40004000
> > > > > > D/TC:? 0 spm_handle_scall:859 Received FFA version
> > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > >
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > > Thanks
> > > > > > > > /Ilias
> > > > > > > > >
> > > > > > > > > =3D> efidebug query -bs -rt -nv
> > > > > > > > > D/TC:? 0 load_stmm:297 stmm load address 0x40004000
> > > > > > > > > D/TC:? 0 spm_handle_scall:859 Received FFA version
> > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > > D/TC:? 0 spm_handle_scall:867 Received FFA direct request
> > > > > > > > > ... stuck here ... I need to reset the board
> > > > > > > > >
> > > > > > > > > Will continue to see if I can get more useful messages
> > > > > > > > >
> > > > > > > > > Thanks,
> > > > > > > > >   Enric
> > > > > > > > >
> > > > > > > > > > Thanks
> > > > > > > > > > /Ilias
> > > > > > > > > > >
> > > > > > > > > > > I'll try to add some more prints to verify if REE is us=
ed as a store
> > > > > > > > > > > system, I assume this should say something about RPMB. =
Am I right with
> > > > > > > > > > > this?
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > And tracing the function calls gives me that:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >       tee_stmm_efi_probe() {
> > > > > > > > > > > > > > >              tee_client_open_context() {
> > > > > > > > > > > > > > >                optee_get_version() {
> > > > > > > > > > > > > > >                  tee_get_drvdata(); (ret=3D0xff=
ff000002e55800)
> > > > > > > > > > > > > > >                } (ret=3D0xd)
> > > > > > > > > > > > > > >                tee_ctx_match(); (ret=3D0x1)
> > > > > > > > > > > > > > >                optee_smc_open() {
> > > > > > > > > > > > > > >                  tee_get_drvdata(); (ret=3D0xff=
ff000002e55800)
> > > > > > > > > > > > > > >                  optee_open() {
> > > > > > > > > > > > > > >                    tee_get_drvdata(); (ret=3D0x=
ffff000002e55800)
> > > > > > > > > > > > > > >                  } (ret=3D0x0)
> > > > > > > > > > > > > > >                } (ret=3D0x0)
> > > > > > > > > > > > > > >              } (ret=3D0xffff000004e71c80)
> > > > > > > > > > > > > > >              tee_client_open_session() {
> > > > > > > > > > > > > > >                optee_open_session() {
> > > > > > > > > > > > > > >                  tee_get_drvdata(); (ret=3D0xff=
ff000002e55800)
> > > > > > > > > > > > > > >                  optee_get_msg_arg() {
> > > > > > > > > > > > > > >                    tee_get_drvdata(); (ret=3D0x=
ffff000002e55800)
> > > > > > > > > > > > > > >                    tee_shm_get_va(); (ret=3D0xf=
fff000002909000)
> > > > > > > > > > > > > > >                  } (ret=3D0xffff000002909000)
> > > > > > > > > > > > > > >                  tee_session_calc_client_uuid()=
; (ret=3D0x0)
> > > > > > > > > > > > > > >                  optee_to_msg_param(); (ret=3D0=
x0)
> > > > > > > > > > > > > > >                  optee_smc_do_call_with_arg() {
> > > > > > > > > > > > > > >                    tee_get_drvdata(); (ret=3D0x=
ffff000002e55800)
> > > > > > > > > > > > > > >                    tee_shm_get_va(); (ret=3D0xf=
fff000002909000)
> > > > > > > > > > > > > > >                    tee_shm_get_va(); (ret=3D0xf=
fff000002909060)
> > > > > > > > > > > > > > >                    optee_cq_wait_init(); (ret=
=3D0xffff000002e55910)
> > > > > > > > > > > > > > >                    optee_smccc_smc(); (ret=3D0x=
ffff0004)
> > > > > > > > > > > > > > >                    tee_get_drvdata(); (ret=3D0x=
ffff000002e55800)
> > > > > > > > > > > > > > >                    optee_smccc_smc(); (ret=3D0x=
ffff0004)
> > > > > > > > > > > > > > >                    tee_get_drvdata(); (ret=3D0x=
ffff000002e55800)
> > > > > > > > > > > > > > >                    optee_smccc_smc(); (ret=3D0x=
ffff0004)
> > > > > > > > > > > > > > >                    tee_get_drvdata(); (ret=3D0x=
ffff000002e55800)
> > > > > > > > > > > > > > >                    optee_smccc_smc(); (ret=3D0x=
ffff0004)
> > > > > > > > > > > > > > >                    tee_get_drvdata(); (ret=3D0x=
ffff000002e55800)
> > > > > > > > > > > > > > >                    optee_smccc_smc(); (ret=3D0x=
ffff0004)
> > > > > > > > > > > > > > >      ... continues sending this forever ...
> > > > > > > > > > > > > > >      ... Hit ^C to stop recording ...
> > > > > > > > > > > > > > >                    tee_get_drvdata(); (ret=3D0x=
ffff000002e55800)
> > > > > > > > > > > > > > >                    optee_smccc_smc() {
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > [1] https://docs.u-boot.org/en/latest/develop/u=
efi/uefi.html#using-op-tee-for-efi-variables
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Thanks in advance,
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > The most common problem with this is miscompiling=
 the tee_supplicant
> > > > > > > > > > > > > > application.
> > > > > > > > > > > > > > Since we don't know if the system has an RPMB, we=
 emulate it in the
> > > > > > > > > > > > > > tee_supplicant. How did you get the supplicant an=
d can you check if it
> > > > > > > > > > > > > > was compiled with RPMB_EMU=3D0 or 1?
> > > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > I'm using the tee-supplicant provided by the fedora=
 package which is
> > > > > > > > > > > > > built with ` -DRPMB_EMU=3D0`, I think that's correc=
t, right?
> > > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > Yes, this is correct. We fixed the Fedora package to =
compile the
> > > > > > > > > > > > supplicant correctly a while back.
> > > > > > > > > > > >
> > > > > > > > > > > > [0] https://www.linaro.org/blog/uefi-secureboot-in-u-=
boot/
> > > > > > > > > > > > [1] https://apalos.github.io/Protected%20UEFI%20varia=
bles%20with%20U-Boot.html#Protected%20UEFI%20variables%20with%20U-Boot
> > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > Regards
> > > > > > > > > > > > /Ilias
> > > > > > > > > > > > > Thanks,
> > > > > > > > > > > > >    Enric
> > > > > > > > > > > > >
> > > > > > > > > > > > > > Thanks
> > > > > > > > > > > > > > /Ilias
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > >    Enric
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > >
> > > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> >
>


--===============6165994881109226455==--

