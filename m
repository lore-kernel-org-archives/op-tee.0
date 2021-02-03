From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: remove need_resched() before cond_resched()
Date: Wed, 03 Feb 2021 08:10:36 +0100
Message-ID: <20210203071036.GA3603358@jade>
In-Reply-To: <
 <CAHUa44GsbxO=wJ_o-AZsxNvKOhn=y=dexkrN17zCy=7+0=1ZQg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3787421863926268563=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3787421863926268563==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 29, 2021 at 02:29:33PM +0100, Jens Wiklander wrote:
> Hi Rouven and Sumit,
>=20
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
>=20
> Does this work for you? I'd like to get this patch ready for v5.12.

Thanks for the help with this patch. I'll submit this up for v5.12.

Cheers,
Jens

--===============3787421863926268563==--

