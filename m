From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH 4/9] firmware: arm_ffa: Add support for querying FF-A features
Date: Thu, 01 Sep 2022 13:32:10 +0200
Message-ID: 
 <CAHUa44GdfJgzbfowY1ZMEZyM8B_hh4h-bYxsZ3h9mtgfj=bYSw@mail.gmail.com>
In-Reply-To: <20220901090416.25riofko2m5mrlnt@bogus>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1952442588380573177=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1952442588380573177==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 1, 2022 at 11:04 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Sep 01, 2022 at 09:56:41AM +0200, Jens Wiklander wrote:
> > On Tue, Aug 30, 2022 at 12:07 PM Sudeep Holla <sudeep.holla@arm.com> wr=
ote:
> > >
> > > Add support for FFA_FEATURES to discover properties supported at the
> > > FF-A interface. This interface can be used to query:
> > >  - If an FF-A interface is implemented by the component at the higher E=
L,
> > >  - If an implemented FF-A interface also implements any optional featur=
es
> > >    described in its interface definition, and
> > >  - Any implementation details exported by an implemented FF-A interface
> > >    as described in its interface definition.
> > >
> > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > ---
> > >  drivers/firmware/arm_ffa/driver.c | 23 +++++++++++++++++++++++
> > >  1 file changed, 23 insertions(+)
> > >
> > > diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_f=
fa/driver.c
> > > index 04e7cbb1b9aa..de94073f4109 100644
> > > --- a/drivers/firmware/arm_ffa/driver.c
> > > +++ b/drivers/firmware/arm_ffa/driver.c
> > > @@ -571,6 +571,29 @@ static int ffa_memory_reclaim(u64 g_handle, u32 fl=
ags)
> > >         return 0;
> > >  }
> > >
> > > +static int ffa_features(u32 func_feat_id, u32 input_props, u32 *if_pro=
ps)
> > > +{
> > > +       ffa_value_t id;
> > > +
> > > +       if (!ARM_SMCCC_IS_FAST_CALL(func_feat_id) && input_props) {
> > > +               pr_err("%s: Invalid Parameters: %x, %x", __func__,
> > > +                      func_feat_id, input_props);
> > > +               return ffa_to_linux_errno(FFA_RET_INVALID_PARAMETERS);
> > > +       }
> > > +
> > > +       invoke_ffa_fn((ffa_value_t){
> > > +               .a0 =3D FFA_FEATURES, .a1 =3D func_feat_id, .a2 =3D inp=
ut_props,
> > > +               }, &id);
> > > +
> > > +       if (id.a0 =3D=3D FFA_ERROR)
> > > +               return ffa_to_linux_errno((int)id.a2);
> > > +
> > > +       if (if_props)
> > > +               *if_props =3D id.a2;
> >
> > w3 (id.a3) also contains a value when querying for
> > FFA_MEM_RETRIEVE_REQ. I see that in "[PATCH 5/9] firmware: arm_ffa:
> > Use FFA_FEATURES to detect if native versions are supported" you're
> > using this function with if_props =3D NULL. So I guess that at the
> > moment we have more than needed, but in case you need to add another
> > parameter to this function you'll need to update all the call sites
> > too.
> >
>
> Right, I clearly missed to observe that. I am fine either way. Do you
> have any preference ? As long as the callers are with this driver, it
> shouldn't be much of an issue to change all, but happy to update to
> accommodate w3 as well in v2.

Either way is fine, it was more of an observation.

Cheers,
Jens

--===============1952442588380573177==--

