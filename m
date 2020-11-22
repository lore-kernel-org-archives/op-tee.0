From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 000/141] Fix fall-through warnings for Clang
Date: Sun, 22 Nov 2020 21:35:58 +0100
Message-ID: 
 <CANiq72nZrHWTA4_Msg6MP9snTyenC6-eGfD27CyfNSu7QoVZbw@mail.gmail.com>
In-Reply-To: <
 <9b57fd4914b46f38d54087d75e072d6e947cb56d.camel@HansenPartnership.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4953150152367307656=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4953150152367307656==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Sun, Nov 22, 2020 at 7:22 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> Well, it's a problem in an error leg, sure, but it's not a really
> compelling reason for a 141 patch series, is it?  All that fixing this
> error will do is get the driver to print "oh dear there's a problem"
> under four more conditions than it previously did.
>
> We've been at this for three years now with nearly a thousand patches,
> firstly marking all the fall throughs with /* fall through */ and later
> changing it to fallthrough.  At some point we do have to ask if the
> effort is commensurate with the protection afforded.  Please tell me
> our reward for all this effort isn't a single missing error print.

It isn't that much effort, isn't it? Plus we need to take into account
the future mistakes that it might prevent, too. So even if there were
zero problems found so far, it is still a positive change.

I would agree if these changes were high risk, though; but they are
almost trivial.

Cheers,
Miguel

--===============4953150152367307656==--

