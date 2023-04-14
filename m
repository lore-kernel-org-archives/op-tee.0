From: 梅建强(禹夜) <meijianqiang.mjq@alibaba-inc.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: fragment transmission while retrieving memory
Date: Fri, 14 Apr 2023 10:29:28 +0800
Message-ID: 
 <17bfccdb-1368-4ec1-9e6e-f9343ee6fff2.meijianqiang.mjq@alibaba-inc.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4691898834156448516=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4691898834156448516==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jens, Olivier,
If I understand properly, for this specific issue both optee and hafnium need=
 to do further fix.
The following discussion and questions are based on figure 18.4 in the FFA sp=
ec.
As I saw in the optee code, the retrieve mechanism would start with this code=
:=20
 retrieve_desc =3D spmc_retrieve_req(cookie);
And in the function spmc_retrieve_req,
optee sets the total length to the same size as fragment0 length before sendi=
ng FFA_MEM_FRAG_REQ to hafnium,
which means hafnium will only retrieve the fragment0 memory region.
In the example process,=20
optee will determines the number of TX sized fragments of descriptor before s=
ending FFA_MEM_FRAG_REQ to hafnium.
I have a question here.=20
How should optee calculate this quantity?
Hafnium then receives the FFA_MEM_FRAG_REQ.
As I saw in the hafnium code, hafnium blocks the case that total length>fragm=
ent length.
 if (fragment_length !=3D length) {
 dlog_verbose("Fragmentation not yet supported.\n");
 return ffa_error(FFA_INVALID_PARAMETERS);
 }
Obviously it is not what we expected.
Then following the example process, hafnium should allocate handle and use it=
 to associate fragments.=20
I didn't find the corresponding implementation in hafnium code for this step.=
=20
And I want to know how to implement the associate action here.
After that, optee lacks the implementation of FFA_MEM_FRAG_RX and FFA_MEM_FRA=
G_TX ABI in CFG_CORE_SEL2_SPMC enable case.
Is there any support plan for the implementation of fragmented memory retriev=
e in the optee community?
Does the hafnium community have a plan to implement it cooperatively?
Thanks a lot for your support.
Regards,
Yuye.
------------------------------------------------------------------
=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AOlivier Deprez <Olivier.Deprez@arm.com>
=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2023=E5=B9=B44=E6=9C=8813=E6=97=
=A5(=E6=98=9F=E6=9C=9F=E5=9B=9B) 15:52
=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A=E6=A2=85=E5=BB=BA=E5=BC=BA(=E7=A6=B9=E5=
=A4=9C) <meijianqiang.mjq@alibaba-inc.com>
=E6=8A=84=E3=80=80=E9=80=81=EF=BC=9Ahafnium <hafnium@lists.trustedfirmware.=
org>; Jens Wiklander <jens.wiklander@linaro.org>
=E4=B8=BB=E3=80=80=E9=A2=98=EF=BC=9ARe: fragment transmission while retrievin=
g memory
 Hi Yuye, Jens,
 For the record, and If I understand properly the last comment in the github =
issue:
 OP-TEE is missing the implementation for receipt of a fragmented retrieve re=
sponse
 There is no further fix to be done in Hafnium for this specific issue at thi=
s moment, please let me know otherwise.
 Thanks, Olivier.
From: =E6=A2=85=E5=BB=BA=E5=BC=BA(=E7=A6=B9=E5=A4=9C) <meijianqiang.mjq@ali=
baba-inc.com>
Sent: 12 April 2023 09:27
To: Olivier Deprez <Olivier.Deprez@arm.com>
Cc: hafnium <hafnium@lists.trustedfirmware.org>; Jens Wiklander <jens.wikla=
nder@linaro.org>
Subject: Re: fragment transmission while retrieving memory
Hi, Olivier,
In our setup,
Hafnium commit: 997476a74571aec4f1a23590d45edf516f3934f4
optee version: 3.20.0
Thanks.
Regards,
Yuye.
------------------------------------------------------------------
=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AOlivier Deprez <Olivier.Deprez@arm.com>
=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2023=E5=B9=B44=E6=9C=8812=E6=97=
=A5(=E6=98=9F=E6=9C=9F=E4=B8=89) 15:22
=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A=E6=A2=85=E5=BB=BA=E5=BC=BA(=E7=A6=B9=E5=
=A4=9C) <meijianqiang.mjq@alibaba-inc.com>
=E6=8A=84=E3=80=80=E9=80=81=EF=BC=9Ahafnium <hafnium@lists.trustedfirmware.=
org>; Jens Wiklander <jens.wiklander@linaro.org>
=E4=B8=BB=E3=80=80=E9=A2=98=EF=BC=9ARe: fragment transmission while retrievin=
g memory
 Hi Yuye,
 AFAIK concerning Hafnium, fragmented mem sharing is supported for FFA_MEM_SH=
ARE/LEND/DONATE and FFA_MEM_RETRIEVE_RESP.
 (For the sake of clarity, this isn't supported for FFA_MEM_RETRIEVE_REQ but =
this shouldn't be a concern as this limitation only exists in the case of mem=
 sharing to multiple borrowers. In your case of a single borrower the mem ret=
rieve req. shouldn't have to be fragmented).
 Can you tell which hafnium commit hash is used in your setup?
 At the moment, I cannot tell if the issue described concern a miss in Hafniu=
m or OP-TEE.
 I need to dig a bit further into both implementations and I'll let you know.
 Regards,
 Olivier.
From: =E6=A2=85=E5=BB=BA=E5=BC=BA(=E7=A6=B9=E5=A4=9C) <meijianqiang.mjq@ali=
baba-inc.com>
Sent: 12 April 2023 08:21
To: Olivier Deprez <Olivier.Deprez@arm.com>
Cc: hafnium <hafnium@lists.trustedfirmware.org>; Jens Wiklander <jens.wikla=
nder@linaro.org>
Subject: fragment transmission while retrieving memory
Hi, Olivier,
Recently, I've been working on this issue.
https://github.com/OP-TEE/optee_os/issues/5943 <https://github.com/OP-TEE/opt=
ee_os/issues/5943 >
Do you know any differences between hafnium's current implementation of fragm=
ent transmission while retrieving memory and the example process described in=
 FF-A 1.1 Figure 18.4?
Regards,
Yuye.

--===============4691898834156448516==--

