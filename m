From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: EHF + OPTEE on ARM64
Date: Wed, 17 Mar 2021 08:35:31 +0100
Message-ID: 
 <CAHUa44E59Vi+E6ay03fZkgSEkZQ7kf-HSvWqojG8mVTh=0W3fw@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3CDB6PR0402MB276037FE910CDDFD0C85CC9D886B9=40DB6PR04?=
 =?utf-8?q?02MB2760=2Eeurprd04=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5637544046995585378=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5637544046995585378==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, Mar 16, 2021 at 11:08 AM Peng Fan <peng.fan@nxp.com> wrote:
>
> Hi,
>
> In bl31/ehf.c, there are following two lines, per my understanding,
> when cpu is in secure world, the non-secure interrupt as FIQ(GICv3)
> will be directly catched by EL3, not S-EL1
>         /* Route EL3 interrupts when in Secure and Non-secure. */
>         set_interrupt_rm_flag(flags, NON_SECURE);
>         set_interrupt_rm_flag(flags, SECURE);
>
> So this will conflict with OP-TEE, because OP-TEE needs catch
> NS-interrupt as FIQ in S-EL1 world.

In the case of GICv3, OP-TEE is configured to receive the non-secure
interrupts as FIQ and secure interrupts as IRQ. See CFG_ARM_GICV3.

Cheers,
Jens

--===============5637544046995585378==--

