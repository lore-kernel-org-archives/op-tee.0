From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v9 3/4] tee: optee: support tracking system threads
Date: Mon, 29 May 2023 15:47:15 +0530
Message-ID: 
 <CAFA6WYMm43GRGFvWv-5dLiRzfeZyFbDMZewoE0ZU93Wsk6EFpQ@mail.gmail.com>
In-Reply-To: <
 <CAHUa44FCEs6dBG_WJApJkDKKUY+rS+EJM1s_ouCDazbb7vURxg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2088475609985940630=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2088475609985940630==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 29 May 2023 at 15:10, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> On Mon, May 29, 2023 at 9:11=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org=
> wrote:
> >
> > On Fri, 26 May 2023 at 01:05, Etienne CARRIERE <etienne.carriere@st.com=
> wrote:
> > >
> > >
> > > > De: Jens Wiklander <jens.wiklander@linaro.org>
> > > > Envoy=C3=A9 : jeudi 25 mai 2023 17:20
> > > >
> > > > Hi,
> > > >
> > > > On Thu, May 25, 2023 at 1:48=E2=80=AFPM Etienne CARRIERE
> > > > <etienne.carriere@st.com> wrote:>
> > > > >
> > > > > >
> > > > > > De : Sumit Garg <sumit.garg@linaro.org>
> > > > > > Envoy=C3=A9 : mercredi 24 mai 2023 09:31
> > > > > > > On Tue, 23 May 2023 at 12:41, Etienne Carriere
> > > > > > <etienne.carriere@linaro.org> wrote:
> > > > > > > Hello Sumit,
> > > > > > >
> > > > > > >
> > > > > > > On Wed, 17 May 2023 at 16:33, Sumit Garg <sumit.garg@linaro.o=
rg> wrote:
> > > > > > > >
> > > > > > > > From: Etienne Carriere <etienne.carriere@linaro.org>
> > > > > > > >
> > > > > > > > Adds support in the OP-TEE driver to keep track of reserved s=
ystem
> > > > > > > > threads. The optee_cq_*() functions are updated to handle thi=
s if
> > > > > > > > enabled. The SMC ABI part of the driver enables this tracking=
, but the
> > > > > > > > FF-A ABI part does not.
> > > > > > > >
> > > > > > > > The logic allows atleast 1 OP-TEE thread can be reserved to T=
EE system
> > > > > > > > sessions. For sake of simplicity, initialization of call queue
> > > > > > > > management is factorized into new helper function optee_cq_in=
it().
> > > > > > > >
> > > > > > > > Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > > > > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.or=
g>
> > > > > > > > Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > > > > ---
> > > > > > > >
> > > > > > > > Disclaimer: Compile tested only
> > > > > > > >
> > > > > > > > Hi Etienne,
> > > > > > > >
> > > > > > > > Overall the idea we agreed upon was okay but the implementati=
on looked
> > > > > > > > complex to me. So I thought it would be harder to explain tha=
t via
> > > > > > > > review and I decided myself to give a try at simplification. =
I would
> > > > > > > > like you to test it if this still addresses the SCMI deadlock=
 problem or
> > > > > > > > not. Also, feel free to include this in your patchset if all =
goes fine
> > > > > > > > wrt testing.
> > > > > > >
> > > > > > > With these changes, there is no more a specific waiting list fo=
r TEE
> > > > > > > system threads hence when a waiting queue can complete, we'll p=
ick any
> > > > > > > TEE thread, not a TEE system thread first..
> > > > > >
> > > > > > I had thought about this but I can't see any value in having a
> > > > > > separate wait queue for system threads. Here we only need to prov=
ide
> > > > > > an extra privileged thread for system sessions (kernel clients) s=
uch
> > > > > > that user-space doesn't contend for that thread. This prevents ke=
rnel
> > > > > > client's starvation or deadlock like in the SCMI case.
> > > > > >
> > > > > > > Also, as stated in a below answer, these change unconditionally
> > > > > > > reserve a TEE thread for TEE system calls even if no TEE client
> > > > > > > reserved such.
> > > > > >
> > > > > > I don't think we should make thread reservations based on the pre=
sence
> > > > > > of TEE clients. You never know how much user-space or kernel TEE
> > > > > > clients you are dealing with. And reserving a single privileged t=
hread
> > > > > > unconditionally for system sessions shouldn't be much of a burden=
 for
> > > > > > memory constrained devices too.
> > > > > >
> > > > > > Also, this way we would enable every kernel TEE client to leverage
> > > > > > system sessions as it's very likely they wouldn't like to compete=
 with
> > > > > > user-space for thread availability. Two other kernel TEE clients =
that
> > > > > > are on top of my head are HWRNG and Trusted Keys which can benefit
> > > > > > from this feature.
> > > > >
> > > > > Trusted Keys is an interesting use case. When OP-TEE accesses Trust=
ed Keys,
> > > > > it may need to access the eMMC/RPMB using the Linux OS tee-supplica=
nt
> > > > >  whichj may repuire an eMMC clock or voltage regulator to be enable=
d.
> > > > > If that clock or regulator is under an SCMI control, then we need 2
> > > > > reserved TEE thread: one for invoking the Trusted Key TA and
> > > > > another for the SCMI request to reach the TEE will the Trusted Key
> > > > > TA invocation still consumes a thread.
> >
> > Trusked keys TA doesn't need access to secure storage (eMMC/RPMB). It
> > only requires a RNG and access to a key derived from HUK.
>
> Because it's always compiled as an early TA so no rollback protection is us=
ed?
>

Yeah it has to be compiled as an early TA to support Trusted Keys
use-cases. BTW, we don't have enumeration support for REE-FS TAs at
the moment.

> >
> > > > >
> > > > Why would the Trusted Keys session need a system thread? To me, it
> > > > seems that the session could use the normal client priority.
> >
> > The system thread priority as per my patch is nothing but an extra
> > thread available in the thread pool for kernel clients as compared to
> > user-space clients.
> >
> > Trusted keys use-case was really motivated by: "every kernel TEE
> > client would like to avoid competing with user-space for thread
> > availability". However, HWRNG has a real case that user-space
> > shouldn't starve kernel RNG thread for OP-TEE thread availability.
> >
> > System thread can be useful for trusted keys in case the disk
> > encryption key is backed by a trusted key.
>
> With well-behaving TAs every TEE client will get its thread in due time.

We should try to keep distinction among user-space clients vs kernel
clients rather than keeping them in the same bucket. The kernel
clients are more privileged than user-space ones. This is similar
hardening as we have done with respect to session login method (REE
kernel login).

>
> The system thread feature was originally intended as a way of avoiding
> a deadlock.

That's true but doing so can also benefit other (mutual independent)
kernel clients as well.

> So far we have otherwise assigned threads on a first-come
> first-served basis. If we now also need a way of giving priority to
> kernel clients for less critical reasons we may need to take a step
> back and redesign because reserving a thread for each kernel client
> doesn't scale.

No, please have a relook at this patch. We have *only* reserved a
single thread for all the allowed (sess->use_sys_thread =3D true) kernel
clients to compete for. And user-space has access to all the other
threads on a first-come first-served basis except the one thread
reserved for kernel clients.

-Sumit

>
> Thanks,
> Jens

--===============2088475609985940630==--

