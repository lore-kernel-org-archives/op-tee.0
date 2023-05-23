From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v2 1/1] tee: amdtee: Add return_origin to 'struct tee_cmd_load_ta'
Date: Tue, 23 May 2023 08:07:12 +0200
Message-ID: 
 <CAHUa44EStHOWapDrbunf-vazBUVdObEXj+gAm6ShWUwx8AUr9g@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYNOjkU_4Kg=khuki3qv95f+bUB5hJUjRy2CoPXDvqW0Sw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6920537558034523609=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6920537558034523609==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 10, 2023 at 1:19=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> On Tue, 9 May 2023 at 13:03, Rijo Thomas <Rijo-john.Thomas@amd.com> wrote:
> >
> > After TEE has completed processing of TEE_CMD_ID_LOAD_TA, set proper
> > value in 'return_origin' argument passed by open_session() call. To do
> > so, add 'return_origin' field to the structure tee_cmd_load_ta. The
> > Trusted OS shall update return_origin as part of TEE processing.
> >
> > This change to 'struct tee_cmd_load_ta' interface requires a similar upda=
te
> > in AMD-TEE Trusted OS's TEE_CMD_ID_LOAD_TA interface.
> >
> > This patch has been verified on Phoenix Birman setup. On older APUs,
> > return_origin value will be 0.
> >
> > Cc: stable(a)vger.kernel.org
> > Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
> > Tested-by: Sourabh Das <sourabh.das@amd.com>
> > Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
> > ---
> > v2:
> >  * Added Fixes tag.
> >
> >  drivers/tee/amdtee/amdtee_if.h | 10 ++++++----
> >  drivers/tee/amdtee/call.c      | 30 +++++++++++++++++-------------
> >  2 files changed, 23 insertions(+), 17 deletions(-)
> >
>
> Acked-by: Sumit Garg <sumit.garg@linaro.org>

I'm picking up this.

Thanks,
Jens

>
> -Sumit
>
> > diff --git a/drivers/tee/amdtee/amdtee_if.h b/drivers/tee/amdtee/amdtee_i=
f.h
> > index ff48c3e47375..e2014e21530a 100644
> > --- a/drivers/tee/amdtee/amdtee_if.h
> > +++ b/drivers/tee/amdtee/amdtee_if.h
> > @@ -118,16 +118,18 @@ struct tee_cmd_unmap_shared_mem {
> >
> >  /**
> >   * struct tee_cmd_load_ta - load Trusted Application (TA) binary into TEE
> > - * @low_addr:    [in] bits [31:0] of the physical address of the TA bina=
ry
> > - * @hi_addr:     [in] bits [63:32] of the physical address of the TA bin=
ary
> > - * @size:        [in] size of TA binary in bytes
> > - * @ta_handle:   [out] return handle of the loaded TA
> > + * @low_addr:       [in] bits [31:0] of the physical address of the TA b=
inary
> > + * @hi_addr:        [in] bits [63:32] of the physical address of the TA =
binary
> > + * @size:           [in] size of TA binary in bytes
> > + * @ta_handle:      [out] return handle of the loaded TA
> > + * @return_origin:  [out] origin of return code after TEE processing
> >   */
> >  struct tee_cmd_load_ta {
> >         u32 low_addr;
> >         u32 hi_addr;
> >         u32 size;
> >         u32 ta_handle;
> > +       u32 return_origin;
> >  };
> >
> >  /**
> > diff --git a/drivers/tee/amdtee/call.c b/drivers/tee/amdtee/call.c
> > index e8cd9aaa3467..e9b63dcb3194 100644
> > --- a/drivers/tee/amdtee/call.c
> > +++ b/drivers/tee/amdtee/call.c
> > @@ -423,19 +423,23 @@ int handle_load_ta(void *data, u32 size, struct tee=
_ioctl_open_session_arg *arg)
> >         if (ret) {
> >                 arg->ret_origin =3D TEEC_ORIGIN_COMMS;
> >                 arg->ret =3D TEEC_ERROR_COMMUNICATION;
> > -       } else if (arg->ret =3D=3D TEEC_SUCCESS) {
> > -               ret =3D get_ta_refcount(load_cmd.ta_handle);
> > -               if (!ret) {
> > -                       arg->ret_origin =3D TEEC_ORIGIN_COMMS;
> > -                       arg->ret =3D TEEC_ERROR_OUT_OF_MEMORY;
> > -
> > -                       /* Unload the TA on error */
> > -                       unload_cmd.ta_handle =3D load_cmd.ta_handle;
> > -                       psp_tee_process_cmd(TEE_CMD_ID_UNLOAD_TA,
> > -                                           (void *)&unload_cmd,
> > -                                           sizeof(unload_cmd), &ret);
> > -               } else {
> > -                       set_session_id(load_cmd.ta_handle, 0, &arg->sessi=
on);
> > +       } else {
> > +               arg->ret_origin =3D load_cmd.return_origin;
> > +
> > +               if (arg->ret =3D=3D TEEC_SUCCESS) {
> > +                       ret =3D get_ta_refcount(load_cmd.ta_handle);
> > +                       if (!ret) {
> > +                               arg->ret_origin =3D TEEC_ORIGIN_COMMS;
> > +                               arg->ret =3D TEEC_ERROR_OUT_OF_MEMORY;
> > +
> > +                               /* Unload the TA on error */
> > +                               unload_cmd.ta_handle =3D load_cmd.ta_hand=
le;
> > +                               psp_tee_process_cmd(TEE_CMD_ID_UNLOAD_TA,
> > +                                                   (void *)&unload_cmd,
> > +                                                   sizeof(unload_cmd), &=
ret);
> > +                       } else {
> > +                               set_session_id(load_cmd.ta_handle, 0, &ar=
g->session);
> > +                       }
> >                 }
> >         }
> >         mutex_unlock(&ta_refcount_mutex);
> > --
> > 2.25.1
> >

--===============6920537558034523609==--

