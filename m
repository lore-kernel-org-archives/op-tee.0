From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 0/7] Asynchronous notifications from secure world
Date: Wed, 07 Jul 2021 08:54:19 +0200
Message-ID: 
 <CAHUa44GEPDYj6A9jOB8sHbbs_mSk1oiREywP6Z8s0vOhbpajpw@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYMsjxYBw_0xzWMtHf=LtXzG+D113WSFuHCR7KhC1RuWYg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7743133993066560623=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7743133993066560623==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 7, 2021 at 7:52 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Tue, 6 Jul 2021 at 18:16, Marc Zyngier <maz@kernel.org> wrote:
> >
[snip]
> > > > - Is there any case where you would instead need a level interrupt
> > > >   (which a SGI cannot provide)?
> > >
> > > I think SGI should be sufficient to suffice OP-TEE notifications use-ca=
se.
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

OP-TEE has one official ABI at the moment, the SMC based one. It's
about to get another one based on FF-A instead. The two ABIs will
never be used at the same time. It's a build time option for the
OP-TEE firmware to either use SMC or FF-A based communication.

The patches I've posted here concern the SMC based ABI. Asynchronous
notification in OP-TEE with a FF-A based ABI will use the notification
framework provided by FF-A instead to implement that counterpart
provided by these patches. So the OP-TEE driver here in the kernel
will use the FF-A framework in the kernel instead of registering an
interrupt handler directly.

Cheers,
Jens

--===============7743133993066560623==--

