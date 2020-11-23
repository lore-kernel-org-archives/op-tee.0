From: Joe Perches <joe@perches.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 000/141] Fix fall-through warnings for Clang
Date: Mon, 23 Nov 2020 08:32:41 -0800
Message-ID: <32dc7423124b51da4e144e931bf099a368ab50a8.camel@perches.com>
In-Reply-To: <
 <fc45750b6d0277c401015b7aa11e16cd15f32ab2.camel@HansenPartnership.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0496001689026304472=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0496001689026304472==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-11-23 at 07:58 -0800, James Bottomley wrote:
> We're also complaining about the inability to recruit maintainers:
>=20
> https://www.theregister.com/2020/06/30/hard_to_find_linux_maintainers_says_=
torvalds/
>=20
> And burn out:
>=20
> http://antirez.com/news/129

https://www.wired.com/story/open-source-coders-few-tired/

> What I'm actually trying to articulate is a way of measuring value of
> the patch vs cost ... it has nothing really to do with who foots the
> actual bill.

It's unclear how to measure value in consistency.

But one way that costs can be reduced is by automation and _not_
involving maintainers when the patch itself is provably correct.

> One thesis I'm actually starting to formulate is that this continual
> devaluing of maintainers is why we have so much difficulty keeping and
> recruiting them.

The linux kernel has something like 1500 different maintainers listed
in the MAINTAINERS file.  That's not a trivial number.

$ git grep '^M:' MAINTAINERS | sort | uniq -c | wc -l
1543
$ git grep '^M:' MAINTAINERS| cut -f1 -d'<' | sort | uniq -c | wc -l
1446

I think the question you are asking is about trust and how it
effects development.

And back to that wired story, the actual number of what you might
be considering to be maintainers is likely less than 10% of the
listed numbers above.



--===============0496001689026304472==--

