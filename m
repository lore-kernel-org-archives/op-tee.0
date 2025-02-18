From: Daniel Stone <daniel@fooishbar.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v5 0/7] TEE subsystem for restricted dma-buf allocations
Date: Tue, 18 Feb 2025 16:46:41 +0000
Message-ID: 
 <CAPj87rN7QQ2XRa4KnaH9MZrvyRcRWWrihSKousR1j7GD+bEQtg@mail.gmail.com>
In-Reply-To: <20250218143527.1236668-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5563830815155393489=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5563830815155393489==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Feb 2025 at 14:35, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
> This can be tested on a RockPi 4B+ with the following steps:
> repo init -u https://github.com/jenswi-linaro/manifest.git -m rockpi4.xml \
>         -b prototype/sdp-v5
> repo sync -j8
> cd build
> make toolchains -j$(nproc)
> make all -j$(nproc)
> # Copy ../out/rockpi4.img to an SD card and boot the RockPi from that
> # Connect a monitor to the RockPi
> # login and at the prompt:
> gst-launch-1.0 videotestsrc ! \
>         aesenc key=3D1f9423681beb9a79215820f6bda73d0f \
>                 iv=3De9aa8e834d8d70b7e0d254ff670dd718 serialize-iv=3Dtrue !=
 \
>         aesdec key=3D1f9423681beb9a79215820f6bda73d0f ! \
>         kmssink
>
> The aesdec module has been hacked to use an OP-TEE TA to decrypt the stream
> into restricted DMA-bufs which are consumed by the kmssink.

Thanks so very much for putting this together btw. This is the exact
thing we were just starting on, but you beat us to it by a few weeks
it seems. It's awesome to have an implementation of 'real' (if
useless) SVP, so we can actually exercise these codepaths in open
generic code.

Cheers,
Daniel

--===============5563830815155393489==--

