From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [op-tee] [PATCH v4 1/4] KEYS: trusted: Add generic trusted keys framework
Date: Tue, 02 Jun 2020 10:14:07 +0300
Message-ID: <20200602071407.GB16602@linux.intel.com>
In-Reply-To: <
 <CAFA6WYP55W2xKtjHWWwu6Pbqy2TGY=eymwAoXxQh-5mF8deR6A@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8402310847785689420=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8402310847785689420==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Mon, Jun 01, 2020 at 02:41:55PM +0530, Sumit Garg wrote:
> > This, I think is wrong. You should have a compile time flag for TPM e.g.
> > CONFIG_TRUSTED_TPM, not this dynamic mess.
> >
> 
> The whole idea to have it dynamic was to have a common trusted keys
> module which could support both TPM and TEE implementation depending
> on hardware. I guess it may be useful in scenarios where a particular
> hardware supports a TPM chip while other doesn't but both need to run
> a common kernel image.

For now it should only scale to what is needed. No problems refining
it later when there is something to enable.

/Jarkko

--===============8402310847785689420==--

