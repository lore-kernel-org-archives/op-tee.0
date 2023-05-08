From: Rijo Thomas <Rijo-john.Thomas@amd.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH 1/1] tee: amdtee: Add return_origin to 'struct tee_cmd_load_ta'
Date: Mon, 08 May 2023 16:42:04 +0530
Message-ID: <b43b203d-5759-0c33-8587-4e84025552d7@amd.com>
In-Reply-To: <
 <CAHUa44Gm5jmm=mEfowcmabaoWFFbCLiDd5NdPSArCPHsjcpOBw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2758976628720475435=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2758976628720475435==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 5/5/2023 1:00 PM, Jens Wiklander wrote:
> Hi,
>=20
> On Tue, May 2, 2023 at 8:25=E2=80=AFAM Rijo Thomas <Rijo-john.Thomas@amd.=
com> wrote:
>>
>> After TEE has completed processing of TEE_CMD_ID_LOAD_TA, set proper
>> value in 'return_origin' argument passed by open_session() call. To do
>> so, add 'return_origin' field to the structure tee_cmd_load_ta. The
>> Trusted OS shall update return_origin as part of TEE processing.
>>
>> This change to 'struct tee_cmd_load_ta' interface requires a similar update
>> in AMD-TEE Trusted OS's TEE_CMD_ID_LOAD_TA interface.
>=20
> This is an ABI change, but it's not clear if it's an incompatible ABI
> change or not. What happens if the AMD-TEE Trusted OS isn't updated?
>=20

If AMD-TEE Trusted OS isn't updated, load_cmd.return_origin value will be 0.

load_cmd.return_origin will have non-zero value only if AMD-TEE Trusted OS on
the platform has the necessary ABI change.

At present, without this patch, arg->ret_origin is 0 and even with this patch
it will be 0 unless AMD-TEE Trusted OS on the platform has the ABI update. So,
this is not an incompatible ABI change.

>>
>> This patch has been verified on Phoenix Birman setup. On older APUs,
>> return_origin value will be 0.
>=20
> Why, because MD-TEE Trusted OS will not be updated on the older APUs?
>=20

Yes, that's correct - older APUs will not have updated AMD-TEE Trusted OS.

>>
>> Cc: stable(a)vger.kernel.org
>=20
> Which stable kernels are you targeting? A Fixes tag might answer that.
>=20

Okay, I will add a Fixes tag and post v2 patch.

Thanks,
Rijo

> Thanks,
> Jens
>=20
>> Tested-by: Sourabh Das <sourabh.das@amd.com>
>> Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
>> ---
>>  drivers/tee/amdtee/amdtee_if.h | 10 ++++++----
>>  drivers/tee/amdtee/call.c      | 30 +++++++++++++++++-------------
>>  2 files changed, 23 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/tee/amdtee/amdtee_if.h b/drivers/tee/amdtee/amdtee_if=
.h
>> index ff48c3e47375..e2014e21530a 100644
>> --- a/drivers/tee/amdtee/amdtee_if.h
>> +++ b/drivers/tee/amdtee/amdtee_if.h
>> @@ -118,16 +118,18 @@ struct tee_cmd_unmap_shared_mem {
>>
>>  /**
>>   * struct tee_cmd_load_ta - load Trusted Application (TA) binary into TEE
>> - * @low_addr:    [in] bits [31:0] of the physical address of the TA binary
>> - * @hi_addr:     [in] bits [63:32] of the physical address of the TA bina=
ry
>> - * @size:        [in] size of TA binary in bytes
>> - * @ta_handle:   [out] return handle of the loaded TA
>> + * @low_addr:       [in] bits [31:0] of the physical address of the TA bi=
nary
>> + * @hi_addr:        [in] bits [63:32] of the physical address of the TA b=
inary
>> + * @size:           [in] size of TA binary in bytes
>> + * @ta_handle:      [out] return handle of the loaded TA
>> + * @return_origin:  [out] origin of return code after TEE processing
>>   */
>>  struct tee_cmd_load_ta {
>>         u32 low_addr;
>>         u32 hi_addr;
>>         u32 size;
>>         u32 ta_handle;
>> +       u32 return_origin;
>>  };
>>
>>  /**
>> diff --git a/drivers/tee/amdtee/call.c b/drivers/tee/amdtee/call.c
>> index e8cd9aaa3467..e9b63dcb3194 100644
>> --- a/drivers/tee/amdtee/call.c
>> +++ b/drivers/tee/amdtee/call.c
>> @@ -423,19 +423,23 @@ int handle_load_ta(void *data, u32 size, struct tee_=
ioctl_open_session_arg *arg)
>>         if (ret) {
>>                 arg->ret_origin =3D TEEC_ORIGIN_COMMS;
>>                 arg->ret =3D TEEC_ERROR_COMMUNICATION;
>> -       } else if (arg->ret =3D=3D TEEC_SUCCESS) {
>> -               ret =3D get_ta_refcount(load_cmd.ta_handle);
>> -               if (!ret) {
>> -                       arg->ret_origin =3D TEEC_ORIGIN_COMMS;
>> -                       arg->ret =3D TEEC_ERROR_OUT_OF_MEMORY;
>> -
>> -                       /* Unload the TA on error */
>> -                       unload_cmd.ta_handle =3D load_cmd.ta_handle;
>> -                       psp_tee_process_cmd(TEE_CMD_ID_UNLOAD_TA,
>> -                                           (void *)&unload_cmd,
>> -                                           sizeof(unload_cmd), &ret);
>> -               } else {
>> -                       set_session_id(load_cmd.ta_handle, 0, &arg->sessio=
n);
>> +       } else {
>> +               arg->ret_origin =3D load_cmd.return_origin;
>> +
>> +               if (arg->ret =3D=3D TEEC_SUCCESS) {
>> +                       ret =3D get_ta_refcount(load_cmd.ta_handle);
>> +                       if (!ret) {
>> +                               arg->ret_origin =3D TEEC_ORIGIN_COMMS;
>> +                               arg->ret =3D TEEC_ERROR_OUT_OF_MEMORY;
>> +
>> +                               /* Unload the TA on error */
>> +                               unload_cmd.ta_handle =3D load_cmd.ta_handl=
e;
>> +                               psp_tee_process_cmd(TEE_CMD_ID_UNLOAD_TA,
>> +                                                   (void *)&unload_cmd,
>> +                                                   sizeof(unload_cmd), &r=
et);
>> +                       } else {
>> +                               set_session_id(load_cmd.ta_handle, 0, &arg=
->session);
>> +                       }
>>                 }
>>         }
>>         mutex_unlock(&ta_refcount_mutex);
>> --
>> 2.25.1
>>

--===============2758976628720475435==--

