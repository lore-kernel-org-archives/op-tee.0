From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [Intel-wired-lan] [PATCH 000/141] Fix fall-through warnings for Clang
Date: Wed, 25 Nov 2020 18:04:15 +0100
Message-ID: 
 <CANiq72=RuekXf1O6Fxrz2Eend0GtS6=E72P4T2=48SDqVcTChA@mail.gmail.com>
In-Reply-To: <
 <20201125082405.1d8c23dc@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7344783779097289109=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7344783779097289109==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, Nov 25, 2020 at 5:24 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> And just to spell it out,
>
> case ENUM_VALUE1:
>         bla();
>         break;
> case ENUM_VALUE2:
>         bla();
> default:
>         break;
>
> is a fairly idiomatic way of indicating that not all values of the enum
> are expected to be handled by the switch statement.

It looks like a benign typo to me -- `ENUM_VALUE2` does not follow the
same pattern like `ENUM_VALUE1`. To me, the presence of the `default`
is what indicates (explicitly) that not everything is handled.

> Applying a real patch set and then getting a few follow ups the next day
> for trivial coding things like fallthrough missing or static missing,
> just because I didn't have the full range of compilers to check with
> before applying makes me feel pretty shitty, like I'm not doing a good
> job. YMMV.

The number of compilers, checkers, static analyzers, tests, etc. we
use keeps going up. That, indeed, means maintainers will miss more
things (unless maintainers do more work than before). But catching
bugs before they happen is *not* a bad thing.

Perhaps we could encourage more rebasing in -next (while still giving
credit to bots and testers) to avoid having many fixing commits
afterwards, but that is orthogonal.

I really don't think we should encourage the feeling that a maintainer
is doing a bad job if they don't catch everything on their reviews.
Any review is worth it. Maintainers, in the end, are just the
"guaranteed" reviewers that decide when the code looks reasonable
enough. They should definitely not feel pressured to be perfect.

Cheers,
Miguel

--===============7344783779097289109==--

