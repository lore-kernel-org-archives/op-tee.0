From: Finn Thain <fthain@telegraphics.com.au>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 000/141] Fix fall-through warnings for Clang
Date: Mon, 23 Nov 2020 09:54:48 +1100
Message-ID: <alpine.LNX.2.23.453.2011230938390.7@nippy.intranet>
In-Reply-To: <
 <CANiq72nZrHWTA4_Msg6MP9snTyenC6-eGfD27CyfNSu7QoVZbw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8085261435914585556=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8085261435914585556==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit


On Sun, 22 Nov 2020, Miguel Ojeda wrote:

> 
> It isn't that much effort, isn't it? Plus we need to take into account 
> the future mistakes that it might prevent, too.

We should also take into account optimisim about future improvements in 
tooling.

> So even if there were zero problems found so far, it is still a positive 
> change.
> 

It is if you want to spin it that way.

> I would agree if these changes were high risk, though; but they are 
> almost trivial.
> 

This is trivial:

 case 1:
	this();
+	fallthrough;
 case 2:
 	that();

But what we inevitably get is changes like this:

 case 3:
        this();
+       break;
 case 4:
        hmmm();

Why? Mainly to silence the compiler. Also because the patch author argued 
successfully that they had found a theoretical bug, often in mature code.

But is anyone keeping score of the regressions? If unreported bugs count, 
what about unreported regressions?

> Cheers,
> Miguel
> 

--===============8085261435914585556==--

