From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v3 0/2] tee: optee: Fixes for supplicant dependent enumeration
Date: Mon, 30 Oct 2023 21:28:59 +0530
Message-ID: <20231030155901.80673-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5565318375074198035=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5565318375074198035==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Currently supplicant dependent optee device enumeration only registers
devices whenever tee-supplicant is invoked for the first time. But it
forgets to remove devices when tee-supplicant daemon stops running and
closes its context gracefully. This leads to following error for fTPM
driver during reboot/shutdown:

[   73.466791] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke error: 0=
xffff3024

Fix this by separating supplicant dependent devices so that the
user-space service can detach supplicant devices before closing the
supplicant. While at it use the global system workqueue for OP-TEE bus
scanning work rather than our own custom one.

Changes in v3:

- Split patch into 2 separate ones, one for supplicant fix and other for
  the workqueue.=20

Changes in v2:

- Use device names to separate out tee-supplicant dependent devices via
  this patch.
- Since user-space service is aware about tee-supplicant lifespan, so
  allow the user-space service to unbind tee-supplicant dependent
  devices before killing the supplicant. Following command has to be
  added to the tee-supplicant service file.

  $ for dev in /sys/bus/tee/devices/*; do if [[ "$dev" =3D=3D *"optee-ta-supp=
-"* ]]; \
        then echo $(basename "$dev") > $dev/driver/unbind; fi done

Sumit Garg (2):
  tee: optee: Fix supplicant based device enumeration
  tee: optee: Remove redundant custom workqueue

 drivers/tee/optee/core.c          | 13 ++-----------
 drivers/tee/optee/device.c        | 13 ++++++++++---
 drivers/tee/optee/optee_private.h |  2 --
 3 files changed, 12 insertions(+), 16 deletions(-)

--=20
2.34.1


--===============5565318375074198035==--

