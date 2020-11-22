From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 000/141] Fix fall-through warnings for Clang
Date: Sun, 22 Nov 2020 14:36:00 -0800
Message-ID: 
 <1c7d7fde126bc0acf825766de64bf2f9b888f216.camel@HansenPartnership.com>
In-Reply-To: <
 <CANiq72nZrHWTA4_Msg6MP9snTyenC6-eGfD27CyfNSu7QoVZbw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6274549609356931732=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6274549609356931732==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Sun, 2020-11-22 at 21:35 +0100, Miguel Ojeda wrote:
> On Sun, Nov 22, 2020 at 7:22 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > Well, it's a problem in an error leg, sure, but it's not a really
> > compelling reason for a 141 patch series, is it?  All that fixing
> > this error will do is get the driver to print "oh dear there's a
> > problem" under four more conditions than it previously did.
> > 
> > We've been at this for three years now with nearly a thousand
> > patches, firstly marking all the fall throughs with /* fall through
> > */ and later changing it to fallthrough.  At some point we do have
> > to ask if the effort is commensurate with the protection
> > afforded.  Please tell me our reward for all this effort isn't a
> > single missing error print.
> 
> It isn't that much effort, isn't it?

Well, it seems to be three years of someone's time plus the maintainer
review time and series disruption of nearly a thousand patches.  Let's
be conservative and assume the producer worked about 30% on the series
and it takes about 5-10 minutes per patch to review, merge and for
others to rework existing series.  So let's say it's cost a person year
of a relatively junior engineer producing the patches and say 100h of
review and application time.  The latter is likely the big ticket item
because it's what we have in least supply in the kernel (even though
it's 20x vs the producer time).

>  Plus we need to take into account the future mistakes that it might
> prevent, too. So even if there were zero problems found so far, it is
> still a positive change.

Well, the question I was asking is if it's worth the cost which I've
tried to outline above.

> I would agree if these changes were high risk, though; but they are
> almost trivial.

It's not about the risk of the changes it's about the cost of
implementing them.  Even if you discount the producer time (which
someone gets to pay for, and if I were the engineering manager, I'd be
unhappy about), the review/merge/rework time is pretty significant in
exchange for six minor bug fixes.  Fine, when a new compiler warning
comes along it's certainly reasonable to see if we can benefit from it
and the fact that the compiler people think it's worthwhile is enough
evidence to assume this initially.  But at some point you have to ask
whether that assumption is supported by the evidence we've accumulated
over the time we've been using it.  And if the evidence doesn't support
it perhaps it is time to stop the experiment.

James



--===============6274549609356931732==--

