From: Gyorgy Szing <Gyorgy.Szing@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: RE: [PATCH] tee: Add Arm FF-A TEE driver
Date: Tue, 17 May 2022 17:55:47 +0000
Message-ID: <AS8PR08MB5895E2E79F48D5CBF939C45391CE9@AS8PR08MB5895.eurprd08.prod.outlook.com>
In-Reply-To: <
 <CAFA6WYMCTn-YQrA-GixYu6OG8Qr_xsZ7xuk4LfFA-1PHgus3RQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6864987145069394388=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6864987145069394388==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Sumit Garg <sumit.garg@linaro.org>
> Sent: 27 April 2022 15:36
> To: Sudeep Holla <Sudeep.Holla@arm.com>
> Cc: linux-kernel(a)vger.kernel.org; op-tee(a)lists.trustedfirmware.org
> Subject: Re: [PATCH] tee: Add Arm FF-A TEE driver
>=20
> On Tue, 26 Apr 2022 at 20:15, Sudeep Holla <sudeep.holla@arm.com>
> wrote:
> >
> > On Fri, Apr 22, 2022 at 12:29:26PM +0530, Sumit Garg wrote:
> > > Hi Sudeep,
> > >
> > > On Fri, 8 Apr 2022 at 19:11, Sudeep Holla <sudeep.holla@arm.com>
> wrote:
> > > >
> > > > The Arm FF-A provides mechanism for Linux kernel and modules to
> > > > communicate with the secure partitions. This is useful for some
> > > > Trusted-OS driver that are kernel resident or modules.
> > > >
> > > > We would also like to avoid adding kernel drivers to communicate
> > > > with each and every service provided by these secure partitions.
> > > > In order to achieve the same with FF-A, it would be better to
> > > > provide user-space interface to access the FF-A functionalities.
> > > > TEE subsystem seems to be the best suited to meet those
> > > > requirements without having to create a new solution custom to FF-A
> alone.
> > >
> > > Yeah, this interface sounds interesting.
> > >
> >
> > Good to hear that.
> >
> > > >
> > > > All FF-A partitions that user-space access can be associated with
> > > > this new FF-A TEE driver and represented by a single TEE device.
> > > > Though the various secure services are generally distributed
> > > > across multiple secure partitions, all of these can be made
> > > > accessible through this single FF-A TEE device.
> > > >
> > > > The minimal functionality needed by the user space application is
> > > > implemented, namely:
> > > >  - Query all partition IDs for a specific FF-A UUID
> > > >  - Sending synchronous message to a partition
> > > >  - Share/unshare buffer with the partition
> > > >
> > >
> > > Are there any corresponding user-space applications/libraries
> > > available to get hands-on with this interface?
> > >
> >
> > Not sure if the changes to make use of this new interface is publicly
> > available yet as these APIs are subject to change. I will see if
> > something can be shared, but this is the project[2] I am using to test
> > with relevant changes to use these TEE APIs.
> >
>=20
> AFAIR, there is a concept of trusted services being launched by OP-TEE as
> well [1]. Is it the environment you are testing this interface with?
>=20
> [1] https://developer.trustedfirmware.org/w/trusted-services/op-tee-spmc/

Hi Sumit,

The best way to test the driver is to use the PSA SPs from Trusted Services s=
imilarly as described on the wiki page above. We have merged the TEE driver e=
nablement patches to integration branch of TS recently, and as a result the s=
et-up and build instructions above will build an end-to-end config using the =
TEE driver.
The TEE driver integration needs to be changed though. Instead of building th=
e TEE driver as an out of tree module from our fork [2], you might want to ch=
ange the config to use the driver posted by Sudeep. If you wish to use the op=
-tee build flow, the makefiles in OP-TEE/build repo part of the above set-up =
need modification too.
TS will build multiple test executables targeting the Linux user-space. For T=
EE driver testing any of these targeting the "arm-linux" environment will do,=
 but I suggest using the "ts-service-test".

AFAIK Sudeep is testing with TS too using a similar set-up.

[2] https://gitlab.arm.com/linux-arm/linux-trusted-services

/George=20

