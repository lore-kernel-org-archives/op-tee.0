From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 000/141] Fix fall-through warnings for Clang
Date: Tue, 24 Nov 2020 08:47:54 -0600
Message-ID: <20201124144754.GL16084@embeddedor>
In-Reply-To: <160616392671.21180.16517492185091399884.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8876999482778032169=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8876999482778032169==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2020 at 08:38:46PM +0000, Mark Brown wrote:
> On Fri, 20 Nov 2020 12:21:39 -0600, Gustavo A. R. Silva wrote:
> > This series aims to fix almost all remaining fall-through warnings in
> > order to enable -Wimplicit-fallthrough for Clang.
> >=20
> > In preparation to enable -Wimplicit-fallthrough for Clang, explicitly
> > add multiple break/goto/return/fallthrough statements instead of just
> > letting the code fall through to the next case.
> >=20
> > [...]
>=20
> Applied to
>=20
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git fo=
r-next
>=20
> Thanks!
>=20
> [1/1] regulator: as3722: Fix fall-through warnings for Clang
>       commit: b52b417ccac4fae5b1f2ec4f1d46eb91e4493dc5

Thank you, Mark.
--
Gustavo

--===============8876999482778032169==--

