From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: fix 'physical' typos
Date: Wed, 03 Feb 2021 13:00:48 +0100
Message-ID: 
 <CAHUa44E+s0KVGhk--vZX-puxADGytfGquBPHqH-PRvwa5bQCRQ@mail.gmail.com>
In-Reply-To: <20210126211507.2920362-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2473686319490799063=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2473686319490799063==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 26, 2021 at 10:15 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Fix misspellings of "physical".
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/tee/optee/optee_smc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I'm picking this up.

Thanks,
Jens

>
> diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
> index 777ad54d4c2c..b52eb34b4237 100644
> --- a/drivers/tee/optee/optee_smc.h
> +++ b/drivers/tee/optee/optee_smc.h
> @@ -139,7 +139,7 @@ struct optee_smc_call_get_os_revision_result {
>   *                                     optee_msg_arg.
>   * OPTEE_SMC_RETURN_ETHREAD_LIMIT      Number of Trusted OS threads exceed=
ed,
>   *                                     try again later.
> - * OPTEE_SMC_RETURN_EBADADDR           Bad physcial pointer to struct
> + * OPTEE_SMC_RETURN_EBADADDR           Bad physical pointer to struct
>   *                                     optee_msg_arg.
>   * OPTEE_SMC_RETURN_EBADCMD            Bad/unknown cmd in struct optee_msg=
_arg
>   * OPTEE_SMC_RETURN_IS_RPC()           Call suspended by RPC call to normal
> --
> 2.25.1
>

--===============2473686319490799063==--

