From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] OP-TEE tracepoints for v5.13
Date: Mon, 15 Mar 2021 12:37:33 +0100
Message-ID: <20210315113733.GA1944243@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3811119821034553442=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3811119821034553442==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this patch adding tracepoints around calls to OP-TEE in
secure world.

Thanks,
Jens

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-tracepo=
ints-for-v5.13

for you to fetch changes up to 0101947dbcc3204f08fb5b69a21dbd4b1535cad6:

  tee: optee: add invoke_fn tracepoints (2021-03-15 12:04:01 +0100)

----------------------------------------------------------------
Add tracepoints around calls to secure world

----------------------------------------------------------------
Jisheng Zhang (1):
      tee: optee: add invoke_fn tracepoints

 drivers/tee/optee/call.c        |  4 +++
 drivers/tee/optee/optee_trace.h | 67 +++++++++++++++++++++++++++++++++++++++=
++
 2 files changed, 71 insertions(+)
 create mode 100644 drivers/tee/optee/optee_trace.h

--===============3811119821034553442==--

