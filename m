From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [op-tee] [PATCH v4 1/4] KEYS: trusted: Add generic trusted keys framework
Date: Fri, 15 May 2020 03:00:25 +0300
Message-ID: <956b284c2b144313fd158de75cba510eb98f71bf.camel@linux.intel.com>
In-Reply-To: <
 <CAFA6WYMciZ=qkG3N_9YWzt_DJr2dGwdAy9diMXCJSNjr2o5ONA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8036045337099583789=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8036045337099583789==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-05-14 at 16:53 +0530, Sumit Garg wrote:
> On Thu, 14 May 2020 at 05:55, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> > On Wed, 2020-05-06 at 15:10 +0530, Sumit Garg wrote:
> > > Current trusted keys framework is tightly coupled to use TPM device as
> > > an underlying implementation which makes it difficult for implementatio=
ns
> > > like Trusted Execution Environment (TEE) etc. to provide trusked keys
> > > support in case platform doesn't posses a TPM device.
> > >=20
> > > So this patch tries to add generic trusted keys framework where underly=
ing
> > > implemtations like TPM, TEE etc. could be easily plugged-in.
> > >=20
> > > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> >=20
> > I tend to agree how this is implemented and could merge it as such.
> >=20
> > I'm just thinking if we could refine this patch in a way that instead of
> > copying TRUSTED_DEBUG macro we could just replace pr_info() statements
> > with pr_debug()?
>=20
> AFAIU, TRUSTED_DEBUG being a security sensitive operation is only
> meant to be used in development environments and should be strictly
> disabled in production environments. But it may not always be true
> with pr_debug() with CONFIG_DYNAMIC_DEBUG=3Dy which allows the debug
> paths to be compiled into the kernel which can be enabled/disabled at
> runtime.
>=20
> IMO we should keep this TRUSTED_DEBUG macro, so that users are aware
> of its security sensitive nature and need to explicitly enable it to
> debug.

You are absolutely correct.

/Jarkko


--===============8036045337099583789==--

