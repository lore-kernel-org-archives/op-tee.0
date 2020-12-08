From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: (subset) [PATCH 000/141] Fix fall-through warnings for Clang
Date: Mon, 07 Dec 2020 23:52:01 -0500
Message-ID: <160740299787.710.4201881220590518200.b4-ty@oracle.com>
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9135007380487337992=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============9135007380487337992==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, 20 Nov 2020 12:21:39 -0600, Gustavo A. R. Silva wrote:

> This series aims to fix almost all remaining fall-through warnings in
> order to enable -Wimplicit-fallthrough for Clang.
> 
> In preparation to enable -Wimplicit-fallthrough for Clang, explicitly
> add multiple break/goto/return/fallthrough statements instead of just
> letting the code fall through to the next case.
> 
> [...]

Applied to 5.11/scsi-queue, thanks!

[054/141] target: Fix fall-through warnings for Clang
          https://git.kernel.org/mkp/scsi/c/492096ecfa39

-- 
Martin K. Petersen	Oracle Linux Engineering

--===============9135007380487337992==--

