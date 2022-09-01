From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 2/9] tee: optee: Use ffa_dev->ops directly
Date: Thu, 01 Sep 2022 09:21:32 +0200
Message-ID: 
 <CAHUa44Fxg4p1t4O+P094m2vvjOVaJ-phPVZTLVKbdL0pOQNGkA@mail.gmail.com>
In-Reply-To: <20220830100700.344594-3-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7741731519996204420=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7741731519996204420==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, Aug 30, 2022 at 12:07 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Now that the ffa_device structure holds the pointer to ffa_dev_ops,
> there is no need to obtain the same through ffa_dev_ops_get().
>
> Just use the ffa_dev->ops directly.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/tee/optee/ffa_abi.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>

--===============7741731519996204420==--

