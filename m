From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Current design of tee-supplicant can't support ftpm requests
 during kernel space bootup
Date: Thu, 21 Jul 2022 13:30:43 +0530
Message-ID: 
 <CAFA6WYNNPP5=5RGYVrTOTf6o-_=QkVu7mm78oK-9dmFqEhEB-g@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3CPUZP153MB06977BECD3377560AE02D4BFDC8E9=40PUZP153MB?=
 =?utf-8?q?0697=2EAPCP153=2EPROD=2EOUTLOOK=2ECOM=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5851062584462667690=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5851062584462667690==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Judy,

On Wed, 20 Jul 2022 at 18:29, Judy Wang via OP-TEE
<op-tee@lists.trustedfirmware.org> wrote:
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

So the requirement here is to have RPMB accesses routed via the TEE
kernel driver itself rather than being dependent on user-mode
tee-supplicant. That's a valid use-case and there have been efforts in
the past to add a RPMB subsystem within the kernel (the most recent
one here [1]). Although for this use-case, I don't think we need that
entire RPMB subsystem but some kind of forwarding agent within the TEE
kernel driver to read/write encrypted RPMB frames to/from MMC/UFS
subsystem.

This has been something on my wish list that I wanted to explore
earlier but didn't get enough time. So I would be happy to chip in
with reviews/suggestions if you have a proposal/RFC to implement this
feature.

[1] https://lore.kernel.org/lkml/20210303135500.24673-1-alex.bennee(a)linaro.=
org/

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
> fTPM TA: microsoft/MSRSec: Security and Privacy Research at Microsoft (gith=
ub.com)<https://github.com/microsoft/MSRSec>
> IMA enabling: https://sourceforge.net/p/linux-ima/wiki/Home/#enabling-ima-m=
easurement:~:text=3Dsystem%27s%20runtime%20integrity.-,Enabling%20IMA%2Dmeasu=
rement,-IMA%20was%20first
>

--===============5851062584462667690==--

