From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v2] tee: optee: ffa: Fix missing-field-initializers warning
Date: Thu, 27 Jun 2024 14:52:03 +0200
Message-ID: 
 <CAHUa44GuctLUKPgGxLd3BU7GA1wTf2ir_BwJuWHbcQD_TOU5=w@mail.gmail.com>
In-Reply-To: <20240627065911.4157-1-mark-pk.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4741214869507575839=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4741214869507575839==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 8:59=E2=80=AFAM Mark-PK Tsai <mark-pk.tsai@mediatek=
.com> wrote:
>
> The 'missing-field-initializers' warning was reported
> when building with W=3D2.
> This patch use designated initializers for
> 'struct ffa_send_direct_data' to suppress the warning
> and clarify the initialization intent.
>
> Signed-off-by: ming-jen.chang <ming-jen.chang@mediatek.com>
> Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> ---
>  drivers/tee/optee/ffa_abi.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

I'm picking up this.

Thanks,
Jens

--===============4741214869507575839==--

