From: Edward Cree <ecree.xilinx@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 000/141] Fix fall-through warnings for Clang
Date: Wed, 25 Nov 2020 22:44:35 +0000
Message-ID: <44005bde-f6d4-5eaa-39b8-1a5efeedb2d3@gmail.com>
In-Reply-To: <
 <CANiq72kqO=bYMJnFS2uYRpgWATJ=uXxZuNUsTXT+3aLtrpnzvQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1981157667343708448=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1981157667343708448==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On 25/11/2020 00:32, Miguel Ojeda wrote:
> I have said *authoring* lines of *this* kind takes a minute per line.
> Specifically: lines fixing the fallthrough warning mechanically and
> repeatedly where the compiler tells you to, and doing so full-time for
> a month.
<snip>
> It is useful since it makes intent clear.
To make the intent clear, you have to first be certain that you
 understand the intent; otherwise by adding either a break or a
 fallthrough to suppress the warning you are just destroying the
 information that "the intent of this code is unknown".
Figuring out the intent of a piece of unfamiliar code takes more
 than 1 minute; just because
    case foo:
        thing;
    case bar:
        break;
 produces identical code to
    case foo:
        thing;
        break;
    case bar:
        break;
 doesn't mean that *either* is correct — maybe the author meant
 to write
    case foo:
        return thing;
    case bar:
        break;
 and by inserting that break you've destroyed the marker that
 would direct someone who knew what the code was about to look
 at that point in the code and spot the problem.
Thus, you *always* have to look at more than just the immediate
 mechanical context of the code, to make a proper judgement that
 yes, this was the intent.  If you think that that sort of thing
 can be done in an *average* time of one minute, then I hope you
 stay away from code I'm responsible for!
One minute would be an optimistic target for code that, as the
 maintainer, one is already somewhat familiar with.  For code
 that you're seeing for the first time, as is usually the case
 with the people doing these mechanical fix-a-warning patches,
 it's completely unrealistic.

A warning is only useful because it makes you *think* about the
 code.  If you suppress the warning without doing that thinking,
 then you made the warning useless; and if the warning made you
 think about code that didn't *need* it, then the warning was
 useless from the start.

So make your mind up: does Clang's stricter -Wimplicit-fallthrough
 flag up code that needs thought (in which case the fixes take
 effort both to author and to review) or does it flag up code
 that can be mindlessly "fixed" (in which case the warning is
 worthless)?  Proponents in this thread seem to be trying to
 have it both ways.

-ed

--===============1981157667343708448==--