>=20
> > > > Cc: Jens Wiklander <jens.wiklander@linaro.org>
> > > > Cc: Sumit Garg <sumit.garg@linaro.org>
> > > > Co-developed-by: Balint Dobszay <balint.dobszay@arm.com>
> > > > Signed-off-by: Balint Dobszay <balint.dobszay@arm.com>
> > > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > > ---
> > > >  drivers/tee/Kconfig                       |   1 +
> > > >  drivers/tee/Makefile                      |   1 +
> > > >  drivers/tee/arm_ffa_tee/Kconfig           |  15 +
> > > >  drivers/tee/arm_ffa_tee/Makefile          |   6 +
> > > >  drivers/tee/arm_ffa_tee/core.c            | 460 ++++++++++++++++++++=
++
> > > >  drivers/tee/arm_ffa_tee/ffa_tee_private.h |  39 ++
> > > >  drivers/tee/arm_ffa_tee/shm_pool.c        |  94 +++++
> > > >  drivers/tee/arm_ffa_tee/ts_msg.c          | 133 +++++++
> > > >  drivers/tee/arm_ffa_tee/ts_msg.h          |  75 ++++
> > > >  include/uapi/linux/arm_ffa_tee.h          | 116 ++++++
> > > >  include/uapi/linux/tee.h                  |   1 +
> > > >  11 files changed, 941 insertions(+)  create mode 100644
> > > > drivers/tee/arm_ffa_tee/Kconfig  create mode 100644
> > > > drivers/tee/arm_ffa_tee/Makefile  create mode 100644
> > > > drivers/tee/arm_ffa_tee/core.c  create mode 100644
> > > > drivers/tee/arm_ffa_tee/ffa_tee_private.h
> > > >  create mode 100644 drivers/tee/arm_ffa_tee/shm_pool.c
> > > >  create mode 100644 drivers/tee/arm_ffa_tee/ts_msg.c  create mode
> > > > 100644 drivers/tee/arm_ffa_tee/ts_msg.h  create mode 100644
> > > > include/uapi/linux/arm_ffa_tee.h
> > > >
> > > > Hi All,
> > > >
> > > > This is the initial version of FF-A TEE driver to get the feedback
> > > > on the overall design/approach.
> > > >
> > > > Few TODOs I plan to do before we finalise:
> > > > 1. Need to decouple the driver from few Trusted Service protocols
> currently
> > > >    implemented. I have WIP, but couldn't get all the tests working(ye=
t to
> > > >    figure out whether the issue is in driver or tests themselves). Ju=
st
> > > >    posting it as is to get initial feedback on other areas.
> > >
> > > Yes I would be in favor of this.
> > >
> >
> > I am too, but Balint had some concerns which I need to discuss with him
> yet.
> >
> > > >
> > > > 2. Based on the way FF-A spec changes/discussions, does it make sense
> to
> > > >    make search based on UUID + partitionID instead of just partitionI=
D or
> > > >    leave that for userspace.
> > >
> > > IIUC, the UUID is the one identifying the trusted service. So what
> > > purpose does partionID solves for user-space program?
> > >
> >
> > Sorry for not giving complete picture here. In the context of FF-A and
> > secure partitions, there were discussions to allow single partition
> > implementing multiple services/protocols(each associated with UUID)
> > and on a system with multiple SPs, 2 different SPs can be implementing
> same protocol/service.
> > Sorry if I am missing something here or if that is impossible, this is
> > just my understanding and hence I was check if UUID + something(vm_id
> > as per FF-A
> > spec) need to be used to identify which partition and service we would
> > want to talk to.
> >
>=20
> Okay, I see this explanation coming from FF-A spec but currently FF-A bus in
> the kernel only enumerates secure partitions via UUIDs only. I guess that
> needs to change first.
>=20
> -Sumit
>=20
> > > >
> > > > 3. While I definitely want to move the protocol specifics from the dr=
iver
> > > >    (as mentioned in (1)), do we even try to remove adding UUID of each
> service
> > > >    we would like to use this driver.
> > >
> > > Yes, we shouldn't hardcode any UUIDs for trusted services within the
> > > driver (it isn't scalable) but rather during open sessions we should
> > > search if a particular UUID is available on FF-A bus to communicate
> > > with?
> > >
> >
> > Yes it is not scalable and I am aware of that. I haven't explored the
> > options to get rid of them yet. Thanks for the suggestion.
> >
> > > >    I haven't thought through that yet,
> > > >    but the idea I have is to just have a blocked UUID list which can
> > > >    contain UUID for OPTEE and other in-kernel users.
> > > >    That may need changes in FF-A bus match but something to consider ?
> > > >
> > >
> > > Currently in the case of OP-TEE we depend on an open session login
> > > method where the particular trusted application decides whether a
> > > particular login method is allowed or not, refer here [1] for more
> > > details. I guess similar access control checks can be implemented by
> > > a particular trusted service during an open session. This will allow
> > > us to not maintain any allowed or blocked list.
> > >
> >
> > Thanks for the details, I will explore and see how we can use
> > something similar. I will ping you if I get stuck or need more info or
> > need more discussion on that.
> >
> > --
> > Regards,
> > Sudeep
> >
> > [2] https://git.trustedfirmware.org/TS/trusted-services.git
> >

--===============6864987145069394388==--

