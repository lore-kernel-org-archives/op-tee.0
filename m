From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 0/2] OP-TEE FF-A notifications
Date: Mon, 06 Nov 2023 09:39:09 +0100
Message-ID: 
 <CAHUa44E3ju=jp2d8wFu57Gv3ayoQuvAW+WQKD_iTby9t77CBeQ@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYP2php3gKjOeD93fGAZgndOGtKhViMrf25zVyp66dCm6A@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3082207501693789233=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3082207501693789233==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 9:53=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> w=
rote:
>
> On Fri, 3 Nov 2023 at 13:32, Jens Wiklander <jens.wiklander@linaro.org> w=
rote:
> >
> > On Thu, Nov 2, 2023 at 3:05=E2=80=AFPM Sumit Garg <sumit.garg@linaro.or=
g> wrote:
> > >
> > > On Thu, 2 Nov 2023 at 18:46, Jens Wiklander <jens.wiklander@linaro.or=
g> wrote:
> > > >
> > > > On Thu, Nov 02, 2023 at 05:46:55PM +0530, Sumit Garg wrote:
> > > > > On Thu, 2 Nov 2023 at 17:29, Jens Wiklander <jens.wiklander@linar=
o.org> wrote:
> > > > > >
> > > > > > Hi Sumit,
> > > > > >
> > > > > > On Mon, Oct 30, 2023 at 11:32:47AM +0530, Sumit Garg wrote:
> > > > > > > Hi Jens,
> > > > > > >
> > > > > > > On Thu, 26 Oct 2023 at 13:34, Jens Wiklander <jens.wiklander@=
linaro.org> wrote:
> > > > > > > >
> > > > > > > > Hi all,
> > > > > > > >
> > > > > > > > This patchset adds support for using FF-A notifications as a =
delivery
> > > > > > > > mechanism of asynchronous notifications from OP-TEE running i=
n the secure
> > > > > > > > world. Support for asynchronous notifications via the SMC ABI=
 was added in
> > > > > > > > [1], here we add the counterpart needed when using the the FF=
-A ABI.
> > > > > > > >
> > > > > > > > Support for FF-A notifications is added with [2] and this pat=
ch set is based
> > > > > > > > on Sudeeps tree at [3].
> > > > > > >
> > > > > > > It's good to see FF-A notifications support coming through. The=
 good
> > > > > > > aspect here is that FF-A uses a common secure world SGI for
> > > > > > > notifications and doesn't have to deal with platform specific r=
eserved
> > > > > > > SPI for notifications.
> > > > > > >
> > > > > > > From OP-TEE point of view I think most of the secure SGI donati=
on base
> > > > > > > would be common, so can we switch the SMC ABI to use this donat=
ed
> > > > > > > secure world SGI for notifications too?
> > > > > >
> > > > > > The SMC ABI driver picks up the interrupt used for notification f=
rom
> > > > > > device-tree, so there's a chance that it just works if a donated =
SGI is
> > > > > > supplied instead. We'll need some changes in the secure world sid=
e of
> > > > > > OP-TEE, but they wouldn't affect the ABI.
> > > > >
> > > > > AFAIK, a secure world donated SGIs doesn't support IRQ mapping via =
DT.
> > > > > The FF-A driver explicitly creates that mapping here [1].
> > > >
> > > > That looks a lot like what platform_get_irq() does via of_irq_get().
> > > >
> > >
> > > There is GIC_SPI or GIC_PPI but nothing like GIC_SGI in DT bindings [1].
> > >
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/include/dt-bindings/interrupt-controller/arm-gic.h
> > >
> > > > > Moreover
> > > > > it's better to detect it via an SMC call rather than hard coded via=
 DT
