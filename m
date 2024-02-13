From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [Linux-stm32] [PATCH v2 4/4] remoteproc: stm32: Add support of an
 OP-TEE TA to load the firmware
Date: Tue, 13 Feb 2024 11:39:49 -0700
Message-ID: 
 <CANLsYkxvkj4Rx6+hA6yGStROY8FDxRdAh2h4SJc+eqECj-Ew9A@mail.gmail.com>
In-Reply-To: <bdac5637-767e-4310-9ecd-fad5490e9b3c@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6306703676478116738=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6306703676478116738==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Feb 2024 at 08:48, Arnaud POULIQUEN
<arnaud.pouliquen@foss.st.com> wrote:
>
> Hello Mathieu,
>
> On 2/5/24 10:13, Arnaud POULIQUEN wrote:
> >
> >
> > On 2/2/24 20:53, Mathieu Poirier wrote:
> >> On Thu, Feb 01, 2024 at 07:33:35PM +0100, Arnaud POULIQUEN wrote:
> >>>
> >>>
> >>> On 2/1/24 17:02, Mathieu Poirier wrote:
> >>>> On Thu, Feb 01, 2024 at 04:06:37PM +0100, Arnaud POULIQUEN wrote:
> >>>>> hello Mathieu,
> >>>>>
> >>>>> On 1/31/24 19:52, Mathieu Poirier wrote:
> >>>>>> On Tue, Jan 30, 2024 at 10:13:48AM +0100, Arnaud POULIQUEN wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>> On 1/26/24 18:11, Mathieu Poirier wrote:
> >>>>>>>> On Thu, Jan 18, 2024 at 11:04:33AM +0100, Arnaud Pouliquen wrote:
> >>>>>>>>> The new TEE remoteproc device is used to manage remote firmware i=
n a
> >>>>>>>>> secure, trusted context. The 'st,stm32mp1-m4-tee' compatibility is
> >>>>>>>>> introduced to delegate the loading of the firmware to the trusted
> >>>>>>>>> execution context. In such cases, the firmware should be signed a=
nd
> >>>>>>>>> adhere to the image format defined by the TEE.
> >>>>>>>>>
> >>>>>>>>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> >>>>>>>>> ---
> >>>>>>>>> V1 to V2 update:
> >>>>>>>>> - remove the select "TEE_REMOTEPROC" in STM32_RPROC config as det=
ected by
> >>>>>>>>>   the kernel test robot:
> >>>>>>>>>      WARNING: unmet direct dependencies detected for TEE_REMOTEPR=
OC
> >>>>>>>>>      Depends on [n]: REMOTEPROC [=3Dy] && OPTEE [=3Dn]
> >>>>>>>>>      Selected by [y]:
> >>>>>>>>>      - STM32_RPROC [=3Dy] && (ARCH_STM32 || COMPILE_TEST [=3Dy]) =
&& REMOTEPROC [=3Dy]
> >>>>>>>>> - Fix initialized trproc variable in  stm32_rproc_probe
> >>>>>>>>> ---
> >>>>>>>>>  drivers/remoteproc/stm32_rproc.c | 149 +++++++++++++++++++++++++=
++++--
> >>>>>>>>>  1 file changed, 144 insertions(+), 5 deletions(-)
> >>>>>>>>>
> >>>>>>>>> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remotepro=
c/stm32_rproc.c
> >>>>>>>>> index fcc0001e2657..cf6a21bac945 100644
> >>>>>>>>> --- a/drivers/remoteproc/stm32_rproc.c
> >>>>>>>>> +++ b/drivers/remoteproc/stm32_rproc.c
> >>>>>>>>> @@ -20,6 +20,7 @@
> >>>>>>>>>  #include <linux/remoteproc.h>
> >>>>>>>>>  #include <linux/reset.h>
> >>>>>>>>>  #include <linux/slab.h>
> >>>>>>>>> +#include <linux/tee_remoteproc.h>
> >>>>>>>>>  #include <linux/workqueue.h>
> >>>>>>>>>
> >>>>>>>>>  #include "remoteproc_internal.h"
> >>>>>>>>> @@ -49,6 +50,9 @@
> >>>>>>>>>  #define M4_STATE_STANDBY     4
> >>>>>>>>>  #define M4_STATE_CRASH               5
> >>>>>>>>>
> >>>>>>>>> +/* Remote processor unique identifier aligned with the Trusted E=
xecution Environment definitions */
> >>>>>>>>> +#define STM32_MP1_M4_PROC_ID    0
> >>>>>>>>> +
> >>>>>>>>>  struct stm32_syscon {
> >>>>>>>>>       struct regmap *map;
> >>>>>>>>>       u32 reg;
> >>>>>>>>> @@ -90,6 +94,8 @@ struct stm32_rproc {
> >>>>>>>>>       struct stm32_mbox mb[MBOX_NB_MBX];
> >>>>>>>>>       struct workqueue_struct *workqueue;
> >>>>>>>>>       bool hold_boot_smc;
> >>>>>>>>> +     bool fw_loaded;
> >>>>>>>>> +     struct tee_rproc *trproc;
> >>>>>>>>>       void __iomem *rsc_va;
> >>>>>>>>>  };
> >>>>>>>>>
> >>>>>>>>> @@ -257,6 +263,91 @@ static int stm32_rproc_release(struct rproc =
*rproc)
> >>>>>>>>>       return err;
> >>>>>>>>>  }
> >>>>>>>>>
> >>>>>>>>> +static int stm32_rproc_tee_elf_sanity_check(struct rproc *rproc,
> >>>>>>>>> +                                         const struct firmware *=
fw)
> >>>>>>>>> +{
> >>>>>>>>> +     struct stm32_rproc *ddata =3D rproc->priv;
> >>>>>>>>> +     unsigned int ret =3D 0;
> >>>>>>>>> +
> >>>>>>>>> +     if (rproc->state =3D=3D RPROC_DETACHED)
> >>>>>>>>> +             return 0;
> >>>>>>>>> +
> >>>>>>>>> +     ret =3D tee_rproc_load_fw(ddata->trproc, fw);
> >>>>>>>>> +     if (!ret)
> >>>>>>>>> +             ddata->fw_loaded =3D true;
> >>>>>>>>> +
> >>>>>>>>> +     return ret;
> >>>>>>>>> +}
> >>>>>>>>> +
> >>>>>>>>> +static int stm32_rproc_tee_elf_load(struct rproc *rproc,
> >>>>>>>>> +                                 const struct firmware *fw)
> >>>>>>>>> +{
> >>>>>>>>> +     struct stm32_rproc *ddata =3D rproc->priv;
> >>>>>>>>> +     unsigned int ret;
> >>>>>>>>> +
> >>>>>>>>> +     /*
> >>>>>>>>> +      * This function can be called by remote proc for recovery
> >>>>>>>>> +      * without the sanity check. In this case we need to load t=
he firmware
> >>>>>>>>> +      * else nothing done here as the firmware has been preloade=
d for the
> >>>>>>>>> +      * sanity check to be able to parse it for the resource tab=
le.
> >>>>>>>>> +      */
> >>>>>>>>
> >>>>>>>> This comment is very confusing - please consider refactoring.
> >>>>>>>>
> >>>>>>>>> +     if (ddata->fw_loaded)
> >>>>>>>>> +             return 0;
> >>>>>>>>> +
> >>>>>>>>
> >>>>>>>> I'm not sure about keeping a flag to indicate the status of the lo=
aded firmware.
> >>>>>>>> It is not done for the non-secure method, I don't see why it would=
 be needed for
> >>>>>>>> the secure one.
> >>>>>>>>
> >>>>>>>
> >>>>>>> The difference is on the sanity check.
> >>>>>>> - in rproc_elf_sanity_check we  parse the elf file to verify that i=
t is
> >>>>>>> valid.
> >>>>>>> - in stm32_rproc_tee_elf_sanity_check we have to do the same, that =
means to
> >>>>>>> authenticate it. the authentication is done during the load.
> >>>>>>>
> >>>>>>> So this flag is used to avoid to reload it twice time.
> >>>>>>> refactoring the comment should help to understand this flag
> >>>>>>>
> >>>>>>>
> >>>>>>> An alternative would be to bypass the sanity check. But this lead t=
o same
> >>>>>>> limitation.
> >>>>>>> Before loading the firmware in remoteproc_core, we call rproc_parse=
_fw() that is
> >>>>>>> used to get the resource table address. To get it from tee we need =
to
> >>>>>>> authenticate the firmware so load it...
> >>>>>>>
> >>>>>>
> >>>>>> I spent a long time thinking about this patchset.  Looking at the co=
de as it
> >>>>>> is now, request_firmware() in rproc_boot() is called even when the T=
EE is
> >>>>>> responsible for loading the firmware.  There should be some conditio=
nal code
> >>>>>> that calls either request_firmware() or tee_rproc_load_fw().  The la=
tter should
> >>>>>> also be renamed to tee_rproc_request_firmware() to avoid confusion.
> >>>>>
> >>>>>
> >>>>> The request_firmware() call is needed in both cases to get the image =
from the
> >>>>> filesystem. The tee_rproc_load_fw() gets, as input, the struct firmwa=
re provided
> >>>>> by request_firmware().
> >>>>
> >>>> The cover letter clearly state the secure side is responsible for load=
ing the
> >>>> firmware image but here you're telling me it has to be loaded twice.  =
This is
> >>>> very confusing.
> >>>
> >>> Concerning the call of request_firmware()
> >>>
> >>> By "both cases" I would say that the call of request_firmware() is need=
ed in
> >>> both modes:
> >>> - the ELF firmware is parsed and loaded by linux (legacy)
> >>> - the binary firmware is parsed and loaded by OP-TEE.
> >>>
> >>> The Op-TEE is not able to get the firmware image from the file system.
> >>>
> >>>
> >>> Concerning the call of tee_rproc_load_fw twice time
> >>>
> >>> There are 2 use cases:
> >>>
> >>> - First boot of the remote processor:
> >>>
> >>>   1) The Linux rproc gets the binary firmware image from the file syste=
m by
> >>>      calling  request_firmware(). A copy is stored in memory.
> >>
> >> Right.  And I think tee_rproc_load_fw() should be called right after
> >> request_firmware() if rproc::tee_rproc_interface is valid.  At that poin=
t the TEE
> >> app may or may not do the firmware authentication, that is application s=
pecific.
>
> FYI, I am close to completing V3 for my series. However, I am facing an iss=
ue
> with rproc_load_segments() that requires the implementation of ops->load on=
 start.
