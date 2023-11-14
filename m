From: Olivier Deprez <Olivier.Deprez@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [TF-A] Re: Handling of normal world interrupts with BL31 PSCI handler
Date: Tue, 14 Nov 2023 10:47:21 +0000
Message-ID: <DB9PR08MB6796CABC939964A3C47286029BB2A@DB9PR08MB6796.eurprd08.prod.outlook.com>
In-Reply-To: <43d950dc2ae648ea87b8234123a40633@analog.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0867401145542951730=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0867401145542951730==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Cc the OP-TEE mailing list, as I sense this might be more of an OP-TEE (/ OPT=
EED) design question than TF-A generic.

I agree with Manish/Achin the best way to eliminate the return by NS interrup=
t while OP-TEE kernel runs handling a PSCI request is to mask interrupts glob=
ally in the GIC e.g. from within opteed_system_reset?

Additional questions:

On https://github.com/ARM-software/arm-trusted-firmware/blob/master/lib/psci/=
psci_system_off.c#L44
The PSCI layer calls into OP-TEE SPD and then resumes OP-TEE to handle the PS=
CI call in a platform defined manner.

As suggested here https://github.com/ARM-software/arm-trusted-firmware/blob/m=
aster/services/spd/opteed/opteed_pm.c#L233 , it looks this invocation is not =
supposed to return into TF-A?

Did you redefine the weak psci_system_reset function within OP-TEE for your p=
latform?
Is this function designed to end up in a loop and never returns to TF-A?

As a side question, is this an issue that the TF-A's PSCI platform hook is po=
ssibly never called https://github.com/ARM-software/arm-trusted-firmware/blob=
/master/lib/psci/psci_system_off.c#L50 ?

Regards,
Olivier.


________________________________
From: Neely, Brian via TF-A <tf-a@lists.trustedfirmware.org>
Sent: 13 November 2023 19:01
To: Manish Pandey2 <Manish.Pandey2@arm.com>; tf-a(a)lists.trustedfirmware.o=
rg <tf-a@lists.trustedfirmware.org>; Ethridge, Caleb <Caleb.Ethridge@anal=
og.com>
Subject: [TF-A] Re: Handling of normal world interrupts with BL31 PSCI handler


Hi Manish,



Just following up on your comment below. Are you planning to provide guidance=
 as to which PSCI calls should have NS interrupts masked? Are these changes t=
hat should go in the mainline TF-A repo, or do you believe they are specific =
to our use case?



Thanks,

Brian



From: Manish Pandey2 via TF-A <tf-a@lists.trustedfirmware.org>
Sent: Friday, November 10, 2023 11:31 AM
To: tf-a(a)lists.trustedfirmware.org; Ethridge, Caleb <Caleb.Ethridge@analo=
g.com>
Subject: [TF-A] Re: Handling of normal world interrupts with BL31 PSCI handler



[External]



Hi Caleb,



The quick answer to your query is to mask the NS interrupts in BL31 (option a=
), You should not remove the callback to OPTEE as it may need to do its own s=
tate maintained before system RESET.



There are other scenarios in PSCI (e.g. CPU power down) path which need to co=
nsider disabling NS interrupts before invoking Secure world hooks, will provi=
de further analysis on those later.



Thanks
Manish Pandey



________________________________

From: Caleb Ethridge via TF-A <tf-a@lists.trustedfirmware.org<mailto:tf-a(a=
)lists.trustedfirmware.org>>
Sent: 10 November 2023 15:12
To: tf-a(a)lists.trustedfirmware.org<mailto:tf-a@lists.trustedfirmware.org>=
 <tf-a(a)lists.trustedfirmware.org<mailto:tf-a@lists.trustedfirmware.org>>
Subject: [TF-A] Handling of normal world interrupts with BL31 PSCI handler



Hello,

If normal world interrupts are received while invoking TF-A's PSCI reset hand=
ler, we have observed that the reset can be aborted.

