From: Sumit Garg <sumit.garg@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v6 03/10] optee: account for direction while converting parameters
Date: Tue, 25 Mar 2025 11:25:54 +0530
Message-ID: <Z-JFagmbZBQd0hoM@sumit-X1>
In-Reply-To: <
 <CAHUa44HY-jZCoDXKnx-f4gBoABRVdh1+6PA1AYHSva9aL=rDAA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1759134577660088224=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1759134577660088224==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 02:00:57PM +0100, Jens Wiklander wrote:
> Hi Sumit,
>=20
> On Thu, Mar 20, 2025 at 10:25=E2=80=AFAM Sumit Garg <sumit.garg@kernel.or=
g> wrote:
> >
> > Hi Jens,
> >
> > On Mon, Mar 17, 2025 at 08:42:01AM +0100, Jens Wiklander wrote:
> > > Hi Sumit,
> > >
> > > On Thu, Mar 13, 2025 at 11:41=E2=80=AFAM Sumit Garg <sumit.garg@kerne=
l.org> wrote:
> > > >
> > > > Hi Jens,
> > > >
> > > > On Wed, Mar 05, 2025 at 02:04:09PM +0100, Jens Wiklander wrote:
> > > > > The OP-TEE backend driver has two internal function pointers to con=
vert
> > > > > between the subsystem type struct tee_param and the OP-TEE type str=
uct
> > > > > optee_msg_param.
> > > > >
> > > > > The conversion is done from one of the types to the other, which is=
 then
