From: Sean Young <sean@mess.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 000/141] Fix fall-through warnings for Clang
Date: Wed, 25 Nov 2020 09:01:14 +0000
Message-ID: <20201125090114.GA24274@gofer.mess.org>
In-Reply-To: <
 <fc45750b6d0277c401015b7aa11e16cd15f32ab2.camel@HansenPartnership.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4401341836335520176=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4401341836335520176==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2020 at 07:58:06AM -0800, James Bottomley wrote:
> On Mon, 2020-11-23 at 15:19 +0100, Miguel Ojeda wrote:
> > On Sun, Nov 22, 2020 at 11:36 PM James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > > It's not about the risk of the changes it's about the cost of
> > > implementing them.  Even if you discount the producer time (which
> > > someone gets to pay for, and if I were the engineering manager, I'd
> > > be unhappy about), the review/merge/rework time is pretty
> > > significant in exchange for six minor bug fixes.  Fine, when a new
> > > compiler warning comes along it's certainly reasonable to see if we
> > > can benefit from it and the fact that the compiler people think
> > > it's worthwhile is enough evidence to assume this initially.  But
> > > at some point you have to ask whether that assumption is supported
> > > by the evidence we've accumulated over the time we've been using
> > > it.  And if the evidence doesn't support it perhaps it is time to
> > > stop the experiment.
> >=20
> > Maintainers routinely review 1-line trivial patches, not to mention
> > internal API changes, etc.
>=20
> We're also complaining about the inability to recruit maintainers:
>=20
> https://www.theregister.com/2020/06/30/hard_to_find_linux_maintainers_says_=
torvalds/
>=20
> And burn out:
>=20
> http://antirez.com/news/129
>=20
> The whole crux of your argument seems to be maintainers' time isn't
> important so we should accept all trivial patches ... I'm pushing back
> on that assumption in two places, firstly the valulessness of the time
> and secondly that all trivial patches are valuable.

You're assuming burn out or recruitment problems is due to patch workload
or too many "trivial" patches.

In my experience, "other maintainers" is by far the biggest cause of
burn out for my kernel maintenance work.

Certainly arguing with a maintainer about some obviously-correct patch
series must be a good example of this.


Sean

--===============4401341836335520176==--

