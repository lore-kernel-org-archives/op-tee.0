From: 梅建强(禹夜) <meijianqiang.mjq@alibaba-inc.com>
To: op-tee@lists.trustedfirmware.org
Subject: =?utf-8?b?5Zue5aSN77yab3B0ZWU=?= device tree and tee driver
Date: Sat, 07 Jan 2023 17:00:30 +0800
Message-ID: 
 <51739f1b-726f-401d-b8e2-dcd678ed5c12.meijianqiang.mjq@alibaba-inc.com>
In-Reply-To: <
 <CAHUa44H0AGNvMZ5FjmaG3dBET7v3nyao7pd6vD5tdi6AKs+qaA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8711480264368989118=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8711480264368989118==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello expert,
Glad to see you emailed back!
Before asking you any more questions, I need to explain the problem in our de=
velopment environment.
The optee driver provied by linaro/linux supports FF-A which depends on that =
the REE OS kernel supports FF-A.
We are currently using kernel 5.10 which does not support FF-A, while it is d=
ifficult to change from kernel 5.19 to 5.10 due to the platform limitations.
In consideration of that devices on which the kernel starts are managed by AC=
PI in the current server environment, we prefer to add an ACPI DSDT table for=
 optee and report it to the kernel as a platform device.
Now, we have independently installed the optee.ko compiled by optee driver in=
to kernel 5.10, and we found that optee api uid mismatch when optee driver pr=
obing for its device. It seems that the optee driver tried to get the optee a=
pi uid from secure world via optee_smccc_smc, but failed.
dmseg log is as follows:=20
[ 82.121488] tee: loading out-of-tree module taints kernel.
[ 82.121578] tee: module verification failed: signature and/or required key m=
issing - tainting kernel
[ 83.206160] optee: probing for conduit method.
[ 83.206166] optee: optee_compatible string: linaro,optee-tz
[ 83.206171] optee:
res.a0: 0xffffffffffffffff
 res.a1: 0x0
 res.a2: 0x0
 res.a3: 0x0
[ 83.206172] optee: api uid mismatch
[ 83.206264] optee: probe of LNRO0020:00 failed with error -22
Do you know how to solve this problem? Looking forward to your reply. Thanks =
for support.
regards,
yuye
------------------------------------------------------------------
=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AJens Wiklander <jens.wiklander@linaro.o=
rg>
=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2023=E5=B9=B41=E6=9C=885=E6=97=
=A5(=E6=98=9F=E6=9C=9F=E5=9B=9B) 20:29
=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A=E6=A2=85=E5=BB=BA=E5=BC=BA(=E7=A6=B9=E5=
=A4=9C) <meijianqiang.mjq@alibaba-inc.com>
=E6=8A=84=E3=80=80=E9=80=81=EF=BC=9Aop-tee <op-tee@lists.trustedfirmware.or=
g>; =E9=AB=98=E6=B5=B7=E6=BA=90(=E7=A0=81=E6=BA=90) <haiyuan.ghy@alibaba-in=
c.com>; =E7=8E=8B=E4=B8=80=E8=92=99(=E5=8C=97=E8=A7=81) <wym389994@alibaba-=
inc.com>; =E8=B5=B5=E5=93=B2(=E4=B8=BA=E5=93=B2) <weizhe.zz@alibaba-inc.com>
=E4=B8=BB=E3=80=80=E9=A2=98=EF=BC=9ARe: optee device tree and tee driver
Hi Yuye,
On Wed, Jan 4, 2023 at 6:10 PM =E6=A2=85=E5=BB=BA=E5=BC=BA(=E7=A6=B9=E5=A4=9C=
) <meijianqiang.mjq@alibaba-inc.com> wrote:
>
> Hello expert,
>
> I have a few questions about the optee device tree and tee driver.
> In our environment, optee uses version 3.19 vexpress-fvp and runs on top of=
 hafnium as SPMC. Here's my question.
>
> 1. Does the current optee version support adding ACPI table iterm for optee=
 to enable REE to identify the installed optee driver so that TA and CA can e=
stablish communication?
Since you mention SPMC I assume you're using FF-A also. With FF-A
there is no need for OP-TEE to have anything in DTB or ACPI. The FF-A
framework is able to tell if there's an OP-TEE available to
communicate with or not.
> (I raise this question because I cannot find the corresponding optee node i=
n "/sys/devices/platform" in the current linux environment.
> While in the QEMU runtime environment, the corresponding optee node is in "=
/proc/device-tree/firmware", i.e. "linaro,optee-tz".)
Yes, but only in the non-FF-A case.
>
> 2. If I want to transfer dtb file which includes a device tree node written=
 by optee to linux, How to configure CFG_DT, CFG_DT_ADDR, and CFG_EXTERNAL_DT=
B_OVERLAY?
> (I understand that this method should be independent from the method in que=
stion 1. If it is not, look forward your explain.)
In the FF-A case, this isn't necessary or even possible in an easy way.
Cheers,
Jens
> Looking forward to your reply. Thanks.
>
> regards,
> yuye

--===============8711480264368989118==--

