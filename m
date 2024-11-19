From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v13 4/7] remoteproc: Introduce release_fw optional operation
Date: Tue, 19 Nov 2024 19:10:58 +0100
Message-ID: <0d9075cd-68c2-49ec-9b9c-4315aa8c8517@foss.st.com>
In-Reply-To: <Zzt+7NBdNjyzWZIb@p14s>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7571903707588851442=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7571903707588851442==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Mathieu,

On 11/18/24 18:52, Mathieu Poirier wrote:
> On Mon, Nov 04, 2024 at 02:35:12PM +0100, Arnaud Pouliquen wrote:
>> This patch updates the rproc_ops struct to include an optional
>> release_fw function.
>>
>> The release_fw ops is responsible for releasing the remote processor
>> firmware image. The ops is called in the following cases:
>>
>>  - An error occurs in rproc_start() between the loading of the segments and
>>       the start of the remote processor.
>>  - after stopping the remote processor.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>> ---
>> Updates from version V11:
>> - fix typo in @release_fw comment
>> ---
>>  drivers/remoteproc/remoteproc_core.c | 5 +++++
>>  include/linux/remoteproc.h           | 3 +++
>>  2 files changed, 8 insertions(+)
>>
>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/rem=
oteproc_core.c
>> index 7694817f25d4..46863e1ca307 100644
>> --- a/drivers/remoteproc/remoteproc_core.c
>> +++ b/drivers/remoteproc/remoteproc_core.c
>> @@ -1258,6 +1258,9 @@ static int rproc_alloc_registered_carveouts(struct r=
proc *rproc)
>> =20
>>  static void rproc_release_fw(struct rproc *rproc)
>>  {
>> +	if (rproc->ops->release_fw)
>> +		rproc->ops->release_fw(rproc);
>> +
>>  	/* Free the copy of the resource table */
>>  	kfree(rproc->cached_table);
>>  	rproc->cached_table =3D NULL;
>> @@ -1377,6 +1380,8 @@ static int rproc_start(struct rproc *rproc, const st=
ruct firmware *fw)
>>  unprepare_subdevices:
>>  	rproc_unprepare_subdevices(rproc);
>>  reset_table_ptr:
>> +	if (rproc->ops->release_fw)
>> +		rproc->ops->release_fw(rproc);
>>  	rproc->table_ptr =3D rproc->cached_table;
>=20
> I suggest the following:
>=20
> 1) Create two new functions, i.e rproc_load_fw() and rproc_release_fw().  T=
he
> only thing those would do is call rproc->ops->load_fw() and
> rproc->ops->release_fw(), if they are present.  When a TEE interface is
> available, ->load_fw() and ->release_fw() become rproc_tee_load_fw() and
> rproc_tee_release_fw().


I'm wondering if it should be ->preload_fw() instead of ->load_fw() ops, as t=
he
->load() op already exists.

>=20
> 2) Call rproc_load_fw() in rproc_boot(), just before rproc_fw_boot().  If t=
he
> call to rproc_fw_boot() fails, call rproc_release_fw().
>=20
> 3) The same logic applies to rproc_boot_recovery(), i.e call rproc_load_fw()
> before rproc_start() and call rproc_release_fw() if rproc_start() fails.


I implemented this and I'm currently testing it.
Thise second part requires a few adjustments to work. The ->load() ops needs =
to
becomes optional to not be called if the "->preload_fw()" is used.

For that, I propose to return 0 in rproc_load_segments if rproc->ops->load is
NULL and compensate by checking that at least "->preload_fw()" or ->load() is
non-null in rproc_alloc_ops.

Thanks,
Arnaud


>=20
> 4) Take rproc_tee_load_fw() out of rproc_tee_parse_fw().  It will now be ca=
lled
> in rproc_load_fw().
>=20
> 5) As stated above function rproc_release_fw() now calls rproc_tee_release_=
fw().
> The former is already called in rproc_shutdown() so we are good in that fro=
nt.
>=20
> With the above the cached_table management within the core remains the same=
 and
> we can get rid of patch 3.7.

>=20
> Thanks,
> Mathieu
>=20
>> =20
>>  	return ret;
>> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>> index 2e0ddcb2d792..08e0187a84d9 100644
>> --- a/include/linux/remoteproc.h
>> +++ b/include/linux/remoteproc.h
>> @@ -381,6 +381,8 @@ enum rsc_handling_status {
>>   * @panic:	optional callback to react to system panic, core will delay
>>   *		panic at least the returned number of milliseconds
>>   * @coredump:	  collect firmware dump after the subsystem is shutdown
>> + * @release_fw:	optional function to release the firmware image from ROM =
memories.
>> + *		This function is called after stopping the remote processor or in cas=
e of an error
>>   */
>>  struct rproc_ops {
>>  	int (*prepare)(struct rproc *rproc);
>> @@ -403,6 +405,7 @@ struct rproc_ops {
>>  	u64 (*get_boot_addr)(struct rproc *rproc, const struct firmware *fw);
>>  	unsigned long (*panic)(struct rproc *rproc);
>>  	void (*coredump)(struct rproc *rproc);
>> +	void (*release_fw)(struct rproc *rproc);
>>  };
>> =20
>>  /**
>> --=20
>> 2.25.1
>>

--===============7571903707588851442==--

