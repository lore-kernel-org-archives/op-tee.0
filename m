From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 0/7] Asynchronous notifications from secure world
Date: Tue, 06 Jul 2021 17:09:13 +0530
Message-ID: 
 <CAFA6WYPVA5yP3trumfz=_oXzxKtfobQXRzDwZ1og8UXwaA1rkQ@mail.gmail.com>
In-Reply-To: <87czrv91b2.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8669739426492262569=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8669739426492262569==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Marc,

On Tue, 6 Jul 2021 at 16:06, Marc Zyngier <maz@kernel.org> wrote:
>
> On Tue, 06 Jul 2021 08:25:26 +0100,
> Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > On Thu, 17 Jun 2021 at 11:40, Jens Wiklander <jens.wiklander@linaro.org=
> wrote:
> > >
> > > Hi Sumit,
> > >
> > > On Thu, Jun 17, 2021 at 6:33 AM Sumit Garg <sumit.garg@linaro.org> wr=
ote:
> > > >
> > > > Hi Jens,
> > > >
> > > > On Wed, 16 Jun 2021 at 16:07, Jens Wiklander <jens.wiklander@linaro=
.org> wrote:
> > > > >
> > > > > Hi all,
> > > > >
> > > > > This adds support for asynchronous notifications from OP-TEE in sec=
ure
> > > > > world to the OP-TEE driver. This allows a design with a top half an=
d bottom
> > > > > half type of driver where the top half runs in secure interrupt con=
text and
> > > > > a notifications tells normal world to schedule a yielding call to d=
o the
> > > > > bottom half processing.
> > > > >
> > > > > An interrupt is used to notify the driver that there are asynchrono=
us
> > > > > notifications pending.
> > > > >
> > > >
> > > > It looks like a nice feature. I would like to get hands on with this.
> > > > Can I test this feature on Qemu?
> > >
> > > Absolutely, you can get this into the normal OP-TEE development repo se=
tup with:
> > > repo init -u https://github.com/OP-TEE/manifest.git -m default.xml
> > > repo sync
> > > Update optee_os with
> > > https://github.com/jenswi-linaro/optee_os/tree/async_notif_v2
> > > Update linux with https://github.com/jenswi-linaro/linux-1/tree/async_n=
otif_v2
> > > cd build
> > > make all -j...
> > > make run-only
> > >
> > > If you type anything at the secure console you'll notice how it
> > > changes behaviour once the Linux kernel has booted.
> > >
> >
> > Thanks for sharing instructions as I now got some time to test and
> > deep dive into this feature. It looks like a pretty useful feature to
> > realize interrupt support in the secure world in its true sense. This
> > feature works for me as per your instructions.
> >
> > I could recognise it's requirement from the time while I was playing
> > with secure timer interrupt support for OP-TEE RNG driver on
> > Developerbox. In that case I had to strip down the secure interrupt
> > handler to a minimum that would just collect entropy and dump into the
> > secure buffer. But with asynchronous notifications support, I could
> > add more functionality like entropy health tests in the bottom half
> > instead of doing those health tests while retrieving entropy from the
> > secure world.
> >
> > Given that, have you explored the possibility to leverage SGI rather
> > than a platform specific SPI for notifying the normal world? If it's
> > possible to leverage Architecture specific SGI for this purpose then I
>
> What does "Architecture specific SGI" mean?
>

Here I meant that SGI is specific to Arm architecture and doesn't
require to be specific to per platform like an SPI.

> > think this feature will come automatically enabled for every platform
> > without the need to reserve a platform specific SPI.
>
> That old chestnut again...

Okay, can you provide reference to earlier threads?

>
> - How do you discover that the secure side has graced you with a
>   Group-1 SGI (no, you can't use one of the first 8)? for both DT and
>   ACPI?

I think the secure world can be probed for that during the OP-TEE
driver probe. And I agree with you that the first 7 SGIs are already
pre-occupied and I guess you remember mine patch-set that tried to
leverage 8th SGI as pseudo NMI for kernel debug purposes.

So yes for this use-case, the secure world can reserve one of the
latter 8 SGIs (8 to 15) for cross world notification and I guess your
earlier work to make SGIs to be requested as normal IRQs should make
it easier to implement this as well.

>
> - How do you find which CPUs are targeted by this SGI? All? One? A
>   subset? What is the expected behaviour with CPU hotplug? How can the
>   NS side (Linux) can inform the secure side about the CPUs it wants
>   to use?

For the current OP-TEE use-case, I think targeting all CPUs would be
efficient. So wouldn't it be possible for the CPU which receives the
secure interrupt to raise that SGI to self that would in turn notify
the normal world (Linux) to create a thread for OP-TEE to do bottom
half processing?

>
> - Is there any case where you would instead need a level interrupt
>   (which a SGI cannot provide)?

I think SGI should be sufficient to suffice OP-TEE notifications use-case.

>
> In general, cross world SGIs are a really bad idea. Yes, some people
> like them. I still think they are misguided, and I don't intend to
> provide a generic request interface for this.

Okay, as I mentioned above having it specific to OP-TEE driver
requesting secure world donated SGI would work for you?

-Sumit

>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

--===============8669739426492262569==--

