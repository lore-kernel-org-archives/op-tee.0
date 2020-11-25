From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [Intel-wired-lan] [PATCH 000/141] Fix fall-through warnings for Clang
Date: Tue, 24 Nov 2020 23:05:35 -0800
Message-ID: 
 <a841536fe65bb33f1c72ce2455a6eb47a0107565.camel@HansenPartnership.com>
In-Reply-To: <202011241327.BB28F12F6@keescook>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6343983798853163934=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6343983798853163934==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, 2020-11-24 at 13:32 -0800, Kees Cook wrote:
> On Mon, Nov 23, 2020 at 08:31:30AM -0800, James Bottomley wrote:
> > Really, no ... something which produces no improvement has no value
> > at all ... we really shouldn't be wasting maintainer time with it
> > because it has a cost to merge.  I'm not sure we understand where
> > the balance lies in value vs cost to merge but I am confident in
> > the zero value case.
> 
> What? We can't measure how many future bugs aren't introduced because
> the kernel requires explicit case flow-control statements for all new
> code.

No but we can measure how vulnerable our current coding habits are to
the mistake this warning would potentially prevent.  I don't think it's
wrong to extrapolate that if we had no instances at all of prior coding
problems we likely wouldn't have any in future either making adopting
the changes needed to enable the warning valueless ... that's the zero
value case I was referring to above.

Now, what we have seems to be about 6 cases (at least what's been shown
in this thread) where a missing break would cause potentially user
visible issues.  That means the value of this isn't zero, but it's not
a no-brainer massive win either.  That's why I think asking what we've
invested vs the return isn't a useless exercise.

> We already enable -Wimplicit-fallthrough globally, so that's not the
> discussion. The issue is that Clang is (correctly) even more strict
> than GCC for this, so these are the remaining ones to fix for full
> Clang coverage too.
> 
> People have spent more time debating this already than it would have
> taken to apply the patches. :)

You mean we've already spent 90% of the effort to come this far so we
might as well go the remaining 10% because then at least we get some
return? It's certainly a clinching argument in defence procurement ...

> This is about robustness and language wrangling. It's a big code-
> base, and this is the price of our managing technical debt for
> permanent robustness improvements. (The numbers I ran from Gustavo's
> earlier patches were that about 10% of the places adjusted were
> identified as legitimate bugs being fixed. This final series may be
> lower, but there are still bugs being found from it -- we need to
> finish this and shut the door on it for good.)

I got my six patches by analyzing the lwn.net report of the fixes that
was cited which had 21 of which 50% didn't actually change the emitted
code, and 25% didn't have a user visible effect.

But the broader point I'm making is just because the compiler people
come up with a shiny new warning doesn't necessarily mean the problem
it's detecting is one that causes us actual problems in the code base. 
I'd really be happier if we had a theory about what classes of CVE or
bug we could eliminate before we embrace the next new warning.

James




--===============6343983798853163934==--

