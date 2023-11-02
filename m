From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 0/2] OP-TEE FF-A notifications
Date: Thu, 02 Nov 2023 17:46:55 +0530
Message-ID: 
 <CAFA6WYPh-hfzcuLOHToby_vuQcqHh64kF0WQ4AdoaRwjeyyFFg@mail.gmail.com>
In-Reply-To: <20231102115925.GA1233092@rayden>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3007041783787881590=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3007041783787881590==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2 Nov 2023 at 17:29, Jens Wiklander <jens.wiklander@linaro.org> wro=
te:
>
> Hi Sumit,
>
> On Mon, Oct 30, 2023 at 11:32:47AM +0530, Sumit Garg wrote:
> > Hi Jens,
> >
> > On Thu, 26 Oct 2023 at 13:34, Jens Wiklander <jens.wiklander@linaro.org=
> wrote:
> > >
> > > Hi all,
> > >
> > > This patchset adds support for using FF-A notifications as a delivery
> > > mechanism of asynchronous notifications from OP-TEE running in the secu=
re
> > > world. Support for asynchronous notifications via the SMC ABI was added=
 in
> > > [1], here we add the counterpart needed when using the the FF-A ABI.
> > >
> > > Support for FF-A notifications is added with [2] and this patch set is =
based
> > > on Sudeeps tree at [3].
> >
> > It's good to see FF-A notifications support coming through. The good
> > aspect here is that FF-A uses a common secure world SGI for
> > notifications and doesn't have to deal with platform specific reserved
> > SPI for notifications.
> >
> > From OP-TEE point of view I think most of the secure SGI donation base
> > would be common, so can we switch the SMC ABI to use this donated
> > secure world SGI for notifications too?
>
> The SMC ABI driver picks up the interrupt used for notification from
> device-tree, so there's a chance that it just works if a donated SGI is
> supplied instead. We'll need some changes in the secure world side of
> OP-TEE, but they wouldn't affect the ABI.

AFAIK, a secure world donated SGIs doesn't support IRQ mapping via DT.
The FF-A driver explicitly creates that mapping here [1]. Moreover
it's better to detect it via an SMC call rather than hard coded via DT
as FF-A driver does.

So the ABI should dynamically detect if there is a donated SGI then
use it otherwise fallback to SPI/PPI detection via DT. This would make
the notifications feature platform agnostic and we can drop legacy DT
methods from optee-os entirely but still need to maintain them in the
kernel for backwards compatibility.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/tr=
ee/drivers/firmware/arm_ffa/driver.c?h=3Dffa-updates-6.7#n1283
[2] https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/tr=
ee/drivers/firmware/arm_ffa/driver.c?h=3Dffa-updates-6.7#n1275

-Sumit

>
> Cheers,
> Jens
>
> >
> > -Sumit
> >
> > >
> > > [1] https://lore.kernel.org/lkml/20211103090255.998070-1-jens.wiklander=
(a)linaro.org/
> > > [2] https://lore.kernel.org/linux-arm-kernel/20231005-ffa_v1-1_notif-v4=
-0-cddd3237809c(a)arm.com/
> > > [3] https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.=
git/tag/?h=3Dffa-updates-6.7
> > >     commit bcefd1bf63b1 ("firmware: arm_ffa: Upgrade the driver version=
 to v1.1")
> > >
> > > Thanks,
> > > Jens
> > >
> > > Jens Wiklander (2):
> > >   optee: provide optee_do_bottom_half() as a common function
> > >   optee: ffa_abi: add asynchronous notifications
> > >
> > >  drivers/tee/optee/call.c          | 31 ++++++++++-
> > >  drivers/tee/optee/ffa_abi.c       | 91 ++++++++++++++++++++++++++++++-
> > >  drivers/tee/optee/optee_ffa.h     | 28 ++++++++--
> > >  drivers/tee/optee/optee_private.h |  9 ++-
> > >  drivers/tee/optee/smc_abi.c       | 36 ++----------
> > >  5 files changed, 153 insertions(+), 42 deletions(-)
> > >
> > >
> > > base-commit: bcefd1bf63b1ec9bb08067021cf47f0fad96f395
> > > --
> > > 2.34.1
> > >

--===============3007041783787881590==--

