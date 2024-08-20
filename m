From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH v2 4/7] firmware: arm_ffa: Add support for FFA_PARTITION_INFO_GET_REGS
Date: Tue, 20 Aug 2024 15:27:57 +0100
Message-ID: <20240820-ffa_v1-2-v2-4-18c0c5f3c65e@arm.com>
In-Reply-To: <20240820-ffa_v1-2-v2-0-18c0c5f3c65e@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0549486233246614060=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0549486233246614060==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

FF-A v1.2 introduced FFA_PARTITION_INFO_GET_REGS which is similar to
FFA_PARTITION_INFO_GET except that the former uses the registers to
get the required information instead of the Rx buffer which the latter
uses.

We need to first check if the platform supports this new API using
FFA_FEATURES so that we can fallback to the FFA_PARTITION_INFO_GET
(which is mandatory) if FFA_PARTITION_INFO_GET_REGS is not implemented.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 72 ++++++++++++++++++++++++++++++++++++-=
--
 1 file changed, 68 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/dri=
ver.c
index 91681933ece9..e28cbfe9a801 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -287,17 +287,75 @@ __ffa_partition_info_get(u32 uuid0, u32 uuid1, u32 uuid=
2, u32 uuid3,
 	return count;
 }
=20
+#define LAST_INDEX_MASK		GENMASK(15, 0)
+#define CURRENT_INDEX_MASK	GENMASK(31, 16)
+#define UUID_INFO_TAG_MASK	GENMASK(47, 32)
+#define PARTITION_INFO_SZ_MASK	GENMASK(63, 48)
+#define PARTITION_COUNT(x)	((u16)(FIELD_GET(LAST_INDEX_MASK, (x))) + 1)
+#define CURRENT_INDEX(x)	((u16)(FIELD_GET(CURRENT_INDEX_MASK, (x))))
+#define UUID_INFO_TAG(x)	((u16)(FIELD_GET(UUID_INFO_TAG_MASK, (x))))
+#define PARTITION_INFO_SZ(x)	((u16)(FIELD_GET(PARTITION_INFO_SZ_MASK, (x))))
+static int
+__ffa_partition_info_get_regs(u32 uuid0, u32 uuid1, u32 uuid2, u32 uuid3,
+			      struct ffa_partition_info *buffer, int num_parts)
+{
+	u16 buf_sz, start_idx, cur_idx, count =3D 0, prev_idx =3D 0, tag =3D 0;
+	ffa_value_t partition_info;
+
+	do {
+		start_idx =3D prev_idx ? prev_idx + 1 : 0;
+
+		invoke_ffa_fn((ffa_value_t){
+			      .a0 =3D FFA_PARTITION_INFO_GET_REGS,
+			      .a1 =3D (u64)uuid1 << 32 | uuid0,
+			      .a2 =3D (u64)uuid3 << 32 | uuid2,
+			      .a3 =3D start_idx | tag << 16,
+			      }, &partition_info);
+
+		if (partition_info.a0 =3D=3D FFA_ERROR)
+			return ffa_to_linux_errno((int)partition_info.a2);
+
+		if (!count)
+			count =3D PARTITION_COUNT(partition_info.a2);
+		if (!buffer || !num_parts) /* count only */
+			return count;
+
+		cur_idx =3D CURRENT_INDEX(partition_info.a2);
+		tag =3D UUID_INFO_TAG(partition_info.a2);
+		buf_sz =3D PARTITION_INFO_SZ(partition_info.a2);
+		if (buf_sz > sizeof(*buffer))
+			buf_sz =3D sizeof(*buffer);
+
+		memcpy(buffer + prev_idx * buf_sz, &partition_info.a3,
+		       (cur_idx - start_idx + 1) * buf_sz);
+		prev_idx =3D cur_idx;
+
+	} while (cur_idx < (count - 1));
+
+	return count;
+}
+
 /* buffer is allocated and caller must free the same if returned count > 0 */
 static int
 ffa_partition_probe(const uuid_t *uuid, struct ffa_partition_info **buffer)
 {
 	int count;
 	u32 uuid0_4[4];
+	bool reg_mode =3D false;
 	struct ffa_partition_info *pbuf;
=20
+	if (!ffa_features(FFA_PARTITION_INFO_GET_REGS, 0, NULL, NULL))
+		reg_mode =3D true;
+
 	export_uuid((u8 *)uuid0_4, uuid);
-	count =3D __ffa_partition_info_get(uuid0_4[0], uuid0_4[1], uuid0_4[2],
-					 uuid0_4[3], NULL, 0);
+	if (reg_mode)
+		count =3D __ffa_partition_info_get_regs(uuid0_4[0], uuid0_4[1],
+						      uuid0_4[2], uuid0_4[3],
+						      NULL, 0);
+	else
+		count =3D __ffa_partition_info_get(uuid0_4[0], uuid0_4[1],
+						 uuid0_4[2], uuid0_4[3],
+						 NULL, 0);
 	if (count <=3D 0)
 		return count;
=20
@@ -305,8 +363,14 @@ ffa_partition_probe(const uuid_t *uuid, struct ffa_parti=
tion_info **buffer)
 	if (!pbuf)
 		return -ENOMEM;
=20
-	count =3D __ffa_partition_info_get(uuid0_4[0], uuid0_4[1], uuid0_4[2],
-					 uuid0_4[3], pbuf, count);
+	if (reg_mode)
+		count =3D __ffa_partition_info_get_regs(uuid0_4[0], uuid0_4[1],
+						      uuid0_4[2], uuid0_4[3],
+						      pbuf, count);
+	else
+		count =3D __ffa_partition_info_get(uuid0_4[0], uuid0_4[1],
+						 uuid0_4[2], uuid0_4[3],
+						 pbuf, count);
 	if (count <=3D 0)
 		kfree(pbuf);
 	else

--=20
2.46.0


--===============0549486233246614060==--

