From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 000/141] Fix fall-through warnings for Clang
Date: Wed, 25 Nov 2020 12:38:17 +0200
Message-ID: 
 <CAHp75VfaewwkLsrht95Q7DaxFk7JpQjwx0KQ7Jvh5f7DUbZkRA@mail.gmail.com>
In-Reply-To: <
 <4993259d01a0064f8bb22770503490f9252f3659.camel@HansenPartnership.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2730229439137813076=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2730229439137813076==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Mon, Nov 23, 2020 at 10:39 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> On Mon, 2020-11-23 at 19:56 +0100, Miguel Ojeda wrote:
> > On Mon, Nov 23, 2020 at 4:58 PM James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:

...

> > But if we do the math, for an author, at even 1 minute per line
> > change and assuming nothing can be automated at all, it would take 1
> > month of work. For maintainers, a couple of trivial lines is noise
> > compared to many other patches.
>
> So you think a one line patch should take one minute to produce ... I
> really don't think that's grounded in reality.  I suppose a one line
> patch only takes a minute to merge with b4 if no-one reviews or tests
> it, but that's not really desirable.

In my practice most of the one line patches were either to fix or to
introduce quite interesting issues.
1 minute is 2-3 orders less than usually needed for such patches.
That's why I don't like churn produced by people who often even didn't
compile their useful contributions.

-- 
With Best Regards,
Andy Shevchenko

--===============2730229439137813076==--

