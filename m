From: Manish Pandey2 <Manish.Pandey2@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [TF-A] Re: Handling of normal world interrupts with BL31 PSCI handler
Date: Thu, 01 Feb 2024 14:51:05 +0000
Message-ID: <VI1PR08MB3472B85E456B9DE3E67CF00FC0432@VI1PR08MB3472.eurprd08.prod.outlook.com>
In-Reply-To: <=?utf-8?q?=3CAM6PR08MB34611001F145450D0053C92EC0B4A=40AM6PR08MB?=
 =?utf-8?q?3461=2Eeurprd08=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3218510825048886397=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3218510825048886397==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Sumit/Brian/Caleb,

FYI the patch is now merged upstream https://review.trustedfirmware.org/c/TF-=
A/trusted-firmware-a/+/25034

Thanks
Manish

________________________________
From: Manish Pandey2 <Manish.Pandey2@arm.com>
Sent: 20 November 2023 12:34
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Olivier Deprez <Olivier.Deprez@arm.com>; tf-a(a)lists.trustedfirmware.o=
rg <tf-a@lists.trustedfirmware.org>; Ethridge, Caleb <Caleb.Ethridge@anal=
og.com>; Neely, Brian <Brian.Neely@analog.com>; op-tee(a)lists.trustedfirmw=
are.org <op-tee@lists.trustedfirmware.org>
Subject: Re: [TF-A] Re: Handling of normal world interrupts with BL31 PSCI ha=
ndler

Hi Sumit/Brian/Caleb

This discussion started with the requirement mentioned here [1] and then the =
side effect of it mentioned here [2]

The question in [1] was "I'm seeing some strange behavior when NS interrupts =
are routed to EL3 as FIQs (due to EHF)"
I want to understand from Brian/Caleb that for your use case do you want to h=
ave a different routing model for OP-TEE with your new requirement or you wan=
t to keep it same. Just because you wanted to pull in EHF for NS world, you g=
et side-effect in secure world?

There are couple of things we are discussing in this thread
1. Should interrupts be disabled when invoking SPD hooks in PSCI calls?
  - It can be done in generic PSCI code (for RESET)

2. Is there a need for changing Secure OS routing model just because EHF has =
been pulled in EL3 ? for e.g. OP-TEE running without EHF (in EL3) will have d=
ifferent routing model for FIQs compared to OP-TEE on top of EL3 with EHF.  C=
urrent OP-TEE must have a mechanism to route NS interrupts to NS world, which=
 can be re-used.

What EHF basically does is changes the routing model of foreign interrupts (S=
CR_EL3.FIQ =3D 1) for both secure(except SPM/hafnium) and NS.
For NS world it means : G1S and G0 interrupts are routed to EL3
For Secure world it means : G1NS and G0 are routed to EL3
The only two known use cases for EHF was to support Firmware First handling (=
only for NS world) and SPM_MM (in secure world).

What I am proposing is to change the EL3 code in such a way that we change FI=
Q routing model just for known use cases (Always for NS world and for secure =
world only if SPM_MM is present). This will require a change similar to [3].
This is also inline with the design of Externa aborts routing to EL3 (SCR_EL3=
.EA =3D 1). This routing selectively done for NS world (HANDLE_EA_EL3_FIRST_N=
S) only as we do not have any use cases where Secure world needs it.

On your comments Sumit:
>I don't think secure world should handle any EL3 interrupts, the EL3 firmwar=
e should directly trap and handle EL3 interrupts.
  - I don't think the worry is about actual EL3 interrupts, I guess its NS in=
terrupts which gets triggered as EL3 interrupt (after pulling in EHF)

>Fast Calls execute atomic operations. The call appears to be atomic from the=
 perspective of the calling PE, and returns when the requested operation has =
completed
   - This holds true even if the SMC calls gets interrupted but the control d=
oes not goes back to the caller location.

[1] https://lists.trustedfirmware.org/archives/list/tf-a(a)lists.trustedfirmw=
are.org/thread/HDFDUBNCEHPV7VS7EOHZC6QH3ERZDHND/#2RLBVV34AAXWCHZZUTUICKC3TRWV=
RFPM
[2] https://lists.trustedfirmware.org/archives/list/tf-a(a)lists.trustedfirmw=
are.org/thread/MU56V7FRNLC6DF7Q4KP2FHKOKEDZVP6E/
[3] https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/25034

