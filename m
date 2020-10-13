From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v7 1/4] KEYS: trusted: Add generic trusted keys framework
Date: Tue, 13 Oct 2020 04:43:04 +0300
Message-ID: <20201013014304.GC41176@linux.intel.com>
In-Reply-To: <1602065268-26017-2-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3679958036316261782=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3679958036316261782==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, Oct 07, 2020 at 03:37:45PM +0530, Sumit Garg wrote:
> Current trusted keys framework is tightly coupled to use TPM device as
> an underlying implementation which makes it difficult for implementations
> like Trusted Execution Environment (TEE) etc. to provide trusted keys
> support in case platform doesn't posses a TPM device.
> 
> Add a generic trusted keys framework where underlying implementations
> can be easily plugged in. Create struct trusted_key_ops to achieve this,
> which contains necessary functions of a backend.
> 
> Also, add a module parameter in order to select a particular trust source
> in case a platform support multiple trust sources.
> 
> Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

This is exactly kind of place where I think static_call() should be
taken into use, which is a v5.10 feature [1]. For background and
context, I'd read [2].

The other thing that I see that does not make much else than additional
complexity, is trusted_tpm.ko. We can do with one trusted.ko.

I'd also *guess* that the static_call() mechanism does not work accross
module boundaries.

[1] https://lore.kernel.org/lkml/20201012155542.GA3557765(a)gmail.com/
[2] https://lwn.net/Articles/815908/

/Jarkko

--===============3679958036316261782==--

