From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 061/141] tee: Fix fall-through warnings for Clang
Date: Sun, 22 Nov 2020 10:26:09 +0100
Message-ID: 
 <CAHUa44G1B8_CSahTJ1uOUMLcDfpVKHUaoN+u87BywkVwyhjnRw@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3Cc505109fe0c02f648e16caa83d8a9773afd696b1=2E1605896?=
 =?utf-8?q?059=2Egit=2Egustavoars=40kernel=2Eorg=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3473572226851370788=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3473572226851370788==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, Nov 20, 2020 at 7:33 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a break statement instead of letting the code fall
> through to the next case.
>
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/tee/tee_core.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Jens Wiklander <jens.wiklander@linaro.org>

Thanks,
Jens

--===============3473572226851370788==--

