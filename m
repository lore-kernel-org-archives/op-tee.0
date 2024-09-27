From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v9 4/7] remoteproc: core: Add TEE interface support for
 firmware release
Date: Fri, 27 Sep 2024 12:01:08 +0200
Message-ID: <b96cef62-950b-44f9-9cc4-b7d6cc3aad45@foss.st.com>
In-Reply-To: <yvax326sikpqkaygfldunjpziwwlwccfzmi6r5ikaqoyvfvama@w7kifjv5yt47>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8204735813154371114=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8204735813154371114==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Bjorn,

On 9/26/24 05:51, Bjorn Andersson wrote:
> On Fri, Aug 30, 2024 at 11:51:44AM GMT, Arnaud Pouliquen wrote:
>> Add support for releasing remote processor firmware through
>> the Trusted Execution Environment (TEE) interface.
>>
>> The tee_rproc_release_fw() function is called in the following cases:
>>
>> - An error occurs in rproc_start() between the loading of the segments and
>>   the start of the remote processor.
>> - When rproc_release_fw is called on error or after stopping the remote
>>   processor.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>> ---
>>  drivers/remoteproc/remoteproc_core.c | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/rem=
oteproc_core.c
>> index 7694817f25d4..32052dedc149 100644
>> --- a/drivers/remoteproc/remoteproc_core.c
>> +++ b/drivers/remoteproc/remoteproc_core.c
>> @@ -29,6 +29,7 @@
>>  #include <linux/debugfs.h>
>>  #include <linux/rculist.h>
>>  #include <linux/remoteproc.h>
>> +#include <linux/remoteproc_tee.h>
>>  #include <linux/iommu.h>
>>  #include <linux/idr.h>
>>  #include <linux/elf.h>
>> @@ -1258,6 +1259,9 @@ static int rproc_alloc_registered_carveouts(struct r=
proc *rproc)
>> =20
>>  static void rproc_release_fw(struct rproc *rproc)
>>  {
>> +	if (rproc->state =3D=3D RPROC_OFFLINE && rproc->tee_interface)
>> +		tee_rproc_release_fw(rproc);
>=20
> I don't like the idea of having op-tee specific calls made from the
> core. If the problem is that we need to unroll something we did at load,
> can we instead come up with a more generic mechanism to unload that? Or

As proposed in [1] an alternative could be to define a new rproc_ops->release=
_fw
operation that will be initialized to tee_rproc_release_fw in the platform dr=
iver.

> can we perhaps postpone the tee interaction until start() to avoid the
> gap?

In such a case, the management of the resource table should also be postponed
as the firmware has to be authenticated first.

The OP-TEE implementation authenticates the firmware during the load
(in-destination memory authentication), so the sequence is:
1) Load the firmware.
2) Get the resource table and initialize resources.
3) Start the firmware.

The tee_rproc_release_fw() is used if something goes wrong during step 2 an3.

From my perspective, this would result in an alternative boot sequence, as we
have today for "attach". I proposed this approach in my V3 [2]. But this add
complexity in remote proc core.


Please, could you align with Mathieu to define how we should move forward to
address your concerns?

[1]https://lkml.org/lkml/2024/9/18/612
[2]https://lore.kernel.org/lkml/8af59b01-53cf-4fc4-9946-6c630fb7b38e(a)quicin=
c.com/T/

Thanks and Regards,
Arnaud

>=20
>=20
> PS. Most of the Qualcomm drivers are TEE-based...so the "tee_interface"
> boolean check here is not very nice.
>=20
> Regards,
> Bjorn
>=20
>> +
>>  	/* Free the copy of the resource table */
>>  	kfree(rproc->cached_table);
>>  	rproc->cached_table =3D NULL;
>> @@ -1348,7 +1352,7 @@ static int rproc_start(struct rproc *rproc, const st=
ruct firmware *fw)
>>  	if (ret) {
>>  		dev_err(dev, "failed to prepare subdevices for %s: %d\n",
>>  			rproc->name, ret);
>> -		goto reset_table_ptr;
>> +		goto release_fw;
>>  	}
>> =20
>>  	/* power up the remote processor */
>> @@ -1376,7 +1380,9 @@ static int rproc_start(struct rproc *rproc, const st=
ruct firmware *fw)
>>  	rproc->ops->stop(rproc);
>>  unprepare_subdevices:
>>  	rproc_unprepare_subdevices(rproc);
>> -reset_table_ptr:
>> +release_fw:
>> +	if (rproc->tee_interface)
>> +		tee_rproc_release_fw(rproc);
>>  	rproc->table_ptr =3D rproc->cached_table;
>> =20
>>  	return ret;
>> --=20
>> 2.25.1
>>

--===============8204735813154371114==--

