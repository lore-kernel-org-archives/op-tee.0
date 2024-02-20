From: Marc Gonzalez <mgonzalez@freebox.fr>
To: op-tee@lists.trustedfirmware.org
Subject: Calling OPTEE_SMC_CALL_GET_OS_UUID from driver code
Date: Tue, 20 Feb 2024 17:29:52 +0000
Message-ID: <443901af-6abd-4a29-b6b6-f06b6d3ce34c@freebox.fr>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8480280639327785751=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8480280639327785751==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,

The driver code I'm working on hard-codes

#define TEE_SMC_FAST_CALL_VAL(func_num) \
    ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_32, \
            ARM_SMCCC_OWNER_TRUSTED_OS, (func_num))

#define TEE_SMC_FUNCID_CALLS_UID 0xFF01
#define TEE_SMC_CALLS_UID \
    ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_32, \
               ARM_SMCCC_OWNER_TRUSTED_OS_END, \
               TEE_SMC_FUNCID_CALLS_UID)

    arm_smccc_smc(TEE_SMC_CALLS_UID,
            0, 0, 0/*is_swap*/, 0, 0, 0, 0, &res);
    dev_err(dev, "TEE UID %x %x %x %x\n", res.a0, res.a1, res.a2, res.a3);


but it seems I would be required to somehow use
OPTEE_SMC_CALL_GET_OS_UUID

But it's not exported, and no code seems to use it...?

$ git grep OPTEE_SMC_CALL_GET_OS_UUID
Documentation/tee/op-tee.rst:- OPTEE_SMC_CALL_GET_OS_UUID returns the particu=
lar OP-TEE implementation, used
drivers/tee/optee/optee_smc.h:#define OPTEE_SMC_CALL_GET_OS_UUID \

How do I make calls to OP-TEE from driver code?

Regards,

Marc Gonzalez

--===============8480280639327785751==--

