From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: optee device tree and tee driver
Date: Thu, 05 Jan 2023 13:29:20 +0100
Message-ID: 
 <CAHUa44H0AGNvMZ5FjmaG3dBET7v3nyao7pd6vD5tdi6AKs+qaA@mail.gmail.com>
In-Reply-To: <
 <56467e5f-c1d8-400e-83ad-4fec823dee30.meijianqiang.mjq@alibaba-inc.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6699260025830492240=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6699260025830492240==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

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

--===============6699260025830492240==--

