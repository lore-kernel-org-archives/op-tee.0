From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH 0/4] firmware: Add support for Qualcomm UEFI Secure Application
Date: Mon, 05 Sep 2022 12:20:50 +0530
Message-ID: 
 <CAFA6WYOS6iw+4e6TW9NLO2-Bk37rZFN_S2J3dyOVvgOcd9CtXA@mail.gmail.com>
In-Reply-To: <312ede16-f0a9-9b9e-a0d6-fb6e37d9f1bb@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6951515855399417325=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6951515855399417325==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

+ TEE ML

On Fri, 2 Sept 2022 at 18:48, Maximilian Luz <luzmaximilian@gmail.com> wrot=
e:
>
> Hi,
>
> On 9/2/22 09:26, Sumit Garg wrote:
> > Hi Maximilian,
> >
> > On 02/08/22 18:52, Maximilian Luz wrote:
>
> [...]
>
> >> Thanks for this information! So as far as I understand it, this is curre=
ntly an
> >> interface to user-space only, i.e. does not allow in-kernel drivers for =
apps?
> >
> > The Linux TEE framework already provides an in-kernel interface to TEE as=
 well via TEE bus [1]. There are already multiple kernel drivers [2] [3] [4] =
[5] [6] [7] using it. So an EFI driver can be an addition to that.
> >
> > Now coming on to TEE implementations, the drivers I mentioned are based o=
n OP-TEE where devices are queried/enumerated during OP-TEE probe here [8]. S=
o in similar manner QTEE smcinvoke driver should be able to register devices =
on the TEE bus.
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/Documentation/staging/tee.rst#n56
> >
> > [2] drivers/char/tpm/tpm_ftpm_tee.c
> >
> > [3] drivers/char/hw_random/optee-rng.c
> >
> > [4] drivers/firmware/arm_scmi/optee.c
> >
> > [5] security/keys/trusted-keys/trusted_tee.c
> >
> > [6] drivers/firmware/broadcom/tee_bnxt_fw.c
> >
> > [7] drivers/rtc/rtc-optee.c
> >
> > [8] drivers/tee/optee/device.c
>
> Thanks for those links!
>
> I think it would indeed be good if we could make it work via that
> interface and I guess that should generally be possible. As far as I can
> see, the biggest problem might be that the current firmware doesn't seem
> to use UUIDs, so I guess we might need to emulate them somehow.
>

Okay, so I had a brief look at your driver to get an idea how QTEE
identifies its trusted/secure applications. AFAIU, it uses constant
strings as follows:

#define QCTEE_UEFISEC_APP_NAME "qcom.tz.uefisecapp"

I think we should be able to extend the TEE bus concept to accept
constant strings as device IDs as well. So if a driver wants to
support both OP-TEE and QTEE based apps then it can put corresponding
identifiers (UUID or a constant string) in the TEE device match ID
table. This way we should be able to support other TEE implementations
as I think any other identifier apart from UUID can be represented as
a constant string.

If anyone else has any better then feel free to discuss.

-Sumit

> It would be great if someone with some actual knowledge of the firmware
> used on those devices could have a look at this and provide some
> insights.
>
> My plan for now is to hold off on the UEFI variable driver until we have
> a (proper) TEE driver, which unfortunately might be a bit out of my
> depth. I'm happy to help out in any way I can though.
>
> Regards,
> Max

--===============6951515855399417325==--

