From: Joakim Bech <joakim.bech@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Verified Boot through U-Boot for RPi3 with OP-TEE
Date: Mon, 12 Aug 2024 10:31:27 +0200
Message-ID: 
 <CA+Eyddbaq1cXtzrNXc1K2bsWwG3v3G6Zm=7Y0SRGuMDw5Zk0FQ@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3CCWLP123MB63935507882C09545073EA17E5BA2=40CWLP123MB?=
 =?utf-8?q?6393=2EGBRP123=2EPROD=2EOUTLOOK=2ECOM=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0608087890404666498=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0608087890404666498==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas and Eden,

On Mon, Aug 12, 2024 at 9:48=E2=80=AFAM thomas.gymer--- via OP-TEE <
op-tee@lists.trustedfirmware.org> wrote:

> Hello all,
>
> We (Eden and I) have been assigned a summer project exploring the
> possibility of verified boot for Linux with a view to experiment with a
> TEE, and would like to share our outcomes from the project so far.
>
> We've been working on condensing all the information and documentation on
> TF-A, OP-TEE, and U-Boot verified boot into a trivially workable form, a
> Makefile, for the Raspberry Pi 3B+. Our aim is a proof of concept pilot
> project to see what parts of the technology outlined in the NIST standards
> for secure boot on IoT is currently available, and thus what needs to be
> developed. This also leads us to an interest in full crypto algorithm
> agility to ensure quick adoption of the quantum safe algorithms as they
> come out.
> I should note that our boot order here is TF-A to OP-TEE, then TF-A to
> U-Boot to Linux.
> This has raised a few areas of note and a couple of issues on our end:
>
> # Areas of note
> - U-Boot and Linux DTB's being incompatible has minimal documentation
> Newer versions of U-Boot do have `CONFIG_OF_UPSTREAM`, but I can't see
> that as a recommended solution. Perhaps a note in the Kconfig entry for
> `CONFIG_OF_CONTROL` would be sufficient
> - U-Boot can fail silently if the DTB used is incompatible
> No idea what the solution here could be; an invalid DTB inevitably means
> that the firmware cannot access any of the hardware correctly.
> - U-Boot unable to find `CONFIG_OF_SEPARATE` DTB's when loaded by TF-A;
> this is a TF-A problem, but maybe check other possible places for a DTB on
> the U-Boot end?
> - U-Boot itself appears to have good crypto agility (or will in the near
> future), with a macro and existing algorithms as examples for the addition
> of new algorithms
> - `mkimage` appears to be lacking these same features for crypto agility,
> which would otherwise set U-Boot up to be ready for the new quantum safe
> algorithms' release
> A similar macro system for `mkimage`, or some other schema for defining
> how to add algorithm keys to the FDT, would provide some amazing
> flexibility, already being able to define more than one signature as
> required. Adding keys to the FDT would need to be standardised in someway
> for this, I would imagine.
>
As a general comment, the incompatibilities (DTB UBoot/Linux) you've seen
is well known to the community and it's been a long running effort to
improve the situation.


>
> I am very aware that some of the below issues are not relevant to all
> projects, but thought it best to maintain a single list to ensure that the
> correct place to make a fix for each issue is not locked project wise too
> early.
> # Issues
> - buildroot build fails when the directory length is greater than ~80
> characters
>
Interesting, I wasn't aware.


> - TF-A does not pass on the DTB address unless `RPI3_DIRECT_LINUX_BOOT` is
> set, which also implies a define U-Boot doesn't need
> - TF-A `LOG_LEVEL=3D50` flag has compatibility issue in xlat tables v2 when
> compiled for 64bit
>
I believe this one is about the image becoming too big? Or is it actually a
xlat tables issue?


> - `mkimage` ECDSA key adding to FDT fails if there is no signature node
> pre-added and doesn't set `required` node when `-r` is used
> - `fit_check_sig`fails to check an ECDSA signed FIT file with
> corresponding FDT due to `<null>` hash node
> - `mkimage` expects ECDSA private key only in a `.pem` and not `.der`,
> which would be standard for a single private key
>
> We intend to release the Makefile and accompanying scripts for this on
> Monday 12th August, likely ~5pm BST to give us time to finalise what we
> have currently; this will consist of two Makefiles: one for verified boot
> using `CONFIG_OF_EMBED`, and another using `CONFIG_OF_SEPARATE` on U-Boot
> v2024.07. We are currently planning on releasing this on GitHub under the
> same license as the involved projects, but what would be the most helpful
> way for us to release this to you?
>
As one of the maintainers of the OP-TEE project, I'm always in favor of
having changes done in the official repositories, both code and
documentation. There is nothing wrong with doing a write up and keep fixes
elsewhere as such, but it has happened a couple of times that when people
do these things on their own, other people find the instructions etc on
internet and when they don't get it to work, they post issues and questions
at the official OP-TEE issue list. However, since this is code not
maintained or in the official git, there is little we can do about it. So,
if you can send fixes upstream to the official projects, that's what I
would suggest, that's the best in the long run. If you keep it elsewhere,
may I please just ask you to put some note somewhere in the docs or readme,
saying that this is work done outside official code, so if people try it
and if it for some reason wouldn't work, then asking for help upstream
likely won't lead to anything.


> We have, beside the points raised in the Issues section above, no specific
> changes for the exiting repos, focusing instead on Makefiles which pull
> together parts of the existing releases to produce a working PoC as quickly
> as possible. We intend to also release this to the Raspberry Pi community
> as a TEE solution they can experiment with today.
>
I understand that you have a deadline for a summer project and therefore
have to prioritize and make decisions. It looks like you've done a great
deep dive and found various things that can (and should) be improved. For
OP-TEE, if you have time, please consider sending your findings to the
various "Issues" list at GitHub. If there is no obvious place to post the
issue, you can use the one in OP-TEE os (
https://github.com/OP-TEE/optee_os/issues). For U-Boot I believe it's the
mailinglist that is the best place to discuss individual issues.


>
> This email has been sent to:
> - u-boot(a)lists.denx.de
> - op-tee(a)lists.trustedfirmware.org
> and the Makefiles will be sent to Raspberry Pi Foundation and community
> some point next week
>
> Thomas Gymer (thomas.gymer(a)bt.com) & Eden Hamilton (eden.hamilton(a)bt.co=
m)
>
>
>
--=20
Regards,
Joakim

--===============0608087890404666498==--

