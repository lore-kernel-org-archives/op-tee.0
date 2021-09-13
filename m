From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH linux-next] tee/optee/shm_pool: fix application of sizeof
 to pointer
Date: Mon, 13 Sep 2021 11:21:43 +0200
Message-ID: <20210913092143.GA165502@jade>
In-Reply-To: <20210902103428.bdbkybvi6he6mgy2@maple.lan>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4346912371615786035=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4346912371615786035==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 02, 2021 at 11:34:28AM +0100, Daniel Thompson wrote:
> On Thu, Aug 19, 2021 at 08:21:27PM -0700, CGEL wrote:
> > From: jing yangyang <jing.yangyang@zte.com.cn>
> >=20
> > sizeof when applied to a pointer typed expression gives the size of
> > the pointer.
> >=20
> > ./drivers/tee/optee/shm_pool.c:38:28-34: ERROR application of sizeof to p=
ointer
> >=20
> > This issue was detected with the help of Coccinelle.
> >=20
> > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > Signed-off-by: jing yangyang <jing.yangyang@zte.com.cn>
>=20
> This should not affect code generation since both pages and *pages are
> pointers but the change looks good to me.
>=20
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

Thanks for reviewing, I agree with your analysis.=20
I'm picking this up as a bugfix for V5.15.

Cheers,
Jens

--===============4346912371615786035==--

