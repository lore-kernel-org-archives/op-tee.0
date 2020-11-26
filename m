From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 000/141] Fix fall-through warnings for Clang
Date: Thu, 26 Nov 2020 15:53:27 +0100
Message-ID: 
 <CANiq72nobq=ptWK-qWxU91JHqkKhMcRtJNnw2XJd5-vSJWZd8Q@mail.gmail.com>
In-Reply-To: <44005bde-f6d4-5eaa-39b8-1a5efeedb2d3@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3428841108937820891=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3428841108937820891==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, Nov 25, 2020 at 11:44 PM Edward Cree <ecree.xilinx@gmail.com> wrote:
>
> To make the intent clear, you have to first be certain that you
>  understand the intent; otherwise by adding either a break or a
>  fallthrough to suppress the warning you are just destroying the
>  information that "the intent of this code is unknown".

If you don't know what the intent of your own code is, then you
*already* have a problem in your hands.

> Figuring out the intent of a piece of unfamiliar code takes more
>  than 1 minute; just because
>     case foo:
>         thing;
>     case bar:
>         break;
>  produces identical code to
>     case foo:
>         thing;
>         break;
>     case bar:
>         break;
>  doesn't mean that *either* is correct — maybe the author meant

What takes 1 minute is adding it *mechanically* by the author, i.e. so
that you later compare whether codegen is the same.

>  to write
>     case foo:
>         return thing;
>     case bar:
>         break;
>  and by inserting that break you've destroyed the marker that
>  would direct someone who knew what the code was about to look
>  at that point in the code and spot the problem.

Then it means you already have a bug. This patchset gives the
maintainer a chance to notice it, which is a good thing. The "you've
destroyed the market" claim is bogus, because:
  1. you were not looking into it
  2. you didn't notice the bug so far
  3. is implicit -- harder to spot
  4. is only useful if you explicitly take a look at this kind of bug.
So why don't you do it now?

> Thus, you *always* have to look at more than just the immediate
>  mechanical context of the code, to make a proper judgement that
>  yes, this was the intent.

I find that is the responsibility of the maintainers and reviewers for
tree-wide patches like this, assuming they want. They can also keep
the behavior (and the bugs) without spending time. Their choice.

> If you think that that sort of thing
>  can be done in an *average* time of one minute, then I hope you
>  stay away from code I'm responsible for!

Please don't accuse others of recklessness or incompetence, especially
if you didn't understand what they said.

> A warning is only useful because it makes you *think* about the
>  code.  If you suppress the warning without doing that thinking,
>  then you made the warning useless; and if the warning made you
>  think about code that didn't *need* it, then the warning was
>  useless from the start.

We are not suppressing the warning. Quite the opposite, in fact.

> So make your mind up: does Clang's stricter -Wimplicit-fallthrough
>  flag up code that needs thought (in which case the fixes take
>  effort both to author and to review)

As I said several times already, it does take time to review if the
maintainer wants to take the chance to see if they had a bug to begin
with, but it does not require thought for the author if they just go
for equivalent codegen.

> or does it flag up code
>  that can be mindlessly "fixed" (in which case the warning is
>  worthless)?  Proponents in this thread seem to be trying to
>  have it both ways.

A warning is not worthless just because you can mindlessly fix it.
There are many counterexamples, e.g. many
checkpatch/lint/lang-format/indentation warnings, functional ones like
the `if (a = b)` warning...

Cheers,
Miguel

--===============3428841108937820891==--

