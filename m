From: Nick Desaulniers <ndesaulniers@google.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [Intel-wired-lan] [PATCH 000/141] Fix fall-through warnings for Clang
Date: Wed, 25 Nov 2020 14:09:08 -0800
Message-ID: 
 <CAKwvOdkWGE5qdFZUuMzcL63LDOu_iZQJOGbeBNjcPi8sJPMkag@mail.gmail.com>
In-Reply-To: <
 <20201125082405.1d8c23dc@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7931690217678303971=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7931690217678303971==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, Nov 25, 2020 at 8:24 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> Applying a real patch set and then getting a few follow ups the next day
> for trivial coding things like fallthrough missing or static missing,
> just because I didn't have the full range of compilers to check with
> before applying makes me feel pretty shitty, like I'm not doing a good
> job. YMMV.

I understand. Everyone feels that way, except maybe Bond villains and
robots.  My advice in that case is don't take it personally.  We're
working with a language that's more error prone relative to others.
While one would like to believe they are flawless, over time they
can't beat the aggregate statistics.  A balance between Imposter
Syndrome and Dunning Kruger is walked by all software developers, and
the fear of making mistakes in public is one of the number one reasons
folks don't take the plunge contributing to open source software or
even the kernel.  My advice to them is "don't sweat the small stuff."
-- 
Thanks,
~Nick Desaulniers

--===============7931690217678303971==--

