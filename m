From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [RFC PATCH] tee: tstee: Add initial Trusted Services TEE driver
Date: Tue, 31 Oct 2023 17:09:26 +0530
Message-ID: 
 <CAFA6WYO_zVi5ZN1JD8_sOCQ2ZCegNiqx7iXFiV5GK6WXLS0aZA@mail.gmail.com>
In-Reply-To: <8FF4167B-4EBF-4C39-B054-93F129E08046@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3044393498129694623=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3044393498129694623==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Balint,

Thanks for the detailed insights.

On Tue, 31 Oct 2023 at 00:05, Balint Dobszay <balint.dobszay@arm.com> wrote:
>
> On 26 Oct 2023, at 8:52, Sumit Garg wrote:
> > On Fri, 20 Oct 2023 at 19:22, Balint Dobszay <balint.dobszay@arm.com> w=
rote:
> >> On 13 Oct 2023, at 14:47, Sumit Garg wrote:
> >>> On Wed, 27 Sept 2023 at 20:56, Balint Dobszay <balint.dobszay@arm.com=
> wrote:
> >>
> >> [snip]
> >>
> >>>> diff --git a/drivers/tee/tstee/core.c b/drivers/tee/tstee/core.c
> >>>> new file mode 100644
> >>>> index 000000000000..c0194638b7da
> >>>> --- /dev/null
> >>>> +++ b/drivers/tee/tstee/core.c
> >>>> @@ -0,0 +1,473 @@
> >>>> +// SPDX-License-Identifier: GPL-2.0-only
> >>>> +/*
> >>>> + * Copyright (c) 2023, Arm Limited
> >>>> + */
> >>>> +
> >>>> +#define DRIVER_NAME "Arm TSTEE"
> >>>> +#define pr_fmt(fmt) DRIVER_NAME ": " fmt
> >>>> +
> >>>> +#include <linux/arm_ffa.h>
> >>>> +#include <linux/err.h>
> >>>> +#include <linux/errno.h>
> >>>> +#include <linux/kernel.h>
> >>>> +#include <linux/limits.h>
> >>>> +#include <linux/list.h>
> >>>> +#include <linux/mm.h>
> >>>> +#include <linux/module.h>
> >>>> +#include <linux/scatterlist.h>
> >>>> +#include <linux/slab.h>
> >>>> +#include <linux/stat.h>
> >>>> +#include <linux/tee_drv.h>
> >>>> +#include <linux/types.h>
> >>>> +#include <linux/uaccess.h>
> >>>> +
> >>>> +#include "tstee_private.h"
> >>>> +
> >>>> +#define FFA_INVALID_MEM_HANDLE U64_MAX
> >>>> +
> >>>> +static void arg_list_to_ffa_data(const u32 *args, struct ffa_send_dir=
ect_data *data)
> >>>> +{
> >>>> +       data->data0 =3D args[0];
> >>>> +       data->data1 =3D args[1];
> >>>> +       data->data2 =3D args[2];
> >>>> +       data->data3 =3D args[3];
> >>>> +       data->data4 =3D args[4];
> >>>> +}
> >>>> +
> >>>> +static void arg_list_from_ffa_data(const struct ffa_send_direct_data =
*data, u32 *args)
> >>>> +{
> >>>> +       args[0] =3D lower_32_bits(data->data0);
> >>>> +       args[1] =3D lower_32_bits(data->data1);
> >>>> +       args[2] =3D lower_32_bits(data->data2);
> >>>> +       args[3] =3D lower_32_bits(data->data3);
> >>>> +       args[4] =3D lower_32_bits(data->data4);
> >>>> +}
> >>>> +
> >>>> +static void tstee_get_version(struct tee_device *teedev, struct tee_i=
octl_version_data *vers)
> >>>> +{
> >>>> +       struct tstee *tstee =3D tee_get_drvdata(teedev);
> >>>> +       struct tee_ioctl_version_data v =3D {
> >>>> +               .impl_id =3D TEE_IMPL_ID_TSTEE,
> >>>> +               .impl_caps =3D tstee->ffa_dev->vm_id,
> >>>
> >>> So while exploring the user-space interface, I observed an anomaly
> >>> here. The ".impl_caps" refers to "Implementation specific
> >>> capabilities" meant to support backwards compatibility of a particular
> >>> TEE implementation. But here I observe you are using it instead for
> >>> endpoint_id. Can you provide the reasoning behind it? Also, do you
> >>> plan to support multiple endpoints via this driver?
> >>
> >> The mapping between Trusted Services SPs and TEE devices is 1:1, i.e.
> >> each /dev/tee<n> device represents exactly one FF-A endpoint. To answer
> >> your second question, each instance of the driver represents a single
> >> endpoint, multiple endpoints are supported by having multiple instances
> >> of the driver.
> >
> > I don't follow you here. How multiple instances of "arm_tstee" driver
> > going to work? Also, I can only see a single FF-A based device:
> > TS_RPC_UUID being probed here.
>
> My terminology regarding "multiple instances of the driver" was
> incorrect, apologies. What I meant was that tstee_probe() gets called
> multiple times, thus allocating multiple instances of "struct tstee".
>
> All of the Trusted Services SPs use the same FF-A UUID (TS_RPC_UUID).
> These will show up on the FF-A bus in Linux as multiple devices, having
> the same FF-A UUID, but different endpoint IDs, e.g.
>
> Name            FF-A EP ID    FF-A UUID
> ------------    ----------    -----------------------------------
> OP-TEE          0x8001        486178e0-e7f8-11e3-bc5e0002a5d5c51b
> TS ITS SP       0x8002        bdcd76d7-825e-4751-963b86d4f84943ac
> TS Crypto SP    0x8003        bdcd76d7-825e-4751-963b86d4f84943ac
> TS Attest SP    0x8003        bdcd76d7-825e-4751-963b86d4f84943ac
>
> Each of the Trusted Services FF-A devices will match the single UUID
> present in tstee_device_ids[], so tstee_probe() will be called multiple
> times, each time with a different FF-A device as argument. In the probe
> function a new TEE device is allocated, and a new "struct tstee" which
> represents the connection between a particular ffa_device and
> tee_device.

I can see now how it works but allocation of a tee_device for every
ffa_device seems an overkill here. I suppose standalone secure
partitions are somewhat analogous to trusted applications. I don't
think we really need separate TEE devices in order to communicate with
different secure partitions.

Based on whatever I have understood as of now regarding this
interface, it should work with single TEE device as follows:

- During tstee_probe(), create a list of FF-A devices (representing
SPs) and create a single TEE device representing TSTEE RPC protocol.
- During open session IOCTL, pass endpoint ID as an argument and check
if corresponding FF-A device is present in the list. If present then
you can return session ID derived from the endpoint ID to the
user-space client.
- For all further invoke commands IOCTL, you can retrieve endpoint ID
from session ID and then talk to corresponding FF-A device.

IMO, this way it would be more scalable and efficient usage of a TEE device.

On a side note, I would suggest you document Trusted Services TEE for
the next patch revision.

>
> I think a similar scenario would be if we had e.g. Hafnium as S-EL2 SPMC
> and two OP-TEE instances as S-EL1 SPs running under Hafnium. In this
> case the FF-A devices representing the OP-TEE instances would have the
> same FF-A UUID but different endpoint IDs. The OP-TEE driver in Linux
> would register two TEE devices for the two OP-TEE SPs.

Do you have any particular use-case where two or more OP-TEE instances
will be required by a single VM (Linux)? Those different TEE devices
are intended to represent different TEE implementations (following
unique communication protocol stack).

-Sumit

>
> > Do you have any working example for this?
>
> The end-to-end integration for FVP I mentioned earlier does build, boot
> and test multiple endpoints.
>
> >> Therefore we always return a single endpoint ID in this
> >> field.
> >>
> >> The reason behind the usage of this field is that somehow user space has
> >> to be able to discover which TEE device represents which FF-A endpoint.
> >> This is required when a client wants to invoke an SP with a specific
> >> endpoint ID, e.g. in a system where the SP's endpoint IDs is static and
> >> known by the client.
> >>
> >> I understand this is not a conventional usage of this field, I couldn't
> >> find a better way to "fit" this information into the ABI. My
> >> understanding is this solution shouldn't cause any issues for other
> >> TEEs, since this implementation specific field should only be parsed by
> >> a client if it has already matched on the TEE implementation ID. Please
> >> correct me if this assumption is wrong, or if you have any suggestions
> >> on other ways to expose the endpoint ID to user space.
> >
> > When you say "each /dev/tee<n> device represents exactly one FF-A
> > endpoint" then "impl_id" should be sufficient to represent endpoint ID
> > too. But I am still confused regarding how you are going to support
> > multiple endpoints?
>
> Hopefully my answer above covers this question too.
>
> > Looking at this driver TEE_IMPL_ID_TSTEE represents an underlying FF-A
> > based TS_RPC_UUID device.
>
> Yes, that is correct. The FF-A UUID here acts as a protocol identifier,
> multiple FF-A endpoints can implement the same protocol, therefore can
> have the same UUID. The mechanism to discover what services a particular
> TS SP provides is not defined by FF-A, in this case it's done by the TS
> RPC protocol which is one layer above FF-A.
>
> Regards,
> Balint

--===============3044393498129694623==--

