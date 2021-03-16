From: Peng Fan <peng.fan@nxp.com>
To: op-tee@lists.trustedfirmware.org
Subject: EHF + OPTEE on ARM64
Date: Tue, 16 Mar 2021 10:08:04 +0000
Message-ID: <DB6PR0402MB276037FE910CDDFD0C85CC9D886B9@DB6PR0402MB2760.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1505110670776131556=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1505110670776131556==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi,

In bl31/ehf.c, there are following two lines, per my understanding,
when cpu is in secure world, the non-secure interrupt as FIQ(GICv3)
will be directly catched by EL3, not S-EL1
        /* Route EL3 interrupts when in Secure and Non-secure. */
        set_interrupt_rm_flag(flags, NON_SECURE);
        set_interrupt_rm_flag(flags, SECURE);

So this will conflict with OP-TEE, because OP-TEE needs catch
NS-interrupt as FIQ in S-EL1 world.

Am I understand correct?

Any ideas how we could address this to make EHF + OPTEE run
together?

Thanks
Peng.

--===============1505110670776131556==--

