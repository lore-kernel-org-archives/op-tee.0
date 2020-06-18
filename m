From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v5 1/4] KEYS: trusted: Add generic trusted keys framework
Date: Thu, 18 Jun 2020 12:12:41 +0530
Message-ID: 
 <CAFA6WYOdtwnewqY0ASnMf7fyw3s_hQx0+oWJRhT3CpkkkxYpDA@mail.gmail.com>
In-Reply-To: <20200617231429.GD62794@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6725390902285562152=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6725390902285562152==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, 18 Jun 2020 at 04:44, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Tue, Jun 16, 2020 at 07:02:37PM +0530, Sumit Garg wrote:
> > + Luke
> >
> > Hi Jarkko,
> >
> > Prior to addressing your comments below which seems to show your
> > preference for compile time selection of trust source (TPM or TEE), I
> > would just like to hear the reasons for this preference especially if
> > it makes distro vendor's life difficult [1] to make opinionated
> > selection which could rather be achieved dynamically based on platform
> > capability.
> >
> > [1] https://lkml.org/lkml/2020/6/3/405
> >
> > -Sumit
>
> Hmm... I do get the distribution kernel point. OK, lets revert to
> dynamic then. Thanks for the remark.
>
> /Jarkko

Thanks, will revert to dynamic mode in v6.

-Sumit

--===============6725390902285562152==--

