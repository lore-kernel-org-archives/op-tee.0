From: Etienne CARRIERE <etienne.carriere@st.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 0/7] Asynchronous notifications from secure world
Date: Fri, 09 Jul 2021 08:05:57 +0000
Message-ID: <PAXPR10MB4687E737261282B78600272DFD189@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7463881278730641336=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7463881278730641336==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Sudeep and all,

On Wed, 7 Jul 2021 at 19:52, Sudeep Holla <sudeep.holla@arm.com> wrote:
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
> While you could argue that it is small extension to what is already present
> but I prefer they support FF-A is they need such a support instead of adding
> custom mechanisms. It is hard to maintain and each vendor will deviate
> from this custom mechanism and soon we will have bunch of them to handle.


There exist armv7-a platforms that expect OP-TEE notification support and wil=
l not move the FF-A, like the stm32mp15. This platform won't move to FF-A mai=
nly due to the memory cost of the added SPM layer and the device physical con=
straints.
We have a usecase for OP-TEE notification. We're working on the integration o=
f an SCMI server in OP-TEE. SCMI notification is a feature needed is this sco=
pe and it requires OP-TEE async notification means as those proposed here.

This OP-TEE async notif also brings a lot of value in OP-TEE as it allows a O=
P-TEE secure thread (i.e. executing a trusted application service) to gently =
wait on a secure interrupt (as a slow bus transaction completion or many othe=
r usecase) with the CPU relaxed. This support is provided by the proposed ser=
ies. I believe existing device should be able to leverage this OP-TEE feature=
 without needing their OP-TEE to move to the new FF-A interface.

Regards,
Etienne

>
> [...]

ST Restricted

--===============7463881278730641336==--

