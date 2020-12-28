From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Mapping an arbitrary SDRAM block outside TZDRAM
Date: Mon, 28 Dec 2020 22:29:24 +0100
Message-ID: 
 <CAHUa44Eru3G4De58gTMNJKSa_2Y_ue5-G4ivnVKYV6k9RQn69Q@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3C01000176aaaea951-36b86cbc-bc43-4441-8a69-d71806e97?=
 =?utf-8?q?be9-000000=40email=2Eamazonses=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0930534390862218642=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0930534390862218642==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Robert,

Comments below.

On Mon, Dec 28, 2020 at 7:49 PM Robert Delien via OP-TEE
<op-tee@lists.trustedfirmware.org> wrote:
>
> Hi,
>
> As discussed earlier, our application requires secured display contents and
> is using a secure frame buffer.
>
> Now to transit from U-Boot to Op-tee as smoothly as possible, I would like
> to copy the contents from the U-Boot frame buffer into the Optee frame
> buffer upon LCD driver initialisation.
>
> The U-Boot frame buffer address is calculated at run time and I haven't
> found a hand-off mechanism, but the physical address can be easily read
> from the LCDIF peripheral's registers. Unfortunately, no MMU mapping is
> present per default for this physical address outside the TZDRAM area.
>
> Is it possible to temporarily map this rather arbitrary non-secure physical
> DDR address outside TZDRAM, so I can access it through a virtual address?
> Preferably in a way that I can also remove this mapping after copying the
> frame buffer?

Yes, it's actually easier than one might first imagine. I assume you
will interact with OP-TEE via a Pseudo TA. This framebuffer is normal
non-secure DDR from OP-TEE point of view, so it should be possible to
just supply it as a memref parameter when invoking the PTA.

Cheers,
Jens

--===============0930534390862218642==--

