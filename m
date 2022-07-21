From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [EXTERNAL] Re: Current design of tee-supplicant can't support
 ftpm requests during kernel space bootup
Date: Thu, 21 Jul 2022 15:16:38 +0530
Message-ID: 
 <CAFA6WYN0tLZp8=PNV46NcjGgG=stNwwxtzxz3wFP_4m8OUODNw@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3CPUZP153MB0697ED3AAD46C7544C99C9E3DC919=40PUZP153MB?=
 =?utf-8?q?0697=2EAPCP153=2EPROD=2EOUTLOOK=2ECOM=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8922448789060807040=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8922448789060807040==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 21 Jul 2022 at 14:41, Judy Wang <wangjudy@microsoft.com> wrote:
>
> Hi Sumit,
>
> Thanks for the headstart. Is this patch in mainline? I just checked the lat=
est in https://github.com/torvalds/linux or git://git.kernel.org/pub/scm/linu=
x/kernel/git/torvalds/linux.git and it's not there.

Yeah it hasn't made it to the mainline and you can see the whole
discussion around management of RPMB key. But for OP-TEE use-case that
shouldn't be an issue as the RPMB key is managed by OP-TEE and the
kernel has to just act as a forwarding agent.

>  There's definitely worth to borrow the concept to build a solution but as =
you've figured out, we do not need a whole rpmb driver to manage the request =
from optee-os. In our platform, optee-os has been booted by firmware so most =
of the info has been retrieved through rpmb driver in uboot of firmware. When=
 uboot handover control to linux kernel, the requests from IMA are simply reg=
istering share memory and use it to pass information by reading/writing rpmb =
storage. So what I'm thinking now is a path in supplicant device driver to mm=
c driver which allow us to fulfill the read/writes before supplicant context =
is filled in user space.

Ack.

> I can see the whole design is rooted with the idea of having tee-supplicant=
 as the servant, don't think it's worth to flip the whole design just to fill=
 the gap before user space is up. We haven't really come up with a design so =
will keep you posted.

You don't need to flip the tee-supplicant design but rather just
handle RPMB requests in the kernel itself if it's supported by MMC
driver (you need a similar hook in the kernel as we have in u-boot
[1]). All other OP-TEE RPC requests unhandled by the kernel can be
forwarded to the user-mode tee-supplicant.

[1] https://source.denx.de/u-boot/u-boot/-/commit/4853ad3e13e21462a86e09caee4=
ea27ae68e764b

-Sumit

>
> Judy.
>
> -----Original Message-----
> From: Sumit Garg <sumit.garg@linaro.org>
> Sent: Thursday, July 21, 2022 4:01 PM
> To: Judy Wang <wangjudy@microsoft.com>
> Cc: jens.wiklander(a)linaro.org; op-tee(a)lists.trustedfirmware.org; Carl L=
amb <Carl.Lamb@microsoft.com>; Tyler Hicks <Tyler.Hicks@microsoft.com>
> Subject: [EXTERNAL] Re: Current design of tee-supplicant can't support ftpm=
 requests during kernel space bootup
