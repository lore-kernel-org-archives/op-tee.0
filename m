From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: optee device tree and tee driver
Date: Mon, 09 Jan 2023 09:03:19 +0100
Message-ID: 
 <CAHUa44FJjwsd_F2Kd+j7gOieWv+9QWtnBUeq2DsbHnHp+eHV7Q@mail.gmail.com>
In-Reply-To: <
 <51739f1b-726f-401d-b8e2-dcd678ed5c12.meijianqiang.mjq@alibaba-inc.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6675112038015926210=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6675112038015926210==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jan 7, 2023 at 10:00 AM =E6=A2=85=E5=BB=BA=E5=BC=BA(=E7=A6=B9=E5=A4=
=9C)
<meijianqiang.mjq@alibaba-inc.com> wrote:
>
> Hello expert,
>
> Glad to see you emailed back!
> Before asking you any more questions, I need to explain the problem in our =
development environment.
>
> The optee driver provied by linaro/linux supports FF-A which depends on tha=
t the REE OS kernel supports FF-A.
> We are currently using kernel 5.10 which does not support FF-A, while it is=
 difficult to change from kernel 5.19 to 5.10 due to the platform limitations.

So you are not using FF-A after all? What are you doing with Hafnium as SPMC?

> In consideration of that devices on which the kernel starts are managed by =
ACPI in the current server environment, we prefer to add an ACPI DSDT table f=
or optee and report it to the kernel as a platform device.

OK

>
> Now, we have independently installed the optee.ko compiled by optee driver =
into kernel 5.10, and we found that optee api uid mismatch when optee driver =
probing for its device. It seems that the optee driver tried to get the optee=
 api uid from secure world via optee_smccc_smc, but failed.
>
> dmseg log is as follows:
>
> [   82.121488] tee: loading out-of-tree module taints kernel.
>
> [   82.121578] tee: module verification failed: signature and/or required k=
ey missing - tainting kernel
> [   83.206160] optee: probing for conduit method.
> [   83.206166] optee: optee_compatible string: linaro,optee-tz
> [   83.206171] optee:
> res.a0: 0xffffffffffffffff
> res.a1: 0x0
> res.a2: 0x0
> res.a3: 0x0
> [   83.206172] optee: api uid mismatch
> [   83.206264] optee: probe of LNRO0020:00 failed with error -22
>
> Do you know how to solve this problem? Looking forward to your reply. Thank=
s for support.

The module you have compiled for the kernel seems to use the SMC ABI.
Did you compile OP-TEE to use the SMC ABI too? Or do you expect to use
the FF-A ABI? I'm a bit confused by the earlier mail where you say
that you're using Hafnium as SPMC, which suggests using the FF-A ABI.

Cheers,
Jens

>
> regards,
> yuye
>
>
>
>
>
> ------------------------------------------------------------------
> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AJens Wiklander <jens.wiklander@linaro=
.org>
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2023=E5=B9=B41=E6=9C=885=E6=97=
=A5(=E6=98=9F=E6=9C=9F=E5=9B=9B) 20:29
> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A=E6=A2=85=E5=BB=BA=E5=BC=BA(=E7=A6=B9=
=E5=A4=9C) <meijianqiang.mjq@alibaba-inc.com>
> =E6=8A=84=E3=80=80=E9=80=81=EF=BC=9Aop-tee <op-tee@lists.trustedfirmware.=
org>; =E9=AB=98=E6=B5=B7=E6=BA=90(=E7=A0=81=E6=BA=90) <haiyuan.ghy@alibaba-=
inc.com>; =E7=8E=8B=E4=B8=80=E8=92=99(=E5=8C=97=E8=A7=81) <wym389994@alibab=
a-inc.com>; =E8=B5=B5=E5=93=B2(=E4=B8=BA=E5=93=B2) <weizhe.zz@alibaba-inc.c=
om>
> =E4=B8=BB=E3=80=80=E9=A2=98=EF=BC=9ARe: optee device tree and tee driver
>
> Hi Yuye,
>
> On Wed, Jan 4, 2023 at 6:10 PM =E6=A2=85=E5=BB=BA=E5=BC=BA(=E7=A6=B9=E5=A4=
=9C) <meijianqiang.mjq@alibaba-inc.com> wrote:
> >
> > Hello expert,
> >
> > I have a few questions about the optee device tree and tee driver.
> > In our environment, optee uses version 3.19 vexpress-fvp and runs on top =
of hafnium as SPMC. Here's my question.
> >
> > 1. Does the current optee version support adding ACPI table iterm for opt=
ee to enable REE to identify the installed optee driver so that TA and CA can=
 establish communication?
>
> Since you mention SPMC I assume you're using FF-A also. With FF-A
> there is no need for OP-TEE to have anything in DTB or ACPI. The FF-A
> framework is able to tell if there's an OP-TEE available to
> communicate with or not.
>
> > (I raise this question because I cannot find the corresponding optee node=
 in "/sys/devices/platform" in the current linux environment.
> > While in the QEMU runtime environment, the corresponding optee node is in=
 "/proc/device-tree/firmware", i.e. "linaro,optee-tz".)
>
> Yes, but only in the non-FF-A case.
>
> >
> > 2. If I want to transfer dtb file which includes a device tree node writt=
en by optee to linux, How to configure CFG_DT, CFG_DT_ADDR, and CFG_EXTERNAL_=
DTB_OVERLAY?
> > (I understand that this method should be independent from the method in q=
uestion 1. If it is not, look forward your explain.)
>
> In the FF-A case, this isn't necessary or even possible in an easy way.
>
> Cheers,
> Jens
>
> > Looking forward to your reply. Thanks.
> >
> > regards,
> > yuye
>
>

--===============6675112038015926210==--

