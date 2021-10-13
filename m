From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH] tee: optee: Fix missing devices unregister during optee_remove
Date: Wed, 13 Oct 2021 14:27:21 +0200
Message-ID: 
 <CAHUa44HFGWeF5x6rUqWY2vE2ia8MFZtxHXKGJc5JqBRScPOuYw@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYNqzmEe23RQ2Wrq2oeaxAxxwg+e3sW0=7PmgZni5Sd2eQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6315977708421524713=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6315977708421524713==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 13, 2021 at 8:00 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Tue, 12 Oct 2021 at 23:33, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Tue, Oct 12, 2021 at 01:01:16PM +0530, Sumit Garg wrote:
> > > When OP-TEE driver is built as a module, OP-TEE client devices
> > > registered on TEE bus during probe should be unregistered during
> > > optee_remove. So implement optee_unregister_devices() accordingly.
> > >
> > > Fixes: c3fa24af9244 ("tee: optee: add TEE bus device enumeration suppor=
t")
> > > Reported-by: Sudeep Holla <sudeep.holla@arm.com>
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > ---
> > >  drivers/tee/optee/core.c          |  3 +++
> > >  drivers/tee/optee/device.c        | 22 ++++++++++++++++++++++
> > >  drivers/tee/optee/optee_private.h |  1 +
> > >  3 files changed, 26 insertions(+)
> > >
> > > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > > index ccad3c7c8f6d..3915dc574503 100644
> > > --- a/drivers/tee/optee/core.c
> > > +++ b/drivers/tee/optee/core.c
> > > @@ -586,6 +586,9 @@ static int optee_remove(struct platform_device *pde=
v)
> > >  {
> > >       struct optee *optee =3D platform_get_drvdata(pdev);
> > >
> > > +     /* Unregister OP-TEE specific client devices on TEE bus */
> > > +     optee_unregister_devices();
> > > +
> >
> > This is not based on FF-A support series by Jens I assume.
>
> Yeah as it fixes an existing problem and for stable backport reasons I
> would suggest rebasing FF-A support series on top of it.
>
> > I added
> > optee_unregister_devices to optee_remove_common and that fixes the issue
> > I reported. I haven't followed the comments by Jens on the approach yet.
> >
>
> Thanks for testing this fix.


I'll rebase the next version of the FF-A patchset on this patch.

Cheers,
Jens

--===============6315977708421524713==--

