From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 061/141] tee: Fix fall-through warnings for Clang
Date: Mon, 23 Nov 2020 16:55:07 -0600
Message-ID: <20201123225507.GR21644@embeddedor>
In-Reply-To: <
 <CAHUa44G1B8_CSahTJ1uOUMLcDfpVKHUaoN+u87BywkVwyhjnRw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4905334421082903841=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4905334421082903841==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Sun, Nov 22, 2020 at 10:26:09AM +0100, Jens Wiklander wrote:
> On Fri, Nov 20, 2020 at 7:33 PM Gustavo A. R. Silva
> <gustavoars@kernel.org> wrote:
> >
> > In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> > by explicitly adding a break statement instead of letting the code fall
> > through to the next case.
> >
> > Link: https://github.com/KSPP/linux/issues/115
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >  drivers/tee/tee_core.c | 1 +
> >  1 file changed, 1 insertion(+)
> 
> Acked-by: Jens Wiklander <jens.wiklander@linaro.org>

Thanks, Jens.
--
Gustavo

--===============4905334421082903841==--

