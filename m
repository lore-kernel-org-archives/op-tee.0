From: Marc Zyngier <maz@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 0/7] Asynchronous notifications from secure world
Date: Tue, 06 Jul 2021 13:46:12 +0100
Message-ID: <87a6mz8vaj.wl-maz@kernel.org>
In-Reply-To: <
 <CAFA6WYPVA5yP3trumfz=_oXzxKtfobQXRzDwZ1og8UXwaA1rkQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1211834006106700946=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1211834006106700946==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Sumit,

On Tue, 06 Jul 2021 12:39:13 +0100,
Sumit Garg <sumit.garg@linaro.org> wrote:
> 
> Hi Marc,
> 
> On Tue, 6 Jul 2021 at 16:06, Marc Zyngier <maz@kernel.org> wrote:
> >
> > On Tue, 06 Jul 2021 08:25:26 +0100,
> > Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > I could recognise it's requirement from the time while I was playing
> > > with secure timer interrupt support for OP-TEE RNG driver on
> > > Developerbox. In that case I had to strip down the secure interrupt
> > > handler to a minimum that would just collect entropy and dump into the
> > > secure buffer. But with asynchronous notifications support, I could
> > > add more functionality like entropy health tests in the bottom half
> > > instead of doing those health tests while retrieving entropy from the
> > > secure world.
> > >
> > > Given that, have you explored the possibility to leverage SGI rather
> > > than a platform specific SPI for notifying the normal world? If it's
> > > possible to leverage Architecture specific SGI for this purpose then I
> >
> > What does "Architecture specific SGI" mean?
> >
> 
> Here I meant that SGI is specific to Arm architecture and doesn't
> require to be specific to per platform like an SPI.

SGIs are, by definition *software* specific (the clue is in the name),
and the architecture spec has *zero* say into what they are used for.
It says even less when it comes to specifying cross-world signalling.

> 
> > > think this feature will come automatically enabled for every platform
> > > without the need to reserve a platform specific SPI.
> >
> > That old chestnut again...
> 
> Okay, can you provide reference to earlier threads?

They show up every other year. Lore is your friend.

> 
> >
> > - How do you discover that the secure side has graced you with a
> >   Group-1 SGI (no, you can't use one of the first 8)? for both DT and
> >   ACPI?
> 
> I think the secure world can be probed

How? With what guarantees?

> for that during the OP-TEE driver probe.

Oh, so it is only for the benefit of a single driver?

> And I agree with you that the first 7 SGIs are already
> pre-occupied and I guess you remember mine patch-set that tried to
> leverage 8th SGI as pseudo NMI for kernel debug purposes.

I do remember, and I'm definitely not keen on spending this last SGI
on this feature.

> So yes for this use-case, the secure world can reserve one of the
> latter 8 SGIs (8 to 15) for cross world notification and I guess your
> earlier work to make SGIs to be requested as normal IRQs should make
> it easier to implement this as well.
>
> >
> > - How do you find which CPUs are targeted by this SGI? All? One? A
> >   subset? What is the expected behaviour with CPU hotplug? How can the
> >   NS side (Linux) can inform the secure side about the CPUs it wants
> >   to use?
> 
> For the current OP-TEE use-case, I think targeting all CPUs would be
> efficient.

Efficient? How? Broadcast? One of N? Random?

> So wouldn't it be possible for the CPU which receives the
> secure interrupt to raise that SGI to self that would in turn notify
> the normal world (Linux) to create a thread for OP-TEE to do bottom
> half processing?

You are assuming that this is the way the NS side wants to work, and I
question this assumption.

> 
> >
> > - Is there any case where you would instead need a level interrupt
> >   (which a SGI cannot provide)?
> 
> I think SGI should be sufficient to suffice OP-TEE notifications use-case.

I don't care about OP-TEE. If you are proposing a contract between S
and NS, it has to be TEE and OS independent. That's how the
architecture works.

> >
> > In general, cross world SGIs are a really bad idea. Yes, some people
> > like them. I still think they are misguided, and I don't intend to
> > provide a generic request interface for this.
> 
> Okay, as I mentioned above having it specific to OP-TEE driver
> requesting secure world donated SGI would work for you?

No. I want a proper architecture between secure and non-secure that
explain how messages are conveyed between the two world, how
signalling is done, how CPU PM is handled, how targeting is
negotiated. And at the end of the day, this is starting to look a lot
like FFA.

If you want a custom OP-TEE hack, you don't need my blessing for
that. You'll even get to keep the pieces once it breaks. But if you
are going to invent a new universal way of signalling things across
world, you'd better start specifying things the right way, taking into
considerations systems where the interrupt controller doesn't allow
cross-world signalling.

	M.

-- 
Without deviation from the norm, progress is not possible.

--===============1211834006106700946==--

