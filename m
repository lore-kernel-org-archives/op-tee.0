From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 1/3] optee: add OPTEE_SMC_CALL_WITH_RPC_ARG
Date: Tue, 05 Apr 2022 18:10:27 +0530
Message-ID: 
 <CAFA6WYMCfev_xsB7y57n-G05-vi4kKWQ=RwQFyM4dPzeASog5w@mail.gmail.com>
In-Reply-To: <
 <CAHUa44G8brKgzV9DdriHD+aN_=k5K9gECvurk+hmK0y-NqF+rA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6437328262611627380=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6437328262611627380==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Mar 2022 at 12:59, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> On Thu, Mar 17, 2022 at 12:40 PM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > On Wed, 16 Mar 2022 at 13:47, Jens Wiklander <jens.wiklander@linaro.org=
> wrote:
> [snip]
> > > > > diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/opte=
e_smc.h
> > > > > index d44a6ae994f8..378741a459b6 100644
> > > > > --- a/drivers/tee/optee/optee_smc.h
> > > > > +++ b/drivers/tee/optee/optee_smc.h
> > > > > @@ -107,14 +107,22 @@ struct optee_smc_call_get_os_revision_result {
> > > > >  /*
> > > > >   * Call with struct optee_msg_arg as argument
> > > > >   *
> > > > > - * When calling this function normal world has a few responsibilit=
ies:
> > > > > + * When called with OPTEE_SMC_CALL_WITH_RPC_ARG or
> > > > > + * OPTEE_SMC_CALL_WITH_REGD_ARG in a0 there is one RPC struct opte=
e_msg_arg
> > > > > + * following after the first struct optee_msg_arg. The RPC struct
> > > > > + * optee_msg_arg has reserved space for the number of RPC paramete=
rs as
> > > > > + * returned by OPTEE_SMC_EXCHANGE_CAPABILITIES.
> > > > > + *
> > > > > + * When calling these functions normal world has a few responsibil=
ities:
> > > > >   * 1. It must be able to handle eventual RPCs
> > > > >   * 2. Non-secure interrupts should not be masked
> > > > >   * 3. If asynchronous notifications has been negotiated successful=
ly, then
> > > > > - *    asynchronous notifications should be unmasked during this ca=
ll.
> > > > > + *    the interrupt for asynchronous notifications should be unmas=
ked
> > > > > + *    during this call.
> > > > >   *
> > > > > - * Call register usage:
> > > > > - * a0  SMC Function ID, OPTEE_SMC*CALL_WITH_ARG
> > > > > + * Call register usage, OPTEE_SMC_CALL_WITH_ARG and
> > > > > + * OPTEE_SMC_CALL_WITH_RPC_ARG:
> > > > > + * a0  SMC Function ID, OPTEE_SMC_CALL_WITH_ARG or OPTEE_SMC_CALL_=
WITH_RPC_ARG
> > > > >   * a1  Upper 32 bits of a 64-bit physical pointer to a struct opte=
e_msg_arg
> > > > >   * a2  Lower 32 bits of a 64-bit physical pointer to a struct opte=
e_msg_arg
> > > > >   * a3  Cache settings, not used if physical pointer is in a predef=
ined shared
> > > > > @@ -122,6 +130,15 @@ struct optee_smc_call_get_os_revision_result {
> > > > >   * a4-6        Not used
> > > > >   * a7  Hypervisor Client ID register
> > > > >   *
> > > > > + * Call register usage, OPTEE_SMC_CALL_WITH_REGD_ARG:
> > > >
> > > > Although I didn't see any reference to OPTEE_SMC_CALL_WITH_REGD_ARG in
> > > > the commit message, but do we really need to introduce it? Wouldn't it
> > > > be possible to just pass additional "shared memory cookie" value as
> > > > part of "Not used" (a4-6) arguments?
> > >
> > > I'll update the commit message to mention OPTEE_SMC_CALL_WITH_REGD_ARG
> > > too. I think it's more clear with a separate ID for this, less risk of
> > > confusion.
> >
> > IMO, it would unnecessarily complicate and introduce ambiguity in the
> > ABI as after this patch we will have:
> >
> > CALL_WITH_ARG: Standard arguments *without* pre-allocated RPC arguments b=
uffer
> > CALL_WITH_RPC_ARG: Standard arguments *with* pre-allocated RPC arguments =
buffer
> > CALL_WITH_REGD_ARG: Registered arguments but *not* explicit whether
> > RPC arguments buffer is there or not.
>
> CALL_WITH_REGD_ARG is quite explicit in the description above (in the patch=
):
>  * When called with OPTEE_SMC_CALL_WITH_RPC_ARG or
>  * OPTEE_SMC_CALL_WITH_REGD_ARG in a0 there is one RPC struct optee_msg_arg
>  * following after the first struct optee_msg_arg. The RPC struct
>  * optee_msg_arg has reserved space for the number of RPC parameters as
>  * returned by OPTEE_SMC_EXCHANGE_CAPABILITIES.
>
> I chose to use two new SMC IDs to have one clear purpose for each.
>
> I preferred the name OPTEE_SMC_CALL_WITH_REGD_ARG instead of
> OPTEE_SMC_CALL_WITH_REGD_RPC_ARG since I thought the former was long
> enough.
>
> >
> > If we keep the ABI simplified to say we only support two types of
> > invocation irrespective of whether the arguments are allocated from
> > statically shared memory or dynamically shared memory:
> >
> > CALL_WITH_ARG: Standard arguments *without* pre-allocated RPC arguments b=
uffer
> > CALL_WITH_RPC_ARG: Standard arguments *with* pre-allocated RPC arguments =
buffer
>
> That's only simple on the surface. When looking into the details of
> CALL_WITH_RPC_ARG you'd need a more complicated register usage since
> the function would be doing two different things.
>
> >
> > > How would the callee know if it's the cookie or the physical
> > > address it should use?  Whatever we do, we're extenting the ABI.
> > >
> >
> > Isn't it possible for OP-TEE to determine if it's a valid cookie or
> > not which will be passed into currently unused arguments?
>
> Actually, we need three registers, one to pass the offset in too.

Okay, fair enough I am fine with your preferred approach in this patch.

-Sumit

>
> Cheers,
> Jens
>
> >
> > -Sumit
> >
> > > >
> > > > > + * a0  SMC Function ID, OPTEE_SMC_CALL_WITH_REGD_ARG
> > > > > + * a1  Upper 32 bits of a 64-bit shared memory cookie
> > > > > + * a2  Lower 32 bits of a 64-bit shared memory cookie
> > > > > + * a3  Offset of the struct optee_msg_arg in the shared memory wit=
h the
> > > > > + *     supplied cookie
> > > > > + * a4-6        Not used
> > > > > + * a7  Hypervisor Client ID register
> > > > > + *
> > > > >   * Normal return register usage:
> > > > >   * a0  Return value, OPTEE_SMC_RETURN_*
> > > > >   * a1-3        Not used
> > > > > @@ -154,6 +171,10 @@ struct optee_smc_call_get_os_revision_result {
> > > > >  #define OPTEE_SMC_FUNCID_CALL_WITH_ARG OPTEE_MSG_FUNCID_CALL_WITH_=
ARG
> > > > >  #define OPTEE_SMC_CALL_WITH_ARG \
> > > > >         OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_CALL_WITH_ARG)
> > > > > +#define OPTEE_SMC_CALL_WITH_RPC_ARG \
> > > > > +       OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_CALL_WITH_RPC_ARG)
> > > > > +#define OPTEE_SMC_CALL_WITH_REGD_ARG \
> > > > > +       OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_CALL_WITH_REGD_ARG)
> > > > >

--===============6437328262611627380==--

