From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: remove need_resched() before cond_resched()
Date: Mon, 25 Jan 2021 10:57:52 +0100
Message-ID: 
 <CAHUa44GtqJhvX7jUvKWu08J+A2EWqewzosMsez3mwGZ9gA21Uw@mail.gmail.com>
In-Reply-To: <20210125095445.1524477-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5037773323232648138=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5037773323232648138==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Rouven and Sumit,

On Mon, Jan 25, 2021 at 10:55 AM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> Testing need_resched() before cond_resched() is not needed as an
> equivalent test is done internally in cond_resched(). So drop the
> need_resched() test.
>
> Fixes: dcb3b06d9c34 ("tee: optee: replace might_sleep with cond_resched")
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/optee/call.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Can you please test to see that this works in your setups too?

Thanks,
Jens

--===============5037773323232648138==--