>
> [You don't often get email from sumit.garg(a)linaro.org. Learn why this is =
important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Hi Judy,
>
> On Wed, 20 Jul 2022 at 18:29, Judy Wang via OP-TEE <op-tee@lists.trustedf=
irmware.org> wrote:
> >
> > Hi Jens,
> >
> > As we are developing platforms to enable RPMB secure storage + fTPM TA, w=
e realize that the current design of optee-os relying on a user space daemon =
tee-supplicant to serve requests cannot meet requirements of another open sou=
rce linux kernel, IMA(Integrity Measurement Architecture). This module will t=
ry to collect data from TPM devices, which in our case, is fTPM TA. It has to=
 collect data when kernel space is booting up, so we cannot delay these reque=
sts further until user space is up. With RPMB as our secure storage, some req=
uests will be sent back to kernel space, but tee-supplicant context is not ye=
t initialized, which results in IMA detection of TPM devices failed. Therefor=
e, failed on the measurements we need.
> > I am wondering if we have related discussion on how modify the design to =
serve optee-os requests during kernel bootup. I can't find related topics in =
LKML archive.
> >
>
> So the requirement here is to have RPMB accesses routed via the TEE kernel =
driver itself rather than being dependent on user-mode tee-supplicant. That's=
 a valid use-case and there have been efforts in the past to add a RPMB subsy=
stem within the kernel (the most recent one here [1]). Although for this use-=
case, I don't think we need that entire RPMB subsystem but some kind of forwa=
rding agent within the TEE kernel driver to read/write encrypted RPMB frames =
to/from MMC/UFS subsystem.
>
> This has been something on my wish list that I wanted to explore earlier bu=
t didn't get enough time. So I would be happy to chip in with reviews/suggest=
ions if you have a proposal/RFC to implement this feature.
>
> [1] https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e.kernel.org%2Flkml%2F20210303135500.24673-1-alex.bennee%40linaro.org%2F&amp;=
data=3D05%7C01%7Cwangjudy%40microsoft.com%7C0aea3957369e432f632a08da6aef23e4%=
7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637939872610700517%7CUnknown%7CT=
WFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D=
%7C3000%7C%7C%7C&amp;sdata=3Dl%2B6w9Ekw7NRwEkmACsfVjgn1ol1YNaHxjOkQ%2B291pmo%=
3D&amp;reserved=3D0
>
> -Sumit
>
> > Thank you.
> > Judy.
> >
> > Cat from /Documentation/ABI/testing/sysfs-bus-optee-devices
> > What:                /sys/bus/tee/devices/optee-ta-<uuid>/
> > Date:           May 2020
> > KernelVersion   5.8
> > Contact:        op-tee(a)lists.trustedfirmware.org<mailto:op-tee@lists.=
trustedfirmware.org>
> > Description:
> >                   OP-TEE bus provides reference to registered drivers und=
er this directory. The <uuid>
> >                   matches Trusted Application (TA) driver and correspondi=
ng TA in secure OS. Drivers
> >                   are free to create needed API under optee-ta-<uuid> dir=
ectory.
> >
> > Reference:
> >
> > fTPM TA: microsoft/MSRSec: Security and Privacy Research at Microsoft
> > (github.com)<https://nam06.safelinks.protection.outlook.com/?url=3Dhttps
> > %3A%2F%2Fgithub.com%2Fmicrosoft%2FMSRSec&amp;data=3D05%7C01%7Cwangjudy%4
> > 0microsoft.com%7C0aea3957369e432f632a08da6aef23e4%7C72f988bf86f141af91
> > ab2d7cd011db47%7C1%7C0%7C637939872610700517%7CUnknown%7CTWFpbGZsb3d8ey
> > JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C300
> > 0%7C%7C%7C&amp;sdata=3D6u5Naup8ldvDk0bKHy9dbyD5s0HurvQqUNfcaoMI8rE%3D&am
> > p;reserved=3D0> IMA enabling:
> > https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fsour
> > ceforge.net%2Fp%2Flinux-ima%2Fwiki%2FHome%2F%23enabling-ima-measuremen
> > t%3A~%3Atext%3Dsystem%2527s%2520runtime%2520integrity.-%2CEnabling%252
> > 0IMA-measurement%2C-IMA%2520was%2520first&amp;data=3D05%7C01%7Cwangjudy%
> > 40microsoft.com%7C0aea3957369e432f632a08da6aef23e4%7C72f988bf86f141af9
> > 1ab2d7cd011db47%7C1%7C0%7C637939872610700517%7CUnknown%7CTWFpbGZsb3d8e
> > yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C30
> > 00%7C%7C%7C&amp;sdata=3DSfGiiflJH1OKWpklRyqGhIK7AJ%2FMDEyMl3f4ILyGRlI%3D
> > &amp;reserved=3D0
> >

--===============8922448789060807040==--

