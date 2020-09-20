From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: fix some comment typos in header files
Date: Sat, 19 Sep 2020 22:01:28 -0500
Message-ID: <5dc9f507-df6b-b711-5312-648150451299@embeddedor.com>
In-Reply-To: <20200920045857.34b612bf@akathisia>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6570616364399571915=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6570616364399571915==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi,

Here is another one you can solve:

$ git grep -nw overlfow
net/sctp/tsnmap.c:78:    * overlfow our map

Thanks
--
Gustavo

On 9/19/20 20:58, Elvira Khabirova wrote:
> struct tee_param: revc -> recv.
> TEE_IOC_SUPPL_SEND: typo introduced by copy-pasting, replace invalid
> description with description from the according argument struct.
> 
> Signed-off-by: Elvira Khabirova <e.khabirova@omprussia.ru>
> ---
>  include/linux/tee_drv.h  | 2 +-
>  include/uapi/linux/tee.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index d074302989dd..61557bc0e29f 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -85,7 +85,7 @@ struct tee_param {
>   * @close_session:	close a session
>   * @invoke_func:	invoke a trusted function
>   * @cancel_req:		request cancel of an ongoing invoke or open
> - * @supp_revc:		called for supplicant to get a command
> + * @supp_recv:		called for supplicant to get a command
>   * @supp_send:		called for supplicant to send a response
>   * @shm_register:	register shared memory buffer in TEE
>   * @shm_unregister:	unregister shared memory buffer in TEE
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
> 

--===============6570616364399571915==--

