From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v7 1/4] KEYS: trusted: Add generic trusted keys framework
Date: Tue, 13 Oct 2020 14:59:18 +0300
Message-ID: <20201013115918.GB141833@linux.intel.com>
In-Reply-To: <
 <CAFA6WYN1n_x1wUefXEf-4Y+bUZybNAMeD9cirvz4WQnK2E7djw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8261474578017473464=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8261474578017473464==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2020 at 04:23:36PM +0530, Sumit Garg wrote:
> On Tue, 13 Oct 2020 at 07:13, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Wed, Oct 07, 2020 at 03:37:45PM +0530, Sumit Garg wrote:
> > > Current trusted keys framework is tightly coupled to use TPM device as
> > > an underlying implementation which makes it difficult for implementatio=
ns
> > > like Trusted Execution Environment (TEE) etc. to provide trusted keys
> > > support in case platform doesn't posses a TPM device.
> > >
> > > Add a generic trusted keys framework where underlying implementations
> > > can be easily plugged in. Create struct trusted_key_ops to achieve this,
> > > which contains necessary functions of a backend.
> > >
> > > Also, add a module parameter in order to select a particular trust sour=
ce
> > > in case a platform support multiple trust sources.
> > >
> > > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> >
> > This is exactly kind of place where I think static_call() should be
> > taken into use, which is a v5.10 feature [1]. For background and
> > context, I'd read [2].
>=20
> This looks like an interesting feature. But I am not sure about the
> real benefits that it will provide in case of trusted keys. If we are
> looking at it performance wise then I think the gain will be
> negligible when compared with slow TPM communication interface (eg.
> SPI, I2C) or when compared with context switching involved in TEE.
>=20
> Also, it requires arch specific support too which currently seems to
> be limited to x86 only.

Please, do not purposely add indirect calls, unless you  must. Here it's
not a must.

static_call() is the correct kernel idiom to define what you are doing
in this patch. arch's will catch up.

> > The other thing that I see that does not make much else than additional
> > complexity, is trusted_tpm.ko. We can do with one trusted.ko.
> >
>=20
> Current implementation only builds a single trusted.ko module. There
> isn't any trusted_tpm.ko.
> -Sumit

You're right, I'm sorry. I misread this:

-static void __exit cleanup_trusted(void)
+static void __exit exit_tpm_trusted(void)
 {
 	if (chip) {
 		put_device(&chip->dev);
@@ -1257,7 +1029,11 @@  static void __exit cleanup_trusted(void)
 	}
 }
=20
-late_initcall(init_trusted);
-module_exit(cleanup_trusted);
-
-MODULE_LICENSE("GPL");
+struct trusted_key_ops tpm_trusted_key_ops =3D {
+	.migratable =3D 1, /* migratable by default */
+	.init =3D init_tpm_trusted,
+	.seal =3D tpm_trusted_seal,
+	.unseal =3D tpm_trusted_unseal,
+	.get_random =3D tpm_trusted_get_random,
+	.exit =3D exit_tpm_trusted,
+};

Please remove "__init" and  "__exit" for the functions as they are used
as fields as members of a struct that has neither life span. That messed
up my head.

Please use a single convention for the function names. It would
be optimal to prefix with the subsystem name because that makes easier
to use tracing tools:  trusted_tpm_<callback name> would work.

/Jarkko

--===============8261474578017473464==--

