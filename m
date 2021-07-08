From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 0/7] Asynchronous notifications from secure world
Date: Thu, 08 Jul 2021 18:26:30 +0530
Message-ID: 
 <CAFA6WYNF_GkRiqn+H5UO6O4ZEkZ16xO=JkV6LOvgvvaVqwFtxw@mail.gmail.com>
In-Reply-To: <20210707175123.xdotr3lsy3e32plm@bogus>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1399844137566165095=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1399844137566165095==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Sudeep,

On Wed, 7 Jul 2021 at 23:22, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Hi Sumit,
>
> I was holding off you reply as I didn't have all the background on this.
> Achin did mention that this is preparatory work for FFA notifications.
> I did mention to him that this is more than that, it is custom extension
> to address what FF-A notification is trying to in standard way.
>
> I share same opinion as Marc Z.
>
> On Wed, Jul 07, 2021 at 11:22:23AM +0530, Sumit Garg wrote:
> > On Tue, 6 Jul 2021 at 18:16, Marc Zyngier <maz@kernel.org> wrote:
>
> [...]
>
> > >
> > > I don't care about OP-TEE. If you are proposing a contract between S
> > > and NS, it has to be TEE and OS independent. That's how the
> > > architecture works.
> > >
> >
> > Agree, here we are not proposing a common contract among the S and NS
> > world that every TEE (based on Arm TrustZone) will use to communicate
> > with REE (Linux in our case) but rather an OP-TEE specific
> > notifications feature that is built on top of OP-TEE specific ABIs.
> >
> > And I can see your arguments coming from an FFA perspective but there
> > are platforms like the ones based on Armv7 which don't support FFA
> > ABI. Maybe Jens can elaborate how this feature will fit in when FFA
> > comes into picture?
> >
>
> I can understand that but won't those platforms add the support both in
> the kernel(current series) and secure world to address notifications.

Agree.

> While you could argue that it is small extension to what is already present
> but I prefer they support FF-A is they need such a support instead of adding
> custom mechanisms. It is hard to maintain and each vendor will deviate
> from this custom mechanism and soon we will have bunch of them to handle.
>

I haven't had a deep dive into FF-A spec, maybe you can clarify on the
following queries regarding Armv7 compatibility:
- As you may be aware, secure monitor implementation on Armv7 is
tightly coupled to trusted OS (part of the same code base), so would
you like each trusted OS vendor to implement a common FF-A interface?
- IIRC, FF-A spec has the notion of multiple secure partitions, are
those supported on Armv7? If yes then how?

> > > > >
> > > > > In general, cross world SGIs are a really bad idea. Yes, some people
> > > > > like them. I still think they are misguided, and I don't intend to
> > > > > provide a generic request interface for this.
> > > >
> > > > Okay, as I mentioned above having it specific to OP-TEE driver
> > > > requesting secure world donated SGI would work for you?
> > >
> > > No. I want a proper architecture between secure and non-secure that
> > > explain how messages are conveyed between the two world, how
> > > signalling is done, how CPU PM is handled, how targeting is
> > > negotiated. And at the end of the day, this is starting to look a lot
> > > like FFA.
> >
> > AFAIK when FFA comes in picture than OP-TEE will use the standard
> > interface provided by FFA ABIs but if FFA isn't supported by a
> > particular platform (eg. based on Armv7) then we need to rely on TEE
> > specific ABI like what OP-TEE currently provides:
> >
>
> Who are asking for this ? Can we ask them to migrate to FF-A if this
> (new) notification support is needed on their platforms ? It is help to
> know the requesters so that they can be included in FF-A spec discussions.
>

I would let Jens answer that.

> > > that. You'll even get to keep the pieces once it breaks. But if you
> > > are going to invent a new universal way of signalling things across
> > > world, you'd better start specifying things the right way, taking into
> > > considerations systems where the interrupt controller doesn't allow
> > > cross-world signalling.
> >
> > As I mentioned above, this patch-set adds an OP-TEE specific
> > notifications feature. AFAIK, the interrupt controllers supported by
> > OP-TEE (GICv2, GICv3 etc.) don't restrict cross-world signaling.
> >
> > So given the explanation above, if you still think requesting an SGI
> > as an IRQ by drivers isn't allowed then I am fine with the approach
> > that Jens has already implemented in this patch-set to use platform
> > specific SPI.
> >
>
> And I assume these platforms in question have SPI to spare and way to
> trigger it from secure world ?
>

Yeah, that is the requirement on the platform if we rely on SPI (Qemu
test example [1]) which wouldn't be the case if we use secure world
donated SGI.

BTW, is this notification mechanism discussed in the case of FF-A? If
yes, can you throw some light on that?

[1] https://github.com/jenswi-linaro/optee_os/commit/9007f8184deb9b7995da8d59=
0779cb3ba2783394

-Sumit

> --
> Regards,
> Sudeep

--===============1399844137566165095==--

