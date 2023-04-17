From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: fragment transmission while retrieving memory
Date: Mon, 17 Apr 2023 09:56:13 +0200
Message-ID: 
 <CAHUa44Eg+Wmoota7K089BE7hXNSZaSfACxEi+8FYYHGYdxBovg@mail.gmail.com>
In-Reply-To: <
 <35812435-fdec-4db7-94e4-27ba020b1fd1.meijianqiang.mjq@alibaba-inc.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0583264623136010218=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0583264623136010218==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Yuye,

On Sat, Apr 15, 2023 at 3:15=E2=80=AFPM =E6=A2=85=E5=BB=BA=E5=BC=BA(=E7=A6=B9=
=E5=A4=9C)
<meijianqiang.mjq@alibaba-inc.com> wrote:
> Hi, Jens,
>
> >The first is the descriptor passed with FFA_MEM_RETRIEVE_REQ_32,
> >this one is not likely to need fragmentation support soon.
>
> Could you tell me why? I'm a little unclear.
> Could you describe the difference between the retrieve process you mean and=
 FFA-spec figure 18.4 in detail?
> I need to make sure that I really understand what you mean,
> so that I can implement the missing support for fragmented mem retrieve res=
ponse as you said.
> Or do you mean that we just need to implement the action done by optee afte=
r it receives FFA_MEM_RETRIEVE_RESP_32?

That's right, I believe you only need to add fragmentation support for
FFA_MEM_RETRIEVE_RESP_32.

Cheers,
Jens

>
> Regards,
> Yuye.
>
>
>
>
>
> ------------------------------------------------------------------
> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AJens Wiklander <jens.wiklander@linaro=
.org>
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2023=E5=B9=B44=E6=9C=8814=E6=
=97=A5(=E6=98=9F=E6=9C=9F=E4=BA=94) 14:23
> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A=E6=A2=85=E5=BB=BA=E5=BC=BA(=E7=A6=B9=
=E5=A4=9C) <meijianqiang.mjq@alibaba-inc.com>
> =E6=8A=84=E3=80=80=E9=80=81=EF=BC=9AOlivier Deprez <Olivier.Deprez@arm.co=
m>; hafnium <hafnium@lists.trustedfirmware.org>; op-tee <op-tee@lists.tru=
stedfirmware.org>
> =E4=B8=BB=E3=80=80=E9=A2=98=EF=BC=9ARe: fragment transmission while retriev=
ing memory
>
> Hi Yuye,
>
> On Fri, Apr 14, 2023 at 4:29 AM =E6=A2=85=E5=BB=BA=E5=BC=BA(=E7=A6=B9=E5=A4=
=9C)
> <meijianqiang.mjq@alibaba-inc.com> wrote:
> >
> >
> > Hi, Jens, Olivier,
> >
> > If I understand properly, for this specific issue both optee and hafnium =
need to do further fix.
> > The following discussion and questions are based on figure 18.4 in the FF=
A spec.
> >
> > As I saw in the optee code, the retrieve mechanism would start with this =
code:
> >     retrieve_desc =3D spmc_retrieve_req(cookie);
> > And in the function spmc_retrieve_req,
> > optee sets the total length to the same size as fragment0 length before s=
ending FFA_MEM_FRAG_REQ to hafnium,
> > which means hafnium will only retrieve the fragment0 memory region.
> >
> > In the example process,
> > optee will determines the number of TX sized fragments of descriptor befo=
re sending FFA_MEM_FRAG_REQ to hafnium.
> > I have a question here.
> > How should optee calculate this quantity?
> >
> > Hafnium then receives the FFA_MEM_FRAG_REQ.
> > As I saw in the hafnium code,  hafnium blocks the case that total length>=
fragment length.
> >     if (fragment_length !=3D length) {
> >         dlog_verbose("Fragmentation not yet supported.\n");
> >         return ffa_error(FFA_INVALID_PARAMETERS);
> >     }
> > Obviously it is not what we expected.
> > Then following the example process, hafnium should allocate handle and us=
e it to associate fragments.
> > I didn't find the corresponding implementation in hafnium code for this s=
tep.
> > And I want to know how to implement the associate action here.
> >
> > After that, optee lacks the implementation of FFA_MEM_FRAG_RX and FFA_MEM=
_FRAG_TX ABI in CFG_CORE_SEL2_SPMC enable case.
> > Is there any support plan for the implementation of fragmented memory ret=
rieve in the optee community?
> > Does the hafnium community have a plan to implement it cooperatively?
>
> If I've understood this correctly we have two different cases of
> eventual fragmentation of descriptors. The first is the descriptor
> passed with FFA_MEM_RETRIEVE_REQ_32, this one is not likely to need
> fragmentation support soon. The other is the descriptor received with
> FFA_MEM_RETRIEVE_RESP, I believe this is where you've run into
> trouble.
>
> From OP-TEE point of view, it would make sense if you took lead on
> implementing this. I can help with review etc.
>
> Thanks,
> Jens
>
> >
> > Thanks a lot for your support.
> >
> > Regards,
> > Yuye.
> >
> >
> >
> >
> >
> > ------------------------------------------------------------------
> > =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AOlivier Deprez <Olivier.Deprez@arm.=
com>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2023=E5=B9=B44=E6=9C=8813=E6=
=97=A5(=E6=98=9F=E6=9C=9F=E5=9B=9B) 15:52
> > =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A=E6=A2=85=E5=BB=BA=E5=BC=BA(=E7=A6=B9=
=E5=A4=9C) <meijianqiang.mjq@alibaba-inc.com>
> > =E6=8A=84 =E9=80=81=EF=BC=9Ahafnium <hafnium@lists.trustedfirmware.org>=
; Jens Wiklander <jens.wiklander@linaro.org>
> > =E4=B8=BB =E9=A2=98=EF=BC=9ARe: fragment transmission while retrieving me=
mory
> >
> > Hi Yuye, Jens,
> >
> > For the record, and If I understand properly the last comment in the gith=
ub issue:
> > OP-TEE is missing the implementation for receipt of a fragmented retrieve=
 response
