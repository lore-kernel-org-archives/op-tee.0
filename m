From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [RFC PATCH] tee: tstee: Add initial Trusted Services TEE driver
Date: Fri, 27 Oct 2023 18:22:56 +0530
Message-ID: 
 <CAFA6WYN838QuBAAM_iV_1M_YG3fNcAQFfLEspwnB9d0nBK-PvQ@mail.gmail.com>
In-Reply-To: <
 <CAHUa44HZHszcL0DW94GSuy581OqJMttCcWGu6XKLmadX5StvQg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5892172527893157399=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5892172527893157399==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Oct 2023 at 19:57, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> On Thu, Oct 26, 2023 at 1:33=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org=
> wrote:
> >
> > On Thu, 26 Oct 2023 at 16:06, Jens Wiklander <jens.wiklander@linaro.org=
> wrote:
> > >
> > > On Thu, Oct 26, 2023 at 11:36=E2=80=AFAM Sumit Garg <sumit.garg@linar=
o.org> wrote:
> > > >
> > > > On Fri, 20 Oct 2023 at 19:29, Balint Dobszay <balint.dobszay@arm.co=
m> wrote:
> > > > >
> > > > > On 19 Oct 2023, at 16:16, Jens Wiklander wrote:
> > > > > > On Tue, Oct 17, 2023 at 1:14 PM Sumit Garg <sumit.garg@linaro.o=
rg> wrote:
> > > > > >> On Mon, 16 Oct 2023 at 13:27, Jens Wiklander <jens.wiklander@l=
inaro.org> wrote:
> > > > > >>> On Fri, Oct 13, 2023 at 1:38 PM Sumit Garg <sumit.garg@linaro=
.org> wrote:
> > > > > >>>> On Tue, 10 Oct 2023 at 21:11, Balint Dobszay <balint.dobszay(a=
)arm.com> wrote:
> > > > > >>>>> On 3 Oct 2023, at 17:42, Sumit Garg wrote:
> > > > > >>>>>> On Wed, 27 Sept 2023 at 20:56, Balint Dobszay <balint.dobsza=
y@arm.com> wrote:
> > > > >
> > > > > [snip]
> > > > >
> > > > > >>>>>>> +static int tstee_invoke_func(struct tee_context *ctx, stru=
ct tee_ioctl_invoke_arg *arg,
> > > > > >>>>>>> +                            struct tee_param *param)
> > > > > >>>>>>> +{
> > > > > >>>>>>> +       struct tstee *tstee =3D tee_get_drvdata(ctx->teedev=
);
> > > > > >>>>>>> +       struct ffa_device *ffa_dev =3D tstee->ffa_dev;
> > > > > >>>>>>> +       struct ts_context_data *ctxdata =3D ctx->data;
> > > > > >>>>>>> +       struct ffa_send_direct_data ffa_data;
> > > > > >>>>>>> +       struct tee_shm *shm =3D NULL;
> > > > > >>>>>>> +       struct ts_session *sess;
> > > > > >>>>>>> +       u32 req_len, ffa_args[5] =3D {};
> > > > > >>>>>>> +       int shm_id, rc;
> > > > > >>>>>>> +       u8 iface_id;
> > > > > >>>>>>> +       u64 handle;
> > > > > >>>>>>> +       u16 opcode;
> > > > > >>>>>>> +
> > > > > >>>>>>> +       mutex_lock(&ctxdata->mutex);
> > > > > >>>>>>> +       sess =3D find_session(ctxdata, arg->session);
> > > > > >>>>>>> +
> > > > > >>>>>>> +       /* Do this while holding the mutex to make sure tha=
t the session wasn't closed meanwhile */
> > > > > >>>>>>> +       if (sess)
> > > > > >>>>>>> +               iface_id =3D sess->iface_id;
> > > > > >>>>>>> +
> > > > > >>>>>>> +       mutex_unlock(&ctxdata->mutex);
> > > > > >>>>>>> +       if (!sess)
> > > > > >>>>>>> +               return -EINVAL;
> > > > > >>>>>>> +
> > > > > >>>>>>> +       opcode =3D lower_16_bits(arg->func);
> > > > > >>>>>>> +       shm_id =3D lower_32_bits(param[0].u.value.a);
> > > > > >>>>>>> +       req_len =3D lower_32_bits(param[0].u.value.b);
> > > > > >>>>>>> +
> > > > > >>>>>>> +       if (shm_id !=3D 0) {
> > > > > >>>>>>> +               shm =3D tee_shm_get_from_id(ctx, shm_id);
> > > > > >>>>>>> +               if (IS_ERR(shm))
> > > > > >>>>>>> +                       return PTR_ERR(shm);
> > > > > >>>>>>> +
> > > > > >>>>>>> +               if (shm->size < req_len) {
> > > > > >>>>>>> +                       pr_err("request doesn't fit into sh=
ared memory buffer\n");
> > > > > >>>>>>> +                       rc =3D -EINVAL;
> > > > > >>>>>>> +                       goto out;
> > > > > >>>>>>> +               }
> > > > > >>>>>>> +
> > > > > >>>>>>> +               handle =3D shm->sec_world_id;
> > > > > >>>>>>> +       } else {
> > > > > >>>>>>> +               handle =3D FFA_INVALID_MEM_HANDLE;
> > > > > >>>>>>> +       }
> > > > > >>>>>>> +
> > > > > >>>>>>> +       ffa_args[TS_RPC_CTRL_REG] =3D TS_RPC_CTRL_PACK_IFAC=
E_OPCODE(iface_id, opcode);
> > > > > >>>>>>> +       ffa_args[TS_RPC_SERVICE_MEM_HANDLE_LSW] =3D lower_3=
2_bits(handle);
> > > > > >>>>>>> +       ffa_args[TS_RPC_SERVICE_MEM_HANDLE_MSW] =3D upper_3=
2_bits(handle);
> > > > > >>>>>>> +       ffa_args[TS_RPC_SERVICE_REQ_LEN] =3D req_len;
> > > > > >>>>>>> +       ffa_args[TS_RPC_SERVICE_CLIENT_ID] =3D 0;
> > > > > >>>>>>> +
> > > > > >>>>>>> +       arg_list_to_ffa_data(ffa_args, &ffa_data);
> > > > > >>>>>>> +       rc =3D ffa_dev->ops->msg_ops->sync_send_receive(ffa=
_dev, &ffa_data);
> > > > > >>>>>>
> > > > > >>>>>> I haven't dug deeper into the ABI yet, which is something I =
will look
> > > > > >>>>>> into. But these RPC commands caught my attention. Are these =
RPC calls
> > > > > >>>>>> blocking in nature? Is there a possibility that these could =
cause CPU
> > > > > >>>>>> stalls? Do the Linux interrupts remain unhandled until the R=
PC calls
> > > > > >>>>>> return?
> > > > > >>>>>
> > > > > >>>>> Yes, that is correct. We did encounter CPU stalls indeed, our=
 solution
> > > > > >>>>> was to enable preemption of S-EL0 SPs in OP-TEE [3] which sol=
ved the
> > > > > >>>>> issue.
> > > > > >>>>
> > > > > >>>> I would have preferred to unite FFA_INTERRUPT and
> > > > > >>>> OPTEE_FFA_YIELDING_CALL_RETURN_INTERRUPT since underneath both=
 are
> > > > > >>>> using FFA ABI.
> > > > > >>>>
> > > > > >>>> Jens,
> > > > > >>>>
> > > > > >>>> Can we change OP-TEE to use FFA_INTERRUPT as well when using F=
FA ABI?
> > > > > >>>
> > > > > >>> No, OP-TEE uses managed exit. Among other advantages, it allows
> > > > > >>> resuming execution on a different CPU.
> > > > > >>>
> > > > > >>
> > > > > >> I suppose that should be the case with FFA_INTERRUPT too. OP-TEE
> > > > > >> should be able to resume SPs on different CPUs as well, right?
> > > > > >
> > > > > > Possibly, but I leave that to Balint and company to sort out if t=
hat's
> > > > > > desired or not.
> > > > >
> > > > > FF-A mandates that S-EL0 SPs have a single execution context, run o=
nly
> > > > > on a single PE in the system at any point of time and are capable of
> > > > > migrating. Also, FF-A allows resuming a S-EL0 SP on a different CPU
> > > > > after it gets preempted by a NS interrupt. I think OP-TEE as S-EL1 =
SPMC
> > > > > does support this, but I don't have a setup yet that would explicit=
ly
> > > > > test this scenario.
> > > > >
> > > >
> > > > You can try to add a few minutes loop within a secure partition and
> > > > see if the Linux scheduler reschedules on a different CPUs. I suppose
> > > > you need to keep the system loaded with other normal world apps too.
> > > >
> > > > > Managed exit is only available for S-EL1 SPs.
> > > > >
> > > >
> > > > So does that mean OP-TEE can use FF-A constructs like (FFA_INTERRUPT)
> > > > for managed exit instead of custom
> > > > OPTEE_FFA_YIELDING_CALL_RETURN_INTERRUPT?
> > >
> > > No, and to be clear OPTEE_FFA_YIELDING_CALL_RETURN_INTERRUPT isn't a
> > > custom solution, it's fully within the specification.
> >
> > I am not talking about it being out of specification. It's rather that
> > if the base FF-A layer provides you with a feature then we shouldn't
> > need to reimplement in every SP (OP-TEE or other trusted OS)
> > communication stack.
>
> Let's take a look at the code we have in the OP-TEE driver for this:
>         case OPTEE_FFA_YIELDING_CALL_RETURN_INTERRUPT:
>                 /* Interrupt delivered by now */
>                 break;
>
> The implementation is pretty small. We're of course piggy-backing on
> the rest of the RPC code, but that would still be needed even if the
> FF-A framework could handle the managed exits. From OP-TEE's point of
> view, there's nothing to gain.
>
> >
> > > Returning via
> > > FFA_INTERRUPT is a simplified model where the SP has less control over
> > > the CPU.
> >
> > I would like to understand which exact bits you are referring to. From
> > Linux point of view, I don't see any difference.
>
> Given how the ABI is defined we can't use FFA_INTERRUPT for managed
> exit.

Okay I see that ABI issue. We have to be backwards compatible and that
will cause more pain rather than reusing FFA_INTERRUPT here. I think I
can live with that in mind.

-Sumit

> There's a vCPU field that is used by the SPMC, there's nothing
> for OP-TEE to suspend/resume a thread to let another thread use the
> CPU.
>
> >
> > > I imagine that it wouldn't play very nicely with spinlocks.
> >
> > Aren't interrupts disabled while spinlock is being held?
>
> Yes, but without managed exit that doesn't matter much since
> suspend/resume are transparent to the SP.
>
> Cheers,
> Jens
>
> >
> > -Sumit
> >
> > >
> > > Cheers,
> > > Jens
> > >
> > > >
> > > > -Sumit

--===============5892172527893157399==--