> Therefore, just inserting a tee_rproc_load_fw() call is not possible.
>
> Due to this constraint, I did not find a solution that matches your
> recommendations. Nevertheless, I will propose another solution in my V3, tr=
ying
> to take into account as many of your comments/requests as possible, includi=
ng
> updating of the remoteproc_core.c to simplify the sequence.
>
>

Thanks for the heads-up, let's see what you come up with.  That said,
please provide as much information as possible on the constraints you
are facing.

> Regards,
> Arnaud
>
>
> >>
> >>>   2) the linux performs a sanity check on the firmware calling
> >>>      rproc_fw_sanity_check()
> >>>     =3D> from OP-TEE point of view this means to autenticate the firmwa=
re
> >>>     =3D> let consider in this exemple that we bypass this step
> >>>            (ops->sanity_check =3D NULL)
> >>
> >> Ok
> >>
> >>>
> >>>   3) the linux rproc call rproc_parse_fw() to get the resource table
> >>>     =3D> From OP-TEE point of view the resource table is available only=
 when
> >>>            the firmware is loaded
> >>
> >> Right, and it should have been loaded already.  If it is not then the TE=
E should
> >> return an error.
> >>
> >>>     =3D> We need to call tee_rproc_load_fw() to be able then to get the
> >>>            address of the resource table.
> >>
> >> See my comment above - at this point the TEE should already have the fir=
mware.
> >> As such the only thing left is to get the address of the resource table,=
 which
