From: Finn Thain <fthain@telegraphics.com.au>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 000/141] Fix fall-through warnings for Clang
Date: Tue, 24 Nov 2020 13:48:34 +1100
Message-ID: <alpine.LNX.2.23.453.2011241210310.7@nippy.intranet>
In-Reply-To: <e72a1aaef8673553a3ee9dfa033d6e893e00abcd.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0997075553461916331=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0997075553461916331==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


On Mon, 23 Nov 2020, Joe Perches wrote:

> On Tue, 2020-11-24 at 11:58 +1100, Finn Thain wrote:
> > it's not for me to prove that such patches don't affect code=20
> > generation. That's for the patch author and (unfortunately) for=20
> > reviewers.
>=20
> Ideally, that proof would be provided by the compilation system itself=20
> and not patch authors nor reviewers nor maintainers.
>=20
> Unfortunately gcc does not guarantee repeatability or deterministic=20
> output. To my knowledge, neither does clang.
>=20

Yes, I've said the same thing myself. But having attempted it, I now think=20
this is a hard problem. YMMV.

https://lore.kernel.org/linux-scsi/alpine.LNX.2.22.394.2004281017310.12(a)nip=
py.intranet/
https://lore.kernel.org/linux-scsi/alpine.LNX.2.22.394.2005211358460.8(a)nipp=
y.intranet/

--===============0997075553461916331==--

