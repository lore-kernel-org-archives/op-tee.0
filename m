From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v13 4/7] remoteproc: Introduce release_fw optional operation
Date: Wed, 20 Nov 2024 17:08:08 +0100
Message-ID: <b3fd3231-3b09-4eef-9ea6-c11b54c712c4@foss.st.com>
In-Reply-To: <
 <CANLsYkxvTuLv8Omw-UeyPaA9g9QokmtMaMYD0eoUPo20wUuONQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3850905311592455492=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3850905311592455492==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 11/19/24 21:38, Mathieu Poirier wrote:
> On Tue, 19 Nov 2024 at 11:14, Arnaud POULIQUEN
> <arnaud.pouliquen@foss.st.com> wrote:
>>
>> Hello Mathieu,
>>
>> On 11/18/24 18:52, Mathieu Poirier wrote:
>>> On Mon, Nov 04, 2024 at 02:35:12PM +0100, Arnaud Pouliquen wrote:
>>>> This patch updates the rproc_ops struct to include an optional
>>>> release_fw function.
>>>>
>>>> The release_fw ops is responsible for releasing the remote processor
>>>> firmware image. The ops is called in the following cases:
>>>>
>>>>  - An error occurs in rproc_start() between the loading of the segments =
and
>>>>       the start of the remote processor.
>>>>  - after stopping the remote processor.
>>>>
>>>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>>>> ---
>>>> Updates from version V11:
>>>> - fix typo in @release_fw comment
>>>> ---
>>>>  drivers/remoteproc/remoteproc_core.c | 5 +++++
>>>>  include/linux/remoteproc.h           | 3 +++
>>>>  2 files changed, 8 insertions(+)
>>>>
>>>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/r=
emoteproc_core.c
>>>> index 7694817f25d4..46863e1ca307 100644
>>>> --- a/drivers/remoteproc/remoteproc_core.c
>>>> +++ b/drivers/remoteproc/remoteproc_core.c
>>>> @@ -1258,6 +1258,9 @@ static int rproc_alloc_registered_carveouts(struct=
 rproc *rproc)
>>>>
>>>>  static void rproc_release_fw(struct rproc *rproc)
>>>>  {
>>>> +    if (rproc->ops->release_fw)
>>>> +            rproc->ops->release_fw(rproc);
>>>> +
>>>>      /* Free the copy of the resource table */
>>>>      kfree(rproc->cached_table);
>>>>      rproc->cached_table =3D NULL;
>>>> @@ -1377,6 +1380,8 @@ static int rproc_start(struct rproc *rproc, const =
struct firmware *fw)
>>>>  unprepare_subdevices:
>>>>      rproc_unprepare_subdevices(rproc);
>>>>  reset_table_ptr:
>>>> +    if (rproc->ops->release_fw)
>>>> +            rproc->ops->release_fw(rproc);
>>>>      rproc->table_ptr =3D rproc->cached_table;
>>>
>>> I suggest the following:
>>>
>>> 1) Create two new functions, i.e rproc_load_fw() and rproc_release_fw(). =
 The
>>> only thing those would do is call rproc->ops->load_fw() and
>>> rproc->ops->release_fw(), if they are present.  When a TEE interface is
>>> available, ->load_fw() and ->release_fw() become rproc_tee_load_fw() and
>>> rproc_tee_release_fw().
>>
>>
>> I'm wondering if it should be ->preload_fw() instead of ->load_fw() ops, a=
s the
>> ->load() op already exists.
>>
>=20
> I agree that ->load() and ->load_fw() will lead to confusion.  I would
> support ->preload_fw() but there is no obvious antonyme.
>=20
> Since we already have rproc_ops::prepare() and rproc_prepare_device()
> I suggest rproc_ops::prepare_fw() and rproc_prepare_fw().  The
> corollary would be rproc_ops::unprepare_fw() and rproc_unprepare_fm().
> That said, I'm open to other ideas should you be interested in finding
> other alternatives.
>=20


