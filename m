From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 000/141] Fix fall-through warnings for Clang
Date: Mon, 23 Nov 2020 12:37:58 -0800
Message-ID: 
 <4993259d01a0064f8bb22770503490f9252f3659.camel@HansenPartnership.com>
In-Reply-To: <
 <CANiq72k5tpDoDPmJ0ZWc1DGqm+81Gi-uEENAtvEs9v3SZcx6_Q@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8020111410092827153=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8020111410092827153==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-11-23 at 19:56 +0100, Miguel Ojeda wrote:
> On Mon, Nov 23, 2020 at 4:58 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > Well, I used git.  It says that as of today in Linus' tree we have
> > 889 patches related to fall throughs and the first series went in
> > in october 2017 ... ignoring a couple of outliers back to February.
>=20
> I can see ~10k insertions over ~1k commits and 15 years that mention
> a fallthrough in the entire repo. That is including some commits
> (like the biggest one, 960 insertions) that have nothing to do with C
> fallthrough. A single kernel release has an order of magnitude more
> changes than this...
>=20
> But if we do the math, for an author, at even 1 minute per line
> change and assuming nothing can be automated at all, it would take 1
> month of work. For maintainers, a couple of trivial lines is noise
> compared to many other patches.

So you think a one line patch should take one minute to produce ... I
really don't think that's grounded in reality.  I suppose a one line
patch only takes a minute to merge with b4 if no-one reviews or tests
it, but that's not really desirable.

> In fact, this discussion probably took more time than the time it
> would take to review the 200 lines. :-)

I'm framing the discussion in terms of the whole series of changes we
have done for fall through, both what's in the tree currently (889
patches) both in terms of the produce and the consumer.  That's what I
used for my figures for cost.

> > We're also complaining about the inability to recruit maintainers:
> >=20
> > https://www.theregister.com/2020/06/30/hard_to_find_linux_maintainers_say=
s_torvalds/
> >=20
> > And burn out:
> >=20
> > http://antirez.com/news/129
>=20
> Accepting trivial and useful 1-line patches

Part of what I'm trying to measure is the "and useful" bit because
that's not a given.

> is not what makes a voluntary maintainer quit...

so the proverb "straw which broke the camel's back" uniquely doesn't
apply to maintainers

>  Thankless work with demanding deadlines is.

That's another potential reason, but it doesn't may other reasons less
valid.

> > The whole crux of your argument seems to be maintainers' time isn't
> > important so we should accept all trivial patches
>=20
> I have not said that, at all. In fact, I am a voluntary one and I
> welcome patches like this. It takes very little effort on my side to
> review and it helps the kernel overall.

Well, you know, subsystems are very different in terms of the amount of
patches a maintainer has to process per release cycle of the kernel.=20
If a maintainer is close to capacity, additional patches, however
trivial, become a problem.  If a maintainer has spare cycles, trivial
patches may look easy.

> Paid maintainers are the ones that can take care of big
> features/reviews.
>=20
> > What I'm actually trying to articulate is a way of measuring value
> > of the patch vs cost ... it has nothing really to do with who foots
> > the actual bill.
>=20
> I understand your point, but you were the one putting it in terms of
> a junior FTE.

No, I evaluated the producer side in terms of an FTE.  What we're
mostly arguing about here is the consumer side: the maintainers and
people who have to rework their patch sets. I estimated that at 100h.

>  In my view, 1 month-work (worst case) is very much worth
> removing a class of errors from a critical codebase.
>=20
> > One thesis I'm actually starting to formulate is that this
> > continual devaluing of maintainers is why we have so much
> > difficulty keeping and recruiting them.
>=20
> That may very well be true, but I don't feel anybody has devalued
> maintainers in this discussion.

You seem to be saying that because you find it easy to merge trivial
patches, everyone should.  I'm reminded of a friend long ago who
thought being a Tees River Pilot was a sinecure because he could
navigate the Tees blindfold.  What he forgot, of course, is that just
because it's easy with a trawler doesn't mean it's easy with an oil
tanker.  In fact it takes longer to qualify as a Tees River Pilot than
it does to get a PhD.

James



--===============8020111410092827153==--

