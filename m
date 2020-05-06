From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [op-tee] [PATCH v4 2/4] KEYS: trusted: Introduce TEE based Trusted Keys
Date: Wed, 06 May 2020 15:10:15 +0530
Message-ID: <1588758017-30426-3-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1588758017-30426-1-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0925906766563585119=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0925906766563585119==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Add support for TEE based trusted keys where TEE provides the functionality
to seal and unseal trusted keys using hardware unique key.

Refer to Documentation/tee.txt for detailed information about TEE.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 include/keys/trusted-type.h                 |   3 +
 include/keys/trusted_tee.h                  |  66 +++++++
 security/keys/Kconfig                       |   3 +
 security/keys/trusted-keys/Makefile         |   1 +
 security/keys/trusted-keys/trusted_common.c |   3 +
 security/keys/trusted-keys/trusted_tee.c    | 282 ++++++++++++++++++++++++++=
++
 6 files changed, 358 insertions(+)
 create mode 100644 include/keys/trusted_tee.h
 create mode 100644 security/keys/trusted-keys/trusted_tee.c

diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
index 5559010..e0df5df 100644
--- a/include/keys/trusted-type.h
+++ b/include/keys/trusted-type.h
@@ -67,6 +67,9 @@ extern struct key_type key_type_trusted;
 #if defined(CONFIG_TCG_TPM)
 extern struct trusted_key_ops tpm_trusted_key_ops;
 #endif
+#if defined(CONFIG_TEE)
+extern struct trusted_key_ops tee_trusted_key_ops;
+#endif
=20
 #define TRUSTED_DEBUG 0
=20
diff --git a/include/keys/trusted_tee.h b/include/keys/trusted_tee.h
new file mode 100644
index 0000000..ab58ffd
--- /dev/null
+++ b/include/keys/trusted_tee.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 Linaro Ltd.
+ *
+ * Author:
+ * Sumit Garg <sumit.garg@linaro.org>
+ */
+
+#ifndef __TEE_TRUSTED_KEY_H
+#define __TEE_TRUSTED_KEY_H
+
+#include <linux/tee_drv.h>
+
+#define DRIVER_NAME "tee-trusted-key"
+
+/*
+ * Get random data for symmetric key
+ *
+ * [out]     memref[0]        Random data
+ *
+ * Result:
+ * TEE_SUCCESS - Invoke command success
+ * TEE_ERROR_BAD_PARAMETERS - Incorrect input param
+ */
+#define TA_CMD_GET_RANDOM	0x0
+
+/*
+ * Seal trusted key using hardware unique key
+ *
+ * [in]      memref[0]        Plain key
+ * [out]     memref[1]        Sealed key datablob
+ *
+ * Result:
+ * TEE_SUCCESS - Invoke command success
+ * TEE_ERROR_BAD_PARAMETERS - Incorrect input param
+ */
+#define TA_CMD_SEAL		0x1
+
+/*
+ * Unseal trusted key using hardware unique key
+ *
+ * [in]      memref[0]        Sealed key datablob
+ * [out]     memref[1]        Plain key
+ *
+ * Result:
+ * TEE_SUCCESS - Invoke command success
+ * TEE_ERROR_BAD_PARAMETERS - Incorrect input param
+ */
+#define TA_CMD_UNSEAL		0x2
+
+/**
+ * struct trusted_key_private - TEE Trusted key private data
+ * @dev:		TEE based Trusted key device.
+ * @ctx:		TEE context handler.
+ * @session_id:		Trusted key TA session identifier.
+ * @shm_pool:		Memory pool shared with TEE device.
+ */
+struct trusted_key_private {
+	struct device *dev;
+	struct tee_context *ctx;
+	u32 session_id;
+	u32 data_rate;
+	struct tee_shm *shm_pool;
+};
+
+#endif
diff --git a/security/keys/Kconfig b/security/keys/Kconfig
index 47c0415..6ca6bc7 100644
--- a/security/keys/Kconfig
+++ b/security/keys/Kconfig
@@ -84,6 +84,9 @@ config TRUSTED_KEYS
 	  if the boot PCRs and other criteria match.  Userspace will only ever
 	  see encrypted blobs.
