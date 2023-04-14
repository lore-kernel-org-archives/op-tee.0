From: Olivier Deprez <Olivier.Deprez@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: fragment transmission while retrieving memory
Date: Fri, 14 Apr 2023 09:13:59 +0000
Message-ID: <DB9PR08MB6796B45D70A66B8826A58D429B999@DB9PR08MB6796.eurprd08.prod.outlook.com>
In-Reply-To: <
 <5e1aba9b-a9d2-48c3-b0c9-ada69f6c34d7.meijianqiang.mjq@alibaba-inc.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4034112235640009990=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4034112235640009990==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Yuye,

At first sight, I wouldn't recommend this path of increasing RX/TX buffer siz=
es (even though the spec permits it), as there are a lot of assumptions in ma=
ny places for such buffers to be a 4K+4K pair. The would require adapting man=
y components (kernel driver, hafnium, OP-TEE etc.)

The fastest and more reasonable path affecting only OP-TEE to my understandin=
g, would be with implementing the missing support for fragmented mem retrieve=
 response as Jens suggested.

Regards,
Olivier.

________________________________
From: =E6=A2=85=E5=BB=BA=E5=BC=BA(=E7=A6=B9=E5=A4=9C) <meijianqiang.mjq@ali=
baba-inc.com>
Sent: 14 April 2023 11:06
To: Jens Wiklander <jens.wiklander@linaro.org>; Olivier Deprez <Olivier.Dep=
rez@arm.com>
Cc: op-tee <op-tee@lists.trustedfirmware.org>; hafnium <hafnium@lists.tru=
stedfirmware.org>
Subject: fragment transmission while retrieving memory




Hi, Jens, Olivier,

Is it possible to solve this problem by increasing the buffer size such as 64=
k?
We plan to adopt this temporary scheme first and then implement the standard =
retrieve process later.
If this scheme is feasible, I have a few questions.
1. Should the RXTX buffer between tee driver and hafnium the same as the one =
between hafnium and optee?
2. Which FFA instance is currently allocating these buffers?
3. For Hafnium, I want to increase the HF_MAILBOX_SIZE in Hafnium, but there =
seem to be two restrictions:
static_assert(HF_MAILBOX_SIZE =3D=3D PAGE_SIZE,
          "Currently, a page is mapped for the send and receive buffers so "
          "the maximum request is the size of a page.");
static_assert(MM_PPOOL_ENTRY_SIZE >=3D HF_MAILBOX_SIZE,
          "The page pool entry size must be at least as big as the mailbox "
          "size, so that memory region descriptors can be copied from the "
          "mailbox for memory sharing.");
I tried to increase the MM_PPOOL_ENTRY_SIZE,
but optee doesn't seem to be booted properly.
Do you know how to avoid the impact of these restrictions?

Regards,
Yuye.





------------------------------------------------------------------
=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AJens Wiklander via Hafnium <hafnium@lis=
ts.trustedfirmware.org>
=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2023=E5=B9=B44=E6=9C=8814=E6=97=
=A5(=E6=98=9F=E6=9C=9F=E4=BA=94) 14:23
=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A=E6=A2=85=E5=BB=BA=E5=BC=BA(=E7=A6=B9=E5=
=A4=9C) <meijianqiang.mjq@alibaba-inc.com>
=E6=8A=84=E3=80=80=E9=80=81=EF=BC=9AOlivier Deprez <Olivier.Deprez@arm.com>=
; hafnium <hafnium@lists.trustedfirmware.org>; op-tee <op-tee@lists.trust=
edfirmware.org>
=E4=B8=BB=E3=80=80=E9=A2=98=EF=BC=9A[Hafnium] Re: fragment transmission while=
 retrieving memory

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
>     retrieve_desc =3D spmc_retrieve_req(cookie);
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
> As I saw in the hafnium code,  hafnium blocks the case that total length>fr=
agment length.
>     if (fragment_length !=3D length) {
>         dlog_verbose("Fragmentation not yet supported.\n");
>         return ffa_error(FFA_INVALID_PARAMETERS);
>     }
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
> https://github.com/OP-TEE/optee_os/issues/5943
> Do you know any differences between hafnium's current implementation of fra=
gment transmission while retrieving memory and the example process described =
in FF-A 1.1 Figure 18.4?
>
> Regards,
> Yuye.
>
>
--
Hafnium mailing list -- hafnium(a)lists.trustedfirmware.org
To unsubscribe send an email to hafnium-leave(a)lists.trustedfirmware.org


--===============4034112235640009990==--

