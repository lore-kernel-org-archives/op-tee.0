From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v9 3/4] tee: optee: support tracking system threads
Date: Mon, 29 May 2023 19:22:49 +0530
Message-ID: 
 <CAFA6WYOhoR1DhbRbw0qGm2-4AL5Ba1BM+Ck3v3TUPsWNwED_Yw@mail.gmail.com>
In-Reply-To: <
 <CAHUa44HBQatvnJ5Nkm=uWmnXX7xx_svjDt5d+fV6sosKAxppSg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0441268916891817390=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0441268916891817390==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 29 May 2023 at 17:53, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> On Mon, May 29, 2023 at 12:17=E2=80=AFPM Sumit Garg <sumit.garg@linaro.or=
g> wrote:
> >
> > On Mon, 29 May 2023 at 15:10, Jens Wiklander <jens.wiklander@linaro.org=
> wrote:
> > >
> > > On Mon, May 29, 2023 at 9:11=E2=80=AFAM Sumit Garg <sumit.garg@linaro=
.org> wrote:
> > > >
> > > > On Fri, 26 May 2023 at 01:05, Etienne CARRIERE <etienne.carriere@st=
.com> wrote:
> > > > >
> > > > >
> > > > > > De: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > > Envoy=C3=A9 : jeudi 25 mai 2023 17:20
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > On Thu, May 25, 2023 at 1:48=E2=80=AFPM Etienne CARRIERE
> > > > > > <etienne.carriere@st.com> wrote:>
> > > > > > >
> > > > > > > >
> > > > > > > > De : Sumit Garg <sumit.garg@linaro.org>
> > > > > > > > Envoy=C3=A9 : mercredi 24 mai 2023 09:31
> > > > > > > > > On Tue, 23 May 2023 at 12:41, Etienne Carriere
> > > > > > > > <etienne.carriere@linaro.org> wrote:
> > > > > > > > > Hello Sumit,
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > On Wed, 17 May 2023 at 16:33, Sumit Garg <sumit.garg@lina=
ro.org> wrote:
> > > > > > > > > >
> > > > > > > > > > From: Etienne Carriere <etienne.carriere@linaro.org>
> > > > > > > > > >
> > > > > > > > > > Adds support in the OP-TEE driver to keep track of reserv=
ed system
> > > > > > > > > > threads. The optee_cq_*() functions are updated to handle=
 this if
> > > > > > > > > > enabled. The SMC ABI part of the driver enables this trac=
king, but the
> > > > > > > > > > FF-A ABI part does not.
> > > > > > > > > >
> > > > > > > > > > The logic allows atleast 1 OP-TEE thread can be reserved =
to TEE system
> > > > > > > > > > sessions. For sake of simplicity, initialization of call =
queue
> > > > > > > > > > management is factorized into new helper function optee_c=
q_init().
> > > > > > > > > >
> > > > > > > > > > Co-developed-by: Jens Wiklander <jens.wiklander@linaro.=
org>
> > > > > > > > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.or=
g>
> > > > > > > > > > Signed-off-by: Etienne Carriere <etienne.carriere@linar=
o.org>
> > > > > > > > > > Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > > > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > > > > > > ---
> > > > > > > > > >
> > > > > > > > > > Disclaimer: Compile tested only
> > > > > > > > > >
> > > > > > > > > > Hi Etienne,
> > > > > > > > > >
> > > > > > > > > > Overall the idea we agreed upon was okay but the implemen=
tation looked
> > > > > > > > > > complex to me. So I thought it would be harder to explain=
 that via
> > > > > > > > > > review and I decided myself to give a try at simplificati=
on. I would
> > > > > > > > > > like you to test it if this still addresses the SCMI dead=
lock problem or
> > > > > > > > > > not. Also, feel free to include this in your patchset if =
all goes fine
> > > > > > > > > > wrt testing.
> > > > > > > > >
> > > > > > > > > With these changes, there is no more a specific waiting lis=
t for TEE
> > > > > > > > > system threads hence when a waiting queue can complete, we'=
ll pick any
> > > > > > > > > TEE thread, not a TEE system thread first..
> > > > > > > >
> > > > > > > > I had thought about this but I can't see any value in having a
> > > > > > > > separate wait queue for system threads. Here we only need to =
provide
> > > > > > > > an extra privileged thread for system sessions (kernel client=
s) such
> > > > > > > > that user-space doesn't contend for that thread. This prevent=
s kernel
> > > > > > > > client's starvation or deadlock like in the SCMI case.
> > > > > > > >
> > > > > > > > > Also, as stated in a below answer, these change uncondition=
ally
> > > > > > > > > reserve a TEE thread for TEE system calls even if no TEE cl=
ient
> > > > > > > > > reserved such.
> > > > > > > >
> > > > > > > > I don't think we should make thread reservations based on the=
 presence