In TF-A's PSCI reset handler, a call out to OP-TEE is made before performing =
the platform-specific reset:
https://github.com/ARM-software/arm-trusted-firmware/blob/master/lib/psci/psc=
i_system_off.c#L44<https://urldefense.com/v3/__https:/github.com/ARM-software=
/arm-trusted-firmware/blob/master/lib/psci/psci_system_off.c*L44__;Iw!!A3Ni8C=
S0y2Y!7wdssXjEhDud9Tm5QRek7Mw71eVJJfoimjH1u-u9fLXfaoLqv1ECsW3KakFsaMwnp3xZzyi=
BgwAyngBZMHyWqcCFuQ$>
https://github.com/ARM-software/arm-trusted-firmware/blob/master/services/spd=
/opteed/opteed_pm.c#L233<https://urldefense.com/v3/__https:/github.com/ARM-so=
ftware/arm-trusted-firmware/blob/master/services/spd/opteed/opteed_pm.c*L233_=
_;Iw!!A3Ni8CS0y2Y!7wdssXjEhDud9Tm5QRek7Mw71eVJJfoimjH1u-u9fLXfaoLqv1ECsW3KakF=
saMwnp3xZzyiBgwAyngBZMHypZWQwUQ$>

When OP-TEE is entered, it is possible to receive foreign (normal world) inte=
rrupts, which invokes the procedure described here: https://optee.readthedocs=
.io/en/3.16.0/architecture/core.html#deliver-non-secure-interrupts-to-normal-=
world<https://urldefense.com/v3/__https:/optee.readthedocs.io/en/3.16.0/archi=
tecture/core.html*deliver-non-secure-interrupts-to-normal-world__;Iw!!A3Ni8CS=
0y2Y!7wdssXjEhDud9Tm5QRek7Mw71eVJJfoimjH1u-u9fLXfaoLqv1ECsW3KakFsaMwnp3xZzyiB=
gwAyngBZMHzqKZ6_0Q$>
When the SMC call is aborted as described above, this results in the reboot f=
ailing. Linux does not retry the PSCI reset (https://github.com/torvalds/linu=
x/blob/master/drivers/firmware/psci/psci.c#L308<https://urldefense.com/v3/__h=
ttps:/github.com/torvalds/linux/blob/master/drivers/firmware/psci/psci.c*L308=
__;Iw!!A3Ni8CS0y2Y!7wdssXjEhDud9Tm5QRek7Mw71eVJJfoimjH1u-u9fLXfaoLqv1ECsW3Kak=
FsaMwnp3xZzyiBgwAyngBZMHwH0cQx8g$>). This makes sense because it is not expec=
ting the SMC call to fail (it expected to make an uninterruptable SMC call in=
to the secure monitor, not a call into OP-TEE).

If OP-TEE itself is setup to handle PSCI reset calls, it also handles them in=
 (uninterruptable) SMC context:
https://github.com/OP-TEE/optee_os/blob/master/core/arch/arm/sm/psci.c#L140<h=
ttps://urldefense.com/v3/__https:/github.com/OP-TEE/optee_os/blob/master/core=
/arch/arm/sm/psci.c*L140__;Iw!!A3Ni8CS0y2Y!7wdssXjEhDud9Tm5QRek7Mw71eVJJfoimj=
H1u-u9fLXfaoLqv1ECsW3KakFsaMwnp3xZzyiBgwAyngBZMHwHJcYAAQ$>
https://github.com/OP-TEE/optee_os/blob/master/core/arch/arm/sm/sm_a32.S#L96<=
https://urldefense.com/v3/__https:/github.com/OP-TEE/optee_os/blob/master/cor=
e/arch/arm/sm/sm_a32.S*L96__;Iw!!A3Ni8CS0y2Y!7wdssXjEhDud9Tm5QRek7Mw71eVJJfoi=
mjH1u-u9fLXfaoLqv1ECsW3KakFsaMwnp3xZzyiBgwAyngBZMHxqZFTGrA$>

Based on this, we see two possible solutions:
a) Masking the non-secure interrupts in BL31 while we are doing a reset
b) Removing the call to OPTEE in the reset handler so that we never leave the=
 SMC context

Which option do you suggest? Or are we missing an important detail here?

Thanks,

Caleb
--
TF-A mailing list -- tf-a(a)lists.trustedfirmware.org<mailto:tf-a@lists.tru=
stedfirmware.org>
To unsubscribe send an email to tf-a-leave(a)lists.trustedfirmware.org<mailto=
:tf-a-leave@lists.trustedfirmware.org>

--===============0867401145542951730==--