Thanks
Manish

________________________________
From: Sumit Garg <sumit.garg@linaro.org>
Sent: 16 November 2023 09:16
To: Manish Pandey2 <Manish.Pandey2@arm.com>
Cc: Olivier Deprez <Olivier.Deprez@arm.com>; tf-a(a)lists.trustedfirmware.o=
rg <tf-a@lists.trustedfirmware.org>; Ethridge, Caleb <Caleb.Ethridge@anal=
og.com>; Neely, Brian <Brian.Neely@analog.com>; op-tee(a)lists.trustedfirmw=
are.org <op-tee@lists.trustedfirmware.org>
Subject: Re: [TF-A] Re: Handling of normal world interrupts with BL31 PSCI ha=
ndler

Hi Manish,

On Tue, 14 Nov 2023 at 16:47, Manish Pandey2 <Manish.Pandey2@arm.com> wrote:
>
> Hi Brian,
>
> Your usecase is that you want to use SDEI framework to deliver some EL3 int=
errupts to NS and if your only concern is about system reset the easiest/temp=
 solution would be to disable the G1NS interrupts in OP-TEE dispatcher's syst=
em RESET hook.
>
> The generic solution would take some time to implement as i need to analyse=
/discuss following scenarios before making a decision
>
> 1. Does secure world really needs EL3 interrupts or it can handle NS-interr=
upts as FIQ (pre-EHF, do not modify routing model for secure world).

I don't think secure world should handle any EL3 interrupts, the EL3
firmware should directly trap and handle EL3 interrupts.

>  Notification to EL3 can be done using some standard or IMPDEF mechanism. F=
FA has an ABI for this FFA_EL3_INTR_HANDLE. Current Hafnium implementation fo=
llows this for G0 interrupts.
> 2. The PSCI calls for CPU power down/up, migrate, system reset/off do invok=
e SPD hooks. It need to be carefully analysed whether we really need to disab=
le G1NS interrupts in these paths or not ? For e.g in CPU power down path the=
 PSCI spec mandates that its caller's responsbility to migrate interrupts fro=