> > > > > as FF-A driver does.
> > > >
> > > > Typo? I guess you mean that you prefer that way the FF-A driver does =
it
> > > > rather than having it set in the DT.
> > >
> > > Yeah sorry about that. We shouldn't use DT if OP-TEE features are disco=
verable.
> > >
> > > >
> > > > Assuming that you only care about "arm,gic-v3". The SGI will likely
> > > > always be the same so it shouldn't be too hard to keep the correct
> > > > configuration in DT.
> > >
> > > See above, DT looks like it does not support SGI.
> >
> > You're right.
> >
> > >
> > > >
> > > > >
> > > > > So the ABI should dynamically detect if there is a donated SGI then
> > > > > use it otherwise fallback to SPI/PPI detection via DT. This would m=
ake
> > > > > the notifications feature platform agnostic and we can drop legacy =
DT
> > > > > methods from optee-os entirely but still need to maintain them in t=
he
> > > > > kernel for backwards compatibility.
> > > >
> > > > We care about compatibility in both directions so we'd need to keep it
> > > > in OP-TEE too, but perhaps under a config flag.
> > >
> > > Isn't it just supported on Qemu right now in OP-TEE? I hope dropping a
> > > feature won't be a problem there compared with the maintenance burden.
> >
> > I'd rather not remove this since I believe it can support more
> > configurations (different interrupt controllers), but feel free to
> > propose a patch with the new ABI.
>
> Having a second thought here, I think adding further ABIs (redundant
> ABIs become maintenance burden overtime) don't make sense until we see
> real users of notifications. Have you been able to discover real users
> of this asynchronous notifications feature in OP-TEE?

No, not upstream. There have been questions about a feature like this
from time to time in the past and I guess non-trivial interrupt
handling will soon need it.

Cheers,
Jens

>
> -Sumit
>
> >
> > Cheers,
> > Jens
> >
> > >
> > > -Sumit
> > >
> > > >
> > > > Thanks,
> > > > Jens
> > > >
> > > > >
> > > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/li=
nux.git/tree/drivers/firmware/arm_ffa/driver.c?h=3Dffa-updates-6.7#n1283
> > > > > [2] https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/li=
nux.git/tree/drivers/firmware/arm_ffa/driver.c?h=3Dffa-updates-6.7#n1275
> > > > >
> > > > > -Sumit
> > > > >
> > > > > >
> > > > > > Cheers,
> > > > > > Jens
> > > > > >
> > > > > > >
> > > > > > > -Sumit
> > > > > > >
> > > > > > > >
> > > > > > > > [1] https://lore.kernel.org/lkml/20211103090255.998070-1-jens=
.wiklander(a)linaro.org/
> > > > > > > > [2] https://lore.kernel.org/linux-arm-kernel/20231005-ffa_v1-=
1_notif-v4-0-cddd3237809c(a)arm.com/
> > > > > > > > [3] https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.ho=
lla/linux.git/tag/?h=3Dffa-updates-6.7
> > > > > > > >     commit bcefd1bf63b1 ("firmware: arm_ffa: Upgrade the driv=
er version to v1.1")
> > > > > > > >
> > > > > > > > Thanks,
> > > > > > > > Jens
> > > > > > > >
> > > > > > > > Jens Wiklander (2):
> > > > > > > >   optee: provide optee_do_bottom_half() as a common function
> > > > > > > >   optee: ffa_abi: add asynchronous notifications
> > > > > > > >
> > > > > > > >  drivers/tee/optee/call.c          | 31 ++++++++++-
> > > > > > > >  drivers/tee/optee/ffa_abi.c       | 91 +++++++++++++++++++++=
+++++++++-
> > > > > > > >  drivers/tee/optee/optee_ffa.h     | 28 ++++++++--
> > > > > > > >  drivers/tee/optee/optee_private.h |  9 ++-
> > > > > > > >  drivers/tee/optee/smc_abi.c       | 36 ++----------
> > > > > > > >  5 files changed, 153 insertions(+), 42 deletions(-)
> > > > > > > >
> > > > > > > >
> > > > > > > > base-commit: bcefd1bf63b1ec9bb08067021cf47f0fad96f395
> > > > > > > > --
> > > > > > > > 2.34.1
> > > > > > > >

--===============3082207501693789233==--

