From: Peter Maydell <peter.maydell@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [op-tee] [PATCH v2 0/2] hw/arm/virt: dt: add kaslr-seed property
Date: Thu, 23 Apr 2020 12:59:18 +0100
Message-ID: 
 <CAFEAcA_q58Yk_7b0DViWse1v7sRMR05FKjSbtFtgHasY7fYWYw@mail.gmail.com>
In-Reply-To: <20200420121807.8204-1-jerome@forissier.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5411555408880208198=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5411555408880208198==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Mon, 20 Apr 2020 at 13:20, Jerome Forissier <jerome@forissier.org> wrote:
>
> This patchset creates the DT property /chosen/kaslr-seed which is used
> by the OS for Address Space Layout Randomization. If the machine is
> secure, a similar property is created under /secure-chosen.
>
> Changes since v1:
>  - Move creation of /secure-chosen to create_fdt()
>  - Use qemu_guest_getrandom() instead of qcrypto_random_bytes()
>  - Create kaslr-seed for the non-secure OS too
>
> Jerome Forissier (2):
>   hw/arm/virt: dt: move creation of /secure-chosen to create_fdt()
>   hw/arm/virt: dt: add kaslr-seed property



Applied to target-arm.next, thanks.

-- PMM

--===============5411555408880208198==--

