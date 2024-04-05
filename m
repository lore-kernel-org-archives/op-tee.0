From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v3 3/3] optee: probe RPMB device using RPMB subsystem
Date: Fri, 05 Apr 2024 13:39:43 +0200
Message-ID: 
 <CAHUa44EeewyqEiW1b8p9mQZYGuRAmCa2R+CpBwLxWxuGvGppVg@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYP_ddmdimC2YF_ZEZfsJQ2OozzYwY=GzLXWVxD8iJ=Sww@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3909524335097731124=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3909524335097731124==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 9:15=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> w=
rote:
>
> On Wed, 3 Apr 2024 at 20:11, Jens Wiklander <jens.wiklander@linaro.org> w=
rote:
> >
> > On Wed, Apr 3, 2024 at 2:58=E2=80=AFPM Sumit Garg <sumit.garg@linaro.or=
g> wrote:
> > >
> > > On Thu, 28 Mar 2024 at 21:39, Jens Wiklander <jens.wiklander@linaro.o=
rg> wrote:
> > > >
> > > > On Fri, Mar 1, 2024 at 11:28=E2=80=AFAM Sumit Garg <sumit.garg@lina=
ro.org> wrote:
> > > > >
> > > > > Hi Jens,
> > > > >
> > > > > On Tue, 27 Feb 2024 at 21:01, Jens Wiklander <jens.wiklander@lina=
ro.org> wrote:
> > > > > >
> > > > > > Adds support in the OP-TEE drivers (both SMC and FF-A ABIs) to pr=
obe and
> > > > > > use an RPMB device via the RPBM subsystem instead of passing the =
RPMB
> > > > >
> > > > > s/RPBM/RPMB/
> > > > >
> > > > > Here are other places too in this patch-set.
> > > > >
> > > > > > frames via tee-supplicant in user space. A fallback mechanism is =
kept to
> > > > > > route RPMB frames via tee-supplicant if the RPMB subsystem isn't
> > > > > > available.
> > > > > >
> > > > > > The OP-TEE RPC ABI is extended to support iterating over all RPMB
> > > > > > devices until one is found with the expected RPMB key already
> > > > > > programmed.
> > > > >
> > > > > I would appreciate it if you could add a link to OP-TEE OS changes =
in
> > > > > the cover-letter although I have found them here [1].
> > > > >
> > > > > [1] https://github.com/jenswi-linaro/optee_os/commits/rpmb_probe/
> > > >
> > > > OK, I'll add a link in the coverletter of the next patch set.
> > > >
> > > > >
> > > > > >
> > > > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > > ---
> > > > > >  drivers/tee/optee/core.c          |  55 +++++++
> > > > > >  drivers/tee/optee/ffa_abi.c       |   7 +
> > > > > >  drivers/tee/optee/optee_private.h |  16 ++
> > > > > >  drivers/tee/optee/optee_rpc_cmd.h |  35 +++++
> > > > > >  drivers/tee/optee/rpc.c           | 233 ++++++++++++++++++++++++=
++++++
> > > > > >  drivers/tee/optee/smc_abi.c       |   6 +
> > > > > >  6 files changed, 352 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > > > > > index 3aed554bc8d8..6b32d3e7865b 100644
> > > > > > --- a/drivers/tee/optee/core.c
> > > > > > +++ b/drivers/tee/optee/core.c
> > > > > > @@ -11,6 +11,7 @@
> > > > > >  #include <linux/io.h>
> > > > > >  #include <linux/mm.h>
> > > > > >  #include <linux/module.h>
> > > > > > +#include <linux/rpmb.h>
> > > > > >  #include <linux/slab.h>
> > > > > >  #include <linux/string.h>
> > > > > >  #include <linux/tee_drv.h>
> > > > > > @@ -80,6 +81,57 @@ void optee_pool_op_free_helper(struct tee_shm_=
pool *pool, struct tee_shm *shm,
> > > > > >         shm->pages =3D NULL;
> > > > > >  }
> > > > > >
> > > > > > +static void optee_rpmb_scan(struct work_struct *work)
> > > > > > +{
> > > > > > +       struct optee *optee =3D container_of(work, struct optee, =
scan_rpmb_work);
> > > > > > +       bool scan_done =3D false;
> > > > > > +       u32 res;
> > > > > > +
> > > > > > +       do {
> > > > > > +               mutex_lock(&optee->rpmb_dev_mutex);
> > > > > > +               /* No need to rescan if we haven't started scanni=
ng yet */
> > > > > > +               optee->rpmb_dev_request_rescan =3D false;
> > > > > > +               mutex_unlock(&optee->rpmb_dev_mutex);
> > > > > > +
> > > > > > +               res =3D optee_enumerate_devices(PTA_CMD_GET_DEVIC=
ES_RPMB);
> > > > > > +               if (res && res !=3D TEE_ERROR_STORAGE_NOT_AVAILAB=
LE)
> > > > >
> > > > > I suppose this hasn't been tested for a negative case since
> > > > > optee_enumerate_devices() won't return this error code (see [2]).
> > > > > However, I would prefer to use GP Client error code:
> > > > > TEEC_ERROR_ITEM_NOT_FOUND here instead.
> > > > >
> > > > > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/tree/drivers/tee/optee/device.c#n43
> > > >
> > > > I prefer TEE_ERROR_STORAGE_NOT_AVAILABLE since that's the code GP says
> > > > a TA should get when storage is unavailable.
> > > > TEEC_ERROR_ITEM_NOT_FOUND is less specific. Anyway, I'll need to
> > > > translate the code in get_devices().
> > >
> > > Okay, that's fair.
> > >
> > > >
> > > >
> > > > >
> > > > > > +                       pr_info("Scanning for RPMB device: res %#=
x\n", res);
> > > > > > +
> > > > > > +               mutex_lock(&optee->rpmb_dev_mutex);
> > > > > > +               /*
> > > > > > +                * If another RPMB device came online while scann=
ing, scan one
> > > > > > +                * more time, unless we have already found an RPB=
M device.
> > > > > > +                */
> > > > > > +               scan_done =3D (optee->rpmb_dev ||
> > > > >
> > > > > I suppose we don't need to check for optee->rpmb_dev here since a
> > > > > successful return from
> > > > > optee_enumerate_devices(PTA_CMD_GET_DEVICES_RPMB) would ensure that
> > > > > the RPMB device has been found.
> > > >
> > > > That makes sense, I'll check the return value instead.
> > > >
> > > > >
> > > > > > +                            !optee->rpmb_dev_request_rescan);
> > > > > > +               optee->rpmb_dev_request_rescan =3D false;
> > > > > > +               optee->rpmb_dev_scan_in_progress =3D !scan_done;
> > > > > > +               mutex_unlock(&optee->rpmb_dev_mutex);
> > > > > > +       } while (!scan_done);
> > > > > > +}
> > > > > > +
> > > > > > +void optee_rpmb_intf_add_rdev(struct rpmb_interface *intf,
> > > > > > +                             struct rpmb_dev *rdev)
> > > > > > +{
> > > > > > +       struct optee *optee =3D container_of(intf, struct optee, =
rpmb_intf);
> > > > > > +       bool queue_work =3D true;
> > > > > > +
> > > > > > +       mutex_lock(&optee->rpmb_dev_mutex);
> > > > > > +       if (optee->rpmb_dev || optee->rpmb_dev_scan_in_progress) {
> > > > >
> > > > > Can we use work_pending() instead of our custom
> > > > > optee->rpmb_dev_scan_in_progress flag?
> > > >
> > > > That seems racy, or am I missing something?
> > > >
> > >
> > > You are right and even work_busy() is documented to provide unreliable
> > > results. So I am rather thinking about just queuing the work and
> > > thereby scanning for devices unconditionally. I suppose the extra
> > > logic to check if we don't try to register duplicate devices can go
> > > under optee_enumerate_devices().
> > >
> > > > >
> > > > > > +               queue_work =3D false;
> > > > > > +               if (optee->rpmb_dev_scan_in_progress)
> > > > > > +                       optee->rpmb_dev_request_rescan =3D true;
> > > > > > +       }
> > > > > > +       if (queue_work)
> > > > > > +               optee->rpmb_dev_scan_in_progress =3D true;
> > > > > > +       mutex_unlock(&optee->rpmb_dev_mutex);
> > > > > > +
> > > > > > +       if (queue_work) {
> > > > > > +               INIT_WORK(&optee->scan_rpmb_work, optee_rpmb_scan=
);
> > > > > > +               schedule_work(&optee->scan_rpmb_work);
> > > > >
> > > > > Can we reuse optee->scan_bus_work rather than introducing a new one=
 here?
> > > >
> > > > No, both may be active at the same time.
> > >
> > > Actually both of them are using system_wq underneath, so it shouldn't
> > > be a problem if both are active at the same time as they can be queued
> > > simultaneously, right?
> >
> > I'm sorry, I don't get it.
> > Are you suggesting to merge optee_rpmb_scan() and optee_bus_scan()?
> > If so, how to tell what to do, that is, if tee-supplicant has become
> > available or of we should scan for RPMB devices?
> > If not, you can only have one callback at a time in a work_struct.
>
> You are right, keep it as it is.
>
> >
> > >
> > > > We'd have to merge
> > > > optee_rpmb_scan() and optee_bus_scan(), but I'm not sure it's worth
> > > > it.
> > > >
> > > > >
> > > > > > +       }
> > > > > > +}
> > > > > > +
> > > > > >  static void optee_bus_scan(struct work_struct *work)
> > > > > >  {
> > > > > >         WARN_ON(optee_enumerate_devices(PTA_CMD_GET_DEVICES_SUPP)=
);
> > > > > > @@ -161,6 +213,7 @@ void optee_release_supp(struct tee_context *c=
tx)
> > > > > >
> > > > > >  void optee_remove_common(struct optee *optee)
> > > > > >  {
> > > > > > +       rpmb_interface_unregister(&optee->rpmb_intf);
> > > > > >         /* Unregister OP-TEE specific client devices on TEE bus */
> > > > > >         optee_unregister_devices();
> > > > > >
> > > > > > @@ -177,6 +230,8 @@ void optee_remove_common(struct optee *optee)
> > > > > >         tee_shm_pool_free(optee->pool);
> > > > > >         optee_supp_uninit(&optee->supp);
> > > > > >         mutex_destroy(&optee->call_queue.mutex);
> > > > > > +       rpmb_dev_put(optee->rpmb_dev);
> > > > > > +       mutex_destroy(&optee->rpmb_dev_mutex);
> > > > > >  }
> > > > > >
> > > > > >  static int smc_abi_rc;
> > > > > > diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_=
abi.c
> > > > > > index ecb5eb079408..befe19ecc30a 100644
> > > > > > --- a/drivers/tee/optee/ffa_abi.c
> > > > > > +++ b/drivers/tee/optee/ffa_abi.c
> > > > > > @@ -7,6 +7,7 @@
> > > > > >
> > > > > >  #include <linux/arm_ffa.h>
> > > > > >  #include <linux/errno.h>
> > > > > > +#include <linux/rpmb.h>
> > > > > >  #include <linux/scatterlist.h>
> > > > > >  #include <linux/sched.h>
> > > > > >  #include <linux/slab.h>
> > > > > > @@ -934,6 +935,7 @@ static int optee_ffa_probe(struct ffa_device =
*ffa_dev)
> > > > > >         optee_cq_init(&optee->call_queue, 0);
> > > > > >         optee_supp_init(&optee->supp);
> > > > > >         optee_shm_arg_cache_init(optee, arg_cache_flags);
> > > > > > +       mutex_init(&optee->rpmb_dev_mutex);
> > > > > >         ffa_dev_set_drvdata(ffa_dev, optee);
> > > > > >         ctx =3D teedev_open(optee->teedev);
> > > > > >         if (IS_ERR(ctx)) {
> > > > > > @@ -955,6 +957,8 @@ static int optee_ffa_probe(struct ffa_device =
*ffa_dev)
> > > > > >         if (rc)
> > > > > >                 goto err_unregister_devices;
> > > > > >
> > > > > > +       optee->rpmb_intf.add_rdev =3D optee_rpmb_intf_add_rdev;
> > > > > > +       rpmb_interface_register(&optee->rpmb_intf);
> > > > > >         pr_info("initialized driver\n");
> > > > > >         return 0;
> > > > > >
> > > > > > @@ -968,6 +972,9 @@ static int optee_ffa_probe(struct ffa_device =
*ffa_dev)
> > > > > >         teedev_close_context(ctx);
> > > > > >  err_rhashtable_free:
> > > > > >         rhashtable_free_and_destroy(&optee->ffa.global_ids, rh_fr=
ee_fn, NULL);
> > > > > > +       rpmb_dev_put(optee->rpmb_dev);
> > > > > > +       mutex_destroy(&optee->rpmb_dev_mutex);
> > > > > > +       rpmb_interface_unregister(&optee->rpmb_intf);
> > > > > >         optee_supp_uninit(&optee->supp);
> > > > > >         mutex_destroy(&optee->call_queue.mutex);
> > > > > >         mutex_destroy(&optee->ffa.mutex);
> > > > > > diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/opte=
e/optee_private.h
> > > > > > index 7a5243c78b55..1e4c33baef43 100644
> > > > > > --- a/drivers/tee/optee/optee_private.h
> > > > > > +++ b/drivers/tee/optee/optee_private.h
> > > > > > @@ -8,6 +8,7 @@
> > > > > >
> > > > > >  #include <linux/arm-smccc.h>
> > > > > >  #include <linux/rhashtable.h>
> > > > > > +#include <linux/rpmb.h>
> > > > > >  #include <linux/semaphore.h>
> > > > > >  #include <linux/tee_drv.h>
> > > > > >  #include <linux/types.h>
> > > > > > @@ -20,11 +21,13 @@
> > > > > >  /* Some Global Platform error codes used in this driver */
> > > > > >  #define TEEC_SUCCESS                   0x00000000
> > > > > >  #define TEEC_ERROR_BAD_PARAMETERS      0xFFFF0006
> > > > > > +#define TEEC_ERROR_ITEM_NOT_FOUND      0xFFFF0008
> > > > > >  #define TEEC_ERROR_NOT_SUPPORTED       0xFFFF000A
> > > > > >  #define TEEC_ERROR_COMMUNICATION       0xFFFF000E
> > > > > >  #define TEEC_ERROR_OUT_OF_MEMORY       0xFFFF000C
> > > > > >  #define TEEC_ERROR_BUSY                        0xFFFF000D
> > > > > >  #define TEEC_ERROR_SHORT_BUFFER                0xFFFF0010
> > > > > > +#define TEE_ERROR_STORAGE_NOT_AVAILABLE 0xF0100003
> > > > > >
> > > > > >  #define TEEC_ORIGIN_COMMS              0x00000002
> > > > > >
> > > > > > @@ -197,6 +200,8 @@ struct optee_ops {
> > > > > >   * @notif:             notification synchronization struct
> > > > > >   * @supp:              supplicant synchronization struct for RPC=
 to supplicant
> > > > > >   * @pool:              shared memory pool
> > > > > > + * @mutex:             mutex protecting @rpmb_dev
> > > > > > + * @rpmb_dev:          current RPMB device or NULL
> > > > > >   * @rpc_param_count:   If > 0 number of RPC parameters to make r=
oom for
> > > > > >   * @scan_bus_done      flag if device registation was already do=
ne.
> > > > > >   * @scan_bus_work      workq to scan optee bus and register opte=
e drivers
> > > > > > @@ -215,9 +220,17 @@ struct optee {
> > > > > >         struct optee_notif notif;
> > > > > >         struct optee_supp supp;
> > > > > >         struct tee_shm_pool *pool;
> > > > > > +       /* Protects rpmb_dev pointer and rpmb_dev_* */
> > > > > > +       struct mutex rpmb_dev_mutex;
> > > > >
> > > > > Given my comments above, do we really need this mutex?
> > > >
> > > > I don't see how we can do without the mutex.
> > >
> > > See if it is possible with the above mentioned approach.
> >
> > I don't follow.
>
> Probably my explanation above to handle complexity within
> optee_enumerate_devices() wasn't clear. Let me try again:
>
> - Schedule optee_enumerate_devices(PTA_CMD_GET_DEVICES_RPMB)
> unconditionally whenever a new RPMB device is registered.
> - While registering OP-TEE devices (TA UUIDs), don't register
> duplicate devices or better make the device pseudo TA to return the
> UUID list only once when RPMB has been discovered successfully.
>
> This would allow us to drop the fragile handling via
> rpmb_dev_scan_in_progress under mutex, right?

I got it now. I'll do that in the v4. Thanks for your patience. :-)

Cheers,
Jens

--===============3909524335097731124==--

