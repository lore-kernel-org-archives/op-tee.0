From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 0/7] Asynchronous notifications from secure world
Date: Tue, 20 Jul 2021 08:50:36 +0100
Message-ID: <20210720075036.z2a5lcguu3xp3wqi@bogus>
In-Reply-To: <
 <CAHUa44G2xLn9td88H-n9E3yJ6JUnyGL4vZNj0rwisu2ArngYAw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7094641431719974380=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7094641431719974380==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 20, 2021 at 08:45:59AM +0200, Jens Wiklander wrote:
> On Tue, Jul 13, 2021 at 1:12 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Fri, Jul 09, 2021 at 08:05:57AM +0000, Etienne CARRIERE wrote:
> > > Hello Sudeep and all,
> > >
> > > On Wed, 7 Jul 2021 at 19:52, Sudeep Holla <sudeep.holla@arm.com> wrot=
e:
> > > >
> > > > Hi Sumit,
> > > >
> > > > I was holding off you reply as I didn't have all the background on th=
is.
> > > > Achin did mention that this is preparatory work for FFA notifications.
> > > > I did mention to him that this is more than that, it is custom extens=
ion
> > > > to address what FF-A notification is trying to in standard way.
>
> Are you suggesting that we should use a hybrid implementation with
> FF-A for notifications and keep the rest as is for armv7-a?
>

No I was just mentioning that this patch series addresses notifications from
secure world(optee in this case) which is very similar to what FF-A is trying
to address too.

Anyways, you brought up interesting idea of hybrid model, it would be good if
that is possible and the specification allows for that. I don't think it does
in the current form, may need some amendments to allow that I think.

> > > >
> > > > I share same opinion as Marc Z.
>
> From what I've read in this thread this has mainly been about using
> SGI notification and not whether asynchronous notification from OP-TEE
> on non-FF-A systems is good or bad. I assume Sumit was asking about
> SGI to find out why that wasn't used. This patch set uses SPI.
>

I understand. I was trying(ineffectively) to tell why it is not so trivial
to use SGI and how FF-A is enabling that.

On SPI, so it is expected that platform has SPI available for this ?

> > > >
> > > > On Wed, Jul 07, 2021 at 11:22:23AM +0530, Sumit Garg wrote:
> > > > > On Tue, 6 Jul 2021 at 18:16, Marc Zyngier <maz@kernel.org> wrote:
> > > >
> > > > [...]
> > > >
> > > > > >
> > > > > > I don't care about OP-TEE. If you are proposing a contract betwee=
n S
> > > > > > and NS, it has to be TEE and OS independent. That's how the
> > > > > > architecture works.
> > > > > >
> > > > >
> > > > > Agree, here we are not proposing a common contract among the S and =
NS
> > > > > world that every TEE (based on Arm TrustZone) will use to communica=
te
> > > > > with REE (Linux in our case) but rather an OP-TEE specific
> > > > > notifications feature that is built on top of OP-TEE specific ABIs.
> > > > >
> > > > > And I can see your arguments coming from an FFA perspective but the=
re
> > > > > are platforms like the ones based on Armv7 which don't support FFA
> > > > > ABI. Maybe Jens can elaborate how this feature will fit in when FFA
> > > > > comes into picture?
> > > > >
> > > >
> > > > I can understand that but won't those platforms add the support both =
in
> > > > the kernel(current series) and secure world to address notifications.
> > > > While you could argue that it is small extension to what is already p=
resent
> > > > but I prefer they support FF-A is they need such a support instead of=
 adding
> > > > custom mechanisms. It is hard to maintain and each vendor will deviate
> > > > from this custom mechanism and soon we will have bunch of them to han=
dle.
>
> Regarding deviation, are we still talking about the OP-TEE driver? So
> far I haven't seen any vendor extensions at all in that driver.
>

Yes, I was referring to addition of notification support in both worlds.
I was trying to emphasize that both OPTEE and FF-A needs changes in the
secure world. OPTEE changes could be small compared to starting with FF-A
but it may result in deviation in notification hadling(in both worlds).

> > >
> > > There exist armv7-a platforms that expect OP-TEE notification support a=
nd
> > > will not move the FF-A, like the stm32mp15. This platform won't move to=
 FF-A
> > > mainly due to the memory cost of the added SPM layer and the device phy=
sical
> > > constraints.
> >
> > Fair enough on the use-case and the analysis for not being able to use FF=
-A.
> > As you may already know it doesn't simply this problem. This has been
> > discussed for years and FF-A was assumed to be the solution when FF-A
> > spec work started.
> >
> > > We have a usecase for OP-TEE notification. We're working on the integra=
tion
> > > of an SCMI server in OP-TEE. SCMI notification is a feature needed is t=
his
> > > scope and it requires OP-TEE async notification means as those proposed
> > > here.
> > >
> >
> > I am aware of this use-case, I understand. But I can only share rants
> > which I know doesn't help much.
> >
> > > This OP-TEE async notif also brings a lot of value in OP-TEE as it allo=
ws a
> > > OP-TEE secure thread (i.e. executing a trusted application service) to
> > > gently wait on a secure interrupt (as a slow bus transaction completion=
 or
> > > many other usecase) with the CPU relaxed. This support is provided by t=
he
> > > proposed series. I believe existing device should be able to leverage t=
his
> > > OP-TEE feature without needing their OP-TEE to move to the new FF-A
> > > interface.
> > >
> >
> > While I agree these are nice to have in OPTEE, the timing is just odd.
> >
> > We are trying hard to push FF-A as standard solution to address all such
> > issues that couldn't be solved with OPTEE + DT, now we are back to address
> > the same in parallel to FF-A.
>
> It's not exactly the same since the primary target here is armv7-a
> where introducing FF-A isn't an obvious choice in all cases. For
> OP-TEE armv7-a is special in the way that all secure world processing
> is handled by OP-TEE. The internal secure monitor already takes care
> of what's implemented in TF-A at EL3 for armv8-a.
>

Fair enough.

> This isn't meant to compete with FF-A, it's to make sure that the
> OP-TEE armv7-a user base isn't left behind. This doesn't rule out FF-A
> support for armv7-a for those prepared to take that step.
>

Sure, as long as that is conveyed to the adopters of this, it should be
fine. Do you have plans to disable this feature for armv8-a ? I see that
as safe approach to avoid any kind of conflicts.

I just don't want similar arguments used as excuse on armv8-a.

--
Regards,
Sudeep

--===============7094641431719974380==--

