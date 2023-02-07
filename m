From: Jérôme Forissier <jerome@forissier.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: State of logging to REE
Date: Tue, 07 Feb 2023 17:33:46 +0100
Message-ID: 
 <CAA-cTWaB6wNv3_bJtXiz_k4jCkqbPziKpRZWSbATr_NZuNPVMQ@mail.gmail.com>
In-Reply-To: <
 <CA+ddPcPYS6szHG_0gA+TH_X1c7tdNgtvcKJ8tFKRmj=8izzVSA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4686076107236066331=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4686076107236066331==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Jeffrey,

On Mon, Feb 6, 2023 at 9:46 PM Jeffrey Kardatzke via OP-TEE <
op-tee@lists.trustedfirmware.org> wrote:

> What's the current state of being able to log to the REE using components
> that already exist in OP-TEE today?  I've seen various issues relating to
> it in GitHub: https://github.com/OP-TEE/optee_os/issues/4230 and
> https://github.com/OP-TEE/optee_os/pull/810, but both ended up being
> closed
> before I can see anything relating to logging to integrated. Did something
> like this end up getting implemented yet?
>

Unfortunately, no. The tee-supplicant plugin mechanism was introduced with
that
use case in mind (see https://github.com/OP-TEE/optee_client/issues/219)
but no
logging-specific code was further upstreamed.

Thanks,
-- 
Jerome

Cheers,
>
> --
> Jeffrey Kardatzke
> jkardatzke(a)google.com
> Google, Inc.
>

--===============4686076107236066331==--

