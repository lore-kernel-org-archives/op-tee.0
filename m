From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 0/7] Asynchronous notifications from secure world
Date: Wed, 07 Jul 2021 11:22:23 +0530
Message-ID: 
 <CAFA6WYMsjxYBw_0xzWMtHf=LtXzG+D113WSFuHCR7KhC1RuWYg@mail.gmail.com>
In-Reply-To: <87a6mz8vaj.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3032648259426931496=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3032648259426931496==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, 6 Jul 2021 at 18:16, Marc Zyngier <maz@kernel.org> wrote:
>
> Sumit,
>
> On Tue, 06 Jul 2021 12:39:13 +0100,
> Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Hi Marc,
> >
> > On Tue, 6 Jul 2021 at 16:06, Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Tue, 06 Jul 2021 08:25:26 +0100,
> > > Sumit Garg <sumit.garg@linaro.org> wrote:
> > > >
> > > > I could recognise it's requirement from the time while I was playing
> > > > with secure timer interrupt support for OP-TEE RNG driver on
> > > > Developerbox. In that case I had to strip down the secure interrupt
> > > > handler to a minimum that would just collect entropy and dump into the
> > > > secure buffer. But with asynchronous notifications support, I could
> > > > add more functionality like entropy health tests in the bottom half
> > > > instead of doing those health tests while retrieving entropy from the
> > > > secure world.
> > > >
> > > > Given that, have you explored the possibility to leverage SGI rather
> > > > than a platform specific SPI for notifying the normal world? If it's
> > > > possible to leverage Architecture specific SGI for this purpose then I
> > >
> > > What does "Architecture specific SGI" mean?
> > >
> >
> > Here I meant that SGI is specific to Arm architecture and doesn't
> > require to be specific to per platform like an SPI.
>
> SGIs are, by definition *software* specific (the clue is in the name),
> and the architecture spec has *zero* say into what they are used for.
> It says even less when it comes to specifying cross-world signalling.
>

Agree.

> >
> > > > think this feature will come automatically enabled for every platform
> > > > without the need to reserve a platform specific SPI.
> > >
> > > That old chestnut again...
> >
> > Okay, can you provide reference to earlier threads?
>
> They show up every other year. Lore is your friend.
>

Okay.

> >
> > >
> > > - How do you discover that the secure side has graced you with a
> > >   Group-1 SGI (no, you can't use one of the first 8)? for both DT and
> > >   ACPI?
> >
> > I think the secure world can be probed
>
> How? With what guarantees?
>

It can simply be a fast SMC call to OP-TEE to retrieve the SGI to be
used for notification using similar SMC as
OPTEE_SMC_FUNCID_GET_ASYNC_NOTIF_VALUE that Jens has used in this
patch-set.

I am not sure how that would fail as we do maintain backwards
compatibility with prior OP-TEE versions.

> > for that during the OP-TEE driver probe.
>
> Oh, so it is only for the benefit of a single driver?
>

Yeah.

> > And I agree with you that the first 7 SGIs are already
> > pre-occupied and I guess you remember mine patch-set that tried to
> > leverage 8th SGI as pseudo NMI for kernel debug purposes.
>
> I do remember, and I'm definitely not keen on spending this last SGI
> on this feature.

Agree and that's why we allowed that last SGI for debug purposes if it
is not used anywhere else. Let's keep this discussion to the
corresponding patch-set only as otherwise we would unnecessarily
derail discussion for this OP-TEE specific feature.

>
> > So yes for this use-case, the secure world can reserve one of the
> > latter 8 SGIs (8 to 15) for cross world notification and I guess your
> > earlier work to make SGIs to be requested as normal IRQs should make
> > it easier to implement this as well.
> >
> > >
> > > - How do you find which CPUs are targeted by this SGI? All? One? A
> > >   subset? What is the expected behaviour with CPU hotplug? How can the
> > >   NS side (Linux) can inform the secure side about the CPUs it wants
> > >   to use?
> >
> > For the current OP-TEE use-case, I think targeting all CPUs would be
> > efficient.
>
> Efficient? How? Broadcast? One of N? Random?
>

By efficient here I meant that we would enable that SGI for every CPU
rather than a subset so that any CPU which receives a secure interrupt
(PPI or SPI) would be able to raise this SGI to itself in order to
notify Linux to create a thread for OP-TEE.

> > So wouldn't it be possible for the CPU which receives the
> > secure interrupt to raise that SGI to self that would in turn notify
> > the normal world (Linux) to create a thread for OP-TEE to do bottom
> > half processing?
>
> You are assuming that this is the way the NS side wants to work, and I
> question this assumption.
>

Actually this is the way that Jens has implemented notifications among
Linux and OP-TEE using a SPI in this patch-set. The only difference
with SGI is that it's a per CPU interrupt.

> >
> > >
> > > - Is there any case where you would instead need a level interrupt
> > >   (which a SGI cannot provide)?
> >
> > I think SGI should be sufficient to suffice OP-TEE notifications use-case.
>
> I don't care about OP-TEE. If you are proposing a contract between S
> and NS, it has to be TEE and OS independent. That's how the
> architecture works.
>

Agree, here we are not proposing a common contract among the S and NS
world that every TEE (based on Arm TrustZone) will use to communicate
with REE (Linux in our case) but rather an OP-TEE specific
notifications feature that is built on top of OP-TEE specific ABIs.

And I can see your arguments coming from an FFA perspective but there
are platforms like the ones based on Armv7 which don't support FFA
ABI. Maybe Jens can elaborate how this feature will fit in when FFA
comes into picture?

> > >
> > > In general, cross world SGIs are a really bad idea. Yes, some people
> > > like them. I still think they are misguided, and I don't intend to
> > > provide a generic request interface for this.
> >
> > Okay, as I mentioned above having it specific to OP-TEE driver
> > requesting secure world donated SGI would work for you?
>
> No. I want a proper architecture between secure and non-secure that
> explain how messages are conveyed between the two world, how
> signalling is done, how CPU PM is handled, how targeting is
> negotiated. And at the end of the day, this is starting to look a lot
> like FFA.

AFAIK when FFA comes in picture than OP-TEE will use the standard
interface provided by FFA ABIs but if FFA isn't supported by a
particular platform (eg. based on Armv7) then we need to rely on TEE
specific ABI like what OP-TEE currently provides:

1. how messages are conveyed between the two worlds -> OP-TEE specific
ABI (yielding SMC calls).
2. how signalling is done -> OP-TEE specific ABI (fast SMC calls).
3. how CPU PM is handled -> OP-TEE is notified on PSCI CPU ON, OFF and
SUSPEND calls.
4. how targeting is negotiated -> SGI would be targeted to the same
CPU which receives the secure interrupt (PPI or SPI).

>
> If you want a custom OP-TEE hack, you don't need my blessing for
> that. You'll even get to keep the pieces once it breaks. But if you
> are going to invent a new universal way of signalling things across
> world, you'd better start specifying things the right way, taking into
> considerations systems where the interrupt controller doesn't allow
> cross-world signalling.

As I mentioned above, this patch-set adds an OP-TEE specific
notifications feature. AFAIK, the interrupt controllers supported by
OP-TEE (GICv2, GICv3 etc.) don't restrict cross-world signaling.

So given the explanation above, if you still think requesting an SGI
as an IRQ by drivers isn't allowed then I am fine with the approach
that Jens has already implemented in this patch-set to use platform
specific SPI.

-Sumit

>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

--===============3032648259426931496==--

