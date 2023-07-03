From: 梅建强(禹夜) <meijianqiang.mjq@alibaba-inc.com>
To: op-tee@lists.trustedfirmware.org
Subject: core: fix fragmented memory retrieve
Date: Mon, 03 Jul 2023 14:30:15 +0800
Message-ID: 
 <cfe35b1c-6915-40fe-9432-a84bd7c06bad.meijianqiang.mjq@alibaba-inc.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2263251054730531432=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2263251054730531432==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jens,
The previous fix was based on ffa_mem_transaction with ffa version 1.0,=20
now optee and Hafnium have updated ffa_mem_transaction to ffa 1.1.=20
But optee-driver in linaro-swg/linux seems to be using ffa version 1.0,=20
which causes incorrect data reading when the driver is doing mem_share to Haf=
nium.
I need to debug my previous code.
 When will optee-driver synchronize this version change?
Regards,
Yuye.
------------------------------------------------------------------
=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AJens Wiklander <jens.wiklander@linaro.o=
rg>
=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2023=E5=B9=B46=E6=9C=8828=E6=97=
=A5(=E6=98=9F=E6=9C=9F=E4=B8=89) 17:54
=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A=E6=A2=85=E5=BB=BA=E5=BC=BA(=E7=A6=B9=E5=
=A4=9C) <meijianqiang.mjq@alibaba-inc.com>
=E6=8A=84=E3=80=80=E9=80=81=EF=BC=9Aop-tee <op-tee@lists.trustedfirmware.or=
g>
=E4=B8=BB=E3=80=80=E9=A2=98=EF=BC=9ARe: core: fix fragmented memory retrieve
Hi Yuye,
On Wed, Jun 28, 2023 at 11:50 AM =E6=A2=85=E5=BB=BA=E5=BC=BA(=E7=A6=B9=E5=A4=
=9C)
<meijianqiang.mjq@alibaba-inc.com> wrote:
>
>
>
>
> Hi, Jens,
>
> Sorry for forgetting to revise the PR in time, because my github email chan=
ged so I haven't received any comments.
> Could you help me reopen the PR since I don't have the right? I will re-fix=
 the problem as requested.
> Thanks.
> https://github.com/OP-TEE/optee_os/pull/5966 <https://github.com/OP-TEE/opt=
ee_os/pull/5966 >
I've reopened it.
Cheers,
Jens

--===============2263251054730531432==--

