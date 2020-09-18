From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v6 1/4] KEYS: trusted: Add generic trusted keys framework
Date: Fri, 18 Sep 2020 12:33:17 +0530
Message-ID: 
 <CAFA6WYNR2rMkEskJooDjQuu+dQ_zwVq-_9paW=zBgXmqM1GJqA@mail.gmail.com>
In-Reply-To: <20200917162506.GC9750@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8891119681776741202=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8891119681776741202==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Sep 2020 at 21:55, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Thu, Sep 17, 2020 at 07:21:49PM +0300, Jarkko Sakkinen wrote:
> > On Thu, Sep 17, 2020 at 07:16:35PM +0530, Sumit Garg wrote:
> > > Current trusted keys framework is tightly coupled to use TPM device as
> > > an underlying implementation which makes it difficult for implementatio=
ns
> > > like Trusted Execution Environment (TEE) etc. to provide trusted keys
> > > support in case platform doesn't posses a TPM device.
> > >
> > > So this patch tries to add generic trusted keys framework where underly=
ing
> > > implementations like TPM, TEE etc. could be easily plugged-in.
> >
> > I would rephrase this a bit:
> >
> > "Add a generic trusted keys framework where underlying implementations
> > can be easily plugged in. Create struct trusted_key_ops to achieve this,
> > which contains necessary functions of a backend."
> >

Okay, will use it instead.

> > I remember asking about this approach that what if there was just a
> > header for trusted key functions and a compile time decision, which C
> > file to include instead of ops struct. I don't remember if these was a
> > conclusion on this or not.

This approach was implemented as part of v5 and we concluded here [1]
to revert back to the dynamic approach as distro vendors won't like to
make opinionated selection at compile time which could rather be
achieved dynamically based on platform capability.

[1] https://www.spinics.net/lists/keyrings/msg08161.html

> >
> > E.g. lets say you have a device with TEE and TPM, should you be able
> > to be use both at run-time? I might play along how this works now but
> > somehow, in the commit message preferably, it should be conclude why
> > one alternative is chosen over another.
>

Okay, so how about adding a kernel module parameter which can enforce
the user's preference about which trust source to use at runtime? And
we should only check availability for that trust source if preference
is provided otherwise by default we can traverse the trust sources
list.

See following change, if this approach looks sane, I can include it in
next version:

diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
index edd635a..a566451 100644
--- a/include/keys/trusted-type.h
+++ b/include/keys/trusted-type.h
@@ -63,6 +63,11 @@ struct trusted_key_ops {
        void (*exit)(void);
 };

+struct trusted_key_source {
+       char *name;
+       struct trusted_key_ops *ops;
+};
+
 extern struct key_type key_type_trusted;

 #define TRUSTED_DEBUG 0
diff --git a/security/keys/trusted-keys/trusted_core.c
b/security/keys/trusted-keys/trusted_core.c
index 83a6a15..74a3d80 100644
--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -21,12 +21,16 @@
 #include <linux/string.h>
 #include <linux/uaccess.h>

-static struct trusted_key_ops *available_trusted_key_ops[] =3D {
+static char *trusted_key_source;
+module_param_named(source, trusted_key_source, charp, 0);
+MODULE_PARM_DESC(source, "Select trusted keys source (tpm or tee)");
+
+static struct trusted_key_source trusted_key_sources[] =3D {
 #if defined(CONFIG_TCG_TPM)
-       &tpm_trusted_key_ops,
+       { "tpm", &tpm_trusted_key_ops },
 #endif
 #if defined(CONFIG_TEE)
-       &tee_trusted_key_ops,
+       { "tee", &tee_trusted_key_ops },
 #endif
 };
 static struct trusted_key_ops *trusted_key_ops;
@@ -296,8 +300,13 @@ static int __init init_trusted(void)
 {
        int i, ret =3D 0;

-       for (i =3D 0; i < sizeof(available_trusted_key_ops); i++) {
-               trusted_key_ops =3D available_trusted_key_ops[i];
+       for (i =3D 0; i < ARRAY_SIZE(trusted_key_sources); i++) {
+               if (trusted_key_source &&
+                   strncmp(trusted_key_source, trusted_key_sources[i].name,
+                           strlen(trusted_key_sources[i].name)))
+                       continue;
+
+               trusted_key_ops =3D trusted_key_sources[i].ops;

                ret =3D trusted_key_ops->init();
                if (!ret)

> We must somehow seal this discussion because the other changes are
> based on this decision.
>
> I don't think tail of this patch set takes a long time spin. This
> is the main architectural decision.

Agree.

-Sumit

>
> /Jarkko

--===============8891119681776741202==--

