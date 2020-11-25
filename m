From: Nick Desaulniers <ndesaulniers@google.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [Intel-wired-lan] [PATCH 000/141] Fix fall-through warnings for Clang
Date: Wed, 25 Nov 2020 04:24:27 -0800
Message-ID: 
 <CAKwvOdkGBn7nuWTAqrORMeN1G+w3YwBfCqqaRD2nwvoAXKi=Aw@mail.gmail.com>
In-Reply-To: <
 <a841536fe65bb33f1c72ce2455a6eb47a0107565.camel@HansenPartnership.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4906248658141555974=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4906248658141555974==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2020 at 11:05 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Tue, 2020-11-24 at 13:32 -0800, Kees Cook wrote:
> > We already enable -Wimplicit-fallthrough globally, so that's not the
> > discussion. The issue is that Clang is (correctly) even more strict
> > than GCC for this, so these are the remaining ones to fix for full
> > Clang coverage too.
> >
> > People have spent more time debating this already than it would have
> > taken to apply the patches. :)
>
> You mean we've already spent 90% of the effort to come this far so we
> might as well go the remaining 10% because then at least we get some
> return? It's certainly a clinching argument in defence procurement ...

So developers and distributions using Clang can't have
-Wimplicit-fallthrough enabled because GCC is less strict (which has
been shown in this thread to lead to bugs)?  We'd like to have nice
things too, you know.

I even agree that most of the churn comes from

case 0:
  ++x;
default:
  break;

which I have a patch for: https://reviews.llvm.org/D91895.  I agree
that can never lead to bugs.  But that's not the sole case of this
series, just most of them.

Though, note how the reviewer (C++ spec editor and clang front end
owner) in https://reviews.llvm.org/D91895 even asks in that review how
maybe a new flag would be more appropriate for a watered
down/stylistic variant of the existing behavior.  And if the current
wording of Documentation/process/deprecated.rst around "fallthrough"
is a straightforward rule of thumb, I kind of agree with him.

>
> > This is about robustness and language wrangling. It's a big code-
> > base, and this is the price of our managing technical debt for
> > permanent robustness improvements. (The numbers I ran from Gustavo's
> > earlier patches were that about 10% of the places adjusted were
> > identified as legitimate bugs being fixed. This final series may be
> > lower, but there are still bugs being found from it -- we need to
> > finish this and shut the door on it for good.)
>
> I got my six patches by analyzing the lwn.net report of the fixes that
> was cited which had 21 of which 50% didn't actually change the emitted
> code, and 25% didn't have a user visible effect.
>
> But the broader point I'm making is just because the compiler people
> come up with a shiny new warning doesn't necessarily mean the problem

That's not what this is though; you're attacking a strawman.  I'd
encourage you to bring that up when that actually occurs, unlike this
case since it's actively hindering getting -Wimplicit-fallthrough
enabled for Clang.  This is not a shiny new warning; it's already on
for GCC and has existed in both compilers for multiple releases.

And I'll also note that warnings are warnings and not errors because
they cannot be proven to be bugs in 100% of cases, but they have led
to bugs in the past.  They require a human to review their intent and
remove ambiguities.  If 97% of cases would end in a break ("Expert C
Programming: Deep C Secrets" - Peter van der Linden), then it starts
to look to me like a language defect; certainly an incorrectly chosen
default.  But the compiler can't know those 3% were intentional,
unless you're explicit for those exceptional cases.

> it's detecting is one that causes us actual problems in the code base.
> I'd really be happier if we had a theory about what classes of CVE or
> bug we could eliminate before we embrace the next new warning.

We don't generally file CVEs and waiting for them to occur might be
too reactive, but I agree that pointing to some additional
documentation in commit messages about how a warning could lead to a
bug would make it clearer to reviewers why being able to enable it
treewide, even if there's no bug in their particular subsystem, is in
the general interest of the commons.

On Mon, Nov 23, 2020 at 7:58 AM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> We're also complaining about the inability to recruit maintainers:
>
> https://www.theregister.com/2020/06/30/hard_to_find_linux_maintainers_says_=
torvalds/
>
> And burn out:
>
> http://antirez.com/news/129
>
> The whole crux of your argument seems to be maintainers' time isn't
> important so we should accept all trivial patches ... I'm pushing back
> on that assumption in two places, firstly the valulessness of the time
> and secondly that all trivial patches are valuable.

It's critical to the longevity of any open source project that there
are not single points of failure.  If someone is not expendable or
replaceable (or claims to be) then that's a risk to the project and a
bottleneck.  Not having a replacement in training or some form of
redundancy is short sighted.

If trivial patches are adding too much to your workload, consider
training a co-maintainer or asking for help from one of your reviewers
whom you trust.  I don't doubt it's hard to find maintainers, but
existing maintainers should go out of their way to entrust
co-maintainers especially when they find their workload becomes too
high.  And reviewing/picking up trivial patches is probably a great
way to get started.  If we allow too much knowledge of any one
subsystem to collect with one maintainer, what happens when that
maintainer leaves the community (which, given a finite lifespan, is an
inevitability)?
--=20
Thanks,
~Nick Desaulniers

--===============4906248658141555974==--

