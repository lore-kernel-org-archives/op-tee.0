From: Jérôme Forissier <jerome@forissier.org>
To: op-tee@lists.trustedfirmware.org
Subject: [op-tee] Maximum line length in the Linux kernel
Date: Mon, 01 Jun 2020 12:17:57 +0200
Message-ID: 
 <CAA-cTWZ54ua24krw0jm9E5u+wwDkiW_pjpYYmkO5rhAE5DfZKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6706104273815551063=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6706104273815551063==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

FYI, the "80 column" rule has just evolved a bit:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=
=3Dbdc48fa11e46f867ea4d75fa59ee87a7f48be144

So it is now s "<=3D 80 columns preferred, but up to 100 is OK". Since we are
mostly following the Linux coding style, I think this should apply to
OP-TEE as well.

Personally, I think it's a good thing as it will help avoid some silly line
breaks in long debug messages for instance.

--=20
Jerome

--===============6706104273815551063==--

