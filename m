From: gaoyusong <a869920004@163.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH] Properly check tee_shm buffer mmap offset
Date: Mon, 23 Nov 2020 15:10:36 +0800
Message-ID: <1606115436-15332-1-git-send-email-a869920004@163.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7790153605414482981=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7790153605414482981==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The memmap options in tee_shm_op_mmap were not being checked for all
sets of possible crazy values. Fix this up by properly check tee_shm
buffer offsets.

Signed-off-by: gaoyusong <a869920004@163.com>
---
 drivers/tee/tee_shm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 827ac3d..3f762c8 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -75,6 +75,16 @@ static int tee_shm_op_mmap(struct dma_buf *dmabuf, struct =
vm_area_struct *vma)
 {
 	struct tee_shm *shm =3D dmabuf->priv;
 	size_t size =3D vma->vm_end - vma->vm_start;
+	unsigned long offset;
+
+	/* Check dmabuffer mmap offset */
+	if (vma->vm_pgoff > (~0UL >> PAGE_SHIFT))
+		return -EINVAL;
+
+	offset =3D vma->vm_pgoff << PAGE_SHIFT;
+
+	if (offset > shm->size || size > shm->size - offset)
+		return -EINVAL;
=20
 	/* Refuse sharing shared memory provided by application */
 	if (shm->flags & TEE_SHM_USER_MAPPED)
--=20
1.8.3.1


--===============7790153605414482981==--

