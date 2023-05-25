From: Etienne CARRIERE <etienne.carriere@st.com>
To: op-tee@lists.trustedfirmware.org
Subject: RE: [PATCH v9 3/4] tee: optee: support tracking system threads
Date: Thu, 25 May 2023 19:35:01 +0000
Message-ID: <PAXPR10MB46872AD9A798A1B7DAF4721DFD469@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <
 <CAHUa44FDs-cukERVwev88i855Y-ZaAkLUt=bVxah=GdW+JKVLQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3364615172441489633=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3364615172441489633==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


> De: Jens Wiklander <jens.wiklander@linaro.org>
> Envoy=C3=A9 : jeudi 25 mai 2023 17:20
>
> Hi,
>
> On Thu, May 25, 2023 at 1:48=E2=80=AFPM Etienne CARRIERE
> <etienne.carriere@st.com> wrote:>
> >
> > >
> > > De : Sumit Garg <sumit.garg@linaro.org>
> > > Envoy=C3=A9 : mercredi 24 mai 2023 09:31
> > > > On Tue, 23 May 2023 at 12:41, Etienne Carriere
> > > <etienne.carriere@linaro.org> wrote:
> > > > Hello Sumit,
> > > >
> > > >
> > > > On Wed, 17 May 2023 at 16:33, Sumit Garg <sumit.garg@linaro.org> wr=
ote:
> > > > >
> > > > > From: Etienne Carriere <etienne.carriere@linaro.org>
> > > > >
> > > > > Adds support in the OP-TEE driver to keep track of reserved system
> > > > > threads. The optee_cq_*() functions are updated to handle this if
> > > > > enabled. The SMC ABI part of the driver enables this tracking, but =
the
> > > > > FF-A ABI part does not.
> > > > >
> > > > > The logic allows atleast 1 OP-TEE thread can be reserved to TEE sys=
tem
> > > > > sessions. For sake of simplicity, initialization of call queue
> > > > > management is factorized into new helper function optee_cq_init().
> > > > >
> > > > > Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > > > > Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > ---
> > > > >
> > > > > Disclaimer: Compile tested only
> > > > >
> > > > > Hi Etienne,
> > > > >
> > > > > Overall the idea we agreed upon was okay but the implementation loo=
ked
> > > > > complex to me. So I thought it would be harder to explain that via
> > > > > review and I decided myself to give a try at simplification. I would
> > > > > like you to test it if this still addresses the SCMI deadlock probl=
em or
> > > > > not. Also, feel free to include this in your patchset if all goes f=
ine
> > > > > wrt testing.
> > > >
> > > > With these changes, there is no more a specific waiting list for TEE
> > > > system threads hence when a waiting queue can complete, we'll pick any
> > > > TEE thread, not a TEE system thread first..
> > >
> > > I had thought about this but I can't see any value in having a
> > > separate wait queue for system threads. Here we only need to provide
> > > an extra privileged thread for system sessions (kernel clients) such
> > > that user-space doesn't contend for that thread. This prevents kernel
> > > client's starvation or deadlock like in the SCMI case.
> > >
> > > > Also, as stated in a below answer, these change unconditionally
> > > > reserve a TEE thread for TEE system calls even if no TEE client
> > > > reserved such.
> > >
> > > I don't think we should make thread reservations based on the presence
> > > of TEE clients. You never know how much user-space or kernel TEE
> > > clients you are dealing with. And reserving a single privileged thread
> > > unconditionally for system sessions shouldn't be much of a burden for
> > > memory constrained devices too.
> > >
> > > Also, this way we would enable every kernel TEE client to leverage
> > > system sessions as it's very likely they wouldn't like to compete with
> > > user-space for thread availability. Two other kernel TEE clients that
> > > are on top of my head are HWRNG and Trusted Keys which can benefit
> > > from this feature.
> >
> > Trusted Keys is an interesting use case. When OP-TEE accesses Trusted Key=
s,
> > it may need to access the eMMC/RPMB using the Linux OS tee-supplicant
> >  whichj may repuire an eMMC clock or voltage regulator to be enabled.
> > If that clock or regulator is under an SCMI control, then we need 2
> > reserved TEE thread: one for invoking the Trusted Key TA and
> > another for the SCMI request to reach the TEE will the Trusted Key
> > TA invocation still consumes a thread.
> >
> Why would the Trusted Keys session need a system thread? To me, it
> seems that the session could use the normal client priority.

I agree. I don't Trusted Key services needs a provisioned TEE system thread.

Etienne

>
> Thanks,
> Jens
>
> > (snip)

ST Restricted

--===============3364615172441489633==--

