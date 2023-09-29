From: Rijo Thomas <Rijo-john.Thomas@amd.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 1/1] tee: amdtee: fix use-after-free vulnerability in
 amdtee_close_session
Date: Fri, 29 Sep 2023 11:34:26 +0530
Message-ID: <80d66581-79fa-51ea-83b2-387bf8ebf704@amd.com>
In-Reply-To: <
 <CAFA6WYOk3M1EH1KPf4w=qYaQRF6Y_cnNWimJGTyiAdEokiNMKQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6451958739394385243=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6451958739394385243==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 9/28/2023 8:35 PM, Sumit Garg wrote:
> Hi Rijo,
>=20
> On Fri, 22 Sept 2023 at 12:26, Rijo Thomas <Rijo-john.Thomas@amd.com> wro=
te:
>>
>> There is a potential race condition in amdtee_close_session that may
>> cause use-after-free in amdtee_open_session. For instance, if a session
>> has refcount =3D=3D 1, and one thread tries to free this session via:
>>
>>     kref_put(&sess->refcount, destroy_session);
>>
>> the reference count will get decremented, and the next step would be to
>> call destroy_session(). However, if in another thread,
>> amdtee_open_session() is called before destroy_session() has completed
>> execution, alloc_session() may return 'sess' that will be freed up
>> later in destroy_session() leading to use-after-free in
>> amdtee_open_session.
>>
>> To fix this issue, treat decrement of sess->refcount and invocation of
>> destroy_session() as a single critical section, so that it is executed
>> atomically.
>>
>> Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
>> Cc: stable(a)vger.kernel.org
>> Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
>> ---
>>  drivers/tee/amdtee/core.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
>> index 372d64756ed6..04cee03bec9d 100644
>> --- a/drivers/tee/amdtee/core.c
>> +++ b/drivers/tee/amdtee/core.c
>> @@ -217,14 +217,13 @@ static int copy_ta_binary(struct tee_context *ctx, v=
oid *ptr, void **ta,
>>         return rc;
>>  }
>>
>> +/* mutex must be held by caller */
>>  static void destroy_session(struct kref *ref)
>>  {
>>         struct amdtee_session *sess =3D container_of(ref, struct amdtee_se=
ssion,
>>                                                    refcount);
>>
>> -       mutex_lock(&session_list_mutex);
>>         list_del(&sess->list_node);
>> -       mutex_unlock(&session_list_mutex);
>>         kfree(sess);
>>  }
>>
>> @@ -272,7 +271,9 @@ int amdtee_open_session(struct tee_context *ctx,
>>         if (arg->ret !=3D TEEC_SUCCESS) {
>>                 pr_err("open_session failed %d\n", arg->ret);
>>                 handle_unload_ta(ta_handle);
>> +               mutex_lock(&session_list_mutex);
>>                 kref_put(&sess->refcount, destroy_session);
>=20
> How about you rather use kref_put_mutex() here and then keep the
> mutex_unlock() within the destroy_session()?
>=20

Sure. I can do that. I will post v2 of this patch.

Thanks,
Rijo

>> +               mutex_unlock(&session_list_mutex);
>>                 goto out;
>>         }
>>
>> @@ -290,7 +291,9 @@ int amdtee_open_session(struct tee_context *ctx,
>>                 pr_err("reached maximum session count %d\n", TEE_NUM_SESSI=
ONS);
>>                 handle_close_session(ta_handle, session_info);
>>                 handle_unload_ta(ta_handle);
>> +               mutex_lock(&session_list_mutex);
>>                 kref_put(&sess->refcount, destroy_session);
>=20
> Ditto.
>=20
>> +               mutex_unlock(&session_list_mutex);
>>                 rc =3D -ENOMEM;
>>                 goto out;
>>         }
>> @@ -331,7 +334,9 @@ int amdtee_close_session(struct tee_context *ctx, u32 =
session)
>>         handle_close_session(ta_handle, session_info);
>>         handle_unload_ta(ta_handle);
>>
>> +       mutex_lock(&session_list_mutex);
>>         kref_put(&sess->refcount, destroy_session);
>=20
> Ditto.
>=20
> -Sumit
>=20
>> +       mutex_unlock(&session_list_mutex);
>>
>>         return 0;
>>  }
>> --
>> 2.25.1
>>

--===============6451958739394385243==--

