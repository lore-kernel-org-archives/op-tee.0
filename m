From: Allen Pais <apais@linux.microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v3 5/7] tee: Support shm registration without dma-buf backing
Date: Thu, 10 Jun 2021 13:10:35 +0530
Message-ID: <F2A9E44A-137B-4081-AA82-B84FF4761957@linux.microsoft.com>
In-Reply-To: <20210609121533.GA2267052@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8999949362758292221=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8999949362758292221==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

>>=20
>> AFAIK, its due the the inherent nature of tee_shm_alloc() and
>> tee_shm_register() where tee_shm_alloc() doesn't need to know whether
>> its a kernel or user-space memory since it is the one that allocates
>> whereas tee_shm_register() need to know that since it has to register
>> pre-allocated client memory.
>>=20
>>> - Why does tee_shm_register() unconditionally use non-contiguous
>>>  allocations without ever taking into account whether or not
>>>  OPTEE_SMC_SEC_CAP_DYNAMIC_SHM was set? It sounds like that's required
>>>  from my reading of https://optee.readthedocs.io/en/latest/architecture/c=
ore.html#noncontiguous-shared-buffers.
>>=20
>> Yeah, but do we have platforms in OP-TEE that don't support dynamic
>> shared memory? I guess it has become the sane default which is a
>> mandatory requirement when it comes to OP-TEE driver in u-boot.
>>=20
>>> - Why is TEE_SHM_REGISTER implemented at the TEE driver level when it is
>>>  specific to OP-TEE? How to better abstract that away?
>>>=20
>>=20
>> I would like you to go through Section "3.2.4. Shared Memory" in TEE
>> Client API Specification. There are two standard ways for shared
>> memory approach with TEE:
>>=20
>> 1. A Shared Memory block can either be existing Client Application
>> memory (kernel driver in our case) which is subsequently registered
>> with the TEE Client API (using tee_shm_register() in our case).
>>=20
>> 2. Or memory which is allocated on behalf of the Client Application
>> using the TEE
>> Client API (using tee_shm_alloc() in our case).
>>=20
>>> Let me know if you agree with the more minimal approach that I took for
>>> these bug fix series or still feel like tee_shm_register() should be
>>> fixed up so that it is usable. Thanks!
>>=20
>> From drivers perspective I think the change should be:
>>=20
>> tee_shm_alloc()
>>=20
>> to
>>=20
>> kcalloc()
>> tee_shm_register()
>=20
> I've just posted "[PATCH 0/7] tee: shared memory updates",
> https://lore.kernel.org/lkml/20210609102324.2222332-1-jens.wiklander(a)lina=
ro.org/
>=20
> Where tee_shm_alloc() is replaced by among other functions
> tee_shm_alloc_kernel_buf(). tee_shm_alloc_kernel_buf() takes care of the
> problem with TEE_SHM_DMA_BUF.
>=20

Thanks Jens. The series looks fine.  Tested too.

- Allen


--===============8999949362758292221==--

