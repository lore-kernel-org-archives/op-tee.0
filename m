From: thomas.gymer@bt.com
To: op-tee@lists.trustedfirmware.org
Subject: Verified Boot through U-Boot for RPi3 with OP-TEE
Date: Fri, 09 Aug 2024 15:21:40 +0000
Message-ID: <CWLP123MB63935507882C09545073EA17E5BA2@CWLP123MB6393.GBRP123.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2220726285972313102=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2220726285972313102==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello all,

We (Eden and I) have been assigned a summer project exploring the possibility=
 of verified boot for Linux with a view to experiment with a TEE, and would l=
ike to share our outcomes from the project so far.

We've been working on condensing all the information and documentation on TF-=
A, OP-TEE, and U-Boot verified boot into a trivially workable form, a Makefil=
e, for the Raspberry Pi 3B+. Our aim is a proof of concept pilot project to s=
ee what parts of the technology outlined in the NIST standards for secure boo=
t on IoT is currently available, and thus what needs to be developed. This al=
so leads us to an interest in full crypto algorithm agility to ensure quick a=
doption of the quantum safe algorithms as they come out.
I should note that our boot order here is TF-A to OP-TEE, then TF-A to U-Boot=
 to Linux.
This has raised a few areas of note and a couple of issues on our end:

# Areas of note
- U-Boot and Linux DTB's being incompatible has minimal documentation
Newer versions of U-Boot do have `CONFIG_OF_UPSTREAM`, but I can't see that a=
s a recommended solution. Perhaps a note in the Kconfig entry for `CONFIG_OF_=
CONTROL` would be sufficient
- U-Boot can fail silently if the DTB used is incompatible
No idea what the solution here could be; an invalid DTB inevitably means that=
 the firmware cannot access any of the hardware correctly.
- U-Boot unable to find `CONFIG_OF_SEPARATE` DTB's when loaded by TF-A; this =
is a TF-A problem, but maybe check other possible places for a DTB on the U-B=
oot end?
- U-Boot itself appears to have good crypto agility (or will in the near futu=
re), with a macro and existing algorithms as examples for the addition of new=
 algorithms
- `mkimage` appears to be lacking these same features for crypto agility, whi=
ch would otherwise set U-Boot up to be ready for the new quantum safe algorit=
hms' release
A similar macro system for `mkimage`, or some other schema for defining how t=
o add algorithm keys to the FDT, would provide some amazing flexibility, alre=
ady being able to define more than one signature as required. Adding keys to =
the FDT would need to be standardised in someway for this, I would imagine.

I am very aware that some of the below issues are not relevant to all project=
s, but thought it best to maintain a single list to ensure that the correct p=
lace to make a fix for each issue is not locked project wise too early.
# Issues
- buildroot build fails when the directory length is greater than ~80 charact=
ers
- TF-A does not pass on the DTB address unless `RPI3_DIRECT_LINUX_BOOT` is se=
t, which also implies a define U-Boot doesn't need
- TF-A `LOG_LEVEL=3D50` flag has compatibility issue in xlat tables v2 when c=
ompiled for 64bit
- `mkimage` ECDSA key adding to FDT fails if there is no signature node pre-a=
dded and doesn't set `required` node when `-r` is used
- `fit_check_sig`fails to check an ECDSA signed FIT file with corresponding F=
DT due to `<null>` hash node
- `mkimage` expects ECDSA private key only in a `.pem` and not `.der`, which =
would be standard for a single private key

We intend to release the Makefile and accompanying scripts for this on Monday=
 12th August, likely ~5pm BST to give us time to finalise what we have curren=
tly; this will consist of two Makefiles: one for verified boot using `CONFIG_=
OF_EMBED`, and another using `CONFIG_OF_SEPARATE` on U-Boot v2024.07. We are =
currently planning on releasing this on GitHub under the same license as the =
involved projects, but what would be the most helpful way for us to release t=
his to you?
We have, beside the points raised in the Issues section above, no specific ch=
anges for the exiting repos, focusing instead on Makefiles which pull togethe=
r parts of the existing releases to produce a working PoC as quickly as possi=
ble. We intend to also release this to the Raspberry Pi community as a TEE so=
lution they can experiment with today.

This email has been sent to:
- u-boot(a)lists.denx.de
- op-tee(a)lists.trustedfirmware.org
and the Makefiles will be sent to Raspberry Pi Foundation and community some =
point next week

Thomas Gymer (thomas.gymer(a)bt.com) & Eden Hamilton (eden.hamilton(a)bt.com)



--===============2220726285972313102==--

