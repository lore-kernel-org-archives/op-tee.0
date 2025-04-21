From: Mario Limonciello <superm1@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH 0/2] small amdtee cleanups
Date: Mon, 21 Apr 2025 10:22:21 -0500
Message-ID: <20250421152238.764659-1-superm1@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0651750167690592562=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0651750167690592562==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mario Limonciello <mario.limonciello@amd.com>

I just noticed a few small things for amdtee where the error messages
didn't consistently use the driver name.  While fixing that I noticed
the headers weren't sorted.

These patches fix both issues.

Mario Limonciello (2):
  tee: Use pr_fmt for messages
  tee: Sort header includes

 drivers/tee/amdtee/core.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

-- 
2.43.0


--===============0651750167690592562==--

