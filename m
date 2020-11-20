From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH 061/141] tee: Fix fall-through warnings for Clang
Date: Fri, 20 Nov 2020 12:33:19 -0600
Message-ID: <c505109fe0c02f648e16caa83d8a9773afd696b1.1605896059.git.gustavoars@kernel.org>
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8442898741132783610=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8442898741132783610==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a break statement instead of letting the code fall
through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/tee/tee_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 6ade4a5c4840..5fdf26688230 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -452,6 +452,7 @@ static int params_to_user(struct tee_ioctl_param __user *=
uparams,
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
 			if (put_user((u64)p->u.memref.size, &up->b))
 				return -EFAULT;
+			break;
 		default:
 			break;
 		}
--=20
2.27.0


--===============8442898741132783610==--

