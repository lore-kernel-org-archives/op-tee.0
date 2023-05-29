From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v9 3/4] tee: optee: support tracking system threads
Date: Mon, 29 May 2023 12:41:17 +0530
Message-ID: 
 <CAFA6WYOFaSHHRhNbeuwjLMtCRhGt4edMyeSD1841E3xzS-ETag@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3CPAXPR10MB46872AD9A798A1B7DAF4721DFD469=40PAXPR10MB?=
 =?utf-8?q?4687=2EEURPRD10=2EPROD=2EOUTLOOK=2ECOM=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4427819761336853402=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4427819761336853402==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 26 May 2023 at 01:05, Etienne CARRIERE <etienne.carriere@st.com> wr=
ote:
>
>
> > De: Jens Wiklander <jens.wiklander@linaro.org>
> > Envoy=C3=A9 : jeudi 25 mai 2023 17:20
> >
> > Hi,
> >
> > On Thu, May 25, 2023 at 1:48=E2=80=AFPM Etienne CARRIERE
> > <etienne.carriere@st.com> wrote:>
> > >
> > > >
> > > > De : Sumit Garg <sumit.garg@linaro.org>
> > > > Envoy=C3=A9 : mercredi 24 mai 2023 09:31
> > > > > On Tue, 23 May 2023 at 12:41, Etienne Carriere
> > > > <etienne.carriere@linaro.org> wrote:
> > > > > Hello Sumit,
> > > > >
> > > > >
> > > > > On Wed, 17 May 2023 at 16:33, Sumit Garg <sumit.garg@linaro.org> =
wrote:
> > > > > >
> > > > > > From: Etienne Carriere <etienne.carriere@linaro.org>
> > > > > >
> > > > > > Adds support in the OP-TEE driver to keep track of reserved system
> > > > > > threads. The optee_cq_*() functions are updated to handle this if
> > > > > > enabled. The SMC ABI part of the driver enables this tracking, bu=
t the
> > > > > > FF-A ABI part does not.
> > > > > >
> > > > > > The logic allows atleast 1 OP-TEE thread can be reserved to TEE s=
ystem
> > > > > > sessions. For sake of simplicity, initialization of call queue
> > > > > > management is factorized into new helper function optee_cq_init().
> > > > > >
> > > > > > Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > > > > > Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > > ---
> > > > > >
> > > > > > Disclaimer: Compile tested only
> > > > > >
> > > > > > Hi Etienne,
> > > > > >
> > > > > > Overall the idea we agreed upon was okay but the implementation l=
ooked
> > > > > > complex to me. So I thought it would be harder to explain that via
> > > > > > review and I decided myself to give a try at simplification. I wo=
uld
> > > > > > like you to test it if this still addresses the SCMI deadlock pro=
blem or
> > > > > > not. Also, feel free to include this in your patchset if all goes=
 fine
> > > > > > wrt testing.
> > > > >
> > > > > With these changes, there is no more a specific waiting list for TEE
> > > > > system threads hence when a waiting queue can complete, we'll pick =
any
> > > > > TEE thread, not a TEE system thread first..
> > > >
> > > > I had thought about this but I can't see any value in having a
> > > > separate wait queue for system threads. Here we only need to provide
> > > > an extra privileged thread for system sessions (kernel clients) such
> > > > that user-space doesn't contend for that thread. This prevents kernel
> > > > client's starvation or deadlock like in the SCMI case.
> > > >
> > > > > Also, as stated in a below answer, these change unconditionally
> > > > > reserve a TEE thread for TEE system calls even if no TEE client
> > > > > reserved such.
> > > >
> > > > I don't think we should make thread reservations based on the presence
> > > > of TEE clients. You never know how much user-space or kernel TEE
> > > > clients you are dealing with. And reserving a single privileged thread
> > > > unconditionally for system sessions shouldn't be much of a burden for
> > > > memory constrained devices too.
> > > >
> > > > Also, this way we would enable every kernel TEE client to leverage
> > > > system sessions as it's very likely they wouldn't like to compete with
> > > > user-space for thread availability. Two other kernel TEE clients that
> > > > are on top of my head are HWRNG and Trusted Keys which can benefit
> > > > from this feature.
> > >
> > > Trusted Keys is an interesting use case. When OP-TEE accesses Trusted K=
eys,
> > > it may need to access the eMMC/RPMB using the Linux OS tee-supplicant
> > >  whichj may repuire an eMMC clock or voltage regulator to be enabled.
> > > If that clock or regulator is under an SCMI control, then we need 2
> > > reserved TEE thread: one for invoking the Trusted Key TA and
> > > another for the SCMI request to reach the TEE will the Trusted Key
> > > TA invocation still consumes a thread.

Trusked keys TA doesn't need access to secure storage (eMMC/RPMB). It
only requires a RNG and access to a key derived from HUK.

> > >
> > Why would the Trusted Keys session need a system thread? To me, it
> > seems that the session could use the normal client priority.

The system thread priority as per my patch is nothing but an extra
thread available in the thread pool for kernel clients as compared to
user-space clients.

Trusted keys use-case was really motivated by: "every kernel TEE
client would like to avoid competing with user-space for thread
availability". However, HWRNG has a real case that user-space
shouldn't starve kernel RNG thread for OP-TEE thread availability.

System thread can be useful for trusted keys in case the disk
encryption key is backed by a trusted key.

-Sumit

--===============4427819761336853402==--

