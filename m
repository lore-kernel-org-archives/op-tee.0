From: Peng Fan <peng.fan@nxp.com>
To: op-tee@lists.trustedfirmware.org
Subject: RE: EHF + OPTEE on ARM64
Date: Wed, 17 Mar 2021 07:41:01 +0000
Message-ID: <DB6PR0402MB2760C53C2383B93804107DA4886A9@DB6PR0402MB2760.eurprd04.prod.outlook.com>
In-Reply-To: <
 <CAHUa44E59Vi+E6ay03fZkgSEkZQ7kf-HSvWqojG8mVTh=0W3fw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8406976380524026673=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8406976380524026673==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

> Subject: Re: EHF + OPTEE on ARM64
> 
> On Tue, Mar 16, 2021 at 11:08 AM Peng Fan <peng.fan@nxp.com> wrote:
> >
> > Hi,
> >
> > In bl31/ehf.c, there are following two lines, per my understanding,
> > when cpu is in secure world, the non-secure interrupt as FIQ(GICv3)
> > will be directly catched by EL3, not S-EL1
> >         /* Route EL3 interrupts when in Secure and Non-secure. */
> >         set_interrupt_rm_flag(flags, NON_SECURE);
> >         set_interrupt_rm_flag(flags, SECURE);
> >
> > So this will conflict with OP-TEE, because OP-TEE needs catch
> > NS-interrupt as FIQ in S-EL1 world.
> 
> In the case of GICv3, OP-TEE is configured to receive the non-secure
> interrupts as FIQ and secure interrupts as IRQ. See CFG_ARM_GICV3.

But EHF needs NS-interrupt FIQ be catched by EL3 if I understand correct,
per " set_interrupt_rm_flag(flags, SECURE);"

So currently EHF could not work together with OP-TEE, right?

Thanks,
Peng.

> 
> Cheers,
> Jens

--===============8406976380524026673==--