> > There is no further fix to be done in Hafnium for this specific issue at =
this moment, please let me know otherwise.
> >
> > Thanks, Olivier.
> >
> >
> > ________________________________
> > From: =E6=A2=85=E5=BB=BA=E5=BC=BA(=E7=A6=B9=E5=A4=9C) <meijianqiang.mjq(a=
)alibaba-inc.com>
> > Sent: 12 April 2023 09:27
> > To: Olivier Deprez <Olivier.Deprez@arm.com>
> > Cc: hafnium <hafnium@lists.trustedfirmware.org>; Jens Wiklander <jens.w=
iklander@linaro.org>
> > Subject: Re: fragment transmission while retrieving memory
> >
> >
> >
> >
> > Hi, Olivier,
> >
> > In our setup,
> > Hafnium commit: 997476a74571aec4f1a23590d45edf516f3934f4
> > optee version: 3.20.0
> > Thanks.
> >
> > Regards,
> > Yuye.
> >
> > ------------------------------------------------------------------
> > =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AOlivier Deprez <Olivier.Deprez@arm.=
com>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2023=E5=B9=B44=E6=9C=8812=E6=
=97=A5(=E6=98=9F=E6=9C=9F=E4=B8=89) 15:22
> > =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A=E6=A2=85=E5=BB=BA=E5=BC=BA(=E7=A6=B9=
=E5=A4=9C) <meijianqiang.mjq@alibaba-inc.com>
> > =E6=8A=84 =E9=80=81=EF=BC=9Ahafnium <hafnium@lists.trustedfirmware.org>=
; Jens Wiklander <jens.wiklander@linaro.org>
> > =E4=B8=BB =E9=A2=98=EF=BC=9ARe: fragment transmission while retrieving me=
mory
> >
> > Hi Yuye,
> >
> > AFAIK concerning Hafnium, fragmented mem sharing is supported for FFA_MEM=
_SHARE/LEND/DONATE and FFA_MEM_RETRIEVE_RESP.
> > (For the sake of clarity, this isn't supported for FFA_MEM_RETRIEVE_REQ b=
ut this shouldn't be a concern as this limitation only exists in the case of =
mem sharing to multiple borrowers. In your case of a single borrower the mem =
retrieve req. shouldn't have to be fragmented).
> >
> > Can you tell which hafnium commit hash is used in your setup?
> >
> > At the moment, I cannot tell if the issue described concern a miss in Haf=
nium or OP-TEE.
> > I need to dig a bit further into both implementations and I'll let you kn=
ow.
> >
> > Regards,
> > Olivier.
> >
> >
> > ________________________________
> > From: =E6=A2=85=E5=BB=BA=E5=BC=BA(=E7=A6=B9=E5=A4=9C) <meijianqiang.mjq(a=
)alibaba-inc.com>
> > Sent: 12 April 2023 08:21
> > To: Olivier Deprez <Olivier.Deprez@arm.com>
> > Cc: hafnium <hafnium@lists.trustedfirmware.org>; Jens Wiklander <jens.w=
iklander@linaro.org>
> > Subject: fragment transmission while retrieving memory
> >
> >
> >
> >
> > Hi, Olivier,
> >
> > Recently, I've been working on this issue.
> > https://github.com/OP-TEE/optee_os/issues/5943
> > Do you know any differences between hafnium's current implementation of f=
ragment transmission while retrieving memory and the example process describe=
d in FF-A 1.1 Figure 18.4?
> >
> > Regards,
> > Yuye.
> >
> >
>
>

--===============0583264623136010218==--