m the core (so we don't need to do anything special in TF-A code). Similarly =
for reset/off and migrate we need to analyse what should be the best way to a=
void this situation.

As per SMCCC spec [1], PSCI calls are part of Standard Secure Service
Calls which are essentially fast calls defined as below in the spec:

"Fast Calls execute atomic operations. The call appears to be atomic
from the perspective of the calling
PE, and returns when the requested operation has completed"

These are non-preemptible. So we should disable all interrupts (EL3 G0
or EL1 G1NS or EL1 G1S) while handling PSCI calls. I don't think it's
the responsibility of the OP-TEE dispatcher but rather the generic EL3
firmware itself. However, if a particular platform is unmasking
interrupts in OP-TEE while handling PSCI notifications then it's an
issue which doesn't seem to be the case here.

[1] https://developer.arm.com/documentation/den0028/f/?lang=3Den

-Sumit

>
> Also, i need to work on test infrastructure to simulate these scenarios. It=
 will be useful if your setup can be recreated using OP-TEE/TF-A ?
>
> Thanks
> Manish
>
> ________________________________
> From: Olivier Deprez <Olivier.Deprez@arm.com>
> Sent: 14 November 2023 10:47
> To: Manish Pandey2 <Manish.Pandey2@arm.com>; tf-a(a)lists.trustedfirmware=
.org <tf-a@lists.trustedfirmware.org>; Ethridge, Caleb <Caleb.Ethridge@an=
alog.com>; Neely, Brian <Brian.Neely@analog.com>
> Cc: op-tee(a)lists.trustedfirmware.org <op-tee@lists.trustedfirmware.org>
> Subject: Re: [TF-A] Re: Handling of normal world interrupts with BL31 PSCI =
handler
>
> Hi,
>
> Cc the OP-TEE mailing list, as I sense this might be more of an OP-TEE (/ O=
PTEED) design question than TF-A generic.
>
> I agree with Manish/Achin the best way to eliminate the return by NS interr=
upt while OP-TEE kernel runs handling a PSCI request is to mask interrupts gl=
obally in the GIC e.g. from within opteed_system_reset?
>
> Additional questions:
>
> On https://github.com/ARM-software/arm-trusted-firmware/blob/master/lib/psc=
i/psci_system_off.c#L44
> The PSCI layer calls into OP-TEE SPD and then resumes OP-TEE to handle the =
PSCI call in a platform defined manner.
>
> As suggested here https://github.com/ARM-software/arm-trusted-firmware/blob=
/master/services/spd/opteed/opteed_pm.c#L233 , it looks this invocation is no=
t supposed to return into TF-A?
>
> Did you redefine the weak psci_system_reset function within OP-TEE for your=
 platform?
> Is this function designed to end up in a loop and never returns to TF-A?
>
> As a side question, is this an issue that the TF-A's PSCI platform hook is =
possibly never called https://github.com/ARM-software/arm-trusted-firmware/bl=
ob/master/lib/psci/psci_system_off.c#L50 ?
>
> Regards,
> Olivier.
>
>
> ________________________________
> From: Neely, Brian via TF-A <tf-a@lists.trustedfirmware.org>
> Sent: 13 November 2023 19:01
> To: Manish Pandey2 <Manish.Pandey2@arm.com>; tf-a(a)lists.trustedfirmware=
.org <tf-a@lists.trustedfirmware.org>; Ethridge, Caleb <Caleb.Ethridge@an=
alog.com>
> Subject: [TF-A] Re: Handling of normal world interrupts with BL31 PSCI hand=
ler
>
>
> Hi Manish,
>
>
>
> Just following up on your comment below. Are you planning to provide guidan=
ce as to which PSCI calls should have NS interrupts masked? Are these changes=
 that should go in the mainline TF-A repo, or do you believe they are specifi=
c to our use case?
>
>
>
> Thanks,
>
> Brian
>
>
>
> From: Manish Pandey2 via TF-A <tf-a@lists.trustedfirmware.org>
> Sent: Friday, November 10, 2023 11:31 AM
> To: tf-a(a)lists.trustedfirmware.org; Ethridge, Caleb <Caleb.Ethridge@ana=
log.com>
> Subject: [TF-A] Re: Handling of normal world interrupts with BL31 PSCI hand=
ler
>
>
>
> [External]
>
>
>
> Hi Caleb,
>
>
>
> The quick answer to your query is to mask the NS interrupts in BL31 (option=
 a), You should not remove the callback to OPTEE as it may need to do its own=
 state maintained before system RESET.
>
>
>
> There are other scenarios in PSCI (e.g. CPU power down) path which need to =
consider disabling NS interrupts before invoking Secure world hooks, will pro=
vide further analysis on those later.
>
>
>
> Thanks
> Manish Pandey
>
>
>
> ________________________________
>
> From: Caleb Ethridge via TF-A <tf-a(a)lists.trustedfirmware.org<mailto:tf-a=
@lists.trustedfirmware.org>>
> Sent: 10 November 2023 15:12
> To: tf-a(a)lists.trustedfirmware.org<mailto:tf-a@lists.trustedfirmware.or=
g> <tf-a(a)lists.trustedfirmware.org<mailto:tf-a@lists.trustedfirmware.org>>
> Subject: [TF-A] Handling of normal world interrupts with BL31 PSCI handler
>
>
>
> Hello,
>
> If normal world interrupts are received while invoking TF-A's PSCI reset ha=
ndler, we have observed that the reset can be aborted.
>
> In TF-A's PSCI reset handler, a call out to OP-TEE is made before performin=
g the platform-specific reset:
> https://github.com/ARM-software/arm-trusted-firmware/blob/master/lib/psci/p=
sci_system_off.c#L44<https://urldefense.com/v3/__https:/github.com/ARM-softwa=
re/arm-trusted-firmware/blob/master/lib/psci/psci_system_off.c*L44__;Iw!!A3Ni=
8CS0y2Y!7wdssXjEhDud9Tm5QRek7Mw71eVJJfoimjH1u-u9fLXfaoLqv1ECsW3KakFsaMwnp3xZz=
yiBgwAyngBZMHyWqcCFuQ$>
> https://github.com/ARM-software/arm-trusted-firmware/blob/master/services/s=
pd/opteed/opteed_pm.c#L233<https://urldefense.com/v3/__https:/github.com/ARM-=
software/arm-trusted-firmware/blob/master/services/spd/opteed/opteed_pm.c*L23=
3__;Iw!!A3Ni8CS0y2Y!7wdssXjEhDud9Tm5QRek7Mw71eVJJfoimjH1u-u9fLXfaoLqv1ECsW3Ka=
kFsaMwnp3xZzyiBgwAyngBZMHypZWQwUQ$>
>
> When OP-TEE is entered, it is possible to receive foreign (normal world) in=
terrupts, which invokes the procedure described here: https://optee.readthedo=
cs.io/en/3.16.0/architecture/core.html#deliver-non-secure-interrupts-to-norma=
l-world<https://urldefense.com/v3/__https:/optee.readthedocs.io/en/3.16.0/arc=
hitecture/core.html*deliver-non-secure-interrupts-to-normal-world__;Iw!!A3Ni8=
CS0y2Y!7wdssXjEhDud9Tm5QRek7Mw71eVJJfoimjH1u-u9fLXfaoLqv1ECsW3KakFsaMwnp3xZzy=
iBgwAyngBZMHzqKZ6_0Q$>
> When the SMC call is aborted as described above, this results in the reboot=
 failing. Linux does not retry the PSCI reset (https://github.com/torvalds/li=
nux/blob/master/drivers/firmware/psci/psci.c#L308<https://urldefense.com/v3/_=
_https:/github.com/torvalds/linux/blob/master/drivers/firmware/psci/psci.c*L3=
08__;Iw!!A3Ni8CS0y2Y!7wdssXjEhDud9Tm5QRek7Mw71eVJJfoimjH1u-u9fLXfaoLqv1ECsW3K=
akFsaMwnp3xZzyiBgwAyngBZMHwH0cQx8g$>). This makes sense because it is not exp=
ecting the SMC call to fail (it expected to make an uninterruptable SMC call =
into the secure monitor, not a call into OP-TEE).
>
> If OP-TEE itself is setup to handle PSCI reset calls, it also handles them =
in (uninterruptable) SMC context:
> https://github.com/OP-TEE/optee_os/blob/master/core/arch/arm/sm/psci.c#L140=
<https://urldefense.com/v3/__https:/github.com/OP-TEE/optee_os/blob/master/co=
re/arch/arm/sm/psci.c*L140__;Iw!!A3Ni8CS0y2Y!7wdssXjEhDud9Tm5QRek7Mw71eVJJfoi=
mjH1u-u9fLXfaoLqv1ECsW3KakFsaMwnp3xZzyiBgwAyngBZMHwHJcYAAQ$>
> https://github.com/OP-TEE/optee_os/blob/master/core/arch/arm/sm/sm_a32.S#L9=
6<https://urldefense.com/v3/__https:/github.com/OP-TEE/optee_os/blob/master/c=
ore/arch/arm/sm/sm_a32.S*L96__;Iw!!A3Ni8CS0y2Y!7wdssXjEhDud9Tm5QRek7Mw71eVJJf=
oimjH1u-u9fLXfaoLqv1ECsW3KakFsaMwnp3xZzyiBgwAyngBZMHxqZFTGrA$>
>
> Based on this, we see two possible solutions:
> a) Masking the non-secure interrupts in BL31 while we are doing a reset
> b) Removing the call to OPTEE in the reset handler so that we never leave t=
he SMC context
>
> Which option do you suggest? Or are we missing an important detail here?
>
> Thanks,
>
> Caleb
> --
> TF-A mailing list -- tf-a(a)lists.trustedfirmware.org<mailto:tf-a@lists.t=
rustedfirmware.org>
> To unsubscribe send an email to tf-a-leave(a)lists.trustedfirmware.org<mail=
to:tf-a-leave@lists.trustedfirmware.org>

--===============3218510825048886397==--

