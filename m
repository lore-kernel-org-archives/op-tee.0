From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v9 1/4] KEYS: trusted: Add generic trusted keys framework
Date: Thu, 22 Apr 2021 10:17:02 +0530
Message-ID: 
 <CAFA6WYOSVVhk91XxwbmqGkvpcUF5pkro4M7fay480Enocoj+=g@mail.gmail.com>
In-Reply-To: <e7a91c8c09722afe1fb1ec3aa7b6544e713183af.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1799522300456869229=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1799522300456869229==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, 21 Apr 2021 at 22:51, James Bottomley <jejb@linux.ibm.com> wrote:
>
> On Wed, 2021-04-21 at 16:38 +0530, Sumit Garg wrote:
> > Hi James,
> >
> > On Wed, 21 Apr 2021 at 04:47, James Bottomley <jejb@linux.ibm.com>
> > wrote:
> > > On Mon, 2021-03-01 at 18:41 +0530, Sumit Garg wrote:
> > > > Current trusted keys framework is tightly coupled to use TPM
> > > > device as an underlying implementation which makes it difficult
> > > > for implementations like Trusted Execution Environment (TEE) etc.
> > > > to provide trusted keys support in case platform doesn't posses a
> > > > TPM device.
> > > >
> > > > Add a generic trusted keys framework where underlying
> > > > implementations can be easily plugged in. Create struct
> > > > trusted_key_ops to achieve this, which contains necessary
> > > > functions of a backend.
> > > >
> > > > Also, define a module parameter in order to select a particular
> > > > trust source in case a platform support multiple trust sources.
> > > > In case its not specified then implementation itetrates through
> > > > trust sources list starting with TPM and assign the first trust
> > > > source as a backend which has initiazed successfully during
> > > > iteration.
> > > >
> > > > Note that current implementation only supports a single trust
> > > > source at runtime which is either selectable at compile time or
> > > > during boot via aforementioned module parameter.
> > >
> > > You never actually tested this, did you?  I'm now getting EINVAL
> > > from all the trusted TPM key operations because of this patch.
> > >
> >
> > Unfortunately, I don't possess a development machine with a TPM
> > device. So mine testing was entirely based on TEE as a backend which
> > doesn't support any optional parameters. And that being the reason I
> > didn't catch this issue at first instance.
> >
> > Is there any TPM emulation environment available that I can use for
> > testing?
>
> Well use the same as we all use: A software TPM running in the host
> coupled with a virtual machine guest for the kernel:
>
> https://en.opensuse.org/Software_TPM_Emulator_For_QEMU
>
> It doesn't catch interface issues (like TIS timeouts) but it does catch
> TPM operations problems like this patch had.
>

Thanks for the pointer. I will use it for future testing.

-Sumit

> James
>
>

--===============1799522300456869229==--