> >> you already do in rproc_tee_get_rsc_table().  The upper part of that fun=
ction
> >> should be spun off in a new static function to deal with the TEE API, so=
mething
> >> like _rproc_tee_get_rsc_table().  The new function should also be called=
 in
> >> tee_rproc_get_loaded_rsc_table() rather than keeping a cache value in
> >> trproc->rsc_va.
> >>
> >>>   4) The Linux rproc calls rproc_handle_resources() to parse the resour=
ce table.
> >>>   5) The linux rproc calls rproc_start()
> >>>     - load the firrmware calling rproc_load_segments()
> >>>             =3D> we don't want to call tee_rproc_load_fw() it a second =
time
> >>
> >> And that is fine if the TEE app has already placed the program segments =
in
> >> memory.
> >>
> >>>     - start the firmware calling ops->start()
> >>>
> >>> - Reboot on crash recovery using rproc_boot_recovery()
> >>>
> >>>   1)  The Linux rproc gets the binary firmware image from the file syst=
em by
> >>>      calling request_firmware(). A copy is stored in memory.
> >>>   5) The linux rproc calls rproc_start()
> >>>     - load the firrmware calling rproc_load_segments()
> >>>             =3D> we have to call tee_rproc_load_fw() to reload the firm=
ware
> >>
> >> Loading the firmware in the TEE should be done right after request_firmw=
are()
> >> has been called, the same way it is done in the boot path.  If there isn=
't a
> >> need to reload the TEE firmware than the TEE application should ignore t=
he
> >> request.
> >
> > I need to prototype to verify this proposal.
> > I will come back with a V3.
>
> >
> > Thank you for the advice and review!
> >
> > Regard,
> > Arnaud
> >
> >>
> >>>     - start the firmware calling ops->start()
> >>>
> >>> In first use case we have to load the firmware on rproc_parse_fw(), in =
second
> >>> usecase on rproc_load_segments().
> >>>
> >>> This is the point I have tried to solve with the ddata->fw_loaded varia=
ble.
> >>>
> >>>>
> >>>> I'm also confused as to why stm32_rproc_tee_elf_sanity_check() is call=
ing
> >>>> tee_rproc_load_fw().  There should be one call to load the firmware an=
d another
> >>>> to perform a sanity check on it.  If the sanity check is done at load =
time by
> >>>> the secure world then ops::sanity_check() is NULL.
> >>>
> >>> Sure, make sense to remove the sanity_check ops
> >>>
> >>> Thanks,
> >>> Arnaud
> >>>
> >>>>
> >>>> Most of what this patchset does makes sense, but some of it needs to b=
e moved
> >>>> around.
> >>>>
> >>>> Thanks,
> >>>> Mathieu
> >>>>
> >>>>>
> >>>>> If we want to integrate in remoteproc_core the solution could probabl=
y have to
> >>>>> create the equivalent of the rproc_fw_boot() to load the firmware wit=
h an
> >>>>> external method. Here is an example based on a new rproc_ops ( not te=
sted)
> >>>>>
> >>>>> + static int rproc_fw_ext_boot(struct rproc *rproc, const struct firm=
ware *fw)
> >>>>> + {
> >>>>> +         struct device *dev =3D &rproc->dev;
> >>>>> +         const char *name =3D rproc->firmware;
> >>>>> +         int ret;
> >>>>> +
> >>>>> +
> >>>>> +         dev_info(dev, "Booting fw image %s, size %zd\n", name, fw->=
size);
> >>>>> +
> >>>>> +         /* ops to load and start the remoteprocessor */
> >>>>> +         ret =3D rproc->ops->boot(rproc, fw);
> >>>>> +         if (ret)
> >>>>> +                 return ret;
> >>>>> +
> >>>>> +         /*
> >>>>> +          * if enabling an IOMMU isn't relevant for this rproc, this=
 is
> >>>>> +          * just a nop
> >>>>> +          */
> >>>>> +         ret =3D rproc_enable_iommu(rproc);
> >>>>> +         if (ret) {
> >>>>> +                 dev_err(dev, "can't enable iommu: %d\n", ret);
> >>>>> +                 return ret;
> >>>>> +         }
> >>>>> +
> >>>>> +         /* Prepare rproc for firmware loading if needed */
> >>>>> +         ret =3D rproc_prepare_device(rproc);
> >>>>> +         if (ret) {
> >>>>> +                 dev_err(dev, "can't prepare rproc %s: %d\n", rproc-=
>name, ret);
> >>>>> +                 goto disable_iommu;
> >>>>> +         }
> >>>>> +
> >>>>> +         ret =3D rproc_set_rsc_table(rproc);
> >>>>> +         if (ret) {
> >>>>> +                 dev_err(dev, "can't load resource table: %d\n", ret=
);
> >>>>> +                 goto unprepare_device;
> >>>>> +         }
> >>>>> +
> >>>>> +
> >>>>> +         /* reset max_notifyid */
> >>>>> +         rproc->max_notifyid =3D -1;
> >>>>> +
> >>>>> +         /* reset handled vdev */
> >>>>> +         rproc->nb_vdev =3D 0;
> >>>>> +
> >>>>> +         /* handle fw resources which are required to boot rproc */
> >>>>> +         ret =3D rproc_handle_resources(rproc, rproc_loading_handler=
s);
> >>>>> +         if (ret) {
> >>>>> +                 dev_err(dev, "Failed to process resources: %d\n", r=
et);
> >>>>> +                 goto clean_up_resources;
> >>>>> +         }
> >>>>> +
> >>>>> +         /* Allocate carveout resources associated to rproc */
> >>>>> +         ret =3D rproc_alloc_registered_carveouts(rproc);
> >>>>> +         if (ret) {
> >>>>> +                 dev_err(dev, "Failed to allocate associated carveou=
ts: %d\n",
> >>>>> +                         ret);
> >>>>> +                 goto clean_up_resources;
> >>>>> +         }
> >>>>> +
> >>>>> +         return 0;
> >>>>> +
> >>>>> + clean_up_resources:
> >>>>> +         rproc_resource_cleanup(rproc);
> >>>>> + unprepare_rproc:
> >>>>> +         /* release HW resources if needed */
> >>>>> +         rproc_unprepare_device(rproc);
> >>>>> + disable_iommu:
> >>>>> +         rproc_disable_iommu(rproc);
> >>>>> +         return ret;
> >>>>> + }
> >>>>>
> >>>>>
> >>>>> int rproc_boot(struct rproc *rproc)
> >>>>> {
> >>>>> [...]
> >>>>>
> >>>>> -                 ret =3D rproc_fw_boot(rproc, firmware_p);
> >>>>> +                 if(rproc->ops->boot)
> >>>>> +                         ret =3D rproc_fw_ext_boot(rproc, firmware_p=
);
> >>>>> +                 else
> >>>>> +                         ret =3D rproc_fw_boot(rproc, firmware_p);
> >>>>>
> >>>>> Another advantage of this solution is that it opens the framework to =
other
> >>>>> formats. For instance it could be a way to support dtb format request=
ed in [RFC]
> >>>>> Passing device-tree to remoteproc [1].
> >>>>>
> >>>>> [1]
> >>>>> https://lore.kernel.org/linux-remoteproc/f67cd822-4e29-71f2-7c42-e11d=
baa6cd8c(a)kalrayinc.com/T/#t
> >>>>>
> >>>>> Thanks,
> >>>>> Arnaud
> >>>>>
> >>>>>
> >>>>>
> >>>>>>
> >>>>>> I touched on that before but please rename rproc_tee_get_rsc_table()=
 to
> >>>>>> rproc_tee_elf_load_rsc_table().  I also suggest to introduce a new f=
unction,
> >>>>>> rproc_tee_get_loaded_rsc_table() that would be called from
> >>>>>> rproc_tee_elf_load_rsc_table().  That way we don't need trproc->rsc_=
va.
> >>>>>>
> >>>>>> I also think tee_rproc should be renamed to "rproc_tee_interface" an=
d folded
> >>>>>> under struct rproc.
> >>>>>>
> >>>>>> With the above most of the problems with the current implementation =
should
> >>>>>> naturally go away.
> >>>>>>
> >>>>>> Thanks,
> >>>>>> Mathieu
> >>>>>>
> >>>>>>>
> >>>>>>>>> +     ret =3D tee_rproc_load_fw(ddata->trproc, fw);
> >>>>>>>>> +     if (ret)
> >>>>>>>>> +             return ret;
> >>>>>>>>> +     ddata->fw_loaded =3D true;
> >>>>>>>>> +
> >>>>>>>>> +     /* Update the resource table parameters. */
> >>>>>>>>> +     if (rproc_tee_get_rsc_table(ddata->trproc)) {
> >>>>>>>>> +             /* No resource table: reset the related fields. */
> >>>>>>>>> +             rproc->cached_table =3D NULL;
> >>>>>>>>> +             rproc->table_ptr =3D NULL;
> >>>>>>>>> +             rproc->table_sz =3D 0;
> >>>>>>>>> +     }
> >>>>>>>>> +
> >>>>>>>>> +     return 0;
> >>>>>>>>> +}
> >>>>>>>>> +
> >>>>>>>>> +static struct resource_table *
> >>>>>>>>> +stm32_rproc_tee_elf_find_loaded_rsc_table(struct rproc *rproc,
> >>>>>>>>> +                                       const struct firmware *fw)
> >>>>>>>>> +{
> >>>>>>>>> +     struct stm32_rproc *ddata =3D rproc->priv;
> >>>>>>>>> +
> >>>>>>>>> +     return tee_rproc_get_loaded_rsc_table(ddata->trproc);
> >>>>>>>>> +}
> >>>>>>>>> +
> >>>>>>>>> +static int stm32_rproc_tee_start(struct rproc *rproc)
> >>>>>>>>> +{
> >>>>>>>>> +     struct stm32_rproc *ddata =3D rproc->priv;
> >>>>>>>>> +
> >>>>>>>>> +     return tee_rproc_start(ddata->trproc);
> >>>>>>>>> +}
> >>>>>>>>> +
> >>>>>>>>> +static int stm32_rproc_tee_attach(struct rproc *rproc)
> >>>>>>>>> +{
> >>>>>>>>> +     /* Nothing to do, remote proc already started by the secure=
d context. */
> >>>>>>>>> +     return 0;
> >>>>>>>>> +}
> >>>>>>>>> +
> >>>>>>>>> +static int stm32_rproc_tee_stop(struct rproc *rproc)
> >>>>>>>>> +{
> >>>>>>>>> +     struct stm32_rproc *ddata =3D rproc->priv;
> >>>>>>>>> +     int err;
> >>>>>>>>> +
> >>>>>>>>> +     stm32_rproc_request_shutdown(rproc);
> >>>>>>>>> +
> >>>>>>>>> +     err =3D tee_rproc_stop(ddata->trproc);
> >>>>>>>>> +     if (err)
> >>>>>>>>> +             return err;
> >>>>>>>>> +
> >>>>>>>>> +     ddata->fw_loaded =3D false;
> >>>>>>>>> +
> >>>>>>>>> +     return stm32_rproc_release(rproc);
> >>>>>>>>> +}
> >>>>>>>>> +
> >>>>>>>>>  static int stm32_rproc_prepare(struct rproc *rproc)
> >>>>>>>>>  {
> >>>>>>>>>       struct device *dev =3D rproc->dev.parent;
> >>>>>>>>> @@ -319,7 +410,14 @@ static int stm32_rproc_prepare(struct rproc =
*rproc)
> >>>>>>>>>
> >>>>>>>>>  static int stm32_rproc_parse_fw(struct rproc *rproc, const struc=
t firmware *fw)
> >>>>>>>>>  {
> >>>>>>>>> -     if (rproc_elf_load_rsc_table(rproc, fw))
> >>>>>>>>> +     struct stm32_rproc *ddata =3D rproc->priv;
> >>>>>>>>> +     int ret;
> >>>>>>>>> +
> >>>>>>>>> +     if (ddata->trproc)
> >>>>>>>>> +             ret =3D rproc_tee_get_rsc_table(ddata->trproc);
> >>>>>>>>> +     else
> >>>>>>>>> +             ret =3D rproc_elf_load_rsc_table(rproc, fw);
> >>>>>>>>> +     if (ret)
> >>>>>>>>>               dev_warn(&rproc->dev, "no resource table found for =
this firmware\n");
> >>>>>>>>>
> >>>>>>>>>       return 0;
> >>>>>>>>> @@ -693,8 +791,22 @@ static const struct rproc_ops st_rproc_ops =
=3D {
> >>>>>>>>>       .get_boot_addr  =3D rproc_elf_get_boot_addr,
> >>>>>>>>>  };
> >>>>>>>>>
> >>>>>>>>> +static const struct rproc_ops st_rproc_tee_ops =3D {
> >>>>>>>>> +     .prepare        =3D stm32_rproc_prepare,
> >>>>>>>>> +     .start          =3D stm32_rproc_tee_start,
> >>>>>>>>> +     .stop           =3D stm32_rproc_tee_stop,
> >>>>>>>>> +     .attach         =3D stm32_rproc_tee_attach,
> >>>>>>>>> +     .kick           =3D stm32_rproc_kick,
> >>>>>>>>> +     .parse_fw       =3D stm32_rproc_parse_fw,
> >>>>>>>>> +     .find_loaded_rsc_table =3D stm32_rproc_tee_elf_find_loaded_=
rsc_table,
> >>>>>>>>> +     .get_loaded_rsc_table =3D stm32_rproc_get_loaded_rsc_table,
> >>>>>>>>> +     .sanity_check   =3D stm32_rproc_tee_elf_sanity_check,
> >>>>>>>>> +     .load           =3D stm32_rproc_tee_elf_load,
> >>>>>>>>> +};
> >>>>>>>>> +
> >>>>>>>>>  static const struct of_device_id stm32_rproc_match[] =3D {
> >>>>>>>>> -     { .compatible =3D "st,stm32mp1-m4" },
> >>>>>>>>> +     {.compatible =3D "st,stm32mp1-m4",},
> >>>>>>>>> +     {.compatible =3D "st,stm32mp1-m4-tee",},
> >>>>>>>>>       {},
> >>>>>>>>>  };
> >>>>>>>>>  MODULE_DEVICE_TABLE(of, stm32_rproc_match);
> >>>>>>>>> @@ -853,6 +965,7 @@ static int stm32_rproc_probe(struct platform_=
device *pdev)
> >>>>>>>>>       struct device *dev =3D &pdev->dev;
> >>>>>>>>>       struct stm32_rproc *ddata;
> >>>>>>>>>       struct device_node *np =3D dev->of_node;
> >>>>>>>>> +     struct tee_rproc *trproc =3D NULL;
> >>>>>>>>>       struct rproc *rproc;
> >>>>>>>>>       unsigned int state;
> >>>>>>>>>       int ret;
> >>>>>>>>> @@ -861,11 +974,31 @@ static int stm32_rproc_probe(struct platfor=
m_device *pdev)
> >>>>>>>>>       if (ret)
> >>>>>>>>>               return ret;
> >>>>>>>>>
> >>>>>>>>> -     rproc =3D rproc_alloc(dev, np->name, &st_rproc_ops, NULL, s=
izeof(*ddata));
> >>>>>>>>> -     if (!rproc)
> >>>>>>>>> -             return -ENOMEM;
> >>>>>>>>> +     if (of_device_is_compatible(np, "st,stm32mp1-m4-tee")) {
> >>>>>>>>> +             trproc =3D tee_rproc_register(dev, STM32_MP1_M4_PRO=
C_ID);
> >>>>>>>>> +             if (IS_ERR(trproc)) {
> >>>>>>>>> +                     dev_err_probe(dev, PTR_ERR(trproc),
> >>>>>>>>> +                                   "signed firmware not supporte=
d by TEE\n");
> >>>>>>>>> +                     return PTR_ERR(trproc);
> >>>>>>>>> +             }
> >>>>>>>>> +             /*
> >>>>>>>>> +              * Delegate the firmware management to the secure c=
ontext.
> >>>>>>>>> +              * The firmware loaded has to be signed.
> >>>>>>>>> +              */
> >>>>>>>>> +             dev_info(dev, "Support of signed firmware only\n");
> >>>>>>>>
> >>>>>>>> Not sure what this adds.  Please remove.
> >>>>>>>
> >>>>>>> This is used to inform the user that only a signed firmware can be =
loaded, not
> >>>>>>> an ELF file.
> >>>>>>> I have a patch in my pipe to provide the supported format in the de=
bugfs. In a
> >>>>>>> first step, I can suppress this message and we can revisit the issu=
e when I push
> >>>>>>> the debugfs proposal.
> >>>>>>>
> >>>>>>> Thanks,
> >>>>>>> Arnaud
> >>>>>>>
> >>>>>>>>
> >>>>>>>>> +     }
> >>>>>>>>> +     rproc =3D rproc_alloc(dev, np->name,
> >>>>>>>>> +                         trproc ? &st_rproc_tee_ops : &st_rproc_=
ops,
> >>>>>>>>> +                         NULL, sizeof(*ddata));
> >>>>>>>>> +     if (!rproc) {
> >>>>>>>>> +             ret =3D -ENOMEM;
> >>>>>>>>> +             goto free_tee;
> >>>>>>>>> +     }
> >>>>>>>>>
> >>>>>>>>>       ddata =3D rproc->priv;
> >>>>>>>>> +     ddata->trproc =3D trproc;
> >>>>>>>>> +     if (trproc)
> >>>>>>>>> +             trproc->rproc =3D rproc;
> >>>>>>>>>
> >>>>>>>>>       rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
> >>>>>>>>>
> >>>>>>>>> @@ -916,6 +1049,10 @@ static int stm32_rproc_probe(struct platfor=
m_device *pdev)
> >>>>>>>>>               device_init_wakeup(dev, false);
> >>>>>>>>>       }
> >>>>>>>>>       rproc_free(rproc);
> >>>>>>>>> +free_tee:
> >>>>>>>>> +     if (trproc)
> >>>>>>>>> +             tee_rproc_unregister(trproc);
> >>>>>>>>> +
> >>>>>>>>>       return ret;
> >>>>>>>>>  }
> >>>>>>>>>
> >>>>>>>>> @@ -937,6 +1074,8 @@ static void stm32_rproc_remove(struct platfo=
rm_device *pdev)
> >>>>>>>>>               device_init_wakeup(dev, false);
> >>>>>>>>>       }
> >>>>>>>>>       rproc_free(rproc);
> >>>>>>>>> +     if (ddata->trproc)
> >>>>>>>>> +             tee_rproc_unregister(ddata->trproc);
> >>>>>>>>>  }
> >>>>>>>>>
> >>>>>>>>>  static int stm32_rproc_suspend(struct device *dev)
> >>>>>>>>> --
> >>>>>>>>> 2.25.1
> >>>>>>>>>
> > _______________________________________________
> > Linux-stm32 mailing list
> > Linux-stm32(a)st-md-mailman.stormreply.com
> > https://st-md-mailman.stormreply.com/mailman/listinfo/linux-stm32

--===============6306703676478116738==--

