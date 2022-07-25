From: Jérôme Forissier <jerome@forissier.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: OP-TEE BTI support
Date: Mon, 25 Jul 2022 15:45:53 +0200
Message-ID: 
 <CAA-cTWYLzcwbDDpC5+XbFQn0uUzzMx437GzcWF0g=LZaH_CxZw@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3CVE1PR08MB4976593CAB0239C2FE9E075C9B899=40VE1PR08MB?=
 =?utf-8?q?4976=2Eeurprd08=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6516695660365598976=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6516695660365598976==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hello Olivier,

On Wed, Jul 13, 2022 at 3:20 PM Olivier Deprez <Olivier.Deprez@arm.com>
wrote:

> Hi,
>
> (in context of testing BTI support when OP-TEE is loaded as a secure
> partition on top of SEL2/Hafnium)
>
> I read through the OP-TEE documentation, and would like to confirm:
> CFG_CORE_BTI=y seems mandatorily required to support BTI in TAs. It means
> we cannot enable independently BTI for TAs and 'disable' for TEE core, is
> this correct?
>
> Interestingly I noticed I can build with CFG_CORE_BTI=n and CTG_TA_BTI=y
> but I appreciate the end result is that the TA get BTI landpads but is not
> effectively leveraging the arch extension because code page aren't guarde
> if TEE core option isn't enabled.
>

That is correct. I don't remember if there was a strong reason for this
choice. Maybe we could introduce a new CFG to allow OP-TEE OS to enforce
BTI in TAs (SEL0) while not using BTI in itself (SEL1), but it might be
more complicated than it sounds (depending on how page tables are
configured to access SEL0 from SEL1).


> I was investigating a way to omit building a specific toolchain as it
> appears to be required when CFG_CORE_BTI=y, but I'll go ahead if there's no
> way round.
>

Currently, there is no other way indeed. I suppose you know how to build a
toolchain but just in case I posted a small script here:
https://github.com/OP-TEE/optee_os/pull/4967#issuecomment-996987581


> Out of curiosity is OP-TEE core pulling gcc libraries? And if yes, which
> kind? I naively thought OP-TEE core would be freestanding or be independent
> from toolchain libs.
>

It does pull libgcc.a for some builtins and floating point ABIs IIRC.

-- 
 Jerome

--===============6516695660365598976==--