> > > > > involved in some operation and finally converted back to the origin=
al
> > > > > type. When converting to prepare the parameters for the operation, =
all
> > > > > fields must be taken into account, but then converting back, it's e=
nough
> > > > > to update only out-values and out-sizes. So, an update_out paramete=
r is
> > > > > added to the conversion functions to tell if all or only some fields
> > > > > must be copied.
> > > > >
> > > > > This is needed in a later patch where it might get confusing when
> > > > > converting back in from_msg_param() callback since an allocated
> > > > > restricted SHM can be using the sec_world_id of the used restricted
> > > > > memory pool and that doesn't translate back well.
> > > > >
> > > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > ---
> > > > >  drivers/tee/optee/call.c          | 10 ++--
> > > > >  drivers/tee/optee/ffa_abi.c       | 43 +++++++++++++----
> > > > >  drivers/tee/optee/optee_private.h | 42 +++++++++++------
> > > > >  drivers/tee/optee/rpc.c           | 31 +++++++++----
> > > > >  drivers/tee/optee/smc_abi.c       | 76 +++++++++++++++++++++++----=
----
> > > > >  5 files changed, 144 insertions(+), 58 deletions(-)
> > > > >
> > > > > diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> > > > > index 16eb953e14bb..f1533b894726 100644
> > > > > --- a/drivers/tee/optee/call.c
> > > > > +++ b/drivers/tee/optee/call.c
> > > > > @@ -400,7 +400,8 @@ int optee_open_session(struct tee_context *ctx,
> > > > >       export_uuid(msg_arg->params[1].u.octets, &client_uuid);
> > > > >
> > > > >       rc =3D optee->ops->to_msg_param(optee, msg_arg->params + 2,
> > > > > -                                   arg->num_params, param);
> > > > > +                                   arg->num_params, param,
> > > > > +                                   false /*!update_out*/);
> > > > >       if (rc)
> > > > >               goto out;
> > > > >
> > > > > @@ -427,7 +428,8 @@ int optee_open_session(struct tee_context *ctx,
> > > > >       }
> > > > >
> > > > >       if (optee->ops->from_msg_param(optee, param, arg->num_params,
> > > > > -                                    msg_arg->params + 2)) {
> > > > > +                                    msg_arg->params + 2,
> > > > > +                                    true /*update_out*/)) {
> > > > >               arg->ret =3D TEEC_ERROR_COMMUNICATION;
> > > > >               arg->ret_origin =3D TEEC_ORIGIN_COMMS;
> > > > >               /* Close session again to avoid leakage */
> > > > > @@ -541,7 +543,7 @@ int optee_invoke_func(struct tee_context *ctx, =
struct tee_ioctl_invoke_arg *arg,
> > > > >       msg_arg->cancel_id =3D arg->cancel_id;
> > > > >
> > > > >       rc =3D optee->ops->to_msg_param(optee, msg_arg->params, arg->=
num_params,
> > > > > -                                   param);
> > > > > +                                   param, false /*!update_out*/);
> > > > >       if (rc)
> > > > >               goto out;
> > > > >
> > > > > @@ -551,7 +553,7 @@ int optee_invoke_func(struct tee_context *ctx, =
struct tee_ioctl_invoke_arg *arg,
> > > > >       }
> > > > >
> > > > >       if (optee->ops->from_msg_param(optee, param, arg->num_params,
> > > > > -                                    msg_arg->params)) {
> > > > > +                                    msg_arg->params, true /*update=
_out*/)) {
> > > > >               msg_arg->ret =3D TEEC_ERROR_COMMUNICATION;
> > > > >               msg_arg->ret_origin =3D TEEC_ORIGIN_COMMS;
> > > > >       }
> > > > > diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_ab=
i.c
> > > > > index 4ca1d5161b82..e4b08cd195f3 100644
> > > > > --- a/drivers/tee/optee/ffa_abi.c
> > > > > +++ b/drivers/tee/optee/ffa_abi.c
> > > > > @@ -122,15 +122,21 @@ static int optee_shm_rem_ffa_handle(struct op=
tee *optee, u64 global_id)
> > > > >   */
> > > > >
> > > > >  static void from_msg_param_ffa_mem(struct optee *optee, struct tee=
_param *p,
> > > > > -                                u32 attr, const struct optee_msg_p=
aram *mp)
> > > > > +                                u32 attr, const struct optee_msg_p=
aram *mp,
> > > > > +                                bool update_out)
> > > > >  {
> > > > >       struct tee_shm *shm =3D NULL;
> > > > >       u64 offs_high =3D 0;
> > > > >       u64 offs_low =3D 0;
> > > > >
> > > > > +     if (update_out) {
> > > > > +             if (attr =3D=3D OPTEE_MSG_ATTR_TYPE_FMEM_INPUT)
> > > > > +                     return;
> > > > > +             goto out;
> > > > > +     }
> > > > > +
> > > > >       p->attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT +
> > > > >                 attr - OPTEE_MSG_ATTR_TYPE_FMEM_INPUT;
> > > > > -     p->u.memref.size =3D mp->u.fmem.size;
> > > > >
> > > > >       if (mp->u.fmem.global_id !=3D OPTEE_MSG_FMEM_INVALID_GLOBAL_I=
D)
> > > > >               shm =3D optee_shm_from_ffa_handle(optee, mp->u.fmem.g=
lobal_id);
> > > > > @@ -141,6 +147,8 @@ static void from_msg_param_ffa_mem(struct optee=
 *optee, struct tee_param *p,
> > > > >               offs_high =3D mp->u.fmem.offs_high;
> > > > >       }
> > > > >       p->u.memref.shm_offs =3D offs_low | offs_high << 32;
> > > > > +out:
> > > > > +     p->u.memref.size =3D mp->u.fmem.size;
> > > > >  }
> > > > >
> > > > >  /**
> > > > > @@ -150,12 +158,14 @@ static void from_msg_param_ffa_mem(struct opt=
ee *optee, struct tee_param *p,
> > > > >   * @params:  subsystem internal parameter representation
> > > > >   * @num_params:      number of elements in the parameter arrays
> > > > >   * @msg_params:      OPTEE_MSG parameters
> > > > > + * @update_out: update parameter for output only
> > > > >   *
> > > > >   * Returns 0 on success or <0 on failure
> > > > >   */
> > > > >  static int optee_ffa_from_msg_param(struct optee *optee,
> > > > >                                   struct tee_param *params, size_t =
num_params,
> > > > > -                                 const struct optee_msg_param *msg=
_params)
> > > > > +                                 const struct optee_msg_param *msg=
_params,
> > > > > +                                 bool update_out)
> > > > >  {
> > > > >       size_t n;
> > > > >
> > > > > @@ -166,18 +176,20 @@ static int optee_ffa_from_msg_param(struct op=
tee *optee,
> > > > >
> > > > >               switch (attr) {
> > > > >               case OPTEE_MSG_ATTR_TYPE_NONE:
> > > > > +                     if (update_out)
> > > > > +                             break;
> > > > >                       p->attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_NONE;
> > > > >                       memset(&p->u, 0, sizeof(p->u));
> > > > >                       break;
> > > > >               case OPTEE_MSG_ATTR_TYPE_VALUE_INPUT:
> > > > >               case OPTEE_MSG_ATTR_TYPE_VALUE_OUTPUT:
> > > > >               case OPTEE_MSG_ATTR_TYPE_VALUE_INOUT:
> > > > > -                     optee_from_msg_param_value(p, attr, mp);
> > > > > +                     optee_from_msg_param_value(p, attr, mp, updat=
e_out);
> > > > >                       break;
> > > > >               case OPTEE_MSG_ATTR_TYPE_FMEM_INPUT:
> > > > >               case OPTEE_MSG_ATTR_TYPE_FMEM_OUTPUT:
> > > > >               case OPTEE_MSG_ATTR_TYPE_FMEM_INOUT:
> > > > > -                     from_msg_param_ffa_mem(optee, p, attr, mp);
> > > > > +                     from_msg_param_ffa_mem(optee, p, attr, mp, up=
date_out);
> > > > >                       break;
> > > > >               default:
> > > > >                       return -EINVAL;
> > > > > @@ -188,10 +200,16 @@ static int optee_ffa_from_msg_param(struct op=
tee *optee,
> > > > >  }
> > > > >
> > > > >  static int to_msg_param_ffa_mem(struct optee_msg_param *mp,
> > > > > -                             const struct tee_param *p)
> > > > > +                             const struct tee_param *p, bool updat=
e_out)
> > > > >  {
> > > > >       struct tee_shm *shm =3D p->u.memref.shm;
> > > > >
> > > > > +     if (update_out) {
> > > > > +             if (p->attr =3D=3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_I=
NPUT)
> > > > > +                     return 0;
> > > > > +             goto out;
> > > > > +     }
> > > > > +
> > > > >       mp->attr =3D OPTEE_MSG_ATTR_TYPE_FMEM_INPUT + p->attr -
> > > > >                  TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
> > > > >
> > > > > @@ -211,6 +229,7 @@ static int to_msg_param_ffa_mem(struct optee_ms=
g_param *mp,
> > > > >               memset(&mp->u, 0, sizeof(mp->u));
> > > > >               mp->u.fmem.global_id =3D OPTEE_MSG_FMEM_INVALID_GLOBA=
L_ID;
> > > > >       }
> > > > > +out:
> > > > >       mp->u.fmem.size =3D p->u.memref.size;
> > > > >
> > > > >       return 0;
> > > > > @@ -222,13 +241,15 @@ static int to_msg_param_ffa_mem(struct optee_=
msg_param *mp,
> > > > >   * @optee:   main service struct
> > > > >   * @msg_params:      OPTEE_MSG parameters
> > > > >   * @num_params:      number of elements in the parameter arrays
> > > > > - * @params:  subsystem itnernal parameter representation
> > > > > + * @params:  subsystem internal parameter representation
> > > > > + * @update_out: update parameter for output only
> > > > >   * Returns 0 on success or <0 on failure
> > > > >   */
> > > > >  static int optee_ffa_to_msg_param(struct optee *optee,
> > > > >                                 struct optee_msg_param *msg_params,
> > > > >                                 size_t num_params,
> > > > > -                               const struct tee_param *params)
> > > > > +                               const struct tee_param *params,
> > > > > +                               bool update_out)
> > > > >  {
> > > > >       size_t n;
> > > > >
> > > > > @@ -238,18 +259,20 @@ static int optee_ffa_to_msg_param(struct opte=
e *optee,
> > > > >
> > > > >               switch (p->attr) {
> > > > >               case TEE_IOCTL_PARAM_ATTR_TYPE_NONE:
> > > > > +                     if (update_out)
> > > > > +                             break;
> > > > >                       mp->attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_NONE;
> > > > >                       memset(&mp->u, 0, sizeof(mp->u));
> > > > >                       break;
> > > > >               case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT:
> > > > >               case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT:
> > > > >               case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT:
> > > > > -                     optee_to_msg_param_value(mp, p);
> > > > > +                     optee_to_msg_param_value(mp, p, update_out);
> > > > >                       break;
> > > > >               case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
> > > > >               case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
> > > > >               case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
> > > > > -                     if (to_msg_param_ffa_mem(mp, p))
> > > > > +                     if (to_msg_param_ffa_mem(mp, p, update_out))
> > > > >                               return -EINVAL;
> > > > >                       break;
> > > > >               default:
> > > >
> > > > Can we rather handle it as follows to improve code readability and
> > > > maintainence long term? Ditto for all other places.
> > > >
> > > > static int optee_ffa_to_msg_param(struct optee *optee,
> > > >                                   struct optee_msg_param *msg_params,
> > > >                                   size_t num_params,
> > > >                                   const struct tee_param *params,
> > > >                                   bool update_out)
> > > > {
> > > >         size_t n;
> > > >
> > > >         for (n =3D 0; n < num_params; n++) {
> > > >                 const struct tee_param *p =3D params + n;
> > > >                 struct optee_msg_param *mp =3D msg_params + n;
> > > >
> > > >                 if (update_out && (p->attr =3D=3D TEE_IOCTL_PARAM_ATT=
R_TYPE_NONE ||
> > > >                      p->attr =3D=3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_I=
NPUT ||
> > > >                      p->attr =3D=3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_=
INPUT))
> > > >                     continue;
> > >
> > > You're missing updating the length field for memrefs.
> > >
> >
> > Do we need to update length field for input memrefs when update_out is
> > set? I don't see that happening in your existing patch too.
>=20
> I'm sorry, I was unclear. The update_out parameter means only the
> output fields should be updated, not the attribute, offsets, ids, etc.
> That is, the length field for memrefs, and the value fields a, b, c
> for value params. Some of the memrefs aren't translated one-to-one
> with SDP, but the length field can and must be updated.

Isn't it rather better to add another attribute type to handled SDP
special handling?

-Sumit

>=20
> Cheers,
> Jens
>=20
> >
> > -Sumit
> >
> > > Cheers,
> > > Jens
> > >
> > > >
> > > >                 switch (p->attr) {
> > > >                 case TEE_IOCTL_PARAM_ATTR_TYPE_NONE:
> > > >                         mp->attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_NONE;
> > > >                         memset(&mp->u, 0, sizeof(mp->u));
> > > >                         break;
> > > >                 case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT:
> > > >                 case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT:
> > > >                 case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT:
> > > >                         optee_to_msg_param_value(mp, p);
> > > >                         break;
> > > >                 case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
> > > >                 case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
> > > >                 case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
> > > >                         if (to_msg_param_ffa_mem(mp, p))
> > > >                                 return -EINVAL;
> > > >                         break;
> > > >                 default:
> > > >                         return -EINVAL;
> > > >                 }
> > > >         }
> > > >
> > > >         return 0;
> > > > }
> > > >
> > > > -Sumit

--===============1759134577660088224==--