> > > > > > > > of TEE clients. You never know how much user-space or kernel =
TEE
> > > > > > > > clients you are dealing with. And reserving a single privileg=
ed thread
> > > > > > > > unconditionally for system sessions shouldn't be much of a bu=
rden for
> > > > > > > > memory constrained devices too.
> > > > > > > >
> > > > > > > > Also, this way we would enable every kernel TEE client to lev=
erage
> > > > > > > > system sessions as it's very likely they wouldn't like to com=
pete with
> > > > > > > > user-space for thread availability. Two other kernel TEE clie=
nts that
> > > > > > > > are on top of my head are HWRNG and Trusted Keys which can be=
nefit
> > > > > > > > from this feature.
> > > > > > >
> > > > > > > Trusted Keys is an interesting use case. When OP-TEE accesses T=
rusted Keys,
> > > > > > > it may need to access the eMMC/RPMB using the Linux OS tee-supp=
licant
> > > > > > >  whichj may repuire an eMMC clock or voltage regulator to be en=
abled.
> > > > > > > If that clock or regulator is under an SCMI control, then we ne=
ed 2
> > > > > > > reserved TEE thread: one for invoking the Trusted Key TA and
> > > > > > > another for the SCMI request to reach the TEE will the Trusted =
Key
> > > > > > > TA invocation still consumes a thread.
> > > >
> > > > Trusked keys TA doesn't need access to secure storage (eMMC/RPMB). It
> > > > only requires a RNG and access to a key derived from HUK.
> > >
> > > Because it's always compiled as an early TA so no rollback protection i=
s used?
> > >
> >
> > Yeah it has to be compiled as an early TA to support Trusted Keys
> > use-cases. BTW, we don't have enumeration support for REE-FS TAs at
> > the moment.
> >
> > > >
> > > > > > >
> > > > > > Why would the Trusted Keys session need a system thread? To me, it
> > > > > > seems that the session could use the normal client priority.
> > > >
> > > > The system thread priority as per my patch is nothing but an extra
> > > > thread available in the thread pool for kernel clients as compared to
> > > > user-space clients.
> > > >
> > > > Trusted keys use-case was really motivated by: "every kernel TEE
> > > > client would like to avoid competing with user-space for thread
> > > > availability". However, HWRNG has a real case that user-space
> > > > shouldn't starve kernel RNG thread for OP-TEE thread availability.
> > > >
> > > > System thread can be useful for trusted keys in case the disk
> > > > encryption key is backed by a trusted key.
> > >
> > > With well-behaving TAs every TEE client will get its thread in due time.
> >
> > We should try to keep distinction among user-space clients vs kernel
> > clients rather than keeping them in the same bucket. The kernel
> > clients are more privileged than user-space ones. This is similar
> > hardening as we have done with respect to session login method (REE
> > kernel login).
> >
> > >
> > > The system thread feature was originally intended as a way of avoiding
> > > a deadlock.
> >
> > That's true but doing so can also benefit other (mutual independent)
> > kernel clients as well.
> >
> > > So far we have otherwise assigned threads on a first-come
> > > first-served basis. If we now also need a way of giving priority to
> > > kernel clients for less critical reasons we may need to take a step
> > > back and redesign because reserving a thread for each kernel client
> > > doesn't scale.
> >
> > No, please have a relook at this patch. We have *only* reserved a
> > single thread for all the allowed (sess->use_sys_thread =3D true) kernel
> > clients to compete for. And user-space has access to all the other
> > threads on a first-come first-served basis except the one thread
> > reserved for kernel clients.
>
> Thanks, got it now. User space clients may or may not be able to
> starve kernel clients enough to matter. However, if all kernel clients
> only will be guaranteed one thread then we're still stuck with the
> deadlock problem for SCMI. We can't guarantee that none of the kernel
> clients will indirectly access eMMC/RPMB.

I think we should be able to address this via disallowing system
sessions for kernel clients whose devices are probed via
PTA_CMD_GET_DEVICES_SUPP. But I can't find a sane way to enforce this
via code but can be taken care of during review as well.

-Sumit

>
> Cheers,
> Jens
>
> >
> > -Sumit
> >
> > >
> > > Thanks,
> > > Jens

--===============0441268916891817390==--

