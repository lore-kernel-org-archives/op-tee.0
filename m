From: Judy Wang <wangjudy@microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: RE: [EXTERNAL] Re: Current design of tee-supplicant can't support
 ftpm requests during kernel space bootup
Date: Thu, 21 Jul 2022 09:11:36 +0000
Message-ID: <PUZP153MB0697ED3AAD46C7544C99C9E3DC919@PUZP153MB0697.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <
 <CAFA6WYNNPP5=5RGYVrTOTf6o-_=QkVu7mm78oK-9dmFqEhEB-g@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5359163689458362607=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5359163689458362607==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Sumit,

Thanks for the headstart. Is this patch in mainline? I just checked the lates=
t in https://github.com/torvalds/linux or git://git.kernel.org/pub/scm/linux/=
kernel/git/torvalds/linux.git and it's not there. There's definitely worth to=
 borrow the concept to build a solution but as you've figured out, we do not =
need a whole rpmb driver to manage the request from optee-os. In our platform=
, optee-os has been booted by firmware so most of the info has been retrieved=
 through rpmb driver in uboot of firmware. When uboot handover control to lin=
ux kernel, the requests from IMA are simply registering share memory and use =
it to pass information by reading/writing rpmb storage. So what I'm thinking =
now is a path in supplicant device driver to mmc driver which allow us to ful=
fill the read/writes before supplicant context is filled in user space. I can=
 see the whole design is rooted with the idea of having tee-supplicant as the=
 servant, don't think it's worth to flip the whole design just to fill the ga=
p before user space is up. We haven't really come up with a design so will ke=
ep you posted.

Judy.

-----Original Message-----
From: Sumit Garg <sumit.garg@linaro.org>=20
Sent: Thursday, July 21, 2022 4:01 PM
To: Judy Wang <wangjudy@microsoft.com>
Cc: jens.wiklander(a)linaro.org; op-tee(a)lists.trustedfirmware.org; Carl Lam=
b <Carl.Lamb@microsoft.com>; Tyler Hicks <Tyler.Hicks@microsoft.com>
Subject: [EXTERNAL] Re: Current design of tee-supplicant can't support ftpm r=
equests during kernel space bootup

[You don't often get email from sumit.garg(a)linaro.org. Learn why this is im=
portant at https://aka.ms/LearnAboutSenderIdentification ]

Hi Judy,

On Wed, 20 Jul 2022 at 18:29, Judy Wang via OP-TEE <op-tee@lists.trustedfir=
mware.org> wrote:
>
> Hi Jens,
>
> As we are developing platforms to enable RPMB secure storage + fTPM TA, we =
realize that the current design of optee-os relying on a user space daemon te=
e-supplicant to serve requests cannot meet requirements of another open sourc=
e linux kernel, IMA(Integrity Measurement Architecture). This module will try=
 to collect data from TPM devices, which in our case, is fTPM TA. It has to c=
ollect data when kernel space is booting up, so we cannot delay these request=
s further until user space is up. With RPMB as our secure storage, some reque=
sts will be sent back to kernel space, but tee-supplicant context is not yet =
initialized, which results in IMA detection of TPM devices failed. Therefore,=
 failed on the measurements we need.
> I am wondering if we have related discussion on how modify the design to se=
rve optee-os requests during kernel bootup. I can't find related topics in LK=
ML archive.
>

So the requirement here is to have RPMB accesses routed via the TEE kernel dr=
iver itself rather than being dependent on user-mode tee-supplicant. That's a=
 valid use-case and there have been efforts in the past to add a RPMB subsyst=
em within the kernel (the most recent one here [1]). Although for this use-ca=
se, I don't think we need that entire RPMB subsystem but some kind of forward=
ing agent within the TEE kernel driver to read/write encrypted RPMB frames to=
/from MMC/UFS subsystem.

This has been something on my wish list that I wanted to explore earlier but =
didn't get enough time. So I would be happy to chip in with reviews/suggestio=
ns if you have a proposal/RFC to implement this feature.

[1] https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
kernel.org%2Flkml%2F20210303135500.24673-1-alex.bennee%40linaro.org%2F&amp;da=
ta=3D05%7C01%7Cwangjudy%40microsoft.com%7C0aea3957369e432f632a08da6aef23e4%7C=
72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637939872610700517%7CUnknown%7CTWF=
pbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7=
C3000%7C%7C%7C&amp;sdata=3Dl%2B6w9Ekw7NRwEkmACsfVjgn1ol1YNaHxjOkQ%2B291pmo%3D=
&amp;reserved=3D0

-Sumit

> Thank you.
> Judy.
>
> Cat from /Documentation/ABI/testing/sysfs-bus-optee-devices
> What:                /sys/bus/tee/devices/optee-ta-<uuid>/
> Date:           May 2020
> KernelVersion   5.8
> Contact:        op-tee(a)lists.trustedfirmware.org<mailto:op-tee@lists.tr=
ustedfirmware.org>
> Description:
>                   OP-TEE bus provides reference to registered drivers under=
 this directory. The <uuid>
>                   matches Trusted Application (TA) driver and corresponding=
 TA in secure OS. Drivers
>                   are free to create needed API under optee-ta-<uuid> direc=
tory.
>
> Reference:
>
> fTPM TA: microsoft/MSRSec: Security and Privacy Research at Microsoft=20
> (github.com)<https://nam06.safelinks.protection.outlook.com/?url=3Dhttps
> %3A%2F%2Fgithub.com%2Fmicrosoft%2FMSRSec&amp;data=3D05%7C01%7Cwangjudy%4
> 0microsoft.com%7C0aea3957369e432f632a08da6aef23e4%7C72f988bf86f141af91
> ab2d7cd011db47%7C1%7C0%7C637939872610700517%7CUnknown%7CTWFpbGZsb3d8ey
> JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C300
> 0%7C%7C%7C&amp;sdata=3D6u5Naup8ldvDk0bKHy9dbyD5s0HurvQqUNfcaoMI8rE%3D&am
> p;reserved=3D0> IMA enabling:=20
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fsour
> ceforge.net%2Fp%2Flinux-ima%2Fwiki%2FHome%2F%23enabling-ima-measuremen
> t%3A~%3Atext%3Dsystem%2527s%2520runtime%2520integrity.-%2CEnabling%252
> 0IMA-measurement%2C-IMA%2520was%2520first&amp;data=3D05%7C01%7Cwangjudy%
> 40microsoft.com%7C0aea3957369e432f632a08da6aef23e4%7C72f988bf86f141af9
> 1ab2d7cd011db47%7C1%7C0%7C637939872610700517%7CUnknown%7CTWFpbGZsb3d8e
> yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C30
> 00%7C%7C%7C&amp;sdata=3DSfGiiflJH1OKWpklRyqGhIK7AJ%2FMDEyMl3f4ILyGRlI%3D
> &amp;reserved=3D0
>

--===============5359163689458362607==--

