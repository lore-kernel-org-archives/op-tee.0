From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: fix some comment typos in header files
Date: Wed, 03 Feb 2021 13:02:53 +0100
Message-ID: 
 <CAHUa44FOvPMWUNE+D4tbfNLxijhQYpkcit0LEyC=LNqZm+uU-Q@mail.gmail.com>
In-Reply-To: <20200920045857.34b612bf@akathisia>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5838827798452459719=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5838827798452459719==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Sun, Sep 20, 2020 at 3:58 AM Elvira Khabirova
<e.khabirova@omprussia.ru> wrote:
>
> struct tee_param: revc -> recv.
> TEE_IOC_SUPPL_SEND: typo introduced by copy-pasting, replace invalid
> description with description from the according argument struct.
>
> Signed-off-by: Elvira Khabirova <e.khabirova@omprussia.ru>
> ---
>  include/linux/tee_drv.h  | 2 +-
>  include/uapi/linux/tee.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

I'll pick this up.

Thanks,
Jens

>
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index d074302989dd..61557bc0e29f 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -85,7 +85,7 @@ struct tee_param {
>   * @close_session:     close a session
>   * @invoke_func:       invoke a trusted function
>   * @cancel_req:                request cancel of an ongoing invoke or open
> - * @supp_revc:         called for supplicant to get a command
> + * @supp_recv:         called for supplicant to get a command
>   * @supp_send:         called for supplicant to send a response
>   * @shm_register:      register shared memory buffer in TEE
>   * @shm_unregister:    unregister shared memory buffer in TEE
> diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
> index b619f37ee03e..7546be5ed4f8 100644
> --- a/include/uapi/linux/tee.h
> +++ b/include/uapi/linux/tee.h
> @@ -342,7 +342,7 @@ struct tee_iocl_supp_send_arg {
>  };
>
>  /**
> - * TEE_IOC_SUPPL_SEND - Receive a request for a supplicant function
> + * TEE_IOC_SUPPL_SEND - Send a response to a received request
>   *
>   * Takes a struct tee_ioctl_buf_data which contains a struct
>   * tee_iocl_supp_send_arg followed by any array of struct tee_param
> --
> 2.28.0
>

--===============5838827798452459719==--

