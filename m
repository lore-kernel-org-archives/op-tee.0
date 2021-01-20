From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] drivers: optee: use flexible-array member instead of
 zero-length array
Date: Wed, 20 Jan 2021 10:20:27 +0100
Message-ID: 
 <CAHUa44EAYhhN1ESFPLNdx0cRUHqjjkK+HwHek22w4OX6YoXdJg@mail.gmail.com>
In-Reply-To: <1609415906-35024-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0068245529583522568=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0068245529583522568==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Tian,

On Thu, Dec 31, 2020 at 12:58 PM Tian Tao <tiantao6@hisilicon.com> wrote:
>
> Use flexible-array member introduced in C99 instead of zero-length
> array. Most of zero-length array was already taken care in previous
> patch [1]. Now modified few more cases which were not handled earlier.
>
> [1]. https://patchwork.kernel.org/patch/11394197/
>
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  drivers/tee/optee/optee_msg.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, I'll pick this up and queue with a few other related changes
I'm planning to post soon.

Cheers,
Jens

>
> diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg.h
> index 7b2d919..b1f1e90 100644
> --- a/drivers/tee/optee/optee_msg.h
> +++ b/drivers/tee/optee/optee_msg.h
> @@ -199,7 +199,7 @@ struct optee_msg_arg {
>         u32 num_params;
>
>         /* num_params tells the actual number of element in params */
> -       struct optee_msg_param params[0];
> +       struct optee_msg_param params[];
>  };
>
>  /**
> --
> 2.7.4
>

--===============0068245529583522568==--

