From: Jerome Forissier <jerome@forissier.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH] tee: optee: do not check memref size on return from Secure World
Date: Wed, 19 Jan 2022 09:11:42 +0100
Message-ID: <49c180ae-6a7b-1f2c-b6c9-686ea4331c81@forissier.org>
In-Reply-To: <
 <CAHUa44Hff45AQxpqPT5_pKF3hTNGmcxhuGphdND=NRJVUpj5og@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4089727034786801430=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4089727034786801430==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

[-CC linux-kernel]

On 1/19/22 08:32, Jens Wiklander wrote:
> On Tue, Jan 18, 2022 at 1:05 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>>
>> Hi Jerome,
>>
>> On Thu, 13 Jan 2022 at 20:57, Jerome Forissier <jerome@forissier.org> wr=
ote:
>>>
>>> Commit c650b8dc7a79 ("tee: optee: do not check memref size on return
>>> from Secure World") was mistakenly lost in commit 4602c5842f64 ("optee:
>>> refactor driver with internal callbacks"). Remove the unwanted code
>>> again.
>>>
>>
>> Ah, that's unfortunate. The refactoring that OP-TEE driver has gone
>> through to support multiple ABIs (SMC and FF-A) was huge and I missed
>> it during review.
>>
>>> Fixes: 4602c5842f64 ("optee: refactor driver with internal callbacks")
>>> Signed-off-by: Jerome Forissier <jerome@forissier.org>
>>> ---
>>>  drivers/tee/optee/smc_abi.c | 10 ----------
>>>  1 file changed, 10 deletions(-)
>>>
>>
>> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
>=20
> I'm picking up this.

Thanks. Therefore, I have added the patch on top of the Linaro optee
branch [1] so it gets included in the coming release.

[1] https://github.com/linaro-swg/linux/commits/optee

--=20
Jerome

>=20
> Thanks,
> Jens
>=20
>>
>> -Sumit
>>
>>> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
>>> index cf2e3293567d..09e7ec673bb6 100644
>>> --- a/drivers/tee/optee/smc_abi.c
>>> +++ b/drivers/tee/optee/smc_abi.c
>>> @@ -71,16 +71,6 @@ static int from_msg_param_tmp_mem(struct tee_param *p,=
 u32 attr,
>>>         p->u.memref.shm_offs =3D mp->u.tmem.buf_ptr - pa;
>>>         p->u.memref.shm =3D shm;
>>>
>>> -       /* Check that the memref is covered by the shm object */
>>> -       if (p->u.memref.size) {
>>> -               size_t o =3D p->u.memref.shm_offs +
>>> -                          p->u.memref.size - 1;
>>> -
>>> -               rc =3D tee_shm_get_pa(shm, o, NULL);
>>> -               if (rc)
>>> -                       return rc;
>>> -       }
>>> -
>>>         return 0;
>>>  }
>>>
>>> --
>>> 2.32.0
>>>

--===============4089727034786801430==--

