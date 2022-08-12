From: Olivier Masse <olivier.masse@nxp.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v2 0/1] tee: Add tee_shm_register_fd
Date: Fri, 12 Aug 2022 16:30:54 +0200
Message-ID: <20220812143055.12938-1-olivier.masse@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4193790824234591718=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4193790824234591718==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Add a new ioctl called TEE_IOC_SHM_REGISTER_FD to register a
shared memory from a dmabuf file descriptor.
This new ioctl will allow the Linux Kernel to register a buffer
to be used by the Secure Data Path OPTEE OS feature.

Please find more information here:
https://static.linaro.org/connect/san19/presentations/san19-107.pdf

Patch tested on Hikey 6220.

Etienne Carriere (1):
  tee: new ioctl to a register tee_shm from a dmabuf file descriptor

 drivers/tee/tee_core.c   | 38 +++++++++++++++
 drivers/tee/tee_shm.c    | 99 +++++++++++++++++++++++++++++++++++++++-
 include/linux/tee_drv.h  | 11 +++++
 include/uapi/linux/tee.h | 29 ++++++++++++
 4 files changed, 175 insertions(+), 2 deletions(-)

-- 
2.25.0


--===============4193790824234591718==--

