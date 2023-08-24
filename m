From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [RFC, PATCH 1/1] rpmb: add Replay Protected Memory Block (RPMB) driver
Date: Thu, 24 Aug 2023 19:37:32 +0530
Message-ID: 
 <CAFA6WYNzLj3ZGj0MP_8n-9ZsMrHs+nFyd11XTARTUXHv4gFs3Q@mail.gmail.com>
In-Reply-To: <
 <CACRpkdb=AnJXG2J_DRsN-RUEh=7_eAs8+_CxPYuueVM0c=DP3Q@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0046369647150576860=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0046369647150576860==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 23 Aug 2023 at 13:34, Linus Walleij <linus.walleij@linaro.org> wrot=
e:
>
> On Tue, Aug 22, 2023 at 9:07=E2=80=AFPM Shyam Saini
> <shyamsaini@linux.microsoft.com> wrote:
>
> > do we plan to disable access to RPMB devices, once we have this RPMB
> > driver in place. User space tools like mmc-utils/nvme/ufs utils
> > can still access RPMB and programme the key and should
> > RPMB driver deny access to RPMB ?
>
> We don't break userspace. Just not. This is not an option.
>
> The RPMB subsystem simply has to provide the rpmb character
> device the same way the MMC subsystem did, or provide an
> in-kernel backend to the MMC subsystem so that it can provide
> the same device. Whatever solution is best.
>
> No deprecation and deletion and breaking userspace. Ever.
>

Agree, that's the golden rule of thumb we follow in kernel
development. Also, we still need to allow cases where trusted
provisioning user-space tools can program OP-TEE RPMB key during
factory provisioning. And once that is provisioned, I don't think
there is much harm in still exposing the RPMB device to user-space
since it can't do anything malicious without access to OP-TEE RPMB
key.

-Sumit

> Yours,
> Linus Walleij

--===============0046369647150576860==--

