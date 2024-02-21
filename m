From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Calling OPTEE_SMC_CALL_GET_OS_UUID from driver code
Date: Wed, 21 Feb 2024 13:10:28 +0530
Message-ID: 
 <CAFA6WYOMHEygroKGaV7Jw7c8=nrnVrW=Vqk5r1yuTR5rwFijCQ@mail.gmail.com>
In-Reply-To: <443901af-6abd-4a29-b6b6-f06b6d3ce34c@freebox.fr>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4437089305514855574=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4437089305514855574==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Marc,

On Tue, 20 Feb 2024 at 22:59, Marc Gonzalez <mgonzalez@freebox.fr> wrote:
>
> Hello,
>
> The driver code I'm working on hard-codes
>
> #define TEE_SMC_FAST_CALL_VAL(func_num) \
>     ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_32, \
>             ARM_SMCCC_OWNER_TRUSTED_OS, (func_num))
>
> #define TEE_SMC_FUNCID_CALLS_UID 0xFF01
> #define TEE_SMC_CALLS_UID \
>     ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_32, \
>                ARM_SMCCC_OWNER_TRUSTED_OS_END, \
>                TEE_SMC_FUNCID_CALLS_UID)
>
>     arm_smccc_smc(TEE_SMC_CALLS_UID,
>             0, 0, 0/*is_swap*/, 0, 0, 0, 0, &res);
>     dev_err(dev, "TEE UID %x %x %x %x\n", res.a0, res.a1, res.a2, res.a3);
>
>
> but it seems I would be required to somehow use
> OPTEE_SMC_CALL_GET_OS_UUID
>
> But it's not exported, and no code seems to use it...?
>

Can you describe your use-case to require direct
OPTEE_SMC_CALL_GET_OS_UUID invocation?

> $ git grep OPTEE_SMC_CALL_GET_OS_UUID
> Documentation/tee/op-tee.rst:- OPTEE_SMC_CALL_GET_OS_UUID returns the parti=
cular OP-TEE implementation, used
> drivers/tee/optee/optee_smc.h:#define OPTEE_SMC_CALL_GET_OS_UUID \
>
> How do I make calls to OP-TEE from driver code?

The TEE driver API documentation is here [1] and you can refer to the
existing OP-TEE RNG driver here for reference.

[1] https://docs.kernel.org/driver-api/tee.html
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/char/hw_random/optee-rng.c

-Sumit

--===============4437089305514855574==--

