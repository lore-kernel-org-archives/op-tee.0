From: Balint Dobszay <balint.dobszay@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [RFC PATCH] tee: tstee: Add initial Trusted Services TEE driver
Date: Tue, 10 Oct 2023 17:40:49 +0200
Message-ID: <779B39B1-534A-46B8-AFCA-CAEB40B67BD0@arm.com>
In-Reply-To: <
 <CAFA6WYO57OQFVV-0ZoWq46LEGOAb+Fia3MBp5Z8QSZV_a9hwpg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7060878233608669627=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7060878233608669627==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Sumit,

On 3 Oct 2023, at 17:42, Sumit Garg wrote:
> On Wed, 27 Sept 2023 at 20:56, Balint Dobszay <balint.dobszay@arm.com> wr=
ote:
>>
>> The Trusted Services project provides a framework for developing and
>> deploying device Root Of Trust services in FF-A Secure Partitions. The
>> FF-A SPs are accessible through the FF-A driver, but this doesn't
>> provide a user space interface. The goal of this TEE driver is to make
>> Trusted Services SPs accessible for user space clients.
>
> I am interested in exploring the user space library/applications. Do
> you have a standard library implementation and some example user-space
> applications leveraging this driver interface?

Yes we have a library reference implementation in Trusted Services using
this driver called libts [1]. There are some test applications that rely
on this library, e.g. ts-service-test [2]. Also, the Parsec project can
use Trusted Services as backend through libts [3] (note, the version of
TS currently integrated in Parsec is not recent, thus the libts in there
still uses an earlier version of this driver).

[snip]

>> +static int tstee_invoke_func(struct tee_context *ctx, struct tee_ioctl_in=
voke_arg *arg,
>> +                            struct tee_param *param)
>> +{
>> +       struct tstee *tstee =3D tee_get_drvdata(ctx->teedev);
>> +       struct ffa_device *ffa_dev =3D tstee->ffa_dev;
>> +       struct ts_context_data *ctxdata =3D ctx->data;
>> +       struct ffa_send_direct_data ffa_data;
>> +       struct tee_shm *shm =3D NULL;
>> +       struct ts_session *sess;
>> +       u32 req_len, ffa_args[5] =3D {};
>> +       int shm_id, rc;
>> +       u8 iface_id;
>> +       u64 handle;
>> +       u16 opcode;
>> +
>> +       mutex_lock(&ctxdata->mutex);
>> +       sess =3D find_session(ctxdata, arg->session);
>> +
>> +       /* Do this while holding the mutex to make sure that the session w=
asn't closed meanwhile */
>> +       if (sess)
>> +               iface_id =3D sess->iface_id;
>> +
>> +       mutex_unlock(&ctxdata->mutex);
>> +       if (!sess)
>> +               return -EINVAL;
>> +
>> +       opcode =3D lower_16_bits(arg->func);
>> +       shm_id =3D lower_32_bits(param[0].u.value.a);
>> +       req_len =3D lower_32_bits(param[0].u.value.b);
>> +
>> +       if (shm_id !=3D 0) {
>> +               shm =3D tee_shm_get_from_id(ctx, shm_id);
>> +               if (IS_ERR(shm))
>> +                       return PTR_ERR(shm);
>> +
>> +               if (shm->size < req_len) {
>> +                       pr_err("request doesn't fit into shared memory buf=
fer\n");
>> +                       rc =3D -EINVAL;
>> +                       goto out;
>> +               }
>> +
>> +               handle =3D shm->sec_world_id;
>> +       } else {
>> +               handle =3D FFA_INVALID_MEM_HANDLE;
>> +       }
>> +
>> +       ffa_args[TS_RPC_CTRL_REG] =3D TS_RPC_CTRL_PACK_IFACE_OPCODE(iface_=
id, opcode);
>> +       ffa_args[TS_RPC_SERVICE_MEM_HANDLE_LSW] =3D lower_32_bits(handle);
>> +       ffa_args[TS_RPC_SERVICE_MEM_HANDLE_MSW] =3D upper_32_bits(handle);
>> +       ffa_args[TS_RPC_SERVICE_REQ_LEN] =3D req_len;
>> +       ffa_args[TS_RPC_SERVICE_CLIENT_ID] =3D 0;
>> +
>> +       arg_list_to_ffa_data(ffa_args, &ffa_data);
>> +       rc =3D ffa_dev->ops->msg_ops->sync_send_receive(ffa_dev, &ffa_data=
);
>
> I haven't dug deeper into the ABI yet, which is something I will look
> into. But these RPC commands caught my attention. Are these RPC calls
> blocking in nature? Is there a possibility that these could cause CPU
> stalls? Do the Linux interrupts remain unhandled until the RPC calls
> return?

Yes, that is correct. We did encounter CPU stalls indeed, our solution
was to enable preemption of S-EL0 SPs in OP-TEE [3] which solved the
issue.

Regards,
Balint

[1] https://git.trustedfirmware.org/TS/trusted-services.git/tree/deployments/=
libts/arm-linux?h=3Dv1.0.0
[2] https://git.trustedfirmware.org/TS/trusted-services.git/tree/deployments/=
ts-service-test/arm-linux?h=3Dv1.0.0
[3] https://github.com/parallaxsecond/parsec/tree/3bcd732b92009612109517a6c90=
75643ef648ca7/src/providers/trusted_service
[4] https://github.com/OP-TEE/optee_os/pull/6002

--===============7060878233608669627==--

