From: Marc Zyngier <maz@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 0/7] Asynchronous notifications from secure world
Date: Tue, 06 Jul 2021 11:36:17 +0100
Message-ID: <87czrv91b2.wl-maz@kernel.org>
In-Reply-To: <
 <CAFA6WYMSAM2MDOXnhjuZFov3BtF8-nihZRUpR8ciUWsL4_nCWA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3600677364111851752=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3600677364111851752==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 06 Jul 2021 08:25:26 +0100,
Sumit Garg <sumit.garg@linaro.org> wrote:
>=20
> On Thu, 17 Jun 2021 at 11:40, Jens Wiklander <jens.wiklander@linaro.org> =
wrote:
> >
> > Hi Sumit,
> >
> > On Thu, Jun 17, 2021 at 6:33 AM Sumit Garg <sumit.garg@linaro.org> wrot=
e:
> > >
> > > Hi Jens,
> > >
> > > On Wed, 16 Jun 2021 at 16:07, Jens Wiklander <jens.wiklander@linaro.o=
rg> wrote:
> > > >
> > > > Hi all,
> > > >
> > > > This adds support for asynchronous notifications from OP-TEE in secure
> > > > world to the OP-TEE driver. This allows a design with a top half and =
bottom
> > > > half type of driver where the top half runs in secure interrupt conte=
xt and
> > > > a notifications tells normal world to schedule a yielding call to do =
the
> > > > bottom half processing.
> > > >
> > > > An interrupt is used to notify the driver that there are asynchronous
> > > > notifications pending.
> > > >
> > >
> > > It looks like a nice feature. I would like to get hands on with this.
> > > Can I test this feature on Qemu?
> >
> > Absolutely, you can get this into the normal OP-TEE development repo setu=
p with:
> > repo init -u https://github.com/OP-TEE/manifest.git -m default.xml
> > repo sync
> > Update optee_os with
> > https://github.com/jenswi-linaro/optee_os/tree/async_notif_v2
> > Update linux with https://github.com/jenswi-linaro/linux-1/tree/async_not=
if_v2
> > cd build
> > make all -j...
> > make run-only
> >
> > If you type anything at the secure console you'll notice how it
> > changes behaviour once the Linux kernel has booted.
> >
>=20
> Thanks for sharing instructions as I now got some time to test and
> deep dive into this feature. It looks like a pretty useful feature to
> realize interrupt support in the secure world in its true sense. This
> feature works for me as per your instructions.
>=20
> I could recognise it's requirement from the time while I was playing
> with secure timer interrupt support for OP-TEE RNG driver on
> Developerbox. In that case I had to strip down the secure interrupt
> handler to a minimum that would just collect entropy and dump into the
> secure buffer. But with asynchronous notifications support, I could
> add more functionality like entropy health tests in the bottom half
> instead of doing those health tests while retrieving entropy from the
> secure world.
>=20
> Given that, have you explored the possibility to leverage SGI rather
> than a platform specific SPI for notifying the normal world? If it's
> possible to leverage Architecture specific SGI for this purpose then I

What does "Architecture specific SGI" mean?

> think this feature will come automatically enabled for every platform
> without the need to reserve a platform specific SPI.

That old chestnut again...

- How do you discover that the secure side has graced you with a
  Group-1 SGI (no, you can't use one of the first 8)? for both DT and
  ACPI?

- How do you find which CPUs are targeted by this SGI? All? One? A
  subset? What is the expected behaviour with CPU hotplug? How can the
  NS side (Linux) can inform the secure side about the CPUs it wants
  to use?

- Is there any case where you would instead need a level interrupt
  (which a SGI cannot provide)?

In general, cross world SGIs are a really bad idea. Yes, some people
like them. I still think they are misguided, and I don't intend to
provide a generic request interface for this.

	M.

--=20
Without deviation from the norm, progress is not possible.

--===============3600677364111851752==--

