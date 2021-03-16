From: Jelle Sels <Jelle.Sels@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: EHF + OPTEE on ARM64
Date: Tue, 16 Mar 2021 10:16:34 +0000
Message-ID: <VI1PR08MB534470EBDC3D4CD3FFE65134866B9@VI1PR08MB5344.eurprd08.prod.outlook.com>
In-Reply-To: <=?utf-8?q?=3C010001783a81d680-6a394230-97c8-4f1f-9c6f-c43307c4c?=
 =?utf-8?q?9c9-000000=40email=2Eamazonses=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8533184272937097477=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8533184272937097477==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

If I am not mistaking, the fiq handler should be opteed_sel1_interrupt_handle=
r which will forward the interrupt to S-EL1.

R,

Jelle


________________________________________
From: OP-TEE <op-tee-bounces@lists.trustedfirmware.org> on behalf of Peng F=
an via OP-TEE <op-tee@lists.trustedfirmware.org>
Sent: Tuesday, March 16, 2021 11:08
To: op-tee(a)lists.trustedfirmware.org; Jens Wiklander; Joakim Bech
Subject: EHF + OPTEE on ARM64

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

--===============8533184272937097477==--

