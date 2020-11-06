From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v8 0/4] Introduce TEE based Trusted Keys support
Date: Fri, 06 Nov 2020 15:02:41 +0530
Message-ID: 
 <CAFA6WYPetvod-Wov2n_L5TL771j+-kt+_csyWYT-uM=haEKMZQ@mail.gmail.com>
In-Reply-To: <20201105050736.GA702944@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8824760297176125072=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8824760297176125072==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Nov 2020 at 10:37, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Tue, Nov 03, 2020 at 09:31:42PM +0530, Sumit Garg wrote:
> > Add support for TEE based trusted keys where TEE provides the functionali=
ty
> > to seal and unseal trusted keys using hardware unique key. Also, this is
> > an alternative in case platform doesn't possess a TPM device.
> >
> > This patch-set has been tested with OP-TEE based early TA which is already
> > merged in upstream [1].
>
> Is the new RPI400 computer a platform that can be used for testing
> patch sets like this? I've been looking for a while something ARM64
> based with similar convenience as Intel NUC's, and on the surface
> this new RPI product looks great for kernel testing purposes.

Here [1] is the list of supported versions of Raspberry Pi in OP-TEE.
The easiest approach would be to pick up a supported version or else
do an OP-TEE port for an unsupported one (which should involve minimal
effort).

[1] https://optee.readthedocs.io/en/latest/building/devices/rpi3.html#what-ve=
rsions-of-raspberry-pi-will-work

-Sumit

>
> /Jarkko
>
> >
> > [1] https://github.com/OP-TEE/optee_os/commit/f86ab8e7e0de869dfa25ca05a37=
ee070d7e5b86b
> >
> > Changes in v8:
> > 1. Added static calls support instead of indirect calls.
> > 2. Documented trusted keys source module parameter.
> > 3. Refined patch #1 commit message discription.
> > 4. Addressed misc. comments on patch #2.
> > 5. Added myself as Trusted Keys co-maintainer instead.
> > 6. Rebased to latest tpmdd master.
> >
> > Changes in v7:
> > 1. Added a trusted.source module parameter in order to enforce user's
> >    choice in case a particular platform posses both TPM and TEE.
> > 2. Refine commit description for patch #1.
> >
> > Changes in v6:
> > 1. Revert back to dynamic detection of trust source.
> > 2. Drop author mention from trusted_core.c and trusted_tpm1.c files.
> > 3. Rebased to latest tpmdd/master.
> >
> > Changes in v5:
> > 1. Drop dynamic detection of trust source and use compile time flags
> >    instead.
> > 2. Rename trusted_common.c -> trusted_core.c.
> > 3. Rename callback: cleanup() -> exit().
> > 4. Drop "tk" acronym.
> > 5. Other misc. comments.
> > 6. Added review tags for patch #3 and #4.
> >
> > Changes in v4:
> > 1. Pushed independent TEE features separately:
> >   - Part of recent TEE PR: https://lkml.org/lkml/2020/5/4/1062
> > 2. Updated trusted-encrypted doc with TEE as a new trust source.
> > 3. Rebased onto latest tpmdd/master.
> >
> > Changes in v3:
> > 1. Update patch #2 to support registration of multiple kernel pages.
> > 2. Incoporate dependency patch #4 in this patch-set:
> >    https://patchwork.kernel.org/patch/11091435/
> >
> > Changes in v2:
> > 1. Add reviewed-by tags for patch #1 and #2.
> > 2. Incorporate comments from Jens for patch #3.
> > 3. Switch to use generic trusted keys framework.
> >
> > Sumit Garg (4):
> >   KEYS: trusted: Add generic trusted keys framework
> >   KEYS: trusted: Introduce TEE based Trusted Keys
> >   doc: trusted-encrypted: updates with TEE as a new trust source
> >   MAINTAINERS: Add myself as Trusted Keys co-maintainer
> >
> >  Documentation/admin-guide/kernel-parameters.txt   |  12 +
> >  Documentation/security/keys/trusted-encrypted.rst | 203 +++++++++++--
> >  MAINTAINERS                                       |   2 +
> >  include/keys/trusted-type.h                       |  47 +++
> >  include/keys/trusted_tee.h                        |  55 ++++
> >  include/keys/trusted_tpm.h                        |  17 +-
> >  security/keys/trusted-keys/Makefile               |   2 +
> >  security/keys/trusted-keys/trusted_core.c         | 354 ++++++++++++++++=
++++++
> >  security/keys/trusted-keys/trusted_tee.c          | 278 +++++++++++++++++
> >  security/keys/trusted-keys/trusted_tpm1.c         | 336 ++++------------=
----
> >  10 files changed, 979 insertions(+), 327 deletions(-)
> >  create mode 100644 include/keys/trusted_tee.h
> >  create mode 100644 security/keys/trusted-keys/trusted_core.c
> >  create mode 100644 security/keys/trusted-keys/trusted_tee.c
> >
> > --
> > 2.7.4
> >
> >

--===============8824760297176125072==--

