From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v7 4/4] MAINTAINERS: Add entry for TEE based Trusted Keys
Date: Wed, 14 Oct 2020 10:36:21 +0530
Message-ID: 
 <CAFA6WYOqknmYcoxPQKOk2rW+gJZ_8fQXZBMcicT9f562C0o-GA@mail.gmail.com>
In-Reply-To: <20201013134048.GA147135@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2575247559739581004=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2575247559739581004==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, 13 Oct 2020 at 19:10, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Tue, Oct 13, 2020 at 04:58:47PM +0530, Sumit Garg wrote:
> > On Tue, 13 Oct 2020 at 07:52, Jarkko Sakkinen
> > <jarkko.sakkinen@linux.intel.com> wrote:
> > >
> > > On Wed, Oct 07, 2020 at 03:37:48PM +0530, Sumit Garg wrote:
> > > > Add MAINTAINERS entry for TEE based Trusted Keys framework.
> > > >
> > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > > ---
> > > >  MAINTAINERS | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > >
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index 48aff80..eb3d889 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -9663,6 +9663,14 @@ F:     include/keys/trusted-type.h
> > > >  F:   include/keys/trusted_tpm.h
> > > >  F:   security/keys/trusted-keys/
> > > >
> > > > +KEYS-TRUSTED-TEE
> > > > +M:   Sumit Garg <sumit.garg@linaro.org>
> > > > +L:   linux-integrity(a)vger.kernel.org
> > > > +L:   keyrings(a)vger.kernel.org
> > > > +S:   Supported
> > > > +F:   include/keys/trusted_tee.h
> > > > +F:   security/keys/trusted-keys/trusted_tee.c
> > > > +
> > > >  KEYS/KEYRINGS
> > > >  M:   David Howells <dhowells@redhat.com>
> > > >  M:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > > --
> > > > 2.7.4
> > >
> > > I'm sorry but I think I have changed my mind on this. This has been
> > > spinning for a while and sometimes conclusions change over the time.
> > >
> > > I don't think that we really need a separate subsystem tag.
> >
> > I don't see it as a separate subsystem but rather a kind of underlying
> > trust source (TEE) driver plugged into existing trusted keys
> > subsystem. We could relate it to the RNG subsystem as well where there
> > is a subsystem maintainer and specific driver maintainers.
> >
> > IMO, having a dedicated entry like this brings clarity in maintenance
> > and in future we may have more trust sources like this added where
> > everyone may not have access to all the trust sources to test.
>
> More entries pointing to the exact same stuff does not necessarily mean
> clarity in my books.
>
> > > I'd be for a
> > > new M-entry or R-entry to the existing subsystem tag. It's essential to
> > > have ack from someone with ARM and TEE knowledge but this way too heavy
> > > for the purpose.
> >
> > If you still think otherwise then I am fine with a new M-entry for
> > existing trusted keys subsystem as well.
>
> Adding a M-entry does makes sense because trusted keys backends can be
> based on various technologies and standard. It's a different in that
> sense than lets say a TPM hardware driver.
>
> > > I also see it the most manageable if the trusted keys PR's come from a
> > > single source.
> >
> > I echo here with you to have a single source for trusted keys PR's
> > irrespective of whether we go with a separate trust source entry or
> > update existing subsystem entry.
> >
> > -Sumit
>
> And I echo that oviously if there is someone to say the final ack about
> TEE, I will require that as the minimum to ever pick any of those
> changes :-)
>
> I would resolve this with just the M-entry, and we can *later on*
> restructure, if there is a need for that. These things are not sealed
> to stone.

Okay, will add a M-entry for existing trusted keys subsystem.

-Sumit

>
> /Jarkko

--===============2575247559739581004==--

