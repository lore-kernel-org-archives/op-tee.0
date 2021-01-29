From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: remove need_resched() before cond_resched()
Date: Fri, 29 Jan 2021 14:29:33 +0100
Message-ID: 
 <CAHUa44GsbxO=wJ_o-AZsxNvKOhn=y=dexkrN17zCy=7+0=1ZQg@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3C0100017738faac80-87e5cf40-6a5a-4727-9c36-382fb909c?=
 =?utf-8?q?8ff-000000=40email=2Eamazonses=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2300399104818725949=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2300399104818725949==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Rouven and Sumit,

On Mon, Jan 25, 2021 at 10:58 AM Jens Wiklander via OP-TEE
<op-tee@lists.trustedfirmware.org> wrote:
>
> Hi Rouven and Sumit,
>
> On Mon, Jan 25, 2021 at 10:55 AM Jens Wiklander
> <jens.wiklander@linaro.org> wrote:
> >
> > Testing need_resched() before cond_resched() is not needed as an
> > equivalent test is done internally in cond_resched(). So drop the
> > need_resched() test.
> >
> > Fixes: dcb3b06d9c34 ("tee: optee: replace might_sleep with cond_resched")
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/tee/optee/call.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
>
> Can you please test to see that this works in your setups too?

Does this work for you? I'd like to get this patch ready for v5.12.

Thanks,
Jens

--===============2300399104818725949==--

