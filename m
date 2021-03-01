From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v9 1/4] KEYS: trusted: Add generic trusted keys framework
Date: Mon, 01 Mar 2021 18:41:24 +0530
Message-ID: <20210301131127.793707-2-sumit.garg@linaro.org>
In-Reply-To: <20210301131127.793707-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3667064645512626458=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3667064645512626458==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Current trusted keys framework is tightly coupled to use TPM device as
an underlying implementation which makes it difficult for implementations
like Trusted Execution Environment (TEE) etc. to provide trusted keys
support in case platform doesn't posses a TPM device.

Add a generic trusted keys framework where underlying implementations
can be easily plugged in. Create struct trusted_key_ops to achieve this,
which contains necessary functions of a backend.

Also, define a module parameter in order to select a particular trust
source in case a platform support multiple trust sources. In case its
not specified then implementation itetrates through trust sources list
starting with TPM and assign the first trust source as a backend which
has initiazed successfully during iteration.

Note that current implementation only supports a single trust source at
runtime which is either selectable at compile time or during boot via
aforementioned module parameter.

Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 .../admin-guide/kernel-parameters.txt         |  12 +
 include/keys/trusted-type.h                   |  53 +++
 include/keys/trusted_tpm.h                    |  29 +-
 security/keys/trusted-keys/Makefile           |   1 +
 security/keys/trusted-keys/trusted_core.c     | 354 +++++++++++++++++
 security/keys/trusted-keys/trusted_tpm1.c     | 366 ++++--------------
 6 files changed, 497 insertions(+), 318 deletions(-)
 create mode 100644 security/keys/trusted-keys/trusted_core.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/=
admin-guide/kernel-parameters.txt
index 0ac883777318..fbc828994b06 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5459,6 +5459,18 @@
 			See Documentation/admin-guide/mm/transhuge.rst
 			for more details.
=20
+	trusted.source=3D	[KEYS]
+			Format: <string>
+			This parameter identifies the trust source as a backend
+			for trusted keys implementation. Supported trust
+			sources:
+			- "tpm"
+			- "tee"
+			If not specified then it defaults to iterating through
+			the trust source list starting with TPM and assigns the
+			first trust source as a backend which is initialized
+			successfully during iteration.
+
 	tsc=3D		Disable clocksource stability checks for TSC.
 			Format: <string>
 			[x86] reliable: mark tsc clocksource as reliable, this
diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
index a94c03a61d8f..24016898ca41 100644
--- a/include/keys/trusted-type.h
+++ b/include/keys/trusted-type.h
@@ -11,6 +11,12 @@
 #include <linux/rcupdate.h>
 #include <linux/tpm.h>
=20
+#ifdef pr_fmt
+#undef pr_fmt
+#endif
+
+#define pr_fmt(fmt) "trusted_key: " fmt
+
 #define MIN_KEY_SIZE			32
 #define MAX_KEY_SIZE			128
 #define MAX_BLOB_SIZE			512
@@ -40,6 +46,53 @@ struct trusted_key_options {
 	uint32_t policyhandle;
 };
=20
+struct trusted_key_ops {
+	/*
+	 * flag to indicate if trusted key implementation supports migration
+	 * or not.
+	 */
+	unsigned char migratable;
+
+	/* Initialize key interface. */
+	int (*init)(void);
+
+	/* Seal a key. */
+	int (*seal)(struct trusted_key_payload *p, char *datablob);
+
+	/* Unseal a key. */
+	int (*unseal)(struct trusted_key_payload *p, char *datablob);
+
+	/* Get a randomized key. */
+	int (*get_random)(unsigned char *key, size_t key_len);
+
+	/* Exit key interface. */
+	void (*exit)(void);
+};
+
+struct trusted_key_source {
+	char *name;
+	struct trusted_key_ops *ops;
+};
+
 extern struct key_type key_type_trusted;
=20
+#define TRUSTED_DEBUG 0
+
+#if TRUSTED_DEBUG
+static inline void dump_payload(struct trusted_key_payload *p)
+{
+	pr_info("key_len %d\n", p->key_len);
+	print_hex_dump(KERN_INFO, "key ", DUMP_PREFIX_NONE,
+		       16, 1, p->key, p->key_len, 0);
+	pr_info("bloblen %d\n", p->blob_len);
+	print_hex_dump(KERN_INFO, "blob ", DUMP_PREFIX_NONE,
+		       16, 1, p->blob, p->blob_len, 0);
+	pr_info("migratable %d\n", p->migratable);
+}
+#else
+static inline void dump_payload(struct trusted_key_payload *p)
+{
+}
+#endif
+
 #endif /* _KEYS_TRUSTED_TYPE_H */
diff --git a/include/keys/trusted_tpm.h b/include/keys/trusted_tpm.h
index a56d8e1298f2..7769b726863a 100644
--- a/include/keys/trusted_tpm.h
+++ b/include/keys/trusted_tpm.h
@@ -16,6 +16,8 @@
 #define LOAD32N(buffer, offset)	(*(uint32_t *)&buffer[offset])
 #define LOAD16(buffer, offset)	(ntohs(*(uint16_t *)&buffer[offset]))
