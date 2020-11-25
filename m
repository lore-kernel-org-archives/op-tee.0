From: Jakub Kicinski <kuba@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [Intel-wired-lan] [PATCH 000/141] Fix fall-through warnings for Clang
Date: Wed, 25 Nov 2020 08:24:05 -0800
Message-ID: 
 <20201125082405.1d8c23dc@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <
 <CAKwvOdkGBn7nuWTAqrORMeN1G+w3YwBfCqqaRD2nwvoAXKi=Aw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7186179018592006640=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7186179018592006640==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, 25 Nov 2020 04:24:27 -0800 Nick Desaulniers wrote:
> I even agree that most of the churn comes from
> 
> case 0:
>   ++x;
> default:
>   break;

And just to spell it out,

case ENUM_VALUE1:
	bla();
	break;
case ENUM_VALUE2:
	bla();
default:
	break;

is a fairly idiomatic way of indicating that not all values of the enum
are expected to be handled by the switch statement. 

I really hope the Clang folks are reasonable and merge your patch.

> If trivial patches are adding too much to your workload, consider
> training a co-maintainer or asking for help from one of your reviewers
> whom you trust.  I don't doubt it's hard to find maintainers, but
> existing maintainers should go out of their way to entrust
> co-maintainers especially when they find their workload becomes too
> high.  And reviewing/picking up trivial patches is probably a great
> way to get started.  If we allow too much knowledge of any one
> subsystem to collect with one maintainer, what happens when that
> maintainer leaves the community (which, given a finite lifespan, is an
> inevitability)?

The burn out point is about enjoying your work and feeling that it
matters. It really doesn't make much difference if you're doing
something you don't like for 12 hours every day or only in shifts with
another maintainer. You'll dislike it either way.

Applying a real patch set and then getting a few follow ups the next day
for trivial coding things like fallthrough missing or static missing,
just because I didn't have the full range of compilers to check with
before applying makes me feel pretty shitty, like I'm not doing a good
job. YMMV.

--===============7186179018592006640==--

