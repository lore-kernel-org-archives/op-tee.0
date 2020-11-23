From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 000/141] Fix fall-through warnings for Clang
Date: Mon, 23 Nov 2020 07:58:06 -0800
Message-ID: 
 <fc45750b6d0277c401015b7aa11e16cd15f32ab2.camel@HansenPartnership.com>
In-Reply-To: <
 <CANiq72m22Jb5_+62NnwX8xds2iUdWDMAqD8PZw9cuxdHd95W0A@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2826765135782445667=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2826765135782445667==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-11-23 at 15:19 +0100, Miguel Ojeda wrote:
> On Sun, Nov 22, 2020 at 11:36 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > Well, it seems to be three years of someone's time plus the
> > maintainer review time and series disruption of nearly a thousand
> > patches.  Let's be conservative and assume the producer worked
> > about 30% on the series and it takes about 5-10 minutes per patch
> > to review, merge and for others to rework existing series.  So
> > let's say it's cost a person year of a relatively junior engineer
> > producing the patches and say 100h of review and application
> > time.  The latter is likely the big ticket item because it's what
> > we have in least supply in the kernel (even though it's 20x vs the
> > producer time).
>=20
> How are you arriving at such numbers? It is a total of ~200 trivial
> lines.

Well, I used git.  It says that as of today in Linus' tree we have 889
patches related to fall throughs and the first series went in in
october 2017 ... ignoring a couple of outliers back to February.

> > It's not about the risk of the changes it's about the cost of
> > implementing them.  Even if you discount the producer time (which
> > someone gets to pay for, and if I were the engineering manager, I'd
> > be unhappy about), the review/merge/rework time is pretty
> > significant in exchange for six minor bug fixes.  Fine, when a new
> > compiler warning comes along it's certainly reasonable to see if we
> > can benefit from it and the fact that the compiler people think
> > it's worthwhile is enough evidence to assume this initially.  But
> > at some point you have to ask whether that assumption is supported
> > by the evidence we've accumulated over the time we've been using
> > it.  And if the evidence doesn't support it perhaps it is time to
> > stop the experiment.
>=20
> Maintainers routinely review 1-line trivial patches, not to mention
> internal API changes, etc.

We're also complaining about the inability to recruit maintainers:

https://www.theregister.com/2020/06/30/hard_to_find_linux_maintainers_says_to=
rvalds/

And burn out:

http://antirez.com/news/129

The whole crux of your argument seems to be maintainers' time isn't
important so we should accept all trivial patches ... I'm pushing back
on that assumption in two places, firstly the valulessness of the time
and secondly that all trivial patches are valuable.

> If some company does not want to pay for that, that's fine, but they
> don't get to be maintainers and claim `Supported`.

What I'm actually trying to articulate is a way of measuring value of
the patch vs cost ... it has nothing really to do with who foots the
actual bill.

One thesis I'm actually starting to formulate is that this continual
devaluing of maintainers is why we have so much difficulty keeping and
recruiting them.

James




--===============2826765135782445667==--

