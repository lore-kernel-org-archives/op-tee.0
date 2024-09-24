From: Daniel Stone <daniel@fooishbar.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [RFC PATCH 0/4] Linaro restricted heap
Date: Tue, 24 Sep 2024 23:02:54 +0100
Message-ID: 
 <CAPj87rM5LSBEdMECyh0WTkjWWySDv2_eyqj7ew_qU7xQ5LEdgA@mail.gmail.com>
In-Reply-To: <20240830070351.2855919-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7006657682924877274=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7006657682924877274==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On Fri, 30 Aug 2024 at 08:04, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
> This patch set is based on top of Yong Wu's restricted heap patch set [1].
> It's also a continuation on Olivier's Add dma-buf secure-heap patch set [2].
>
> The Linaro restricted heap uses genalloc in the kernel to manage the heap
> carvout. This is a difference from the Mediatek restricted heap which
> relies on the secure world to manage the carveout.

Calling this the 'genalloc heap' would be much more clear.

Cheers,
Daniel

--===============7006657682924877274==--

