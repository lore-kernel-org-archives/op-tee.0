From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v6 1/4] KEYS: trusted: Add generic trusted keys framework
Date: Thu, 17 Sep 2020 19:21:42 +0300
Message-ID: <20200917162142.GB9750@linux.intel.com>
In-Reply-To: <1600350398-4813-2-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3464132786128454154=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3464132786128454154==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, Sep 17, 2020 at 07:16:35PM +0530, Sumit Garg wrote:
> Current trusted keys framework is tightly coupled to use TPM device as
> an underlying implementation which makes it difficult for implementations
> like Trusted Execution Environment (TEE) etc. to provide trusted keys
> support in case platform doesn't posses a TPM device.
> 
> So this patch tries to add generic trusted keys framework where underlying
> implementations like TPM, TEE etc. could be easily plugged-in.

I would rephrase this a bit:

"Add a generic trusted keys framework where underlying implementations
can be easily plugged in. Create struct trusted_key_ops to achieve this,
which contains necessary functions of a backend."

I remember asking about this approach that what if there was just a
header for trusted key functions and a compile time decision, which C
file to include instead of ops struct. I don't remember if these was a
conclusion on this or not.

E.g. lets say you have a device with TEE and TPM, should you be able
to be use both at run-time? I might play along how this works now but
somehow, in the commit message preferably, it should be conclude why
one alternative is chosen over another.

/Jarkko

--===============3464132786128454154==--

