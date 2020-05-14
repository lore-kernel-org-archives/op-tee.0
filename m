From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [op-tee] [PATCH v4 1/4] KEYS: trusted: Add generic trusted keys framework
Date: Thu, 14 May 2020 03:25:14 +0300
Message-ID: <07bb6080f8be9f6613f460e2d6e19f3d456e219c.camel@linux.intel.com>
In-Reply-To: <1588758017-30426-2-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6821506881099145356=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6821506881099145356==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, 2020-05-06 at 15:10 +0530, Sumit Garg wrote:
> Current trusted keys framework is tightly coupled to use TPM device as
> an underlying implementation which makes it difficult for implementations
> like Trusted Execution Environment (TEE) etc. to provide trusked keys
> support in case platform doesn't posses a TPM device.
> 
> So this patch tries to add generic trusted keys framework where underlying
> implemtations like TPM, TEE etc. could be easily plugged-in.
> 
> Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

I tend to agree how this is implemented and could merge it as such.

I'm just thinking if we could refine this patch in a way that instead of
copying TRUSTED_DEBUG macro we could just replace pr_info() statements
with pr_debug()?

/Jarkko


--===============6821506881099145356==--

