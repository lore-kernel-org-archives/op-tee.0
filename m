From: Balint Dobszay <balint.dobszay@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [RFC PATCH] tee: tstee: Add initial Trusted Services TEE driver
Date: Wed, 22 Nov 2023 17:47:25 +0100
Message-ID: <50D6603C-D896-49FD-B41A-39A381E07EB4@arm.com>
In-Reply-To: <
 <CAFA6WYOc2MdKTsUpJwQ3xrcQ3iDTCnhki9LdqgdfR8KsEC8TRQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3279984517867274868=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3279984517867274868==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 20 Nov 2023, at 9:01, Sumit Garg wrote:
> On Tue, 14 Nov 2023 at 20:02, Balint Dobszay <balint.dobszay@arm.com> wro=
te:
>> On 31 Oct 2023, at 12:39, Sumit Garg wrote:
>>> On Tue, 31 Oct 2023 at 00:05, Balint Dobszay <balint.dobszay@arm.com> w=
rote:
>>>> On 26 Oct 2023, at 8:52, Sumit Garg wrote:
>>>>> On Fri, 20 Oct 2023 at 19:22, Balint Dobszay <balint.dobszay@arm.com>=
 wrote:
>>>>>> On 13 Oct 2023, at 14:47, Sumit Garg wrote:
>>>>>>> On Wed, 27 Sept 2023 at 20:56, Balint Dobszay <balint.dobszay@arm.c=
om> wrote:
>>>>>>
>>>>>> [snip]
>>>>>>
>>>>>>>> diff --git a/drivers/tee/tstee/core.c b/drivers/tee/tstee/core.c
>>>>>>>> new file mode 100644
>>>>>>>> index 000000000000..c0194638b7da
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/drivers/tee/tstee/core.c
>>>>>>>> @@ -0,0 +1,473 @@
>>>>>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>>>>>> +/*
>>>>>>>> + * Copyright (c) 2023, Arm Limited
>>>>>>>> + */
>>>>>>>> +
>>>>>>>> +#define DRIVER_NAME "Arm TSTEE"
>>>>>>>> +#define pr_fmt(fmt) DRIVER_NAME ": " fmt
>>>>>>>> +
>>>>>>>> +#include <linux/arm_ffa.h>
>>>>>>>> +#include <linux/err.h>
>>>>>>>> +#include <linux/errno.h>
>>>>>>>> +#include <linux/kernel.h>
>>>>>>>> +#include <linux/limits.h>
>>>>>>>> +#include <linux/list.h>
>>>>>>>> +#include <linux/mm.h>
>>>>>>>> +#include <linux/module.h>
>>>>>>>> +#include <linux/scatterlist.h>
>>>>>>>> +#include <linux/slab.h>
>>>>>>>> +#include <linux/stat.h>
>>>>>>>> +#include <linux/tee_drv.h>
>>>>>>>> +#include <linux/types.h>
>>>>>>>> +#include <linux/uaccess.h>
>>>>>>>> +
>>>>>>>> +#include "tstee_private.h"
>>>>>>>> +
>>>>>>>> +#define FFA_INVALID_MEM_HANDLE U64_MAX
>>>>>>>> +
>>>>>>>> +static void arg_list_to_ffa_data(const u32 *args, struct ffa_send_d=
irect_data *data)
>>>>>>>> +{
>>>>>>>> +       data->data0 =3D args[0];
>>>>>>>> +       data->data1 =3D args[1];
>>>>>>>> +       data->data2 =3D args[2];
>>>>>>>> +       data->data3 =3D args[3];
>>>>>>>> +       data->data4 =3D args[4];
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static void arg_list_from_ffa_data(const struct ffa_send_direct_dat=
a *data, u32 *args)
>>>>>>>> +{
>>>>>>>> +       args[0] =3D lower_32_bits(data->data0);
>>>>>>>> +       args[1] =3D lower_32_bits(data->data1);
>>>>>>>> +       args[2] =3D lower_32_bits(data->data2);
>>>>>>>> +       args[3] =3D lower_32_bits(data->data3);
>>>>>>>> +       args[4] =3D lower_32_bits(data->data4);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static void tstee_get_version(struct tee_device *teedev, struct tee=
_ioctl_version_data *vers)
>>>>>>>> +{
>>>>>>>> +       struct tstee *tstee =3D tee_get_drvdata(teedev);
>>>>>>>> +       struct tee_ioctl_version_data v =3D {
>>>>>>>> +               .impl_id =3D TEE_IMPL_ID_TSTEE,
>>>>>>>> +               .impl_caps =3D tstee->ffa_dev->vm_id,
>>>>>>>
>>>>>>> So while exploring the user-space interface, I observed an anomaly
>>>>>>> here. The ".impl_caps" refers to "Implementation specific
>>>>>>> capabilities" meant to support backwards compatibility of a particular
>>>>>>> TEE implementation. But here I observe you are using it instead for
>>>>>>> endpoint_id. Can you provide the reasoning behind it? Also, do you
>>>>>>> plan to support multiple endpoints via this driver?
>>>>>>
>>>>>> The mapping between Trusted Services SPs and TEE devices is 1:1, i.e.
>>>>>> each /dev/tee<n> device represents exactly one FF-A endpoint. To answer
>>>>>> your second question, each instance of the driver represents a single
>>>>>> endpoint, multiple endpoints are supported by having multiple instances
>>>>>> of the driver.
>>>>>
>>>>> I don't follow you here. How multiple instances of "arm_tstee" driver
>>>>> going to work? Also, I can only see a single FF-A based device:
>>>>> TS_RPC_UUID being probed here.
>>>>
>>>> My terminology regarding "multiple instances of the driver" was
>>>> incorrect, apologies. What I meant was that tstee_probe() gets called
>>>> multiple times, thus allocating multiple instances of "struct tstee".
>>>>
>>>> All of the Trusted Services SPs use the same FF-A UUID (TS_RPC_UUID).
>>>> These will show up on the FF-A bus in Linux as multiple devices, having
>>>> the same FF-A UUID, but different endpoint IDs, e.g.
>>>>
>>>> Name            FF-A EP ID    FF-A UUID
>>>> ------------    ----------    -----------------------------------
>>>> OP-TEE          0x8001        486178e0-e7f8-11e3-bc5e0002a5d5c51b
>>>> TS ITS SP       0x8002        bdcd76d7-825e-4751-963b86d4f84943ac
>>>> TS Crypto SP    0x8003        bdcd76d7-825e-4751-963b86d4f84943ac
>>>> TS Attest SP    0x8003        bdcd76d7-825e-4751-963b86d4f84943ac
>>>>
>>>> Each of the Trusted Services FF-A devices will match the single UUID
>>>> present in tstee_device_ids[], so tstee_probe() will be called multiple
>>>> times, each time with a different FF-A device as argument. In the probe
>>>> function a new TEE device is allocated, and a new "struct tstee" which
>>>> represents the connection between a particular ffa_device and
>>>> tee_device.
>>>
>>> I can see now how it works but allocation of a tee_device for every
>>> ffa_device seems an overkill here. I suppose standalone secure
>>> partitions are somewhat analogous to trusted applications. I don't
>>> think we really need separate TEE devices in order to communicate with
>>> different secure partitions.
>>
>> Makes sense, I was thinking about this too. In an earlier version of
>> this driver I implemented a similar approach to what you've suggested,
>> code available at [1]. However, there were some places where the single
>> TEE device solution had shortcomings, that's why I ended up with the
>> current version. I think from a layering point of view an SP is more
>> similar to a TEE. In Trusted Services an SP can host one or multiple
>> services, each one is identified by a service UUID and defines service
>> specific operations and parameters. IMO these services are analogous to
>> TAs and the collection of services accessible by a common RPC protocol
>> is analogous to a TEE.
>>
>>> Based on whatever I have understood as of now regarding this
>>> interface, it should work with single TEE device as follows:
>>>
>>> - During tstee_probe(), create a list of FF-A devices (representing
>>> SPs) and create a single TEE device representing TSTEE RPC protocol.
>>
>> This is fine, basically this is what I've implemented in [1].
>>
>>> - During open session IOCTL, pass endpoint ID as an argument and check
>>> if corresponding FF-A device is present in the list. If present then
>>> you can return session ID derived from the endpoint ID to the
>>> user-space client.
>>
>> There is an issue here: unless static endpoint IDs are used, user space
>> has to be able to discover the endpoint IDs assigned to this driver
>> first (i.e. currently using tee_ioctl_version_data.impl_caps that we've
>> been discussing in the other thread). If there is only a single TEE
>> device for all SPs, the impl_caps solution cannot be used. In [1] the
>> workaround I implemented for this was to have a special case in the
>> invoke_func() op that doesn't actually do a call to SWd, but just
>> gathers the list of available endpoint IDs and returns them to user
>> space. I think this is probably not in line with the intended usage of
>> this ioctl, but couldn't find a better way.
>
> Don't you think we need to provide unique static endpoint IDs for
> services supporting the RPC protocol? Are these currently dynamically
> allocated?

A unique endpoint ID is assigned to each SP at boot time by the SPMC. If
an SP's manifest specifies a static endpoint ID, that one will be used,
otherwise the SPMC will dynamically allocate one.

> How does user-space know if the endpoint ID belongs to attestation
> service or crypto service?

A single SP can provide multiple services, i.e. it's 1:n mapping between
endpoint IDs and services. The service types (e.g. PSA Crypto, ITS, etc)
are identified by a service UUID (IMO this is somewhat analogous to a
TA's UUID). To discover if a service is implemented by an endpoint the
TS_RPC_OP_SERVICE_INFO request is used in open_session(). This RPC will
either return success along with the service's short ID (interface ID)
if the service is present, or an error if the queried service UUID is
not implemented by the endpoint.

If user space has no prior knowledge of what services are implemented by
which endpoint ID, to find a specific service UUID it calls open session
ioctl for each TEE device that is TEE_IMPL_ID_TSTEE [1].

>> Also, the current solution maps well to the TEE subsystem concepts of a
>> context and a session. The context represents a connection to an SP, one
>> or more services can be opened in the SP represented by sessions in that
>> context. In the future we plan to introduce some form of login/
>> authentication mechanism for services in TS SPs where the related fields
>> in open_session ioctl's argument would be useful. However, if a session
>> would represent a whole SP, a new solution would be needed - specific to
>> this driver - for representing the services inside the SP and passing
>> the login/authentication arguments in the ioctl.
>>
>>> - For all further invoke commands IOCTL, you can retrieve endpoint ID
>>> from session ID and then talk to corresponding FF-A device.
>>
>> There is an issue with the memory sharing operations. The SHM alloc
>> ioctl doesn't have a session ID field in its input argument struct, i.e.
>> the memory share operation is "context specific", not "session
>> specific". If a single TEE device is representing all TS SPs, when
>> invoking an SHM alloc ioctl on that device there is no way to convey
>> information about the destination endpoint ID to the driver.
>
> Okay I see that as a major limiting factor to the approach I proposed.
> The generic TEE driver design is to share memory at once with
> underlying TEE implementation (TSTEE in this case). It can then be
> further reused to communicate with multiple TAs.
>
> However, in trusted services the user-space has to separately share
> memory with each trusted service using endpoint ID. That's the major
> reason I see that we have to create a separate TEE device for each
> trusted service. I would like to see that reasoning in the commit
> message description as well as the documentation for TSTEE.

Sure, I will document this topic.

Regards,
Balint

[1] https://git.trustedfirmware.org/TS/trusted-services.git/tree/components/r=
pc/ts_rpc/caller/linux/ts_rpc_caller_linux.c#n104

--===============3279984517867274868==--

