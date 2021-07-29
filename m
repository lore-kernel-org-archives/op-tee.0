From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v3 2/5] optee: simplify optee_release()
Date: Thu, 29 Jul 2021 12:40:32 +0530
Message-ID: 
 <CAFA6WYNdkYGYiAMgkLRzc1-Ag=1Gd3kCSCwx=wT1RAxfYZtmgw@mail.gmail.com>
In-Reply-To: <20210729064359.GA3316601@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1711713857523278378=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1711713857523278378==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Jul 2021 at 12:14, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> On Wed, Jul 28, 2021 at 02:15:47PM +0530, Sumit Garg wrote:
> > On Thu, 22 Jul 2021 at 17:48, Jens Wiklander <jens.wiklander@linaro.org=
> wrote:
> > >
> > > Simplifies optee_release() with a new helper function,
> > > optee_close_session_helper() which has been factored out from
> > > optee_close_session().
> > >
> >
> > Simplification looks good to me.
> >
> > > A separate optee_release_supp() is added for the supplicant device.
> > >
> >
> > On similar terms, can we have separate optee_open_supp() for better
> > understanding?
>
> I'm not so keen on that. It wouldn't be much of a simplification since
> we'd end up adding quite a few functions. optee_smc_open_supp(),
> optee_ffa_open_supp(), optee_open_common(), and finally
> optee_open_supp().
>

Fair enough, FWIW:

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> Thanks,
> Jens

--===============1711713857523278378==--

