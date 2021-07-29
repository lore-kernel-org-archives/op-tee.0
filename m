From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v3 2/5] optee: simplify optee_release()
Date: Thu, 29 Jul 2021 08:43:59 +0200
Message-ID: <20210729064359.GA3316601@jade>
In-Reply-To: <
 <CAFA6WYOJ6At7p21UuWNp8k4=Qwcb_2VFuV78Z9hksyW76p-fKA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6858504345583007452=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6858504345583007452==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 28, 2021 at 02:15:47PM +0530, Sumit Garg wrote:
> On Thu, 22 Jul 2021 at 17:48, Jens Wiklander <jens.wiklander@linaro.org> =
wrote:
> >
> > Simplifies optee_release() with a new helper function,
> > optee_close_session_helper() which has been factored out from
> > optee_close_session().
> >
>=20
> Simplification looks good to me.
>=20
> > A separate optee_release_supp() is added for the supplicant device.
> >
>=20
> On similar terms, can we have separate optee_open_supp() for better
> understanding?

I'm not so keen on that. It wouldn't be much of a simplification since
we'd end up adding quite a few functions. optee_smc_open_supp(),
optee_ffa_open_supp(), optee_open_common(), and finally
optee_open_supp().

Thanks,
Jens

--===============6858504345583007452==--

