From: Allen Pais <apais@linux.microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 1/2] optee: fix tee out of memory failure seen during
 kexec reboot
Date: Tue, 02 Mar 2021 11:21:33 +0530
Message-ID: <6f1c6529-7c89-21c9-0ce6-28545c251a9f@linux.microsoft.com>
In-Reply-To: <
 <CAHUa44F5Ew6U80t7PPmV1J4KunXBm_izBxVrxg=x8azjBz0r9Q@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3147361091143512002=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3147361091143512002==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

>>
>> From: Allen Pais <apais@linux.microsoft.com>
>>
>> The following out of memory errors are seen on kexec reboot
>> from the optee core.
>>
>> [    0.368428] tee_bnxt_fw optee-clnt0: tee_shm_alloc failed
>> [    0.368461] tee_bnxt_fw: probe of optee-clnt0 failed with error -22
>>
>> tee_shm_release() is not invoked on dma shm buffer.
>>
>> Implement .shutdown() method to handle the release of the buffers
>> correctly.
>>
>> More info:
>> https://github.com/OP-TEE/optee_os/issues/3637
>>
>> Signed-off-by: Allen Pais <apais@linux.microsoft.com>
>> ---
>>   drivers/tee/optee/core.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>=20
> This looks good to me. Do you have a practical way of testing this on
> QEMU for instance?

   I have not tried this on QEMU. I will give it a go today.

Thanks.

>=20
> Thanks,
> Jens
>=20
>>
>> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
>> index cf4718c6d35d..80e2774b5e2a 100644
>> --- a/drivers/tee/optee/core.c
>> +++ b/drivers/tee/optee/core.c
>> @@ -582,6 +582,13 @@ static optee_invoke_fn *get_invoke_func(struct device=
 *dev)
>>          return ERR_PTR(-EINVAL);
>>   }
>>
>> +/* optee_remove - Device Removal Routine
>> + * @pdev: platform device information struct
>> + *
>> + * optee_remove is called by platform subsystem to alter the driver
>> + * that it should release the device
>> + */
>> +
>>   static int optee_remove(struct platform_device *pdev)
>>   {
>>          struct optee *optee =3D platform_get_drvdata(pdev);
>> @@ -612,6 +619,18 @@ static int optee_remove(struct platform_device *pdev)
>>          return 0;
>>   }
>>
>> +/* optee_shutdown - Device Removal Routine
>> + * @pdev: platform device information struct
>> + *
>> + * platform_shutdown is called by the platform subsystem to alter
>> + * the driver that a shutdown/reboot(or kexec) is happening and
>> + * device must be disabled.
>> + */
>> +static void optee_shutdown(struct platform_device *pdev)
>> +{
>> +       optee_disable_shm_cache(platform_get_drvdata(pdev));
>> +}
>> +
>>   static int optee_probe(struct platform_device *pdev)
>>   {
>>          optee_invoke_fn *invoke_fn;
>> @@ -738,6 +757,7 @@ MODULE_DEVICE_TABLE(of, optee_dt_match);
>>   static struct platform_driver optee_driver =3D {
>>          .probe  =3D optee_probe,
>>          .remove =3D optee_remove,
>> +       .shutdown =3D optee_shutdown,
>>          .driver =3D {
>>                  .name =3D "optee",
>>                  .of_match_table =3D optee_dt_match,
>> --
>> 2.25.1
>>

--===============3147361091143512002==--

