From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v6 4/4] efivarfs: automatically update super block flag
Date: Thu, 22 Jun 2023 21:56:46 +0300
Message-ID: <ZJSZbmUz583pszny@hera>
In-Reply-To: <5fe03be6-8c95-0bfa-687d-68e7ddffd97c@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7750671361229826166=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7750671361229826166==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Kojima-san, Jan

On Thu, Jun 22, 2023 at 04:58:50PM +0200, Jan Kiszka wrote:
> On 22.06.23 10:51, Masahisa Kojima wrote:
> > efivar operation is updated when the tee_stmm_efi module is probed.
> > tee_stmm_efi module supports SetVariable runtime service,
> > but user needs to manually remount the efivarfs as RW to enable
> > the write access if the previous efivar operation does not support
> > SerVariable and efivarfs is mounted as read-only.
> >
> > This commit notifies the update of efivar operation to
> > efivarfs subsystem, then drops SB_RDONLY flag if the efivar
> > operation supports SetVariable.
>
> But it does not re-add it and prevents further requests to the TA (that
> will only cause panics there) when the daemon terminates, does it?

It doesn't, but I think I got a better way out.  Even what you suggest won't
solve the problem entirely.  For the sake of context
- The kernel decides between the RO/RW depending on the SetVariable ptr
- The stmm *module* registers and swaps the RT calls -- and the ptr is now
valid.  Note here that the module probe function will run only if the
supplicant is running
- Once the module is inserted the filesystem will be remounted even without
the supplicant running, which would not trigger an oops, but an hard to
decipher error message from OP-TEE.

So even if we switch the permissions back to RO when the supplicant dies,
someone can still remount it as RW and trigger the same error.

Which got me thinking and staring the TEE subsystem a bit more.  The
supplicant is backed by a /dev file, which naturally has .open() and
.release() callbacks.  Why don't we leave the module perform the initial
setup -- e.g talk to StMM and make sure it's there, setup the necessary
buffers etc and defer the actual swapping of the efivar ops and the
filesystem permissions there?  I might 'feel' a bit weird, but as I
mentioned the module probe function only runs if the supplicant is running
anyway

Cheers
/Ilias

>
> Jan
>
> --
> Siemens AG, Technology
> Competence Center Embedded Linux
>

--===============7750671361229826166==--