=20
+	  It also provides support for alternative TEE based Trusted keys
+	  generation and sealing in case TPM isn't present.
+
 	  If you are unsure as to whether this is required, answer N.
=20
 config ENCRYPTED_KEYS
diff --git a/security/keys/trusted-keys/Makefile b/security/keys/trusted-keys=
/Makefile
index 2b1085b..ea937d3 100644
--- a/security/keys/trusted-keys/Makefile
+++ b/security/keys/trusted-keys/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_TRUSTED_KEYS) +=3D trusted.o
 trusted-y +=3D trusted_common.o
 trusted-y +=3D trusted_tpm1.o
 trusted-y +=3D trusted_tpm2.o
+trusted-y +=3D trusted_tee.o
diff --git a/security/keys/trusted-keys/trusted_common.c b/security/keys/trus=
ted-keys/trusted_common.c
index 9bfd081..03555ed 100644
--- a/security/keys/trusted-keys/trusted_common.c
+++ b/security/keys/trusted-keys/trusted_common.c
@@ -27,6 +27,9 @@ static struct trusted_key_ops *available_tk_ops[] =3D {
 #if defined(CONFIG_TCG_TPM)
 	&tpm_trusted_key_ops,
 #endif
+#if defined(CONFIG_TEE)
+	&tee_trusted_key_ops,
+#endif
 };
 static struct trusted_key_ops *tk_ops;
