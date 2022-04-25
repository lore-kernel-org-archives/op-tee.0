From: Andrew Davis <afd@ti.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 2/2] tee: remove flags TEE_IOCTL_SHM_MAPPED and
 TEE_IOCTL_SHM_DMA_BUF
Date: Mon, 25 Apr 2022 08:59:22 -0500
Message-ID: <06faec69-15e8-2aca-24cd-a4d7034c5920@ti.com>
In-Reply-To: <
 <CAFA6WYPK2NS08pdzqS5Ze5pdJic2iQ7hC6h0SK+JT=EbPkg+Sg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6166177200517110186=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6166177200517110186==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 4/25/22 1:46 AM, Sumit Garg wrote:
> On Fri, 22 Apr 2022 at 23:31, Andrew Davis <afd@ti.com> wrote:
>>
>> These look to be leftover from an early edition of this driver. Userspace
>> does not need this information. Checking all users of this that I have
>> access to I have verified no one is using them.
>>
>> They leak internal use flags out to userspace. Even more they are not
>> correct anymore after a45ea4efa358. Lets drop these flags before
>> someone does try to use them for something and they become ABI.
>>
>=20
> Sounds reasonable to me.
>=20
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> ---
>>   drivers/tee/tee_core.c   | 1 -
>>   include/uapi/linux/tee.h | 4 ----
>>   2 files changed, 5 deletions(-)
>>
>> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
>> index 8aa1a4836b92f..650dd87a38e77 100644
>> --- a/drivers/tee/tee_core.c
>> +++ b/drivers/tee/tee_core.c
>> @@ -339,7 +339,6 @@ tee_ioctl_shm_register(struct tee_context *ctx,
>>                  return PTR_ERR(shm);
>>
>>          data.id =3D shm->id;
>> -       data.flags =3D shm->flags;
>>          data.length =3D shm->size;
>>
>=20
> This change is required for tee_ioctl_shm_alloc() as well.
>=20


Indeed it is, adding for v2.

Thanks,
Andrew


> -Sumit
>=20
>>          if (copy_to_user(udata, &data, sizeof(data)))
>> diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
>> index 25a6c534beb1b..23e57164693c4 100644
>> --- a/include/uapi/linux/tee.h
>> +++ b/include/uapi/linux/tee.h
>> @@ -42,10 +42,6 @@
>>   #define TEE_IOC_MAGIC  0xa4
>>   #define TEE_IOC_BASE   0
>>
>> -/* Flags relating to shared memory */
>> -#define TEE_IOCTL_SHM_MAPPED   0x1     /* memory mapped in normal world */
>> -#define TEE_IOCTL_SHM_DMA_BUF  0x2     /* dma-buf handle on shared memory=
 */
>> -
>>   #define TEE_MAX_ARG_SIZE       1024
>>
>>   #define TEE_GEN_CAP_GP         (1 << 0)/* GlobalPlatform compliant TEE */
>> --
>> 2.17.1
>>

--===============6166177200517110186==--

