From: 梅建强(禹夜) <meijianqiang.mjq@alibaba-inc.com>
To: op-tee@lists.trustedfirmware.org
Subject: fragment transmission while retrieving memory
Date: Mon, 17 Apr 2023 15:29:28 +0800
Message-ID: 
 <8c75e58a-7013-42cb-bb61-93a87d07130f.meijianqiang.mjq@alibaba-inc.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6585481735882229190=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6585481735882229190==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jens, Olivier,
update for optee:
https://github.com/OP-TEE/optee_os/pull/5966 <https://github.com/OP-TEE/optee=
_os/pull/5966 >
update for hafnium:
diff --git a/src/api.c b/src/api.c
index 5f699478..7e43e305 100644
--- a/src/api.c
+++ b/src/api.c
@@ -3191,7 +3191,8 @@ struct ffa_value api_ffa_mem_frag_rx(ffa_memory_handle_=
t handle,
 return ffa_error(FFA_INVALID_PARAMETERS);
 }
 }
-
+ if (to->id=3D=3D0x8001 && to->mailbox.state !=3D MAILBOX_STATE_EMPTY)
+ to->mailbox.state =3D MAILBOX_STATE_EMPTY;
 to_locked =3D vm_lock(to);
 if (vm_is_mailbox_busy(to_locked)) {
diff --git a/src/ffa_memory.c b/src/ffa_memory.c
index 3e978d23..59e71ff3 100644
--- a/src/ffa_memory.c
+++ b/src/ffa_memory.c
@@ -2385,7 +2385,7 @@ struct ffa_value ffa_memory_retrieve_continue(struct vm=
_locked to_locked,
 &fragment_length);
 CHECK(remaining_constituent_count =3D=3D 0);
 to_locked.vm->mailbox.recv_size =3D fragment_length;
- to_locked.vm->mailbox.recv_sender =3D HF_HYPERVISOR_VM_ID;
+ to_locked.vm->mailbox.recv_sender =3D to_locked.vm->id;
 to_locked.vm->mailbox.recv_func =3D FFA_MEM_FRAG_TX_32;
 to_locked.vm->mailbox.state =3D MAILBOX_STATE_FULL;
It seems that to->mailbox.state needs to be set to MAILBOX_STATE_EMPTY firstl=
y.=20
I have not figured out why, but large TA could be loaded successfully with ab=
ove fix now.
Regards,
Yuye.
------------------------------------------------------------------
=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A=E6=A2=85=E5=BB=BA=E5=BC=BA(=E7=A6=B9=E5=
=A4=9C) <meijianqiang.mjq@alibaba-inc.com>
=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2023=E5=B9=B44=E6=9C=8817=E6=97=
=A5(=E6=98=9F=E6=9C=9F=E4=B8=80) 02:16
=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9AJens Wiklander <jens.wiklander@linaro.o=
rg>
=E6=8A=84=E3=80=80=E9=80=81=EF=BC=9AOlivier Deprez <Olivier.Deprez@arm.com>=
; hafnium <hafnium@lists.trustedfirmware.org>; op-tee <op-tee@lists.trust=
edfirmware.org>
=E4=B8=BB=E3=80=80=E9=A2=98=EF=BC=9Afragment transmission while retrieving me=
mory
Hi, Jens,
I have implement the missing support for fragmented mem retrieve response as =
you suggested.
I will push fix into the community code soon and please help review it later.
Thanks.
Regards,
Yuye.
------------------------------------------------------------------
=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AJens Wiklander <jens.wiklander@linaro.o=
rg>
=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2023=E5=B9=B44=E6=9C=8814=E6=97=
=A5(=E6=98=9F=E6=9C=9F=E4=BA=94) 14:23
=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A=E6=A2=85=E5=BB=BA=E5=BC=BA(=E7=A6=B9=E5=
=A4=9C) <meijianqiang.mjq@alibaba-inc.com>
=E6=8A=84=E3=80=80=E9=80=81=EF=BC=9AOlivier Deprez <Olivier.Deprez@arm.com>=
; hafnium <hafnium@lists.trustedfirmware.org>; op-tee <op-tee@lists.trust=
edfirmware.org>
=E4=B8=BB=E3=80=80=E9=A2=98=EF=BC=9ARe: fragment transmission while retrievin=
g memory
Hi Yuye,
On Fri, Apr 14, 2023 at 4:29 AM =E6=A2=85=E5=BB=BA=E5=BC=BA(=E7=A6=B9=E5=A4=
=9C)
<meijianqiang.mjq@alibaba-inc.com> wrote:
>
>
> Hi, Jens, Olivier,
>
> If I understand properly, for this specific issue both optee and hafnium ne=
ed to do further fix.
> The following discussion and questions are based on figure 18.4 in the FFA =
spec.
>
> As I saw in the optee code, the retrieve mechanism would start with this co=
de:
> retrieve_desc =3D spmc_retrieve_req(cookie);
> And in the function spmc_retrieve_req,
> optee sets the total length to the same size as fragment0 length before sen=
ding FFA_MEM_FRAG_REQ to hafnium,
> which means hafnium will only retrieve the fragment0 memory region.
>
> In the example process,
> optee will determines the number of TX sized fragments of descriptor before=
 sending FFA_MEM_FRAG_REQ to hafnium.
> I have a question here.
> How should optee calculate this quantity?
>
> Hafnium then receives the FFA_MEM_FRAG_REQ.
> As I saw in the hafnium code, hafnium blocks the case that total length>fra=
gment length.
> if (fragment_length !=3D length) {
> dlog_verbose("Fragmentation not yet supported.\n");
> return ffa_error(FFA_INVALID_PARAMETERS);
> }
> Obviously it is not what we expected.
> Then following the example process, hafnium should allocate handle and use =
it to associate fragments.
> I didn't find the corresponding implementation in hafnium code for this ste=
p.
> And I want to know how to implement the associate action here.
>
> After that, optee lacks the implementation of FFA_MEM_FRAG_RX and FFA_MEM_F=
RAG_TX ABI in CFG_CORE_SEL2_SPMC enable case.
> Is there any support plan for the implementation of fragmented memory retri=
eve in the optee community?
> Does the hafnium community have a plan to implement it cooperatively?
If I've understood this correctly we have two different cases of
eventual fragmentation of descriptors. The first is the descriptor
passed with FFA_MEM_RETRIEVE_REQ_32, this one is not likely to need
fragmentation support soon. The other is the descriptor received with
FFA_MEM_RETRIEVE_RESP, I believe this is where you've run into
trouble.
From OP-TEE point of view, it would make sense if you took lead on
implementing this. I can help with review etc.
Thanks,
Jens
>
> Thanks a lot for your support.
>
> Regards,
> Yuye.
>
>
>
>
>
> ------------------------------------------------------------------
> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AOlivier Deprez <Olivier.Deprez@arm.co=
m>
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2023=E5=B9=B44=E6=9C=8813=E6=
=97=A5(=E6=98=9F=E6=9C=9F=E5=9B=9B) 15:52
> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A=E6=A2=85=E5=BB=BA=E5=BC=BA(=E7=A6=B9=
=E5=A4=9C) <meijianqiang.mjq@alibaba-inc.com>
> =E6=8A=84 =E9=80=81=EF=BC=9Ahafnium <hafnium@lists.trustedfirmware.org>; =
Jens Wiklander <jens.wiklander@linaro.org>
> =E4=B8=BB =E9=A2=98=EF=BC=9ARe: fragment transmission while retrieving memo=
ry
>
> Hi Yuye, Jens,
>
> For the record, and If I understand properly the last comment in the github=
 issue:
> OP-TEE is missing the implementation for receipt of a fragmented retrieve r=
esponse
> There is no further fix to be done in Hafnium for this specific issue at th=
is moment, please let me know otherwise.
>
> Thanks, Olivier.
>
>
> ________________________________
> From: =E6=A2=85=E5=BB=BA=E5=BC=BA(=E7=A6=B9=E5=A4=9C) <meijianqiang.mjq@a=
libaba-inc.com>
> Sent: 12 April 2023 09:27
> To: Olivier Deprez <Olivier.Deprez@arm.com>
> Cc: hafnium <hafnium@lists.trustedfirmware.org>; Jens Wiklander <jens.wik=
lander@linaro.org>
> Subject: Re: fragment transmission while retrieving memory
>
>
>
>
> Hi, Olivier,
>
> In our setup,
> Hafnium commit: 997476a74571aec4f1a23590d45edf516f3934f4
> optee version: 3.20.0
> Thanks.
>
> Regards,
> Yuye.
>
> ------------------------------------------------------------------
> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AOlivier Deprez <Olivier.Deprez@arm.co=
m>
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2023=E5=B9=B44=E6=9C=8812=E6=
=97=A5(=E6=98=9F=E6=9C=9F=E4=B8=89) 15:22
> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A=E6=A2=85=E5=BB=BA=E5=BC=BA(=E7=A6=B9=
=E5=A4=9C) <meijianqiang.mjq@alibaba-inc.com>
> =E6=8A=84 =E9=80=81=EF=BC=9Ahafnium <hafnium@lists.trustedfirmware.org>; =
Jens Wiklander <jens.wiklander@linaro.org>
> =E4=B8=BB =E9=A2=98=EF=BC=9ARe: fragment transmission while retrieving memo=
ry
>
> Hi Yuye,
>
> AFAIK concerning Hafnium, fragmented mem sharing is supported for FFA_MEM_S=
HARE/LEND/DONATE and FFA_MEM_RETRIEVE_RESP.
> (For the sake of clarity, this isn't supported for FFA_MEM_RETRIEVE_REQ but=
 this shouldn't be a concern as this limitation only exists in the case of me=
m sharing to multiple borrowers. In your case of a single borrower the mem re=
trieve req. shouldn't have to be fragmented).
>
> Can you tell which hafnium commit hash is used in your setup?
>
> At the moment, I cannot tell if the issue described concern a miss in Hafni=
um or OP-TEE.
> I need to dig a bit further into both implementations and I'll let you know.
>
> Regards,
> Olivier.
>
>
> ________________________________
> From: =E6=A2=85=E5=BB=BA=E5=BC=BA(=E7=A6=B9=E5=A4=9C) <meijianqiang.mjq@a=
libaba-inc.com>
> Sent: 12 April 2023 08:21
> To: Olivier Deprez <Olivier.Deprez@arm.com>
> Cc: hafnium <hafnium@lists.trustedfirmware.org>; Jens Wiklander <jens.wik=
lander@linaro.org>
> Subject: fragment transmission while retrieving memory
>
>
>
>
> Hi, Olivier,
>
> Recently, I've been working on this issue.
> https://github.com/OP-TEE/optee_os/issues/5943 <https://github.com/OP-TEE/o=
ptee_os/issues/5943 >
> Do you know any differences between hafnium's current implementation of fra=
gment transmission while retrieving memory and the example process described =
in FF-A 1.1 Figure 18.4?
>
> Regards,
> Yuye.
>
>

--===============6585481735882229190==--