=20
diff --git a/security/keys/trusted-keys/trusted_tee.c b/security/keys/trusted=
-keys/trusted_tee.c
new file mode 100644
index 0000000..724a73c
--- /dev/null
+++ b/security/keys/trusted-keys/trusted_tee.c
@@ -0,0 +1,282 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Linaro Ltd.
+ *
+ * Author:
+ * Sumit Garg <sumit.garg@linaro.org>
+ */
+
+#include <linux/err.h>
+#include <linux/key-type.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/uuid.h>
+
+#include <keys/trusted-type.h>
+#include <keys/trusted_tee.h>
+
+static struct trusted_key_private pvt_data;
+
+/*
+ * Have the TEE seal(encrypt) the symmetric key
+ */
+static int tee_key_seal(struct trusted_key_payload *p, char *datablob)
+{
+	int ret =3D 0;
+	struct tee_ioctl_invoke_arg inv_arg;
+	struct tee_param param[4];
+	struct tee_shm *reg_shm_in =3D NULL, *reg_shm_out =3D NULL;
+
+	memset(&inv_arg, 0, sizeof(inv_arg));
+	memset(&param, 0, sizeof(param));
+
+	reg_shm_in =3D tee_shm_register(pvt_data.ctx, (unsigned long)p->key,
+				      p->key_len, TEE_SHM_DMA_BUF |
+				      TEE_SHM_KERNEL_MAPPED);
+	if (IS_ERR(reg_shm_in)) {
+		dev_err(pvt_data.dev, "key shm register failed\n");
+		return PTR_ERR(reg_shm_in);
+	}
+
+	reg_shm_out =3D tee_shm_register(pvt_data.ctx, (unsigned long)p->blob,
+				       sizeof(p->blob), TEE_SHM_DMA_BUF |
+				       TEE_SHM_KERNEL_MAPPED);
+	if (IS_ERR(reg_shm_out)) {
+		dev_err(pvt_data.dev, "blob shm register failed\n");
+		ret =3D PTR_ERR(reg_shm_out);
+		goto out;
+	}
+
+	inv_arg.func =3D TA_CMD_SEAL;
+	inv_arg.session =3D pvt_data.session_id;
+	inv_arg.num_params =3D 4;
+
+	param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
+	param[0].u.memref.shm =3D reg_shm_in;
+	param[0].u.memref.size =3D p->key_len;
+	param[0].u.memref.shm_offs =3D 0;
+	param[1].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
+	param[1].u.memref.shm =3D reg_shm_out;
+	param[1].u.memref.size =3D sizeof(p->blob);
+	param[1].u.memref.shm_offs =3D 0;
+
+	ret =3D tee_client_invoke_func(pvt_data.ctx, &inv_arg, param);
+	if ((ret < 0) || (inv_arg.ret !=3D 0)) {
+		dev_err(pvt_data.dev, "TA_CMD_SEAL invoke err: %x\n",
+			inv_arg.ret);
+		ret =3D -EFAULT;
+	} else {
+		p->blob_len =3D param[1].u.memref.size;
+	}
+
+out:
+	if (reg_shm_out)
+		tee_shm_free(reg_shm_out);
+	if (reg_shm_in)
+		tee_shm_free(reg_shm_in);
+
+	return ret;
+}
+
+/*
+ * Have the TEE unseal(decrypt) the symmetric key
+ */
+static int tee_key_unseal(struct trusted_key_payload *p, char *datablob)
+{
+	int ret =3D 0;
+	struct tee_ioctl_invoke_arg inv_arg;
+	struct tee_param param[4];
+	struct tee_shm *reg_shm_in =3D NULL, *reg_shm_out =3D NULL;
+
+	memset(&inv_arg, 0, sizeof(inv_arg));
+	memset(&param, 0, sizeof(param));
+
+	reg_shm_in =3D tee_shm_register(pvt_data.ctx, (unsigned long)p->blob,
+				      p->blob_len, TEE_SHM_DMA_BUF |
+				      TEE_SHM_KERNEL_MAPPED);
+	if (IS_ERR(reg_shm_in)) {
+		dev_err(pvt_data.dev, "blob shm register failed\n");
+		return PTR_ERR(reg_shm_in);
+	}
+
+	reg_shm_out =3D tee_shm_register(pvt_data.ctx, (unsigned long)p->key,
+				       sizeof(p->key), TEE_SHM_DMA_BUF |
+				       TEE_SHM_KERNEL_MAPPED);
+	if (IS_ERR(reg_shm_out)) {
+		dev_err(pvt_data.dev, "key shm register failed\n");
+		ret =3D PTR_ERR(reg_shm_out);
+		goto out;
+	}
+
+	inv_arg.func =3D TA_CMD_UNSEAL;
+	inv_arg.session =3D pvt_data.session_id;
+	inv_arg.num_params =3D 4;
+
+	param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
+	param[0].u.memref.shm =3D reg_shm_in;
+	param[0].u.memref.size =3D p->blob_len;
+	param[0].u.memref.shm_offs =3D 0;
+	param[1].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
+	param[1].u.memref.shm =3D reg_shm_out;
+	param[1].u.memref.size =3D sizeof(p->key);
+	param[1].u.memref.shm_offs =3D 0;
+
+	ret =3D tee_client_invoke_func(pvt_data.ctx, &inv_arg, param);
+	if ((ret < 0) || (inv_arg.ret !=3D 0)) {
+		dev_err(pvt_data.dev, "TA_CMD_UNSEAL invoke err: %x\n",
+			inv_arg.ret);
+		ret =3D -EFAULT;
+	} else {
+		p->key_len =3D param[1].u.memref.size;
+	}
+
+out:
+	if (reg_shm_out)
+		tee_shm_free(reg_shm_out);
+	if (reg_shm_in)
+		tee_shm_free(reg_shm_in);
+
+	return ret;
+}
+
+/*
+ * Have the TEE generate random symmetric key
+ */
+static int tee_get_random(unsigned char *key, size_t key_len)
+{
+	int ret =3D 0;
+	struct tee_ioctl_invoke_arg inv_arg;
+	struct tee_param param[4];
+	struct tee_shm *reg_shm =3D NULL;
+
+	memset(&inv_arg, 0, sizeof(inv_arg));
+	memset(&param, 0, sizeof(param));
+
+	reg_shm =3D tee_shm_register(pvt_data.ctx, (unsigned long)key, key_len,
+				   TEE_SHM_DMA_BUF | TEE_SHM_KERNEL_MAPPED);
+	if (IS_ERR(reg_shm)) {
+		dev_err(pvt_data.dev, "random key shm register failed\n");
+		return PTR_ERR(reg_shm);
+	}
+
+	inv_arg.func =3D TA_CMD_GET_RANDOM;
+	inv_arg.session =3D pvt_data.session_id;
+	inv_arg.num_params =3D 4;
+
+	param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
+	param[0].u.memref.shm =3D reg_shm;
+	param[0].u.memref.size =3D key_len;
+	param[0].u.memref.shm_offs =3D 0;
+
+	ret =3D tee_client_invoke_func(pvt_data.ctx, &inv_arg, param);
+	if ((ret < 0) || (inv_arg.ret !=3D 0)) {
+		dev_err(pvt_data.dev, "TA_CMD_GET_RANDOM invoke err: %x\n",
+			inv_arg.ret);
+		ret =3D -EFAULT;
+	} else {
+		ret =3D param[0].u.memref.size;
+	}
+
+	tee_shm_free(reg_shm);
+
+	return ret;
+}
+
+static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *d=
ata)
+{
+	if (ver->impl_id =3D=3D TEE_IMPL_ID_OPTEE)
+		return 1;
+	else
+		return 0;
+}
+
+static int trusted_key_probe(struct device *dev)
+{
+	struct tee_client_device *rng_device =3D to_tee_client_device(dev);
+	int ret =3D 0, err =3D -ENODEV;
+	struct tee_ioctl_open_session_arg sess_arg;
+
+	memset(&sess_arg, 0, sizeof(sess_arg));
+
+	/* Open context with TEE driver */
+	pvt_data.ctx =3D tee_client_open_context(NULL, optee_ctx_match, NULL,
+					       NULL);
+	if (IS_ERR(pvt_data.ctx))
+		return -ENODEV;
+
+	/* Open session with hwrng Trusted App */
+	memcpy(sess_arg.uuid, rng_device->id.uuid.b, TEE_IOCTL_UUID_LEN);
+	sess_arg.clnt_login =3D TEE_IOCTL_LOGIN_REE_KERNEL;
+	sess_arg.num_params =3D 0;
+
+	ret =3D tee_client_open_session(pvt_data.ctx, &sess_arg, NULL);
+	if ((ret < 0) || (sess_arg.ret !=3D 0)) {
+		dev_err(dev, "tee_client_open_session failed, err: %x\n",
+			sess_arg.ret);
+		err =3D -EINVAL;
+		goto out_ctx;
+	}
+	pvt_data.session_id =3D sess_arg.session;
+
+	ret =3D register_key_type(&key_type_trusted);
+	if (ret < 0)
+		goto out_sess;
+
+	pvt_data.dev =3D dev;
+
+	return 0;
+
+out_sess:
+	tee_client_close_session(pvt_data.ctx, pvt_data.session_id);
+out_ctx:
+	tee_client_close_context(pvt_data.ctx);
+
+	return err;
+}
+
+static int trusted_key_remove(struct device *dev)
+{
+	unregister_key_type(&key_type_trusted);
+	tee_client_close_session(pvt_data.ctx, pvt_data.session_id);
+	tee_client_close_context(pvt_data.ctx);
+
+	return 0;
+}
+
+static const struct tee_client_device_id trusted_key_id_table[] =3D {
+	{UUID_INIT(0xf04a0fe7, 0x1f5d, 0x4b9b,
+		   0xab, 0xf7, 0x61, 0x9b, 0x85, 0xb4, 0xce, 0x8c)},
+	{}
+};
+
+MODULE_DEVICE_TABLE(tee, trusted_key_id_table);
+
+static struct tee_client_driver trusted_key_driver =3D {
+	.id_table	=3D trusted_key_id_table,
+	.driver		=3D {
+		.name		=3D DRIVER_NAME,
+		.bus		=3D &tee_bus_type,
+		.probe		=3D trusted_key_probe,
+		.remove		=3D trusted_key_remove,
+	},
+};
+
+static int __init init_tee_trusted(void)
+{
+	return driver_register(&trusted_key_driver.driver);
+}
+
+static void __exit cleanup_tee_trusted(void)
+{
+	driver_unregister(&trusted_key_driver.driver);
+}
+
+struct trusted_key_ops tee_trusted_key_ops =3D {
+	.migratable =3D 0, /* non-migratable */
+	.init =3D init_tee_trusted,
+	.seal =3D tee_key_seal,
+	.unseal =3D tee_key_unseal,
+	.get_random =3D tee_get_random,
+	.cleanup =3D cleanup_tee_trusted,
+};
+EXPORT_SYMBOL_GPL(tee_trusted_key_ops);
--=20
2.7.4


--===============0925906766563585119==--

