From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v8 10/14] dma-contiguous: export dma_contiguous_default_area
Date: Fri, 02 May 2025 11:59:24 +0200
Message-ID: <20250502100049.1746335-11-jens.wiklander@linaro.org>
In-Reply-To: <20250502100049.1746335-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6678599862749050328=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6678599862749050328==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Export the global variable dma_contiguous_default_area so
dev_get_cma_area() can be called a module.

Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: iommu(a)lists.linux.dev
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 kernel/dma/contiguous.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 8df0dfaaca18..eb361794a9c5 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -53,6 +53,7 @@
 #endif
 
 struct cma *dma_contiguous_default_area;
+EXPORT_SYMBOL(dma_contiguous_default_area);
 
 /*
  * Default global CMA area size can be defined in kernel's .config.
-- 
2.43.0


--===============6678599862749050328==--

