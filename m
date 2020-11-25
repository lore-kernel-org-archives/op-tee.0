From: Kees Cook <keescook@chromium.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [Intel-wired-lan] [PATCH 000/141] Fix fall-through warnings for Clang
Date: Wed, 25 Nov 2020 13:10:00 -0800
Message-ID: <202011251240.1E67BE900@keescook>
In-Reply-To: <
 <a841536fe65bb33f1c72ce2455a6eb47a0107565.camel@HansenPartnership.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1638786142693517905=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1638786142693517905==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2020 at 11:05:35PM -0800, James Bottomley wrote:
> Now, what we have seems to be about 6 cases (at least what's been shown
> in this thread) where a missing break would cause potentially user
> visible issues.  That means the value of this isn't zero, but it's not
> a no-brainer massive win either.  That's why I think asking what we've
> invested vs the return isn't a useless exercise.

The number is much higher[1]. If it were 6 in the entire history of the
kernel, I would agree with you. :) Some were fixed _before_ Gustavo's
effort too, which I also count towards the idea of "this is a dangerous
weakness in C, and now we have stopped it forever."

> But the broader point I'm making is just because the compiler people
> come up with a shiny new warning doesn't necessarily mean the problem
> it's detecting is one that causes us actual problems in the code base.=20
> I'd really be happier if we had a theory about what classes of CVE or
> bug we could eliminate before we embrace the next new warning.

But we did! It was long ago justified and documented[2], and even links to
the CWE[3] for it. This wasn't random joy over discovering a new warning
we could turn on, this was turning on a warning that the compiler folks
finally gave us to handle an entire class of flaws. If we need to update
the code-base to address it not a useful debate -- that was settled
already, even if you're only discovering it now. :P. This last patch
set is about finishing that work for Clang, which is correctly even
more strict than GCC.

-Kees

[1] https://outflux.net/slides/2019/lss/kspp.pdf calls out specific
    numbers (about 6.5% of the patches fixed missing breaks):
	v4.19:  3 of 129
	v4.20:  2 of  59
	v5.0:   3 of  56
	v5.1:  10 of 100
	v5.2:   6 of  71
	v5.3:   7 of  69

    And in the history of the kernel, it's been an ongoing source of
    flaws:

    $ l --no-merges | grep -i 'missing break' | wc -l
    185

    The frequency of such errors being "naturally" found was pretty
    steady until the static checkers started warning, and then it was
    on the rise, but the full effort flushed the rest out, and now it's
    dropped to almost zero:

      1 v2.6.12
      3 v2.6.16.28
      1 v2.6.17
      1 v2.6.19
      2 v2.6.21
      1 v2.6.22
      3 v2.6.24
      3 v2.6.29
      1 v2.6.32
      1 v2.6.33
      1 v2.6.35
      4 v2.6.36
      3 v2.6.38
      2 v2.6.39
      7 v3.0
      2 v3.1
      2 v3.2
      2 v3.3
      3 v3.4
      1 v3.5
      8 v3.6
      7 v3.7
      3 v3.8
      6 v3.9
      3 v3.10
      2 v3.11
      5 v3.12
      5 v3.13
      2 v3.14
      4 v3.15
      2 v3.16
      3 v3.17
      2 v3.18
      2 v3.19
      1 v4.0
      2 v4.1
      5 v4.2
      4 v4.5
      5 v4.7
      6 v4.8
      1 v4.9
      3 v4.10
      2 v4.11
      6 v4.12
      3 v4.13
      2 v4.14
      5 v4.15
      2 v4.16
      7 v4.18
      2 v4.19
      6 v4.20
      3 v5.0
     12 v5.1
      3 v5.2
      4 v5.3
      2 v5.4
      1 v5.8


    And the reason it's fully zero, is because we still have the cases we're
    cleaning up right now. Even this last one from v5.8 is specifically of
    the same type this series addresses:

        case 4:
                color_index =3D TrueCModeIndex;
+               break;
        default:
                return;
        }


[2] https://www.kernel.org/doc/html/latest/process/deprecated.html#implicit-s=
witch-case-fall-through

	All switch/case blocks must end in one of:

	break;
	fallthrough;
	continue;
	goto <label>;
	return [expression];

[3] https://cwe.mitre.org/data/definitions/484.html

--=20
Kees Cook

--===============1638786142693517905==--

