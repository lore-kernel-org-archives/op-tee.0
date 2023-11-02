From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 0/2] OP-TEE FF-A notifications
Date: Thu, 02 Nov 2023 14:16:24 +0100
Message-ID: <20231102131624.GB1233092@rayden>
In-Reply-To: <
 <CAFA6WYPh-hfzcuLOHToby_vuQcqHh64kF0WQ4AdoaRwjeyyFFg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1917263017963081423=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1917263017963081423==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 02, 2023 at 05:46:55PM +0530, Sumit Garg wrote:
> On Thu, 2 Nov 2023 at 17:29, Jens Wiklander <jens.wiklander@linaro.org> w=
rote:
> >
> > Hi Sumit,
> >
> > On Mon, Oct 30, 2023 at 11:32:47AM +0530, Sumit Garg wrote:
> > > Hi Jens,
> > >
> > > On Thu, 26 Oct 2023 at 13:34, Jens Wiklander <jens.wiklander@linaro.o=
rg> wrote:
> > > >
> > > > Hi all,
> > > >
> > > > This patchset adds support for using FF-A notifications as a delivery
> > > > mechanism of asynchronous notifications from OP-TEE running in the se=
cure
> > > > world. Support for asynchronous notifications via the SMC ABI was add=
ed in
> > > > [1], here we add the counterpart needed when using the the FF-A ABI.
> > > >
> > > > Support for FF-A notifications is added with [2] and this patch set i=
s based
> > > > on Sudeeps tree at [3].
> > >
> > > It's good to see FF-A notifications support coming through. The good
> > > aspect here is that FF-A uses a common secure world SGI for
> > > notifications and doesn't have to deal with platform specific reserved
> > > SPI for notifications.
> > >
> > > From OP-TEE point of view I think most of the secure SGI donation base
> > > would be common, so can we switch the SMC ABI to use this donated
> > > secure world SGI for notifications too?
> >
> > The SMC ABI driver picks up the interrupt used for notification from
> > device-tree, so there's a chance that it just works if a donated SGI is
> > supplied instead. We'll need some changes in the secure world side of
> > OP-TEE, but they wouldn't affect the ABI.
>=20
> AFAIK, a secure world donated SGIs doesn't support IRQ mapping via DT.
> The FF-A driver explicitly creates that mapping here [1].

That looks a lot like what platform_get_irq() does via of_irq_get().

> Moreover
> it's better to detect it via an SMC call rather than hard coded via DT
> as FF-A driver does.

Typo? I guess you mean that you prefer that way the FF-A driver does it
rather than having it set in the DT.

Assuming that you only care about "arm,gic-v3". The SGI will likely
always be the same so it shouldn't be too hard to keep the correct
configuration in DT.

>=20
> So the ABI should dynamically detect if there is a donated SGI then
> use it otherwise fallback to SPI/PPI detection via DT. This would make
> the notifications feature platform agnostic and we can drop legacy DT
> methods from optee-os entirely but still need to maintain them in the
> kernel for backwards compatibility.

We care about compatibility in both directions so we'd need to keep it
in OP-TEE too, but perhaps under a config flag.

Thanks,
Jens

>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/=
tree/drivers/firmware/arm_ffa/driver.c?h=3Dffa-updates-6.7#n1283
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/=
tree/drivers/firmware/arm_ffa/driver.c?h=3Dffa-updates-6.7#n1275
>=20
> -Sumit
>=20
> >
> > Cheers,
> > Jens
> >
> > >
> > > -Sumit
> > >
> > > >
> > > > [1] https://lore.kernel.org/lkml/20211103090255.998070-1-jens.wikland=
er(a)linaro.org/
> > > > [2] https://lore.kernel.org/linux-arm-kernel/20231005-ffa_v1-1_notif-=
v4-0-cddd3237809c(a)arm.com/
> > > > [3] https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linu=
x.git/tag/?h=3Dffa-updates-6.7
> > > >     commit bcefd1bf63b1 ("firmware: arm_ffa: Upgrade the driver versi=
on to v1.1")
> > > >
> > > > Thanks,
> > > > Jens
> > > >
> > > > Jens Wiklander (2):
> > > >   optee: provide optee_do_bottom_half() as a common function
> > > >   optee: ffa_abi: add asynchronous notifications
> > > >
> > > >  drivers/tee/optee/call.c          | 31 ++++++++++-
> > > >  drivers/tee/optee/ffa_abi.c       | 91 +++++++++++++++++++++++++++++=
+-
> > > >  drivers/tee/optee/optee_ffa.h     | 28 ++++++++--
> > > >  drivers/tee/optee/optee_private.h |  9 ++-
> > > >  drivers/tee/optee/smc_abi.c       | 36 ++----------
> > > >  5 files changed, 153 insertions(+), 42 deletions(-)
> > > >
> > > >
> > > > base-commit: bcefd1bf63b1ec9bb08067021cf47f0fad96f395
> > > > --
> > > > 2.34.1
> > > >

--===============1917263017963081423==--