=20
+extern struct trusted_key_ops trusted_key_tpm_ops;
+
 struct osapsess {
 	uint32_t handle;
 	unsigned char secret[SHA1_DIGEST_SIZE];
@@ -52,30 +54,19 @@ int tpm2_unseal_trusted(struct tpm_chip *chip,
 #if TPM_DEBUG
 static inline void dump_options(struct trusted_key_options *o)
 {
-	pr_info("trusted_key: sealing key type %d\n", o->keytype);
-	pr_info("trusted_key: sealing key handle %0X\n", o->keyhandle);
-	pr_info("trusted_key: pcrlock %d\n", o->pcrlock);
-	pr_info("trusted_key: pcrinfo %d\n", o->pcrinfo_len);
+	pr_info("sealing key type %d\n", o->keytype);
+	pr_info("sealing key handle %0X\n", o->keyhandle);
+	pr_info("pcrlock %d\n", o->pcrlock);
+	pr_info("pcrinfo %d\n", o->pcrinfo_len);
 	print_hex_dump(KERN_INFO, "pcrinfo ", DUMP_PREFIX_NONE,
 		       16, 1, o->pcrinfo, o->pcrinfo_len, 0);
 }
=20
-static inline void dump_payload(struct trusted_key_payload *p)
-{
-	pr_info("trusted_key: key_len %d\n", p->key_len);
-	print_hex_dump(KERN_INFO, "key ", DUMP_PREFIX_NONE,
-		       16, 1, p->key, p->key_len, 0);
-	pr_info("trusted_key: bloblen %d\n", p->blob_len);
-	print_hex_dump(KERN_INFO, "blob ", DUMP_PREFIX_NONE,
-		       16, 1, p->blob, p->blob_len, 0);
-	pr_info("trusted_key: migratable %d\n", p->migratable);
-}
-
 static inline void dump_sess(struct osapsess *s)
 {
 	print_hex_dump(KERN_INFO, "trusted-key: handle ", DUMP_PREFIX_NONE,
 		       16, 1, &s->handle, 4, 0);
-	pr_info("trusted-key: secret:\n");
+	pr_info("secret:\n");
 	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE,
 		       16, 1, &s->secret, SHA1_DIGEST_SIZE, 0);
 	pr_info("trusted-key: enonce:\n");
@@ -87,7 +78,7 @@ static inline void dump_tpm_buf(unsigned char *buf)
 {
 	int len;
=20
-	pr_info("\ntrusted-key: tpm buffer\n");
+	pr_info("\ntpm buffer\n");
 	len =3D LOAD32(buf, TPM_SIZE_OFFSET);
 	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE, 16, 1, buf, len, 0);
 }
@@ -96,10 +87,6 @@ static inline void dump_options(struct trusted_key_options=
 *o)
 {
 }
=20
-static inline void dump_payload(struct trusted_key_payload *p)
-{
-}
-
 static inline void dump_sess(struct osapsess *s)
 {
 }
diff --git a/security/keys/trusted-keys/Makefile b/security/keys/trusted-keys=
/Makefile
index 7b73cebbb378..49e3bcfe704f 100644
--- a/security/keys/trusted-keys/Makefile
+++ b/security/keys/trusted-keys/Makefile
@@ -4,5 +4,6 @@
 #
=20
 obj-$(CONFIG_TRUSTED_KEYS) +=3D trusted.o
+trusted-y +=3D trusted_core.o
 trusted-y +=3D trusted_tpm1.o
 trusted-y +=3D trusted_tpm2.o
diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/truste=
d-keys/trusted_core.c
new file mode 100644
index 000000000000..0db86b44605d
--- /dev/null
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -0,0 +1,354 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2010 IBM Corporation
+ * Copyright (c) 2019-2021, Linaro Limited
+ *
+ * See Documentation/security/keys/trusted-encrypted.rst
+ */
+
+#include <keys/user-type.h>
+#include <keys/trusted-type.h>
+#include <keys/trusted_tpm.h>
+#include <linux/capability.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/key-type.h>
+#include <linux/module.h>
+#include <linux/parser.h>
+#include <linux/rcupdate.h>
+#include <linux/slab.h>
+#include <linux/static_call.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+
+static char *trusted_key_source;
+module_param_named(source, trusted_key_source, charp, 0);
+MODULE_PARM_DESC(source, "Select trusted keys source (tpm or tee)");
+
+static const struct trusted_key_source trusted_key_sources[] =3D {
+#if defined(CONFIG_TCG_TPM)
+	{ "tpm", &trusted_key_tpm_ops },
+#endif
+};
+
+DEFINE_STATIC_CALL_NULL(trusted_key_init, *trusted_key_sources[0].ops->init);
+DEFINE_STATIC_CALL_NULL(trusted_key_seal, *trusted_key_sources[0].ops->seal);
+DEFINE_STATIC_CALL_NULL(trusted_key_unseal,
+			*trusted_key_sources[0].ops->unseal);
+DEFINE_STATIC_CALL_NULL(trusted_key_get_random,
+			*trusted_key_sources[0].ops->get_random);
+DEFINE_STATIC_CALL_NULL(trusted_key_exit, *trusted_key_sources[0].ops->exit);
+static unsigned char migratable;
+
+enum {
+	Opt_err,
+	Opt_new, Opt_load, Opt_update,
+};
+
+static const match_table_t key_tokens =3D {
+	{Opt_new, "new"},
+	{Opt_load, "load"},
+	{Opt_update, "update"},
+	{Opt_err, NULL}
+};
+
+/*
+ * datablob_parse - parse the keyctl data and fill in the
+ *                  payload structure
+ *
+ * On success returns 0, otherwise -EINVAL.
+ */
+static int datablob_parse(char *datablob, struct trusted_key_payload *p)
+{
+	substring_t args[MAX_OPT_ARGS];
+	long keylen;
+	int ret =3D -EINVAL;
+	int key_cmd;
+	char *c;
+
+	/* main command */
+	c =3D strsep(&datablob, " \t");
+	if (!c)
+		return -EINVAL;
+	key_cmd =3D match_token(c, key_tokens, args);
+	switch (key_cmd) {
+	case Opt_new:
+		/* first argument is key size */
+		c =3D strsep(&datablob, " \t");
+		if (!c)
+			return -EINVAL;
+		ret =3D kstrtol(c, 10, &keylen);
+		if (ret < 0 || keylen < MIN_KEY_SIZE || keylen > MAX_KEY_SIZE)
+			return -EINVAL;
+		p->key_len =3D keylen;
+		ret =3D Opt_new;
+		break;
+	case Opt_load:
+		/* first argument is sealed blob */
+		c =3D strsep(&datablob, " \t");
+		if (!c)
+			return -EINVAL;
+		p->blob_len =3D strlen(c) / 2;
+		if (p->blob_len > MAX_BLOB_SIZE)
+			return -EINVAL;
+		ret =3D hex2bin(p->blob, c, p->blob_len);
+		if (ret < 0)
+			return -EINVAL;
+		ret =3D Opt_load;
+		break;
+	case Opt_update:
+		ret =3D Opt_update;
+		break;
+	case Opt_err:
+		return -EINVAL;
+	}
+	return ret;
+}
+
+static struct trusted_key_payload *trusted_payload_alloc(struct key *key)
+{
+	struct trusted_key_payload *p =3D NULL;
+	int ret;
+
+	ret =3D key_payload_reserve(key, sizeof(*p));
+	if (ret < 0)
+		return p;
+	p =3D kzalloc(sizeof(*p), GFP_KERNEL);
+
+	p->migratable =3D migratable;
+
+	return p;
+}
+
+/*
+ * trusted_instantiate - create a new trusted key
+ *
+ * Unseal an existing trusted blob or, for a new key, get a
+ * random key, then seal and create a trusted key-type key,
+ * adding it to the specified keyring.
+ *
+ * On success, return 0. Otherwise return errno.
+ */
+static int trusted_instantiate(struct key *key,
+			       struct key_preparsed_payload *prep)
+{
+	struct trusted_key_payload *payload =3D NULL;
+	size_t datalen =3D prep->datalen;
+	char *datablob;
+	int ret =3D 0;
+	int key_cmd;
+	size_t key_len;
+
+	if (datalen <=3D 0 || datalen > 32767 || !prep->data)
+		return -EINVAL;
+
+	datablob =3D kmalloc(datalen + 1, GFP_KERNEL);
+	if (!datablob)
+		return -ENOMEM;
+	memcpy(datablob, prep->data, datalen);
+	datablob[datalen] =3D '\0';
+
+	payload =3D trusted_payload_alloc(key);
+	if (!payload) {
+		ret =3D -ENOMEM;
+		goto out;
+	}
+
+	key_cmd =3D datablob_parse(datablob, payload);
+	if (key_cmd < 0) {
+		ret =3D key_cmd;
+		goto out;
+	}
+
+	dump_payload(payload);
+
+	switch (key_cmd) {
+	case Opt_load:
+		ret =3D static_call(trusted_key_unseal)(payload, datablob);
+		dump_payload(payload);
+		if (ret < 0)
+			pr_info("key_unseal failed (%d)\n", ret);
+		break;
+	case Opt_new:
+		key_len =3D payload->key_len;
+		ret =3D static_call(trusted_key_get_random)(payload->key,
+							  key_len);
+		if (ret < 0)
+			goto out;
+
+		if (ret !=3D key_len) {
+			pr_info("key_create failed (%d)\n", ret);
+			ret =3D -EIO;
+			goto out;
+		}
+
+		ret =3D static_call(trusted_key_seal)(payload, datablob);
+		if (ret < 0)
+			pr_info("key_seal failed (%d)\n", ret);
+		break;
+	default:
+		ret =3D -EINVAL;
+	}
+out:
+	kfree_sensitive(datablob);
+	if (!ret)
+		rcu_assign_keypointer(key, payload);
+	else
+		kfree_sensitive(payload);
+	return ret;
+}
+
+static void trusted_rcu_free(struct rcu_head *rcu)
+{
+	struct trusted_key_payload *p;
+
+	p =3D container_of(rcu, struct trusted_key_payload, rcu);
+	kfree_sensitive(p);
+}
+
+/*
+ * trusted_update - reseal an existing key with new PCR values
+ */
+static int trusted_update(struct key *key, struct key_preparsed_payload *pre=
p)
+{
+	struct trusted_key_payload *p;
+	struct trusted_key_payload *new_p;
+	size_t datalen =3D prep->datalen;
+	char *datablob;
+	int ret =3D 0;
+
+	if (key_is_negative(key))
+		return -ENOKEY;
+	p =3D key->payload.data[0];
+	if (!p->migratable)
+		return -EPERM;
+	if (datalen <=3D 0 || datalen > 32767 || !prep->data)
+		return -EINVAL;
+
+	datablob =3D kmalloc(datalen + 1, GFP_KERNEL);
+	if (!datablob)
+		return -ENOMEM;
+
+	new_p =3D trusted_payload_alloc(key);
+	if (!new_p) {
+		ret =3D -ENOMEM;
+		goto out;
+	}
+
+	memcpy(datablob, prep->data, datalen);
+	datablob[datalen] =3D '\0';
+	ret =3D datablob_parse(datablob, new_p);
+	if (ret !=3D Opt_update) {
+		ret =3D -EINVAL;
+		kfree_sensitive(new_p);
+		goto out;
+	}
+
+	/* copy old key values, and reseal with new pcrs */
+	new_p->migratable =3D p->migratable;
+	new_p->key_len =3D p->key_len;
+	memcpy(new_p->key, p->key, p->key_len);
+	dump_payload(p);
+	dump_payload(new_p);
+
+	ret =3D static_call(trusted_key_seal)(new_p, datablob);
+	if (ret < 0) {
+		pr_info("key_seal failed (%d)\n", ret);
+		kfree_sensitive(new_p);
+		goto out;
+	}
+
+	rcu_assign_keypointer(key, new_p);
+	call_rcu(&p->rcu, trusted_rcu_free);
+out:
+	kfree_sensitive(datablob);
+	return ret;
+}
+
+/*
+ * trusted_read - copy the sealed blob data to userspace in hex.
+ * On success, return to userspace the trusted key datablob size.
+ */
+static long trusted_read(const struct key *key, char *buffer,
+			 size_t buflen)
+{
+	const struct trusted_key_payload *p;
+	char *bufp;
+	int i;
+
+	p =3D dereference_key_locked(key);
+	if (!p)
+		return -EINVAL;
+
+	if (buffer && buflen >=3D 2 * p->blob_len) {
+		bufp =3D buffer;
+		for (i =3D 0; i < p->blob_len; i++)
+			bufp =3D hex_byte_pack(bufp, p->blob[i]);
+	}
+	return 2 * p->blob_len;
+}
+
+/*
+ * trusted_destroy - clear and free the key's payload
+ */
+static void trusted_destroy(struct key *key)
+{
+	kfree_sensitive(key->payload.data[0]);
+}
+
+struct key_type key_type_trusted =3D {
+	.name =3D "trusted",
+	.instantiate =3D trusted_instantiate,
+	.update =3D trusted_update,
+	.destroy =3D trusted_destroy,
+	.describe =3D user_describe,
+	.read =3D trusted_read,
+};
+EXPORT_SYMBOL_GPL(key_type_trusted);
+
+static int __init init_trusted(void)
+{
+	int i, ret =3D 0;
+
+	for (i =3D 0; i < ARRAY_SIZE(trusted_key_sources); i++) {
+		if (trusted_key_source &&
+		    strncmp(trusted_key_source, trusted_key_sources[i].name,
+			    strlen(trusted_key_sources[i].name)))
+			continue;
+
+		static_call_update(trusted_key_init,
+				   trusted_key_sources[i].ops->init);
+		static_call_update(trusted_key_seal,
+				   trusted_key_sources[i].ops->seal);
+		static_call_update(trusted_key_unseal,
+				   trusted_key_sources[i].ops->unseal);
+		static_call_update(trusted_key_get_random,
+				   trusted_key_sources[i].ops->get_random);
+		static_call_update(trusted_key_exit,
+				   trusted_key_sources[i].ops->exit);
+		migratable =3D trusted_key_sources[i].ops->migratable;
+
+		ret =3D static_call(trusted_key_init)();
+		if (!ret)
+			break;
+	}
+
+	/*
+	 * encrypted_keys.ko depends on successful load of this module even if
+	 * trusted key implementation is not found.
+	 */
+	if (ret =3D=3D -ENODEV)
+		return 0;
+
+	return ret;
+}
+
+static void __exit cleanup_trusted(void)
+{
+	static_call(trusted_key_exit)();
+}
+
+late_initcall(init_trusted);
+module_exit(cleanup_trusted);
+
+MODULE_LICENSE("GPL");
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/truste=
d-keys/trusted_tpm1.c
index 493eb91ed017..99172af30d27 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -1,29 +1,22 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (C) 2010 IBM Corporation
- *
- * Author:
- * David Safford <safford@us.ibm.com>
+ * Copyright (c) 2019-2021, Linaro Limited
  *
  * See Documentation/security/keys/trusted-encrypted.rst
  */
=20
 #include <crypto/hash_info.h>
-#include <linux/uaccess.h>
-#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/parser.h>
 #include <linux/string.h>
 #include <linux/err.h>
-#include <keys/user-type.h>
 #include <keys/trusted-type.h>
 #include <linux/key-type.h>
-#include <linux/rcupdate.h>
 #include <linux/crypto.h>
 #include <crypto/hash.h>
 #include <crypto/sha1.h>
-#include <linux/capability.h>
 #include <linux/tpm.h>
 #include <linux/tpm_command.h>
=20
@@ -63,7 +56,7 @@ static int TSS_sha1(const unsigned char *data, unsigned int=
 datalen,
=20
 	sdesc =3D init_sdesc(hashalg);
 	if (IS_ERR(sdesc)) {
-		pr_info("trusted_key: can't alloc %s\n", hash_alg);
+		pr_info("can't alloc %s\n", hash_alg);
 		return PTR_ERR(sdesc);
 	}
=20
@@ -83,7 +76,7 @@ static int TSS_rawhmac(unsigned char *digest, const unsigne=
d char *key,
=20
 	sdesc =3D init_sdesc(hmacalg);
 	if (IS_ERR(sdesc)) {
-		pr_info("trusted_key: can't alloc %s\n", hmac_alg);
+		pr_info("can't alloc %s\n", hmac_alg);
 		return PTR_ERR(sdesc);
 	}
=20
@@ -136,7 +129,7 @@ int TSS_authhmac(unsigned char *digest, const unsigned ch=
ar *key,
=20
 	sdesc =3D init_sdesc(hashalg);
 	if (IS_ERR(sdesc)) {
-		pr_info("trusted_key: can't alloc %s\n", hash_alg);
+		pr_info("can't alloc %s\n", hash_alg);
 		return PTR_ERR(sdesc);
 	}
=20
@@ -212,7 +205,7 @@ int TSS_checkhmac1(unsigned char *buffer,
=20
 	sdesc =3D init_sdesc(hashalg);
 	if (IS_ERR(sdesc)) {
-		pr_info("trusted_key: can't alloc %s\n", hash_alg);
+		pr_info("can't alloc %s\n", hash_alg);
 		return PTR_ERR(sdesc);
 	}
 	ret =3D crypto_shash_init(&sdesc->shash);
@@ -305,7 +298,7 @@ static int TSS_checkhmac2(unsigned char *buffer,
=20
 	sdesc =3D init_sdesc(hashalg);
 	if (IS_ERR(sdesc)) {
-		pr_info("trusted_key: can't alloc %s\n", hash_alg);
+		pr_info("can't alloc %s\n", hash_alg);
 		return PTR_ERR(sdesc);
 	}
 	ret =3D crypto_shash_init(&sdesc->shash);
@@ -597,12 +590,12 @@ static int tpm_unseal(struct tpm_buf *tb,
 	/* sessions for unsealing key and data */
 	ret =3D oiap(tb, &authhandle1, enonce1);
 	if (ret < 0) {
-		pr_info("trusted_key: oiap failed (%d)\n", ret);
+		pr_info("oiap failed (%d)\n", ret);
 		return ret;
 	}
 	ret =3D oiap(tb, &authhandle2, enonce2);
 	if (ret < 0) {
-		pr_info("trusted_key: oiap failed (%d)\n", ret);
+		pr_info("oiap failed (%d)\n", ret);
 		return ret;
 	}
=20
@@ -612,7 +605,7 @@ static int tpm_unseal(struct tpm_buf *tb,
 		return ret;
=20
 	if (ret !=3D TPM_NONCE_SIZE) {
-		pr_info("trusted_key: tpm_get_random failed (%d)\n", ret);
+		pr_info("tpm_get_random failed (%d)\n", ret);
 		return -EIO;
 	}
 	ret =3D TSS_authhmac(authdata1, keyauth, TPM_NONCE_SIZE,
@@ -641,7 +634,7 @@ static int tpm_unseal(struct tpm_buf *tb,
=20
 	ret =3D trusted_tpm_send(tb->data, MAX_BUF_SIZE);
 	if (ret < 0) {
-		pr_info("trusted_key: authhmac failed (%d)\n", ret);
+		pr_info("authhmac failed (%d)\n", ret);
 		return ret;
 	}
=20
@@ -653,7 +646,7 @@ static int tpm_unseal(struct tpm_buf *tb,
 			     *datalen, TPM_DATA_OFFSET + sizeof(uint32_t), 0,
 			     0);
 	if (ret < 0) {
-		pr_info("trusted_key: TSS_checkhmac2 failed (%d)\n", ret);
+		pr_info("TSS_checkhmac2 failed (%d)\n", ret);
 		return ret;
 	}
 	memcpy(data, tb->data + TPM_DATA_OFFSET + sizeof(uint32_t), *datalen);
@@ -680,7 +673,7 @@ static int key_seal(struct trusted_key_payload *p,
 		       p->key, p->key_len + 1, p->blob, &p->blob_len,
 		       o->blobauth, o->pcrinfo, o->pcrinfo_len);
 	if (ret < 0)
-		pr_info("trusted_key: srkseal failed (%d)\n", ret);
+		pr_info("srkseal failed (%d)\n", ret);
=20
 	tpm_buf_destroy(&tb);
 	return ret;
@@ -702,7 +695,7 @@ static int key_unseal(struct trusted_key_payload *p,
 	ret =3D tpm_unseal(&tb, o->keyhandle, o->keyauth, p->blob, p->blob_len,
 			 o->blobauth, p->key, &p->key_len);
 	if (ret < 0)
-		pr_info("trusted_key: srkunseal failed (%d)\n", ret);
+		pr_info("srkunseal failed (%d)\n", ret);
 	else
 		/* pull migratable flag out of sealed key */
 		p->migratable =3D p->key[--p->key_len];
@@ -713,7 +706,6 @@ static int key_unseal(struct trusted_key_payload *p,
=20
 enum {
 	Opt_err,
-	Opt_new, Opt_load, Opt_update,
 	Opt_keyhandle, Opt_keyauth, Opt_blobauth,
 	Opt_pcrinfo, Opt_pcrlock, Opt_migratable,
 	Opt_hash,
@@ -722,9 +714,6 @@ enum {
 };
=20
 static const match_table_t key_tokens =3D {
-	{Opt_new, "new"},
-	{Opt_load, "load"},
-	{Opt_update, "update"},
 	{Opt_keyhandle, "keyhandle=3D%s"},
 	{Opt_keyauth, "keyauth=3D%s"},
 	{Opt_blobauth, "blobauth=3D%s"},
@@ -822,7 +811,7 @@ static int getoptions(char *c, struct trusted_key_payload=
 *pay,
 			if (i =3D=3D HASH_ALGO__LAST)
 				return -EINVAL;
 			if  (!tpm2 && i !=3D HASH_ALGO_SHA1) {
-				pr_info("trusted_key: TPM 1.x only supports SHA-1.\n");
+				pr_info("TPM 1.x only supports SHA-1.\n");
 				return -EINVAL;
 			}
 			break;
@@ -851,71 +840,6 @@ static int getoptions(char *c, struct trusted_key_payloa=
d *pay,
 	return 0;
 }
=20
-/*
- * datablob_parse - parse the keyctl data and fill in the
- * 		    payload and options structures
- *
- * On success returns 0, otherwise -EINVAL.
- */
-static int datablob_parse(char *datablob, struct trusted_key_payload *p,
-			  struct trusted_key_options *o)
-{
-	substring_t args[MAX_OPT_ARGS];
-	long keylen;
-	int ret =3D -EINVAL;
-	int key_cmd;
-	char *c;
-
-	/* main command */
-	c =3D strsep(&datablob, " \t");
-	if (!c)
-		return -EINVAL;
-	key_cmd =3D match_token(c, key_tokens, args);
-	switch (key_cmd) {
-	case Opt_new:
-		/* first argument is key size */
-		c =3D strsep(&datablob, " \t");
-		if (!c)
-			return -EINVAL;
-		ret =3D kstrtol(c, 10, &keylen);
-		if (ret < 0 || keylen < MIN_KEY_SIZE || keylen > MAX_KEY_SIZE)
-			return -EINVAL;
-		p->key_len =3D keylen;
-		ret =3D getoptions(datablob, p, o);
-		if (ret < 0)
-			return ret;
-		ret =3D Opt_new;
-		break;
-	case Opt_load:
-		/* first argument is sealed blob */
-		c =3D strsep(&datablob, " \t");
-		if (!c)
-			return -EINVAL;
-		p->blob_len =3D strlen(c) / 2;
-		if (p->blob_len > MAX_BLOB_SIZE)
-			return -EINVAL;
-		ret =3D hex2bin(p->blob, c, p->blob_len);
-		if (ret < 0)
-			return -EINVAL;
-		ret =3D getoptions(datablob, p, o);
-		if (ret < 0)
-			return ret;
-		ret =3D Opt_load;
-		break;
-	case Opt_update:
-		/* all arguments are options */
-		ret =3D getoptions(datablob, p, o);
-		if (ret < 0)
-			return ret;
-		ret =3D Opt_update;
-		break;
-	case Opt_err:
-		return -EINVAL;
-		break;
-	}
-	return ret;
-}
-
 static struct trusted_key_options *trusted_options_alloc(void)
 {
 	struct trusted_key_options *options;
@@ -936,252 +860,99 @@ static struct trusted_key_options *trusted_options_all=
oc(void)
 	return options;
 }
=20
-static struct trusted_key_payload *trusted_payload_alloc(struct key *key)
+static int trusted_tpm_seal(struct trusted_key_payload *p, char *datablob)
 {
-	struct trusted_key_payload *p =3D NULL;
-	int ret;
-
-	ret =3D key_payload_reserve(key, sizeof *p);
-	if (ret < 0)
-		return p;
-	p =3D kzalloc(sizeof *p, GFP_KERNEL);
-	if (p)
-		p->migratable =3D 1; /* migratable by default */
-	return p;
-}
-
-/*
- * trusted_instantiate - create a new trusted key
- *
- * Unseal an existing trusted blob or, for a new key, get a
- * random key, then seal and create a trusted key-type key,
- * adding it to the specified keyring.
- *
- * On success, return 0. Otherwise return errno.
- */
-static int trusted_instantiate(struct key *key,
-			       struct key_preparsed_payload *prep)
-{
-	struct trusted_key_payload *payload =3D NULL;
 	struct trusted_key_options *options =3D NULL;
-	size_t datalen =3D prep->datalen;
-	char *datablob;
 	int ret =3D 0;
-	int key_cmd;
-	size_t key_len;
 	int tpm2;
=20
 	tpm2 =3D tpm_is_tpm2(chip);
 	if (tpm2 < 0)
 		return tpm2;
=20
-	if (datalen <=3D 0 || datalen > 32767 || !prep->data)
-		return -EINVAL;
-
-	datablob =3D kmalloc(datalen + 1, GFP_KERNEL);
-	if (!datablob)
-		return -ENOMEM;
-	memcpy(datablob, prep->data, datalen);
-	datablob[datalen] =3D '\0';
-
 	options =3D trusted_options_alloc();
-	if (!options) {
-		ret =3D -ENOMEM;
-		goto out;
-	}
-	payload =3D trusted_payload_alloc(key);
-	if (!payload) {
-		ret =3D -ENOMEM;
-		goto out;
-	}
+	if (!options)
+		return -ENOMEM;
=20
-	key_cmd =3D datablob_parse(datablob, payload, options);
-	if (key_cmd < 0) {
-		ret =3D key_cmd;
+	ret =3D getoptions(datablob, p, options);
+	if (ret < 0)
 		goto out;
-	}
+	dump_options(options);
=20
 	if (!options->keyhandle) {
 		ret =3D -EINVAL;
 		goto out;
 	}
=20
-	dump_payload(payload);
-	dump_options(options);
-
-	switch (key_cmd) {
-	case Opt_load:
-		if (tpm2)
-			ret =3D tpm2_unseal_trusted(chip, payload, options);
-		else
-			ret =3D key_unseal(payload, options);
-		dump_payload(payload);
-		dump_options(options);
-		if (ret < 0)
-			pr_info("trusted_key: key_unseal failed (%d)\n", ret);
-		break;
-	case Opt_new:
-		key_len =3D payload->key_len;
-		ret =3D tpm_get_random(chip, payload->key, key_len);
-		if (ret < 0)
-			goto out;
+	if (tpm2)
+		ret =3D tpm2_seal_trusted(chip, p, options);
+	else
+		ret =3D key_seal(p, options);
+	if (ret < 0) {
+		pr_info("key_seal failed (%d)\n", ret);
+		goto out;
+	}
=20
-		if (ret !=3D key_len) {
-			pr_info("trusted_key: key_create failed (%d)\n", ret);
-			ret =3D -EIO;
+	if (options->pcrlock) {
+		ret =3D pcrlock(options->pcrlock);
+		if (ret < 0) {
+			pr_info("pcrlock failed (%d)\n", ret);
 			goto out;
 		}
-		if (tpm2)
-			ret =3D tpm2_seal_trusted(chip, payload, options);
-		else
-			ret =3D key_seal(payload, options);
-		if (ret < 0)
-			pr_info("trusted_key: key_seal failed (%d)\n", ret);
-		break;
-	default:
-		ret =3D -EINVAL;
-		goto out;
 	}
-	if (!ret && options->pcrlock)
-		ret =3D pcrlock(options->pcrlock);
 out:
-	kfree_sensitive(datablob);
 	kfree_sensitive(options);
-	if (!ret)
-		rcu_assign_keypointer(key, payload);
-	else
-		kfree_sensitive(payload);
 	return ret;
 }
=20
-static void trusted_rcu_free(struct rcu_head *rcu)
-{
-	struct trusted_key_payload *p;
-
-	p =3D container_of(rcu, struct trusted_key_payload, rcu);
-	kfree_sensitive(p);
-}
-
-/*
- * trusted_update - reseal an existing key with new PCR values
- */
-static int trusted_update(struct key *key, struct key_preparsed_payload *pre=
p)
+static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
 {
-	struct trusted_key_payload *p;
-	struct trusted_key_payload *new_p;
-	struct trusted_key_options *new_o;
-	size_t datalen =3D prep->datalen;
-	char *datablob;
+	struct trusted_key_options *options =3D NULL;
 	int ret =3D 0;
+	int tpm2;
=20
-	if (key_is_negative(key))
-		return -ENOKEY;
-	p =3D key->payload.data[0];
-	if (!p->migratable)
-		return -EPERM;
-	if (datalen <=3D 0 || datalen > 32767 || !prep->data)
-		return -EINVAL;
+	tpm2 =3D tpm_is_tpm2(chip);
+	if (tpm2 < 0)
+		return tpm2;
=20
-	datablob =3D kmalloc(datalen + 1, GFP_KERNEL);
-	if (!datablob)
+	options =3D trusted_options_alloc();
+	if (!options)
 		return -ENOMEM;
-	new_o =3D trusted_options_alloc();
-	if (!new_o) {
-		ret =3D -ENOMEM;
-		goto out;
-	}
-	new_p =3D trusted_payload_alloc(key);
-	if (!new_p) {
-		ret =3D -ENOMEM;
-		goto out;
-	}
=20
-	memcpy(datablob, prep->data, datalen);
-	datablob[datalen] =3D '\0';
-	ret =3D datablob_parse(datablob, new_p, new_o);
-	if (ret !=3D Opt_update) {
-		ret =3D -EINVAL;
-		kfree_sensitive(new_p);
+	ret =3D getoptions(datablob, p, options);
+	if (ret < 0)
 		goto out;
-	}
+	dump_options(options);
=20
-	if (!new_o->keyhandle) {
+	if (!options->keyhandle) {
 		ret =3D -EINVAL;
-		kfree_sensitive(new_p);
 		goto out;
 	}
=20
-	/* copy old key values, and reseal with new pcrs */
-	new_p->migratable =3D p->migratable;
-	new_p->key_len =3D p->key_len;
-	memcpy(new_p->key, p->key, p->key_len);
-	dump_payload(p);
-	dump_payload(new_p);
+	if (tpm2)
+		ret =3D tpm2_unseal_trusted(chip, p, options);
+	else
+		ret =3D key_unseal(p, options);
+	if (ret < 0)
+		pr_info("key_unseal failed (%d)\n", ret);
=20
-	ret =3D key_seal(new_p, new_o);
-	if (ret < 0) {
-		pr_info("trusted_key: key_seal failed (%d)\n", ret);
-		kfree_sensitive(new_p);
-		goto out;
-	}
-	if (new_o->pcrlock) {
-		ret =3D pcrlock(new_o->pcrlock);
+	if (options->pcrlock) {
+		ret =3D pcrlock(options->pcrlock);
 		if (ret < 0) {
-			pr_info("trusted_key: pcrlock failed (%d)\n", ret);
-			kfree_sensitive(new_p);
+			pr_info("pcrlock failed (%d)\n", ret);
 			goto out;
 		}
 	}
-	rcu_assign_keypointer(key, new_p);
-	call_rcu(&p->rcu, trusted_rcu_free);
 out:
-	kfree_sensitive(datablob);
-	kfree_sensitive(new_o);
+	kfree_sensitive(options);
 	return ret;
 }
=20
-/*
- * trusted_read - copy the sealed blob data to userspace in hex.
- * On success, return to userspace the trusted key datablob size.
- */
-static long trusted_read(const struct key *key, char *buffer,
-			 size_t buflen)
+static int trusted_tpm_get_random(unsigned char *key, size_t key_len)
 {
-	const struct trusted_key_payload *p;
-	char *bufp;
-	int i;
-
-	p =3D dereference_key_locked(key);
-	if (!p)
-		return -EINVAL;
-
-	if (buffer && buflen >=3D 2 * p->blob_len) {
-		bufp =3D buffer;
-		for (i =3D 0; i < p->blob_len; i++)
-			bufp =3D hex_byte_pack(bufp, p->blob[i]);
-	}
-	return 2 * p->blob_len;
+	return tpm_get_random(chip, key, key_len);
 }
=20
-/*
- * trusted_destroy - clear and free the key's payload
- */
-static void trusted_destroy(struct key *key)
-{
-	kfree_sensitive(key->payload.data[0]);
-}
-
-struct key_type key_type_trusted =3D {
-	.name =3D "trusted",
-	.instantiate =3D trusted_instantiate,
-	.update =3D trusted_update,
-	.destroy =3D trusted_destroy,
-	.describe =3D user_describe,
-	.read =3D trusted_read,
-};
-
-EXPORT_SYMBOL_GPL(key_type_trusted);
-
 static void trusted_shash_release(void)
 {
 	if (hashalg)
@@ -1196,14 +967,14 @@ static int __init trusted_shash_alloc(void)
=20
 	hmacalg =3D crypto_alloc_shash(hmac_alg, 0, 0);
 	if (IS_ERR(hmacalg)) {
-		pr_info("trusted_key: could not allocate crypto %s\n",
+		pr_info("could not allocate crypto %s\n",
 			hmac_alg);
 		return PTR_ERR(hmacalg);
 	}
=20
 	hashalg =3D crypto_alloc_shash(hash_alg, 0, 0);
 	if (IS_ERR(hashalg)) {
-		pr_info("trusted_key: could not allocate crypto %s\n",
+		pr_info("could not allocate crypto %s\n",
 			hash_alg);
 		ret =3D PTR_ERR(hashalg);
 		goto hashalg_fail;
@@ -1231,16 +1002,13 @@ static int __init init_digests(void)
 	return 0;
 }
=20
-static int __init init_trusted(void)
+static int trusted_tpm_init(void)
 {
 	int ret;
=20
-	/* encrypted_keys.ko depends on successful load of this module even if
-	 * TPM is not used.
-	 */
 	chip =3D tpm_default_chip();
 	if (!chip)
-		return 0;
+		return -ENODEV;
=20
 	ret =3D init_digests();
 	if (ret < 0)
@@ -1261,7 +1029,7 @@ static int __init init_trusted(void)
 	return ret;
 }
=20
-static void __exit cleanup_trusted(void)
+static void trusted_tpm_exit(void)
 {
 	if (chip) {
 		put_device(&chip->dev);
@@ -1271,7 +1039,11 @@ static void __exit cleanup_trusted(void)
 	}
 }
=20
-late_initcall(init_trusted);
-module_exit(cleanup_trusted);
-
-MODULE_LICENSE("GPL");
+struct trusted_key_ops trusted_key_tpm_ops =3D {
+	.migratable =3D 1, /* migratable by default */
+	.init =3D trusted_tpm_init,
+	.seal =3D trusted_tpm_seal,
+	.unseal =3D trusted_tpm_unseal,
+	.get_random =3D trusted_tpm_get_random,
+	.exit =3D trusted_tpm_exit,
+};
--=20
2.25.1


--===============3667064645512626458==--

