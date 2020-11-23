From: Mark Brown <broonie@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 000/141] Fix fall-through warnings for Clang
Date: Mon, 23 Nov 2020 20:38:46 +0000
Message-ID: <160616392671.21180.16517492185091399884.b4-ty@kernel.org>
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4889784289313691385=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4889784289313691385==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Nov 2020 12:21:39 -0600, Gustavo A. R. Silva wrote:
> This series aims to fix almost all remaining fall-through warnings in
> order to enable -Wimplicit-fallthrough for Clang.
>=20
> In preparation to enable -Wimplicit-fallthrough for Clang, explicitly
> add multiple break/goto/return/fallthrough statements instead of just
> letting the code fall through to the next case.
>=20
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-=
next

Thanks!

[1/1] regulator: as3722: Fix fall-through warnings for Clang
      commit: b52b417ccac4fae5b1f2ec4f1d46eb91e4493dc5

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

--===============4889784289313691385==--

