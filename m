From: James Bottomley <jejb@linux.ibm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v9 1/4] KEYS: trusted: Add generic trusted keys framework
Date: Wed, 21 Apr 2021 10:20:59 -0700
Message-ID: <e7a91c8c09722afe1fb1ec3aa7b6544e713183af.camel@linux.ibm.com>
In-Reply-To: <
 <CAFA6WYOzD-qhHrcnzvd9P7iFvEqWwf0NCKXrgrEgvnB5i_-SxQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7127093314079041575=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7127093314079041575==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, 2021-04-21 at 16:38 +0530, Sumit Garg wrote:
> Hi James,
> 
> On Wed, 21 Apr 2021 at 04:47, James Bottomley <jejb@linux.ibm.com>
> wrote:
> > On Mon, 2021-03-01 at 18:41 +0530, Sumit Garg wrote:
> > > Current trusted keys framework is tightly coupled to use TPM
> > > device as an underlying implementation which makes it difficult
> > > for implementations like Trusted Execution Environment (TEE) etc.
> > > to provide trusted keys support in case platform doesn't posses a
> > > TPM device.
> > > 
> > > Add a generic trusted keys framework where underlying
> > > implementations can be easily plugged in. Create struct
> > > trusted_key_ops to achieve this, which contains necessary
> > > functions of a backend.
> > > 
> > > Also, define a module parameter in order to select a particular
> > > trust source in case a platform support multiple trust sources.
> > > In case its not specified then implementation itetrates through
> > > trust sources list starting with TPM and assign the first trust
> > > source as a backend which has initiazed successfully during
> > > iteration.
> > > 
> > > Note that current implementation only supports a single trust
> > > source at runtime which is either selectable at compile time or
> > > during boot via aforementioned module parameter.
> > 
> > You never actually tested this, did you?  I'm now getting EINVAL
> > from all the trusted TPM key operations because of this patch.
> > 
> 
> Unfortunately, I don't possess a development machine with a TPM
> device. So mine testing was entirely based on TEE as a backend which
> doesn't support any optional parameters. And that being the reason I
> didn't catch this issue at first instance.
> 
> Is there any TPM emulation environment available that I can use for
> testing?

Well use the same as we all use: A software TPM running in the host
coupled with a virtual machine guest for the kernel:

https://en.opensuse.org/Software_TPM_Emulator_For_QEMU

It doesn't catch interface issues (like TIS timeouts) but it does catch
TPM operations problems like this patch had.

James



--===============7127093314079041575==--

