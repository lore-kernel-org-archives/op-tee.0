From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v5 8/8] firmware: tee_bnxt: Release TEE shm, session, and
 context during kexec
Date: Mon, 19 Jul 2021 12:49:51 +0200
Message-ID: 
 <CAHUa44EetPuA_5+UQLW-c=-_OApiRoiq+YjeFs6TRPj6=AJfHw@mail.gmail.com>
In-Reply-To: <
 <CAHLZf_t5U1bh1H8sULbJz7xrZ-r3Dcmxuw9MMmG2fehS3C72uQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1799254290202662659=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1799254290202662659==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 16, 2021 at 4:48 AM Vikas Gupta <vikas.gupta@broadcom.com> wrot=
e:
>
> Hi Allen/Tyler,
>  The patch looks good to me.

Thanks.

Rafal, is it OK if I include this patch together with the rest of the
patches in this patch set in a pull request to arm-soc?

Thanks,
Jens

>
> Thanks,
> Vikas
>
>>
>> > From: Allen Pais <apais@linux.microsoft.com>
>> >
>> > Implement a .shutdown hook that will be called during a kexec operation
>> > so that the TEE shared memory, session, and context that were set up
>> > during .probe can be properly freed/closed.
>> >
>> > Additionally, don't use dma-buf backed shared memory for the
>> > fw_shm_pool. dma-buf backed shared memory cannot be reliably freed and
>> > unregistered during a kexec operation even when tee_shm_free() is called
>> > on the shm from a .shutdown hook. The problem occurs because
>> > dma_buf_put() calls fput() which then uses task_work_add(), with the
>> > TWA_RESUME parameter, to queue tee_shm_release() to be called before the
>> > current task returns to user mode. However, the current task never
>> > returns to user mode before the kexec completes so the memory is never
>> > freed nor unregistered.
>> >
>> > Use tee_shm_alloc_kernel_buf() to avoid dma-buf backed shared memory
>> > allocation so that tee_shm_free() can directly call tee_shm_release().
>> > This will ensure that the shm can be freed and unregistered during a
>> > kexec operation.
>> >
>> > Fixes: 246880958ac9 ("firmware: broadcom: add OP-TEE based BNXT f/w mana=
ger")
>> > Cc: stable(a)vger.kernel.org
>> > Signed-off-by: Allen Pais <apais@linux.microsoft.com>
>> > Co-developed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
>> > Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
>> > ---
>> >  drivers/firmware/broadcom/tee_bnxt_fw.c | 14 +++++++++++---
>> >  1 file changed, 11 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/drivers/firmware/broadcom/tee_bnxt_fw.c b/drivers/firmware/=
broadcom/tee_bnxt_fw.c
>> > index ed10da5313e8..a5bf4c3f6dc7 100644
>> > --- a/drivers/firmware/broadcom/tee_bnxt_fw.c
>> > +++ b/drivers/firmware/broadcom/tee_bnxt_fw.c
>> > @@ -212,10 +212,9 @@ static int tee_bnxt_fw_probe(struct device *dev)
>> >
>> >       pvt_data.dev =3D dev;
>> >
>> > -     fw_shm_pool =3D tee_shm_alloc(pvt_data.ctx, MAX_SHM_MEM_SZ,
>> > -                                 TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
>> > +     fw_shm_pool =3D tee_shm_alloc_kernel_buf(pvt_data.ctx, MAX_SHM_MEM=
_SZ);
>> >       if (IS_ERR(fw_shm_pool)) {
>> > -             dev_err(pvt_data.dev, "tee_shm_alloc failed\n");
>> > +             dev_err(pvt_data.dev, "tee_shm_alloc_kernel_buf failed\n");
>> >               err =3D PTR_ERR(fw_shm_pool);
>> >               goto out_sess;
>> >       }
>> > @@ -242,6 +241,14 @@ static int tee_bnxt_fw_remove(struct device *dev)
>> >       return 0;
>> >  }
>> >
>> > +static void tee_bnxt_fw_shutdown(struct device *dev)
>> > +{
>> > +     tee_shm_free(pvt_data.fw_shm_pool);
>> > +     tee_client_close_session(pvt_data.ctx, pvt_data.session_id);
>> > +     tee_client_close_context(pvt_data.ctx);
>> > +     pvt_data.ctx =3D NULL;
>> > +}
>> > +
>> >  static const struct tee_client_device_id tee_bnxt_fw_id_table[] =3D {
>> >       {UUID_INIT(0x6272636D, 0x2019, 0x0716,
>> >                   0x42, 0x43, 0x4D, 0x5F, 0x53, 0x43, 0x48, 0x49)},
>> > @@ -257,6 +264,7 @@ static struct tee_client_driver tee_bnxt_fw_driver =
=3D {
>> >               .bus            =3D &tee_bus_type,
>> >               .probe          =3D tee_bnxt_fw_probe,
>> >               .remove         =3D tee_bnxt_fw_remove,
>> > +             .shutdown       =3D tee_bnxt_fw_shutdown,
>> >       },
>> >  };
>> >
>> > --
>> > 2.25.1
>> >
>>
>> ----- End forwarded message -----

--===============1799254290202662659==--

