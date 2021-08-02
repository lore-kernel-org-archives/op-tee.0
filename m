From: Arnd Bergmann <arnd@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [GIT PULL] TEE kexec fixes for v5.14
Date: Mon, 02 Aug 2021 15:32:41 +0200
Message-ID: <162791113532.1139989.17019256982120013702.b4-ty@arndb.de>
In-Reply-To: <20210726081039.GA2482361@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6378452471989664469=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6378452471989664469==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Arnd Bergmann <arnd@arndb.de>

On Mon, 26 Jul 2021 10:10:39 +0200, Jens Wiklander wrote:
> Please pull these fixes relating to OP-TEE, ftpm (firmware TPM), and
> tee_bnxt_fw (Broadcom BNXT firmware manager) drivers in kexec and kdump
> (emergency kexec) based workflows.
> 
> The two patches "firmware: tee_bnxt: Release TEE shm, session, and context
> during kexec" and "tpm_ftpm_tee: Free and unregister TEE shared memory
> during kexec" are acked by their respective maintainers.
> 
> [...]

Merged into arm/fixes, thanks!

merge commit: 64429b9e0e1dc05cbe4f88076909fe0c4d2d29dc

       Arnd

--===============6378452471989664469==--

