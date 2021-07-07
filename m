From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 0/7] Asynchronous notifications from secure world
Date: Wed, 07 Jul 2021 18:51:23 +0100
Message-ID: <20210707175123.xdotr3lsy3e32plm@bogus>
In-Reply-To: <
 <CAFA6WYMsjxYBw_0xzWMtHf=LtXzG+D113WSFuHCR7KhC1RuWYg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7707200469853668487=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7707200469853668487==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Sumit,

I was holding off you reply as I didn't have all the background on this.
Achin did mention that this is preparatory work for FFA notifications.
I did mention to him that this is more than that, it is custom extension
to address what FF-A notification is trying to in standard way.

I share same opinion as Marc Z.

On Wed, Jul 07, 2021 at 11:22:23AM +0530, Sumit Garg wrote:
> On Tue, 6 Jul 2021 at 18:16, Marc Zyngier <maz@kernel.org> wrote:

[...]

> >
> > I don't care about OP-TEE. If you are proposing a contract between S
> > and NS, it has to be TEE and OS independent. That's how the
> > architecture works.
> >
> 
> Agree, here we are not proposing a common contract among the S and NS
> world that every TEE (based on Arm TrustZone) will use to communicate
> with REE (Linux in our case) but rather an OP-TEE specific
> notifications feature that is built on top of OP-TEE specific ABIs.
> 
> And I can see your arguments coming from an FFA perspective but there
> are platforms like the ones based on Armv7 which don't support FFA
> ABI. Maybe Jens can elaborate how this feature will fit in when FFA
> comes into picture?
>

I can understand that but won't those platforms add the support both in
the kernel(current series) and secure world to address notifications.
While you could argue that it is small extension to what is already present
but I prefer they support FF-A is they need such a support instead of adding
custom mechanisms. It is hard to maintain and each vendor will deviate
from this custom mechanism and soon we will have bunch of them to handle.

> > > >
> > > > In general, cross world SGIs are a really bad idea. Yes, some people
> > > > like them. I still think they are misguided, and I don't intend to
> > > > provide a generic request interface for this.
> > >
> > > Okay, as I mentioned above having it specific to OP-TEE driver
> > > requesting secure world donated SGI would work for you?
> >
> > No. I want a proper architecture between secure and non-secure that
> > explain how messages are conveyed between the two world, how
> > signalling is done, how CPU PM is handled, how targeting is
> > negotiated. And at the end of the day, this is starting to look a lot
> > like FFA.
> 
> AFAIK when FFA comes in picture than OP-TEE will use the standard
> interface provided by FFA ABIs but if FFA isn't supported by a
> particular platform (eg. based on Armv7) then we need to rely on TEE
> specific ABI like what OP-TEE currently provides:
>

Who are asking for this ? Can we ask them to migrate to FF-A if this
(new) notification support is needed on their platforms ? It is help to
know the requesters so that they can be included in FF-A spec discussions.

> > that. You'll even get to keep the pieces once it breaks. But if you
> > are going to invent a new universal way of signalling things across
> > world, you'd better start specifying things the right way, taking into
> > considerations systems where the interrupt controller doesn't allow
> > cross-world signalling.
> 
> As I mentioned above, this patch-set adds an OP-TEE specific
> notifications feature. AFAIK, the interrupt controllers supported by
> OP-TEE (GICv2, GICv3 etc.) don't restrict cross-world signaling.
> 
> So given the explanation above, if you still think requesting an SGI
> as an IRQ by drivers isn't allowed then I am fine with the approach
> that Jens has already implemented in this patch-set to use platform
> specific SPI.
>

And I assume these platforms in question have SPI to spare and way to
trigger it from secure world ?

-- 
Regards,
Sudeep

--===============7707200469853668487==--