1) Using ops::prepare_fw/unprepare_fw:
My concern is that it could also lead to confusion as we would load the firmw=
are
on ops::prepare_fw and do nothing on ops::load(). That would not match with t=
he
ops action. look to me that in this option, ops::load() must be kept as
mandatory ops for consistence.


2) Using ops::preload_fw:
This seems to better reflect the use case. Concerning the antonym choice , co=
uld
we consider that ops::release_fw() is the antonym of both ops;;preload_fw and
ops::load?
some other antonym proposal:
 - unload_fw
 - postunload_fw


3) Other alternatives:

3-a) using ops::rproc_prepare/unprepare_device.
Same concern that prepare_fw/unprepare_fw
another drawbackis that rproc_tee_load_fw() would be not directly mapped to an
rproc ops but platform
driver should need to call rproc_tee_load_fw() into its ops::prepare() functi=
on
(a.e stm32_rproc_prepare).


3-b) Another alternative I can see is the one I proposed in version 3 [1]. The
principle was to keep existing ops but propose an alternative boot sequence.
Perhaps a backup solution is to reanalyze this option if no other is suitable.

[1]
https://lore.kernel.org/lkml/8af59b01-53cf-4fc4-9946-6c630fb7b38e(a)quicinc.c=
om/T/

Please just tell/confirm me your prefered solution that I propose it in next
revision.

Regards,
Arnaud

>>>
>>> 2) Call rproc_load_fw() in rproc_boot(), just before rproc_fw_boot().  If=
 the
>>> call to rproc_fw_boot() fails, call rproc_release_fw().
>>>
>>> 3) The same logic applies to rproc_boot_recovery(), i.e call rproc_load_f=
w()
>>> before rproc_start() and call rproc_release_fw() if rproc_start() fails.
>>
>>
>> I implemented this and I'm currently testing it.
>> Thise second part requires a few adjustments to work. The ->load() ops nee=
ds to
>> becomes optional to not be called if the "->preload_fw()" is used.
>>
>> For that, I propose to return 0 in rproc_load_segments if rproc->ops->load=
 is
>> NULL and compensate by checking that at least "->preload_fw()" or ->load()=
 is
>> non-null in rproc_alloc_ops.
>>
>=20
> I agree.
>=20
>> Thanks,
>> Arnaud
>>
>>
>>>
>>> 4) Take rproc_tee_load_fw() out of rproc_tee_parse_fw().  It will now be =
called
>>> in rproc_load_fw().
>>>
>>> 5) As stated above function rproc_release_fw() now calls rproc_tee_releas=
e_fw().
>>> The former is already called in rproc_shutdown() so we are good in that f=
ront.
>>>
>>> With the above the cached_table management within the core remains the sa=
me and
>>> we can get rid of patch 3.7.
>>
>>>
>>> Thanks,
>>> Mathieu
>>>
>>>>
>>>>      return ret;
>>>> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>>>> index 2e0ddcb2d792..08e0187a84d9 100644
>>>> --- a/include/linux/remoteproc.h
>>>> +++ b/include/linux/remoteproc.h
>>>> @@ -381,6 +381,8 @@ enum rsc_handling_status {
>>>>   * @panic:  optional callback to react to system panic, core will delay
>>>>   *          panic at least the returned number of milliseconds
>>>>   * @coredump:         collect firmware dump after the subsystem is shut=
down
>>>> + * @release_fw:     optional function to release the firmware image fro=
m ROM memories.
>>>> + *          This function is called after stopping the remote processor=
 or in case of an error
>>>>   */
>>>>  struct rproc_ops {
>>>>      int (*prepare)(struct rproc *rproc);
>>>> @@ -403,6 +405,7 @@ struct rproc_ops {
>>>>      u64 (*get_boot_addr)(struct rproc *rproc, const struct firmware *fw=
);
>>>>      unsigned long (*panic)(struct rproc *rproc);
>>>>      void (*coredump)(struct rproc *rproc);
>>>> +    void (*release_fw)(struct rproc *rproc);
>>>>  };
>>>>
>>>>  /**
>>>> --
>>>> 2.25.1
>>>>

--===============3850905311592455492==--

