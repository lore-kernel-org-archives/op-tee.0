From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [GIT PULL] OP-TEE driver for v5.11
Date: Fri, 27 Nov 2020 08:14:59 +0100
Message-ID: 
 <CAHUa44Fnj4zQ_3O+kdzVopVAggUOdb34KGnA8+r=Rp-4+etWbw@mail.gmail.com>
In-Reply-To: <
 <CAK8P3a2CDp0KwCZjffA78fXUqOfAkvUb8Q=R64830fvvn_WG2w@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0147191210715232764=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0147191210715232764==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Arnd,

On Thu, Nov 26, 2020 at 10:00 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Wed, Nov 25, 2020 at 1:01 PM Jens Wiklander
> <jens.wiklander@linaro.org> wrote:
> >
> > Hello arm-soc maintainers,
> >
> > Please pull this small patch which allows the OP-TEE driver to work with
> > ARMv7 based single CPU systems.
>
> Can you rebase that branch onto -rc1? I had started the arm/drivers
> branch early on top of that, so I'd prefer to avoid a backmerged.
>
> For the commit itself, shouldn't that be marked as a bugfix and get
> merged into v5.10 instead? If it should, you don't have to rebase
> since the arm/fixes branch is already ahead.

Yes it is a bit of a bugfix, so if you don't mind taking it as that
I'm sure that Rui would be happy to get it in this release.

>
> Also, it would be nice to Cc linux-arm-kernel on the pull request
> in addition to linux-kernel.

I'll keep that in mind the next time. Thanks for the feedback.

Cheers,
Jens

--===============0147191210715232764==--

