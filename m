From: "Neely, Brian" <Brian.Neely@analog.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 RE: [TF-A] Re: Handling of normal world interrupts with BL31 PSCI handler
Date: Tue, 14 Nov 2023 13:36:37 +0000
Message-ID: <ceb9f0a5b7954aebb4ecb98ee47b3174@analog.com>
In-Reply-To: <=?utf-8?q?=3CVI1PR08MB3472350286DC5E2EFC58107BC0B2A=40VI1PR08MB?=
 =?utf-8?q?3472=2Eeurprd08=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6652040521498914369=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6652040521498914369==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the info Manish. Regarding testing, it seems like this should be p=
ossible with the standard FVP model? If I look at how system reset is impleme=
nted, it looks similar to our platform (platform-specific PSCI handler writes=
 a register to trigger the reset: https://github.com/ARM-software/arm-trusted=
-firmware/blob/master/plat/arm/board/fvp/fvp_pm.c#L320). I think what would n=
eed to happen is to "open" the window in which a NS interrupt could interrupt=
 OP-TEE while it executes its reset hook: https://github.com/OP-TEE/optee_os/=
blob/master/core/arch/arm/kernel/thread.c#L1180. Possibly just putting an inf=
inite loop in there would expose the issue. The NS interrupt that is received=
 on our platform is a generic one, the kernel's timer interrupt, and therefor=
e should also be active/enabled when running Linux on the FVP. Issuing a rebo=
ot command from Linux on the FVP should trigger this scenario.

Thanks,
Brian

From: Manish Pandey2 via TF-A <tf-a@lists.trustedfirmware.org>
Sent: Tuesday, November 14, 2023 6:17 AM
To: Olivier Deprez <Olivier.Deprez@arm.com>; tf-a(a)lists.trustedfirmware.o=
rg; Ethridge, Caleb <Caleb.Ethridge@analog.com>; Neely, Brian <Brian.Neely(=
a)analog.com>
Cc: op-tee(a)lists.trustedfirmware.org
Subject: [TF-A] Re: Handling of normal world interrupts with BL31 PSCI handler

[External]


Hi Brian,

Your usecase is that you want to use SDEI framework to deliver some EL3 inter=
rupts to NS and if your only concern is about system reset the easiest/temp s=
olution would be to disable the G1NS interrupts in OP-TEE dispatcher's system=
 RESET hook.

The generic solution would take some time to implement as i need to analyse/d=
iscuss following scenarios before making a decision

1. Does secure world really needs EL3 interrupts or it can handle NS-interrup=
ts as FIQ (pre-EHF, do not modify routing model for secure world). Notificati=
on to EL3 can be done using some standard or IMPDEF mechanism. FFA has an ABI=
 for this FFA_EL3_INTR_HANDLE. Current Hafnium implementation follows this fo=
r G0 interrupts.
2. The PSCI calls for CPU power down/up, migrate, system reset/off do invoke =
SPD hooks. It need to be carefully analysed whether we really need to disable=
 G1NS interrupts in these paths or not ? For e.g in CPU power down path the P=
SCI spec mandates that its caller's responsbility to migrate interrupts from =
the core (so we don't need to do anything special in TF-A code). Similarly fo=
r reset/off and migrate we need to analyse what should be the best way to avo=
id this situation.

Also, i need to work on test infrastructure to simulate these scenarios. It w=
ill be useful if your setup can be recreated using OP-TEE/TF-A ?

Thanks
Manish

________________________________
From: Olivier Deprez <Olivier.Deprez(a)arm.com<mailto:Olivier.Deprez@arm.co=
m>>
Sent: 14 November 2023 10:47
To: Manish Pandey2 <Manish.Pandey2(a)arm.com<mailto:Manish.Pandey2@arm.com>=
>; tf-a(a)lists.trustedfirmware.org<mailto:tf-a@lists.trustedfirmware.org> =
<tf-a(a)lists.trustedfirmware.org<mailto:tf-a@lists.trustedfirmware.org>>; =
Ethridge, Caleb <Caleb.Ethridge(a)analog.com<mailto:Caleb.Ethridge@analog.c=
om>>; Neely, Brian <Brian.Neely(a)analog.com<mailto:Brian.Neely@analog.com>>
Cc: op-tee(a)lists.trustedfirmware.org<mailto:op-tee@lists.trustedfirmware.=
org> <op-tee(a)lists.trustedfirmware.org<mailto:op-tee@lists.trustedfirmwar=
e.org>>
Subject: Re: [TF-A] Re: Handling of normal world interrupts with BL31 PSCI ha=
ndler

Hi,

Cc the OP-TEE mailing list, as I sense this might be more of an OP-TEE (/ OPT=
EED) design question than TF-A generic.

I agree with Manish/Achin the best way to eliminate the return by NS interrup=
t while OP-TEE kernel runs handling a PSCI request is to mask interrupts glob=
ally in the GIC e.g. from within opteed_system_reset?

Additional questions:

On https://github.com/ARM-software/arm-trusted-firmware/blob/master/lib/psci/=
psci_system_off.c#L44<https://urldefense.com/v3/__https:/github.com/ARM-softw=
are/arm-trusted-firmware/blob/master/lib/psci/psci_system_off.c*L44__;Iw!!A3N=
i8CS0y2Y!8HI5Oe8IvvYa590aD7zysc9MYvvYV0XYvmerD_jk2SFGjCq98qqbK5KnQdTJHBIw4KcB=
GjviF0__i89-cn3OjFRSiw$>
The PSCI layer calls into OP-TEE SPD and then resumes OP-TEE to handle the PS=
CI call in a platform defined manner.

As suggested here https://github.com/ARM-software/arm-trusted-firmware/blob/m=
aster/services/spd/opteed/opteed_pm.c#L233<https://urldefense.com/v3/__https:=
/github.com/ARM-software/arm-trusted-firmware/blob/master/services/spd/opteed=
/opteed_pm.c*L233__;Iw!!A3Ni8CS0y2Y!8HI5Oe8IvvYa590aD7zysc9MYvvYV0XYvmerD_jk2=
SFGjCq98qqbK5KnQdTJHBIw4KcBGjviF0__i89-cn1laotJtQ$> , it looks this invocatio=
n is not supposed to return into TF-A?

Did you redefine the weak psci_system_reset function within OP-TEE for your p=
latform?
Is this function designed to end up in a loop and never returns to TF-A?

As a side question, is this an issue that the TF-A's PSCI platform hook is po=
ssibly never called https://github.com/ARM-software/arm-trusted-firmware/blob=
/master/lib/psci/psci_system_off.c#L50<https://urldefense.com/v3/__https:/git=
hub.com/ARM-software/arm-trusted-firmware/blob/master/lib/psci/psci_system_of=
f.c*L50__;Iw!!A3Ni8CS0y2Y!8HI5Oe8IvvYa590aD7zysc9MYvvYV0XYvmerD_jk2SFGjCq98qq=
bK5KnQdTJHBIw4KcBGjviF0__i89-cn2_ePsW5A$> ?

Regards,
Olivier.


________________________________
From: Neely, Brian via TF-A <tf-a(a)lists.trustedfirmware.org<mailto:tf-a@l=
ists.trustedfirmware.org>>
Sent: 13 November 2023 19:01
To: Manish Pandey2 <Manish.Pandey2(a)arm.com<mailto:Manish.Pandey2@arm.com>=
>; tf-a(a)lists.trustedfirmware.org<mailto:tf-a@lists.trustedfirmware.org> =
<tf-a(a)lists.trustedfirmware.org<mailto:tf-a@lists.trustedfirmware.org>>; =
Ethridge, Caleb <Caleb.Ethridge(a)analog.com<mailto:Caleb.Ethridge@analog.c=
om>>
Subject: [TF-A] Re: Handling of normal world interrupts with BL31 PSCI handler


Hi Manish,



Just following up on your comment below. Are you planning to provide guidance=
 as to which PSCI calls should have NS interrupts masked? Are these changes t=
hat should go in the mainline TF-A repo, or do you believe they are specific =
to our use case?



Thanks,

Brian



From: Manish Pandey2 via TF-A <tf-a@lists.trustedfirmware.org<mailto:tf-a(a=
)lists.trustedfirmware.org>>
Sent: Friday, November 10, 2023 11:31 AM
To: tf-a(a)lists.trustedfirmware.org<mailto:tf-a@lists.trustedfirmware.org>=
; Ethridge, Caleb <Caleb.Ethridge(a)analog.com<mailto:Caleb.Ethridge@analog=
.com>>
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

--===============6652040521498914369==--

