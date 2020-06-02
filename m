From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [op-tee] [PATCH v4 1/4] KEYS: trusted: Add generic trusted keys framework
Date: Tue, 02 Jun 2020 14:10:37 +0530
Message-ID: 
 <CAFA6WYOVho3sAO=ABaeO3CGw-DfWuGOE9H_D48pCwAq0+VX9Qw@mail.gmail.com>
In-Reply-To: <20200602071407.GB16602@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7326916818448581835=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7326916818448581835==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, 2 Jun 2020 at 12:44, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Mon, Jun 01, 2020 at 02:41:55PM +0530, Sumit Garg wrote:
> > > This, I think is wrong. You should have a compile time flag for TPM e.g.
> > > CONFIG_TRUSTED_TPM, not this dynamic mess.
> > >
> >
> > The whole idea to have it dynamic was to have a common trusted keys
> > module which could support both TPM and TEE implementation depending
> > on hardware. I guess it may be useful in scenarios where a particular
> > hardware supports a TPM chip while other doesn't but both need to run
> > a common kernel image.
>
> For now it should only scale to what is needed. No problems refining
> it later when there is something to enable.
>

Fair enough, will switch to compile time mode then.

-Sumit

> /Jarkko

--===============7326916818448581835==--

