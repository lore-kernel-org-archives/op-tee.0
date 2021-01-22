From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] OP-TEE driver fix for v5.11
Date: Fri, 22 Jan 2021 08:42:34 +0100
Message-ID: <20210122074234.GA1074747@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4185536742518152576=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4185536742518152576==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this small patch taking care of a rcu_sched trace in some
corner cases when OP-TEE is invoked.

Thanks,
Jens

The following changes since commit e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62:

  Linux 5.11-rc2 (2021-01-03 15:55:30 -0800)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-rcu-sch=
ed-trace-for-v5.11

for you to fetch changes up to dcb3b06d9c34f33a249f65c08805461fb0c4325b:

  tee: optee: replace might_sleep with cond_resched (2021-01-21 10:36:48 +010=
0)

----------------------------------------------------------------
Fix rcu_sched trace from OP-TEE invoke

Replaces might_sleep() with a conditional call to cond_resched()
in order to avoid the rcu_sched trace in some corner cases.

----------------------------------------------------------------
Rouven Czerwinski (1):
      tee: optee: replace might_sleep with cond_resched

 drivers/tee/optee/call.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--===============4185536742518152576==--

