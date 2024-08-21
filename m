From: Ulf Hansson <ulf.hansson@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v9 0/4] Replay Protected Memory Block (RPMB) subsystem
Date: Wed, 21 Aug 2024 23:23:03 +0200
Message-ID: 
 <CAPDyKFqBuQ8uUdeThRaJtd2CYNWMmpLCEDxfO+znhwjPamH+Gg@mail.gmail.com>
In-Reply-To: <20240814153558.708365-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4083338453243164914=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4083338453243164914==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Aug 2024 at 17:36, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> Hi,
>
> This patch set is getting ready to be queued for the next merge window. The
> issues reported by Mikka in the v7 patch set has been resolved, the issues
> turned out to be outside of the v7 patch set relating to configuration in
> the secure world. I'm planning a pull request to arm-soc, but before that
> I'd rather have acks or at least an OK for:
> - "rpmb: add Replay Protected Memory Block (RPMB) subsystem" by Greg
> - "mmc: block: register RPMB partition with the RPMB subsystem" by Ulf
>
> Arnd, please let me know if anything else is missing.

Greg, Jens,

To help out with the merging strategy, I don't mind queuing this whole
series via my mmc tree. It would also be nice to let it cook in
linux-next for while, via my next branch.

 From my point of view this looks good to me now, but please let me
know if you prefer a different route or if you have any further
comments.

[...]

Kind regards
Uffe

--===============4083338453243164914==--

