From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [RFC PATCH] tee: tstee: Add initial Trusted Services TEE driver
Date: Thu, 26 Oct 2023 12:36:45 +0200
Message-ID: 
 <CAHUa44EJ2ceA5hZ-ikNmpPLxmtznZEHCoROFFj0tL-RHu50_zA@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYNDKojP4EM5-UNXX82tYyUy7MjUi6yAztjhDC2PqzFPWw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2038250325189084492=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2038250325189084492==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 11:36=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
>
> On Fri, 20 Oct 2023 at 19:29, Balint Dobszay <balint.dobszay@arm.com> wro=
te:
> >
> > On 19 Oct 2023, at 16:16, Jens Wiklander wrote:
> > > On Tue, Oct 17, 2023 at 1:14 PM Sumit Garg <sumit.garg@linaro.org> wr=
ote:
> > >> On Mon, 16 Oct 2023 at 13:27, Jens Wiklander <jens.wiklander@linaro.=
org> wrote:
> > >>> On Fri, Oct 13, 2023 at 1:38 PM Sumit Garg <sumit.garg@linaro.org> =
wrote:
> > >>>> On Tue, 10 Oct 2023 at 21:11, Balint Dobszay <balint.dobszay@arm.c=
om> wrote:
> > >>>>> On 3 Oct 2023, at 17:42, Sumit Garg wrote:
> > >>>>>> On Wed, 27 Sept 2023 at 20:56, Balint Dobszay <balint.dobszay@ar=
m.com> wrote:
> >
> > [snip]
> >
> > >>>>>>> +static int tstee_invoke_func(struct tee_context *ctx, struct tee=
_ioctl_invoke_arg *arg,
> > >>>>>>> +                            struct tee_param *param)
> > >>>>>>> +{
> > >>>>>>> +       struct tstee *tstee =3D tee_get_drvdata(ctx->teedev);
> > >>>>>>> +       struct ffa_device *ffa_dev =3D tstee->ffa_dev;
> > >>>>>>> +       struct ts_context_data *ctxdata =3D ctx->data;
> > >>>>>>> +       struct ffa_send_direct_data ffa_data;
> > >>>>>>> +       struct tee_shm *shm =3D NULL;
> > >>>>>>> +       struct ts_session *sess;
> > >>>>>>> +       u32 req_len, ffa_args[5] =3D {};
> > >>>>>>> +       int shm_id, rc;
> > >>>>>>> +       u8 iface_id;
> > >>>>>>> +       u64 handle;
> > >>>>>>> +       u16 opcode;
> > >>>>>>> +
> > >>>>>>> +       mutex_lock(&ctxdata->mutex);
> > >>>>>>> +       sess =3D find_session(ctxdata, arg->session);
> > >>>>>>> +
> > >>>>>>> +       /* Do this while holding the mutex to make sure that the =
session wasn't closed meanwhile */
> > >>>>>>> +       if (sess)
> > >>>>>>> +               iface_id =3D sess->iface_id;
> > >>>>>>> +
> > >>>>>>> +       mutex_unlock(&ctxdata->mutex);
> > >>>>>>> +       if (!sess)
> > >>>>>>> +               return -EINVAL;
> > >>>>>>> +
> > >>>>>>> +       opcode =3D lower_16_bits(arg->func);
> > >>>>>>> +       shm_id =3D lower_32_bits(param[0].u.value.a);
> > >>>>>>> +       req_len =3D lower_32_bits(param[0].u.value.b);
> > >>>>>>> +
> > >>>>>>> +       if (shm_id !=3D 0) {
> > >>>>>>> +               shm =3D tee_shm_get_from_id(ctx, shm_id);
> > >>>>>>> +               if (IS_ERR(shm))
> > >>>>>>> +                       return PTR_ERR(shm);
> > >>>>>>> +
> > >>>>>>> +               if (shm->size < req_len) {
> > >>>>>>> +                       pr_err("request doesn't fit into shared m=
emory buffer\n");
> > >>>>>>> +                       rc =3D -EINVAL;
> > >>>>>>> +                       goto out;
> > >>>>>>> +               }
> > >>>>>>> +
> > >>>>>>> +               handle =3D shm->sec_world_id;
> > >>>>>>> +       } else {
> > >>>>>>> +               handle =3D FFA_INVALID_MEM_HANDLE;
> > >>>>>>> +       }
> > >>>>>>> +
> > >>>>>>> +       ffa_args[TS_RPC_CTRL_REG] =3D TS_RPC_CTRL_PACK_IFACE_OPCO=
DE(iface_id, opcode);
> > >>>>>>> +       ffa_args[TS_RPC_SERVICE_MEM_HANDLE_LSW] =3D lower_32_bits=
(handle);
> > >>>>>>> +       ffa_args[TS_RPC_SERVICE_MEM_HANDLE_MSW] =3D upper_32_bits=
(handle);
> > >>>>>>> +       ffa_args[TS_RPC_SERVICE_REQ_LEN] =3D req_len;
> > >>>>>>> +       ffa_args[TS_RPC_SERVICE_CLIENT_ID] =3D 0;
> > >>>>>>> +
> > >>>>>>> +       arg_list_to_ffa_data(ffa_args, &ffa_data);
> > >>>>>>> +       rc =3D ffa_dev->ops->msg_ops->sync_send_receive(ffa_dev, =
&ffa_data);
> > >>>>>>
> > >>>>>> I haven't dug deeper into the ABI yet, which is something I will l=
ook
> > >>>>>> into. But these RPC commands caught my attention. Are these RPC ca=
lls
> > >>>>>> blocking in nature? Is there a possibility that these could cause =
CPU
> > >>>>>> stalls? Do the Linux interrupts remain unhandled until the RPC cal=
ls
> > >>>>>> return?
> > >>>>>
> > >>>>> Yes, that is correct. We did encounter CPU stalls indeed, our solut=
ion
> > >>>>> was to enable preemption of S-EL0 SPs in OP-TEE [3] which solved the
> > >>>>> issue.
> > >>>>
> > >>>> I would have preferred to unite FFA_INTERRUPT and
> > >>>> OPTEE_FFA_YIELDING_CALL_RETURN_INTERRUPT since underneath both are
> > >>>> using FFA ABI.
> > >>>>
> > >>>> Jens,
> > >>>>
> > >>>> Can we change OP-TEE to use FFA_INTERRUPT as well when using FFA ABI?
> > >>>
> > >>> No, OP-TEE uses managed exit. Among other advantages, it allows
> > >>> resuming execution on a different CPU.
> > >>>
> > >>
> > >> I suppose that should be the case with FFA_INTERRUPT too. OP-TEE
> > >> should be able to resume SPs on different CPUs as well, right?
> > >
> > > Possibly, but I leave that to Balint and company to sort out if that's
> > > desired or not.
> >
> > FF-A mandates that S-EL0 SPs have a single execution context, run only
> > on a single PE in the system at any point of time and are capable of
> > migrating. Also, FF-A allows resuming a S-EL0 SP on a different CPU
> > after it gets preempted by a NS interrupt. I think OP-TEE as S-EL1 SPMC
> > does support this, but I don't have a setup yet that would explicitly
> > test this scenario.
> >
>
> You can try to add a few minutes loop within a secure partition and
> see if the Linux scheduler reschedules on a different CPUs. I suppose
> you need to keep the system loaded with other normal world apps too.
>
> > Managed exit is only available for S-EL1 SPs.
> >
>
> So does that mean OP-TEE can use FF-A constructs like (FFA_INTERRUPT)
> for managed exit instead of custom
> OPTEE_FFA_YIELDING_CALL_RETURN_INTERRUPT?

No, and to be clear OPTEE_FFA_YIELDING_CALL_RETURN_INTERRUPT isn't a
custom solution, it's fully within the specification. Returning via
FFA_INTERRUPT is a simplified model where the SP has less control over
the CPU. I imagine that it wouldn't play very nicely with spinlocks.

Cheers,
Jens

>
> -Sumit

--===============2038250325189084492==--

