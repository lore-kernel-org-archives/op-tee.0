From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: remove need_resched() before cond_resched()
Date: Mon, 01 Feb 2021 10:32:26 +0530
Message-ID: 
 <CAFA6WYMez3c_fT2v2wDuKo5vFvL6MdBXnniYsNvqgFR6LA3+2A@mail.gmail.com>
In-Reply-To: <
 <CAHUa44GsbxO=wJ_o-AZsxNvKOhn=y=dexkrN17zCy=7+0=1ZQg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1932935789504440212=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1932935789504440212==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On Fri, 29 Jan 2021 at 18:59, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> Hi Rouven and Sumit,
>
> On Mon, Jan 25, 2021 at 10:58 AM Jens Wiklander via OP-TEE
> <op-tee@lists.trustedfirmware.org> wrote:
> >
> > Hi Rouven and Sumit,
> >
> > On Mon, Jan 25, 2021 at 10:55 AM Jens Wiklander
> > <jens.wiklander@linaro.org> wrote:
> > >
> > > Testing need_resched() before cond_resched() is not needed as an
> > > equivalent test is done internally in cond_resched(). So drop the
> > > need_resched() test.
> > >
> > > Fixes: dcb3b06d9c34 ("tee: optee: replace might_sleep with cond_resched=
")
> > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > ---
> > >  drivers/tee/optee/call.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > Can you please test to see that this works in your setups too?
>
> Does this work for you? I'd like to get this patch ready for v5.12.

It does work for me as well.

Tested-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

>
> Thanks,
> Jens

--===============1932935789504440212==--

